Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7921F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 15:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfJ1PBE (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 11:01:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52047 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfJ1PBE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 11:01:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id q70so9837951wme.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RqXObUARn9crBOzcPiCz1qqD00XTgDpJOpFbWCJE01g=;
        b=gKN4u0vxNt+xqxtBy2EbzjCJqkLif4Q5kHkdDR+/IMo8zdW1ziXKrZHCxDJuHcbkCq
         q2SmTifElnaKuoP7VrhiBWpU8RPtoS8bMoqtzfQfLJH43i67FOpi0OZYWcuO9VR/k8B9
         thDU8WCIY05Zaop+wI/itk2HNi5SSaNog+kZGhRFx+HgR/v8TuhfOojGft+svczGt3eF
         S72PSWhH+G24GZIdUZPGr5kOyrsgKt+wngtdjvlBArCx5XI42/lU9rKNtMTcSOS5cHUa
         tHAqJNdOM6vLlQAIi1ucAy8G71o05ydAByBmliNHRshdpR9Q3rxq0y6KUsmtHM/Hz0/q
         RCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RqXObUARn9crBOzcPiCz1qqD00XTgDpJOpFbWCJE01g=;
        b=absCvIbwTimtrT/uewWgKdPmw9t+qHkT2r8LlgRlzHQRF0Sv81SXvmkyegT3hpC1Jj
         IMH70M9LenNmJ4Po5hvLcUUloykGsn7VpicgQQkklpSDJLy6FLmRIdT/i/F4m+Rwn0d2
         RkheLVotxlIhwYJR+HCgxNGQXm25lBonmJHAySSOuZeIbh/VrKvLZIXm5yULZzuO9Img
         4/xLSHPM8X0OwUdzOmlEvy7TtiKLCFEKNi08DEUWFXnnKfRz6ksrrGX0xQl+vQdwX6Gq
         KyH8cvDU/Ny9gU5Y4inius9d1KQZYIo7ATaKuPpW29QzsdRijVlhLFpL3rZNaZiUZgI4
         8Jug==
X-Gm-Message-State: APjAAAU5hlzZ5LA8jbxEr4NeJyM3aNsCeuH05aVg5GXCenZpMyFGjv1I
        UPCa4719YHIEFBvNY140ns53f7Dz
X-Google-Smtp-Source: APXvYqzPJ6CrMg3uhYIo6Msbb2dEdH9vtdCIVRsgD6Sq5/oFlG2jJkU/R1+geMhX5KE3emGQi9ihQA==
X-Received: by 2002:a1c:a842:: with SMTP id r63mr340305wme.23.1572274861767;
        Mon, 28 Oct 2019 08:01:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm12426317wru.72.2019.10.28.08.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 08:01:01 -0700 (PDT)
Message-Id: <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.428.git.1572274859.gitgitgadget@gmail.com>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 15:00:59 +0000
Subject: [PATCH 1/1] vreportf(): avoid buffered write in favor of unbuffered
 one
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The MSVC runtime behavior differs from glibc's with respect to
`fprintf(stderr, ...)` in that the former writes out the message
character by character.

In t5516, this leads to a funny problem where a `git fetch` process as
well as the `git upload-pack` process spawned by it _both_ call `die()`
at the same time. The output can look like this:

	fatal: git uploadfata-lp: raemcokte :error:  upload-pnot our arcef k6: n4ot our ea4cr1e3f 36d45ea94fca1398e86a771eda009872d63adb28598f6a9
	8e86a771eda009872d6ab2886

Let's avoid this predicament altogether by rendering the entire message,
including the prefix and the trailing newline, into the buffer we
already have (and which is still fixed size) and then write it out via
`write_in_full()`.

The history of `vreportf()` with regard to this issue includes the
following commits:

d048a96e (2007-11-09) - 'char msg[256]' is introduced to avoid interleaving
389d1767 (2009-03-25) - Buffer size increased to 1024 to avoid truncation
625a860c (2009-11-22) - Buffer size increased to 4096 to avoid truncation
f4c3edc0 (2015-08-11) - Buffer removed to avoid truncation
b5a9e435 (2017-01-11) - Reverts f4c3edc0 to be able to replace control
                        chars before sending to stderr
9ac13ec9 (2006-10-11) - Another attempt to solve interleaving.
                        This is seemingly related to d048a96e.
137a0d0e (2007-11-19) - Addresses out-of-order for display()
34df8aba (2009-03-10) - Switches xwrite() to fprintf() in recv_sideband()
                        to support UTF-8 emulation
eac14f89 (2012-01-14) - Removes the need for fprintf() for UTF-8 emulation,
                        so it's safe to use xwrite() again
5e5be9e2 (2016-06-28) - recv_sideband() uses xwrite() again

Note that we need to be careful to handle the return value of
`vsnprintf()` that indicates the _desired_ byte count.

Also please note that we `fflush(stderr)` here to help when running in a
Git Bash on Windows: in this case, `stderr` is not actually truly
unbuffered, and needs the extra help.

Co-authored-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 usage.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/usage.c b/usage.c
index 2fdb20086b..4328894dce 100644
--- a/usage.c
+++ b/usage.c
@@ -10,13 +10,19 @@ void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
 	char *p;
-
-	vsnprintf(msg, sizeof(msg), err, params);
+	size_t off = strlcpy(msg, prefix, sizeof(msg));
+	int ret = vsnprintf(msg + off, sizeof(msg) - off, err, params);
 	for (p = msg; *p; p++) {
 		if (iscntrl(*p) && *p != '\t' && *p != '\n')
 			*p = '?';
 	}
-	fprintf(stderr, "%s%s\n", prefix, msg);
+	if (ret > 0) {
+		if (off + ret > sizeof(msg) - 1)
+			ret = sizeof(msg) - 1 - off;
+		msg[off + ret] = '\n'; /* we no longer need a NUL */
+		fflush(stderr);
+		xwrite(2, msg, off + ret + 1);
+	}
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
-- 
gitgitgadget
