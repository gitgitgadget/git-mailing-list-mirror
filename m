Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5871202F61
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363683; cv=none; b=CnUuisAuYlQ3y7Mtzc8oMjU7TN2xcPwRc1AxRPlPufmj1v8eIhPqrF1qoH5zGmg7hnke6tTf57Z0sHZz/NIBn8i9E1DfsnbKmSFM8IDFXleavc4JnWSybqQ/tEubY8Mx8Dpkf1RJJobTXmkA83C2E8IXj+C0+avgKaVHYH7K1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363683; c=relaxed/simple;
	bh=joMZg4qmYz2Lz0QTlg6bh5rrHnJFa9ko+IlIwy68Qiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXYmiC/SeIVu30lRjJ2eJ6YkYpkcFILXpS80TofS0oFx7780D8PeubqYBkyUhV1BRzOWAy2cndmlX5rYP0C+H90bqGNLi9Z/7QF01Mb802L65hinoIUqSJyO4pxm9LO/8Lks+LcPEKhm0JfKOsTf6OyXm5zf6h/auOuu1j+EE1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ji/X1Nnw; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ji/X1Nnw"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so73264276.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 11:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736363680; x=1736968480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rxjyTX8VFudYaSaxpA1JZ7mGErbYWSHzZV0u9GWv0sk=;
        b=ji/X1NnwUSj8Ws/JKdgKdjccR2Y8xmXlAZXXK43WHTkgxfIpWT99cQOndpbIiTwPBP
         F7JW2qMIBJtY7DPmPmSfSkW23nK9eWde8JHx6CQiTc/hs7/wQADIegL8xPGhdHHfLkHe
         zDGPkmBxdrrgqmwHrfdpoH8auUWwORyko6VfKGL6bk+4YcOGDpFSSzrHqrCQT+7DLq+z
         DNCBJ3e9gTgmOAuyovPajeJxlRC19C5YtUYVA53wpxcFDXFREjhYur8l9bhcJ+eqkTdA
         zjRQaV9Ko4wOSHQ5YyBCRb1qo+o1H62AU5a7dAHUG6FbGzWJ7JHwh0dU6ZTNRmrdhGik
         ZoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736363680; x=1736968480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxjyTX8VFudYaSaxpA1JZ7mGErbYWSHzZV0u9GWv0sk=;
        b=IlXoI5wp9+ojUfredAY3QiZPWTu4iY4VtpRhHWNWaM48nCR4BMGn8hqYDrVAd2f1J+
         1Qjc4DDzluq+70c1kHV5wWG4W30DwGU+KvPp16tiSHMm0X6LaBkbJkjpiQftN+/XIFyx
         yxiAqyppNSjUUQc6XFPQPA5xMRNNZWyjJ0+4RZEBfEPu5fRwkaJG7g2/9sx8N1uvd7ha
         0Bedu1MLhmHnkYqnugUrxFXBUz1G8lOEb8QvSc3+sBbWm+7mwQUmFT1DXuDEGOZipqrt
         lAJka7Sv7VU43mXb2mgevaqvw5l3/bvNdsrVuG82WO/sQ7HViz1rGEjSuhJV7rEb1D13
         LwiA==
X-Gm-Message-State: AOJu0YwqR7c7ZyY8ff8zst4Ida/JBOI6PNPD5EEl5v9GCDKhlnYnlJcu
	VMSRA5vho46ZNKVqKN8Ru+ks7D117ySlVqhID9EvbzrmgSCmprHK2nHlwdq/Vfi96IFPYBrUN+n
	AyGw=
X-Gm-Gg: ASbGncu/Wfsr3Sv0oL/E6WvvFn6iwNFzDrW/SGilZ1FpQlk6zQ6XMmLGzJh97Z7Qfm/
	D1ctkhZCaur1kunbCy7QLdKB7gNwfkrHESDLPDz4j4JbbY0t75lrBSWzf97dUnfoMz4htJjLaQa
	dmkCMqIND6LBeHrYF0ku+3O5dx/Dzj15HL/29x/2pJdWLFd9ly0S2aq1tkA6N7xoFxvTM8f1CyW
	DBWciwPi/xT/J6rPI1ds05AY0qKoscqJiC9iV5XuyeJWD4x3ivPZRDuJm4a27CA/AqbzbwMnB7K
	6NbnF399GbhYAKUBsKLHprNZXTX9
X-Google-Smtp-Source: AGHT+IHNtjwRX5y/Xf5rD2QTHTdgf9qpV+YdrY1Geq7WtnC0Dh5DGflaUJKDqVQDkoTVUEhw9QMmyA==
X-Received: by 2002:a05:690c:6a85:b0:6ef:6e34:6561 with SMTP id 00721157ae682-6f5312dd8c2mr35876127b3.32.1736363680574;
        Wed, 08 Jan 2025 11:14:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e783ac8csm92959367b3.116.2025.01.08.11.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:14:40 -0800 (PST)
Date: Wed, 8 Jan 2025 14:14:39 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/8] csum-file.c: extract algop from
 hashfile_checksum_valid()
Message-ID: <1ffab2f82891af8d8644443d75bd6f29bcbd6906.1736363652.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1736363652.git.me@ttaylorr.com>

Perform a similar transformation as in the previous commit, but focused
instead on hashfile_checksum_valid(). This function does not work with a
hashfile structure itself, and instead validates the raw contents of a
file written using the hashfile API.

We'll want to be prepared for a similar change to this function in the
future, so prepare ourselves for that by extracting 'the_hash_algo' into
its own field for use within this function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index b28cd047e3f..7a71121e340 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -242,14 +242,15 @@ int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
 {
 	unsigned char got[GIT_MAX_RAWSZ];
 	git_hash_ctx ctx;
-	size_t data_len = total_len - the_hash_algo->rawsz;
+	const struct git_hash_algo *algop = the_hash_algo;
+	size_t data_len = total_len - algop->rawsz;
 
-	if (total_len < the_hash_algo->rawsz)
+	if (total_len < algop->rawsz)
 		return 0; /* say "too short"? */
 
-	the_hash_algo->unsafe_init_fn(&ctx);
-	the_hash_algo->unsafe_update_fn(&ctx, data, data_len);
-	the_hash_algo->unsafe_final_fn(got, &ctx);
+	algop->unsafe_init_fn(&ctx);
+	algop->unsafe_update_fn(&ctx, data, data_len);
+	algop->unsafe_final_fn(got, &ctx);
 
-	return hasheq(got, data + data_len, the_repository->hash_algo);
+	return hasheq(got, data + data_len, algop);
 }
-- 
2.48.0.rc2.33.gaab3d23ed4c

