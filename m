Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DB14B941
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906612; cv=none; b=IugOlhYS2LoL/XB1z1hMOaF0y3i3PtEvtIpmLyUX91zhB+BU9SBz4u/f4Ra6ZPXnsRlFg+Ld3O+g3Mb9rgZ0bFWyLFTRtk1lB4gfUWZWxjL3ve0qOObC/3AYmX+Hx7f3e/A55FMGOEdfvk3F0gNzFPjZasFo9nFcS6nVOf4Kdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906612; c=relaxed/simple;
	bh=lbxxZWov7krDvfRPREguqlu+nMVALJZ1VvdGFEKSvag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8LCRTt3vFhzuBipFiF5FGsv4GfNwVEyQ/0TNZyRx3Z64A2FdrEhf2xhcGNI0tCD7kLouG088LFs6trvHmu/3ol4geI5IEhKaCSjp0vNMk6wm1UxejjdWP6DNpEsf+oIQjmeSSTuQk0aZs12EEvkhJUIRetQngw3SEkQROhUpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCueunpB; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCueunpB"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d55e2e032dso2338288b6e.3
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906609; x=1720511409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SjjoWcrN9Uaxxpmx4FAHcpdNLcALiOKRRA5v3KYKuc=;
        b=bCueunpBC3LH60VfepbGLT0tCbC8wB8niWTwyNscICLVdaEHrIn/dwut2wgpnUWadV
         QsR5psYG24GzaXQI33xWf/eueLu/evEb1CxccEJAKZJPy4oQo4wSeq9tdTpZj3Puqupo
         u4mCi9xsXkQZk5KFm66FqWrZ70PyqnF6MWW4wSRqqROQS41RSLnpALCBLpoUcSbgOPYT
         dFqZOAps+EEoZuApnp/K7qMSaUtr94MnDFnID3fhCg5k+WIb9HUGTCuDaE00THasNvks
         YvYqqomNaeJkv71tTz15gksxfYowBzWvY1G8+jHUgJU3/yxNfLVanS2UqQEZ3DAqY6gC
         hOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906609; x=1720511409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SjjoWcrN9Uaxxpmx4FAHcpdNLcALiOKRRA5v3KYKuc=;
        b=oVfwA98ug54QJYdtj/v4YPGg6g7dN7+m5K4WGtUMxkk1sLKzXNtkSjP85kjkAiz4xY
         379Ip1dtaZzlshIEw5aGS6DDRRLmH2BGHXT0WV710vVVwzGH62uxAeRMtBrS9Rvwqrbd
         eunnj0WFbiBPy7xx3jKxQjP6lHn/SA4TSyGAL65pC0lGX2s1x/+26iT+tbgQKS5/Awmm
         6CJ0+Rkyg8l163rrleIEH0YHIG6/8O3ARKBVaXqlpfMqM66yF4FJHVf2Vg2p2+TotB9M
         eR2Y8KccSWx3JO0RKnIwyhrw+SoC6ZDeIE32HCj3mQbpbZutlP2mg2hwXrJDnOVn1H2n
         p/eA==
X-Gm-Message-State: AOJu0YzaAxUhwzLFuohfm/oaFHfwtlKdVVVLBPfdFL2WLUBJE3FYoSzO
	mb5RUR3YCOfJDQT/0Xp3aYRO6lsT7w0pDRFmm4poQhkN94vhZJTBQFSIEN7Kqzk=
X-Google-Smtp-Source: AGHT+IHvG3JrcHwEdt/leAnmsECLZhsOGTXm/5CNWQQSXWi4cdwGc71iDTgc8QNopJrsauVbyLmkbQ==
X-Received: by 2002:a05:6808:1408:b0:3d5:5fbe:b31a with SMTP id 5614622812f47-3d6b55925e4mr11968397b6e.51.1719906608922;
        Tue, 02 Jul 2024 00:50:08 -0700 (PDT)
Received: from Ubuntu.. ([106.206.197.80])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm7772626b3a.161.2024.07.02.00.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:50:08 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 08/11] t-reftable-record: add obj tests for reftable_record_is_deletion()
Date: Tue,  2 Jul 2024 12:52:21 +0530
Message-ID: <20240702074906.5587-9-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240702074906.5587-1-chandrapratap3519@gmail.com>
References: <20240628063625.4092-1-chandrapratap3519@gmail.com>
 <20240702074906.5587-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_record_is_deletion() is a function defined in
reftable/record.{c, h} that determines whether a record is of
type deletion or not. In the current testing setup, this function
is left untested for two of the four record types (obj, index).

Add tests for this function in the case of obj records.
Note that since obj records cannot be of type deletion, this function
must always return '0' when called on an obj record.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 6ece76e416..1b52085f46 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -384,6 +384,7 @@ static void t_reftable_obj_record_roundtrip(void)
 		int n, m;
 		uint8_t extra;
 
+		check(!reftable_record_is_deletion(&in));
 		t_copy(&in);
 		reftable_record_key(&in, &key);
 		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
-- 
2.45.2.404.g9eaef5822c

