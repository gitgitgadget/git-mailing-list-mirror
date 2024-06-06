Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12993BBEA
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699263; cv=none; b=MFWhLYmMyyvvoa7FQDYllAFnYQf2JbmlibVz9NiGTBM4fIj05e2E22D5nsqgCntDdKKGRbGZwC7HT385MHAUDRwVPv13ZhYAqIQvrddICWlY4REEsL6pVpY/ozusTel352BWyoZQtLHPuQn2fq5G/okAcOJIE43NFSyIlWKpuIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699263; c=relaxed/simple;
	bh=ZvVm55J8OBlCSLEOBk9jtny6d0QjRwaU0S0zGjxlXZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ix5AHoPQurY1MkveIriSMymjfVSBI+jX6O5tjopml6Z3S8B9JaljzzWCt6tDJsEJucReR/UrbdCICyhdlmuDnymEMympL0cj1tO+PZrs6lSP7zY/SDxV2c4R3L2/hIE/iAkgdQlj1AF1FwfgHIuxrweRvXytAfqSLiCfFwK1Fcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GjTbkuyr; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GjTbkuyr"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so7295136d6.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 11:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717699259; x=1718304059; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXwMpGDE9tQyW7crVZLyWDujYP5ONZ2CYWH0zJaqjLo=;
        b=GjTbkuyrv/8NMN2hWDxAQclYMKRKYLjxBQYIbFudXjYBzzIJHax1REgmfRUV8yG5BD
         jLb/do8jh8ZnSDwfZLwSO0SWlXrBa6KNIXzU8iWSkZNNIlofDgqBa3Ndzpw6QRQt7ES0
         8vDjaoXNjME1TdACIi1GMyJW0hAminksia6qXjv5gOphdjyYW7xOw9IeRPFdQAfIAZ8R
         0rm7OXI5KgTU/nt2DmoPzgXiigTJIyiCsofjD+PVlJNfPpmnHh76t7pnvt6MLpqVeSKY
         nOH3bypGJN9ijETk86Hae9K2kKbby0urwcq3d5I+LaXN/qIqL1nXh6MWmOJhk0bZgLpO
         fswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717699259; x=1718304059;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXwMpGDE9tQyW7crVZLyWDujYP5ONZ2CYWH0zJaqjLo=;
        b=KAGW0CJzNFv5O6uHPOlwb6O1f6a5L34wwa64UU7etUT9jPo7JjYBE9xa3Kn/JEGguc
         GYFBOAFpc6CsuVshgSpvKVnHKfvNTsRZUsOzihL1w2CJZZrP/pdWZG+h2g+UdBhYQijK
         4eyv+yHX6rJ5M1lYs932MrYck8lzbwEq4K1UhorAlZbrNCQxWqSyct5hssFT5vp7dTND
         svAco5sLu1O+AmkEgq+22BwH/UDA/YUeoQeeG7FT9o3RSFVuzFPn89deqAU2+Cr+dU7t
         5KXpOq3jfaopveGNjviB3oH+IeKZ7vz+IbAY6sQL7k4Ae8HJMFa+QHTbyiHV9UZJWhMI
         zGFw==
X-Gm-Message-State: AOJu0YxWTnFhVR9PVLKqgYWqA9U5mRVEjHZ1WkQw4YhqXSPNhdJaOXLy
	jxBPn9dYDvqFRjRQXrGQ1B1wX/yijyYsGHMaTYmnytRhr4KahaV71SFLBHSvnLh9Fk0g3IF9BzO
	YuGo=
X-Google-Smtp-Source: AGHT+IGeAtXxkjfQSxzBdcQyStZyDwE4VPIiPvoz25TVoshDikALxlzxNnP1iczq6m2sp6Fdjtrdmw==
X-Received: by 2002:a05:6214:5982:b0:6ae:497:8738 with SMTP id 6a1803df08f44-6b059bd6c2emr5175556d6.29.1717699258925;
        Thu, 06 Jun 2024 11:40:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6213basm8720046d6.7.2024.06.06.11.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:40:58 -0700 (PDT)
Date: Thu, 6 Jun 2024 14:40:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Documentation/technical/bitmap-format.txt: add missing
 position table
Message-ID: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

While investigating a benign Coverity warning on the new pseudo-merge
implementation, I was struggling to understand the (paraphrased) below:

    ofs = index_end - 24 - (index->pseudo_merges.nr * sizeof(uint64_t));
    for (i = 0; i < index->pseudo_merges.nr; i++) {
            index->pseudo_merges.v[i].at = get_be64(ofs);
            ofs += sizeof(uint64_t);
    }

, in pack-bitmap.c::load_bitmap_header(). Looking at the documentation,
the diagram describing the on-disk format (prior to this patch)
suggested that the optional extended lookup table immediately preceded
the trailing metadata portion.

If that were the case, that would make the above code from
load_bitmap_header() incorrect, as we'd be blindly reading into the
extended offset table.

But later on in the documentation there is a description of the
pseudo-merge position table as immediately preceding the trailing
metadata portion of the extension. And indeed, we do write the position
table in pack-bitmap-write.c:

    /* write positions for all pseudo merges */
    for (i = 0; i < writer->pseudo_merges_nr; i++)
            hashwrite_be64(f, pseudo_merge_ofs[i]);

    hashwrite_be32(f, writer->pseudo_merges_nr);
    hashwrite_be32(f, kh_size(writer->pseudo_merge_commits));
    hashwrite_be64(f, table_start - start);
    hashwrite_be64(f, hashfile_total(f) - start + sizeof(uint64_t));

So this is purely a case of the diagram being out of sync with the
textual description and actual implementation of the format
specification.

Add the missing component back to the format diagram to avoid further
confusion in this area.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/bitmap-format.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index ee7775a258..bfb0ec7beb 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -312,6 +312,15 @@ the end of a `.bitmap` file. The format is as follows:
 |                                           |
 +-------------------------------------------+
 |                                           |
+|  Pseudo-merge position table              |
+|  +----+----------+----------+----------+  |
+|  | N  | Offset 1 |   ....   | Offset N |  |
+|  +----+----------+----------+----------+  |
+|  |    |  8 bytes |   ....   |  8 bytes |  |
+|  +----+----------+----------+----------+  |
+|                                           |
++-------------------------------------------+
+|                                           |
 |  Pseudo-merge Metadata                    |
 |  +-----------------------------------+    |
 |  | # pseudo-merges (4 bytes)         |    |

base-commit: 0b7500dc66ffcb6b1ccc3332715936a59c6b5ce4
-- 
2.45.0.32.ga71ec05e5dc.dirty

