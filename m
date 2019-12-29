Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B54C2D0CE
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 15:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6E220748
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 15:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbpxsHpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfL2Pty (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 10:49:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39782 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfL2Pty (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 10:49:54 -0500
Received: by mail-ed1-f65.google.com with SMTP id t17so30184408eds.6
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=fkRs9zBV+PClpSTGvRWpGA/VZvK95GI9M3N166/B/X8=;
        b=rbpxsHpgufBNbeKBCnWBBpTrxOy2hX+Gyv59L/HN5Hxtdns7wnlNFJPEoLacXJPG0u
         YeCs3LLSzoSry+laIv6DznjJW0MXpiMeoIezQvKS8lo8AgK9GMuIMplFUhO7nLC9OIvU
         w62OleUb21qlna+5+5ZeP8wcuNu9MKJNa31vR5U5GLg+aKZbcK3arKoxdgzwyq8GJjfw
         Q8/W7GVXEb/jLMfuki3IWWEpTZ1nEWVq7ofmNT0VezYTMEUj0cf8tnOyVKF12JTzPS1m
         pp5jj31zhBI4U1G5ghO4hilL6DF0X4bnz89GmplNqglZev0aOZNeC99nVc4yHr4SBGM3
         qKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fkRs9zBV+PClpSTGvRWpGA/VZvK95GI9M3N166/B/X8=;
        b=D7parn6Spo1HC9mKy73qQtzNN85hSeJagmsIxL6HDAj68C8/ydtx+BLwbsygr0tEij
         JRbAiYpdYgLEU3DvBo3CqQupWjWuAJcOSnAzokd1IW42J4xrlnPw6u2PH5PGTjNNeng4
         MFhICQc/yvbZ7MuEhVRwGPwnE94Ern7F4hGhghSL72VLFqNGjBci8U4q5JC/mAK6Bgc1
         q02V7KmvXeex3krNw7SN19VHalrGeHDA+PgP22kmb64rNrPNL5t5/65aY0pqcQ+c7J7C
         sdeWLVkypGH6b5t81899hR3JdZ+X5LmxEa4+8WTqIP9TFM40hdm8yXTj9BdeaybOGXIT
         qC/w==
X-Gm-Message-State: APjAAAWyjmWuau9nyg3Eed74YZE/l+2BMJ2jAddyNPMYC3ucqM+QtDnk
        UK92sqwtK5VvDmuvMlBnF0GFRZrp
X-Google-Smtp-Source: APXvYqzShCVbbhEZX7rnboludkgMvunLT78RD9gXGAE2GwqngK07vcwH8VHVQDGTSgYpRwKeTUnz3w==
X-Received: by 2002:a17:906:538c:: with SMTP id g12mr66139108ejo.101.1577634591900;
        Sun, 29 Dec 2019 07:49:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dd20sm5161491ejb.59.2019.12.29.07.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Dec 2019 07:49:51 -0800 (PST)
Message-Id: <pull.684.git.git.1577634590.gitgitgadget@gmail.com>
From:   "Jack Bates via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Dec 2019 15:49:49 +0000
Subject: [PATCH 0/1] diff-highlight: highlight range-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jack Bates <jack@nottheoilrig.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Piping git range-diff through diff-highlight currently has no effect, for
two reasons:

 1. There are ANSI escapes before and after the @@ hunk headers (when color
    is enabled) which diff-highlight fails to match. One solution is to
    match both escapes (/^$COLOR*\@\@$COLOR* /). This patch drops the
    trailing space from the existing pattern instead.
    
    
 2. Unlike git log, git range-diff diffs are indented, which diff-highlight
    also fails to match. This patch allows hunk headers preceded by any
    amount of whitespace, and then skips past that indentation when parsing
    subsequent lines, by reusing the machinery that handles the --graph
    output.
    
    

Signed-off-by: Jack Bates jack@nottheoilrig.com [jack@nottheoilrig.com]

Jack Bates (1):
  diff-highlight: highlight range-diff

 contrib/diff-highlight/DiffHighlight.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-684%2Fjablko%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-684/jablko/patch-1-v1
Pull-Request: https://github.com/git/git/pull/684
-- 
gitgitgadget
