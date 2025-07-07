Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F242049
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902229; cv=none; b=JuMkNBjgpune4LcleIVRrdQ02lmokW4n/rMkGqCIVuqnu9esr7MkXL25r2W/hYAiSnDioBImfsFSrmrHC4wfk8d/BHwX+ZSnFYvjywVVfgvV6eKIussImZN3gVKxp0k4iFpjuNpdkO8ryw7++kwQ358O92YO9e1EXZ85erW8Dec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902229; c=relaxed/simple;
	bh=4+AltBUqhqs4PX5Zm0ZJGHBdzRw33lbnr/MWPFRmz4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UgrdktJWTDFRPxk1JxE/XCxOScgmC/WbPsV/4L5RVGkjTc25QI7uVo5jGD26i4Vz1ca4+Hio5qwKJNspyPYIWzgZyf7idwSAKB+vheGhq0zrz9E9mFRfUbobTmxkhZvmYsEsqujSQGrANlWQlYScIxFti3dCr8FYANJem6nYvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYHOgR0Q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYHOgR0Q"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2350fc2591dso30176505ad.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751902227; x=1752507027; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esgPzxkLGoZLu1/wYNNdnWhtsLS3lhEDZ3c5Opef4wI=;
        b=mYHOgR0QgKpSoywW3gC2CizT2i2WB8726meGW0MFXPN/5Ozv2+tlVT8BvP1Li9z0nK
         MtcTYka/I4W8paNLCwJXoBnRp1c84/OtwGqCXYVJWiktGGCU7wmf1jyOpXZscppFDCPM
         7XkN2HD5rPiyAbUL9HdjYYyQ+vOYK0bYy54F5Wv8qllPgkKFsN6/UgA/jl8PSsts/YcB
         E2oSARDxDuXtgAQpu5DEvsOhWHDH9UgDROQ5DOE7xMBF9mAgbq1GUQzRbXdT3HFksUEe
         jwuXBAO1qujn43tH4vn+YdFUku6KAaNku8yrcucnk5wGg9ZdT2Jq+UZJhPc2gBkUFNYP
         KSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902227; x=1752507027;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=esgPzxkLGoZLu1/wYNNdnWhtsLS3lhEDZ3c5Opef4wI=;
        b=BaANs+fpPBd6MCOdUXCNAGeh2mcoMZnS8pT2weoBdS6PVX0LUvb1vZUQ212JeeIEJh
         VyD8BvDyG+XVVQn/Hz6xxvYz2OZwY71TdolxqqTL9J4atyMdr8N2IVoFCIuq7v/bWP6f
         bQO+fpBiIG0BjOwskF81LPz1jvdGIM5i9YoWJHZiQDc1hIWcLQbr5kdM6Tt0s46YwAPd
         KoOXngDb9k5F23LBMiapG/0vy56H697fUuFoYW3l01DlvOQi2WYywTpTdJDTGm90fayf
         N9x1U8hH1wY6Jz8UcWvap+IPgxKT9tPzQZ/grjKpOWh5GqwBq1bBz9CHx2E5fekN38+/
         uWxA==
X-Gm-Message-State: AOJu0Yw5QmoFR8DVK446XP1cyBmVCAdW625SGSgMmvzy1t2FET49YDe4
	f2w+bxhZDDPyvTXCK3LdRUVMR+GAVXulQQEHinWyV+0sMAodi2oZ9C9WtQObYw==
X-Gm-Gg: ASbGncsZhA1WAP2GOJ7S9NBEMRD6+mym66Bble8In0qlG312w/CLVWWI6c3AnAXfX+2
	zkW2iFwAczD3FLa11MAgJYCFZNF3W7rW5Wcd5APfKCH5wuMKqqLmdk2hqMaYVqTJlyDqfI0SW/D
	CkKd3t32yfcGSPQjTHSGuWYCcETbR2vjANPiFMwIGpZk5/sxRnx8jopj7naTt77CTn5QDfB1isM
	2YgOfLyvQlmf4cUI1rG4PiweszK2dWT1q67U78wsbNpvQt2/4N4EXzVi3QQr1Ay1SihQ7i8LK5V
	LKJeSTKDxwvO3blgSK9uW5Obfgw+B30ftZ5ESrC+WQSUMiu3Uc0pd5MgY/ham5274Mi4/SrTf6g
	Bj8XbVIPUyoRpfEOpNZxJpJwqs6s=
X-Google-Smtp-Source: AGHT+IGi/KLl+1IsJfJ1Q+cndI45AtJ02IySF8tsD5rfgqGyrYNPWSKgiALpMLtn5iGCjbHhLevdwg==
X-Received: by 2002:a17:903:40ca:b0:233:d3e7:6fd6 with SMTP id d9443c01a7336-23c84b80905mr208031885ad.19.1751902227231;
        Mon, 07 Jul 2025 08:30:27 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c8431ef2bsm94049345ad.33.2025.07.07.08.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:30:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 4/4] for-each-ref: introduce a '--skip-until' option
In-Reply-To: <20250704-306-git-for-each-ref-pagination-v2-4-bcde14acdd81@gmail.com>
	(Karthik Nayak's message of "Fri, 04 Jul 2025 15:02:32 +0200")
References: <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
	<20250704-306-git-for-each-ref-pagination-v2-4-bcde14acdd81@gmail.com>
Date: Mon, 07 Jul 2025 08:30:25 -0700
Message-ID: <xmqq5xg4588e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> +	if (filter.seek && sorting_options.nr > 1)
> +		die(_("cannot use --skip-until custom sort options"));

Missing "with" before "custom sort".

When I commented on the previous iteration about sorting, I didn't
mean to suggest making them incompatible---it may have some use case
to grab a batch out of the underlying refstore, sort refs in that
batch, and then show them.  But from usability's point of view, I
tend to agree with this design decision.  Such an unnatural batching
and sorting operation is probably not worth supporting.
