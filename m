Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3128C33CB7
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F0D2077C
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHYUhel6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgAPQJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:09:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38842 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgAPQJf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 11:09:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so19744173wrh.5
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 08:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Rupxb/F+zMjSWq64R5cbUJIONY34r8lX6c//KyJp2PE=;
        b=IHYUhel6349VtSjBabehVwkqRegJ29eltsK1BRVeSBc2GHjyprdaQJ6jjcf3HXtY4g
         jHz7FdCPmlxrHTyMapRjJvz+pg77tCM0A6FAL7k0uHsf2gMJWbsor99f02ey/spNH4m0
         7jTvXu4FYpl41wWzTaYK+p0Ip6k/0IhzXGmtlj9bnZHRsK0B+BsWdNwtt/UYtntBV1Qw
         fS+NgY3ooMSxsIPYj6nN7hb74pImW9MgBq4uEPwOGHvePeeMx9i2s4P7AHypd8iNgsro
         Uehpvsk0N4s/BdVIe1FjuMatGIeSm8GiHQCTBTUI933RzdWL/RQGtc8uGQlux7VndPOA
         pgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Rupxb/F+zMjSWq64R5cbUJIONY34r8lX6c//KyJp2PE=;
        b=DbR2JJ8kp4ymPPquu28oOdcg9uMa5L46NvrWzGBOJ4bBNuc+0psLAi5mJRdHOS9de/
         MJuNLeL3+BJPFQutz8h4RMqQFJ84n1P4cO8KXGPx+bbE5epXh34QULfaZellg3J4UFdY
         MUq0im5Xo5/WRAKBrjlWHYrr3FcurwvYBWE/D/6dc+TDK4cLCg4Xy/GtxMIk/P7+EnPT
         F8ob9Kobguli33Kq24Fk9H7HnLbxiVbdSQuauCrbL+qmz272hSNabHPSTED7X+9kgJI/
         TG7zPIUWZY1abgSPOfJhwQwTJKGX1VTfsJ2vJ7z9O4sJNlrnCDEonumrzbklptKTu+rJ
         3prA==
X-Gm-Message-State: APjAAAXN1XoHX80srtpVKzpV3V7CirwZipR62XxjuuxJP8CRWij1BdwT
        Taajj2ZyEoOfPPSZwwmzNnHMg7Cd
X-Google-Smtp-Source: APXvYqzVdGIB0UlQEOAqle+4aa8YICVeosw/8HysATgENq9CtWi22lnRRN5lZ5ePwKmxwviBHn8ChA==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr3903554wrw.370.1579190972797;
        Thu, 16 Jan 2020 08:09:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm892090wmg.46.2020.01.16.08.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:09:32 -0800 (PST)
Message-Id: <8a5f2dbe9eef0d6fe360a8ac1130b854e73245bf.1579190965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.git.1579190965.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 16:09:22 +0000
Subject: [PATCH 5/8] doc: stash: document more options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-stash.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index f75b80a720..f5fa62dc7c 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -185,6 +185,13 @@ OPTIONS
 The `--patch` option implies `--keep-index`.  You can use 
 `--no-keep-index` to override this.
 
+-q::
+--quiet::
+	Quiet, suppress feedback messages.
+
+\--::
+	Separates pathspec from options for disambiguation purposes.
+
 <pathspec>...::
 	The new stash entry records the modified states only for the files
 	that match the pathspec.  The index entries and working tree files
-- 
gitgitgadget

