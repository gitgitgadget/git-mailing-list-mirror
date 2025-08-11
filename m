Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36C2E1C69
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936750; cv=none; b=dEv817+NN10ihGNarGwyBdWM416Kr9rJ25qSQ4O1jYIpS5ZrltoRz7ajevUrbPWj6nW4AZirPKziLoZAAoEJpQPbzmkIO6WJb+Xxke0zMRgYw/FIPeyzHI1tALtiCUZVprKhQLRS3t5qsRriOBFzptK+ORMyF056BhtAfY6FW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936750; c=relaxed/simple;
	bh=7M92JqUZN3kmtcS2OeR4nDtY/hfklguOcXoDGVs5tGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/IZLle5Wy3nplxAm1tCN1gtvyuzXoKn1hChuM/vHuLP28S73qbvfvqkANZPd2uWaynvBj4+Gd/xy+PVlbXeCFdX4GrKbqUb4XshsicYvgIa77O3JjprYlHYlWHitIB477tXq86ZOeuwLU7+lNXvbTSNa7Hyfo/N8avSawxiQds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3BJ+0eC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3BJ+0eC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-242d3ba2b44so15476365ad.3
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754936748; x=1755541548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M92JqUZN3kmtcS2OeR4nDtY/hfklguOcXoDGVs5tGE=;
        b=Z3BJ+0eCjBVqoPSWfXTjZwzLUC8uy3qodlQ/2Kto6xzwjiA84Rhx2BpnuzRYWSpswA
         1mk2a51WizheXezY/g/B71BgPlm5IqzYoJRu+ma/RCAsier6NBh/7KJWyfkZyJbkIleB
         PSid0KYx8KNTIk0rsIYnMvPK2vCpgYBq+yCHpqktkZYS4QurPdlDoKEAFw4IEdVQYbDH
         m23mVvxJ5Tt4gjjK8KObfMw+o8RCK55JVpulqbrPAZidTuyJwTq00axl7dKEev54ywv2
         GIOFcfHA4isHXZGV0kp/Rbscmoh02Pw4FSEMkbk3QbclIiHVA1q7KLHVXysHMO2Hx3lM
         8m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936748; x=1755541548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M92JqUZN3kmtcS2OeR4nDtY/hfklguOcXoDGVs5tGE=;
        b=voIhIP4ybCHppp8rtBeWDws8fnBON+QE16ZQbsSZ9BfGfiNm0WieaPtq14qPY9a9Pn
         haIPMkOHHTe+sX2oOQWUp57cNN64DbGOwme99JllUQ3aIo5WiypqSP/u2Zj7OO+sXOCz
         Fb0LTP3MduAfJ88K5ZdbTYdlNMQaj4A07qsK7Ds6SZK0th/C6fNKimpIggEpVd6wDBTv
         jEocWORa87gmhsZ8wGSvTt1ovZ10rySBVS63N5Ucum4610/QGTS3l+9vQr9DhjSOaY1w
         DguLDXV9X6/oHf5t7Tfb9dJX+e2zwtNlv/fGSTafBZumb0TC8us5gfG6/38+CU9AGJN6
         EXjA==
X-Forwarded-Encrypted: i=1; AJvYcCVVsy86ya3mrQXpsMFy6O3wUN0RhtdiEw5IojqgW8bGQeQcn131wFnpSvFLIKMAFXdnwdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMEG7dTTPgPEqFpberzsHSNQ/qhuy2M3RbNoXiW3e3pW9UBQiR
	9rsj5/bI1fTN8dUbhh0S3ZMgKKTBmtmx48dDrRgBATQ3ejgolBUDG08gLQdFqEgCvm5xhQVCWNv
	csmr3dlM/EKVfYdfXAfMkQBqjVz6QWiE=
X-Gm-Gg: ASbGncvFATRdxhcacMMUF+qhn6TiH/d23PcmgzmROdWA6T/6onZ0WvwQba1hqWiaAQM
	r8aZ85zB9olfG3aEvzNHBl0oa1MKKnkpqUwYdcE1tMA5yObi7jym4bMTLS694iZUedKFvRLdLIH
	vhbSQaVbpDXTUAB+om7dnS7CEj3ZBVE972y2xZPRjmeWXQAy6rxLSA5/Ef+wOkJyKjanchnHfcw
	Yn7qzsa
X-Google-Smtp-Source: AGHT+IENUkfBjEyuEOtaSuWzLVp5BIYq/6Ex/cUN63mIXp671ZA9G+xFLYObKaw6nYJhk1CE5LLt1LN51OBwh0AoiZk=
X-Received: by 2002:a17:902:ebc6:b0:242:9bbc:3644 with SMTP id
 d9443c01a7336-242c225a177mr184326895ad.54.1754936747955; Mon, 11 Aug 2025
 11:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754868681.git.ayu.chandekar@gmail.com> <3aa014ed46d14e31ea0c2f6b7631e7e4cbbd3943.1754868681.git.ayu.chandekar@gmail.com>
 <076c19ae-58fc-4823-9679-1d5fe6e46211@gmail.com> <xmqqikit3kgo.fsf@gitster.g>
In-Reply-To: <xmqqikit3kgo.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Mon, 11 Aug 2025 23:55:34 +0530
X-Gm-Features: Ac12FXzWkSRQIKJQRdr_4D-lPWreCeBvWRvaYkGJ3cbvnJq5SCM_f170NuySaOw
Message-ID: <CAE7as+YdYmmUvVxzY+CeA2vNU01av_QtvsmcUTy=FibqVRrudA@mail.gmail.com>
Subject: Re: [GSOC PATCH v2 1/2] environment: remove the global variable 'merge_log_config'
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, christian.couder@gmail.com, 
	git@vger.kernel.org, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 9:43=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Hi Ayush
> >
> > On 11/08/2025 00:45, Ayush Chandekar wrote:
> >> The global variable 'merge_log_config', set via the "merge.log" or
> >> "merge.summary" settings, is only used in 'cmd_fmt_merge_msg()' and
> >> 'cmd_merge()' to adjust the 'shortlog_len' variable.
> >> Remove 'merge_log_config' globally and localize it in
> >> 'cmd_fmt_merge_msg()' and 'cmd_merge()'. Set its value by passing it i=
n
> >> 'fmt_merge_msg_config()' by passing its pointer to the function via th=
e
> >> callback parameter.
> >
> > This looks like a good solution
>
> When fmt_merge_msg_config() needs to read more stuff, the callback
> parameter may have to be updated, but this will do for now.
>
> Thanks.

Yes, then we can create a struct and pass the struct instead, maybe.

Thanks,
Ayush
