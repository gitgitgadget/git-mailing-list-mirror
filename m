Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AE7C761A0
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 09:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816B62072C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 09:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojKLoQnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgBQJBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:01:16 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52378 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgBQJBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 04:01:16 -0500
Received: by mail-wm1-f54.google.com with SMTP id p9so16271317wmc.2
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 01:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=M9x4thl/j3LYvf100qPT2mx870Xsw+4dQieNy1WpXGE=;
        b=ojKLoQnqbQS4f3sExxj9qgfLN3VZ8pPbWfIXFCnpKp+foFtF7m6HXBWqJv3IWhTzR1
         sZOezSiaBYeWQ3NB1l/wwHijz6JOx7tUfmJGNJwNjJQ2gzS3D1D5R+VxXbFrsPiINZI6
         weEBt/JrHFUMCAvsiNe6sUm5o+k+ocJlMUm3BGqyfEWLpAJNbZGzlUERtx2GE7DB3PRx
         LuqENTTu1lwP7U+eF68tahJvvJmtB+TCCRPbfGcPzORcSIXDlEmUSDUmyWEc61MYvYvl
         +i48G0f3d3EPKIxra+uSqxtDiXoFPv79+RsKabGPRFEZxPHDiMvOduU8YpqdoHSOHLJ1
         tsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M9x4thl/j3LYvf100qPT2mx870Xsw+4dQieNy1WpXGE=;
        b=CS9abK/DvM/BoUPeC1xMFz84+hoHzGMHYMKaDwiODGsq6yXE+u+48mCxdzBDhT/AJL
         qSjeLRS5/vDITW2g2FeHkHdwD8gSalib7BHEGAFt/u8eMBv8CXIHBOuzePYHooNGE8Mw
         IwXsWF62kRpAFL+rTkjS6PG7TluzNARd96pcGpaYTG+C2RLTjbhI9J5zw05Qb4mC67AG
         GJj7Ywy4KLaNdV+fWlcc1wlQ2T2JhNzndCi1721+asqceXQffyss5Kwug903FMS17YCZ
         by1F0pY3A+AXHoqtPE+6YDTL5m6b1Xn+8FITBGXu6jc2RTGdu6ci3VSVpAv0KLiS9Xmm
         Kgmw==
X-Gm-Message-State: APjAAAVVw0Gnd1PiFYvzCC1GbxbhzqWInP7vXEhtp57FG8HJ7jzCZrAx
        fKmTgHFnKje8z1goc+tclOG6PuWzP3HcrNMA3LNPBRDnU+E=
X-Google-Smtp-Source: APXvYqyPfrH20QjrPumxjT7dNDW41RlJ1JMPTrAh9OlLGVma6aqGSiCWc+gnbo4lUOUMALF2fa06ea5vMFOHjWzUXz8=
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr21713948wma.171.1581930074892;
 Mon, 17 Feb 2020 01:01:14 -0800 (PST)
MIME-Version: 1.0
From:   Michael Strelnikov <michaelst@gmail.com>
Date:   Mon, 17 Feb 2020 20:00:38 +1100
Message-ID: <CANno94g7S68OfXNJ5B-uKR5=oZn3dsuDsuZHnKrh7tXzYWPNig@mail.gmail.com>
Subject: git diff from a pre-commit hook
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

   I'm trying to implement the pre-commit hook and faced a problem.
   1. If I just run command "git diff --staged --name-only
--diff-filter=A" I get an error: "fatal: unable to read [SHA]"
   2. After searching for solutions I found that for a pre-commit hook
I have to re-set the GIT_INDEX_FILE variable to ".git/index". After
doing that I see that diff is not honoring the "info/exclude"
settings.

Is there anything else I need to set to make diff working properly?

Best regards,
Michael Strelnikov
