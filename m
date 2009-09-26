From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Distribution size
Date: Sat, 26 Sep 2009 04:27:27 -0700 (PDT)
Message-ID: <m37hvmaqud.fsf@localhost.localdomain>
References: <1253962653-sup-1882@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 26 13:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrVRB-0007NM-3E
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 13:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbZIZL11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 07:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbZIZL10
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 07:27:26 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:47055 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZIZL10 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 07:27:26 -0400
Received: by fxm18 with SMTP id 18so2741484fxm.17
        for <git@vger.kernel.org>; Sat, 26 Sep 2009 04:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=AYX57Kry2UjLIHNI49gxrDL5xu+dYrMn9APqJgxVQvo=;
        b=bDwJ6uaIsJ57XsrSftiK5XpBTyrCii/AdEQLxZWdkVbPfuCKuoDVbY8m/2s9e3/lRt
         CowfSsvfUD1I4SHH9NEpun3TRrUkTUV0HfgKB42JKM/km7zwatG/RlY+aNKdcHZd0N/7
         zOYl4FE0MWx12J0ZM1GlbIlUbPkxUImWQt3n8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=hBhWx9LYrrGsyvcddJ8gJ8CMFYzmS9HgUR2eEE9oEUrUgKLN2i8j5vyzYWyBYeatkL
         U7x9QUpXLaIh9qOE+SgAyGT5qfArS33rYG903p0qwaf0G6rY45OSf1VF/4SQwjT/KPJd
         Swz+kOFiIECHY49LgiBQpwX8WHs0Ujls+FjaM=
Received: by 10.86.231.13 with SMTP id d13mr1763074fgh.41.1253964447937;
        Sat, 26 Sep 2009 04:27:27 -0700 (PDT)
Received: from localhost.localdomain (abvs184.neoplus.adsl.tpnet.pl [83.8.216.184])
        by mx.google.com with ESMTPS id l12sm2186663fgb.29.2009.09.26.04.27.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Sep 2009 04:27:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n8QBROr5014760;
	Sat, 26 Sep 2009 13:27:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n8QBRNBu014757;
	Sat, 26 Sep 2009 13:27:23 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1253962653-sup-1882@nixos>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129150>

Marc Weber <marco-oweber@gmx.de> writes:

> Has anyone thought about reducing distribution size ?
> 
> comparison:
> 
> git-1.6.4.4 i%du -hs .
> 115M    .

Errr... what?

  $ du -hs /usr/libexec/git-core/
  8.0M

  $ du -shc `rpm -ql git`
  ...
  27M
 
But

  $ du -sh git/.git
  49M

(there is some of my commits there, some old branches pinned, and some
commits with other git(web) forks).

And

  $ git archive HEAD --output=tmp.tar
  $ du -sh tmp.tar 
  11M     tmp.tar

> mercurial-1.0.2 i%du -hs .
> 5.4M    .
> 
> bazaar-1.10rc1 i%du -hs
> 21M     .
> 
> darcs-2.2.1 i%du -hs    /nix/store/8xwfavyv22pvm3s60wvzcbq561fjk5di-darcs-2.2.1 nixos   
> 32M	.
> 
> There was an attempt to reduce size by using a shared library in 2007:
> http://markmail.org/message/vzukaie4qvbghkq5
> 
> So is there a reason why git takes up so much more disk space other than
> that its using many small executables?

Are you sure you are comparing the same thing in all cases?
And not in some cases after "make", with all object files?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
