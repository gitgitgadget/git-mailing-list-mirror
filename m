Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF97C33C9E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 10:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FCB208C4
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 10:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMvQ9M4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgAGKDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:03:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51612 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgAGKDB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 05:03:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so18240969wmd.1
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 02:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MRA31R5rf4OqsMbjqOYB/lD50jIvhlYrz7acqRuy6K8=;
        b=DMvQ9M4p6LPisg5eqm02AhrR+GuaD6MG6BfYxtuSItL/z6dvpRCq232ICxhIqc3buT
         IGHlhZPlfXzWLQPr4NOGTsR6kJ3YtduaUbVxskmtTnTvgKt4sBpyaU49IIz5dhZvSozw
         Y0ACTb4aBQKJJXBvVOaKMRkOBl2i/CF+GVBBenIKbqFmFDCd7oObZ1csjEkeQsU4wRtz
         YJT8a4sl4UU9mwxCdkL2u+ozn9xgzjzz6eCblv0YYPpqTLKqocBaQ8ddxYXSUbBMf/W+
         vUESWVm0QRKD1GR1ZLGMdU+Fp90cLFumFUACQCxOaA44mIkwsB1W7tBD1c6AmAgxcHj7
         jZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MRA31R5rf4OqsMbjqOYB/lD50jIvhlYrz7acqRuy6K8=;
        b=b2q8MlfNdabs98d1pZ7lugchZHVy8xQuSepsj4PFJFUxaPqzTvulPa6dAWU35UlhSq
         sEUy4ZAVkoza4gCyyD77opbb5yHHwNl0HED+RO9y+yFPhgijVY5xrTOvuytWP8JKC0KW
         ed0EEADUyhMQ1BRIBJYbr/dZymSp0tJ0f8rfuVeisPtrSYpc29OOc/sKGAxLKvNYwzhE
         apCwXAWfGanmqAayAGpZArvKmrvfaqqdrII7Fr7P7h8/t9oBhHmeMO5CYgvxFhw09zfN
         b39C6bttGwnpgOp+VosKdnICi17ofPGTpNGwXrPgDlKJezAdnev6r5Y2piEt30vKNtZF
         R52A==
X-Gm-Message-State: APjAAAW3tZg5BWCbPsYquD/stjxFS11ImkHdLQAbdzIVjNR2bQqMFLvi
        j2ZXDXVMJd5JAOLyytdOvD7SMYTu
X-Google-Smtp-Source: APXvYqzoA6/KeA+3c1LTp0veJzfDVPl9q7efV2gf+Y+d/qx4aYk9o3S0CmgWpMqvhVCpXL2wMpFDuQ==
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr39391711wmm.24.1578391378963;
        Tue, 07 Jan 2020 02:02:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15sm76922678wrp.4.2020.01.07.02.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:02:58 -0800 (PST)
Message-Id: <8c96c56a1818b066d4570873e00c52d42399e3c2.1578391376.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.516.git.1578391376.gitgitgadget@gmail.com>
References: <pull.516.git.1578391376.gitgitgadget@gmail.com>
From:   "Liam Huang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 10:02:56 +0000
Subject: [PATCH 1/1] Update imap-send.c, fix incompatibilities with OpenSSL
 1.1.x
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Liam Huang <Liam0205@users.noreply.github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Liam Huang <Liam0205@users.noreply.github.com>

Some APIs have been changed since OpenSSL 1.1.0, so fix incompatibilities with OpenSSL 1.1.x.

See:

* <https://www.openssl.org/docs/man1.1.0/man3/SSLv23_method.html>
* <https://wiki.openssl.org/index.php/Library_Initialization>

Signed-off-by: Liam Huang <liamhuang0205@gmail.com>
---
 imap-send.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index 6c54d8c29d..446fd5532b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -249,15 +249,28 @@ static int verify_hostname(X509 *cert, const char *hostname)
 	/* try the DNS subjectAltNames */
 	found = 0;
 	if ((subj_alt_names = X509_get_ext_d2i(cert, NID_subject_alt_name, NULL, NULL))) {
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
+		int num_subj_alt_names = OPENSSL_sk_num(subj_alt_names);
+#else
 		int num_subj_alt_names = sk_GENERAL_NAME_num(subj_alt_names);
+#endif
 		for (i = 0; !found && i < num_subj_alt_names; i++) {
+			
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
+			GENERAL_NAME *subj_alt_name = OPENSSL_sk_value(subj_alt_names, i);
+#else
 			GENERAL_NAME *subj_alt_name = sk_GENERAL_NAME_value(subj_alt_names, i);
+#endif
 			if (subj_alt_name->type == GEN_DNS &&
 			    strlen((const char *)subj_alt_name->d.ia5->data) == (size_t)subj_alt_name->d.ia5->length &&
 			    host_matches(hostname, (const char *)(subj_alt_name->d.ia5->data)))
 				found = 1;
 		}
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
+		OPENSSL_sk_pop_free(subj_alt_names, GENERAL_NAME_free);
+#else
 		sk_GENERAL_NAME_pop_free(subj_alt_names, GENERAL_NAME_free);
+#endif
 	}
 	if (found)
 		return 0;
@@ -284,12 +297,22 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
 	int ret;
 	X509 *cert;
 
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
+        OPENSSL_init_ssl(0, NULL);
+
+	meth = TLS_method();
+#else
 	SSL_library_init();
 	SSL_load_error_strings();
 
 	meth = SSLv23_method();
+#endif
 	if (!meth) {
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
+		ssl_socket_perror("TLS_method");
+#else
 		ssl_socket_perror("SSLv23_method");
+#endif
 		return -1;
 	}
 
-- 
gitgitgadget
