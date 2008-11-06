From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Need help for migration from CVS to git in one go (ie, FORGETTING CVS history)
Date: Wed, 05 Nov 2008 19:08:16 -0800 (PST)
Message-ID: <m3zlkdeelm.fsf@localhost.localdomain>
References: <200811060014.57046.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Thu Nov 06 04:09:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxvFf-0004X9-SM
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 04:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbYKFDIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 22:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753729AbYKFDIY
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 22:08:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:51355 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbYKFDIT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 22:08:19 -0500
Received: by nf-out-0910.google.com with SMTP id d3so197375nfc.21
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 19:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=qGKrAH5Zw9y/PAT4yhRL+2NwNuYoJFVukEQle1IpV/o=;
        b=Z2KS2s9NP8lL+TDO9dJMH+hcmQgdPigTc9h72uR009MqX1ioDoGc48pzKrNWGVLtdL
         /ccKSEC08oMtd6c2Pne5knU2k7j480YcJrkDrrvtAOqvMrlzmgzntDzgUU+facIocNQH
         py+Nzavw0Q5howuTixWQkgK5YU3eoQOE0PKLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=qI1Ct67yYp5j2v094f8omUDPsGhw8gbdnK7MHAwBhVQglWqAZUJ0Sc3QhmRGx5tA51
         D0c0cNtAB6s+uhargnHvVUqXiQLvt26KxOzdb6TkUwu14M5LHQjF8cgTG7YQTti3tb/Y
         5ymu2UNGpQ1ZpWkR13UlOYTK/FO1lq5jmJ7k8=
Received: by 10.210.121.8 with SMTP id t8mr1808646ebc.180.1225940897858;
        Wed, 05 Nov 2008 19:08:17 -0800 (PST)
Received: from localhost.localdomain (abwr214.neoplus.adsl.tpnet.pl [83.8.241.214])
        by mx.google.com with ESMTPS id 3sm831760eyj.3.2008.11.05.19.08.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 19:08:16 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mA638A1e010513;
	Thu, 6 Nov 2008 04:08:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mA6386aG010509;
	Thu, 6 Nov 2008 04:08:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200811060014.57046.fg@one2team.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100210>

Francis Galiegue <fg@one2team.net> writes:

> Since my first email where I said that we wanted to migrate from CVS to a 
> distributed SCM, we have had a lot of discussions with developers and my 
> chief (which happens to be a developer too). We have come to the following 
> conclusions:
> 
> * git has credentials (heck, it "runs" the Linux kernel, Wine,
>   Samba, and other);

The main contenders among top OSS version control systems seems to be
Git, Mercurial and Bazaar-NG for distributed SCM, and Subversion for
centralized SCM.

> * the "distributed" part of it is indeed an advantage (planned
>   developments with huge technical/functional impacts);

> * 52 CVS modules, fine; but then this can become one and 52
>   subdirectories in them and still act as separate modules from
>   the build system point of view (which I have implemented, so
>   I can change it);

I think that those CVS modules should become separate repositories,
perhaps joined together using submodules. This is one of more
difficult things during conversion.

Note that in Git commits are always whole tree (whole project)
commits.

> * second: even though this may be a "non problem", we use Bonsai,
> which has the ability to see what was commited by whom, given a time
> interval (from d1 to d2): the base gitweb allows to search by
> commiter, which is good, but it has no date boundaries: do tools
> exist for git that can do this? If not, that wouldn't be a big deal,
> however...

First, there are more web interfaces than gitweb, see
http://git.or.cz/gitweb/InterfacesFrontendsAndTools

Second, you can do this from command line, using combination of commit
limiting a..b and a...b, or --since=<date> or --after=<date> and
--before=<date>, commit message searching --author, --committer, and
--grep, and path limiting "git log -- <pathspec>".

Third, it would be not that hard to add more advanced search support
to gitweb; this is even one of planned features.

> * third: also Bonsai-related; Bonsai can link to Bugzilla by
> matching (wild guess) /\b(?:#?)(\d+)\b/ and transforming this into
> http://your.bugzilla.fqdn.here/show_bug.cgi?id=$1. Does gitweb have
> this built-in? (haven't looked yet) Is this planned, or has it been
> discussed and been considered not worth the hassle?

This is (under name of 'committags') in gitweb TODO; gitweb-xmms2
support this IIRC or supported this (for Mantis and not Bugzilla
though...)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
