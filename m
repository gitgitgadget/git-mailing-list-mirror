Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE55DC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 13:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiJUNpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJUNp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 09:45:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC79A2A0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 06:45:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j7so4960430wrr.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+yFfarI6PAzKrBHPqA24mRpxVVnM0TMas1ZXC34qyA=;
        b=RjKMUyBW1tFPhS9P7Qcn9KM71S4J+vJ0uFAG76+/0nK1e6HIOyvk0rcSdjr33CxTPl
         QApu8TNmfHCmp6go8DFZKYrWeeuhxHtfIkBaUo6LxgFqeRabfo9Uj28LfnbkUFZ9io9R
         GE6zgtI5olu9k39ZMnSmgH3RuXc8npOxCSK7Uf2urYSmOz9yAu13Zcl4zAgVDeHF53BW
         Sb3PFBBVzS19n93DXIODxK91TJDeA2zhgGokqxHwtZZvp7eNLdoUhbHWBJv+Q1FsJv3E
         dRRGmFYi0S9ggtBSE+VeKC7ctPahvynHHDAEvpbcoFjO8X5Ibd8lgcjbmeUnUVpusGtp
         Ub3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+yFfarI6PAzKrBHPqA24mRpxVVnM0TMas1ZXC34qyA=;
        b=tvt2QHgIo1t23vbpxqRgq4xM/u06Vtm/XmGYXBmQQBNZIUnfGVoOxik3so0LqYpDpH
         SiyWzMgk78mIb1yJYL/+C+8sI/bYWfKLmDqYqIFS/lGUDRZga6y4hVWTF7r6h9FJDECi
         Gg7W4ITgKIKR40IPBbhjXhXAyJf9rf/8X+gu9PZmDEbxP2JUG1Lx8zhL6D+Ub2axuYDn
         Q7Oj+MwcTyCpaBKkYobmRRJ3HircYrpVLVPhhhf8ws0GPABQOUUDfgSQXmSJFqbna0Wi
         +OCl29J9XDzBU5BnhZlum1GBhosRG2gkO7BiMsCjRZOxuvyE2rlqvlKSMMxx74cYKsIH
         kRVA==
X-Gm-Message-State: ACrzQf1F/C2yP8D3ZK4qlpROJXnUDWbI/IneldDF6jI0F+2YGcpfAr+f
        CqGDF05hWOUzwHKOBrurN4ACYQB9m6Q=
X-Google-Smtp-Source: AMsMyM61L2Kb9GiEgWjAeG+YQ95NH/GZyaBeH6CQaxmcXTbf0o37YyaRNM613z18qwg9FzwJ5dguqA==
X-Received: by 2002:adf:a40c:0:b0:22e:47fe:7ea3 with SMTP id d12-20020adfa40c000000b0022e47fe7ea3mr11944509wra.248.1666359921223;
        Fri, 21 Oct 2022 06:45:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q124-20020a1c4382000000b003c706e177c1sm2774900wma.14.2022.10.21.06.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:45:20 -0700 (PDT)
Message-Id: <cd753602e48a2faa0d59edca2f6fab0fe753f0f6.1666359915.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 13:45:13 +0000
Subject: [PATCH 2/3] config: require at least one digit when parsing numbers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the input to strtoimax() or strtoumax() does not contain any digits
then they return zero and set `end` to point to the start of the input
string.  git_parse_[un]signed() do not check `end` and so fail to return
an error and instead return a value of zero if the input string is a
valid units factor without any digits (e.g "k").

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 config.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/config.c b/config.c
index d5069d4f01d..b7fb68026d8 100644
--- a/config.c
+++ b/config.c
@@ -1167,6 +1167,10 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 		val = strtoimax(value, &end, 0);
 		if (errno == ERANGE)
 			return 0;
+		if (end == value) {
+			errno = EINVAL;
+			return 0;
+		}
 		factor = get_unit_factor(end);
 		if (!factor) {
 			errno = EINVAL;
@@ -1202,6 +1206,10 @@ static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 		val = strtoumax(value, &end, 0);
 		if (errno == ERANGE)
 			return 0;
+		if (end == value) {
+			errno = EINVAL;
+			return 0;
+		}
 		factor = get_unit_factor(end);
 		if (!factor) {
 			errno = EINVAL;
-- 
gitgitgadget

