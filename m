Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070061624D7
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223991; cv=none; b=dch0g4WsOT2anJkavqxgByicrvdYJq6jQdw2gIN2ZwGfRmlwl3zPmmkQX8VfZfqnRhSsa6EaSn54IcavdwfZ2+YqJScWNv4pMumIanoBQEaSaBztDEnCD9Ccx64l3MkqTy4EzpEVEcYJ7HJGfwYpNevhF5xxflJqJ8vjquOngrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223991; c=relaxed/simple;
	bh=VbvTDjOsg1VxUe4KOnqpBDUhabom7CZwE7bW5n+R00o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WIpsPdUQmNKs8d5B/IdzmV/mCz3mh4Rt8lYbw5hAZGdGXtrvSNxG10o0mYNEEjAQ7AsauNlcVB1XOn31fVEx6ECRobGM82XAwDQtVGkfiSIdpo95jLw2xqjjW7lj9xgQSDr35SZq0+koKcdmLP1FO5kmwztbOnJjlasjo/mUba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XNKY95hP; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XNKY95hP"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e53c9035003so98617276.2
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 17:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741223989; x=1741828789; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVbl4ben/BiTPbJt0TsUU8l1kXvIX63MHrHfDpO9ILA=;
        b=XNKY95hPL5K/Hom01KDYvQtw4jnmCSI4tptK4sWwwpb2jNnptoaaO4KS/hUyLd/esf
         eY7V9bH4K3FCfDbbCHO6c6NfR48XIJgZ8rIJo6Gh52RYMQV2b1aF/Gg13FQzmxAB2X03
         ngQUeDqwWYwEVS98UVBjjuVaDivJ2x1llrSBavXQXQYCbbTWT941B898/ubVDufHuY0F
         K/BRBzZeoGKbfsr13ZUNFCWFZgAdbP8CG47bMI4m64PfF931AHcw/CJtj+xhmq/9A4+t
         dOIYFxAOQHSa1diyZXcxO4K2OFK0d8wGQRYGuWY6iOaDHu2R2pi35yvIfz4j/MSLT0L1
         JkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741223989; x=1741828789;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVbl4ben/BiTPbJt0TsUU8l1kXvIX63MHrHfDpO9ILA=;
        b=B+sT5KWZIqhY/kCvO5NiG3oBfxKFarzJh3wuqbAIQRd3ZpikKJ1DoeA8jul72ManHF
         aNVMuNv16YOnD4fsXfYJrVraXH9ctZqBXf66WvWQ1oyvP7icA7ol8jVgMgvxfu8IUv5d
         nvIKRZM7MI0qGyjFRDDQqxtFTbxI0RFNQMVSM7KjBRawIgp6uAK1Z6fKAzS0jtkSKNxl
         6UGA2gKmAe+4y5cymhybMeBrbdnJfA60OLdK+DI8Ciy5Dmrz+eBrNviLTNDSwmMUTbR3
         P/Y/PIraXcm3TrwkCnHD3ic6RPR2tvUt7hYSCKTmnO35/mIlW6VORQIl7OawNnHvPmO3
         a6BA==
X-Gm-Message-State: AOJu0YxPPQc3azS3P3PbdBPhsEpDnTUCwHhDGQb7/cGL0O4FaBLcAJya
	oHIo7HSwvBVHNlwiSE/sVi80BmjK/Fw3VyR0J8XmmrLMfp2azp0HKRqamepXO8dhzEvsac1cEkZ
	Y
X-Gm-Gg: ASbGncs3nTOpVqyo9vmJVNWAlzRzcet5l6Bkh6vtYIEWzKshinlrEO9d9HYT0PeepJF
	Y6E3EVqUezorhHLK7bwEKl1HJ+xpjWJ8qQ4LmdHsxmqH5WF2wKvXDTWSwWTGiDf8G607FVgCJnW
	Xf7CNdiRO0Jetr8T0CQ7zRn4lbEElirnDkZlaop+q+bhXIclUO/a8pLWGT0YJoNcY/8lrXEoMnU
	dUD50MOlwnzaufT0ogvqveMDXJHmvN0UUgVNLTKm1mliEzm3zhdNhs1tyLrtfSE4czFTSp+GM7V
	fhiBQtEBAFrm9OUIM8re8km1gZ7dxLtQUBm+DDnWGt15Y/7RCwnH+I2/EgQp5i5d3akMCXMIw3J
	XDwbWTgt2yHp7Q4Jo
X-Google-Smtp-Source: AGHT+IEPr+17FzLEEGfERslDvvhsTrVSctn9upyrPrURt+LyYY9sT6r0sRf7F1JZwdde368pyjsW1w==
X-Received: by 2002:a05:690c:28f:b0:6f2:96e7:8afc with SMTP id 00721157ae682-6fda2f67e43mr71034267b3.3.1741223988725;
        Wed, 05 Mar 2025 17:19:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a1c0dcsm299677b3.23.2025.03.05.17.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 17:19:48 -0800 (PST)
Date: Wed, 5 Mar 2025 20:19:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	SURA <surak8806@gmail.com>
Subject: [PATCH 0/2] refs: a couple of --exclude fixes
Message-ID: <cover.1741223981.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This short patch series fixes a couple of quirk's with the --exclude
feature in for-each-ref (and the corresponding low level bits in the
reftable and packed backend).

The issue described and fixed in the second patch was reported by SURA
here[1]. While working on that issue, I noticed a separate issue that
merited fixing in its own patch, which precedes the fix I intended to
write ;-).

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com/

Taylor Blau (2):
  refs.c: remove empty '--exclude' patterns
  refs.c: unify '--exclude' behavior between files and packed backends

 refs.c                  | 20 ++++++++++++++++++++
 t/t1419-exclude-refs.sh | 12 +++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)


base-commit: 6a64ac7b014fa2cfa7a69af3c253bcd53a94b428
-- 
2.49.0.rc1.2.g7e6a5e020ba
