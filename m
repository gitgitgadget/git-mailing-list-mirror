From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: commiting while the current version is in conflict
Date: Thu, 16 Oct 2008 16:42:06 -0700 (PDT)
Message-ID: <m3ljwojeeu.fsf@localhost.localdomain>
References: <2d460de70810161510ha220593g4615a55b2c3e3b25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Richard Hartmann" <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 01:43:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqcV1-0003Yq-Se
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 01:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbYJPXmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 19:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbYJPXmL
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 19:42:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:48042 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYJPXmK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 19:42:10 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1919169ugf.37
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=kAcirbIWbRaQDkTFLlrxgf/9FJxb1CJY7/i1rB7vk6E=;
        b=m9So3gj3fJe4tMXnV6Bavw9C578EdthIwB8m+52GRsCtjs19whYCkmv4K56xR5Q0gr
         qRoOpFdeYo3JoYrJyVbftAMmsq73KIfX7vycS6WEVIqid/fdpyqlOhjluNyBeukxE/6Y
         cdEor4GjpRlfxdgJSu+zr7jEAZR0H+js9BMlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=rmobZcfeYSpHoznVqWA7stw1V46klyjULWGQ6PmXXZPVv4+zW2wJiRSVth8LBYuka6
         IqeFm5Mjtno2Tmzdxo3lB3FId31wFtXpeZr3BtIo+VODSaC1qVpZG7qvOdvsYx6gS9iL
         HC/vrLnvZNOnB/yVu13mR6EBJwWDa85NBPQMc=
Received: by 10.210.30.1 with SMTP id d1mr3620806ebd.127.1224200528145;
        Thu, 16 Oct 2008 16:42:08 -0700 (PDT)
Received: from localhost.localdomain (abvf153.neoplus.adsl.tpnet.pl [83.8.203.153])
        by mx.google.com with ESMTPS id 23sm2766224eya.7.2008.10.16.16.42.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Oct 2008 16:42:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9GNg2c4026861;
	Fri, 17 Oct 2008 01:42:03 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9GNg1XE026858;
	Fri, 17 Oct 2008 01:42:01 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2d460de70810161510ha220593g4615a55b2c3e3b25@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98437>

"Richard Hartmann" <richih.mailinglist@gmail.com> writes:

> I fooled around with git a liitle bit and noticed something
> rather strange. I merged two branches, creating a conflict
> on purpose. When I then did a
> 
>  git commit -a
> 
> all changes were submitted. Of course, I now have a
> file with the conflict markers inlined in my repository. Not
> a good thing, imo. Is there a way to make git block all
> conflicting versions?

The default pre-commit hook shipped with git includes this check.  
All you have to do is enable it: it has to be named 'pre-commit' and
it has to be exacutable.  In older git version you would do:
  $ chmod a+x .git/hooks/pre-commit
while in never versions it would be
  $ mv .git/hooks/pre-commit.sample .git/hooks/pre-commit
 
> Also, I would be interested in the design decissions
> behind the current behaviour. Any pointers?

It is a git policy that it ships with all hooks disabled.

P.S. You can always bypass pre-commit hook (for example if comitting
AsciiDoc files, which may include something that looks like conflict
markers, or if you are committing test which includes conflicted file
as one of test vectors), by using `--no-verify' option to git-commit.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
