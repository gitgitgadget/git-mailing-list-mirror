Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E121FC3
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761615; cv=none; b=dnawsWKinozlEa9pOMH2+Kj9WCojslfwimHkH+qomJKXedq68BlM9FTjmu/+Fy/r17k9o+zNk2fk7QnnlYf2JVWtnoNd3a3Bcg3M2Nd5d1xGbAzwyoMdGwuPHa+f9TdsA6XA03G1snT0Kz+kmFrAAMH5VaViJFZmZiA/Vai+kGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761615; c=relaxed/simple;
	bh=b7rZepGFet+S0Aw8heHuNrSxUV3cPkskwEpHMlWUIds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4RIse9y5ZIa9liDujAR9g+SsbzaGengcTX09cgiZ5yaeUPt5UCFYposF8bGM6XQWrO/JVtxkqVoIwRbdApUxSWbzFDfKEb+7eB05SKAWpNiUQu0EIs8Vlls+UZZUZT642j9Tb9QjXEMqUM5J8dGvg+jDhklZ9TzAttQnhV3C6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncqq4qek; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncqq4qek"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dcd8d6f130so2377572a12.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 05:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738761612; x=1739366412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8MWypWpkHXMcoHccVIAAQEEPLsj6JhjNRsGbupCGNM=;
        b=ncqq4qekG4mUijeCjpT5OHz2o0mobas8SMcl+ue2Vlb7svsTBTX0l5XbfGFk+YvQ04
         qTzCgwWulS+iEECC8Y6cY2U61zsmbMPNAPR5/5/A93I9Fjn9TTcMvcbtSATNX18SG8eD
         3nqnJz8zoz/XtcQUzptZ5nZT4OqL/lzUVfCONjrHEdMqtQNpuFJoMp8FG9vr306QZkes
         idfEo5DgY35Nn6gWb5lUk9ADLZC5sjTNz9xMWhIXETq3V0K9IYS1dmvyAlej15YL3db/
         s3jVL2Y8nfUN891IecgqOGs3pVvmtAOavhUqMeBhoHHeAIzqaNyfvfPhKAeTA9SFHYOw
         zCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738761612; x=1739366412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8MWypWpkHXMcoHccVIAAQEEPLsj6JhjNRsGbupCGNM=;
        b=Nk+KszSs0Y085kLTKtj7ROXNo5hp8OkksxqC+vdc6eczRBKP9/isfw/RvpL3bNiROP
         Pr0GCDfbMS2radLoxZiWZRmtlm/nqH5Eys8ogfhnkCP3h1MWryjaEb/S4vMw4wZvQUcp
         P4ZyT1L9tojpTeH8yFmmAJxRqBRf0YNRhC5mGx27Hhg7gJEFgiy5oLfcz2LhySAhJTgG
         XNuS/i/JmDJsm9RjyZIp6lkQzzkHDG5JvN3BPFaVkRoTScgfz+U8qWRSCAwGvKFMdLX0
         9zAw2P2N4HARAMwi/RSWmg124+aku3nzWJywbpP1Z5F51AJ84OPvPob97bBQjlc1MVQb
         R4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVPIW2lu/M/Xl5ySqoUI5XXMuXw1sbSdVA6WrKVSatd3OC/mVsU6u52ZDkkXC9XPYj+U+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwC1maktl3sIAyJkCWF8Nu7nn9ST1e8FHd/qL3BLFwrFAVb3Gf
	cBQG1cxYs08DfE5r5gJGiHAVO+DHXr7hmE082DVp7JFexAvGP5hYUF62Up/FZ2wd7yHKqQdNSld
	7IebSExN6TMgQgWZ/3hJ2pZ3WU8k=
X-Gm-Gg: ASbGncv2SqLOKUOSpdZ2ERDigjPOaXfwPS7Oxdy+1WFTm/xCOcFiQe3wlGVeNh9GaVn
	tBxPWE8lH/eCZWz/M5UXAUb8HYfQAFj8DbWRBxnetMaINClPURoE4KiKXEUwnbjzPVcAGRNHYCc
	g=
X-Google-Smtp-Source: AGHT+IF7rZ6OQqkNJVe8Kbj+TjYTeqq3VqYEU6IOooguVV0Ee4K8kxvjWfYHC6Hl2NnJodmS9RMokEdEQiTjucYpcMs=
X-Received: by 2002:a05:6402:321e:b0:5cf:43c1:6ba7 with SMTP id
 4fb4d7f45d1cf-5dcdb77f481mr3548256a12.30.1738761612360; Wed, 05 Feb 2025
 05:20:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com> <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
In-Reply-To: <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 5 Feb 2025 14:20:00 +0100
X-Gm-Features: AWEUYZlEBWDgcHh6eT3M27Yb_pvwdVMh5vsc4G6WS8AJHGlCyWyW0ZaUtctUATw
Message-ID: <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
Subject: Re: Git in GSoC 2025
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jialuo She <shejialuo@gmail.com>, 
	Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kaartic and all,

On Tue, Feb 4, 2025 at 7:33=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> - Consolidate ref-related functionality into git-refs
>
>    Possible mentors:
>    * Patrick Steinhardt
>    * Jialuo She

I have just added myself as a possible mentor. If possible I'd like to
just co-mentor this project and someone else to be the main mentor for
this project.

> - Refactoring in order to reduce Git's global state
>
>    Possible mentors:
>    * Patrick Steinhardt
>    * Karthik Nayak
>    * Jialuo She

I have just added myself as a possible mentor. If possible I'd like to
be the main mentor for this project.

> Note that I haven't assigned any mentors / co-mentors for each project.
> I suppose we could assign that based on the applications we receive and
> the ideas that we end up selecting.
>
> Based on Christian's inputs, we should be able to distribute
> projects among mentors well.

Yeah, I hope it will be possible to distribute projects among mentors well.

Thanks for working on this!
