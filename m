Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324793ADB9B
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321927; cv=none; b=Aut56jTP6r6dInytTen8zpuMOB62JZFBG1VKm3Eb9W5Rrnc+HbWhgVX7MFPujnC3kBWoPY5z+GtJB2fQuh1ilEsLeSVB4sePol74Su9yxB2mryaDrIpmF36e4/xEfACSWLVehRPXFAZKzPL0sJNXgjmBb56LbY31Nsaiew2Mvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321927; c=relaxed/simple;
	bh=WFnkgr+3w+x0/dy1IKLrvw0dFUoQmqhx6Gdo33SBQaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMCDR4aMsDkZDphoZGUKrNiQxXwdaUn9gyT9louS5MM0ZZzi8KG/qHajfnQjGZZo912Hwo04ul0MHMw22ODLRj8QRoTIQG0qJdRXmxkACfwNTSBchnc57n9j5CgD6mNYE75/p+fauqOUbUOu1B6OgbXsSj4BjShSdGwbS8IMy9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwDCB/rW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwDCB/rW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso92903665e9.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321925; x=1780926725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3cxbjhqwQr/k79HUYAmg378Pb9YmuKi1j2kOUBGqxc=;
        b=LwDCB/rWTq0GyF+TAWkAgKNFIxvRJNcm4gp4OfqC7mzXmmbBorDrz9DmPHgbZCrP9i
         gKAaDy0SUXbbh/cgys8SPYrEJtS+v3eHyM4UB7+jc4QR/cweJgM9l1Qtq7dUiY63nMYs
         O0mIk4gwb9HIAVo8jH8IE58dOaVB1sGwHG9+QkcSZJglHO4dB3qBT8AJEmW+UIZkjDDu
         t7PyTBePIvQVZwtt0TvULjid/paHb9OyAKbct53mx4F4fTGUHDlt6bxfXUmx+FBijtvb
         EZbeZo+z+/XlQLBXmFwilgpyOSXZCoZexocSqVSSGG9r/7lnKn34pgtdnE4/CRIsHfxK
         srug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321925; x=1780926725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3cxbjhqwQr/k79HUYAmg378Pb9YmuKi1j2kOUBGqxc=;
        b=Oxt41GH6MJFS64dDmU4xa6fa1Iz+2EnLJHUwhhG+jFOTReIr4TtByyRXobCouBdoX7
         W1lupZbDrcSSt5YFDybsxFdT4cEi5LCvsjCgNi4fJRrZBWIRXap+Qd3x44Xv6FGlW1Y7
         M0qbjJu/y1qZgKQI7rnA4xS99193TSXG3k8680vxNucNCOn1cIj4Je86zSKF4qWn6yvl
         PIr3dR9j8wNC1Lxe7k3W5f5V3F1tCEo5N3XJv9trPTwvNv74ZSerIdck8DPd2x/X822E
         6uVD9ISwJMrKHR6IfojQ8QuXI90UC+n023it0Uu4vtEe7Xw3vEHgYlBRDM6lvLLKKFJH
         9GOQ==
X-Gm-Message-State: AOJu0YzUZjPivFhR2vGybKdUNf6C2kG6f+se0SqOO+ik7b/Qz/7BsmZl
	/CQgEVQIsy7pHemvaEKJxqybYYDyggD6uqIbeD/U9duF5XVyP71wmnd9No5yEQ==
X-Gm-Gg: Acq92OGI5X7v/dlYA/vGJ76GnNLK0yQs6wI6AzvynAQig4BV1iw7GCeqegmTN8OAuZ2
	Av4rO7TUuQE7DqsnXq4dSLYvlnRwvABmG8eOkx4TEtOJyNIgu1kRDrYow8CMsJ1wVCIVnMeYHlf
	0g9MJbzyTC5hs79831ayXR3EkKqMI1K1Q+ztDGTUqvun1ukEUEGd4IRy44a2z9noDMN378+/JIF
	uj8czvC5iTl5GQdZUSHbF936LYQit5RDjtGeAcW72FPJORTbcOFs7TOFpft+Gj8RWjWDpd2TPAH
	iJHeMZdOlr760x4IW+VBA7OlKwxlyq7hpkMf7xckYXBwnjmeC/JwAcswnOnYiKk7OlG1YKawMSt
	RYFxdTWGvYYOtrgYEicWY6mY9TBb5Kh/65RrWvrMoOO7fKNmhTIbFEJn7PiQValkND4mvR5MRfp
	1D86gOJ4IUHmd0abp9jHUUIzWbR0kHY2x1DnJbGzSrLWgoIXjVd9txQbbj0N+SJxQcq0S5h4ViW
	YV/dnOvzPMu5AxrSlmQMtAT0xg9qEXxcw==
X-Received: by 2002:a05:600c:8508:b0:490:625e:bb68 with SMTP id 5b1f17b1804b1-490a290ec6cmr215766595e9.3.1780321924585;
        Mon, 01 Jun 2026 06:52:04 -0700 (PDT)
Received: from lorenzo-VM ([84.33.159.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09ab80sm77878595e9.5.2026.06.01.06.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:52:03 -0700 (PDT)
Date: Mon, 1 Jun 2026 15:52:01 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, fox <fox.gbr@townlong-yak.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 1/2] http: cleanup function fetch_and_setup_pack_index()
Message-ID: <e87a270cc05266407d75c9bdfd4faf068fc6f4ba.1780321770.git.lorenzo.pegorari2002@gmail.com>
References: <ahjUmMCKxREamQE-@lorenzo-VM>
 <cover.1780321770.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780321770.git.lorenzo.pegorari2002@gmail.com>

Cleanup the function `fetch_and_setup_pack_index()` by removing the
useless call to the function `unlink()`.

This is not necessary anymore since 63aca3f7f1 (dumb-http: store
downloaded pack idx as tempfile, 2024-10-25), when `fetch_pack_index()`
started registering its return value (in this case `tmp_idx`) as a
tempfile to be deleted at process exit.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 http.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/http.c b/http.c
index 67c9c6fc60..b8443b1ef4 100644
--- a/http.c
+++ b/http.c
@@ -2538,9 +2538,7 @@ static int fetch_and_setup_pack_index(struct packfile_list *packs,
 
 	new_pack = parse_pack_index(the_repository, sha1, tmp_idx);
 	if (!new_pack) {
-		unlink(tmp_idx);
 		free(tmp_idx);
-
 		return -1; /* parse_pack_index() already issued error message */
 	}
 
-- 
2.54.0.129.g2dffd77b94.dirty

