Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08FE1A4F2F
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782600; cv=none; b=QWVxZWhf/dg+2XwPQDso5Kwe1plarvPFZsCGVR9+6O6BW/9qvihTC4Te829yYd79/1Rxqr9YfHv4ZjDA6KIAVQBPbQDKqcrxlQ5vhYPYryCotnZwQHjtG5mcKysV60hb6Gc25p1pmZnRnR+cd2DPKIwnwA11QSs/gRYOFK5EE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782600; c=relaxed/simple;
	bh=2sQQ+IS/6MAnA+6VsCRNcPcWfJYwSdQsZpKTi+hUGbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t33M7HCE7zybshBq3jN8o5idzyIpMq65u08QtyltfGJ7Tsu6Bdk+sbPH/IqAOFANIVbAhktWlXlV+eraLDD7BBTRUJGpB7nIFF1AZbK9GLiXHj7wUOFxKbomGWmA6plkUwm6VwNuRSSlj6WmIh9q8yxdVUg9GMfM8ncZFptql90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvWSgc7t; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvWSgc7t"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4be66ac7685so96292137.2
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 00:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739782597; x=1740387397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlBJo3PQpjP51sVXeYNbG2JN5k/8BW4LkRPeDddr4Lk=;
        b=QvWSgc7tZMQg5evUaTmq2mjxHHrgI/YawDvjqmlRoufHXA6lfMdO+EG7LpN2ps1EEs
         6XcpQM0BUbmHpzvIRFySGDUr1xhRlUUFrk6jXW3BgPl4e712t+93rX964JmH0Iu3IKvq
         6EgoOWaF4QnDGIhesPfNEpVh5BTkeFutIl9Cf54KB8vbxuyaSMAn6OXo1giyj3JMag7H
         KKiKer25HBCqvwh6Hc1vS1X6opRcEZG0slkphb7kQVTw73ntBcIqntbqODT5Mwrfh/Hp
         7yWGY99nz5R6AzOKEEeZXLcBdyTcs1xAPv6nCO56O+3fLl4Ez1ZlrgGSQEf/vvI9BQBz
         jRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782597; x=1740387397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlBJo3PQpjP51sVXeYNbG2JN5k/8BW4LkRPeDddr4Lk=;
        b=pTSIRpN/u4q684lXDv32a3DNxFaMzKM4hje55lfMz5rtz6knpnu7WNzCMXL+nWYiQP
         gnLwWxQYklcyD7CxrlX96zqHoTKKRSbi7azAcM/yfq6xTrfO3X+rGQGmqVpTWpehLLE3
         Y3dhk037FSUwpSstWXs/StXF4vOe20kRIX7kKN0LYSmYCWgNMLqBKX+Da6Z/DT/PGBsg
         3/WJq1/IGZ3bChQAaFVscCMC7yhOoxxrREYC4p2wkWn4pK79CVh/eduhuCCTgoI2YYIO
         wGQVLzMosju4uKLKnTcW6VuCt1fammyAOiZFEvfHnuBNT1jm3NOfag1kTtAi8o6e1hGr
         n2mg==
X-Gm-Message-State: AOJu0YxD/eLaiVn2OSqKWlHgHL+VHUeMeyCNwzv7g7I1kECnC+nKLbJj
	G6awQAJG+v45jmJIEFviGGaom5tGRgCTBU/hXGYZ7PE7uU+jb8YCLGd+/mD/zvclIMlZlme7tAw
	iLRiGtmS7cj0m1i2+iRXJ5nF894U=
X-Gm-Gg: ASbGncvTfHw8V+SETHfpP56vJ8bo15YqkZxbbW4MO2TDO0Z5phvGJrRuBJHSxoM3LeG
	L+foqZ/OeWskmbtMhcPRamwWV/rzDXBYSgyIcYLze0osZUqa0YuXpCZa2oSeikFwN9iFzx/j7
X-Google-Smtp-Source: AGHT+IGXR6ASv+xvpnQDSl5WgNa2KvW6JOaq6YX6w5bZ/6xSlR2+Nb4uKwonHrHS03iZ8gSrLcVxPYixCL+xPs5dWXk=
X-Received: by 2002:a05:6102:419e:b0:4bb:9b46:3f95 with SMTP id
 ada2fe7eead31-4bd3fc79d9emr3870508137.4.1739782597681; Mon, 17 Feb 2025
 00:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com> <Z7F6oSEkg4JSs9bp@ArchLinux>
In-Reply-To: <Z7F6oSEkg4JSs9bp@ArchLinux>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 17 Feb 2025 14:26:24 +0530
X-Gm-Features: AWEUYZntPP8Hj7xigvUv-7KenpTspoYdL8DFJIJVkpjZpb14iEF8k9Q8Tx4pXN4
Message-ID: <CAPSxiM_yzxTV9=U7amxZF_hxt77D42tsn8H4HgNW9S3g-q_-TA@mail.gmail.com>
Subject: Re: [PATCH 0/7][Outreachy] stop using the_repository global variable.
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, christian.couder@gmail.com, 
	johncai86@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 11:11=E2=80=AFAM shejialuo <shejialuo@gmail.com> wr=
ote:
>
> On Sat, Feb 15, 2025 at 04:27:16AM +0530, Usman Akinyemi wrote:
>
> [snip]
>
> > Usman Akinyemi (7):
> >   builtin/verify-tag: stop using `the_repository`
> >   builtin/verify-commit.c: stop using `the_repository`
> >   builtin/send-pack.c: stop using `the_repository`
> >   builtin/pack-refs: stop using `the_repository`
> >   builtin/ls-files: stop using `the_repository`
> >   builtin/for-each-ref: stop using `the_repository`
> >   builtin/checkout-index.c: stop using `the_repository`
> >
>
> The commit message is not consistent. We should remove ".c".
Yeah, I will fix it in the next version.
