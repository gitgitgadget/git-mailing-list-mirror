Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8334BA34
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379301; cv=none; b=b3xbv34l4MVYLo27r/gm7tSg0GTAuQ8QgmG079i7Je8SzyJlX/kQULLKQNQEI4z4b7+pIABuRotdJniq4ebOrm57bJV9xEKmjjIdIJdJgza+8i2kRYKu+EXP2t2NWVfA3TjYWknXmysfGvA7jjg4gP+x0VUhDLj6BMRx4avhOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379301; c=relaxed/simple;
	bh=7XsECvJCDUiMOJp3GuJ3NaSF5GG+uQMYERTRqO6Icho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVHQi2TbGyb+1lwiA0dVNBkDlbFraCD3anCy6lNEtzZWb+xrqpREgFmVz++6/l0Oxnz8Egqp7iZBRPLzf59eWqrcfJyM9Gwspzk5mEokSyvS9YM0ux1gD5fKeeW0CoYCmFnqLPUVP8USqrDLrj6rz8+mhiXML+oBJzgJDmrbj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1mspro/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1mspro/"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-81fdd5d7b59so65096956d6.3
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 11:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760379299; x=1760984099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veAdQ6F7T+MoqWGuSzh/fEfMKe+UU4cHX11yJBUjLQQ=;
        b=A1mspro/CxOoyWTwfYLPfGDeleMJykdNqxQUri2RBtW7gftvaFyQG+1J5UiqCEhYGM
         xVUYkBxEwIbuYky+TR/5E0fiJQzSt16S4jq6KxAe/HfXoq48f3yIUU9JF7H3QZCSkuBo
         8VYIw1JIDPQTR5uZ66MJ+YBybUUymwinxFzd2FgC4sHYT2ed9rdrfLaEWKI0AXiV5W/u
         xqFaeGPQujqavgDSSRDeQ7yQ6/upK5zbS2tBotXLtVHxbCWYt2MKTloUg0gye98FMKSH
         bkY4GE6aHar5wdOHVvx7Hl3tAJkBtgBOLgLvdz4Bu5DpijPwAnzo6UCc0iLP/X1IriSW
         9Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379299; x=1760984099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veAdQ6F7T+MoqWGuSzh/fEfMKe+UU4cHX11yJBUjLQQ=;
        b=TB3WRVcCwVUaRqDDBoWBLQWeBtnvpeiiWofT5GyUhwTEoTfCEhlzmiQAiQIe0xPpq5
         rrCvvawaxDU7hg5xIYejf4DK+JWbEiGlv01MtQx+r8Mt5i7rIQ0QDYhsfjjZHPFbsn/s
         7GbBOXewxKDYM/13zsj6bJiFxxRjzycle7JepNP6py4D3wtvaOM6F+LQrjM1xW94Xs98
         nzZDxh3USYiS7j9pgvxcSR9+9jlvqMSJFGVXjdqaziZX/WzYDidQXy8OkNR6MB/LMHb9
         Ek9yN2GjlHrEV8o4AKZjFJ0IBovRro1OXyxI2CPjcWA/TR9L44lxV+/mgbC+nJbnnX8r
         Gs1g==
X-Gm-Message-State: AOJu0YyTlMFaYIsrUiX5dARPIjZUIubuBHr3VIiB7QTGtpDB8jzaXwaQ
	/L+EGw30wAHWBIxzH3mLjCwzPRVQYkecYNp7NojuSfspRjxFLmAhrVdE6onDzxBNLbMcF5VS3W/
	eEx9yvRSRige78ttQelxSQqFhvaOeNRdsLJbI/o7fHfAj
X-Gm-Gg: ASbGncunebMqLah3me1Q45lcD1wIhHA68vXpyMh5ZP/WtThDyGfhwSZUViZI2UuplIZ
	HzvZQ5QGKzI845NXAircv/l/WnbyieFAAzzYJ/lMTnZzFdgwGa9G7cnglkf2stfB4KzTR/rzXQ1
	0RXAHfWfgTlOXA4P9Lk7vrPA2pVwijTlw1tHVO2PmmFx2AYH/n+Cgs9aQdwFZSvfvrCLZCYmyr+
	RDHk1Tho1hPt+9J2ShyfGircnFXwYtSJriK1gU6CLprrRt9z9aXcWszi3/A6c5cucL+sqOCYjs=
X-Google-Smtp-Source: AGHT+IEjlxKyecyF93MiIXroVzd6uxTlmtp8HvSqj5KwQOVVImcrpSRsMM4uFyNIfLu0kyX42SNtzinMDajKjWELOIs=
X-Received: by 2002:ad4:5746:0:b0:80b:d332:3083 with SMTP id
 6a1803df08f44-87b2ef1d9b0mr336022286d6.31.1760379298864; Mon, 13 Oct 2025
 11:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013165320.201333-1-okhuomonajayi54@gmail.com>
 <xmqq4is23evz.fsf@gitster.g> <CAFpMFfBXhfy7ecBzR-cnGViivQG3AHGrQ00vSTnVY6OdxZPSLg@mail.gmail.com>
 <xmqqzf9u1zix.fsf@gitster.g>
In-Reply-To: <xmqqzf9u1zix.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Mon, 13 Oct 2025 19:14:47 +0100
X-Gm-Features: AS18NWAnqpHShkj4QJ-rCxyyMUnhvmo2w9vPcIULy2R9pPAi4s3Ap3lUrFtbIJo
Message-ID: <CAFpMFfAHA8OfVXKVVSSAQ5p+B8ngT3p54on1HpM+n2qs3P1rHA@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy] patch-ids: fix const correctness
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Thanks for explaining! I get it now the NEEDSWORK comment isn=E2=80=99t nee=
ded
since the hashmap API is supposed to have cmpfn_data as const. I=E2=80=99ve
removed the comment and didn=E2=80=99t change anything else

Cheers

On Mon, Oct 13, 2025 at 6:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > I=E2=80=99ll revert my local change, run a build and tests, and then th=
ink
> > about safer alternatives (or leave the NEEDSWORK comment in place if
> > changing the hashmap API isn=E2=80=99t appropriate).
> > Thanks for the clarification.
>
> If you can convince readers that changing the hashmap API is not
> appropriate, then I would think that would make a great explanation
> for a commit that removes the needswork comment without doing
> anything else.  "Thinking about const correctness issues around this
> code is no longer needed.  The hashmap API is right to insist that
> the extra data pointer must be const because ....  Which makes
> casting constness away when assigning it to opt, which is what the
> code is, is indeed the only reasonable thing to do, and there is no
> more change necessary around here."  Of course, such a commit log
> message must fill in the "because ..." part with a convincing
> argument ;-).
>
> Thanks.
>
>
