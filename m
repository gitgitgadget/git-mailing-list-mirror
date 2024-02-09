Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F031A79
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467779; cv=none; b=Zut1cFZubhzVy76I4GSNMTGdFDDEw87Pt55P42txAsKwgkNMPBbBg5UDeRPA7INlBbgIIP0gzFepmV/VKz83CU2rD5YNR2r0IcchiWOne5t2+cGnhMkyqXVxqLGMJ8i2x6zXRrKNe28+h/RNDWEez/025lA8EmucQryIn8073ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467779; c=relaxed/simple;
	bh=wBCBy1LPOAPs/ET1QAkIq8XLqOH3NhRO/PBd0Yg+u8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZLuv1kn+mkQG9fTUTv5TX9R+zdNa1qeINYpTY4yqZeNTZFe3NQ/cZp0kLIrS903sFSr+PN6IR1tUAnJEUzWnBAkxsFkyZoO8UzxLE1gl4jYrbyKQGIBIFJeUyWTx1zNvuP8cBBj+9Jc7jdb3U7WzXrZz9QwHLk7oMZcTlnMVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etruYeam; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etruYeam"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a39e31e1aa9so81687166b.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 00:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707467775; x=1708072575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGzb5Ad4SwO861Ks65Ax3MIaf/C/irc5U9Kacl+CYoA=;
        b=etruYeamfnOP+esefpu1uZzs+Lf8WKoII7l8L3g5FNHkvhWkCd5UYosDQbxfk8zDGR
         /HKtYhxZ6n5GGpewku8WpfEysH0nlA/bFUtpYko+cVV9VH1wj/9N3Y+W7L6vP4SuVeOl
         DpraUQg38FAeXIyK+ZwCkR0EQTqY/kOhLwnaqYO10AG4o3Yb6/eDzPbr76gAPilLmyiF
         +8QX2Ubo98nN2BdrtFGr2Redp3crntTl2Yk+DAaN1oCD0sKRTuvb6AGs4FLKp1boHWYF
         rFrCcORNE77zeCl+kfnUH+BrZvuVjV/WvEE+BQvakLmkzlkvrF7HPryFMsS9uzR2xscr
         GQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707467775; x=1708072575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGzb5Ad4SwO861Ks65Ax3MIaf/C/irc5U9Kacl+CYoA=;
        b=nxIyKuhv2NKrx1Ip61S4JeSAHbrBEm1Y2dBgNzr3D0EFcK4JswmRazNqYy86GvY2es
         MhJn2FanCASaoQgQsN4LXyGgZgozConbW7BxWZfrCoFcsbLXCXy1OWy5169wJ74f6E+Y
         7y1iJ41fc2OeYCbC2A7GP4Ghm16pY54d+8pkEqcKuG40M5uViHDZN4YfJPO3NFQMdJGh
         sGg7tLMhOIvJAD5cQd2oZERKxZsoIvIzKImVR3+N6R+3apqQNaRu9D/oVlIKnczcP9bA
         DGlAtwBPiFqakZF0J5wo/zSx8QKos8uG59+6xqVoI2HGF69A4O/lRnxYLLyrS8eR2g8z
         lIuw==
X-Forwarded-Encrypted: i=1; AJvYcCVTCp+sy/XU4vZQd26g4M0u0io65q25ihif9H+8Yh45MFg8/44E1z2Ah06LKDrQFt7SCFJypAovcfihp+L3xKzo3c2d
X-Gm-Message-State: AOJu0YwCDY3kEROfhE2dpmSFew+uRb9RHzGieGxKvrAGCMbdSfJuNXzJ
	NyTt1Oe1yrVI78TQqsZZg8jRrRzk+ZnAYuu35Yd/Rwe6IiPW8SvJmQvykXsDrtGi4y6gdubeL9G
	IKA8Mrd9bhtIHDlIAuPE5brIbsRE=
X-Google-Smtp-Source: AGHT+IEHx8u/SykjYXtagf7WQoL2KZiC8b1lMBZIlATyVAhjfNAy0Cdws7Kdm8NTcQIvnYCQNm6t216RwekWbcM32HY=
X-Received: by 2002:a17:906:856:b0:a38:8d72:250f with SMTP id
 f22-20020a170906085600b00a388d72250fmr626930ejd.44.1707467775337; Fri, 09 Feb
 2024 00:36:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <106b8e7be9ddc2d24670b01d54347dfcf9aef196.1707122040.git.ps@pks.im>
 <CAP8UFD3F95TzytdpKO=LLf6Y_ejxwh9QtgAxRNKgMXW-72hjgQ@mail.gmail.com>
 <e1c04f67-5981-4393-8a8e-a28cc53858eb@gmail.com> <ZcHIxcrKbgyhdyWn@tanuki>
 <CAP8UFD2yFr1uOjKOnMjznjR6BEzGqq=R7K85z2Jz4i=sG0CLJA@mail.gmail.com> <F2684AB9-C4F3-43C3-91F2-A6D7D71F4927@gmail.com>
In-Reply-To: <F2684AB9-C4F3-43C3-91F2-A6D7D71F4927@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 9 Feb 2024 09:36:02 +0100
Message-ID: <CAP8UFD2nc=p5DKyfAWEKUsSCWWWbNvBHS=a8=7TAAq_WoQNGRw@mail.gmail.com>
Subject: Re: [PATCH] Add ideas for GSoC 2024
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kaartic,

On Thu, Feb 8, 2024 at 3:02=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On 6 February 2024 1:43:02 pm IST, Christian Couder <christian.couder@gma=
il.com> wrote:
> >On Tue, Feb 6, 2024 at 6:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> >
> >> I don't quite mind either way. I think overall we have enough tests th=
at
> >> can be converted even if both projects got picked up separately. And t=
he
> >> reftable unit tests are a bit more involved than the other tests given
> >> that their coding style doesn't fit at all into the Git project. So it=
's
> >> not like they can just be copied over, they definitely need some speci=
al
> >> care.
> >>
> >> Also, the technical complexity of the "reftable" backend is rather hig=
h,
> >> which is another hurdle to take.
> >>
> >> Which overall makes me lean more towards keeping this as a separate
> >> project now that I think about it.
>
> Makes sense.  I suppose we need to capture the distinction more clearly i=
n the ideas page.
>
> I've tweaked the doc for the same. Do check it out and feel free to sugge=
st any corrections.
>
> Ideas page: https://git.github.io/SoC-2024-Ideas/

Thanks! It looks good to me too.

> >Ok, for me. If we have a contributor working on each of these 2
> >projects, we just need to be clear that the contributors should not
> >work together on the 2 projects as I think the GSoC forbids that.
>
> Indeed. We must make sure to communicate this to selected contributors if=
 we end up choosing two of them for the unit test migration projects.
>
> On a related note, I think I could help as a co-mentor the non-reftable u=
nit tests migration project if we don't find any other willing volunteer. :=
-)
>
> I'm hoping I should be of some help on guiding the contributor as a co-me=
ntor. Feel free to let me correct me if I might potentially lack required k=
nowledge.

Thanks a lot for volunteering to co-mentor with me! I think you don't
need any special knowledge and you will be very helpful as usual.

> >> > That said, how helpful would it be to link the following doc in the =
unit
> >> > testing related ideas?
> >> >
> >> > https://github.com/git/git/blob/master/Documentation/technical/unit-=
tests.txt
> >>
> >> Makes sense to me.
> >
> >To me too.
> >
> >> > Would it worth linking the reftable technical doc for the above idea=
s?
> >> >
> >> > https://git-scm.com/docs/reftable
> >> >
> >> > I could see it goes into a lot of detail. I'm just wondering if link=
 to it
> >> > would help someone who's looking to learn about reftable.
> >>
> >> Definitely doesn't hurt.
> >
> >I agree.
>
> Thanks for the feedback. Included both of these links in relevant ideas t=
oo. Feel free to cross-check them!

Great, thanks!
