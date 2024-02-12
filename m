Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8BF4DA1D
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778106; cv=none; b=dLXjOUkEytFyIYstGHsOjbil3sSx3n/9xwY7PWp3QTPeoP9aBOU/elfAWid9dFUzTqntZaLH/2yYeBJed0PSjp1gwgA5ok9NsfcYUUhTHoioC8axOXsC5WQUeUItbpNnDpY61HxOrIk6qg5FbPWOgJDe2O+FWMO84+PV33U6x/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778106; c=relaxed/simple;
	bh=605IEkbOTAFY1x+VJY1mQsWPpltxnLLdsLWmQfxTKuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE6kIgwo5o8w7K4U61JeytDLC1iGKgNf6MsDBn+nMwE63k8hez33U4zEYWtCkHBSvuKmdtNaF/GajopeL+7if00aNDqXhYiam7V0JyRnKxikE3itBxgtEjJhSGaBAtj2aLfSisiExW5NsYzAbef8x45EdGMGCCfWvTpKiY5QIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ag/V7vCw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ag/V7vCw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d93f2c3701so18409125ad.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 14:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707778104; x=1708382904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyiVp18ukZWsLrvFfCiNZjInjrqDJcyM7Q9V2sD4AoU=;
        b=ag/V7vCwIfMhRhTJL+LyBbCwe2YgK+2/NrBxXHJWSBoZ45PzMlxplCN/ia9rInGARD
         onC3yJ/FsQv1j0T2zAwa6KjWveKmZgwSDj5Qz4ott/Vkf61US4Yk0QFBmHkZxIN7tZ/r
         cYcObAa3Q/y+TcjR9NnW3iowZGPUeJEJECYaNJQMlpROJlx4kYVfYXVKtMHA2Xzxj16C
         uJrCJoImTK5js9lT0aYlBdVdy1gQ+wmWjQUtksTi6Q8zFJHAmgaSXJseaH12wP98hxhL
         KgyvvMjQ240DD9r952JolkI2nN4vYWwUlSirB8eFpF0tS9D4j7FVbXkblJSINDDVk5M/
         tpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707778104; x=1708382904;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyiVp18ukZWsLrvFfCiNZjInjrqDJcyM7Q9V2sD4AoU=;
        b=CE0RxURmJsjzXIbpsaZ00SKzsFdR26NPD0W1DA33debgP0162Ufi3bzekctqbPVhv/
         rtK9Bqk7caAYO0XWGRQPmTf/lMG2FzEfZrONR1vRJjxPlLz/SwIXEYG6LlzbW2/OISbK
         qrwdBohMIlPHpymUECpoAiShKHpLYGvf+C1ORk2L0NuZeP7aZwoXkfWRk0X+gn7p9QQs
         N6LHmo5r2WNdQyW970IRQRj++OBfTHf10mmvS0PqLsyFbKgg+ByyIlAFbRCp5cBQRBcE
         3RWHXDigeRAvrBjS4y66yi4qLf+rdmAbegED2daHYGT68OHR/3Zi1DBgXUjdFKYnudja
         bMMQ==
X-Gm-Message-State: AOJu0YwGGzuQkDawndNmVFRDv9np4YLGNh+rI5acBFpvDPzLVJwGGXgY
	jw1WSVrPREvHLpVP8Uilv1+Y6OfRHrUWn9/Ngik6o5MIECvRwE0B9OKqOsmKqio5NM9+ONs7kXo
	6Zw==
X-Google-Smtp-Source: AGHT+IEwGhsbOlv4SiZDduqDSy+qqBRx/FiFmtNOpl6weunDqIfuw+uHdBpu83TJomJ6RYg1pMEHRg==
X-Received: by 2002:a17:902:ced1:b0:1d9:a2d3:8127 with SMTP id d17-20020a170902ced100b001d9a2d38127mr7466691plg.52.1707778103800;
        Mon, 12 Feb 2024 14:48:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXqm1NnEpgbhMzEz5y9cuEXZQxsbXWIeeqxHWI85DkMPleLTrRmEzRoGJLozRQdml6pSIDKM+kVcWXdR957GnIbGu3zh0fHYXvp+dyNIyOOj3cwixP4DQ22qq3qVmU4+75Gkkx5KK4R62CRAflRJT4H3CRTj8=
Received: from google.com ([2620:15c:2d3:204:a710:9f21:f1bd:da22])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903308b00b001d9a146907dsm847568plc.11.2024.02.12.14.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:48:23 -0800 (PST)
Date: Mon, 12 Feb 2024 14:48:18 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 3/6] test-tool run-command testsuite: remove
 hardcoded filter
Message-ID: <ZcqgMgFx97DbH94y@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <e1b89ae93e930cd902d1527955d588c3d0c15490.1706921262.git.steadmon@google.com>
 <xmqqeddo6lkk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeddo6lkk.fsf@gitster.g>

On 2024.02.07 12:55, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > `test-tool run-command testsuite` currently assumes that it will only be
> > running the shell test suite, and therefore filters out anything that
> > does not match a hardcoded pattern of "t[0-9][0-9][0-9][0-9]-*.sh".
> >
> > Later in this series, we'll adapt `test-tool run-command testsuite` to
> > also support unit tests, which do not follow the same naming conventions
> > as the shell tests, so this hardcoded pattern is inconvenient.
> 
> Makes sense to explain what future steps this prepares the codebase
> for like this.
> 
> > Since `testsuite` also allows specifying patterns on the command-line,
> > let's just remove this pattern. As noted in [1], there are no longer any
> > uses of `testsuite` in our codebase, it should be OK to break backwards
> > compatibility in this case. We also add a new filter to avoid trying to
> > execute "." and "..", so that users who wish to execute every test in a
> > directory can do so without specifying a pattern.
> 
> As we discussed in Peff's Makefile change that enumerates "which are
> the unit-test programs?" Generally, $(wildcard) and readdir() to
> slurp everything in a directory, including stuff that is an
> untracked cruft, is not an excellent idea.
> 
> This is not an end-user facing program and we are in full control of
> its input (most notably, "which ones should we be running?"), I do
> not think it would be a huge issue, though.

Would you prefer if I remove the default behavior of "run everything in
the CWD" and require passing in at least one filename filter?
