Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AD41E7C09
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374301; cv=none; b=THVRNIXdtRbuhBVJm6qdkPbddt8Af57uwRD49zq9H9KOF89gDYMmlMA9sJBn0/+hwvL0+toR3bIBKdrfNGoyCqmkh308EoTAVhgnhhPL6rbzgvYhhQZGHXK855NAMlCqx/uz4wrYlsNNZ5Ucd/9fmP6EbNwNcXfMZkdawLg0Xj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374301; c=relaxed/simple;
	bh=4vd2AMPos3kqBowvcs/Yml3O13WwZ8nSXLMUPjBQs78=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7b7gRUDTrvTa3RhGY+kmZOQTCfeawMbiYGCUVbx7LOAmFiea6Yji4vkN6CFfYRblD5KV+4hFXDgz8t40JviWThAt7dK18k6VuYcwO7QDNHYfvxZ9eO0yiB4z7Wv7zZ0aiVhuVaRuZEgbjxGp2asZV+zLt9fY2NSxPmgSuqaZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbmw3HIV; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbmw3HIV"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50ab5e0c482so1470505e0c.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728374297; x=1728979097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yhDuwU28iiU/ojJCax5shab/WHm+y0zE7aHUDKokkW8=;
        b=Nbmw3HIVC5lMyerr64a8vv9dC29OaHtJ87iuQddVwwjj2OCJD/dFBIlrRgd9Lbviih
         AsDdBkp/c3IMVEEeHQKvxJ1k2Ip4JoB5BjcUHS9zKi7y2UT8FtH8vjCPWbYo/kkYw5DD
         /pxFbfGiEJ/w46xSSd6Ix2Jf8dqrm00wqptY1KkZS1qLJbmWgKIUaa9aoXNP22ZtOlfD
         4NNaQp3U19QT07Bh4oDRtlGBuraqwdgzFaxrJfhPdk/t+b2tF0iJfp8lDc5vPBYHejsL
         F8nIFIDziUHQtkWHLiSaxdAiKeO5xgf5baBjChcjqROX736FhWQwTqAwoeDtYckGX5I3
         t+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374297; x=1728979097;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhDuwU28iiU/ojJCax5shab/WHm+y0zE7aHUDKokkW8=;
        b=tb/snwNtSL6rVuenHF2mO6d5BtDJI9irqXo7hLGqvbpnn/IBzQTQkxPDCntuUKg9/Q
         qe1KQo5PW4ZW4XGoEZjHLR4PkSZg26vHACQweTkON9MDL5u94nI38MOSAYcJ4BUYUDnm
         D3Xvdiozq9KLo+327gNMkQVZh+tbaakvwzOAG11UYUSbP5mKw2Q6GGptPJJgFe4bgyCE
         uTsLQBGh/U0rXxRVvYOwUF2wy6lZic/WGGelJORLPn1HaQLgnbmb006D+iZCYc1oUzU3
         lUHBuFvS2aiuZk5jJBm9AoaqqhJpqrafRdjPjk1K3fJa8NXjoaWzANEwK1iwqPPzCy/9
         RCxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMdK4WkL+eOiVpcXmIa5MOFUHsEBRKUjWKon//ZD/BXXDGtxsvzWnAgUstXMcfegRvn0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0G9aIQL4aA9taPwhEkqjyNQotvaH0xHow6drYZ4LWLk43ykO
	BOwnnWR2bIFMYu323jtZ9e+hM7vxmvmSM4ip2nl50xOxG8FRKQdXPQQxvKlCLx9Qm+KCZYycrSk
	S8RoRv4m9cWdTU/+d/8Fw9JnkimQ=
X-Google-Smtp-Source: AGHT+IGbMKzob8jwFWyYTItJMQesoYczfKWawrNHGOo0LHPy/MAd+TO+gxX0cZnIKwYsRpj5OE8oSkZUJzDSeP0LhY4=
X-Received: by 2002:a05:6122:17a6:b0:50a:cb38:31d5 with SMTP id
 71dfb90a1353d-50c8559ae66mr8172470e0c.12.1728374297170; Tue, 08 Oct 2024
 00:58:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Oct 2024 00:58:16 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Zvj-vbvQym1R4KJk@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux> <Zvj-vbvQym1R4KJk@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Oct 2024 00:58:16 -0700
Message-ID: <CAOLa=ZQGaLJTJ-bcSYD1mcsgCD8ayHYzXatmK2iyz4gDodvvKA@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] ref: add basic symref content check for files backend
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000005c09f0623f280fc"

--00000000000005c09f0623f280fc
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> We have code that checks regular ref contents, but we do not yet check
> the contents of symbolic refs. By using "parse_loose_ref_content" for
> symbolic refs, we will get the information of the "referent".
>
> We do not need to check the "referent" by opening the file. This is
> because if "referent" exists in the file system, we will eventually
> check its correctness by inspecting every file in the "refs" directory.
> If the "referent" does not exist in the filesystem, this is OK as it is
> seen as the dangling symref.
>
> So we just need to check the "referent" string content. A regular could

seems like we're missing the noun here, a regular what?

> be accepted as a textual symref if it begins with "ref:", followed by
> zero or more whitespaces, followed by the full refname, followed only by
> whitespace characters. However, we always write a single SP after "ref:"
> and a single LF after the refname. It may seem that we should report a
> fsck error message when the "referent" does not apply above rules and we
> should not be so aggressive because third-party reimplementations of Git
> may have taken advantage of the looser syntax. Put it more specific, we
> accept the following "referent":
>
> 1. "ref: refs/heads/master   "
> 2. "ref: refs/heads/master   \n  \n"
> 3. "ref: refs/heads/master\n\n"
>
> When introducing the regular ref content checks, we created a new fsck
> message "unofficialFormattedRef" which exactly represents above
> situation. So we will reuse this fsck message to write checks to info
> the user about these situations.
>

Plus to what Patrick said in the previous commit, it would be nice to
separate these issues with different message IDs.

> But we do not allow any other trailing garbage. The followings are bad
> symref contents which will be reported as fsck error by "git-fsck(1)".
>
> 1. "ref: refs/heads/master garbage\n"
> 2. "ref: refs/heads/master \n\n\n garbage  "
>
> And we introduce a new "badReferent(ERROR)" fsck message to report above
> errors by using "ref.c::check_refname_format". But we cannot just pass
> the "referent" to this function because the "referent" might contain
> some whitespaces which will cause "check_refname_format" failing.
>

It would be nice if you could elaborate here, or rather restructure to
say something like..

    Since 'check_refname_format' doesn't work with whitespaces, we use
    the trimmed version of 'referent' with the function.

[snip]

--00000000000005c09f0623f280fc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ccad5ba27d4c2a7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jRTVoWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUgwQy80MDZQdTd2Y3R2ck14dTR0Um9VSEMzNHJOZQptSjd0SmF3Q1pM
Z2xkSDNQeGhPR285aUNSTi90WnFsMEo2cUtGd1lBalZkNEdNWHRHZ1pwMW5TUS9xcXlmcS9LCmZI
OU9DV3ZtSW12OHE3RUtJcXFNUnVXWTA0STdTakVSUG9hVGtKS0xLa3VwelJTT3ErVGhyV1dIbjNF
bzJhNzgKSTBrY0FIaXN6LzFjWWhVMHE4L3IzSTBoclVqbmQ4cExKRXdjTTJscjJvRWhHdHZ4M1d5
UTJPUU1VaVU4NG0zWApGTzEwdXRVbWYvd1FJaWduMXVCMk1kTkhDWE5ZRnJmVmVCWmpCeFFXOWN1
V0JKVWgxczRRc0lTM0o4dHhER09iCko4UGdGNDRWczNScytFcXRkVkhjNm9Cb3RjYjFhYlFFajdP
bmplL1ZvYUNJaUpDUWg3aXJ6aWVWeUhvTFFmVysKVUU5RDgwbXNZOVhid2tzZlN1V29rWGN2VDRT
a1YrUlFGSThIL2dZd0dkRkNWSHFVKzc1L0orTER1aStkUWx4Ygpld0NKNThnSlMraDFOcmxSdU9Q
WDA2TTc3NVYzVC9uRGErbDUzK3kxOS9kTFhsT2IrWjBMbjgyY3g1OE0zdDV3ClZkS0Rva0RMNkxO
em9WSVZ5Q1hYYmJHSnZVd2ZqUWtBaGhNTm5iTT0KPXVzSlgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000005c09f0623f280fc--
