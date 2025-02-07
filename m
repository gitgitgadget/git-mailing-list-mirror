Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E21A08CA
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738915645; cv=none; b=ftebZw8f5yKJcolIj4sZoHeqdZ7m6PKRh435bv/Yo6rCzvpUKgA+Xqa2Oy6+L/oBkReMy3UX4v4/NIETq6mdktqe9MP0v32ebys04YnJN9/UjSkXgl64wH8q+8D69aVKjITpC7R987yAi/miL0Yb9pTUxq7HVgOr2HV1sp1jAyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738915645; c=relaxed/simple;
	bh=2lEPqth/bxhbesls38m6g+3UGhGYB5AgLdvCtYemWrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6hQ8weamtaydLk5BzjGMn8/lJJAEeBis0unUPjIZMqGrOQf7Xe6nCcvWyhXYcRHEs0YTkOVG4rf9HRS5oo4rQkdaliC4UNft4Kya7Jbv5WFfSJ0hWvlIElvOzkiAp0ITo0yWe7KttCECRUguSQmzfLhLBGJV1ddO/+Ure45xz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cw9xg8hV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw9xg8hV"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dca451f922so3932610a12.2
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 00:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738915642; x=1739520442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lEPqth/bxhbesls38m6g+3UGhGYB5AgLdvCtYemWrg=;
        b=Cw9xg8hVRdladaJj19GQhXt3SBpM230Dtle2lbcSWnw6SHjwWeEtxjnoMWXvme+04D
         DIjs4fQ27IMS55t2tWgjGktruZ3MyBfujLGtJ3dqrQZrVzeJlDVfyJoAxEbb4BZXDEZS
         3gt3jaRcSfK9r69GxnnuOkvo/Clxe9fazbw1064P+/LZnRCqvApisVlQdFCpeKsC9ZRp
         osrYMoB4RVvd5nV28LPhlD9b7TCIK4KNI2Edr0/jPBVeYAG6aXGNu4ka9p9HEzW91d0i
         ca9+AuDlpYmp/k6MlOD1kBPjdfy+KjMRFxV+F4GyAlez/g8JDVQ5L72kO9To5bDjdOE9
         udBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915642; x=1739520442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lEPqth/bxhbesls38m6g+3UGhGYB5AgLdvCtYemWrg=;
        b=O/qlTsJSZyPSXNgi+0Fqx4mzkglBw4m1Tp+2cJRdV/ye8ehs1jGWxrZ3jEEYmUb9+Z
         aOg4OYb7orJQ6W2U5fvAuCMWjqKrtu8KfgWJisyYWwGGmbu+z66FGqKR1YBVpYHxQdeu
         KkeC+HtP//jCtrhLLgXJ/amgaUsBBdlyvJXqVuQClf1MRP3DKUPec0HezKC2DQiD9B2u
         0sJcFY8PlDGeoB8Rm+iwqvFscr6XPOVBbDrYv12lJc+TPYuGbLLNuONZLjKNsfFTWu6x
         d2IdoRpKGurfuxmRt7ews5kO/oQ3g/zuhYzzN4+69v2Btbyr6Ey9hrStl+MoQuYm9PKD
         Zfnw==
X-Forwarded-Encrypted: i=1; AJvYcCX/maL/MiEENhx2N+o5WuBUnCLCfdJ+X2rJhXgdNcWSGZcYkW5QpQ36G5xDpkP0GSWJWvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BMrcI39HqvTJYysKmGJ7YxXKEbUQ+YSY8VNYN1oGiywwD/qA
	JTGq/PJOZoMT9vt9k8eMGx/p1S+K0vWdELf5XW4D4eL4TEssTeBBSQJnqTwxwQS1C9pS0/uaWXq
	juhS1g//2281S/HWHzZxVENbA2t7OJg==
X-Gm-Gg: ASbGncsNPpETe+gEc3dtExgLGlZ/NcKxsbkAUDW/5GmTUmpFfeMMaSY+LYFf5mG5fV2
	ugXt2nG21t6Snx9smjr9Mkq0HDvORaqNuSf7SikaVd2nBtfllCWjKeJPzKQyWUZFHvE72tE03JV
	I/SWxikMSUjN5qHBaC8H7hRiUr3tXA
X-Google-Smtp-Source: AGHT+IFSf/SxqotOa4JyhcvUbxBVHrG17sUlTH2WMvYgxwvTRuDbny0Wc2AjLeFTPGUr+mAvmTAkX67BuMM2Co9L2/Q=
X-Received: by 2002:a05:6402:27d1:b0:5de:4add:d52f with SMTP id
 4fb4d7f45d1cf-5de4adddbcemr1128485a12.32.1738915641970; Fri, 07 Feb 2025
 00:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com> <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
 <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com> <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com>
In-Reply-To: <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 7 Feb 2025 09:07:10 +0100
X-Gm-Features: AWEUYZlGAPcuV0muMGr_bukMHuM6sFgJYrTuKCSHD-A-aUJhemyJF-N2uDGVgis
Message-ID: <CAP8UFD3YPSFT8izveGmNZ0a3YsNiqQt5tm11tHW4Ld0rJj+FwA@mail.gmail.com>
Subject: Re: Git in GSoC 2025
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jialuo She <shejialuo@gmail.com>, 
	Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kaartic,

On Fri, Feb 7, 2025 at 8:32=E2=80=AFAM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> -- 8< --
>
> Consolidate ref-related functionality into git-refs
>
> - Mentor: Patrick
> - Co-mentor: Jialuo / Christian
>
> Refactoring in order to reduce Git=E2=80=99s global state
>
> - Mentor: Christian
> - Co-mentor: Karthik / Jialuo
>
> Machine-Readable Repository Information Query Tool
>
> - Mentor: Karthik
> - Co-mentor: Patrick
>
> Implement support for reftables in =E2=80=9Cdumb=E2=80=9D HTTP transport
>
> - Mentor: Patrick
> - Co-mentor: Karthik
>
> -- >8 --
>
> Let me know if this sounds fine to all of you.

Fine for me. Thanks!

> So, I suppose we could
> pick a maximum of 3 projects but we cannot pick both "Consolidate
> ref-related functionality into git-refs" and "Implement support
> for reftables in =E2=80=9Cdumb=E2=80=9D HTTP transport" at the same time =
as Patrick
> only prefers to be mentor in one project.

Yeah, but we have time to decide on this. It seems to me that we can
still come up with new project ideas and possibly new mentors or
co-mentors until it's time for applicants to send their.application.

> Based on this, I'll tweak the ideas page to mention that we could
> pick a max of 3 candidates.

Thanks!

> BTW, I've just submitted Git's application for GSoC. We should know
> by February 26 about the selection result.

Thanks again!
