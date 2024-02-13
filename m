Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883155FEF1
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842965; cv=none; b=qKg8YzbicQWzjXvYT6r2J9+/uCRYjBDznosFLKvvnQYRp/np6MU/ixMKwtxpydWmH7VRsyNT+ogl9dSg6CLYu70P8pCs4ey11j0CFIS8Q5/QdKIqfZFccy2pxX8a4mSOjfH2cSaJzVwynyOUy4crE6+HyacQ8ghysGZjkoRanJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842965; c=relaxed/simple;
	bh=2lcXTpQ1Vv2x+Bjua90N++eaDnhVUVKqBp+Hxt0p+Rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g3I3j613D6rlVCcOcd5XULC0cbOUGBgcgrJ0GHLpNabZP9ze8Uamd+WZEw0hYkMD5eXpuR7lGL3JBFLm1Qba3VBr3ayg38bnsl3F2xQ7rM/ZFFaCO8MXj4e2hkExqvgoGWs0PJ4O6UQbD8FYsblw0ZfW0L3BcPBUjLmDj1VhU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pM/1AjNI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pM/1AjNI"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d5b60c929bso71834925ad.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707842963; x=1708447763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lcXTpQ1Vv2x+Bjua90N++eaDnhVUVKqBp+Hxt0p+Rg=;
        b=pM/1AjNIMhILVswBZANd10eU7k91UqgQpGXY2afxv2iH8W9NHoCSONwZO3EDwhVedk
         +XEADckBSu5zR7sASp+LbzCK+qvcRdJWpwfe3Ha6xb1AUt4nfOgcPeCHrL1V4rLY/mk5
         7D3afIzx6H9Dzx3WyIduIfQxMAHnMmz0PP+TzKTLM2tTf07HNPmnTOY10VmUW51DDdUb
         YTkG5ShwZFqtYif9hW39/1mqyNBi4xsRY5ndSawMM1IKyO12zJGhE3AD5bjBwZEZwgIj
         r1ZfuQbIjnKpgYdtMT4jykag7QihMzUkcqBBlkkO7xTEqaGh3FlLv0WCTy+c1YjdwZdX
         qh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842963; x=1708447763;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2lcXTpQ1Vv2x+Bjua90N++eaDnhVUVKqBp+Hxt0p+Rg=;
        b=CpsOC8OgHlxswFXxL9k/HFbIMvHIycoJTAwLk2RoGdWprPVvqEJdCUMDsSp2JOP+8j
         tevH07gIyGyKR7+7DYbbY5eZK885Bt/biepR7HCvBsOv/DTwo8j8Ya85g5lZrR+pcuSf
         0iS9eMXrmvVdl59hdp8PveOZ1ifgncmHwaB0Jml8MvUSa8eSD8+VUJIMVsojBf/c1agy
         RmnZmNTE/kVEuarElm14ER4Ej8bCXgiFIyqlsaeQtq6cNLEklhjM2wjvtXFM244YOfrh
         i0E/E7jNIuQrxNndXxK80mfG1M8wNTTL1Br5ffXMlDySbHayRxjPYdzwov2T8hXpKWSR
         XArw==
X-Gm-Message-State: AOJu0Yz3tw8jKjMOuAlwpDqQsNnm4k9MVMOaEo5vvLhQvnIQQfTCKhNm
	TBs+46N3yKVVbl0VPUc0hpAArO/10BFQJRMTftu4lYFKd18oWKJe3fuV0b6Y5AjzrVu/0BV2szN
	lQg==
X-Google-Smtp-Source: AGHT+IHEBbV0HLI3Eqs9/q778xz0to5vaMal2LM366kfpLX1ro3mC/tHV4YQqLLXAWB27fqhpspWu2uwlig=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90b:3c0f:b0:298:c3ba:43b0 with SMTP id
 pb15-20020a17090b3c0f00b00298c3ba43b0mr3419pjb.0.1707842963299; Tue, 13 Feb
 2024 08:49:23 -0800 (PST)
Date: Tue, 13 Feb 2024 08:49:21 -0800
In-Reply-To: <CAP8UFD1YaEfdM=apQ7An+GcKV+Wc26StsMqJcd9e5tHJg9U_hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <a72eca301f7f9016ef3a8063f79790ce00f41ffe.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD1YaEfdM=apQ7An+GcKV+Wc26StsMqJcd9e5tHJg9U_hQ@mail.gmail.com>
Message-ID: <owlywmr8b97y.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 12/28] format_trailer_info(): append newline for
 non-trailer lines
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> [...]
>
>> The test suite passes again, so format_trailer_info() is in better shape
>> supersede format_trailers(), which we'll do in the next patch.
>
> s/supersede/to supersede/

Nice catch! Will update for next reroll, thanks.
