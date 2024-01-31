Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3C3A8E4
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741553; cv=none; b=KBUppihhowpWQIVQPYjbO4/xDu1Pniyz1t0LPspuz1t/nHbuBFZE0MuGXk3UelTWnV7l53OF0S7J5SpY2lJ5qTnEfieY5TNiazsB7+pW4B4qGiRdM68XSJvoVQakmZ/TRhxgB9nga8B73jDOUT26d4IB/XvxaOFWXF/7SpVcgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741553; c=relaxed/simple;
	bh=6fayB0pzbqY0SSuq1+LMbdKYgnZFeQDprowmSXeJY0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiDRndaFAw/cCcLUNF8HmM6ohImVv4/AULVw798JmcS9VxWttYBOEMop6cAuJ455+F4ldS+9fMvk0RtAE00mdOv5KwobKJUaZQFwMAppfbY0vwwtfO9NOpDjjzaIHB+ust0HOoPnm1VBaWHg4TgldhLxQHq6UZ11ypfHg/XmJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=u/Q+7ZEu; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="u/Q+7ZEu"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so216117b6e.2
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741550; x=1707346350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0er1k/e891E7VZYgtccUhj/xF/eCgQLRnf6QB/xQh2s=;
        b=u/Q+7ZEuvqPqVxMYKfIWDmc22jp06rrhfhN99M5S6/6xXsnDue8XBuuj7A9x3JxgYO
         GdLy3r7kPdA9NQ/UYzDS1PaU4g2j6fluE8J1V6+X+6ZV7wWSemovirFvEfH7bh4550qw
         AFKxhsRwds+RYhaW6Cey9IDOKxJqw8B21MfF1hK5GxttJ2uBR+sRjizh2gJ9PdKgVLbv
         I+X6dsUII+aKQIZs4gj/zeMqkoV20NhKJNdTJRVaYIJT1c+KJYvqSkcviU0yzwnRPnLb
         TTrSTBFC07q/dlkqd/yR4sRwUYQ3Lsq5pwAPHLu5RvTmWU7kfrd1EBio130Ab+hkEvRn
         E+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741550; x=1707346350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0er1k/e891E7VZYgtccUhj/xF/eCgQLRnf6QB/xQh2s=;
        b=WHgoCYTW2/z914CIzrnDXylOq6wAS8Vf214JQWP32qXgPOT/2fjjNkJy7gtH09m4ZK
         Q2JAUj3OKbknU8DJ42p28nx93pLOfMMvcuvIas9GLfSCVTtZzxazBnymRnp4cC/d1aJq
         4OwnQE+9dfqdzWsoTaFxslvQKXGBAUhfGOuaeZ+Fcsk/3qCebSzwUJIY0FX0UPsS2CgJ
         JeaPSlnYZ2/BuiJWld5KhhB2a/z3gmx05qQjTrYSIgODLUiQ5Ux1gk9oR4fDNNdXdEov
         XMhlhhTNUTfnUKn44P/hFbld4N2klWiMNcCMaJ+yggsmRkViMwpAluK5BahZkiaYNCJR
         nLDQ==
X-Gm-Message-State: AOJu0YxP9QE0cOAHZ+v6WZC4Y9ZpkG2DOEjjVCuWP+RUm5AOUCMD0sbd
	fXTdESD3rN4t8dxVFZHTAGvL9Wcw1GETMEbrAySxoyDJsOvX3+9D/f3dXj1AKFKfXouxeGCx+lJ
	2SLg=
X-Google-Smtp-Source: AGHT+IH9Mp7uasqrHWKJ+tDD71BNBD9C4WOfl1lGKQplzPFJbsDKYM8Yjv7+8TFH/F8PBIcYLWHSUg==
X-Received: by 2002:a05:6808:114c:b0:3bf:1a8c:75b3 with SMTP id u12-20020a056808114c00b003bf1a8c75b3mr443117oiu.26.1706741550083;
        Wed, 31 Jan 2024 14:52:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c19-20020a37e113000000b00783fb14c67bsm3192563qkm.48.2024.01.31.14.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:29 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:29 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 04/16] gitformat-commit-graph: describe version 2 of BDAT
Message-ID: <56a9fdaff02e8b4488a44d4995a25651f33ccc2c.1706741516.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1706741516.git.me@ttaylorr.com>

From: Jonathan Tan <jonathantanmy@google.com>

The code change to Git to support version 2 will be done in subsequent
commits.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-commit-graph.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 31cad585e2..3e906e8030 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -142,13 +142,16 @@ All multi-byte numbers are in network byte order.
 
 ==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
     * It starts with header consisting of three unsigned 32-bit integers:
-      - Version of the hash algorithm being used. We currently only support
-	value 1 which corresponds to the 32-bit version of the murmur3 hash
+      - Version of the hash algorithm being used. We currently support
+	value 2 which corresponds to the 32-bit version of the murmur3 hash
 	implemented exactly as described in
 	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
 	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
 	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
-	in Probabilistic Verification"
+	in Probabilistic Verification". Version 1 Bloom filters have a bug that appears
+	when char is signed and the repository has path names that have characters >=
+	0x80; Git supports reading and writing them, but this ability will be removed
+	in a future version of Git.
       - The number of times a path is hashed and hence the number of bit positions
 	      that cumulatively determine whether a file is present in the commit.
       - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
-- 
2.43.0.509.g253f65a7fc

