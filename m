Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9388730FF29
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727766; cv=none; b=JqMfjRzjY5SLZMfb0K+Q7/rfXmsEtUQ52dQowJ2tFf6Ql0rBXEJHmA8S6XiwloPIwYY29WheqJSB84bK8t22jngNu2+BdPMpoucOXshGGNRLndjTRGxs8yXIetvwklI8lD+f+zpqOg1ozD/FXthasM2QdGluazPSI8oa/0Lw1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727766; c=relaxed/simple;
	bh=Bz4Wmq4Xhb2+pQRKOCdNGrzxgSD1xQe2rRtTM4tlJ/Q=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=prJWspNOtijT1YpcOv50KPPMzFLPrRA4G7JlQnzqPTOKUsTr2sHrVwk1tgJjBm0Q6pX8dJ6cf6mQjOpBwxsQKDVinyBlFgxVtqnVH83UszgE3d4v4U671K2AbY6NhOeNyKIMCC7+Iyo1G5t+Wid4zDN3+R+S7nxf8APGK2lXS9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsLck6Ew; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsLck6Ew"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-60170e15cf6so4551565d50.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758727763; x=1759332563; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHxZx0chCYMG1tzfNxPLxo93Bv3xu8hVEVjGmb3TLfM=;
        b=YsLck6Ewrej3tM0kGzZhY68eMHBIJhElHAkaVN7Pr9f5yNu7mejYQ0XOaJ5EH0BXha
         rrrqxL8I6VGjIgMBguOUZu3SN42RlOsZit4GYfLCSkPDlY+gc84jfzDgi0nQnTJjHgXq
         mexRTGnBEpYlY2IiUKkeZAC9ipJF1OLiZcAHdb4f9c0gVGPVo1KBZIDlD6evq0YK+Uft
         UvDhuHIEcsI8nAycYyooR3o0GjwXaKXnYgdtDfS0IvuIIK7hSHkOat8cikv8zsch1CmY
         i58cGV6PvuDtcpacjF/NDxq+lWbsedTwTh02kue1KM7UNcJt0vvNn/7qz265vlPAYm58
         Kc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727763; x=1759332563;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHxZx0chCYMG1tzfNxPLxo93Bv3xu8hVEVjGmb3TLfM=;
        b=l3tUBiO7INh9GKrvAw1Bu71tLLFWKux5xrCQ62eUSQoH5PgRdMX+pkY25ANLB6D6GA
         +yfxmyX7+EkEXItioYLTXmakGfAnLX4WCzAnYJBQx20HJD1qa42nYxBHGU7sjdtuBoat
         JKhO12JblOiNRbCPZPfC3h6s6SYBEbSE9cRPwOEy/JoVxZwH07Okrj1WChlAOPyEigT8
         c7pCNoLMJqwDvGx2Asi6ZdfU8+BOXkG1B/k/CbIe6XlK8Th+N4KPzcAIgqY2iOjfcEHH
         dXgHEbp7neZonb8h8fXhzXHedsu6VNayc0n1YlmRNqdfErQvYPXchujn3400HMO8a8Oq
         1Oxw==
X-Forwarded-Encrypted: i=1; AJvYcCXlcycaiJ1Ku+OlNZcsR28qg6FT+YQlvDkOoljHssdaulGXWMh1h8hsdpwBGa2fDtKKX+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzooCY5JKEidAh4PdjoiL8HoF/LD63Qf6lwgK3DspXUT6UkNxID
	N4owa8jRKhXkDaqRhlx83zDMa6ljjjOn1ez0N0+x7QBn/aCiWFZjA5zb
X-Gm-Gg: ASbGncuqp+8J+u/l+01vaE6ny/b5m5NFXIxD3STWveOpTVjzD+Q+MnfVlWk/BunlH/k
	qSpDDqK9LNlzsuuIUonGdvDqLrB8gXXe+UdGt4SWG+7AQTk880TyoypnVE5Ffx9chddTFwOyalO
	5bkBp+enSIhkjvL8uQmEKG3rqgoK6kjP6mHn9yQz2hwlzAIm99JjgfvF8VVodtivs7J4n9PKdTx
	J8F+70PS1nrmVLnAyFVF8gh8dYdCRg1cs39FJi7Gnh05vf1u0ZWu+T/tjeW+3li1FYfVsR5yhBE
	bq5Gw4bwinfDSarLCqTgSJO3fhn+klBWA06s3NQrZ+oLXit0/0RD3o8Gv+rntLD2ZFaq40zpaGI
	E9daG+SP1xBWAPY5zJop4DAlII+S6OOnifN307tj4N54XgeWn3xH9V+QtOACAkA==
X-Google-Smtp-Source: AGHT+IFEjOY6UOgyMZMwfd99vtZsYQJ1v7SjIrqAfaLNGSuti/P+VqZ29gzM6RpYDMnN7sdEUEeTsw==
X-Received: by 2002:a05:690e:1599:20b0:633:bbcd:5837 with SMTP id 956f58d0204a3-6361a742ac2mr88353d50.20.1758727763072;
        Wed, 24 Sep 2025 08:29:23 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:5194:54a6:d414:9d55])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-75d312ee6d1sm8166587b3.56.2025.09.24.08.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:29:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [GSoC][PATCH] builtin/refs: add 'get' subcommand
Date: Wed, 24 Sep 2025 11:29:11 -0400
Message-Id: <4FEB2B85-FC32-4076-9DA6-F47AAB096CB0@gmail.com>
References: <aNOQhncjwYCwCaZ3@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Meet Soni <meetsoni3017@gmail.com>,
 git@vger.kernel.org, shejialuo@gmail.com
In-Reply-To: <aNOQhncjwYCwCaZ3@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 24 sept. 2025 =C3=A0 02:37, Patrick Steinhardt <ps@pks.im> a =C3=A9crit=
 :
>=20
> =EF=BB=BFOn Tue, Sep 23, 2025 at 02:50:46PM -0700, Junio C Hamano wrote:
>> Meet Soni <meetsoni3017@gmail.com> writes:
>>=20
>>> While `git-rev-parse(1)` and `git-show-ref(1)` can be used to read
>>> reference values, they have drawbacks for scripting and discoverability.=

>>> `rev-parse` performs DWIM expansion which is unpredictable for scripts,
>>> and `show-ref --verify` is difficult to discover and cannot read the
>>> direct target of a symbolic reference.
>>=20
>> Well "refs get" is even harder to discover (it is not even in Git
>> 2.50's manual that is available everywhere on the net), so difficult
>> to discover is not a good excuse.  In a sense show-ref was invented
>> exactly to serve as something like "refs get" you are writing, so I
>> wonder if a better approach is to extend it instead of introducing
>> a new subcommand in a distant place from it?
>>=20
>> Perhaps "show-ref --verify --no-deref" or something that does not
>> dereference but works directly on a symbolic ref?
>=20
> For now: yes, it's more difficult to discover for sure. But users will
> adjust over time as they get more familiar with git-refs(1), and from
> thereon I think it will become significantly easier to discover that
> subcommand.

I think this goes to perhaps some of my unasked questions: who is the target=
 audience? My experience suggest that most mostly-porcelain users don=E2=80=99=
t acquire familiarity with scripting commands, so it sounds like we=E2=80=99=
re talking about script-writers here (and in the commit message).

But how do we encourage script writers to discover these things? =F0=9F=A4=94=
 Hm.=20=
