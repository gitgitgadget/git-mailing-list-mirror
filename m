Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959F10E4
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629535; cv=none; b=VP31dVZ9vBdl9V8dIktmrE0DGV8UceNx7B+0UE6LW00NnZuyhYfgYq1Kef8yskJKoNA9WMwCtL5ddvzVy1I9rW+TNVb2AUN4ytsP3m3BMfrKOo8v6aa9mE0RwuMnV6EN9hAvJnyHA9rjvSCv2eEsuRIXbRICEVDDeAst6bMsvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629535; c=relaxed/simple;
	bh=zmToU2wfPF6akJTo0y7phSBIuupx92PEvRd2j9fC8fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n04mKSYHk37yoccGz6Ox7JESeDg4Si6FyJW/s4EFE58YWLzNd6e/a0FcXjTMB9j11zHcxs61pXsiXDWhAALtGimJnRJKlh233dE4jsQyH6apwqBAYvA34lkz72mrQXSYLpUV6LKQFQO9jqvml5BjQwdBpxUcAC3EuCKMuCBgArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUTUyYx1; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUTUyYx1"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cddb0ee311so3555241fa.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 17:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705629532; x=1706234332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFGO/IJ7x+SPdYj6LENrjAIZ/26h3BRZUf0zQwpXZU8=;
        b=bUTUyYx1gZ/jeoWRj7Ob4wvRUNCxAtd06bbW1gl1tEIkwa7eHkhqPiovcBTldK7BAT
         uETf+i3n7x59gkIetWzJXZjtssTAPPaewd9n+nysEAxhPJer+nweRAGII02/kVp4+etp
         JdyHpXahhAQ/zE2rFOhHNSVsaFnJtxTiSChZSdSXrPMme7UQIZLbeeSI6A/MF7H5E683
         KcNYrSKRbUJwZXGs6f9UpjUzOmO+75iB/FB4PMRGPB1q40ZoJEiBRmpT3sz8wf/iQyPD
         ARwa4/R5AyFuWq+XHOljOBGIjekMmPePhRCBvbFomvTGKQE8p9VxdI5iwNNZlL+3irkD
         Om7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705629532; x=1706234332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFGO/IJ7x+SPdYj6LENrjAIZ/26h3BRZUf0zQwpXZU8=;
        b=d4yCHUn8nd1KEzxpWMziBgFKaE6HlOU9NVuajhOMWi48PwhiSd0zdThoH6zS2PidpY
         2QUBWTbENUqS4LGkbCy4zIkcKUlWhKkXmSDqpm5QVH0Vx9pxY47UyGV3dCZZgHx8dhB5
         I/x9eM1YVHEzHjBx8Wo8TRZGi5vO0uBanfSk6vN8zCL4iK8yHo7WkLHVkzRppprJszGl
         mv1Asfj7Sf5FmAtvw6BOMN48F/WhVc/tqs1pz/PFdoEVhenLCLROdz49YeGjzJKAIobR
         UF6KzqT4o7BjWlrHrysSvN3VChThjFduCIkQIZgj2/F3T4DtPZOrPsSPFVgwCmQhZceT
         mcPQ==
X-Gm-Message-State: AOJu0Yxq5/YP8sr5tDjGDFa2T46z07uYRiFfwt6t75XutGJVT5PQKjYB
	Y10X2TS2vGnrXSGlDZ4zrxGphqoWE/ls7rjiIJdrLRAaAbS7nETPE4DazvHuixLvFxER0/RchM0
	MlxR8UylywMb4VgyJ3p/pq0DqAL4=
X-Google-Smtp-Source: AGHT+IFe70jszSwjqakfHapeVvy+716p9lpuQKhoSHlkJIF7CiO9B6KJTGWSCPKIQeUa47Xz/MyBYtFf6AA/RLz5/ds=
X-Received: by 2002:a2e:95c8:0:b0:2cd:d406:fe34 with SMTP id
 y8-20020a2e95c8000000b002cdd406fe34mr490820ljh.90.1705629531788; Thu, 18 Jan
 2024 17:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmst5yply.fsf@gitster.g>
In-Reply-To: <xmqqmst5yply.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 18 Jan 2024 17:57:00 -0800
Message-ID: <CABPp-BEG+rtjxC32N6WBR-yAsYKWUZOLJyFvmq=PnZ=WUx+spA@mail.gmail.com>
Subject: en/diffcore-delta-final-line-fix (Was: Re: What's cooking in git.git
 (Jan 2024, #05; Tue, 16))
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 2:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> * en/diffcore-delta-final-line-fix (2024-01-11) 1 commit
>  - diffcore-delta: avoid ignoring final 'line' of file
>
>  Rename detection logic ignored the final line of a file if it is an
>  incomplete line.
>
>  Expecting a reroll.
>  cf. <xmqqedenearc.fsf@gitster.g>
>  source: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>

Reroll was provided here:
https://lore.kernel.org/git/pull.1637.v2.git.1705119973690.gitgitgadget@gma=
il.com/
