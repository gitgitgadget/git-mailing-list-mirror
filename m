From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v8] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 30 Jun 2008 01:56:27 +0200
Message-ID: <200806300156.28908.jnareb@gmail.com>
References: <1214273933-3925-1-git-send-email-LeWiemann@gmail.com> <200806300047.12224.jnareb@gmail.com> <48681D21.1040302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 01:57:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD6lx-0000d6-6d
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 01:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbYF2X4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 19:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbYF2X4g
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 19:56:36 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:45045 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbYF2X4f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 19:56:35 -0400
Received: by ik-out-1112.google.com with SMTP id c28so574859ika.5
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 16:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=W9UmsPWVa9C2Z1xsNdQ7QPSEfml8zcIknkvwlbEC0mI=;
        b=HB50cf4RLXo0PDhr+nruE3K+rOSJLB39YOYsb7bZLsUscVEscTf8srnfS6V81XMQo/
         MPCl7iyAgiUOnBIYn8ZD0GNc8IHQS++Pi9znzbHn2RaPZ5c1+6kIlFbHIuu/m/ZGOD38
         lJ+JKEv14vDALBvIVi//Djg0D5qNE2z8bl82w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qANIB8S3nF10OS1AieqH7r8aP789SP0WD6PPOuYiTfRM5zhL4KGwj/5V1uLfy4YUzX
         cYLyvBNvCNHz+IMC47EK4osBkO3zYJusDneUCTtrLnGao46ZzmviBlXyx6/JcJWrOBlY
         hUkhNSWcIFl3fmtmuT4B47pac9oDTAuKtBxG4=
Received: by 10.210.130.14 with SMTP id c14mr3576320ebd.100.1214783791604;
        Sun, 29 Jun 2008 16:56:31 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.210])
        by mx.google.com with ESMTPS id c24sm5707365ika.4.2008.06.29.16.56.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Jun 2008 16:56:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48681D21.1040302@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86849>

On Mon, 30 June 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
>> On Thu, 26 June 2008, Lea Wiemann wrote:
>>>
>>> - Follow redirects rather than failing.
>> 
>> Nice. Where it is?
> 
> test_page doesn't use $mech->get_ok anymore, but rather calls $mech->get
> and checks that the status is [23][0-9][0-9].  If it's 3xx, it also
> follows the redirect.

Thanks for the info.

By the way, some time ago I have send a patch (dropped, perhaps because
of it being feature freeze, or just lost) which converted support for
links with hash and without action (introduced in 7f9778b by Gerrit
Pape) to use redirect (like for 'object' action) instead of silently
filling correct action based on type of object (given by hash).  IMHO
it is better as it should prevent bookmarking "expensive" URL.

So this is useful, and could/would be even more useful.

>>> - Do not test correctness of line number fragments (#l[0-9]+); they're
>>>   broken too often right now.
>> 
>> What do you mean by broken?
> 
> This is only visible with --long-tests -- there are links to line
> numbers that don't exist (IOW the fragment doesn't exist in a name or id
> attribute on the target page).  I've even seen links to #l0.  Bug fixes
> welcome. ;-)

I wonder if those are intentional (or at least known) breaking, to form
approximate blame file history browsing; there was discussion about it
on git mailing list some time ago (it resulted in adding "parent" line
to blame porcelain/incremental output... or was it only in 'pu'?).
 
>> Good work!
> 
> Thanks! :-)  I'll send v9 in (hopefully) 2-3 days, together with the
> first working version of the caching code.

One issue of note, after brief peek at Git::Repo code: you should not
error out on unknown header in commit object, but either save its value
under its name, or just skip it.

Unless this has changed...

-- 
Jakub Narebski
Poland
