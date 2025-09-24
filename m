Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926A28F4
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746464; cv=none; b=q50CPA3QY0piRnopvFOV0RB2YnrowCJVZ5+Kzrj0KkBPOsIm/AgEKHeVgloRN3Zyr8uOUyoef2XLicPfVQikG5QFcap7mHTWJRfGIXAKztJCCeMPXqoCiiyj9kU0Izy/BrmXnJessuaxz7Xy5rvc/D1GByfkC7aNzBvp/zmznbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746464; c=relaxed/simple;
	bh=WhUer27ZvnkMQILz2vps0+fLAMdX8G4DwAX5vKM/tr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOtk5pLAJQCqlAZUEnZepgADnvccoKeoRPj8hv2rOhwtUjYAcmNzKWcK6ThYvC7GXhucYk3aa7k2GcCxh3awFbFXH15n8Swuc3Q/dNnfR7rDgoTioL3wvLbMCS1wkBER7yxcIkOhtSBuHT6BFdiY2Wys4gPKDr/FvPTRhv6wde4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k13XzGzp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k13XzGzp"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-631845b51e2so222544a12.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758746461; x=1759351261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhUer27ZvnkMQILz2vps0+fLAMdX8G4DwAX5vKM/tr0=;
        b=k13XzGzpfAk9frjkzePvdqNZyTwrqSZJQOK8TvsD6o+0cM41tbLDBRV7dw5u5+NyfH
         3Qp1s2HSCrRL+apaGkr/7UpUIA7YpPCWItpPV2TuZ3Lq3SuL1iAlNjBvL/iyO6o+uxFP
         dsj+YtGsAZj5PHbpI1ahPoFfmR4a8qbYDuQ7kO+pwXar7rNjdRRYnqRk75VoZQLmF1Ds
         180oHSEE/c1x9pWz82xa+mF5Y7G/S4iVrW+iVo8xhw87GSki5iQTxOuSVhbhyND568yX
         HPkWjEnjAU03TGtkm/NXHgrHEvu52pl9Je3AKs1UQZGsYVw21cv37dUF3tdWJO/yybTs
         H5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746461; x=1759351261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhUer27ZvnkMQILz2vps0+fLAMdX8G4DwAX5vKM/tr0=;
        b=p1pY0IlISBfW+0Fvnc2yfdw/Otfijd/KX2j3PvCLPUJG7Gs4a+7SQsxq9xhayPFrJg
         5wDB4r6xuIBFcHkoopgiFq7Luf9yoPRosKilc5LJ9ki5yMeJTONJ3xNFajGbNAESLYJK
         UVW5Okck2vZW+2IsWaRTyaQIJKoDTyj6GV6/6vZhk59cCaWHHtG/DiSG6kWjLyPrGXFh
         9VBe36O2ZpnGfphxIZTFtvV5Vx0mO/WNWn0+nqZgEGK4mrxI0edyUzNW5YBheNIZROLC
         Kf3r0ABIL4gA3/d8zbAtFIJzn8NtR2BntAU3pFJbnffta0n4cfnqR7BsPLT5nDd8X9NI
         k7NQ==
X-Gm-Message-State: AOJu0YzbZyS0RmI4eUl/3OPPKoQ/TY1ON9eEYDjTx/sNVd9JDwATeHRx
	6TohQWzd4QNUc9sELZt70lbCo0nkUbI3sahiqO3bR5G/T0cr5JK0sWhcL5o1V4h5lInvXeWDwBt
	JPkL7Hks6cRmw4LydcFqcgyfBld75+88=
X-Gm-Gg: ASbGncv/SnboEAJoctpeVb3noKkr1CjZ+BV2GQGZdPOsdBJZQPSCPgIpZEtyR1Vc80t
	ShfYpjcatos5DJ9rSy5vT8J5RvpdwqGTv91WtIkPgmd3I4ShVB9RPi/En6tCGG4Fnw7iW81Srsw
	P6KI/6N89qyzL8tvxQmQN+7d96G2XBgknsvTMSSpJX+7x6jZTuqw+JCO+Mav05SLCX1ylN5V+H5
	qYyxX/YBP52YTdwhjcJIf5UdmvebPaIgsn2eB5dbw==
X-Google-Smtp-Source: AGHT+IGju8F9RL9PGNUvsFyqDhHooWlUtLDWx5cBOtcpJxjBFTuxd2ykQyyO+D5zqQpsfrISTAgv3WXYQ9gpJXCctyI=
X-Received: by 2002:aa7:cc86:0:b0:634:4d49:6b6f with SMTP id
 4fb4d7f45d1cf-6349fa8f0abmr606768a12.26.1758746460725; Wed, 24 Sep 2025
 13:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757982870.git.ben.knoble+github@gmail.com>
 <cover.1758505011.git.ben.knoble+github@gmail.com> <8e6cafbf3a01b968663b65559acf3df615eecbad.1758505011.git.ben.knoble+github@gmail.com>
 <d7721018-3b2f-4764-b33d-4fc6bdc034a1@gmail.com>
In-Reply-To: <d7721018-3b2f-4764-b33d-4fc6bdc034a1@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 24 Sep 2025 16:40:48 -0400
X-Gm-Features: AS18NWDH4DzhiwvLdJxln6EpBrIqOk1TP6-ZC64C5QouTdwbkvmxUtz13x7FMs8
Message-ID: <CALnO6CA9z39rgGd673p-ZMzMOBM_G37YPOs4ysNtPHGGCDVM-A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] stash: honor stash.index in apply, pop modes
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, moti sd <motisd8@gmail.com>, 
	Denton Liu <liu.denton@gmail.com>, Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Glen Choo <glencbz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:11=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Ben
>
> On 22/09/2025 02:39, D. Ben Knoble wrote:
> > With stash.index=3Dtrue, git-stash(1) command now tries to reinstate th=
e
> > index by default in the "apply" and "pop" modes. Not doing so creates a
> > common trap [1], [2]: "git stash apply" is not the reverse of "git stas=
h
> > push" because carefully staged indices are lost and have to be manually
> > recreated. OTOH, this mode is not always desirable and may create more
> > conflicts when applying stashes. As usual, "--no-index" will disable
> > this behavior if you set "stash.index".
>
> Thanks for updating the tests, they look good. As I said before I don't
> have a strong opinion about this change but I certainly don't object to
> it. I think this change will also affect the behavior of "git
> merge/pull/rebase --autostash" which we should maybe call out in the
> commit message. I don't think that change in behavior is a problem as it
> is probably what the user would expect when they set this config.

Agreed, I hadn't considered that here. Should we also update the docs,
do you think?
