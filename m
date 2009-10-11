From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: combine git repo historically
Date: Sun, 11 Oct 2009 01:48:17 -0700 (PDT)
Message-ID: <m31vlagvtw.fsf@localhost.localdomain>
References: <20091009012254.GA3980@debian.b2j>
	<4ACED204.3000907@viscovery.net> <20091010140358.GA3924@debian.b2j>
	<200910110436.52653.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bill lam <cbill.lam@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Oct 11 10:50:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwu8X-00065i-TF
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 10:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbZJKIs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 04:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbZJKIs4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 04:48:56 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:55936 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbZJKIsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 04:48:55 -0400
Received: by bwz6 with SMTP id 6so2520017bwz.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=vRQExMIOqX2ggy9ucXpwIRfW3V4TEtASJNV8A+k207U=;
        b=BI3HgL+eipLdKB9jDrdVQr/1cdOqWCyw0s8Tg7HZXeVx3L24WzrHhfnaL9xYh3ZLYs
         Xn6avj4D+puR1pdWTbRMGdahFqjEoRTIIYJQVsk/rztzNsTLyWtmaP010ObpcSIB/mV4
         9do4r1GmsWRHONZldl+lLEAYZHSO8DaupZ+6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=eU7DxGJbke5HtsD7G2g0C5VMj9H8lfVdTqbdRaIVevXlr8wkEO1CqJQF06P/vYoIXU
         5oYar6MjEU6kXDHAdMtbndwPkzzJX0fLArIQQNAUIV3a/hrZtPMysGKb5oInrLRWgLYK
         oZ7G6/5fwYx7kItLUv3I7EsM0klGummB6ebNw=
Received: by 10.103.76.37 with SMTP id d37mr1872580mul.99.1255250897789;
        Sun, 11 Oct 2009 01:48:17 -0700 (PDT)
Received: from localhost.localdomain (abwa37.neoplus.adsl.tpnet.pl [83.8.224.37])
        by mx.google.com with ESMTPS id y6sm6500560mug.10.2009.10.11.01.48.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 01:48:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9B8mign003619;
	Sun, 11 Oct 2009 10:48:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9B8mRPi003608;
	Sun, 11 Oct 2009 10:48:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200910110436.52653.chriscool@tuxfamily.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129907>

Christian Couder <chriscool@tuxfamily.org> writes:

> On Saturday 10 October 2009, bill lam wrote:

> > Christian Couder also mentioned the git-replace command, how to stitch
> > with it?
> 
> First you need to create a commit that will replace commit N, let's call it 
> N' and after that you can use "git replace N N'". So the complex part is to 
> create N'.
> 
> You want N' to have the same content as N but to have M as parent. So you 
> could do something like the following:
> 
> (We suppose that commits A to M are in branch1 and that you are in the root 
> directory of your repo2 working directory.)
> 
> $ git checkout -b repo1-branch1 remote/repo1/branch1
> $ git checkout N -- .
> $ export GIT_AUTHOR_NAME=<author name of commit N>
> $ export GIT_AUTHOR_EMAIL=<author email of commit N>
> $ export GIT_AUTHOR_DATE=<date of commit N>
> $ git commit -a
> 
> And then use the commit message from commit N, and maybe also say in the 
> commit message that it is replacement commit made to link repo1 with repo2 
> or something like that.

I think simpler solution would be to use plumbing for that.  First
save commit to be replaced in a (text) file:

 $ git cat-file commit N > COMMIT_N

If you want to edit only commit message and perhaps parentage (like I
think in this case), you need to simply edit COMMIT_N file, and modify
(or add) 'parent' header(s), which is between 'tree' and 'author'
header.

Then put modified commit in repository object database

 $ git hash-object -t commit -w COMMIT_N
 
> At this step you have created N' and you should make sure that it is exactly 
> what you want. It should point to the same tree as N, it should have M as 
> parent, ...
> 
> If everything is ok then you can use:
> 
> $ git replace N HEAD

And then do

 $ git replace N NEW_N

where N is _SHA-1_ of original comit ("git rev-parse --verify N^0"),
and NEW_N is SHA-1 of replacement commit, as written by git-hash-object.
 
> And you should be done.

But I haven't tested this. YMMV.

See also my answer here: 
http://stackoverflow.com/questions/1220557/how-do-i-prepend-history-to-a-git-repo/1547490#1547490

-- 
Jakub Narebski
Poland
ShadeHawk on #git
