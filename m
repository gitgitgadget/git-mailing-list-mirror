Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFB6C4BA2D
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 23:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E848120658
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 23:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNEq375U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBZXYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:24:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43940 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgBZXYC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 18:24:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id c13so937931wrq.10
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 15:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p56gSG1dGjp/TZyIXuqzbEJiQkt+erjvlh9gz7GwWTo=;
        b=gNEq375UgCY0W4D4zf8xJdEtJFK+q+OX11PPIULf70P9xrnpl+CX+n0Iy6ppR0e9V4
         zjUH5t0cMPYuLgoIYxhOHPcBBM2gGuzomzcsNrMq2Usm1jvfUPgDzDbUKYLplT4L0JhY
         T1p+qVps+OjpjjHwnN8vsFMOSHuX5xM8C6SKzDz724QrsGAgyozBBh4LOKC9EcDHq8xV
         Qieu3FgNGNBUNK/eDbwEqfFekbXGvTpijRDp7gJI2u3DKj4vyageNxRfkoRHW29UMWOS
         SDjvV2v34UgiA1QRSb8D8F9FzFx1cck7F6ejLLwbYc71/zS29U19AMiDjhHgtgPoGpyK
         WiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p56gSG1dGjp/TZyIXuqzbEJiQkt+erjvlh9gz7GwWTo=;
        b=bEr/OXUiqI3Ukjr2Epyjd6hVwkIzsvF77a5I0s+fIOo+IdGaUMzlud/LnUop+nuUPl
         0FzYIDNGW1LNc6HsgKYXO2rg2M7aQd90oDgdqjbWd9BlK58NBxcbTK+iO4g5EShNWQZB
         UeSSIrA6WtvD293jX+dFI1l/uU/dwbXrHYPLdzuE+ECPOFYuMRH/3RxhLAQJx2RBsQrQ
         gvxDof8PXI5r/zxSWTh2RRWUDeH5i8w6JUTJ0guHRWJ2flIppyHnXzfc4a9flQJNcWH3
         WyAg+0nOFlh+pdcqvPuQ/NalmtWVn61/c3+A7ssz/V8GgSHaUW3WpOkO//iG3QxAm3wc
         ap+A==
X-Gm-Message-State: APjAAAVFWfJMVNv97gGh/6XqM5ZJy2TWFztl/vgFOqhjhx6Z7KyMWqVZ
        wBUj45W8mpXZYkkTr6pm8uAwSgaP
X-Google-Smtp-Source: APXvYqw4CFZoXxlVawH86EZw178NWhgihV0G8+wnKbyjPE13sn6XM7MYWfOwv7bwb77slr8tyQhS6w==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr951494wrp.167.1582759440963;
        Wed, 26 Feb 2020 15:24:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm5312422wro.85.2020.02.26.15.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:24:00 -0800 (PST)
Message-Id: <c40207a3928f9cbc490b9ef2e99e7cba7788e7c0.1582759438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.559.v2.git.1582759438.gitgitgadget@gmail.com>
References: <pull.559.git.1582321003.gitgitgadget@gmail.com>
        <pull.559.v2.git.1582759438.gitgitgadget@gmail.com>
From:   "Jorge Lopez Silva via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 23:23:58 +0000
Subject: [PATCH v2 2/2] config: documentation for HTTPS proxy client cert.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jorge <JALopezSilva@gmail.com>,
        Jorge Lopez Silva <jalopezsilva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jorge Lopez Silva <jalopezsilva@gmail.com>

The commit adds 4 options, client cert, key, key password and CA info.
The CA info can be used to specify a different CA path to validate the
HTTPS proxy cert.

Signed-off-by: Jorge Lopez Silva <jalopezsilva@gmail.com>
---
 Documentation/config/http.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index e806033aab8..7e704687e87 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -29,6 +29,20 @@ http.proxyAuthMethod::
 * `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
 --
 
+http.proxycert::
+	File indicating a client certificate to use to authenticate with an HTTPS proxy.
+
+http.proxykey::
+	File indicating a private key to use to authenticate with an HTTPS proxy.
+
+http.proxykeypass::
+	When communicating to the proxy using TLS (using an HTTPS proxy), use this
+	option along `http.proxykey` to indicate a password for the key.
+
+http.proxycainfo::
+	File containing the certificates to verify the proxy with when using an HTTPS
+	proxy.
+
 http.emptyAuth::
 	Attempt authentication without seeking a username or password.  This
 	can be used to attempt GSS-Negotiate authentication without specifying
-- 
gitgitgadget
