Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D012E3378
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849491; cv=none; b=jtafA8nxKAOCZpao6HoJf1DFrLKRcwe6GolLzWINn9uy2yih00oXyjs5Tm52u0wGtxlIHN+zpdzoypC+Wy+l7s52g7g88KTWrzGer/BhIL+J7KfZwIryjJj32j3AxAtkJxMoN9JX5uHMjeaSUN5o9VjmtM+kTugvisz6HDjXSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849491; c=relaxed/simple;
	bh=iS3G1iKst/eN5ExfcNz3PST0PgXFni5YriUt5hfzcpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuyuG7il1dD3MSHjXz/5hsiWl5ZxdbI828aYSsmwn2PSXtUzuE+TnKvoRCriAgX9hqaZkj85yVetEtl3IFymvZ190UwJWJDSrBDTrVjo5ZvtTiQUvPZuEHO/3nNC7WzRCZpayiW+spDvTaNpd4r0CUio519Wu0faZ6Z2k9ZP2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alVHccOt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alVHccOt"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso7565234a12.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742849488; x=1743454288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS3G1iKst/eN5ExfcNz3PST0PgXFni5YriUt5hfzcpk=;
        b=alVHccOtJMacnP7LNkLVuJL/YLEJWraIMTrdYcgUihYV9B2CVDOUvPv2lVnylcd7si
         fRMQ8LX5nO8nzEtIjAc5W0r0CoAcBGW1h5TnWfDUwkTQlF8AjwR7VRPzPlwjB6kOFx0d
         KA58qZ2kDfFFinlhH16U+9Q21gC2Y6QQc3bnkUB/pygr/cSaSM/53yLWBNezqWYT7OSD
         5HqsPfg2oIJox3EaXZ3tr4oqaPfckR+UAwLqmnO+oaUOo1NpeUwNYfvtfxg2sUux7BAc
         tlYtpOeig/pHYyBFCraVIp/EJxHtywdHV5pKfwgNXJ3b2Jq4FkhlObCMWYZNz2kPZbZf
         B28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849488; x=1743454288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iS3G1iKst/eN5ExfcNz3PST0PgXFni5YriUt5hfzcpk=;
        b=Y8uKPcUP9vjhRSI0jJ4OjbtF8WSAsOIZySCyqCfJnaUNCnE606RBydatUif5H/IPkU
         74R/X1SF0JoeDDneguccoFs6oU3WxCDpnSXNu1kGsiCgh7zyTJTxIBc/tYKlJE3HztZW
         sm9NfcYCxInz9FVlVkfZcn0xTtPAgKH+EN9d+6nWT58OWshv6C7x/oWf/JAxMlvnOmem
         DBvtYioriN+1jafummDh4HwCwPJXzAV6XF3NcvUCT4U0VcoY08lMZiAmPCoyWgegtC/0
         JmMrlUbhBJiEWedJ578/npkrIR/BLko/RR1bcdQAIepOtANZmQhy9Bxyj87AdpjMCz8i
         S/4w==
X-Gm-Message-State: AOJu0Ywa3t5McvklL5kpMKu3ozIgUl5CpYfs923AfFfqwCsdxBkWMwT0
	1TUo8QhUHpMm3fK11qFLeaFQV5bcmCe7EEGyoQYqfA2Vu0K9ztspdFoeJeYDBG2GdR3sDM+g6AB
	aLqzxsk2jJouu5RBkQ0eUe/fpdHk=
X-Gm-Gg: ASbGncsHmv6l4BVXGVYYLK9V4Ebrgz+RYww6UWE7dIvZPaoQWGjKhUK82k1cz9lyM+l
	jJO9p5fBQRj8w1aSHE9OxFi8h7oOvpYhzlxTaW3oqUGuOu7iHSsgOtYH+SP2Sjain6YByTgU1Po
	PlHob6HYubOzulgzvy986mVzc84bJZdWhqNbqW9OqcGT9A08lzeQgX0uEdgwpJ
X-Google-Smtp-Source: AGHT+IEA05+UXSG8v4US5CLf+Bdeibt2F7jAIiyIcRc5SaVWsJhSmnPYCBihfNSr7IvqQ7FKAymuFHeMx/UEYwhfNXI=
X-Received: by 2002:a05:6402:430d:b0:5ec:8ef1:35c4 with SMTP id
 4fb4d7f45d1cf-5ec8ef141b7mr6583278a12.13.1742849487843; Mon, 24 Mar 2025
 13:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324204558.76145-1-ben.knoble+github@gmail.com> <CAPig+cQg_VTN7Ug3FTdLdkVwSPZGiQHJZSpCkA2pTxwBiT29bw@mail.gmail.com>
In-Reply-To: <CAPig+cQg_VTN7Ug3FTdLdkVwSPZGiQHJZSpCkA2pTxwBiT29bw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Mon, 24 Mar 2025 16:51:14 -0400
X-Gm-Features: AQ5f1JrNkb-HPUIhdhKct8CpFRznRNSU3gWtz0qhE3MdRJe8JEf0qDJMH4b3gg4
Message-ID: <CALnO6CAcue+fnm8-CYobdraoieXA1Mzh8yb8V4e7N6w73+_ZEA@mail.gmail.com>
Subject: Re: [PATCH] vimdiff: clarify the sigil used for marking the buffer to save
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Fernando Ramos <greenfoo@u92.eu>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 4:47=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Mon, Mar 24, 2025 at 4:46=E2=80=AFPM D. Ben Knoble
> <ben.knoble+github@gmail.com> wrote:
> > The original documentation from 7b5cf8be18 (vimdiff: add tool
> > documentation, 2022-03-30) mistakenly described the marker as an
> > asterisk, which is the character "*". The code and examples have always
> > looked for an arobase ("@").
> > ---
>
> Missing sign-off.

doh, indeed.
