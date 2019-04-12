Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AC1920248
	for <e@80x24.org>; Fri, 12 Apr 2019 23:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDLXEm (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 19:04:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33811 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfDLXEl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 19:04:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id x14so9780552eds.1
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BsEVxwyGyoDVVV5NEmNsZmb1rv6alVm83kw4OD5W1pA=;
        b=S8FU4lfGAvhS6e/P+Lz+D6j5m0ySI9nVGsU0TlURQq3ixlC1690O6o9gW1R8ClARhT
         c/FSot311/mDCYg0QK4OJkKgfOD2kgZKCjFdhb5am4Iy81B5pFEArBWIlOW2f8YngA+p
         KAHjZtn67mdOXDztrFlo65rcAwUYnM4yd8KHe5dngWAWEC41blGo7am7vKUy3c9eQCtc
         TAFo8Zc8y3fWp/1CPHHwD6ow5AMkJtqvqGybz0pHVn49g8fqW6jbP4C/6ZqP1QmCsnnS
         k3kudZhe1SZjEM3YWSqZKMl1jnWIHN616AHkBjojWi1oKNnaRKftBc/NoA8JipdJ57+I
         LCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BsEVxwyGyoDVVV5NEmNsZmb1rv6alVm83kw4OD5W1pA=;
        b=tUpv5gTMdGwwrNeVB13LushdX3C1ess9UVlpgKCdPBLFOozmRfAgh/N7lN61UYqqLp
         fGvGoe6lCBCJXV6etf1GrIfOzkeUxHHvLzItJJa4CslRMjARdj3c5KBfVP03ScSTVi7p
         +ef9JtMGTr1byoPBExqv1dhClyFNsrDC+LcGVxSYNl/UoXSe+cd/HZffT8TxET1dreKw
         ON4Fgt/2XGitOii5nrXylc/sXC2b56MDOrJvHbapGsGpZNuNrRHps+gtjzG2/PZ+m61z
         Ua1zAvsE+CIsMQnsKpDnbwLepITOVDmljHvMcQC9RHF1wLpZXb0ywRTWTu0Ycbp4/1Dr
         O1lw==
X-Gm-Message-State: APjAAAV3D0B+F2MVmZ6QtaszmTmQjmhADGlAIpy0wV0tbduDTkTv8A5m
        Mrm2DMAXlErDu21mg+HU+aYXs9GA
X-Google-Smtp-Source: APXvYqwfcw8vAUwi3BS4pFeRA81h36AXPioIP2pPu4HphnMjKnY74kk23bNuKwlVWyCPc26LGvLo+A==
X-Received: by 2002:a50:86f0:: with SMTP id 45mr11442874edu.153.1555110280199;
        Fri, 12 Apr 2019 16:04:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm6058830edr.76.2019.04.12.16.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 16:04:39 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:04:39 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 23:04:37 GMT
Message-Id: <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.145.git.gitgitgadget@gmail.com>
References: <pull.145.git.gitgitgadget@gmail.com>
From:   "Rohit Ashiwal via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] archive: replace write_or_die() calls with
 write_block_or_die()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

MinGit for Windows comes without `gzip` bundled inside, git-archive uses
`gzip -cn` to compress tar files but for this to work, gzip needs to be
present on the host system.

In the next commit, we will change the gzip compression so that we no
longer spawn `gzip` but let zlib perform the compression in the same
process instead.

In preparation for this, we consolidate all the block writes into a
single function.

This closes https://github.com/git-for-windows/git/issues/1970

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 archive-tar.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 4aabd566fb..ba37dad27c 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -17,6 +17,8 @@ static unsigned long offset;
 
 static int tar_umask = 002;
 
+static gzFile gzip;
+
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args);
 
@@ -38,11 +40,21 @@ static int write_tar_filter_archive(const struct archiver *ar,
 #define USTAR_MAX_MTIME 077777777777ULL
 #endif
 
+/* writes out the whole block, or dies if fails */
+static void write_block_or_die(const char *block) {
+	if (gzip) {
+		if (gzwrite(gzip, block, (unsigned) BLOCKSIZE) != BLOCKSIZE)
+			die(_("gzwrite failed"));
+	} else {
+		write_or_die(1, block, BLOCKSIZE);
+	}
+}
+
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
 {
 	if (offset == BLOCKSIZE) {
-		write_or_die(1, block, BLOCKSIZE);
+		write_block_or_die(block);
 		offset = 0;
 	}
 }
@@ -66,7 +78,7 @@ static void do_write_blocked(const void *data, unsigned long size)
 		write_if_needed();
 	}
 	while (size >= BLOCKSIZE) {
-		write_or_die(1, buf, BLOCKSIZE);
+		write_block_or_die(buf);
 		size -= BLOCKSIZE;
 		buf += BLOCKSIZE;
 	}
@@ -101,10 +113,10 @@ static void write_trailer(void)
 {
 	int tail = BLOCKSIZE - offset;
 	memset(block + offset, 0, tail);
-	write_or_die(1, block, BLOCKSIZE);
+	write_block_or_die(block);
 	if (tail < 2 * RECORDSIZE) {
 		memset(block, 0, offset);
-		write_or_die(1, block, BLOCKSIZE);
+		write_block_or_die(block);
 	}
 }
 
-- 
gitgitgadget

