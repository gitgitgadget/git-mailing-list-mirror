From: Jim Cromie <jim.cromie@gmail.com>
Subject: git send-email --body <file> ?
Date: Fri, 27 May 2011 13:56:24 -0600
Message-ID: <BANLkTi=28buKWVZeAHZs3xB4ry+njDDuuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 21:57:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ39Z-0006KE-Uz
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 21:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756938Ab1E0T45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 15:56:57 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:35690 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148Ab1E0T4y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 15:56:54 -0400
Received: by pxi2 with SMTP id 2so1436039pxi.10
        for <git@vger.kernel.org>; Fri, 27 May 2011 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=qQ0Qso2ZO/6xvno04q9fhYN8HR0a6ipC/c5UJBrohxk=;
        b=HQI3aSVCVwxqkZl+nQZUn19vrApYL7WLyAgOaRFuvWqOyXloNHOi/MzwIlp2RCaLNt
         LpaOz8+jU1U4Pf28RfEQkh09sp4F+ne9xgTMgjJmaZKqjK0TbV/exTyVirlHFfHPP2lN
         CiUwJVPDskFtlX7jeZhVNw25K+b3mto8kH2vE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=gi8gZ/jhV/FNOWnmIoFEIZj6pxK2pEHcOys2wG+wI/q0GU2xHenmi64tmGzTV7LaRt
         Cbv2YWIt1JoUDd3qTRtn3SI1UTLeFLnfqdtxrDXtiPp64d7ATAcFnTnxi53/vG60YVJM
         njltL7VgZ4p2YzzH/vViZCH4E+Lq5ze8IkTKY=
Received: by 10.142.225.11 with SMTP id x11mr364983wfg.389.1306526214065; Fri,
 27 May 2011 12:56:54 -0700 (PDT)
Received: by 10.143.59.18 with HTTP; Fri, 27 May 2011 12:56:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174643>

The perlbug tool is increasingly used by perl community to send patches,
it has options to save report (perlbug.rep by default)

Ive started hacking it to use git send-email when used from inside the git repo
(theyve switched to git :-), and Id like to just use the file it writes.

I tried just passing file in as 1st arg, tool was unhappy:

[jimc@groucho perl]$ git send-email --dry-run  perlbug.rep 0001-*
fatal: perlbug.rep: 61: patch contains a line longer than 998 characters
warning: no patches were sent

I dont want to turn off validation, but if I do, it appears to work,
but my test-send resulted in only the 2 patch files 0001-* arriving
at my inbox, it seems the 1st file (perlbug.rep) was silently rejected.

Indeed, on-screen output shows only 2 sends (below)

--body <file>  seems an ideal solution:
it would read file, and act like --compose if the file were missing
critical stuff, or perhaps just error out.

thanks,
~jimc

[jimc@groucho perl]$ git send-email --to=kidongrok@yahoo.com
--no-validate perlbug.rep 0001-*
perlbug.rep
0001-perlhack.pod-fix-perlbug-invocation.patch
0001-regexp.h-repair-linux-perf-compilation.patch

                                                             Who
should the emails appear to be from? [Jim Cromie
<jim.cromie@gmail.com>]
Emails will be sent from: Jim Cromie <jim.cromie@gmail.com>


Message-ID to be used as In-Reply-To for the first email?
Password:
OK. Log says:
Server: smtp.gmail.com
MAIL FROM:<jim.cromie@gmail.com>
RCPT TO:<kidongrok@yahoo.com>
From: Jim Cromie <jim.cromie@gmail.com>
To: kidongrok@yahoo.com
Subject: [PATCH] b3045a4 perlhack.pod: fix perlbug invocation
Date: Fri, 27 May 2011 13:22:49 -0600
Message-Id: <5.12.3_2182_1306516233@groucho.jimc.earth>
X-Mailer: git-send-email 1.7.4.4
Reply-To: jim.cromie@gmail.com

Result: 250 2.0.0 OK 1306524179 a6sm721905pbo.15

In git 1.7.0, the default has changed to --no-chain-reply-to
Set sendemail.chainreplyto configuration variable to true if
you want to keep --chain-reply-to as your default.
(mbox) Adding cc: Jim Cromie <jim.cromie@gmail.com> from line 'From:
Jim Cromie <jim.cromie@gmail.com>'

From: Jim Cromie <jim.cromie@gmail.com>
To: kidongrok@yahoo.com
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH] perlhack.pod: fix perlbug invocation
Date: Fri, 27 May 2011 13:22:50 -0600
Message-Id: <1306524177-10446-1-git-send-email-jim.cromie@gmail.com>
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <5.12.3_2182_1306516233@groucho.jimc.earth>
References: <5.12.3_2182_1306516233@groucho.jimc.earth>

    The Cc list above has been expanded by additional
    addresses found in the patch commit message. By default
    send-email prompts before sending whenever this occurs.
    This behavior is controlled by the sendemail.confirm
    configuration setting.

    For additional information, run 'git send-email --help'.
    To retain the current behavior, but squelch this message,
    run 'git config --global sendemail.confirm auto'.


                                                             Send this
email? ([y]es|[n]o|[q]uit|[a]ll): a
OK. Log says:
Server: smtp.gmail.com
MAIL FROM:<jim.cromie@gmail.com>
RCPT TO:<kidongrok@yahoo.com>
RCPT TO:<jim.cromie@gmail.com>
From: Jim Cromie <jim.cromie@gmail.com>
To: kidongrok@yahoo.com
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH] perlhack.pod: fix perlbug invocation
Date: Fri, 27 May 2011 13:22:50 -0600
Message-Id: <1306524177-10446-1-git-send-email-jim.cromie@gmail.com>
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <5.12.3_2182_1306516233@groucho.jimc.earth>
References: <5.12.3_2182_1306516233@groucho.jimc.earth>

Result: 250 2.0.0 OK 1306524208 a6sm721905pbo.15

(mbox) Adding cc: Jim Cromie <jim.cromie@gmail.com> from line 'From:
Jim Cromie <jim.cromie@gmail.com>'
OK. Log says:
Server: smtp.gmail.com
MAIL FROM:<jim.cromie@gmail.com>
RCPT TO:<kidongrok@yahoo.com>
RCPT TO:<jim.cromie@gmail.com>
From: Jim Cromie <jim.cromie@gmail.com>
To: kidongrok@yahoo.com
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH] regexp.h: repair linux perf compilation
Date: Fri, 27 May 2011 13:22:51 -0600
Message-Id: <1306524177-10446-2-git-send-email-jim.cromie@gmail.com>
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <5.12.3_2182_1306516233@groucho.jimc.earth>
References: <5.12.3_2182_1306516233@groucho.jimc.earth>

Result: 250 2.0.0 OK 1306524210 a6sm721905pbo.15
