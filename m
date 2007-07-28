From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb and submodules
Date: Sat, 28 Jul 2007 22:39:28 +0200
Message-ID: <200707282239.29340.jnareb@gmail.com>
References: <200707271322.50114.jnareb@gmail.com> <200707281229.17351.jnareb@gmail.com> <20070728104054.GI31114MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Sven Verdoolaege <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Sun Jul 29 00:59:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEvFi-00056s-KM
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 00:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487AbXG1W7L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 18:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757458AbXG1W7L
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 18:59:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:15421 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757262AbXG1W7K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 18:59:10 -0400
Received: by nf-out-0910.google.com with SMTP id g13so96904nfb
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 15:59:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D990uLST7Bahj22qHwmT79wtsYsZAqFO3L8i0w/+3/INLHLR41Z9mJMLVUZjXNXsePS0JuZPb10pEi6uc8+obhYCTLa3bDq6MaXg6BYWfSsxYkUqk8f3Jq+Jzew0j1iBLe6CeY3sgzWeZukYkid46xztjRFoRyGQLKOGSLPI0js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nzsiAxhtZ5+ezyGOrVdA1V9Ahp5JlCznO2wh1U64W4N5nPmx5QGTHG9wwOtUaNbWT60Jweu05NpCSlfckVYEiI+xsH/DwndnVSCG5Sas9iNFhR0wzmVB+BYDflXieSLLbSIYOUSVsfyUpMSSXN5FISX1hfIO4I+1JwKDDTpjcug=
Received: by 10.86.60.7 with SMTP id i7mr2889407fga.1185663549079;
        Sat, 28 Jul 2007 15:59:09 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id j2sm5985275mue.2007.07.28.15.59.03
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jul 2007 15:59:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070728104054.GI31114MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54065>

On Sat, 28 July 2007, Sven Verdoolaege wrote:
> On Sat, Jul 28, 2007 at 12:29:16PM +0200, Jakub Narebski wrote:
>>
>> What do you think about using "submodule.$name.gitdir" configuration 
>> variable for that?
> 
> What will be the value?  A path relative to the gitdir of the superproject?

Or absolute path. I was thinking about absolute path, but path
relative to GIT_DIR of superproject is a good idea.

>> It has to be configuration variable because the 
>> location of repository which has submodule objects doesn't change when 
>> checking out (or rewinding) to different commit in supermodule.
> 
> Let's hope Pasky provides a way to set this information...

Why Pasky?

>> As a special case I'd use 'no value' to note that submodule objects are 
>> contained in the supermodule repository.
> 
> How about using '.' for that and no value for submodules that
> are not available on this server?

Very good idea, both using '.' to mark that submodule objects are in
the superproject objects database, and no value for not available
(although I'm less sure about the latter).


I am thinking about the following sequence to search for submodule
objects:

>From $GIT_DIR/config:
  submodule.$name.objects (absolute or relative to gitdir of superproject)
  submodule.$name.gitdir  (absolute or relative to gitdir of superproject)
  submodule.$name.url     (to find GIT_DIR, if it is local filesystem URL)

If there is working directory, from .gitmodules file in top level
of working directory:
  submodule.$name.path/.git (relative to toplevel of working directory)

What do you think about this?

-- 
Jakub Narebski
Poland
