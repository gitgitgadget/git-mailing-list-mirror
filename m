Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9078715AABB
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778041; cv=none; b=VpdDZgZfR4bPLz9zBtpaEanxCmkZvCmreKBFKPB1qtNcAT6m/vLfYb8iq9BaJYrJTdHmhfeSu9IE/FvMZUlwoLI9hV+B/UrqWWWFideVkz49iMgyoHKSeVuZs9QGfSr9fZsX6nGqBHADighOgRd5k5Ccaso6suNhVXzHE2SJRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778041; c=relaxed/simple;
	bh=frBa1r+I6lPDr6NcdTwoInw9wzmTEMYx0oIH+NV3/+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gG/4uGa24m7AaEZ1kBIQEeUYTDvHTbrFcK5O1E3Lr9O+NYC8ojwGnu422ybYQTWzGPauPjKcsic4bLbTzpc/379i1wpQ0tBJkvkzVsVsmmkZnGfCu5VaHS+IXmlXtZ3c3D0Hd/EthhSIPMghwemsmIKHJ96/9/zIBUvufMuWGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxXNDMWq; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxXNDMWq"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21499c9650cso387172fac.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 01:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706778038; x=1707382838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frBa1r+I6lPDr6NcdTwoInw9wzmTEMYx0oIH+NV3/+M=;
        b=RxXNDMWqIn5pwxCM0JddoRe/Gu0DdGeSAy6aYwtAuT+JUYJCpoWoP1NrBJp7SevxJN
         tDpgnUnJGa11EaU2FKsvH4oXPKItVBE9hBDHBNiYrSteDgBC00/9BeCeLvxgD6PaVGFr
         fPOG70Ag6Gw/IEP1dYZqz548yEg6a89Y71M6IXRDztikeNtc1Xqf8FeH2dsiLk2UPRQH
         8f2tAlcDRO5Jhe5s/zIiFZeaJMFFiUpXlNiQThosPdvlkrCEOf/+pgTQ9lkehsm8qQp+
         D5a4JpQ1u236N7fcHNS4OvybdmuY8D/P2dcmr+hBvFcupJlB8BplLPKy2N0eH5eMAvtw
         RddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706778038; x=1707382838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frBa1r+I6lPDr6NcdTwoInw9wzmTEMYx0oIH+NV3/+M=;
        b=S99IS8KtD8idIaUAjsw+BpOAyQjmD0deR9Tp/Hh5x9SEUyrkiVfcFFMOfs88t9LvdB
         mytNBadSHW1esPVzmfBukbTcF09/yWAU86zBIOzeQzWrFJW7Av5m6XxEEbcd5Cwebl0Y
         mWIgqLWb3k+2u48NGTNu1XNdKxGShvWHRn5nHMy9F3XRwqsFA5LuRyTVYMFQzU5VDSwH
         kidpO4BMfxv3iJ/kBvtR5s93xCS/Pq9sePlHqHtfIzMtDhd0fpJOHeutfOP75VGQmlh4
         W7+nWZ6kYKycR6OV1ZCaY/8a8TB9k97sZ4Nqf1jEtpx6g3moYQxuSRyEXITWNCvz5Osg
         r9tg==
X-Gm-Message-State: AOJu0Yzt4Qf27RsBMsCKKQknujhouRohn5rIRa2tvmuYpYKKgRqwkeEn
	tmZigwbQ+xgYBoQRmJfPJfo1PtlB+MQgH3ISCsE1zsBvhXaOrnU0iG//pFjR4cfje/hA6aVTUrL
	Za3A1G2xcU7PIxqNVCs4/yI8Xl8M=
X-Google-Smtp-Source: AGHT+IFKZh+CjgMGQ5hx4xmoDzJBPK0Lw5U/I03jRyIQafEweENqaspMUIRU8illjuKx87AH+VFdX9bmv4bRbGktKpg=
X-Received: by 2002:a05:6870:65a3:b0:214:fc3f:3471 with SMTP id
 fp35-20020a05687065a300b00214fc3f3471mr4671188oab.40.1706778038277; Thu, 01
 Feb 2024 01:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki> <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
In-Reply-To: <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 1 Feb 2024 10:00:11 +0100
Message-ID: <CAOLa=ZQCh1YR9kGzjsX5EFkkN2n55gCX_S8PGwTSMKN=94Y+AQ@mail.gmail.com>
Subject: Re: Git in GSoC 2024
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <christian.couder@gmail.com>, git <git@vger.kernel.org>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all!

On Wed, Jan 31, 2024 at 6:58=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hi Patrick,
>
> On 31 January 2024 6:40:36 pm IST, Patrick Steinhardt <ps@pks.im> wrote:
> >On Tue, Jan 30, 2024 at 10:08:53AM +0100, Patrick Steinhardt wrote:
> >> On Tue, Jan 30, 2024 at 09:38:48AM +0100, Christian Couder wrote:
> >>
> >> Yes, the tests in t0032-reftable-unittest.sh should be ported over to
> >> the new unit test framework eventually, and I think that this might be=
 a
> >> good GSoC project indeed.
> >>
>
> Nice. Good to hear that.
>
> >> If there is interest I'd also be happy to draft up some more topics in
> >> the context of refs and the reftable backend. I'm sure there should be
> >> some topics here that would be a good fit for the GSoC project, and I'=
d
> >> be happy to mentor any such project in this context.
> >
>
> Great. Thanks for your interest in willing to mentor!
>
> I created a fairly rough SoC ideas page for now including a barebones
> information about the unit test migration idea:
>
> https://git.github.io/SoC-2024-Ideas/
>
> Note well that the existing idea's description is far from complete and
> I mostly just cooked it up to serve as a template for how the idea entry
> could look like. Kindly contribute towards elaborating the same :-)
>
> Also, feel free to suggest ideas you have around refs and reftable
> backed, Patrick. Those would be helpful.
>
> >I noticed that the starting period falls right into my honeymoon from
> >June 17th until July 19th. This unfortunately makes it quite a lot
> >harder for me to mentor projects alone. Still, I'd be happy to co-mentor
> >or help out in other ways.
> >
>
> I too don't believe your vacation is going to be a deal breaker for you
> being a mentor. It should be totally fine given that we get a backup
> mentor who is also willing to mentor the candidate. (side note: I myself
> have no knowledge about refs backends. So, I suppose I might not be able
> to help co-mentor this one).

I should be able to help out here, happy to co-mentor on the reftable topic=
s.
