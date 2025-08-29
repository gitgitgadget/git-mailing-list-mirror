Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB431FBE9B
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436970; cv=none; b=YFLW+wrf5agA9mYIghFWzFAAlKFBzr1icWBtktDChUgyxLb/ICJRz72wJpv8Blfq7AeHJ4EttfZdex6x7bd4MT8O7tggnvTdyElZtnPQSBm8w4pUw4ayPpxrmD/zo+z6Hj4fHuqXM5GMZ+q0gTdTqhKM+Hnq2mGpuwl6JMPg2Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436970; c=relaxed/simple;
	bh=aMhBrcnJjKf+1SJuc0ELiqP8Hh1Wq4sZAtrArsOEBB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UgTJX/WPABMaVHvutaEFqy4E7P1ErWc2wJp7jhnC6bRk2hSzZ41bxyiQ4OOS62ZKFpQffS2UepBbNcMIYlFijeYrdU1km8q9/Ft9scr/3zSQtgQJCGCUEhUXhvZhugdUC0PVrvrx7FSb0uLIxJCsj2BUlB0dQp4dlwYE/kyB/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLNdsDDk; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLNdsDDk"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ef2efc0439so15932215ab.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 20:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756436968; x=1757041768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8meeOgKxyBMM46iZEcbIUd9pT/TCdq2lNCo0WlTjt+M=;
        b=SLNdsDDkkdvPcjdu4GtCgin2ew1XG260NUdhzyXjl3Aei/QWkjKaLCN87ssXVFzf3Z
         SuAnK+Z/pTA+ywqEX7bo4khm/o4v2Q5PjtEYABMGq4wRN6p75qlTp5D68JkQJ3ZIBi/n
         OKAxoqHYIyEEBJ3E9agV7IW2EfOtSnzbngW5cGc/pqMQL1HLPnOzozPHHCNFabN7PJiZ
         F2UraqIpoajThhFtTkMboWFdTS2PyZ3e62VGepQhGUy08qKifnT9tCq/FzubbHF08Hr1
         zOk0gwEreePrberSrA8TgcSK2C0HsybOBAXLOZu5uhLPhDt6dR3b1tTG1gli+vW/9qEx
         Wo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436968; x=1757041768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8meeOgKxyBMM46iZEcbIUd9pT/TCdq2lNCo0WlTjt+M=;
        b=aSXvnWwwL4aVNTgqaaMTqOTIQtoBTqedrfYDbb0imqqpgsHQ5YlLDHW1nyVHS2UIiP
         MKiO75bH/gnLNMkMopu0pz61mGGu7d74Y8n3GKxUF5ComnOSKz6CuSdgHKn7X3/OVZ5t
         fPfotBYcDZ22VY1mfCPmEpFN3Jzqds339KVbLq0a3oHEveDoRhs8UfMpQxRazI8zsfkG
         VXjDAHVpjFu5QONdq4P6i4OSm77pg9EtdcxVefyshGc9N4VoiTopGj+Rs/nVjoamThqA
         MgN8Al5HbxMZtAmxRqvdL/A6OWY28P2+53Xyjw+15WkTXHk6Fi7IaaGI5/M5EbWBOFlZ
         Oa4g==
X-Forwarded-Encrypted: i=1; AJvYcCVnJ+7lLMvrjvj9en3WLkT2QZq4hdOCQHk+swg5Vgmhda+9+Xq/ufKz3qdxq7oAzngVHi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybsva3mAFkkHB8Djilz7w2y/vK/AX9Y1rrPGc7OnkqCUyZeLSK
	W7/jvL2UDpPcbugbVEnK/uuyy4R3inNyrdfWXTuKHpnjzDPNQ29oSpjHPBujpZGXZbXvSB6q82l
	OeGNzkZx15JZfmTLDueX4o0i732nDtto=
X-Gm-Gg: ASbGncuAylvEjPCAoqm6JbZXBcBI0fQIpippLetq0ZfPjLRW7Zch6xVadGVgWTAqFHg
	Pl1EzRRT0pquls1agWbahss0CkEERootF/v4IJcuIEbm06toOOIWJSx6/RYJe66t//iENs66FZa
	wAI6+mJJorguWH0mtT0pViuPMZAnZgLkIHwCYxifOQStpdI54tEXWcPYZogVUgzmfSXhMnd5uRH
	atSI+M8tztxIHrof6gjRqQZcpF0jG3Wt+W8/J/YEVICIoNBvtM=
X-Google-Smtp-Source: AGHT+IGM+xsdqvuK3uYka5V5T2mFkTpwOFmM6Xml3py/UVBDEgqCvyBzjfRjeZSaEnHJwI4X4MOSwyO6GswKN64VRU0=
X-Received: by 2002:a05:6e02:1524:b0:3e5:262b:8303 with SMTP id
 e9e14a558f8ab-3e92231a63amr369588015ab.20.1756436967871; Thu, 28 Aug 2025
 20:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728190520.10962-1-amonakov@ispras.ru> <xmqqa54oun5w.fsf@gitster.g>
 <43459416-ced2-d551-40e3-6db594ca4520@ispras.ru> <xmqqecsvqal6.fsf@gitster.g>
In-Reply-To: <xmqqecsvqal6.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 28 Aug 2025 20:09:16 -0700
X-Gm-Features: Ac12FXzB_KRkXL1bfeAFtdVxjUiGgmqhDbxViPQJ0SqplRYif4agNH9ntR-UT1g
Message-ID: <CABPp-BGo17qAicW0C3o6eURfTvGjXTN9EbTzokcmmTCd_bzpWg@mail.gmail.com>
Subject: Re: [PATCH 0/2] optimize string hashing in xdiff
To: Junio C Hamano <gitster@pobox.com>
Cc: Alexander Monakov <amonakov@ispras.ru>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Alexander Monakov <amonakov@ispras.ru> writes:
>
> >> Using xxhash() was merely a sample code path for technology
> >> demonstration, so the Rust adoption topic may want to pick a
> >> different code path to do its thing.
> >
> > My interest here is just speeding up xdiff in C, is that a welcome topi=
c?
>
> It seems that the (side) discussion on the performance has
> concluded, and Ezekiel's new iteration of the Rust thing moved to a
> non-overlapping part of the system, so I do not see any reason to
> keep this topic out of 'next'.
>
> Is everybody OK for me to mark the topic for 'next' soonish?  Any
> objections I overlooked?

Sounds good to me.
