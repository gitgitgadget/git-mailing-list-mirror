Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A626AC1
	for <git@vger.kernel.org>; Tue, 21 May 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305478; cv=none; b=j9G+LtmhdFiW2fPVejPZ3PJSJO+mxJE7I/YYNCWl9HDWC+xiz0lZJnN8b2MENmrDxAU/mZWgxTGCyQKh8pnx16XKAFt1rjzr+xYCNgqMHm1KEnQnnCoYsGJHiwya6b6AQYooQ6qKTCp/d259CtYczNOW78TW/2IdQZYtLKBHLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305478; c=relaxed/simple;
	bh=NnsSCK0xGHfvKpTeHrLO0pnBYeaE3AcPEgB/JVR7Vhs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNRIfyU4H/oTGRHU4CXveuUn0g7T89IZhDT8RW5+SvXYOV6NLWQBvR4CUBdtXN7TLvcb4qiHAVHE94Xfrdaeav0qB7o3WzQ9VqGbfem2nUaQv/Yn+v/bmaX/srlZT4pxZA8waIyJgISF2XPv7pzuHUTKbD6/0KQR4O+ZFYFvm8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S55TlM0i; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S55TlM0i"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9995562a0so2674347b6e.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716305476; x=1716910276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TzIfxbmSGb3Gm0FTgEwJ0TI45b7ctnU4Eph3EQ4F+SA=;
        b=S55TlM0iPKF1hWel0NVGzcmEZpB5lCO5dsO9PfDMkhk5HdE9PrkQsJ72WvtkoeeXFQ
         cZiePIiv0rgO7r8jYRMzJ9x4VVj3rSc3ZsbRWLAvMgrRU03p4scAK4+4d/d3Kdtrqj9T
         FvCXqewUOUhxUhoyUekNH/1meqXaOLT3FbELUigkgQgkY5XixZ/cvTQz2bBF9E+8LQ88
         7MeHMCwl9Zg0G9XNWKCCFRtMsfyFSPbxb2uV8VueDf/SBsBLvO8MppF16Kf5KyEit5iL
         5dJR4tOwZnZCzWthEBBGGt6FpobExMj0EYqvVxYMR8RDbccUtyPCgQSzqc9SBAsUlT0I
         /+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305476; x=1716910276;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzIfxbmSGb3Gm0FTgEwJ0TI45b7ctnU4Eph3EQ4F+SA=;
        b=jUHG8opo/wDF1TxFYfCzYazy4eAINqq81FRCx23YmYJNJs8MGqbOkrbsP9CAk975+v
         G/FyURoAM4I7Z3XR8vI8Qc+qtxadi+MJaLzseYLmqr7/Cx7tlH2WubKqX6mgoCvsVBel
         MQluDzoyQYvCfgkzKtgRMxzHTO5RWa2sBm/MDeduLp9MBNn69Ib5ZKb9FKLFUvZ/ghg5
         dQh7cPFph+9IHit5j6ovLAGeR5WRISdWNRjDj3yWP/9vPaCxUOXjlCSQQVr7XGJ6Cc0S
         LCrEEqVblu9p9g55AQvFLXZi9TmVJHgxMzFqKO0gqHd6Iw+/g8538nUwSOtgn8UPBGgE
         b62w==
X-Forwarded-Encrypted: i=1; AJvYcCVGyJ2Lsjv+Ns5yIGq4LtYVxUzAtHxWPOXxXgasrUNhT8vNfo3rYqqaSQPHFHqf7ZsXa+EW95Qui6CMa+vVUeNFpRr0
X-Gm-Message-State: AOJu0Yyog9d+m5A84J/BBAMoDXymZccQeu/M1iQmzDQFoUG0udm2u5sW
	UM+N982NmsmX3XQT7A2lar47n5yHnemwMFwgaqf602m5z6qQYVlq0spWtlnX36MUCzikXZfbXEO
	HabXDzGiePR3Kfm4VSFbgpyyaeEk=
X-Google-Smtp-Source: AGHT+IFs4m5lTSzDW2w7P0GbyQGWctb5/I9PkurXIYe0v8dgOQnN1iUhLdhbYVd5Ibc16aCwi6AVFZrC5ufTUp3/uXo=
X-Received: by 2002:a05:6870:a352:b0:24c:1b5e:eea4 with SMTP id
 586e51a60fabf-24c1b5efd93mr7816011fac.27.1716305476157; Tue, 21 May 2024
 08:31:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 May 2024 15:31:15 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im> <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 May 2024 15:31:15 +0000
Message-ID: <CAOLa=ZQPS_gVAf-f3cW_=C18B4C7i-gh=bYMWW2X03S4nYK3Aw@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] reftable: prepare for re-seekable iterators
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000003b9e3c0618f88296"

--0000000000003b9e3c0618f88296
Content-Type: text/plain; charset="UTF-8"

Hello,

Patrick Steinhardt <ps@pks.im> writes:
> Hi,
>
> this is the second version of my patch series that prepares the reftable
> iterators to become re-seekable. These refactorings will eventually
> allow us to reuse data structures by iterators and optimize for certain
> cases.
>
> Changes compared to v1:
>
>   - Various fixes to commit messages.
>
>   - Fixed a copy & pasted comment to refer to logs instead of refs.
>
> The series continues to build on top of ps/reftable-write-optim. There
> is a merge conflict with the in-flight ps/reftable-write-options, but
> given that this series has not yet been merged to next and because Junio
> has already resolved the conflict in "seen" I decided to not pull it in
> as an additional dependency.
>
> Thanks!
>
> Patrick

I didn't review the earlier version. I did go through the patches in
this version, I only have a nit in the first patch, not worth a reroll.
Thanks for the series, I have nothing more to add.

Karthik

--0000000000003b9e3c0618f88296
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: eac5d171d3404c29_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aTXZrRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memRkREFDT0JwNEoxaGlVTjNIR3UrT3ZnQ3UzRkdLUwp0aU9ibDdMc25k
a2ZlNEE2Z0JVWkV3dHlZYUhIWjdhYjZtYy96YU94N0wvck9SSkVTQjdObmdNNmZsb0dmdktHCjVu
amNPWnEvSFdXZDR0SDRIY1lsN1lMMzgwL0pDYU80QWlGT1EyQUJrc093Tk5HSVFTd0NjbmpSdGVN
TXY5M3QKZkJWeS9PSGpoZU9TeS91RHhWL2Fhakprb3hyZ3RxY09ITzd4aUhsbWZjUzM5WU1ISjll
NjFidVZIM002YkIySgpzL3UvOEdzTnFiZ2tucDRIRG8vYU9ZWTdoeThaZ1hSWU9tU001dUdCNE5T
dmVlSzIrdDlvZGRTWHRFK3AwMk1CCjJ3VzdMU041bktiK0RUd0xGZFRERDJVZGVrZFowQ2t5NUdT
WWFyTFN2dFlzakQwUHJ2M3ViU2tjZkJDc1U1OVgKdWx4REdjbjhGQXFOMXZST0RMbkE2TFlVcytz
T2g1cDFvNDZ2Ykl1OHBRSzNXQ2pUNHhVVzgrNHpTRE4xcy9oQgpwL0R6KzgyWnpZa1J4S3dCWWJ0
MXBwV0x0SWpjVmNWdUtmQ2JEK0ZDZFZhRzdPRGkyeWRpMTZCenRVVGx6cUx6CjBqK3lRVDFmQ2R6
YitQT3dCVU1lemlMQ1dGL3Nxb1Y3dkNGdFpDQT0KPXowQ3AKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003b9e3c0618f88296--
