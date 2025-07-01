Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD4072621
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751410865; cv=none; b=N3cYckQw4ONbl7p2d2aqjkaLgm0cf9+tVkVoF/QTW93IqZCWAdETlMQDzWN/Dpe3OUJvIyVzVXCsSiX/5lc2iAd7AyK1ktYLWGR/8nSqSGa25r97XZAsPeG/inqQb8VxM4E2ZkWyeiZAwlWXgUXVXr5fgX3FQMs/iq9UelXf59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751410865; c=relaxed/simple;
	bh=TICfGTA/ncDtfx3VibCdEaZyIXKZkl02NcjdLiqbzVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q966LkrTpb49Cy02nhOgaJcNCO0N8ufodNJt4ktkI1JLdCB4D1296HRBCGq6T4gN7Se4UkJpKZD/0guoBclWWfhwz9XYWUY17Mo4/ljsZyyBMOzc8Om9xBSO3OV3XLitPwFf9ETQUtUGI1vKwEGUY9ksOEhrulT5GiuuY3HPGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knfOTAlX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knfOTAlX"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748f54dfa5fso5399497b3a.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 16:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751410863; x=1752015663; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B10sNtu+Kb3vV6jy52W8bUPg7xv3pv2Qz3EHzplIYLs=;
        b=knfOTAlXpNaeMBPmnPWzn43DkEbFmcUAQEptkqFwJwhl1RGXXgMX0AUmXd0VEuXelx
         fTuYsP2d0DaYe7L+rWR+ZdY3z61TDpidvOYKxHl2zvnEmQ8TJHXmPwdP+mggB8wTde9c
         6etbfdZiVTPul1hMAkbf4979gXN/rNNGudJt/UXpMmolOuqwTrsRVZ31WeYuExbLSUXh
         xDLDZdHF4cAHilmDGKFLLFlehPk49TYSgYeiCMTo1RCi3MXm3gHPrrqJjLQ3xybYOVQK
         l9epzSCUVhPoNOSqf0mOlMVP9kda16o2apnknE7+oY6dz3MFlGdGTll6uH/XfJLLx2SM
         YFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751410863; x=1752015663;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B10sNtu+Kb3vV6jy52W8bUPg7xv3pv2Qz3EHzplIYLs=;
        b=u1Anhz0oDhIYKLwIl+ElEqgLXKyoreT2qBxFzBjfGgkK0A0ZL7av8eBhwpAg1smFT5
         TXc4GPda0tabkhQl0q/I4HvPMMj/M4UK2ccTHNSw37DcElBTt2E2a4jLzmreaHR7jzND
         CysHdp/qtYd6iZWPiJ9fZ0nOiAeWTHoAOv2CVgxzZvPYnwTLwUiadW6WVeh0m3sDhzfk
         GzhwiPlu3vopbv76d9iEEpW+KNqDsGIuJF8kIrUMiIqeUTLKfYxZoUOjRG6/0xUHESad
         hAOQXo71pgHKm0C4MeBnlhPggz+zWv0Cg5pe8W9KYKwjwz0RabjIsqon+6dH8GKiyYzx
         5orA==
X-Gm-Message-State: AOJu0YyUaqnR5MqTj4YJNYEyWPh9gAPV0BI7U2lESyYkArdeumvEA5iV
	Fjm+JqGR6L5yq+nas1Y/99QgmiWBy+uyhVGdjmPvrnZ9kyVe2Q1TekAQ
X-Gm-Gg: ASbGncsejA2rotzjZrhk4yvVefS3L8dWLPRE6u6FlLJYA95PpF4dc16pvkKLTa/qvGJ
	3Ev6x+6SixfpIDaPf/s/wPSsF97qIOXMRPOQlJTWbqZj6BJkHLNGcYwu7bxuV5dzm5HRx3QDX0d
	hrZL+F7z+Wj41QU2qCIec3FLJSNpqOEZZ/VnHFi0fRqbBgAPbJlPIVurNDCZ+t986XIKIAwNtPP
	NQZ7stsjXkvQisYBCLb3Ef3bLoyfyGRamXGzx1kjhIwjz7+tZ+anPO/m9gM4N6GRnB35vq75Qf7
	xp8rZg10DGBMUN+l1nANs8s0icjHhrmWaCi7ULiOjms98YbwqcoUxaFnsfvUcsHjP1nuMFo4hZQ
	V2+0+flifpcz+vrNO+ClY1Sj8REM=
X-Google-Smtp-Source: AGHT+IGQj4b+LDGotWGuoVJWIGmakVSuSkwVkrBjJN2V+2ym4M4XGNrzjkOx7h8sYI1zTlDde4qYWw==
X-Received: by 2002:a05:6a00:2347:b0:740:a85b:7554 with SMTP id d2e1a72fcca58-74b50e69745mr861353b3a.2.1751410862549;
        Tue, 01 Jul 2025 16:01:02 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af5409d62sm12054882b3a.27.2025.07.01.16.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 16:01:02 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Derrick Stolee <stolee@gmail.com>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v3 0/3] Introduce git-last-modified(1) command
In-Reply-To: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com> (Toon
	Claes's message of "Mon, 30 Jun 2025 20:49:22 +0200")
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
	<20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
Date: Tue, 01 Jul 2025 16:01:01 -0700
Message-ID: <xmqqa55nikia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Again thanks to Taylor and the people at GitHub for sharing these
> patches. I hope we can work together to get this upstreamed.
>
> [1]: https://lore.kernel.org/git/patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com/
> [2]: https://lore.kernel.org/git/Z+XJ+1L3PnC9Dyba@nand.local/
> [3]: https://lore.kernel.org/git/20250326-toon-blame-tree-v1-3-4173133f3786@iotcl.com/
> [4]: git@github.com:ttaylorr/git.git
> [5]: https://lore.kernel.org/git/aCbBKj7O9LjO3SMK@pks.im/
>
> --
> Cheers,
> Toon
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
> Changes in v3:
> - Updated benchmarks in commit messages.
> - Removed the patches that attempt to increase performance for tree
>   entries that have not been updated in a long time. (see above)
> - Move handling failure in `last_modified_init()` to the caller.
> - Sorted #include clauses lexicographically.
> - Removed unneeded `commit` in `struct last_modified_entry`.
> - Renamed some functions/variables and added some comments to make it
>   easier to understand.
> - Removed unnecessary checking of the commit-graph generation number.
> - Link to v2: https://lore.kernel.org/r/20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com
>
> Changes in v2:
> - The subcommand is renamed from `blame-tree` to `last-modified`
> - Documentation is added. Here we mark the command as experimental.
> - Some test cases are added related to merges.
> - Link to v1: https://lore.kernel.org/r/20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com
>
> ---
> Toon Claes (3):
>       last-modified: new subcommand to show when files were last modified
>       t/perf: add last-modified perf script
>       last-modified: use Bloom filters when available
>
>  .gitignore                           |   1 +
>  Documentation/git-last-modified.adoc |  49 +++++++
>  Documentation/meson.build            |   1 +
>  Makefile                             |   2 +
>  builtin.h                            |   1 +
>  builtin/last-modified.c              |  44 ++++++
>  command-list.txt                     |   1 +
>  git.c                                |   1 +
>  last-modified.c                      | 257 +++++++++++++++++++++++++++++++++++
>  last-modified.h                      |  35 +++++
>  meson.build                          |   2 +
>  t/meson.build                        |   2 +
>  t/perf/p8020-last-modified.sh        |  21 +++
>  t/t8020-last-modified.sh             | 204 +++++++++++++++++++++++++++
>  14 files changed, 621 insertions(+)

FWI, "git last-modified -h" does not work; its output is expected to
match what is in "git help last-modified", and t0450 would not pass
without it.

