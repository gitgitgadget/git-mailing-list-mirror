Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B571428E4
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726089174; cv=none; b=iCZya3IO5cR+I97oolnYkBj14+RS1Fnkvcx7BW7KkbQGLn5Y37R9C0tZRIJHGo5Wqww3aMRz7BL/dg2hEipnI5dp4G5akOn9olCTa24uqrcY59hZFex/NGJe2cOGTpcns7bW601//4QpGa0qWAp89iKL0mHhSfeZyBvFTegl/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726089174; c=relaxed/simple;
	bh=DMkeGRnkf42DTiHrZFxPvEnyMXIs5wjd2wAqhsMhoZQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuV4EP8RSY9c+3Brbe/OOgXbaNcGBCzMvpzM6RFyEYjfLVChgYEBTyKylAcvn3E8GA2ii9zcYkYiGQ1f8cmDasgi9tDHA6xsz1atylCmKs113ZcduX4ARczKQVau65xPrinyu32SL4mrDSsVG5RBgvWJOz364lGaZwshMNJhZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0b6BNc7; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0b6BNc7"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e06b72f3e7so448643b6e.0
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726089172; x=1726693972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gcq6UfKwA2A+FX1BQ6wqGFaHDFHdj9VG0FlOspsng/Q=;
        b=B0b6BNc7TWT6+AFRcTtmnSAGfQxOKtMIvCnB9MVjRVzMCfVNpCHxR2NTv/Eqe2/2Wq
         4YKhGEesxGyLOpfGFF6Ukmvz8X+2cVolGSaXelfUWJQP+tYtwdPKHKqcO2zAFD5ljr7s
         h/ggs5kZr86kKKAEjqQegyj1twwpxD9TFd1RwAac+iWIr9/LB2cffHHGOx8xNVFz86M3
         vql0RKjH3kRsSUMI9lFAsGeIM/QMR1Zq8HurDlUiWqewMig1PE63UYh8tAG2pyqKKKCv
         Nn7v0D5p7F25cALfk5gNqDjqA20WQC0zZczFlptnX0tOuriyeQXvlpBTc7gNhLJBi5y8
         3EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726089172; x=1726693972;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcq6UfKwA2A+FX1BQ6wqGFaHDFHdj9VG0FlOspsng/Q=;
        b=Y05ov4aIrkPqfynl8mLhWVriXutn8OOP/gMqs2UH/GqOxJWS7sQlCFOfPxWa1K+OOA
         U/H9RiC9ZHS/STnubUXhuOSgA5N1UImOUDBNA6r/T4F1Pg7EywwwYWifpg9oaUGo42b4
         I1U76kf6V5Si0qGapyik0wF96hXmr2UCWmyD1/JfSriRc1FvIDjSJbNjZFmEHYJoXhX1
         J3F9PXQUN8NfjXwGooevhKnikkt7+MAKS+5oORGaXIqIqx3M1gASo3e9PNe70gHVIb3M
         ImG6LMpH8lDFedppda1QSrc/EEqylMD+9+jNOu2eBJGGXv/McRxFFllQykjtavxVh2FF
         jKcg==
X-Forwarded-Encrypted: i=1; AJvYcCXobcCrCmunS3hEARLsJcO+A5Oc2hMXbnpfXWDZZHOLi9pT+I0uXDLSL5US4u5yrkBW+4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCA82CRIARrDdGqmC9vZ62o+NhKTyw+4FL1KnsZmpPIWIKIysK
	a3m5dTRE7EoajE0bWlkRyJ91nK92Cyy0Jyetz1WkqPrpHztu+M5cMYWjgNNSSl7iJW+H1cs2Bgm
	LjvfxGcM8cgbEENGNaRUmQOAn7bA=
X-Google-Smtp-Source: AGHT+IEKGjf6h8wErS1MdJ8Kjs/b5Hk03RYTdlkx3WbIgpSpEpZbZoURBEQrZYRwhZ6wXYc9ETyu6k9GGRJ9fhrko78=
X-Received: by 2002:a05:6808:d48:b0:3dd:c07:8962 with SMTP id
 5614622812f47-3e071a1f508mr308955b6e.6.1726089172160; Wed, 11 Sep 2024
 14:12:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Sep 2024 14:12:51 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <a1969c5b0734cacd0316c34ef3d3b1939f521cd4.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im> <cover.1725008897.git.ps@pks.im> <a1969c5b0734cacd0316c34ef3d3b1939f521cd4.1725008898.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Sep 2024 14:12:51 -0700
Message-ID: <CAOLa=ZQxVtFrZqFJ+Q+0ifj5h+x-7-ZE6viD9OUyNr2CvE7s-A@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] environment: make `get_git_dir()` accept a repository
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000f533540621de73ee"

--000000000000f533540621de73ee
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/repository.c b/repository.c
> index 9825a308993..6f43f2e8344 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -91,6 +91,13 @@ static void expand_base_dir(char **out, const char *in,
>  		*out = xstrfmt("%s/%s", base_dir, def_in);
>  }
>
> +const char *repo_get_git_dir(struct repository *repo)
> +{
> +	if (!repo->gitdir)
> +		BUG("git environment hasn't been setup");

Shouldn't this message be more generic now? Since this function can be
used with any repository?

> +	return repo->gitdir;
> +}
> +
>  static void repo_set_commondir(struct repository *repo,
>  			       const char *commondir)
>  {

[snip]

Rest of the patch looks good. Thanks

--000000000000f533540621de73ee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 73245e25273e6139_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iaUI4OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3dlREFDSkZjaXVBbkNScE5BdlRGN2Jqd050NEtMOQphUkpiOWluVzNC
MUJhV2JlNzJ2L0t5VGx5VTlubDdoZ0ZRMGNJYWVaL2ZUSE9McGFMRlVBNjFPV1RYMWVpN2JMCjZi
S2RaRTJ1RjlXc28yUW9PTlN1Uk5sODRwcUxjdXBmK2dmTnIwSzlZdjRCMGdiMTY2bXYwWGR6U2Y1
dXFZdDQKcU5QWkF6N0JpQVdEQmVVZmRxMFEwY3NRRmhXT0JUWDBPWHhRL0VRdnNvMG93TTM2ZzNS
azFvN1pXV205NmxBQQp1ZzFlK25KbVhRVEpWNC8wOXYzMlEzc0ZnRzBMcFFmcTNsTDNRRWNYRFBy
NHNGemZ4NUFZVi92ZnN3TUhaOUNGCkx5Z1FwaG1ta2lQRkptZEN5TjFKV2lrQVdyTER5SjVzY1Ri
VU1rSWhHcjhBTE0yZlhIUzdWa2VNMHJHQlBDTHEKaTArNW5kaUJqdjl4QTZYblE5MUM1UDUyKzdr
b3FJMVpvbkZkdTJYWSt3UU9pY3p3ZzhtZUxDY3EvQ1dtelpVVQo3dlRZMG96b1FrSTRxZzUva2xr
eERYVE9tZkd6NkNmdGJNOHdWQlpVRVpxVG5iUHhEUHJVUngvUmhiTVZtbm9qCm5rNm1mbWZLVEZ3
WG0xb1haTDQrc05icFFwQVFNakN3SkNKN011bz0KPUp3eksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f533540621de73ee--
