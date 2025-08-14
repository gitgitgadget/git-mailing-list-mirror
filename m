Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790B1ACECE
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182040; cv=none; b=AHr0ByxJKcx1z4V9sM/NgFjdOqVsxiLuEMzgAk47xsmZ7veWKxZ9sP2qGZImCumM7kuxOLHI2VG4LwltrYV2wWvMPxiClA0iCC2oPz6q6RQQDsCFUTvIoD1xb61GkMOUGFtN2UXDHh7KdX9YBBrSM38aMrTGjsI38qLPqiYc8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182040; c=relaxed/simple;
	bh=ILDJ4hqZKegw7rdYhrQTzKN1OR90xoIBgJSCh+vbw5U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=roiwbtcNgPVDaBdyqBngzN4fPELikDKD5uy1DmunUEjxnF/8rQ3MifhqFV7BiW+5H6llq++NOR5dY3mMewqVSsHZ9Sem5FCaFB3R3PeWK4KgSDho3tZn1B8nm5goIPilVxlGop+fWBAHyr7bJKAeP01gbowNortoc6IV14nBp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUKBISQ9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUKBISQ9"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7abfc5cso179610166b.3
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755182036; x=1755786836; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzfLdxTZjvWjpjIyiTZ0FrFoQbgrC11GlO+xNgXiCjw=;
        b=TUKBISQ9UlheC9uyLZCZRwo2ZgTZ7+GHpinLOI0a489U9nRnXIxeuJTsvZuY9f6Q9W
         KqOXum2CMfh5789jf1sgD3ErUWSJcxhwA9RiIVKsCDbTf25tlv1Iq9DQGSuLgNJ/4aa2
         g8anniGN1PdCzABfimpR2TBcOIGYlkrrYtgWa9ggcZCTDWv/FtGVqt0dQHij+hZUfHIB
         PlACSwm1UdG4R3xvAJyp0E4avPLLpQbg+PvMrQVkYAaaOXvA8Qp7FrAoA/xpvoujGSwN
         2+VzOUlHsh09+p/nUsTGob7cam1iN2f7QfMp8cYJIP8cEyib+H2/SabS9KPVp7KpCZRq
         h1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755182036; x=1755786836;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzfLdxTZjvWjpjIyiTZ0FrFoQbgrC11GlO+xNgXiCjw=;
        b=WzuGs0Wn6ZkNRVqk6T98N7do0Q/GJ1OrT0wgaaQuENDYoPwVnDN/zVA9zLmTqWaNqo
         KRpRc69JpKmxD3Wg/HARrEgXehkmcJI+GrhvOUUpJ8N83YBUFHeykoQjl9s809C6Y/nq
         JVY2JMvekFfCwqUtZKdS5vyLnmPLI3jJJ5RXzuSK1z3mwLE5+aMICp5ZM9nMTmtegQYZ
         oV+lPhCp2jhdrrgw7K9wRG0meAeo8W0ezvhl84s1sZRYt/SmWDF2zpsrpXYyXoiezMRO
         TeC+jdXS0mXeNsnIeoq2LphvetOGtNHu+FHu37WQdV7As7gDEzuE43dVkDlWFIqSk3UT
         Yi8w==
X-Gm-Message-State: AOJu0YwX/WkizYinF2dgbRj/TR0fAfmZPaDrFxZyU6D40qgF1bHGtUgP
	GJlzUTcBh7qxbh7cE0Va9leA5WBmUha+/Yj6iEBxvqQCmxVeAKeGJJa/n+0smw==
X-Gm-Gg: ASbGncuw58KKCujq/z50Y3ACUIAfw0LGx/rFZDFKe2SWvBRKsesmCwr9+9OVii07yXR
	1l483MipteRm870J+UBCA0OTUC9X27CpCrV+ZZINaXTBPO0Le1eVCH3W9yPR3JpVHtAqbtIEkyt
	Dd5UUxxVSKgxzbfPjzO5PuyydPFoTJq7kzsf4r+Nk1lWCoNIq89OFvSL8TockJN4jQwUNZ3NEpH
	2TveEUrmv4lh3FHDnbNd9pir8M+xphEPM/jhVZu3h+x5GbQyHFtjIPSpkppeoVe0MvQNlI/A5rv
	h2dpU0zonSpbA0YdcJI1EjkGpUpTwuZQcDGrh/1LyRMxU7ZzQC/FtzUQ/xzD2hulNCHFGhWXDD1
	JnrXxwFt52YWq5jP7wcMPMS47Y2DG2qbXhQ==
X-Google-Smtp-Source: AGHT+IFW9ZZGkj0FOPkvOTHEOapBz/a2uMWmskxDw+b/w+uJ+KQOzlcDDXXwed556HjLNPQ6XBvfqg==
X-Received: by 2002:a17:907:3d9e:b0:af9:b4e9:8680 with SMTP id a640c23a62f3a-afcb98c17efmr322338666b.28.1755182036036;
        Thu, 14 Aug 2025 07:33:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0761f2sm2613454266b.11.2025.08.14.07.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:33:55 -0700 (PDT)
Message-Id: <pull.2031.v3.git.git.1755182034719.gitgitgadget@gmail.com>
In-Reply-To: <pull.2031.v2.git.git.1755177382349.gitgitgadget@gmail.com>
References: <pull.2031.v2.git.git.1755177382349.gitgitgadget@gmail.com>
From: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Aug 2025 14:33:54 +0000
Subject: [PATCH v3] count-objects: document count-objects pack
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Daniele Sassoli <danielesassoli@gmail.com>,
    Daniele Sassoli <danielesassoli@gmail.com>

From: Daniele Sassoli <danielesassoli@gmail.com>

0bdaa12169b (git-count-objects.txt: describe each line in -v output,
2013-02-08) forgot to include `packs`.

Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
---
    Document count-objects -v - packs output
    
    https://github.com/DanieleSassoli/git/commit/0bdaa12169bca5d69f2c58f96cc92d51280e9e26
    (git-count-objects.txt: describe each line in -v output, 2013-02-08)
    forgot to include packs.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2031%2FDanieleSassoli%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2031/DanieleSassoli/master-v3
Pull-Request: https://github.com/git/git/pull/2031

Range-diff vs v2:

 1:  6f0394651c9 ! 1:  ab90af2b6a0 Document count-objects pack
     @@ Metadata
      Author: Daniele Sassoli <danielesassoli@gmail.com>
      
       ## Commit message ##
     -    Document count-objects pack
     +    count-objects: document count-objects pack
      
          0bdaa12169b (git-count-objects.txt: describe each line in -v output,
          2013-02-08) forgot to include `packs`.


 Documentation/git-count-objects.adoc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-count-objects.adoc b/Documentation/git-count-objects.adoc
index 97f9f126101..eeee6b9f7f4 100644
--- a/Documentation/git-count-objects.adoc
+++ b/Documentation/git-count-objects.adoc
@@ -28,6 +28,8 @@ size: disk space consumed by loose objects, in KiB (unless -H is specified)
 +
 in-pack: the number of in-pack objects
 +
+packs: the number of pack files
++
 size-pack: disk space consumed by the packs, in KiB (unless -H is specified)
 +
 prune-packable: the number of loose objects that are also present in

base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
-- 
gitgitgadget
