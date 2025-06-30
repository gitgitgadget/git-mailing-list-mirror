Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D24919994F
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308478; cv=none; b=ZgwL60wC3duSNc1QNCEx5Ne2fZy/gedvPbbL6/Jrd92dja57m1yXfraLfiwBB/zGAH+C32WT4j70f4n/eUuT59m/7IHAnGk9i6XIRTCIBO5xUnTQEkGyNUt4tQ4g1yZX/NonYKUxqAnEO+dXn+agleyDSCcZIkrV6RKKJuWi7Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308478; c=relaxed/simple;
	bh=iUvUZaFZom4XexO6aXjdLvW5KwYmIVEQ9kf9+jpdZN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AHaUj5g5WCMRFs737SPCnqkEaLiJI+Cqr3CVJtwGJbwsFbejPIztmrsyhGn5N9p7MVWFNuB0eOkoa9c4DigVFls45O2U7/1m7aMVpgQADveC+dWUN9ln/V3dHQCYlRmO6rparb7tzg0mag941ZMgBXUcC0/G5HUCKhw4ipxB1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1xVBBZi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1xVBBZi"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so3943085a91.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751308476; x=1751913276; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLn06do0uvlX1H2dHPiCwUaMfux7lpPmXAzwBPnyDvk=;
        b=C1xVBBZidJ+9RKm+okynNMk4JTg1MpxEu28ttqW/4sx4dFv4fm2bYTyoqTz59ZZ10o
         mzZTxa3lTUobV/2/LIzd8sMhbWuy8vTIxTbl1cvEG7Tv7WpDS9eP1TH+Rl3FXeyxvWZo
         9W5taG20+9MZ5lPvxNQA+tJ5Tn+q3U16hZQGz25nEufnGyCSrGH0LNSh9RLMXUsgneTU
         9guRiqldEM9c66P+9usfR/UaRjg0DqnCVFvKnYyphpDYI6ZEJdoE1ORfiOyOmXcor4tO
         zGmd6Vx6oaz9OKwqMqH+wGN8lPPDswk6b1hyVjwRortNkuNqY2196966hHHcO27CVbEQ
         dHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751308476; x=1751913276;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PLn06do0uvlX1H2dHPiCwUaMfux7lpPmXAzwBPnyDvk=;
        b=M5VGEFvfybOAms8MKkJzrRKozO56EdaNA5gqRh9JLPPxQadA55JbtwRRlxFkTB3tvk
         XQJpDjZvWGKCqnN5Nf5YArh3MmoB+EVyuE4nCPTvn4nVcamQb1yoY2b/EJkkRWkMQxKe
         ExWQL4fT25Kft1mfHGH8sDozJUxkD+58bESXGWDO8v0yZNrLDb6OuEpX8GWDkZafl2FB
         4CS8i6Vtir2D51glBzncrzVj62L+gnoSXbDxVkKr+5CH7hQXECq/ifggSmE5sqWoZRYI
         mf708uk4Vpj9ruHVJe9j3/FgYOTA0Ls8dhM9BQM0mP+L1Xzk6tqIdD93vHinB0yB10nM
         hEVQ==
X-Gm-Message-State: AOJu0Yw7mM3cHG3TGL2u2sfRD9JFGXNYzywAk70i4SlGN2rF/PUHcEe3
	0FBG9U0Tslna9gAK0ItrWUds/Ir+q50QZEfRQWxHLvazuZRbHF2J8wTh
X-Gm-Gg: ASbGncs5Zu/dvOGvLLxwaSxdTbp4f8OSGeh11tVYvc9aQww3fcSh79GoKT+47IyJfIE
	TZyzSFbpyCz1CJsbhbRHjvayMqnJoB/Zv56EUPivtXBSLS2s/KxHKci0QYmsPr1yMQI5VoHNav3
	rUqpEXNafRj3s59Xl0JR4X9OUDfMQZw5gzLYoBmU3ZEceFmwTtRG3bp7oy/DZ0jqbu9v7eloAUV
	lDYLkHh5i+lG4ZX/ZMjc9dqwdQcP2zmu1LRwHlNhF0S3O3FkfK+SbATBmMbJgwUcOmg3gOn+31p
	/U+qpAPaEXvHiDbg9OIMkZibIyKJnoyryGtL4pmXmndAAi+4yoOUOgYveCkVzI5SoDsbiDf+hjk
	lHsFk8WtWP0Fw5GQh4bdql04PzA0=
X-Google-Smtp-Source: AGHT+IGN6LTNH09CM4VPjRQq0QuLRn3nep6NyBIFs+L5/8mErlshX77hObDtcU6oGmlfRkoKruUalw==
X-Received: by 2002:a17:90b:2f8f:b0:311:a54d:8492 with SMTP id 98e67ed59e1d1-318c910de41mr20798819a91.6.1751308475582;
        Mon, 30 Jun 2025 11:34:35 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3193a3a2474sm169316a91.0.2025.06.30.11.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:34:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Raymond E. Pasco" <ray@ameretat.dev>
Cc: git@vger.kernel.org,  Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH 1/5] apply: error on --intent-to-add outside gitdir
In-Reply-To: <20250628225819.1294068-3-ray@ameretat.dev> (Raymond E. Pasco's
	message of "Sat, 28 Jun 2025 18:52:03 -0400")
References: <20250628225819.1294068-2-ray@ameretat.dev>
	<20250628225819.1294068-3-ray@ameretat.dev>
Date: Mon, 30 Jun 2025 11:34:34 -0700
Message-ID: <xmqqfrfh13k5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> It makes no sense to register an intent to add outside a repository. We
> should error out here.

I am not so sure, especially if you still keep the original "if we
are using 'git apply' as a better GNU patch, ignore -N" logic.

Not that I am suggesting to also error out when -N is given without
--index or --cached, that is.

I think the most problematic is the claim "it makes no sense" is not
linked to the conclusion "we should error out".  The behaviour of
the original code, and the behaviour of the code with this patch in
"a better GNU patch" mode is based on "it makes no sense in such a
context, hence we just ignore (instead of erroring out)", which
makes perfect sense as well.

> Based-on-patch-by: Johannes Altmanninger <aclopte@gmail.com>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
>  apply.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 8bbe6ed224..e7856ae6b3 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -174,8 +174,12 @@ int check_apply_state(struct apply_state *state, int force_apply)
>  			return error(_("'%s' outside a repository"), "--cached");
>  		state->check_index = 1;
>  	}
> -	if (state->ita_only && (state->check_index || is_not_gitdir))
> -		state->ita_only = 0;
> +	if (state->ita_only) {
> +		if (is_not_gitdir)
> +			return error(_("'%s' outside a repository"), "--intent-to-add");
> +		if (state->check_index)
> +			state->ita_only = 0;
> +	}
>  	if (state->check_index)
>  		state->unsafe_paths = 0;
