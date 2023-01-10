Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65DBC54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 09:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbjAJJdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 04:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbjAJJc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 04:32:57 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4A213E1B
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 01:32:56 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bk16so11036430wrb.11
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 01:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACf6fefE0hM+295x6h7zJ/I19Jh8BMiq9aVTlbS7n3k=;
        b=ZM+9Vl86p9htNYfUv1jKPFr7vVawdyHWzirJ/9LQzSRlll25dcVGxObUgRgSFfLor0
         Ls8ggVIWE1KXof7Zpr003h0xdrwJYfP88wZfhnOCGKzIQazsOW0PxgtO+TkWs8EHzS/W
         KmDlKKgmbR25nuFrlW2WFQaAkCgZVhwvp8PUwwDld6/BGSooB32w84P7Pri52C6KNYCQ
         UaoQDcLYMnWzs/ZnZMG0K/wggpULHwlxorJtQp2I5IwrHjxjMytPfxa2ZUqlOcwHzlmi
         DJKWYQmfLoDKRLSJCiCuygeChSZxiYcletxz3aguevfBGdc5CQHaWXekbSD8O1KSSSHi
         Ls9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACf6fefE0hM+295x6h7zJ/I19Jh8BMiq9aVTlbS7n3k=;
        b=OuQT1Osy1mcO1GS0gDXm5pY431qBAkv7w6iMBQZPPD+k24imUl7BP/tsTk6e/5PYlg
         xld/CveAcXYbXKcMID7zg9PqC6p4KZrJHbWVJCmQfTvhwjPRd7TTp8gIs2UcoysDukT7
         N/MwLV/BTy6IAjzfVLf5EjCf5rMpavsJgseQtiBzwvzHkUoHnNhGFNYMqwq6miwviMKA
         L/yAG8uYfT0vJ37xciBSuC2gaYp8Th51dT1bVgeadlq2aser7/jTrblgW5S2trn5Zp8F
         fVa3pLnW/9Tj9xj/CNXeqJHsTaBuU22CiZ4FG2BTjAbkrmOU3J5F7eIoDrPjofhmJuHd
         XfPQ==
X-Gm-Message-State: AFqh2kqhtfbeSUo7j4xB2e4F3kYlJeZv4cVpzDZRuik3jTtDsjNJoqvD
        RU0QfX9H9vwwAIixHfPJGRgb0K33/z7hOwrp
X-Google-Smtp-Source: AMrXdXuDK5W2nfjK+8mPbjcj9xiNoLlA5hjMaBAZB2dbu51RNu9llcmvAfOQDkqx2jh1NQc0LRGdig==
X-Received: by 2002:adf:cd0a:0:b0:2b7:26c1:e81a with SMTP id w10-20020adfcd0a000000b002b726c1e81amr10804585wrm.25.1673343175074;
        Tue, 10 Jan 2023 01:32:55 -0800 (PST)
Received: from titov.fritz.box ([212.102.57.75])
        by smtp.gmail.com with ESMTPSA id bx9-20020a5d5b09000000b0023662245d3csm10729071wrb.95.2023.01.10.01.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 01:32:54 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] update references in git-bisect-lk2009.txt
Date:   Tue, 10 Jan 2023 10:32:49 +0100
Message-Id: <20230110093251.193552-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230110083801.186789-1-rybak.a.v@gmail.com>
References: <20230110083801.186789-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While double-checking the patch I noticed that nist.gov link is also dead.

Changes since v1:

 * new second patch which fixes nist report link

Andrei Rybak (2):
  git-bisect-lk2009: update java code conventions link
  git-bisect-lk2009: update nist report link

 Documentation/git-bisect-lk2009.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.38.1

