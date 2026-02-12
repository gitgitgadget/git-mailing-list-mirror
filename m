Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BB271A7C
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890828; cv=pass; b=RlDDf0V0RJbTnehY4cb5TDHDoSzgmeu391Xmi4pM79RW7FqR9/AwZLxZ1g/T8JRGZv/4BN8850CChhPm0Q2FbtIOXuAGEb14JIlIB58eaufaSjU09og7HHadt8v/WUsIbsNYJcJcZhv2NmzhftHigk9nIRNc7YNt028hLEusGoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890828; c=relaxed/simple;
	bh=ZpDBwK7lsUmAeMyEBEThGsbAj8zOfKU6Z8iUkpmrax4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QE/JMV9OwSGuMuG4713h9yWUOu/izV0FaD1wZu1oaSp1D5XDZoPvf5sqTtVaaexJDKdTKh0Rj21wkgi3dilAo8eh60xt/FR6gy1kmz7SkqOaalLS3HoZ1PTOAQ8TsJe47rzlN1lfDtmWT87Ui/hJpbp4FTjM8cDjem9TGqqf0gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5RhF70S; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5RhF70S"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12732165d1eso347407c88.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:07:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770890826; cv=none;
        d=google.com; s=arc-20240605;
        b=dELZk/sUrvAPrt+ExfwCqamu2GExfW4lZeSHNUTnUe5yNRgAPXBCEPOmUNcLfExI4r
         GkYdGw6wg9E2F29TdZRg2RI/TQZeyrmU7DIcH68I0n614KME/nhEFf3PYA3Q9JYQVS84
         F2gD5R2s54V0F/T3pt0ju2JqwqWrEh4dte1Pt/xS8nmqAteAb/RlbAygTYSGHPm12cce
         TYnnCIMHN2Nl3TZIj1Dx7Qbyl42jYNB8ZK/ruLoz4ezBCCcI3kbY0ZHCX30dhh6sI0NS
         37Z04SR3lcavxa7fPzFgN3XGnjeXOAM7yaJ7Va8ok6fwZpTtw4qK+/FaQQFYIKcX3/UL
         W1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vOVjPc8wEeA8iE1syy8Hmg2JB4ao9y4QIOeweAFW2MA=;
        fh=sFUv2Yk7W28jKwKk93FUOHba1Fh+s4Z1esNWzfg8X+w=;
        b=fU5tcNBnsQMYmvPmkk3exyiVMGsds6EEwsDqN121Vt3o434eovdhOCv8yGQiWDfpLS
         XYc61ccQE4pcwQEVGyQPSR0tJcIhEB01vmYVPyIn6aZPzuPuQMcfGFCpUchoNCYEWU8Z
         3chn63kUO4idox7xEas7C9yMLI4QX8YadGu1WxfAkUKdA0DNbj9/YCOcWAkVMdk+RNwj
         IyaSXvHCfnQWU2DEVFjSmEnOSX/0c6fzxRunZPaSOaol/oEhidI+c4tOU9R3KIvaB7qU
         VRTffOmnA3BTLmHxUtAFu0x6CoqLw7qe6ocLENxFcMDwvzI3TjfAegs7gPD/HaqCQn1H
         ivGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890826; x=1771495626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOVjPc8wEeA8iE1syy8Hmg2JB4ao9y4QIOeweAFW2MA=;
        b=f5RhF70S4DPnTlkDj9UCwtiqtxHxvvuZvj11Pa3ljQiY8J1koYQYPiDHlHITzxhuUX
         8s1o3Jnx7/CrRBbGlUcgCoumvcf9dyPYNxJyhDzMXUjZksse6IhB5d0D+wcSEPo7sZbr
         k5YfKeiUt2dckyPLh+9wuvURCLiiFLTpJ7CdtZkqjSkmKj323daV6UI7H/LaZLEhfMNI
         Kp8CmqoGfIznXnRiWd5qxaMmHAmfd2MGz5fwbs4hBhXRHrg4tUjU0tGRpdFy2SosHIjw
         a/W0qwoAbFjiKYYg5n3qzQTXDScV9oBGrjktscOwOlZCkeAUMOSc/7kd9g0trcfZulAl
         u/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890826; x=1771495626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vOVjPc8wEeA8iE1syy8Hmg2JB4ao9y4QIOeweAFW2MA=;
        b=mAwzkZWuelCHBCMkoVHtTTLxZB+XPDqDoe12NOVGzTwhjAnzXtzCLOtg0peUMTZwVL
         bLpr/flc8gNaImghG4yAFaudDf/xVRnQ2UlS1Zt/VTrDx1cxjfh7t20WM+944AZofrat
         olq9j7UHg0pma6FKjnAXg4XO2z7uPUrrgVFzw+kU1NGMCMESpZjg0KteS4eOyW3LNfnr
         B42OIHlc4FhM+yRF94mw76abp/3KF7dcWL5wRnNF/Ld6tBb5YZWN8xFwTA09Tyow/Nk+
         kND/NYOdTNVEtvaoaXbX1gXsRYUrpdgYoG5IW94JGvzldpl7ndgdyyXxOVu8qRtwMtvi
         5QBQ==
X-Gm-Message-State: AOJu0YyIgbuYF3wQp8IBX9MGyeFp80jTmb79EqemP1w86NQj50alD33i
	zoSLJKQFo+hqcdPQM9oUYHdXju3SIQLlkQcsY1ZmVccpqthQ5GxIEHUb+EF9iN7S+SejLXIgZnK
	zQ357WC24jIkQuVltg0QAu91hZZlTOj4=
X-Gm-Gg: AZuq6aJ1y+/ArVWdyHpwMWIaUMuDSmvdM3e96daHeSS/f8bNnogboNYsscUP1MNBIc2
	nB5Fnv7acMp04Lvqk7G2GZ6bOPR/q5eZpMcm3MpWdAWfBRfrnTIO+6nFaqaBf61bAcPUpN1BwGg
	didexO4uQDm9xuonG3HOV9qrdeiP6MsMcbBT+7x9raNKj3ETESdaK0KK46Kv1OX7Ji1udAK19IA
	M8F/3bVkCJtIgJSjlCRsifRZcSf5PCV32NbLjzD5KD5ajcpvZfafIZUC2gL02C9mUpK81MjeMpr
	UTbx7qZLkKfEO9mfGn8cItmlZqNoGonZRKt6KHMcPSqh48YC007+hqW2Ikwoe0UiRE67Njt8bkt
	On2o=
X-Received: by 2002:a05:7022:91e:b0:11f:2c69:2d with SMTP id
 a92af1059eb24-1273059dc57mr635247c88.45.1770890826351; Thu, 12 Feb 2026
 02:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260204110818.2919273-1-christian.couder@gmail.com> <20260204110818.2919273-6-christian.couder@gmail.com>
 <aYxsippsLqPnfIQ1@pks.im>
In-Reply-To: <aYxsippsLqPnfIQ1@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 12 Feb 2026 11:06:54 +0100
X-Gm-Features: AZwV_QjR5Yot12rqZvsL-Uk-1cQA-RvZLWpGfn_trkGciqRUM7vXzOVSWmybjSw
Message-ID: <CAP8UFD2SdgB7dAa3O-ZwzA0aO-NEFjgWOUgYFKnFkzzPzEyjfQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] doc: fetch: document `--filter=<filter-spec>` option
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <avila.jn@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 12:48=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Wed, Feb 04, 2026 at 12:08:10PM +0100, Christian Couder wrote:
> > The `--filter=3D<filter-spec>` option is documented in most commands th=
at
> > support it except `git fetch`.
> >
> > Let's fix that and document that option using the same words already
> > used to document it for `git clone`.
> >
> > Those words could probably be improved, but they are not wrong, so
> > let's just use them for now and leave improving them for future work.
>
> Heh, this reads quite funny to me. I prefer the commit message from v1
> myself, but don't care strongly about this.

Yeah, what about the following then:

   The `--filter=3D<filter-spec>` option is documented in most commands tha=
t
   support it except `git fetch`.

   Let's fix that and document this option. To ensure consistency across
   commands, let's reuse the exact description currently found in
   `git clone`.
