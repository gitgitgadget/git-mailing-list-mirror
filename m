Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB52D97A4
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155115; cv=none; b=D4UJfXQ5CTbFkQa0qCWLaxiGPGaiKA1uuQgoqgDGtdz9YXA9UMKBrpr3FZSkGarwXulNh5ajBmWLMkc2VWiPacp4jjn1xYt8HufwDnKlFdtte/tuKXqRQ3IVnqugwYssrEG8S0u3sBw0pP4LH05TJZo5S48t26s5U/S1OJ1yMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155115; c=relaxed/simple;
	bh=NrC7dA5Xoh7WruUTn4LSAZ/eyGyOkf6APWIDF4JqcHk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=KQRwb5iyq78Ou+f4SaCXq8jqOWvJ+7gjClC7/e1CHNKSub9or6bTfzGU586IftS9K8fCdvSyNp9nHCa7lTCPVnOWmDQ5TUiVjAtZRh4DoIQTo2qOKd845xS3mTOOz2IgMANzBmomqi1sJk6w4+NR7mBPwKjMxoV8k5tU0kUPS1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws+pVBFq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws+pVBFq"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-783fa3aa582so69978377b3.3
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761155113; x=1761759913; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhGD3Qk3v/DE9eNePF49s4IbBrokAvKvhDcwWN09Hcc=;
        b=Ws+pVBFq2ap31SrGLa6CEeaMoBPFDdkkp5lQhYdsDY6GU9Ha1m6NorkDnP2W04zUPf
         meTSHc3OgwvIZwBVe545InEXo4esbVKWgXZc0GEOhey7yr/itTImGXmbPVJSvzk71mye
         rmhdnpgOCUANdYGnM3CSlj30q8ZHYUI40AuLZWPTOCfcbGBYK9wQLXHbWG9uTRDWCAi3
         Z/sSZDpY2+3u8a/FNxf6CVpriVa7cnoI1MX7ynKPYM7FjCCluorztAHhQOix5ILibmkG
         yNUOwSfCwTBPPAbLcaE/cE97V//m98Ne+fgqrGxtVXoPPsQZFn9Jl/ise4nq6MxBckVB
         MG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155113; x=1761759913;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhGD3Qk3v/DE9eNePF49s4IbBrokAvKvhDcwWN09Hcc=;
        b=PoyGzVEBhccYIxQnobK6RVn1Rg+s0gOHvnsFreM/Xxy7nFboVcBfp1ljV8bpdg7476
         sjDFH1MbMWRpI5yJWOxkuJn+4sAYUin/dj6wl29diEKMnEymNyVUI6XZl5kOMbolwjNd
         In+6orr0pYCdANDXXtQ1AWbbhfp+r2zfYsKH0W0IJ+D0QhSGvFYlRS1Hlo57fnMYpI6J
         hErMjOHpdA6GuIljepe6ly7N9jxpvUZpICznb5sjDN8V2FvwTZ2s1FsUjWJvqh/H3r5z
         7zQn+h6Vy/rdlc9hQ0NDRrV92aswjr/PRR2XRJgh9kM+48+8kvus0wuHe5WudB+FZtCO
         W6yg==
X-Forwarded-Encrypted: i=1; AJvYcCXArT98ynIMhFcw/goTVAY5eZUQfHkEaQWNNuouvWVE1hJbNj8JwkRMycrJpeP+155uCwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+T/pWZYaID5clByu4VsUpdKjSSRvCJ66tuOmfdRY5njcN/dp
	AAUsDYd34AXHEPRya86RMFwPuiJWqwr4idrXMcGHOOr0WnP0CDTxQF8a
X-Gm-Gg: ASbGncu5s9WB2BZAMHfv+gcm3f7PgLk5ot7dOlvPtSJrXnst17FcS2R4WZpOG0snrog
	UkjwxdElw5E87r+BySVUdDpWIm+nLLCijEBYpjKcuh0uvVKS856p+fY//eOE5tRFwFNX9rHLHG3
	97mR18Bp8toGmR9fTZ3KlkdJ+SIipMPpH7WtlRq6AFOKQj25CJLectHybATNP1GIrICNudt2jIv
	CcXXhWUJ7JVP6oiW9WZAuacmDyMbGH0ErrMPUhj+mI/x3/S1e8pCdwXdPRCQ4ipd1Z8sTlFF5t5
	F1XT1Gj4mwYsgTYONCm5as+JSUzzr4w/GCdjIaaYuRI5omFx9DuW96iSfyjnFAhfkiGLuXFqcjB
	Yuo557tBoYyvtHW6YaC9zp5FkaN2meYbWvQ7+om0pRB8FLlGc2dafjUbCAzHoUbRcILnNx6CuA4
	cONVGphFA+zlEaA4Nlqmz2MaCY2m3FwJJb4w==
X-Google-Smtp-Source: AGHT+IEE6UvGhnXEcDGDfLYu0pqXOV7ulWNvnaA4Numim2bVvixhlltqCFg65Ja44H7Hu1RM5hHhPQ==
X-Received: by 2002:a05:690e:168a:b0:63c:f5a7:3df with SMTP id 956f58d0204a3-63e16201f42mr14828040d50.59.1761155112590;
        Wed, 22 Oct 2025 10:45:12 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:c453:ab75:b1b9:2303])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-784641f3a7asm38411067b3.13.2025.10.22.10.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:45:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [rfc] flip rerere.enabled default to be "on" at Git 3.0 boundary?
Date: Wed, 22 Oct 2025 13:45:01 -0400
Message-Id: <80220653-7302-4E4D-99E9-1A8CB5B4F23D@gmail.com>
References: <bec27479-c53f-472c-87c7-374321108ad5@kdbg.org>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <bec27479-c53f-472c-87c7-374321108ad5@kdbg.org>
To: Johannes Sixt <j6t@kdbg.org>
X-Mailer: iPhone Mail (21F90)


> Le 22 oct. 2025 =C3=A0 01:55, Johannes Sixt <j6t@kdbg.org> a =C3=A9crit :
>=20
> =EF=BB=BFAm 21.10.25 um 20:55 schrieb Kristoffer Haugsbakk:
>>> On Tue, Oct 21, 2025, at 20:21, Junio C Hamano wrote:
>>> A good default matters, and people who find out how useful a rerere
>>> database is would say "gee, that sounds great but why they do not
>>> enable it by default?  It is too buggy and they wanted to reduce the
>>> number of support requests?"  Yes, the reason it is not enabled by
>>> default initially was exactly that, i.e. those opt into the feature
>>> was used as guinea pigs to polish the feature.  But we forgot to set
>>> the graduation criteria and never said "ok it is mature enough, so
>>> let's turn it on for everybody".
>>>=20
>>> Perhaps Git 3.0 boundary is a good occasion to do so?
>>=20
>> This sounds nice.
>=20
> While I agree that the rerere cache is a very valuable tool to have, it
> has the very sharp edge that a cached wrong resolution is extremely
> difficult to get rid of.
>=20
> Merge conflicts and how to resolve them correctly is a skill that needs
> to be trained. Giving a novice who is still tipping their toes into the
> waters of merge resolution the advice to "just enable rerere" exposes
> them to a behavior whose results (the reuse of incorrect merge
> resolutions that they thought they had already corrected) are
> inexplicable without the help of an expert.
>=20
> I think I'm saying that I am mildly opposed to enable rerere by default
> as long as it has this sharp edge.

Fair points. Could I ask an enterprising reader to summarize the sharp edges=
 of rerere that need polished? It could make an effective todo list to aim f=
or prior to 3.0. Here=E2=80=99s what I recall seeing:
- messaging is not clear
- usage for dealing with incorrect caches needs improvement (should be useab=
le without expert intervention)
    - as a first step, perhaps having rerere and status display more informa=
tion about possible steps to take (review results, keep or discard) would he=
lp?=
