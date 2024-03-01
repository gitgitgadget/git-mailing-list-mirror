Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99F3631
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252092; cv=none; b=f8ZF0u1wQ8P0vTVVqodQLmXGGqqsYs9PBuPPjlN9pC78jSbS9dtrNwJhqEQnaySjaNWz5rdMPgZ53zIhGuL2QzrV9MmOeZ8+iGISQ5aKfm2jCmo93ccdQ40kPScJYkdhFHjkS2h+VK66C3ki3RZiGN2gnOOi7RSOTEHuT1EFPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252092; c=relaxed/simple;
	bh=VtcouaHw6ztbGb3EWtk4zEbxwTZdAZDIvLKHObqns28=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GGh9jvvbrT5ULnglC4PVD554kA5RDwCoxu52+zfKl99UzDg+73BYs3g58swWu4ZRzdIWFXGwC934USu3SKVb9XdLchRTiwroLjLH4RGsD9mgy6Hu/Ma1T9iwvBJriUjEK69R1aURRfB7MqpYfTsCy4v4zL8/XRL6/Xbzq5Bd2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwPAtIJY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwPAtIJY"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d61e39912so733696f8f.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709252088; x=1709856888; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNGSXY0lACUj57g92wZ8kTjwAhEGXfhsU6tUIWHtlMI=;
        b=YwPAtIJYi1R3Cr1chA+igQSgEVYNgxG61MeQb/tBnMXDyXZ4WgxKN8dpfdjUFJjREM
         AVY0hepwQDGlGt88xEWrGyamRx4K8sOPWfP21xjCV5ZeDRUPvz4ZihOwT83f0Ab2e5Eh
         V95F7L+tBkthwh8P7OoQNCU7Q6d6IZg9B+U7D1VO+eU9D0kGBCKxObIQd2nQHjCey7Rc
         JJUiwqXCD/vTiS/04GCgslBZUUzXDkq3VnNSYCGorI3l1qJG2HQuXMiqzAw9eCb+Fwn3
         uj/TmNCMPu3RiCL7kdrbY7LpjM5ulkmfGKOUVT5D5G0WX3kzm+kBiWaQJAofNBNibr3K
         Dwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252088; x=1709856888;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNGSXY0lACUj57g92wZ8kTjwAhEGXfhsU6tUIWHtlMI=;
        b=pemBMvOl3X7O8TAjlkZVBIJK5URUeTl46wYQhWcmQkj/wigMcxyZkQHPOIvq+fo1s2
         zlAopsZ6eK5vaQTkP2lNPhvPT8IUYc+RnqSAQenLS069Q9PCDEgai7CAxpR16gv7KJYH
         qBFPqZfsBsEfumyU3VljWOD/yNzDUHgjUfIrEqddhChszBKITwWUdjuEPPFQsJp7rt1U
         j85nElFHyVA1Z06cXdqF35aozySXHhAELALXkqURWLHIIvzDis9pIqT5m9CpTfmo3LIK
         whptAY06Y2Cm0xDJD5LklZWOcMRSKbJUoh7127BwyITOaz5W+AE7RpvH5BTQH/0r5WEC
         igGw==
X-Gm-Message-State: AOJu0YyWBlhUfRjQ6RPBRkI7KEg8KOZVlRsLiJDTvBsXiMm8Rhfh8UHJ
	My4bEDhKaHjXZTYHORW3wgeuI3autzwonUmQBFHrlHmrynniglACm1MnTCpL
X-Google-Smtp-Source: AGHT+IHbhtQUPLo4alJnaYtOc94s9dIgkZmcwQsaZZy3yLclfzHkKj8TqOXUx3YTAyAVX6+5syDbpw==
X-Received: by 2002:a5d:59a1:0:b0:33d:f719:83c3 with SMTP id p1-20020a5d59a1000000b0033df71983c3mr103716wrr.34.1709252088492;
        Thu, 29 Feb 2024 16:14:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7-20020adf9c87000000b0033d640c8942sm3029263wre.10.2024.02.29.16.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:14:48 -0800 (PST)
Message-ID: <652df25f30ecc8227bef5109b0f7b47817386b13.1709252086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 Mar 2024 00:14:38 +0000
Subject: [PATCH v6 1/9] trailer: free trailer_info _after_ all related usage
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

In de7c27a186 (trailer: use offsets for trailer_start/trailer_end,
2023-10-20), we started using trailer block offsets in trailer_info. In
particular, we dropped the use of a separate stack variable "size_t
trailer_end", in favor of accessing the new "trailer_block_end" member
of trailer_info (as "info.trailer_block_end").

At that time, we forgot to also move the

   trailer_info_release(&info);

line to be _after_ this new use of the trailer_info struct. Move it now.

Note that even without this patch, we didn't have leaks or any other
problems because trailer_info_release() only frees memory allocated on
the heap. The "trailer_block_end" member was allocated on the stack back
then (as it is now) so it was still safe to use for all this time.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index 3a0710a4583..e1d83390b66 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1111,13 +1111,12 @@ void process_trailers(const char *file,
 	}
 
 	print_all(outfile, &head, opts);
-
 	free_all(&head);
-	trailer_info_release(&info);
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
 		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
+	trailer_info_release(&info);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
-- 
gitgitgadget

