Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33000202C58
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438720; cv=none; b=nWmp7iia8m0ixOURqkfC06Bi+aDNpk8vvVBoUqogzAyQbg009j9RN4i/piNYlX6dR5rqJgigOMUeG/DuJkf728Xr0Oqs+PiokWmU4KAuaeubDLQo/ERza//20DiDypkNrtOdUnlAH0FG2LDbFBCoW9C10IajxPE0rwBt9eiR+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438720; c=relaxed/simple;
	bh=fdCwJfuCq8td3SeBoasi9YNJtmCywQHY1VN9tydInx8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWoSgi/144SwWmbNljUpwXEdG2JCeaDysw9z3SDjb4/9G3XDPRC60VtgxW4o+2aTpV36/OO7BWYbiDDBvYzSIL4A91SDWtaP5ztLgQ5CAdzkljdjbgWjG9acKunMTV0rNDalbd/vKv0DWkQwPKdLRWdWxOAsMTriP+wmmkmhKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tea7DDfj; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tea7DDfj"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4ba79f6c678so211503137.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 01:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739438717; x=1740043517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xN95x6lYrL+W8eRuutkWAWn/sGoBIeTruSJYzDRcsA=;
        b=Tea7DDfjKMxqtEcEV8uxt8iRmP+A8SkEiXeG5wdkqEYMCvW+6esIjzTFcrb3eoub2T
         74yoJBI/SajCue0aRRCEmrQiSam28iHcm/BktDf0gvuEiv1kMh+h14G3vAlc7Wmu5sYZ
         YIAhK7pfKauaTw7Qln1O/vXLGgUo5I5yv3jL8QHUWrIkR1F3DVZVuFTAeAPjNWGF+f1S
         8a7N9o+5NDxvsZMA2Riu0wBrVcxQuYn8xdEmsqRK6znLwpKDxwv88ss4ihtEyBRun8hF
         eBGYcVZ1tOqeQIwFuB414ZekZ6THCf0Chq64xkyyCJDfDI8Pim3Va5DPaUCJ9HhhNKLP
         KLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739438717; x=1740043517;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xN95x6lYrL+W8eRuutkWAWn/sGoBIeTruSJYzDRcsA=;
        b=pXJZpAzrvEFr9oP8ASud29f4he8wGBAuITPalkDkRavNlucpz+bpA2sxgu7tgceZpf
         GcdhuXrqeP3hwq6TF3roJElaL2fyxPQSu5lg6CsYXjgujZjsXqw1ylBlXNUC0svyIt7V
         BvoAJQ1nIchGt2l++GJ1dYduZn/sibVEgbrAGy7EddTEA/v+ODCx7qDJVTFpYN8VMDvg
         oN+6G5ZOfjQpDbOE0BLBwerIxJZxpHPbfh5Atd8d22n2OYDCJQDcwuzwjCQMhXgNGFgt
         xmvgSbajlNuKuomrVeJBiZckWzd1xGtgTbQ41tN8UIDa/THpvXxlmuzt8MpG1QOlGkkN
         iaLQ==
X-Gm-Message-State: AOJu0Ywo4pnjDfeihHzyV3H5aDQ8/9b3xyDkGW3Uzi6QTOfs6uq4PWC0
	eganLaq+vCAaLXC3T22LlLItLi0wehi0k/FdQdZRiUzcIV/jH44Nk1+oly1wj7wi6ZcN5Pnv/x9
	7PRKQ7D99b7/6GC1ws8YHfofqHlU=
X-Gm-Gg: ASbGncvzqzYPG6UyEctce7pJaqXVBI7tzFp6lu+mawwBm1x6cItS+5By+caUDG7CLJh
	Yj2HSMa80xmuofiKilA0ZeXAeniSZCnAUjEvDg+1yy4TjEK3G2ptQxLcm6qFDBgQmSA0q1/8=
X-Google-Smtp-Source: AGHT+IFS3ZfFVrOfVBCgN74gvS398R5W1gDq5AVCg/OGt0Wo8XlT0vFJMwhCwl/JRIxezNYztyz7O/ndkrdIBqp/Ru0=
X-Received: by 2002:a05:6102:80a7:b0:4bb:e8c5:b15c with SMTP id
 ada2fe7eead31-4bbf2224d1cmr6616922137.14.1739438717409; Thu, 13 Feb 2025
 01:25:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Feb 2025 04:25:16 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqcyfoz82h.fsf@gitster.g>
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
 <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
 <xmqqcyfoz82h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Feb 2025 04:25:16 -0500
X-Gm-Features: AWEUYZnxJLAXPx8z84ZBJz3xR1pIelMSR9zVPAZfWK_lgsy9wayBFPDzXWyAcU4
Message-ID: <CAOLa=ZSzLYWLckuEsCfLyXcgrukbNUgE-LZohUeH0=LZA+47bA@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000dc36eb062e02a2ee"

--000000000000dc36eb062e02a2ee
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The 'git-refs(1)' migrate subcommand, which transfers repositories
>> between reference backends, currently migrates reflogs by default as of
>> 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
>>
>> While this behavior is desirable for most client-side repositories,
>> server-side repositories are not expected to contain reflogs. However,
>> due to historical reasons, some may still have them. This could be
>> caused, for example, by bugs, misconfiguration, or an administrator
>> enabling reflogs on the server for debugging purposes.
>>
>> To address this, introduce the --skip-reflog flag, allowing users to
>> bypass reflog migration. This ensures that the repository ends up in the
>> expected state after migration.
>>
>> Helped-by: Patrick Steinhardt <ps@pks.im>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> Changes in v2:
>> - Fix typo in commit mesasge and clarify the intent.
>> - Modify the test to use `test_line_count` and `test_must_be_empty`.
>> - Link to v1: https://lore.kernel.org/r/20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com
>> ---
>> Range-diff versus v1:
>>
>> 1:  ce14d3d07e ! 1:  6b83089348 builtin/refs: add '--skip-reflog' flag to bypass reflog migration
>>     @@ Commit message
>>
>>          The 'git-refs(1)' migrate subcommand, which transfers repositories
>>          between reference backends, currently migrates reflogs by default as of
>> ...
>>      +		'
>>       	done
>>       done
>> ---
>>  builtin/refs.c          |  3 +++
>>  refs.c                  |  8 +++++---
>>  refs.h                  |  5 ++++-
>>  t/t1460-refs-migrate.sh | 19 +++++++++++++++++--
>>  4 files changed, 29 insertions(+), 6 deletions(-)
>
> This is tangent that is totally unrelated to the theme of this
> patch, but I find that the placement of range-diff makes it very
> hard to follow.
>
> After skimming the proposed log message, the next thing I would want
> to see is the list of paths that are modified, before deciding I
> want to review the patch now.  Once I decide to read it _now_, the
> changes from the previous iteration and range-diff becomes relevant.
>
> Is it just me who decides in what order to review the patches and
> then reviews them in that order?
>
> Anyway.
>

I missed responding to this in my previous email, but I've been using b4
for sending patches and this was primarily due to how it sends single
patch series.

I've fixed the template to show the diff-stat first, and this should be
the case for upcoming patches.

Thanks for pointing it out!

[snip]

--000000000000dc36eb062e02a2ee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b87e5fb6f883b48a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ldHVuc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUZ0Qy8wY1BBNGcrN1U2V3ErZlFUM3N0OWtrUkl5VQpEZGhzVitzVExm
UEw4K3pzZVpFbXd5MWZqRmppTUdzRGczdXlsc21qMEczeXIvWHEzNWtpTE05TW1Wd2tEVGdnCjZ4
eWhVbWNHYWp4OE8zUTNvMVNoOHdLKzdIdHNDZm9iamJrWTJaODNaZVFPMG83bGYrbVVCZHNZOGxj
bEhOZTIKNEZBZk1NUHZQdzlvYmNwTUV2S2JNRng4eEt6N0lJeFJidFNwTmthbTE5OEloVXovQzh0
dklxaitVYXdQS28xOQpzaE5CaVBoMy80clpRYUJBeFpReUM5YjF4a3ZNNTV5WTBzVVVoUWt6QzF5
LzhuL1FrRkZXN1JTMytEUmZlMHozClBjbVlvLy9aZFU3c0c2TnZEVzM5ZTE2b3V2Sk4rSkhWemJF
ZmthRUczSEJmUDNwdjNydWdCd1BLcEZubWE4enkKZnU3eFUwemluRWJxdG05MnM3UW96MXJOdk00
TGNGdGU2bXczbE5kcDNyWGQzVzZ3UHJsdUtFL2VaVFpRRklKYgo5V0dNaCthcVVrZkp4T2taWDQy
YXgrWHR0YlFKWUZQQmowOGQwN0VHUU5ib0ZFc0d0NXV5SzJhT1dnNURTRkxYCmx4QlM5NldzY0dj
SFBFZGNzczZDY0Q0NzRrdTNpV1RPRHU2Y3hJZz0KPXFDVnAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dc36eb062e02a2ee--
