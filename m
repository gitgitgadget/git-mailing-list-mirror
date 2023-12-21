Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C76BB3D
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtltBKRW"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28bd8e76024so338507a91.2
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703155418; x=1703760218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6fRy5oor5MlCzaWe2ygoQhhSbZh8H00fQ7O2dhcoxg=;
        b=KtltBKRWMKOQzhq6DW2T6BKz2Lm4bXDGDYwJJUvrAVeRdcRJXSBMIKD0jmVy6suyEL
         bDdKeNLTGkrJuSpddxEBif6CGB3Z3l2IjPdYX3au6y3ktjCVJBvFUkVoYjMuZDTtYg+P
         H2SOrs0KAjQIjb1ysEn6wtFvChEb47RVI04AxB6qiHzMIt3bhKovjhWaKGj8z4BJpSUu
         DRv00poYmjQ9ySEvMMsxpIDgMhEtxJlqg/lJp4zUlVP/s6eLVoYQmGf+1pR4QNWKWFDr
         yLbxygXxDb8JAfTwkGk7+PRDt41Vv1qa8rBeEfOzxlZgWMPSYOLSl14/IADLoduXspNb
         wRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703155418; x=1703760218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6fRy5oor5MlCzaWe2ygoQhhSbZh8H00fQ7O2dhcoxg=;
        b=uEqaTuFX4WXF5stWhpMwuWrMUYshP/d3LDhaHCGeBqf/xQ7SxHFUUWBLJlc/MIgv+8
         Vq3cn2+Tlg1AhYDj8hyYC1Aw5UBSRdy4Ma9ZHN21wUcUJTo6C3HlT3xftg5FfVfxrnIv
         tgp0VdPd5WsGa8YyOHOSQ5COTutji6p5RYuVQCrEorM032Aodfms36RuPQYbNZthPbgq
         vHSv6rbUSHRJlyDMoXROzQJbTeA08ICR0T4zebD+9/jRKnQa0tmi2Ey+JDAYZ5fcmpub
         Xg9iQtNAATl5eFg0p3lPoBR0GvXWPulWabbGToWRJ0s+yhQsaxjBBGtcsh2q51l3quUN
         0Qew==
X-Gm-Message-State: AOJu0YwUsIGXzAGIIcv+uMijW25zqjjIuHBqnOLNcTYibL9+Zv9hRrMC
	K1ZhDl0rInIFZ8ZSqFqjOwyYTRo0lClP6qMs2zsEWvHdpRI=
X-Google-Smtp-Source: AGHT+IEuo1P7Jn1RprEw3H/XWJS/jgOlzlJTD0/WfphGt5buzKGC6CtKKSZ2kKjkcqD6eDyk4z6f2S9Ey73UP8s9vKQ=
X-Received: by 2002:a17:90a:3886:b0:28b:d854:4fbb with SMTP id
 x6-20020a17090a388600b0028bd8544fbbmr1337839pjb.59.1703155418420; Thu, 21 Dec
 2023 02:43:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700549493.git.ps@pks.im> <cover.1702047081.git.ps@pks.im> <02b11f3a80608ba8748a0d0e2294f432e02464e5.1702047081.git.ps@pks.im>
In-Reply-To: <02b11f3a80608ba8748a0d0e2294f432e02464e5.1702047081.git.ps@pks.im>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 21 Dec 2023 11:43:27 +0100
Message-ID: <CAOw_e7bQ+jxO2zhj32mDksq9uBKQfNt=wMNP5K6Oy1DqievCdg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] reftable/block: reuse buffer to compute record keys
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 3:53=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:

> @@ -84,10 +84,12 @@ struct block_iter {
>
>         /* key for last entry we read. */
>         struct strbuf last_key;
> +       struct strbuf key;
>  };

it's slightly more efficient, but the new field has no essential
meaning. If I encountered this code with the change you make here, I
would probably refactor it in the opposite direction to increase code
clarity.

I suspect that the gains are too small to be measurable, but if you
are after small efficiency gains, you can have
reftable_record_decode() consume the key to avoid copying overhead in
record.c.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
