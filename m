From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] bash completion: Support "unpushed commits" warnings in __git_ps1
Date: Sun, 06 Jun 2010 14:07:48 -0700 (PDT)
Message-ID: <m3r5kjq3ac.fsf@localhost.localdomain>
References: <4C0AE640.3040503@pileofstuff.org>
	<201006062014.59386.trast@student.ethz.ch>
	<4C0C09BF.4070503@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sun Jun 06 23:08:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLN4Z-0004nH-Mq
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 23:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279Ab0FFVHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 17:07:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50835 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab0FFVHx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 17:07:53 -0400
Received: by wyi11 with SMTP id 11so1965329wyi.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 14:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=qExhTZSKFL+iqCcu4Earr9f+9BNoaaoB0HlUnCn88v4=;
        b=bqlOpDYZMRoEV8/UfokbTGHTjjybQVtqP2DGZ2u/J+0yPpuvqofLrI/XkWgQq6y4ql
         9qhoGvbYPr0TQj/kAOLfzpimbn8Tg6WVcgF4APNcdAoHrHg3Wx5KxF4XUdz75EDGKQYh
         DhKCT3MJpSL4ppya/TrJ1krLeDQVDp4ROaVQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=sI942ockaIFNhyD35L1e4pr+UzIbOkwSaOxm4zdWuV22yMJxf3Rj+opaidecWZ0L7Z
         weprL1jkHox3dqIuPUf3ABWHh5SEYEXCxj4vK91/2bv1Z+/4zEXew/OLe9W35AsdgVwU
         0V8tmJe8y200BhyWfOBht17hk8JvTzasSumLw=
Received: by 10.227.127.132 with SMTP id g4mr13038488wbs.177.1275858470311;
        Sun, 06 Jun 2010 14:07:50 -0700 (PDT)
Received: from localhost.localdomain (abwd128.neoplus.adsl.tpnet.pl [83.8.227.128])
        by mx.google.com with ESMTPS id q6sm6072654wbc.11.2010.06.06.14.07.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 14:07:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o56L76ih016854;
	Sun, 6 Jun 2010 23:07:17 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o56L6aDM016840;
	Sun, 6 Jun 2010 23:06:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4C0C09BF.4070503@pileofstuff.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148543>

Andrew Sayers <andrew-git@pileofstuff.org> writes:

> I don't see how to actually split out the branch name without calling
> sed or using one of the disallowed ${} constructs.  So I compared the
> following commands on my PC (2.1 GHz dual-core Athlon) using a
> repository with 100 empty commits between HEAD and a git-svn-id:
> 
> time git log | \
> 	sed -ne "/^    git-svn-id: / { s/^    git-svn-id: "\
> 	"$remote_branch\/\([^@]*\).*/\1/p ; q }"
> 
> time git log -1 --grep="^git-svn-id: $remote_branch" | \
> 	sed -ne "s/^    git-svn-id: $remote_branch\/\([^@]*\).*/\1/p"

What disallowed ${} constructs?

First, ${var#pattern}, ${var##pattern}, ${var%pattern} and ${var%%pattern}
are POSIX, so you can use it in git shell scripts.

Second, this is _bash_ completion, so you can use also bash-specific
expansion, like ${var/pattern/string} or ${var//pattern/string}.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
