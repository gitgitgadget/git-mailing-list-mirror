Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D07C1F238F
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268107; cv=none; b=rfYdWn3oANljTXbtbyxOaklSAIX9c3aofHxBXWx9AtrquzaFCcKdQrcXg179K8YDqIWpDk7McSTPKRKRstyGh/p6e55yTZTIPxQ/c74dVLu9Lm7eOKUDvawWKZ3uMaMEMITI/BGIYDoHROswELR4EAIBXxNnX/Tcu8x1sQm6+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268107; c=relaxed/simple;
	bh=q6ELfuIdzxNG0wrl3ZZPoa4HB3Gfpt84ni/zxcBi9w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgXNyh47Ebztrd5ASUWts0IqWV+cIqSKSF6WhR+x4+qqDUmR/+QtO3bPh15iZbHA8ie3wsOSqn0Vn5buwLATefamAnh+fYwsAeRw8I9/q8dolOqkIJG/9T3wlz+LqQtiuSH+Z9gQaeWM2f6KT8AAfLj4sIcP34uo2fjeVIC74qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9hlXHMS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9hlXHMS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f464b9a27so88242895ad.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 02:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739268105; x=1739872905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MyIexXLxt8ezMKLYr2d3jB/dbF0osQZsLUSeo3qypE=;
        b=b9hlXHMSGJ3UWStfuFBNVYedjQurLp+lK2hGPzsTDSkGv92yY4YMsoRmnIe5YM0vWT
         m1CdYjvgM7/SX7A1mcNpe1kDOilA6JEsmhWKMbUCv+syp7/pLTNSRdSPl2bmhH7IE/PU
         qui7zgGMIQAE3UZgUEEa+lIKYQzjXhx4vitjx4O6prCvD03r865KppTpglxTvfZiPMVT
         R2VWHXTkV6HSnrpC0MSMh1QYWMtsMwMLw0TCa85ZOb5cgszM1pVCh2k0L6MTJXTl5r2X
         AGJyRFPaoeAWzLvJazMFYqVWlSytFVyRjwVokTa8wNENHzM3zRcVda4o1vXuLoRvgTXy
         3wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739268105; x=1739872905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MyIexXLxt8ezMKLYr2d3jB/dbF0osQZsLUSeo3qypE=;
        b=UyQ+5/P4OMQYDHNukOQBJhXmJvUpiW1EPZn2X7ERrPtlVXS8us2QX+OrJCWsVMAJki
         p5PtUmAMw4J9tw0ypx+fjnLRoJGhnz5wuRVZ8WffOimC7zcORzi2s4JGhvXqxke4wfxV
         O7rBdn3DTMrqjBfAGMGSMR0/KZzdmJXIjjZQWoEKPCz8UzqWYkKcXzjTw8ojSdA4M708
         cUPbu9M2BBVd1zmgfh5OnhdI9oMyNtnvSEjAhF7JzLtQ4bBc23Yg9XuNVKo6GUeTo6rw
         qG6opSnHSzKgAvVzFmvqjmjAo+4YeH1fpHzHbKIIztCjeRpKsNClzzJB7I3FxxE5As7y
         mK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOkoc8MqvvQ1zY3rN/foDmZtfsORjYmduX15GjR1DWTEFGygHDSvG36eO2jc+j8AIHj+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTPOTvi6dWodHhMaqsAu21h8oMMkdFublniJqs4QC/e+UvjH2
	/ByIygNMas9Ei7CkT80rvOUxsYTijbjxL0Ci+/HfT84qsguv4gDXe+GcKg==
X-Gm-Gg: ASbGnctYABIk0TMTpi9/Ub/HDIHnzaqzeEoKK2bqARDGZMbl7W9LHuTnmI/59j+gL7R
	gglT31wQNFADS3cm19sOWIm+b+qgy2qzCM9wP8GadxOeuCfyL3cco8anorCwpjJlx7xuGiwlW6B
	JCC4bj3ND0zopEk3wS/a7IFmROYCr7iSM2GiQnVjn3Jwe1W2x+nBFGP91ODlbDzjbMstR0pMkvF
	BO5HLQYvhdLFaBoELus5T2wh5v0j2Ll3HS1pl4n1rStPSQ+tNeC9o64se+D088el+vlaw==
X-Google-Smtp-Source: AGHT+IGXdaqt195gaq267FU+QAh3qABO+B6SKr4klazaZ7DD00rCFwRmw6Sk5ErP7PS2j3FuBl17cw==
X-Received: by 2002:a17:902:c941:b0:21f:8099:72de with SMTP id d9443c01a7336-21f809974b2mr130632985ad.45.1739268105056;
        Tue, 11 Feb 2025 02:01:45 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fab011be14sm145434a91.28.2025.02.11.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 02:01:44 -0800 (PST)
Date: Tue, 11 Feb 2025 18:03:34 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/16] path: remove dependency on `the_repository`
Message-ID: <Z6sgdtsnBV9g9UQX@ArchLinux>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
 <Z6d41SYoyavqcei-@ArchLinux>
 <xmqq8qqdbqhb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qqdbqhb.fsf@gitster.g>

On Mon, Feb 10, 2025 at 10:32:16AM -0800, Junio C Hamano wrote:
> Thanks, all.
> 
> By the way, shejialuo, this may textually conflict with your
> get_worktrees_without_reading_head() thing, but the resolution
> should be obvious.

Thanks for reminding me to notice this. I will take care.

Thanks,
Jialuo
