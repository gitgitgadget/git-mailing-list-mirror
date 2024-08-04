Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34B2C6AF
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722787862; cv=none; b=nx1RG3MWzNHpBuMn6m4fdemkrPBlb/UpYukrCK48kRlexkF7/NX9K0gwIQ8WBYmxGcR65Cj3I87lx3fkpHNRTPD3f/LZu6XVLP2nRdr/6hHpN3YVXpX5qWC7kh0436erDad2PKwQdGXSOiygeDZbqRiQNQ+ncKt+IoA7W4f9YuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722787862; c=relaxed/simple;
	bh=LPlJ1CyO73VgURU1282aGKIDcrKCJjIi73ha7yA/ung=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0mDqlihPYeONH1jDYmVRTmYWPNXRstOUhZyK2l47oHlZdHbe6+iQPGt/oJCsUj2oYsJY/qahzp7WxPfX9GBKdFNAUkHRmfN3p+ntQXRWJpQkTSdoVrFeexCpP5ku4KUq89ot1tzNQW7StMaXb1U9J+yu6hV3W8RyZIEoWHJhwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=h3/5Ecdl; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="h3/5Ecdl"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-685cc5415e8so45893157b3.3
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722787860; x=1723392660; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6oLgLO/Sf28AbKdzxQVnz3HiY2ZObV/np25qZ3KpRu4=;
        b=h3/5Ecdl+j9rfd9Jksva6Mq/ew/2YYt1aw/bXQCvtW1CvHcfp62ENZACmua9xW5NZQ
         QtZd7B4/nPjfFIVdGD5KL7L8K1JHZTvWZpP0O+eAt/DjvIpDF1EQd8QRE82X7IbNm6Cr
         euQhPLVG+e0ncIU3QKP3JfrK/UcyOcxjCQJP2FJmqp55CEJJdDIw5Ttl0Zi+33+Xd3Fg
         ix+wqYLuUTVcOHyDiD+aVW1TgQ26XmkNckyrRuQzH6cfwCpg8fxQJ7JdqYFuEVV+Brdf
         ilGzoTUuS7eVYdZ21zf8Z2iJYx/+IVWXGkuarx4pmFOFXXR9YZtF1YJB/pNWXknCMAM4
         ZBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722787860; x=1723392660;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oLgLO/Sf28AbKdzxQVnz3HiY2ZObV/np25qZ3KpRu4=;
        b=j6rNBlRb5WS9K9cQL45GHs17ovXmPwk1WoBEqnt826FHIE3+cOoSeJCJq3KVlxnZBG
         c+YlBYKUi4NUHpG2IiVJu1CIyibfYUAuXRkVXRnky6y79go7uUljWb+HquEoBVr9guWK
         9iDJfdR16l1ECHmNk7HwTq8WNLuFvxKX46JeV7y9ZXJO/mw6LByygy615bEO/MKrKMM9
         VSCwfRBnRZ0CeajIOMJoDKrjyHkeMaI6rQ0lcsFYIqnhdajqMWoJwbOJdv02HeySSC/0
         BFw6ANuFAkWvRtBok/rx7UHWpL80ZuZ6ygl1Z7X0z2pg1Ji86hzuOkAEMRa37yu3/35A
         dYgA==
X-Gm-Message-State: AOJu0YxSVUWmVUZoLm+j+FwfK7m5470TEmN6Qr65BfhKJ48YIPaBvbUR
	Hv+yAHjf140HOHIxoWoHGMDNJg2GBxrOqByvpKDgJQExNtgq5BbNx4EBT1v1iqIgK9k8S3KI3dL
	Q
X-Google-Smtp-Source: AGHT+IEAav1aKUHV6Q1iqzxIyYcNxI8JpnpgLTF3n4+HImuygsF5oT3LMKvaLyTbLYP9vQTY7h7p5A==
X-Received: by 2002:a0d:f5c4:0:b0:66a:8b03:5cfb with SMTP id 00721157ae682-68961eba2femr94649387b3.27.1722787859809;
        Sun, 04 Aug 2024 09:10:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a137b43easm9003617b3.128.2024.08.04.09.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 09:10:59 -0700 (PDT)
Date: Sun, 4 Aug 2024 12:10:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] log-tree: use decimal_width()
Message-ID: <Zq+oEby6ew3HrWFK@nand.local>
References: <06783722-5184-41d5-8edd-94f97b2f2794@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06783722-5184-41d5-8edd-94f97b2f2794@web.de>

On Sat, Aug 03, 2024 at 02:33:24PM +0200, René Scharfe wrote:
> ---
>  log-tree.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

This looks all very reasonable to me.

Some history (if interesting): lineno_width(), which was the precursor
to decimal_width() was introduced way back in cee7f245dc (git-pickaxe:
blame rewritten., 2006-10-19). The piece this patch removes was added in
e00de24b10 (format-patch -n: make sorting easier by padding number,
2007-02-09), but lineno_width() did not become part of pager.h until
ec7ff5ba27 (make lineno_width() from blame reusable for others,
2012-02-12), hence why it wasn't already used here.

Thanks,
Taylor
