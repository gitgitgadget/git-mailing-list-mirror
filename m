Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C6D299
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614975; cv=none; b=KzfHWdOwzw32MhtMA3BFFU8kNQKNmcXZh+tXvGwCO8kfcY8vFpCnCtMy/J6SJ9tfNeaZKUGWNzoZ9g7kSCeRP/jWpQIn7sjL35yRCfgZ32DsUoTmv4ViztekQClBPH1YSvCA/U6oiiDw0tUgLmZoRgckMM1wYBo+mxPQwR/yASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614975; c=relaxed/simple;
	bh=MhWgSwTjhjxbxle5kNPyGLnTBcOPI1zstDJO5VnOzJE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qK+CW4qg2fBuhk7wQAk6mvEhtRx4HIFB6NgC84jkSgMoqc+PBhoMGRLPOYxI31VthsXQAn8BFka/l8lmNoxcw1a8i5Z3ZbRPPIBVC+/b0Uj0KycG+uhl5ga9l29JIkrCSgmLAEBGCaODZBYWvXEXJThq5VdDall0/GNv10Yz8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jnhb6UEN; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jnhb6UEN"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4af400e2ac6so35018137.0
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 01:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732614971; x=1733219771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MhWgSwTjhjxbxle5kNPyGLnTBcOPI1zstDJO5VnOzJE=;
        b=Jnhb6UENqa3xCleqA7UcG/Q/CXd11Pm+82POhPG25odymJY03HkQkjnQoZqL0qUo+R
         x/1+2sSRWajpPRCr1GBRUeJsONJ5FY0oZ5vlsIunvSYe7FyXs4Ft5Ujaxifk29uNBSPG
         52UZPXd+5WOIu/mQIZVvEwLMvh2owVhhAhiXosy9vKF+bp3c/yQW2Lju1Y3KR6+Cd/dt
         gPIK9SYET+phcc+e4Dv5F1GX2v5DF2NsKwxgAWU4ND1KM7JPOjE1p4ZxwJpQQk6K3Qxx
         l7M9G6HlM54Q3A4vS/0KmwkdOyCs6kjEyFvpfzmyXIVWhJ8AW6SWTJvlZWrrX/aOG+Kk
         B5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732614971; x=1733219771;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhWgSwTjhjxbxle5kNPyGLnTBcOPI1zstDJO5VnOzJE=;
        b=FX2LVXmsUMOKYhzAZv+P5coEfO2U4W5LW3Xl6e8wZxjQ4+uvPyyTzEFbh9gJ/cCbvp
         QPgLDSgAn01KgOmD8TEUWXz6y1soODknFRGQ/WU3wQ9cYQGpEgxeT07eMxWH0D64ImKB
         E2WQ36kTWfgcBH5J85leI3lSuAeaoIcB650WJpKhaSsE046ZUqgsP3xuMQH1S9nNLEKD
         mynQrhPTieoNOOQ5BpVxUICbZGrDwKCWU0gJQNzBfUi6BoQhF9WuebHtI6adlWbwu8nC
         lLsPjbWQb/rNDauvdmlg1eQeYjQK8SaRMFdanr0taOHeR8DFkyULslganB78pK+9S5av
         ymIg==
X-Gm-Message-State: AOJu0Yz7rGl6lPurGgg90J0iclYSXr5xtMagKlNcA/SE/wmGq+ZOPs8n
	o92HM3Hle57uJxy2zISRj3pxiQfgNiqY7h8TE+L6v9Rr60BPXuaXRm1FiW+SgrkzogdB5kXNKoa
	2OKDIVy+BEH4KeeqwwsfleNbpVrA=
X-Gm-Gg: ASbGncux2h1pdQ861r+CXh6qDZAQlLJVRuQxeR4PV/xSBL5hdU4gtdxxvA2kyb84cFv
	WbZj4y3uttiJsSkBdsGxanjth2SFwzA==
X-Google-Smtp-Source: AGHT+IE+Qfc6bBFbDgOEcWpY4BDSYxw4MsDfYERFHHYc1TmsUBTp7/hLm4S+e+JGmndkZ0xrAw7WPbI+McZeT448apI=
X-Received: by 2002:a05:6102:390b:b0:4a5:b0d3:cbc4 with SMTP id
 ada2fe7eead31-4addcba3a5amr14420462137.8.1732614971339; Tue, 26 Nov 2024
 01:56:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Nov 2024 04:56:10 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Z0WNKV5prRE2Hupw@pks.im>
References: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
 <Z0WNKV5prRE2Hupw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 Nov 2024 04:56:10 -0500
Message-ID: <CAOLa=ZTUv41jfPcevaY+Afxu2e03_C9bDF+uXzNha-24LH+Lmw@mail.gmail.com>
Subject: Re: [PATCH] builtin: pass repository to sub commands
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="000000000000e656510627cddb01"

--000000000000e656510627cddb01
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Nov 25, 2024 at 03:55:30PM +0100, Karthik Nayak wrote:
>> In 9b1cb5070f (builtin: add a repository parameter for builtin
>> functions, 2024-09-13) the repository was passed down to all builtin
>> commands. This allowed the repository to be passed down to lower layers
>> without depending on the global `the_repository` variable.
>>
>> Continue this work by also passing down the repository parameter from
>> the command to sub-commands. This will help pass down the repository to
>> other subsystems and cleanup usage of global variables like
>> 'the_repository' and 'the_hash_algo'.
>
> One alternative could be to instead pass a caller-provided structure to
> the subcommands. Right now that isn't really needed because we tend to
> make use of not only `the_repository` as a global variable, but also
> because we track all kinds of other variables globally.
>
> So if the code were refactored to instead accept an arbitrary `void *`
> pointer, callers could provide a custom structure and pass that along to
> its subcommands. In many cases we may end up just passing the repo
> directly, but I'm sure there are others where this direction would buy
> us additional flexibility and allow us to get rid of even more global
> state.
>

That's a really good idea. I do see the merit of doing that, I'm not
sure if such a need would actually arise. But then, the fallback would
still be `repository *` so I think it should work indeed. Will modify and
send. Thanks.

--000000000000e656510627cddb01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8789b9b11e6cac90_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kRm16a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUNPQy85ZG5lZ0p5blFobGNGTTBRQkplMWRKMWN6SgpqVGRwc1g1anRK
WTROekt6dWpQNlNCdUtvMHJKRjM5UjExNHBYSTJnZVFyalNxYVNvS3hQd3g2dGhZSjJGUnFiClFk
VDViSWtKZnF4SVFjMTVJa1d2T080akxCOFRmWnpLeDhOMFFxeWt4cGxSemlQZnlNV2RFUGZSV0VB
V3pYd3UKTUQ0OHNrcXFHbkplZ2lnTlVybmlCMWVhaURMNFh0WHh4YmV2T1pPa1NkSVFkVnJ5US96
cEhXZmJ1cUgwMVJ3UQp6OWpJVFJGWVRVTUs5bDQ5aUJmM0ZoQ2MySENEYkZmRFplN2xucU9CYXp5
R296K0NkcXQ0T2tXeENkYlozTFU0Cmk2Q21PSU9Qa08wVUFBUVAzSEw4d0l0UFRhNEFFS0tENXlJ
SEcwL2JFMndVVmtrcGc3OFFKRVRxT3MxSCtHaWoKa0YwRDYyOXZZY25oQWVQM0Q5c25HN1VYdjdm
TWwvU3kyNDNPVGsvTGxobDBNNm9STEllUnZ0QjFLaUduWExBYQo2NVh2QzBmTzlDWVAvYjF5TWs4
akI5QUtxVFdnSHNscVppaHVod1piUnhqcFZuRGdHdDZWU3F1ZjFLbkhKbkYyCmliYzZDNm1zQm9q
MHhTMS9ZUUJxc21LeXNrRUlwbm5ORWZMdHRCZz0KPUoyQ1YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e656510627cddb01--
