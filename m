Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92462A55
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757031697; cv=none; b=CE+N/swY9+vEXITQ/fQEz+96W38LlLIjiTZpNmLDbkeSPBum4+zy950/p5ed0NzrSthKLlmCayiDKe0DzHG+dcKUvxL74VFeIxRsdl/U+nNR6hisauoZ9eVsS4GHL9LHJcnuLUM1Mge+YBtJdHmZt9+CDEsDXQvHuFp5pQ5m76w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757031697; c=relaxed/simple;
	bh=5f8jPOi/cs1Vebk+u1w0ZIWnb5dGRwNcOu8YAZwert0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DHM6q+EpM6NeJ1G1kiNCAATAhCIML1SqUWXykEZwrX4htDmrW58ftes91vP7RrEN6l7K/O78qrfmJfbAfy9u5A60YnwV9XYSei1gvdX2XdrKX5Vw1z93zdyXXcvJ8coA7r9l6gfjevnWZqw0KlEV2FS3nttfY/ZLG1V1LlTGOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0vF6HJR; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0vF6HJR"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d605c6501so17264007b3.3
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 17:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757031694; x=1757636494; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBOCDsTVsXvZiYWjM2EB9FRioYex5qflYlq5jGvQc6g=;
        b=m0vF6HJRsPyf+wtyVAU4Etl6tF8pfFiS4Lb13fU2pME1HACtA5h/yHLR9i6Siog1cw
         DO5LC+MQlInQh5FIb8tQ/U61C78s+YkdO4pEWi4XYb9+KMK+Qy+ge++qx+bY6etxfb8h
         lmJyewDpGDL+S6TNS9o2nZpOV+DO4ik6eene7u4tzUpVc15jvTtUWzbBJzi7kWOMMaCE
         Cf+4L1n6to5bEI9+Z/2oaRLdQpKq42wOgirJBpw2z11VaM4Oj1CJz1A3DwzLar+zHlj/
         XRnPP4Gd1su2rtvjjB4IdyN8aHRA7eGDH0X0KOIKR2vkjPfQoCFjhIWYwnPIZQbVIULA
         qxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757031694; x=1757636494;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBOCDsTVsXvZiYWjM2EB9FRioYex5qflYlq5jGvQc6g=;
        b=VJ5WDKUceGIF76cAF0TNXTCwbb8O4sQLt0qH9rrMNSznafl3cGgsami5X1MrqONu05
         QsVxFr9VJTNIOSJqOhdJlF52X6mtt78tWFE7Hz11GLbD20aUj9xRHlyeLEx2EuEkOIqx
         11WUrIudFPOFz9KsRmMtCQq/YNJxt6WYt24MdM8oMrpJkIbMDVSufxs7BNeCBqOs53Ow
         uoH4Ed1B0YWx26TghDTC0fvjuPkfj1tfwa7131GHe9NCbc4SU0HKfNTrVmTQLX1rIJAS
         6ph1LBdGbWVQs1b17b3FBqBACqUToZHki+a2GPHLC2Zaz8ITlSDmcIjQfxstBcYvyO62
         4gMA==
X-Forwarded-Encrypted: i=1; AJvYcCXoHIpytLdIM19lc/xYZMCVj4h5GTZfmEf5s2G3tt/OlJ/zOmH+3n/6EK8ucSIWZGptVgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHMmKR8D/D6tE2bNi0WdrnRSYIXJiS26bAcKmunw03rhp6gTgS
	mmUV7HS47LeIKC/JYjiVgcNURln2VVb/NbfVF8+6xFM2QTMPz3O+1aGx
X-Gm-Gg: ASbGncv/qmxAXPJxa7RWE+vTDZPI10S8jqcD+ilqAyEskqnXFwCUT6/VqbukyT1zo/a
	nPCUxCbi99IAWz/8kW9jQd2JfqhNPbAb66lVguighDf73WuPXffzUrVd9sXl5qLFSTuWas1eHPn
	Mg5SpiSYtPQrAG4+gIov/6C+zFYnB3/jDDvGVthSGaUgo5U5kef51TK0xNZeF+Rbe3FknIR6Gl2
	0Hoc9SQsAuwVE1HsZUPUSZnqz+HjdHDOb6U13EFF74+1pVqV++tIXh49PY3ZnosRzHJIhsxpQZ8
	tlbxReLhiBhdg7mJ2F97Dii8cyBtx/Bpd0oSJora7t2Nd5kXR2YddJPh5b/uKpeANCoIZSASoPU
	K0PeF0EJzmMbe2RpeiEg5ruK4e3wYgZWGiXpb/Gjz8JW3osaTTw==
X-Google-Smtp-Source: AGHT+IFFCmxnqBPjR5R+MxDGtz8cqqott2wN0TpYZPb1KfLOHWe3JWyWSbJr8DKeImzZ0vVYzl1dyg==
X-Received: by 2002:a05:690c:45c5:b0:723:8be3:a678 with SMTP id 00721157ae682-7238be3a833mr139624997b3.40.1757031694287;
        Thu, 04 Sep 2025 17:21:34 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:3443:acb0:c14:892e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a85aaac9sm25184927b3.72.2025.09.04.17.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 17:21:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: What's cooking in git.git (Sep 2025, #02; Wed, 3)
Date: Thu, 4 Sep 2025 20:21:23 -0400
Message-Id: <B980B743-2034-45DA-8829-998034381BF3@gmail.com>
References: <xmqq7byeb34a.fsf@gitster.g>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
In-Reply-To: <xmqq7byeb34a.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)

> Le 4 sept. 2025 =C3=A0 12:21, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BF"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:=

>=20
>> =E2=80=A2 Incorporate Peff=E2=80=99s patch[2] if I=E2=80=99m up to the ta=
sk
>> =E2=80=A2 Then mention on the whatchanged *hint* that they can make an al=
ias to
>>  shadow it
>=20
> Hmph, I am not sure if training users that they can always alias
> anything away in order to keep deprecated names forever is a good
> idea overall.  That way, we will ensure that newer users when
> watching over shoulders of more old timers will have more chance to
> get confused by unusual synonyms old timers would use without any

They stand an equal chance to be confused by my unusual aliases and scripts :=
p

> advantage over the more modern ways they have learned at school,
> other than the "mustle memory" of old timers.

(Most of which I try to update to take account for modern Git CLI practice.)=


> But if nobody is disturbed by that idea, then the above two would be
> a reasonable way forward.

Agreed. I suppose the question is how quickly the changes should land and re=
lease: were you planning on trying to get these messages out as a fast .1 or=
 similar to help quell the noise more quickly? Or wait a while for the next n=
ormal release, in which case baking a few more patches on top seems logical?=
