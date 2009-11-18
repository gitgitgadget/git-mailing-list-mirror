From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-mailinfo doesn't stop parsing at the end of the header
Date: Wed, 18 Nov 2009 09:46:43 -0800 (PST)
Message-ID: <m3bpizd8ua.fsf@localhost.localdomain>
References: <aa2993680911180620g151d8a07t11144d150cd6e29e@mail.gmail.com>
	<20091118155154.GA15184@coredump.intra.peff.net>
	<aa2993680911180911o7e3af804m4ebdc20096baa609@mail.gmail.com>
	<20091118172424.GA24416@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Hofstetter <phofstetter@sensational.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 18:47:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAocO-0006zF-DI
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 18:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758112AbZKRRqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 12:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758089AbZKRRqm
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 12:46:42 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:49243 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758074AbZKRRqk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 12:46:40 -0500
Received: by bwz27 with SMTP id 27so1390342bwz.21
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 09:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Bxbt2QEu2/0/NPOB0PohKNF5ubY2sVJXuIT+JuXBGjU=;
        b=jEL0DNFOahqjuOomm5Hi7IcxndqGuwm2CkKPUb0hE89FbkIUJ6zIigIc3lGUmXD7Jc
         JMoaP7hJcIbHhwO4GIA66ee86L1Y+qud9HsDkRDZJpBAJVbPchRRo8BxonifrrlYzin2
         WhVKqlE9BQkamWeXPxnuLFA6bRnAcV+a+LvkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=pVtbmGQyxvQ4jLIxaI0uODsvFR0iRhcQq5UnuPb2ACQNnAn0zviGCQa+AiOtZtTuLW
         pDlshoEA2vJCtaxmD+F+n7X0GkfhOGd4r+vm74E5w0akTgYTtFCLqgU/GAsqyUeHkOlp
         Ovqx2tEG52F8ZxamYWsUOqeEMAGhOtV8PzSKQ=
Received: by 10.204.156.18 with SMTP id u18mr4085028bkw.102.1258566405909;
        Wed, 18 Nov 2009 09:46:45 -0800 (PST)
Received: from localhost.localdomain (abwj15.neoplus.adsl.tpnet.pl [83.8.233.15])
        by mx.google.com with ESMTPS id 16sm120881bwz.3.2009.11.18.09.46.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Nov 2009 09:46:43 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAIHkekd020098;
	Wed, 18 Nov 2009 18:46:40 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAIHkcnt020094;
	Wed, 18 Nov 2009 18:46:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20091118172424.GA24416@coredump.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133193>

Jeff King <peff@peff.net> writes:

> I also think "git commit" would not be the right time for such a
> feature. The problem is not that you have this text in your commit
> message. The problem is that the "format-patch | am" transport is lossy.
> You would do better to have format-patch say "Ah, this is going to
> create a bogus email address" and somehow quote it appropriately.

Doesn't mbox format have some way of escaping "From:" (or is it "From ")?
If I remember correctly it uses ">From " or something for that.
git-format-patch could do this also (perhaps only with --rebasing
option).

P.S. As git-format-patch / git-am have hidden --rebasing option,
perhaps git-mailinfo should have it as well (even if it is called
--strict).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
