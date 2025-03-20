Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB5C225413
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493495; cv=none; b=UuMAmGd7zhh6zOuLeD2vyszJl4OM8FRmK4T9uzoFxBFWFZaYqDCN0vJfwfQcEsHzEZmq8TUNMdfQq41mHGPBceiHL5BwkwTjVdg6hRuniuwoolWhekSv2zURtnfiuAmtapig4d4o7pVNGPbo6Hl7W+5V0ewlU0XsvUvVP2kWSxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493495; c=relaxed/simple;
	bh=3OsnMhfJDvo5kVjhXtyPLDMglD8dv1l2QYZvvtLsGtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfETkFxHTR3gBlPbduM0c0F1nvPhjEg+kZUxUQE4YfPq/Ny/jmJxCfvLgCrTPTuK47hqFY2bNDqWljQWHCENFXTSMHZt01DKsP6rq1WSWsE3N6C9SqV2x8D4Hw1kqBiia5ZWaDxjNTNEWkGZqEOjIfbHfXQyejb4f9t/0RBwlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=R3fdXuZD; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="R3fdXuZD"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ddcff5a823so8793216d6.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493493; x=1743098293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xCBMlqoIiEIlRWM6kpd95kaSBwByHKdEbw2L1ZCVwrA=;
        b=R3fdXuZDH28bhhY1Xn3t9KHgOIZUXPCzsF7SLIUinAKhSza0Rz87wo4Vcc7/u+o1IF
         5yzfGgBNQcqxDPt0pqbm2Vx/p24czWafC3n7i0fEHUDK06ufOyrpPxjJLPm7J9Nj6+OG
         56Amp0vBUpHKQtgsMVbxaL9HJG/U4mK5o3AIM4y5VQjCJ+P/fBPQ9o5wQfl0MzxP0kMW
         o0xhGzjhngi5Ch6m8Hl7Ap3vtRA260Fcv66Qdcdlv7+SW7+mc9kSopZqBBujrFOVTiMI
         lBTEJC6co5tGCLF7jr6qHY3zatoPE2f5Im5Lf12bVAXi7lCrB0FwfJcXXuHt1JccgFru
         upLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493493; x=1743098293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCBMlqoIiEIlRWM6kpd95kaSBwByHKdEbw2L1ZCVwrA=;
        b=GYzbnKgiGvMkF483+YY24GINuMllbT3hVeZumhBBfsySYDWUX9dFdyW6oyCLXrZzfX
         9U9aiTprXPx5n/Lk+d+adnTjgPBUnCogR8i0XUOjEy7IcSuERdot4wJOex1FBwzPAP+d
         2sgBOv5NkXTksq+wEJE0uH+uwQwvoXyuec9NCONX64xvUh7HnmMIXHNgDnDDK22v4Vg/
         gvIcCmmWZmvCjhpndwGCLgC9dhKCCvIA4Mh99nhYmF6LuztsFf0BhGJNvpKyyHrg5/Kh
         FgETIOqBIN9bE7Ud0hc7SlPuPRiOXlVnAHsgfkbinmH1jEwIEMAJkRSfJARR3ivTfX0s
         PONQ==
X-Gm-Message-State: AOJu0YwTuBUF4fFWzgZoSQic4ZS2KxJCpBc+htoWhFIcr8ObhJJaPaxz
	UowVduWbAdSwbMIoWlqvPdwf+60TVJRATofVPHxgHUUayhtlfOKlIXogRE1mQgZgjFQUqwWLp/x
	VK6Q=
X-Gm-Gg: ASbGncuq9eogtmCMc1lkaLuD0gSzKcJ4apEXYwm667lRIpeuuMAi3k2XnxChX4q+z+5
	RqmC4X5kpIj3q1+9fjb80Os7xYn8LuEt28dgjbQ8hJZMGIkQfKa8T7o9bEwHgVl1k0OuJWg1EO4
	hH0sCPR3bwWzyz3/vsEHC8bwFXJpoe2mJ9KxlhBG/5Mvc7eb/CITh74QhKwKG6TT+wkkZPcjYCu
	g8zys9t9lV6UkoGbx/EICD4jF+5Vp0k6bk1ohnYdhgZdL+RgTSwckarJU9Hdaff06KHwfGUwJsF
	qfKnwzXHHeNdt9C1OIh69idHQcxeV54KgcTyQOWTmWtKawLNR6xKY+RdGhzVjY65Y7Aoxs4wC3a
	4rTNu4S7xWg6OqIS4
X-Google-Smtp-Source: AGHT+IGxjfWe/ohVKtIc7MSKLaqh9l6VKALWWMoJqw2QrV7/nC/Uq+NNSYvifZc+ELXLvwki7ce21g==
X-Received: by 2002:a05:6214:508c:b0:6e6:6bd8:3a86 with SMTP id 6a1803df08f44-6eb3f27da4fmr4141206d6.6.1742493492844;
        Thu, 20 Mar 2025 10:58:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3ef1f887sm1149876d6.30.2025.03.20.10.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:58:12 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:58:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 08/14] pack-bitmap.c: teach `rev-list --test-bitmap`
 about incremental MIDXs
Message-ID: <Z9xXM2DB+3cllQQA@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1742493373.git.me@ttaylorr.com>
 <20250320175652.huJnykbhBJ9dLM6drZm3omfLTisaJX-eq1TQ5FN52h4@z>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320175652.huJnykbhBJ9dLM6drZm3omfLTisaJX-eq1TQ5FN52h4@z>

On Thu, Mar 20, 2025 at 01:56:52PM -0400, Taylor Blau wrote:
> ---
>  pack-bitmap.c | 107 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 86 insertions(+), 21 deletions(-)

Oops. I moved the wrong direction from 9->8 instead of 9->10 when
submitting, hence the duplicate patch here.

Please disregard this one, though the rest of the round is fine.

Thanks,
Taylor
