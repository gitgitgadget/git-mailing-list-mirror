Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4344C65
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152866; cv=none; b=K7EuYEgQaWIQF3KkoIgdrli5hMCSdaiJa2KqRd35iA+8W8rqTj4bhAELMT5+SS2Gfq+no77yXqjqRm1ZdZmEbV6QEq3nnHWeFaPYoUMWWBjSjQwwJUbTsZydk+w6ecEzxpR2pbiq1vvLgr4PNmafDVnpJNXSHiVKrnLmSr8Ldds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152866; c=relaxed/simple;
	bh=iYQAjAlQbnW0Pj1DPLJV3yFxNjipOTH6vCau1BXFKYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sn1vD83Kcz27SVd518UmA5RA9C6bXdnoDQyPx7/PTpRq8B8pQz70oqyOntP8mCg5ADuCRiEdND26vcv5ufzwsEsp2MMAWfTowVCIMZxx+buzIVtL9p03a5Ncgo1RYaNdF7izfiY6Y6jwBJrnQCu36kvOlp+EYsajs2A0ImgiyV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYuwexyp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYuwexyp"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2a17f3217aso624405966b.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 09:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707152863; x=1707757663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYQAjAlQbnW0Pj1DPLJV3yFxNjipOTH6vCau1BXFKYw=;
        b=hYuwexypX5tD2QWWKwuok3wmZN/CiE8UKiC6R0MJbK848eHXc3IONU1QS1Q+fjNzdM
         PD/zpPzT7wB6YEu3u8dL9XZIg1EKM3/x9j6xKf9SUt91b+50lOfSD0MQ5w8UexnM3wRS
         ZVSROS0JP0RIpodBQfsHd87Qkv2E8mcZwaCr0M95GjdHgWRyn6TBpViaN2n0sSpj1J9I
         3SI8iJPQTeoVUCn631816UeTwyG7HF7npucAbnMRajScvCXI5tpPMR3pQfMc4QnWwCib
         RLX72NuUvLBdmdOAZpQkfbkzbLO+qP0ICuNcDnZfCOdZ0Hm6Z0xfZBdY6/moFp4nQ2Zb
         020w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152863; x=1707757663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYQAjAlQbnW0Pj1DPLJV3yFxNjipOTH6vCau1BXFKYw=;
        b=D9Rnql7WZiXF1jGuy/ut/GylDj+uyEXY4tR9Tt/CBWyKLuFbliVMn96EVOCA922YdI
         8HuWCfMLHVkiNKnRRABAENT12kTlbAR/cbuwj74Dp9kdq/xSX8Wux4c+BWhsM9XJcpY5
         1hP5IUrbMxzhxHxaFBtWemOdLKtUscgq5WmMhh/94pMi4LWcnM/D0Rcjui/7u0bH+RuP
         LjdmQ21lnE0xsJuwfrrG6zqC6ZEvjXUpnyo32Afwx7FwzgloFR0wsdJuXeequsRsDrwP
         /svu4fXjBfA3V6q69l8wqfR+Xwe2nUKj9fwO1bD03temOqfAGhZ3j77LOtaQrDaI/CLe
         PjuQ==
X-Gm-Message-State: AOJu0YwYqhb11zTBCWxA/GN7laKI8HR2ql02vDnFX90YOlHApMXdJIin
	+0dpvRC2KK1pWlizULY15p7WB9OxIPjUN1b3NWLdFXi9sYgY2b5Mktg1UeX+aFYHc+Xyx0oNRzh
	VciTSQZnqEy82395wKuZXCTYwfeU=
X-Google-Smtp-Source: AGHT+IHJ0+RTfHY0CSVSObvfAbpC1mhxEdo8kadG1HEpF0iFCa9IcVE6OXyMlFoZ8Lk3csjq/FMQCPE0bP1BGYMs9No=
X-Received: by 2002:a17:906:abcd:b0:a37:6acf:d445 with SMTP id
 kq13-20020a170906abcd00b00a376acfd445mr32321ejb.53.1707152862785; Mon, 05 Feb
 2024 09:07:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki> <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
 <Zbtmoo8qTmj-yt99@tanuki> <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
In-Reply-To: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 5 Feb 2024 18:07:30 +0100
Message-ID: <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com>
Subject: Re: Git in GSoC 2024
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kaartic, Patrick, Karthik and all,

On Sat, Feb 3, 2024 at 12:41=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On 01/02/24 15:08, Patrick Steinhardt wrote:
> > On Wed, Jan 31, 2024 at 11:27:13PM +0530, Kaartic Sivaraam wrote:
> >>
> >> I created a fairly rough SoC ideas page for now including a barebones
> >> information about the unit test migration idea:
> >>
> >> https://git.github.io/SoC-2024-Ideas/

Thanks for creating the page!

I have just applied the patch Patrick sent to the mailing list with
the ideas related to reftable.

> >> Note well that the existing idea's description is far from complete an=
d I
> >> mostly just cooked it up to serve as a template for how the idea entry=
 could
> >> look like. Kindly contribute towards elaborating the same :-)
> >>
> >> Also, feel free to suggest ideas you have around refs and reftable bac=
ked,
> >> Patrick. Those would be helpful.
> >
> > I'll have a the beginning of next week and will think about topics
> > meanwhile.
> >
>
> Thanks, Patrick! It would be great if you could share the same as soon
> as possible. The deadline for applying to GSoC is Feb 6 (18:00 UTC) and
> we need the ideas page to be decent enough before we go ahead with
> applying for this year.
>
> If the elaborate project description could take time, feel free to share
> a paragraph or two that are supplemented with a few references. That
> should be sufficient for applying to GSoC.

Yeah, we need a decent idea page, but it doesn't need to be finalized.
I think we can still make changes after the deadline (which is for the
Open Source Orgs to apply).

> Christian,
>
> It would be great if you could look into and improve the detail for the
> unit test migration idea. I just added a very terse description based on
> what I could get my hands on. If you think the description we used for
> the Outreachy round would do, kindly update the page with the same or
> kindly share it here so that I could update the same in the ideas page :-=
)

The project description for Outreachy was not very elaborate and is
now quite outdated. I have instead improved the project description in
the Ideas page.

> > Yeah, as long as there is a co-mentor that can take over during my
> > absence I'm happy to do it. Karthik said that he'd be willing to cover
> > me, which I think would be a good fit given that he's already got quite
> > a bit of exposure to the reftable backend internally at GitLab. Thanks!
>
> Sounds good. Thank you for volunteering to co-mentor, Karthik!

Yeah, thank you Patrick and Karthik!
