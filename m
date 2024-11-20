Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9A157E88
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098342; cv=none; b=Kkj5uNeTx7uRZ/v0iy8dJt5oQE8Uhj1gopI937q23KIu4dgSC0r8TpC3cu+HYRrGo59FZH6WdDqbCwqzPLG3P1TVXOQs7WTeoA1WMoTgP12QfuTDtt/5ZgDsi5ir8c2x3yfradRgGSc/1Oko8xlHy8eEKe4ppM3GEpDUCl6SNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098342; c=relaxed/simple;
	bh=OvHwvSHt8mkfFij1XliCGYqZMWHwceFwPU3QlneU73s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZktFx3Ke13mVQ2cpfQR/cs2PbCzZZFUVdKhx8AFR0EO/eZlHa5ZyVhZ9fF1jTrd831af5nMngNghJj0Q44lFDu/JBb0DBLrf/pLXH5Y8ShYZxpYQcJqZRyzeRwkpbR6H2IqZLDLzkn4f1OcRvqJsnSvfOEW3IybM3GRqDcIC8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lmj4sksY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lmj4sksY"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfc035649bso5018159a12.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 02:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732098339; x=1732703139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvHwvSHt8mkfFij1XliCGYqZMWHwceFwPU3QlneU73s=;
        b=Lmj4sksYMNz0XfgecovG7lbT8693M5ZVSNARKtiEYOH7B3YZ790y/3Pd54RgOM4po9
         FrQD+E8WIHd3YIoL2US4wf9p49DipEAVqr0K3wwaW4kzrJ9/hKYzKvJTXFZYldyITz1o
         WsolgIKedzbWrSveJWXseO0/ouFHGmeJNVmB+m5Q2aKESTY8LJq5aBN7HIiXmZLjwKqJ
         zSkoW4RU2AEW6iAHfavyOAJM6WMq3hkWAeNWgpipUkwzeR9yEvUjJnWLKoeQ85BDmNWj
         jJDwN1GlAQ8ZovHoJt5BXHcpQnCSfMVA/edQ55grkrf9GVb4MKfPAzY1pxzUZ+7Nf52H
         e7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732098339; x=1732703139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvHwvSHt8mkfFij1XliCGYqZMWHwceFwPU3QlneU73s=;
        b=pyc+bDRL1VBw1q+oPcWHtveSMY96IMm8dOaflRN2yblwhRjU91LLn+1nM1Hxqqx2+I
         ABClg9Z+e4HdJ66Ncr1qfueOhdypU3XstZc1xry8Xb+QH0DEh+1E8tqutA+Yveld26d3
         L5E7he4ywzndV+MpD56lzLdNiRllVHsihA9DpUVr1yJ3+kQt+joHA2MH5gukkFRRUtVs
         42jmQYihsrkfJA7mJKfF55f9jUS0SieeVy9cR9+zbklNDFYyyVTUl9XtpDx1JOExwKdQ
         +UsqtEPIRhGYLZO6NuCjoJm4gT8WlUOpoS0c7UkHAA+FHEoHwznxenxeWmaJlEE8gMFa
         lSOg==
X-Forwarded-Encrypted: i=1; AJvYcCVpMLy5jQ0KPhHpAN+K3lcwQjnZ3ySfE1C7Cnjb6MNkoAPaWtBVkbhsb9XEgW6xxVynTEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+n9IFcNGbftVFak03CG89KdhViXRfBfivl7aTgkV7cwgVuEJ
	CmnbmyePen3RgYeDnfd4KZqANFpn+h77P/EY7Q2o3QT8NcU5USn8wRYnY0z7V3aSOsp2w3ABWTO
	HWR9OqQEgF7lpnFB/eT2qzCWGIKc=
X-Google-Smtp-Source: AGHT+IFm1hNTUKfYm23hWQUOQUvkhHPNjkqHjbyhCsYXhFeMKCKewMYz0IkfTYswTnbb43AARAzG1nNWedhBPVik44g=
X-Received: by 2002:a17:906:da85:b0:aa3:1ee3:2ac8 with SMTP id
 a640c23a62f3a-aa4dd56e59amr211663066b.25.1732098338734; Wed, 20 Nov 2024
 02:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
 <CAOLa=ZTGtGJDnMmuv++FS9Rv4KiRQewOepo_qOY=6h1xtNmNZA@mail.gmail.com>
 <ZzH-OaXmFcZkGE43@pks.im> <xmqqzfluidwo.fsf@gitster.g> <Zz2UtKNnREAJgtaI@pks.im>
In-Reply-To: <Zz2UtKNnREAJgtaI@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Nov 2024 11:25:26 +0100
Message-ID: <CAP8UFD1vLm5G=+K=b17_JGCvkm01BmaLE7EcdWhGO6bPWyJ9hA@mail.gmail.com>
Subject: Re: [PATCH 00/10] refs: optimize ref format migrations
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, karthik nayak <karthik.188@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 9:00=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> Sure, let's do it that way. Will send the updated patch series in a
> second, thanks!

I took a look at the v2 and found a number of small nits. Not sure
it's worth a reroll though, as otherwise I found it great!

Thanks.
