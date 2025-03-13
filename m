Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81E18A6CE
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887326; cv=none; b=YQh9FCBlowphBp9NPOi4bi64up9+o1u4eG6GCoSMM22GqG1+8VVUgKvseG48XLwwhofuML4nvcwVZx66DHVctAKjlVLhMUwITLVZ2Zz2trdLHV0pUzdh4WcNpBz5FbBWAVycyfzCQZrVd11Ho/yxEaOO9X1wpH6hs51V3iWsvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887326; c=relaxed/simple;
	bh=2BiZfMQs3uaAIZ4azjjG042kPouoyBk1NHdUwP7Yp54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMQ+smPMwyiqldd28Bl4nKYRZGllOV8KY+W/VK+vPauCismMYPZ+UODd6QMmlMzSoHu3k/3QGExlRajclA0m3K51Dk61rSplU73iwUx6wSpFI1F22CcYkls2MJfz9YdzTFagk83hnq323wbGlke9eSi+IK4T/e7hRYt5pn/ikDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eIW/QR/J; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eIW/QR/J"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4766cb762b6so12970791cf.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741887323; x=1742492123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ7e5WO6wzH3559EaDmknAUrcWc5LammY4VuO/Gdw+c=;
        b=eIW/QR/J8prnAJcCVwT2F/tWhoNqm0bStgvv/60pGJqEHXEQOUHA/qWqS+gVH1RjAU
         tKUodn8v/YHvtN/TZqoYbTgcMJH38gdAcYTguDfpugvHsZOtvCuXhI4FN+ucnB1mwSFt
         4+nnafaq+61EeqBnTkEnpoyOOVnXBg2OsSuDIIGit3QNRZ0iK8kzxsfGD89u+0rnO73+
         XQ8Browmf83Cq46zdxbx71birXxiOrB6DCb9CBk67vkWzNdxgLosGiC99ac0eSX/UG5T
         ysp01vy+lUatbZuYjPmUbDgypyUQE/TxCaahhQt7h0+KL+whfR3XQry5p04YDkoJH0b9
         oSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887323; x=1742492123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ7e5WO6wzH3559EaDmknAUrcWc5LammY4VuO/Gdw+c=;
        b=PpIrY5awyaHbQSOrmJ/ncOHMrQ0Wam+mGCyRXMoW8g/3HAMKeweFwaEg9EOoTqdYQU
         E34wBdgqfM9A0WCcwyclv8BdtLVzD7/oQGLsNjL86HBbQaqc4qv9btSIA0nJOLT+Imaz
         RXGyAdIXpLJx2Npvg202TQR7H+/fZcuFo8S2lMklLuz8Zqjg3n6eXWf2eFgOiy2vDpjd
         DnRSKdo48iI9JH/OLzkAbubTiMhFDV8/s420xNoZv/HshqUeAWPGKnSYZWmvcncygObk
         KPwrjFfJBeJqK8xL6IgDfDddSixXkM0nKglnwhcGdk67X5EbwvpowrwPnwgpifPDeLR7
         0REQ==
X-Gm-Message-State: AOJu0Yw8kEgF1uBY6IsBlUSgiKd4XKZPPfBtuc6Sbi4Lh4XG8WN899Uf
	hqw4nBbZaZ1I2yHQfuiRrrGR0g8mqYbwu79fejXyYJvFaSGPHTRg1lx6p4mL95w2B2aaODY5IY6
	wmfo=
X-Gm-Gg: ASbGncs9tXRSO9p5zbCyf52BUZcGyYJ77psBRZAdNhksGoEhkvKi6SHiqTTTMJpfV4s
	oxZmQiNBQFJ5IjnF3pjZGWZtOyAFT3CeY06jlPw+6dHVvJZxbFiwj9BmJEWbMpdYdCa2J+o3X2p
	8SIW30RXEyB53ULxOR9Cb+aEtv6SeO/FMoEcl6QORJLIMD8BKkg3sQbAOIWBoXs35HWvdpGQkzM
	aBXFsltXVmtZcqY+N7eiVD4ToFc/kwcARhT7Nju5F8ffpTVCYgIn755bjgMjNUC9ZaJRYtGYD/p
	JTy3Z44WBUrjUraYWq2seVkiaOsviDYUNOyWJGrr0WNfVJ/mCrleg6qN8g/XZKvql9DtHiA/9MU
	bKL+ljswx69NPH4cf
X-Google-Smtp-Source: AGHT+IHpS7exUqIdRRTZwfVPL+eru1U7zSpcf/LwlhuH+TCPqPbhHQBrxbmFd+esD+94BCdf/uFTtA==
X-Received: by 2002:a05:622a:2a0a:b0:471:80ef:35e7 with SMTP id d75a77b69052e-476ba88e974mr49776261cf.4.1741887323228;
        Thu, 13 Mar 2025 10:35:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb660c5esm11869611cf.40.2025.03.13.10.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:35:22 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:35:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/6] pack-objects: freshen objects with multi-cruft
 packs
Message-ID: <Z9MXWeXd5G1d4kY5@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
 <xmqqr0332un3.fsf@gitster.g>
 <Z9GpQqm4YBvWF7Ff@nand.local>
 <xmqqfrjixfwe.fsf@gitster.g>
 <Z9Ha2mFXpojI+aIR@nand.local>
 <xmqqa59qxc9b.fsf@gitster.g>
 <Z9Hl+UpnEq07qFeW@nand.local>
 <xmqq1pv0q27u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1pv0q27u.fsf@gitster.g>

On Thu, Mar 13, 2025 at 10:17:57AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Perhaps in the longer term, but I think for the reasons above that the
> > existing behavior (plus the new patch from v3, which we should still
> > queue) is sufficient.
>
> The older iteration has a few loose ends <Z8l5hxNjEOALl_g-@pks.im>
> we would want to tie.  Elijah's "decision to combine should be made
> at half or below the max size to always make a progress" would also
> makes sense.

Let's split these two out. This series (or single patch, as it will
shortly become in v5) is fixing a legitimate bug in freshening
unreachable objects when they appear in multiple cruft packs.

That will allow us a little more time to think through the more
complicated issues while fixing the more straightforward ones quickly.

Thanks,
Taylor
