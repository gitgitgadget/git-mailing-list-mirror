Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404BA189916
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134247; cv=none; b=ZDO6It6tmovmuGjId+Q3FmTmm9O8xuRZeVu35+PgfbLM9S0JiFpI0uI2eA9jOMivBc/3PSIth5gwZtjRs/W7Kn5xclH2RIfE0PyDtPC7IRQoCz5YA2+o0VfujNykL70ysqxYYYHS8WGaduFKQWRP9iB+MwaXAT872JNrmqk6H4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134247; c=relaxed/simple;
	bh=73MMFQh4/pp1pQUpMO/AA5St5EPj1CDrWHpTesfzSdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJRBq9srUmwpW//kUx67HJOJ4BaIuGAx0Zw+fvWdPoQfV8jRk/vig8NoQRpfAB4d7zp7/RW4Xvs1YM+55ojHbM26wHALUbSo7YHIqXyDEFunZNPoxc135tWh6Q1bADLVdySt2dBAcmLFqLAyCD20q9on7VU0paFqS9PeJlLsdZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbm1AkSW; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbm1AkSW"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53f757134cdso7041470e87.2
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 23:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738134244; x=1738739044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qME+WZzwqOCTjjeTW4U9V8zC2RGtkIHWTkR5ljQNevs=;
        b=Sbm1AkSWAtANpU8pPhvlQrH5B0ClU/6vr+h4Ju1wqJXeL9LXTSscp2YnYVknaFHgM9
         DSR4qqA+94+sOKUcsd29KDignQTaeiFluAK2GuH6+kWLwRU3YqZrKWFp7wae0MMmHrnC
         +KY2xegT0cd4SR8Q1wQe0G7bicRwdkTEC8lQy/h2ttB23jy66hXnOH0o1opUkf6ZxW+L
         TaiGl8gDUY8bSfvdF6vAlz4q7hIPEDwPQfxOr6cy50FfwH/4gqszXZuAVVussbYEZPfC
         Rzd5JquvsrRRoD79z5cZjwcRsEYZ9mhHjokkk5KjfwKaGtaq1rV5/gB9zK4psz9oM88p
         6InA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738134244; x=1738739044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qME+WZzwqOCTjjeTW4U9V8zC2RGtkIHWTkR5ljQNevs=;
        b=JEU/4OAAMS7xL0PWks69+hFERELGi16a2MjrVurbUqrljWBk8UB1q4QyIvBa9vo98W
         GjxOdIhHzknLziXP42PSVa36/wY6wccCB5/MQQ+SaUQPqSo64GhryzDlLxEbi0QpoKwS
         go942s4gtKANbWqNL8SUOQ785PGCSPgqHmflUJ/p+BGuHEW+I3ZoNwgHQJx0N2e2G9AK
         VeYeLUYRY3tcq0FregZ9greVOpYIUnI/8oKedVeztKVd+Xo6F7saQa8nEd/SxZc4WBqw
         AlNCY5l7mjwZWbTulNklYvPIJ22PadgReIYcRxPk/4Ckird0P3DTmjuz7sMT8vPWVnFs
         NXdA==
X-Gm-Message-State: AOJu0YxLquOwCo00Yol5CIsXinWhWAGchDoMRkk+TxP9MqM9dNwv5Hpc
	wDSwzkaZoojHfXJNUQVzilZwIXHnqktXEhFxrwCQnL4bHhXeCZ8/BNn2knX1qIvMtWRm3fP/jMi
	GlWYRP5I6fMDIkCMRCnvYUUMxCGc=
X-Gm-Gg: ASbGnctBpXkp/OiUwLgSOJ/BQoZL+5GX80hYencc105L4t7ZYB6WG62kTgXHqo5NEu7
	TVzyQz6cc7dA/HYuvAJGqN/osOYxrv2oHzpomZNpiG9Ceo/qkkOECe7w7emS2fgOQ0VMM/7mpG3
	w=
X-Google-Smtp-Source: AGHT+IHcMUtYYYKt6EXEvbmeQ5zCqkKMiTb9s3pG97OduPoHgjKzc0v2Hu7lQBJrS8oHp4+vCAFGpm8FARJBQLU13p0=
X-Received: by 2002:a05:6512:3b26:b0:542:7196:d1ed with SMTP id
 2adb3069b0e04-543e4c3b94cmr422178e87.53.1738134243930; Tue, 28 Jan 2025
 23:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
 <20250127103644.36627-4-meetsoni3017@gmail.com> <xmqqtt9kqak5.fsf@gitster.g>
In-Reply-To: <xmqqtt9kqak5.fsf@gitster.g>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Wed, 29 Jan 2025 12:33:52 +0530
X-Gm-Features: AWEUYZn5K46nZnRLCNtWaryXDmpQEgyerPnA-sto6OPdva2UO1sEzl_Y0hRqtrc
Message-ID: <CAPhwyn0tsU-0Tw44DeZssBJnjDpL_mYF6OBGT5sTdSYEy+k4cw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] refspec: relocate apply_refspecs and related funtions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com, 
	Elijah Newren <newren@gmail.com>, Jacob Keller <jacob.keller@gmail.com>, 
	Matthew Rogers <mattr94@gmail.com>, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jan 2025 at 01:44, Junio C Hamano <gitster@pobox.com> wrote:
>
> Meet Soni <meetsoni3017@gmail.com> writes:
>
> > +/*
> > + * Applies refspecs to a name and returns the corresponding destinatio=
n.
> > + * Returns the destination string if a match is found, NULL otherwise.
> > + */
> > +char *apply_refspecs(struct refspec *rs, const char *name);
>
> Explaining a function whose name has "apply" with a comment that
> uses "apply" as the verb does not add as much information as a
> comment with a bit rephrased explanation.  What does it mean to
> "apply refspec to a name" in the context of this function?

The term "apply" was intended to convey the idea of mapping the
refspec with the given name, but it=E2=80=99s more helpful to describe the
function=E2=80=99s behavior more explicitly.

I=E2=80=99ll update the comment in the next version of this series.
Here=E2=80=99s the revised comment I plan to use:

/*
 * Search for a refspec that matches the given name and return the
 * corresponding destination (dst) if a match is found, NULL otherwise.
 */
