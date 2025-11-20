Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5BE1FD4
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763676959; cv=none; b=gFwNbVSLtWkKnkp0lDhjQ7DDaGdNYlZ+aKaxg5n0dnGHRiTsUuXG8yDXhUyPFrsMKzMS23BCJ3IEIG0zYwKtvGHDWktNgH/Z3/STGTYzAonbCZfrnch5MV0rMiS4o5+8MR5/u6SOC4+4nbP2XKVUm5my6iwJjdi3H5UjhuJvdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763676959; c=relaxed/simple;
	bh=pzSQTonne8dVVoYTtXWtlEcPIK98psmWLs08aL7xYLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzeBMCqxIB/u8yOXo8Jxbs0t6UA7+OUKhlX6Ez4rrf+jTw4fzRPGJ37IUJxEdqELZYMs99eXV5Ibkfu7mlFiZ8uq56ulIKYlq8cO+7VBmFa8LcOCQjQvwMB6jaM3HjJI4usurdIkyICs4UgT+DnVpykcdrulJeQpv4KUvr0gGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ7hqEQj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ7hqEQj"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343f35d0f99so1135461a91.0
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 14:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763676957; x=1764281757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlTWhUGbb3mYQveMgyFw5ofkxSkImVK1ZUb/PMjRKec=;
        b=MZ7hqEQjPWofBiAojInvaNDqv3A932lU6FiJujXKFUovDTnkgkXN4J5xn0sPfwbzne
         twUT7nwKxuV9gTuOZGgtsoKyWHBCsSKbKIwydSl7APmXaDMdTFXPthlIiTOYhzDuyWgz
         kK5FFyJbeJmdb3f0zufxrWE2uyASXMygkjlu2VZcu2Bl7qm9/E161bPSHxElgeqs11YI
         F6qdhPp3dhrnpTTsAgZJp0YPoEq0YXY9uVufGYLeA9L6+AtlDh/UIl3OJc5xgvA88d+F
         OMDv/pKxOVqXgoaXPk50n97/I3uUnyhcEpZtZAD9cD2DAf24yXDVRsb7Cb1do7IpDygm
         TKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763676957; x=1764281757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IlTWhUGbb3mYQveMgyFw5ofkxSkImVK1ZUb/PMjRKec=;
        b=FRHGYbC9Ael8Eid0tk5HpQls+l96W4JKEAE24LfLAOZbkwgvL/3F52+EPMkhxXetYC
         QxMfUvPYHwAW0iLQvrBfrOt+OJZS0NLEMAOfWP2ewFDrcgfTA2UPugxHHPRjPAbuTtgR
         hHs6PwVUPUDrYlqAAVYqFJ6NSbPVr2EzA37piaGPfgiTjGwae5b/QX6wP4oRl+ZCKx4b
         tLmRBz54AvAKdkIEndlEkBkj3S1NEF8Q9Q01XCaVyBQ07Lx9BfNJv0koVBHtbtC/Bqbu
         k9J3y5L+kfYB5LjIKvKQ5LncPvM8+xPLjICC2MGFzo4XMSHFxsQOyceKvUplJpAiLd/6
         6hOQ==
X-Gm-Message-State: AOJu0YyQWCp+9+wawyXkf90doxY6pX/+vG+VnOy30Hz7G9ouli7UoWab
	HFm/7fkAijgoX++XHcJecpVXcDjV4TnpuClPUHcvejrOQL2sizafXP5eTgCL7KCGO/6sijUD7eu
	vksuw5syQNIF5dewl+9fGpblFCZ7ihL4=
X-Gm-Gg: ASbGncvQE1cKyGfxQdAXP1bUV904KYABtLV3TDoQgQpHA5ApOma4L8dHClkltMnUrEi
	5vpvWXhqBOIiLwL9LMrQ+7dhQnGHKk8Gzt3+RziekofX2rExnWQcglyCk8j97h1FJGgeZrEmHFh
	CnKVMJdDlusyQM5Ah5tmLjszkefjgLmaPaEfEiJwRm2qo+nnEUa3aV8TnMkFrl1CS0//NdheNjI
	o6QA2L1o2bBT/PlGOHbEKvKRzcEn/igdHtds6/sPyXxzzQVejOIoW9Xfy3QdQXpB97R6iqOClCb
	ZBGbpWlRk4PCjD7NUg==
X-Google-Smtp-Source: AGHT+IF9VB1n3FHmTAZ2d28koGX6782GU4iDDf8VZ5eJtDmNUD3nFSCD9LBXa2j/2vbT2yAaKv48rRE9MiFR3Ie2HDQ=
X-Received: by 2002:a17:90b:35cc:b0:341:194:5e7d with SMTP id
 98e67ed59e1d1-34733f19c00mr27022a91.24.1763676957385; Thu, 20 Nov 2025
 14:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqms4g7b1h.fsf@gitster.g>
In-Reply-To: <xmqqms4g7b1h.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Nov 2025 17:15:46 -0500
X-Gm-Features: AWmQ_blp8W4ftqheXczJvfvXBJVaPXTLam7eQFTgm9dH_dckMckySi_n0SBnXww
Message-ID: <CALnO6CC0HU60F47yoE45ei7_K2_MeLRS7fihMPn+f8top7Jr7w@mail.gmail.com>
Subject: Re: [PATCH] config: really pretend missing :(optional) value is not there
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Han Jiang <jhcarl0814@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 2:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Earlier we added support for a value spelled as ":(optional)path"
> for configuration variables whose values are of type "path", with
> the documented semantics "if the path is missing, behave as if such
> a variable definition is not even there."
>
> This has worked OK for code paths that reads configuration files and
> stores the configured value as a string, where NULL in such a string
> is treated as if the setting is not there, left as the default.
>
> However, there are other code paths that do not _ignore_ such NULL
> values and misbehave.  "git config get --path" is one of them.
>
> When git_config_pathname() helper function finds that the value of
> the variable is an optional path *and* the path is missing, it
> leaves the destination pointer intact (which usually is left to
> NULL) and returns 0 to signal a success.  format_config() helper
> however assumed that the destination pointer always gets a string,
> which no longer is the case, and segfaulted.
>
> Make sure that git_config_pathname() clears the destination pointer
> in such a case, and teach format_config() to react to the condition
> by returning 1 (which is different from 0 that is a normal success
> and negative that is an error) to its callers.  Adjust the callers
> to react to this new return value that tells them to pretend as if
> they did not even see this partcular <key, value> pair.
>
> Reported-by: Han Jiang <jhcarl0814@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This is only about "git config get --path".  Another patch for
>    the rest of the callers of git_config_pathname() will follow in a
>    separate message.
>
>  builtin/config.c           | 45 ++++++++++++++++++++++++++++++--------
>  config.c                   |  1 +
>  t/t1311-config-optional.sh | 36 ++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+), 9 deletions(-)

This needs a tweak to Meson, probably in t/meson.build, for the new
test script. Otherwise Meson-based packages (like Gentoo) won't build.

--=20
D. Ben Knoble
