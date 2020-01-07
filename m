Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9781C33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 10:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F00A2075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 10:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQUuRiBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgAGKF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:05:57 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:51827 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGKF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 05:05:57 -0500
Received: by mail-wm1-f53.google.com with SMTP id d73so18251864wmd.1
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 02:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P6TCu8nVVscBevb0h7IIlq8yNl31M1BC6tYeu0T//Pw=;
        b=pQUuRiBp+AtLXi1zrVCIG/lSu4pdd9kf7EuVcywntgrMf3pnGxmjLULlnmvzPvntms
         uQaWzK2EUqUZu5Ri8MYwnrAEumsPqwclG8YmFPljq3RZdLultvYs9CAW1anGIOmb1D10
         kdYgh5O32Vl9kiKecRWkuXJpqgzn4PACscPETP2POeP87pJwYrm3glkP/oKqP4rtPgbu
         YMxhu8yCCxd9xZPQHT9kP0ZuRrzhCRyCwk9mJvOFlkbtEhBHeava5I+XDwO4BcQvJAZC
         mmbrd+zR3BGv5qGPjBuWQ5W8d4JcERxJbElaUjJqXuDjwIPOJqngN2J6oF3k1rV1TQXp
         XCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P6TCu8nVVscBevb0h7IIlq8yNl31M1BC6tYeu0T//Pw=;
        b=mIfhQNZJ6/HauncQkpY5BHL7W8WjJ4oL/lycwTWnfr6fkhCfCfrHn1VhHhFhr53rpK
         ymDmUdFLRefWmF6Q4l+ZK0Jjgwnl/oOIzuNvfX5ZTpsyv7HEfJqWt1LmvNv6F0TjFSRG
         EM0QHLYvCQHpNSzc63yQACfrOdu9enwB56vPLSecyyPTSLI5kZK37SEey0NzClVOIEmt
         egKTEqoJxlqweyiIK2AeUw6Z2Fk5WsPFtDLOMXyhoKx4iscolTXYVYyUEqjZ1UKtPH15
         OTW01MBIj4Ya9ed6haQH3R/kx4ixCuZM1kAedTdCvpG5zxVnSkJ7RPAOF3Kk6Aj38YzL
         RenA==
X-Gm-Message-State: APjAAAX4J/+/5gmEQD5sucSUS1u+rQ9KHLgt7PjRty/2vW6tXUPkISCo
        lQvbDXiQNEmBqZRIaUvKgKMzF+Ae
X-Google-Smtp-Source: APXvYqyFaciP0icH62b764FGfR2C3yesKJbOrjhnqgVW4386yvDit+PwkDvkXEsxEFyNHPo1MPzKXg==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr39860855wmb.0.1578391554543;
        Tue, 07 Jan 2020 02:05:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm75962949wro.47.2020.01.07.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:05:54 -0800 (PST)
Message-Id: <ee8636e0ed40888b2a132cff2dacc97754550ba1.1578391553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.515.git.1578391553.gitgitgadget@gmail.com>
References: <pull.515.git.1578391553.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 10:05:53 +0000
Subject: [PATCH 1/1] doc: fix a typo in gitcore-tutorial.txt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/gitcore-tutorial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index f880d21dfb..c0b95256cc 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -751,7 +751,7 @@ to it.
 ================================================
 If you make the decision to start your new branch at some
 other point in the history than the current `HEAD`, you can do so by
-just telling 'git checkout' what the base of the checkout would be.
+just telling 'git switch' what the base of the checkout would be.
 In other words, if you have an earlier tag or branch, you'd just do
 
 ------------
-- 
gitgitgadget
