From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 10/15] commit.c: fix a memory leak
Date: Tue, 24 Mar 2015 20:42:17 +0700
Message-ID: <CACsJy8A3CptGYNAZ=+k0ykBCp6SGoOLY0nX20WkWQp=qUnxwWg@mail.gmail.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
 <1426897692-18322-11-git-send-email-sbeller@google.com> <xmqqk2ybatm1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 14:43:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaP6o-0000X8-Vc
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 14:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbbCXNmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 09:42:52 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36657 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbbCXNms (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 09:42:48 -0400
Received: by igbud6 with SMTP id ud6so71947453igb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 06:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=22hFlphcFY7rdXyLFpexb1BCZXcgAWGdfYbL/eTeNgg=;
        b=qsP5o84PzTkcJZL2D4a+Qp+KyoXPU0m3aj5EvH8+ctzPI0CWrVbjdtm7+CzW8AXM6U
         wq5Qiycoa8YoFYSDsdwcBFmp676InqnWW/CJ8COQ2ciNrhwvxBhAtDeyMzcI6QwNuazG
         q07DC0gsaP2PfyT9MXGBCOdUz95uRtiVCoyI7c+bs+TU/zFTRtF8U2dZMob4p5gu5A4G
         LUu7IfvHG4KTx9ASCI9/FR1ORZ+5xNA/+D2aeJB0d0vdgGXXZB4Gf60eawiSW3OGOfBW
         n6iN7q7GQbmk+Ci333FSW8hNJojZU7Cirs8cZvDAMQjSbI8fSTYexNSB6ABQbCY6DSPw
         2RtA==
X-Received: by 10.50.131.196 with SMTP id oo4mr22437066igb.2.1427204567818;
 Tue, 24 Mar 2015 06:42:47 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Tue, 24 Mar 2015 06:42:17 -0700 (PDT)
In-Reply-To: <xmqqk2ybatm1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266187>

On Sat, Mar 21, 2015 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> A further tangent (Duy Cc'ed for this point).  We might want to
> rethink the interface to ce_path_match() and report_path_error()
> so that we do not have to do a separate allocation of "has this
> pathspec been used?" array.  This was a remnant from the olden days
> back when pathspec were mere "const char **" where we did not have
> any room to add per-item bit---these days pathspec is repreasented
> as an array of "struct pathspec" and we can afford to add a bit
> to the structure---which will make this kind of leak much less
> likely to happen.

I just want to say "noted" (and therefore in my backlog). But no
promise that it will happen any time soon. Low hanging fruit, perhaps
some people may be interested..
-- 
Duy
