Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BDBC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A6B60F5A
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhKBPtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbhKBPsz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:48:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4B8C06120D
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 08:46:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t30so9168166wra.10
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oUOtW+VMfF77w6KugTIk7kk1SNVq3GaMJS9+jVTFH/w=;
        b=pcgwjTqfpujds5kEDC67I4fRtQRc+xn+3GLP13J3RBz3vmSErEhpvR+UyE2sBGUfcl
         hT2qQFOC4DhlrSlRiWf/S8Nlc9RBXSiueZ5aTkQJON4FuRSYc1mHGbUqL0Rw4kCEyjcE
         xMa95F/jiTpeeJzcLNxmJeYg2qCiWRokHW3x9LTsJw8hApCEUp08DS9Pgj/KPYngfZYs
         Wt5x2e9R/jKs0QQE7SVd5LiDlJbgmREWpqe5cyBlolUOaXNLqeo4mg7Dx9Ia90BfBFDH
         sScjdR5oQkE02Fq3Mn4EWdEHH/sr4xt3lMkWnrq5wcRtcyu7YVcSzI1eRHpQ4oQvOPzA
         10wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oUOtW+VMfF77w6KugTIk7kk1SNVq3GaMJS9+jVTFH/w=;
        b=BeB6059zshronmYZPTZTtVpLYXqiqBSHogI6BZ5Mhfk9sk1+GbycC4Mh/4tMUnzR+S
         xcaixg/u/YA/bk44g2gkmyAS/2hNst4FdHAuhPpO5TtFmK6IWMX4ebxtoG22Rzg2Gh9g
         lo0aoBl4C0zoiMDd9cValL/jkxkByGEWcaG0p37tfzX+jKakoAJlym3sHwlf/HJhTrnM
         J9HjfWhtsI3hrsqUx4chf89ZjzKsU7YcF/koDKuiANhNtPG+5eE/lAdYIZXXqTNU45Lq
         Z1A5aEyWzr0ujW/gc5BZCfXl98H7v6v8xImTSGry6BO4lXvOeGybhHjeViBpXMILkiT4
         DkbA==
X-Gm-Message-State: AOAM5330XlYUKioNOhQUyDEpqKPUzadzTL11Xoth1cHMxX7irKVIdnVX
        DCH0sduWszkUm2NdgTvily5byM8ocD8=
X-Google-Smtp-Source: ABdhPJzzBkMQVPWnh1/FdYd4FfCVCNyl9xXfLEQhUu5UpLNiQ5GajBuO/SzfFiXNxg9L29MTHXpt7A==
X-Received: by 2002:a05:6000:154f:: with SMTP id 15mr35522306wry.74.1635867978186;
        Tue, 02 Nov 2021 08:46:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm9304977wrq.29.2021.11.02.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:46:17 -0700 (PDT)
Message-Id: <7b6655f03f50925747fa9870333bab39a690d3f8.1635867971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Nov 2021 15:46:10 +0000
Subject: [PATCH v4 7/8] odb: guard against data loss checking out a huge file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

This introduces an additional guard for platforms where `unsigned long`
and `size_t` are not of the same size. If the size of an object in the
database would overflow `unsigned long`, instead we now exit with an
error.

A complete fix will have to update _many_ other functions throughout the
codebase to use `size_t` instead of `unsigned long`. It will have to be
implemented at some stage.

This commit puts in a stop-gap for the time being.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h       | 6 +++---
 object-file.c | 6 +++---
 packfile.c    | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/delta.h b/delta.h
index 2df5fe13d95..8a56ec07992 100644
--- a/delta.h
+++ b/delta.h
@@ -90,15 +90,15 @@ static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
 					       const unsigned char *top)
 {
 	const unsigned char *data = *datap;
-	unsigned long cmd, size = 0;
+	size_t cmd, size = 0;
 	int i = 0;
 	do {
 		cmd = *data++;
-		size |= (cmd & 0x7f) << i;
+		size |= st_left_shift(cmd & 0x7f, i);
 		i += 7;
 	} while (cmd & 0x80 && data < top);
 	*datap = data;
-	return size;
+	return cast_size_t_to_ulong(size);
 }
 
 #endif
diff --git a/object-file.c b/object-file.c
index f233b440b22..70e456fc2a3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1344,7 +1344,7 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
 				       unsigned int flags)
 {
 	const char *type_buf = hdr;
-	unsigned long size;
+	size_t size;
 	int type, type_len = 0;
 
 	/*
@@ -1388,12 +1388,12 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
 			if (c > 9)
 				break;
 			hdr++;
-			size = size * 10 + c;
+			size = st_add(st_mult(size, 10), c);
 		}
 	}
 
 	if (oi->sizep)
-		*oi->sizep = size;
+		*oi->sizep = cast_size_t_to_ulong(size);
 
 	/*
 	 * The length must be followed by a zero byte
diff --git a/packfile.c b/packfile.c
index 755aa7aec5e..3ccea004396 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1059,7 +1059,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, unsigned long *sizep)
 {
 	unsigned shift;
-	unsigned long size, c;
+	size_t size, c;
 	unsigned long used = 0;
 
 	c = buf[used++];
@@ -1073,10 +1073,10 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 			break;
 		}
 		c = buf[used++];
-		size += (c & 0x7f) << shift;
+		size = st_add(size, st_left_shift(c & 0x7f, shift));
 		shift += 7;
 	}
-	*sizep = size;
+	*sizep = cast_size_t_to_ulong(size);
 	return used;
 }
 
-- 
gitgitgadget

