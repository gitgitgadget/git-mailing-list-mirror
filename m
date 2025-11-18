Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4E286D7B
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451710; cv=none; b=Y+r7n6FroYy0h4Yp3+J9i+jNRlRvgXEK+PQ3wZTOfsPrKegFLULTwH8dclQ5DV/YysYgE7rf2Dhwla9kTwthLOicxxc/k6apZHlb3D2rcBkBNUlbPgHFfwLV3mAHqGlthEEeogQdkbn1jyXS36ov92/fhkx/ehzkTiobNlhGMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451710; c=relaxed/simple;
	bh=3nMVSZJlgUX+pLHETDWKoNUcZdo/M+Py1Cs5Nkzr6YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7zbTVFBTO7aeUHfnSo7ENShnyVtqPbwnk4tZyCkxBpHba6I34duhTIYGhhIdG17gV9nq8ucJVn1M53Li5NnmvEPZDns6LX9xS2AKBLFwX/K/E+i+jnHhcakm+DZONmkvV0R2nlA7MdxqRmidVCnGB+Le9rJ3/28lmeASQ9CmEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyUh8O3p; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyUh8O3p"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-641e9422473so3438867d50.2
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 23:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763451707; x=1764056507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nMVSZJlgUX+pLHETDWKoNUcZdo/M+Py1Cs5Nkzr6YQ=;
        b=HyUh8O3pTvCfiOq2bHrDrFa1AVBFK9kH3pFV9nCRaTntPCcQoFOKgGWVzZuY+woy1T
         UBeH7777w+CpXDAvrCo3cYrhdWcCfH8e1O1m+2uqQa33wxJo97AikISHhZAR6t/WH+Ih
         EjJTlvUkTgC2yR9K84Qck1w5NbnTyK6hE/UZODYaCtRmKbQn8VvqPxRzd0gX0yKB/2wx
         bMZ5eGXdlGU2CJXkno6EgGB0XZUqgHMlGCRjg13T+OKQTIp5q5tvuQfe1DPtpfEX3J5L
         dsvjRvyfn1m2H5Swl2RxLEtJKkSg8AlqVqSibpfycnJspQea/CWePjit3057ho+DalpC
         ljMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763451707; x=1764056507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3nMVSZJlgUX+pLHETDWKoNUcZdo/M+Py1Cs5Nkzr6YQ=;
        b=T5L796aMhVbzSdrafQXTTHLApWoI+JODRMEX9BTdew5j7TF3E6tgSjgh5fNYktBMbg
         aGfBkm8Yrqbr9mLh92KeZUNgcvcFvpYBCwr3IED3c6Rdgm9Pj4K6lYD0uZPt9SGQr8Wf
         PxRNw+2U586NfnJV3PHX1TSEcKYMUnDaaQMm+h7tEBmB/uMbj4Dif9HX0FI/HGX/4Lnf
         PBugA/QbhVR/FzFSCmt/7fb1U1+hwL0l0mS55IbRiwGT2i5xP8XQIX+rXAO6HLTCTjLz
         wEHsyFA3H94IJDJ5t4QCbvLFP9OZfCXn5bdZJbWRAC00SpKX5RsiyOzmCk5w0pSbfd+Q
         YD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhHw1GUQJ7EEaDzISuf2XJmnQxDPr/+RRZVN4b9RuwDpSxwWsq2jrRWiq0M6U7AbQC+fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCt17eiPACZ5NetWM/0ZYVHSpUht8AS5+3K8OFyVEjf7ZWID7
	SQhQajNoRx2j7S5w2butIWQQMmphWzzh0Ygzr1PBZCaycCPSs+1RUbQANvN+Tev2SB3mGzzkt0Z
	QNhyJzvYJlmmFmCrP99mkfZqSv35aG9toKaNxzqg=
X-Gm-Gg: ASbGncuzeriX27D4BNOStZWFF/QQsbip53ZTX+ZlL9Rl3sdpN5SNJ/ro7sjaGvoEEXA
	T9kcwL2l4YxIHUpFH0cFDW/nXYnG5yb3VRJGXUMm4Sxeb8eayc5LsKRNpxQFFKbT9YNl/t661+q
	R0zQkIuoRL87ARVIExz/WgwQpnaIz8MQ1efN7D666+a8Yc/QUDNeCPdiydXsV7RRQb+VwPIVcwe
	CPNHBi8Nba4KYs27zp9w/1OR+MXmP2bg0+5AmYqtbDI6WQgbP1TfnD/cJwjTf99iJJ886+8
X-Google-Smtp-Source: AGHT+IFJtYnTxnTMbxzzyMAcMjxVougpHNmMmildd/kI0ZByuij0dtas/LTX4gq+CiFYAGqYk8vEMUQ8zg6gPzScCNg=
X-Received: by 2002:a81:fb0a:0:b0:788:121:f8d2 with SMTP id
 00721157ae682-78929e2da54mr190135177b3.20.1763451707601; Mon, 17 Nov 2025
 23:41:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cb24b29c-1fa4-8f01-88ed-c6f02a1bd990@gmx.de> <ebc68ec5b2abbc4702b94f833b9b3bf1adb79f1a.1763450087.git.zhiyou.jx@alibaba-inc.com>
In-Reply-To: <ebc68ec5b2abbc4702b94f833b9b3bf1adb79f1a.1763450087.git.zhiyou.jx@alibaba-inc.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Tue, 18 Nov 2025 15:41:31 +0800
X-Gm-Features: AWmQ_blgci7s7-fgexRUDupJwfA7-W4pBrhPO-FippVk_oqGihB0NWaPzaSWJjE
Message-ID: <CANYiYbEKVfTJ6+yZ6Z33+WNmF1DzuUkrjcN0MgL71p26Gwaa2g@mail.gmail.com>
Subject: Re: [PATCH] ci: bump actions/setup-go from 5 to 6
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 3:26=E2=80=AFPM Jiang Xin <worldhello.net@gmail.com=
> wrote:
>
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> Bumps actions/setup-go from 5 to 6. This upgrade includes dependency
> updates that incorporate a fix for a critical vulnerability.
> [Originally opened at https://github.com/git-for-windows/git/pull/5811]
>
> - [Release notes](https://github.com/actions/setup-go/releases)
> - [Commits](https://github.com/actions/setup-go/compare/v5...v6)

Hi Johannes,

I received your pull request[1] in September. At that time, I should have
resent the patch to the Git mailing list like the previous email, as I only
merge l10n changes to the "po/" directory. Sorry for the delay.

[1]: https://github.com/git-l10n/git-po/pull/870

--
Jiang Xin
