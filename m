Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5420482D9
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938040; cv=none; b=WJTVIEH0WsZj7TvBSXU4YOgNnFlg2IE2eyqoLhpUqRlUbMzBBr0y65vx2BlO5ZDi24GGT69UwJvRzR2GXzM0OPKOW++aCAnAcuErvH35zgYo7nO6O1RHburhfmzEbCMVbiO2UTPN234x1qLOnLJzfZ8Iq1dP97qY+vvQWXhRYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938040; c=relaxed/simple;
	bh=9cKWYWsZDELCWwoGcrONJOJIppSwC5AZp5ur8s1CwOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFkf0TGIutj4RqqHqhwpqI4yHnZYAzGA+cQnJWUHLZdnnCGLVrZOaSHnr8ghBUeia7tq6D3lv0H3dALZHLWJ7elZUQT5SrJRjvWqG6r6nc6Bi3odeLCRt+QaLkpLwnALiJkxzqJtbTD6/mDZs/Giu9w6M9Pag0B+yHSV62HleqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P325vSeX; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P325vSeX"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2142ef4a7feso896904fac.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 07:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705938037; x=1706542837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvNgRlgK4WGQODE6IZiaFy+tCOHjB4LGVrxuc1JOsp0=;
        b=P325vSeXujiRzg9jFxUe5IILm447rR1N+SARzVwcJZ3nWcEcSWh391NAQJjHBxEwdr
         bRfKbKNOQB0Aswy9ZDfPAdnXp3NgSqdXSeARU2XJpf4g+pf/XR7RDEyR6l1CTmM7gBiD
         pydO+h9eqkoYdTaqxQ22AzVbhP+/OA4dakY3HvJUcQ8tBRlJyeaBJJ8CMaBYusY0esYu
         U2Fe+61nJiIld0pyUe0h9iv0UVMR57Hr3uGJqDaaXKkx3jkVojyg3SW3C2RjcLrxX/5S
         ZqsYD6PCrkqcr4jIGGoCZzeRLLS99H2w9ZdIPhSEiflRhb+KaEYmapPvMhojxMHL0jnW
         XSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705938037; x=1706542837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvNgRlgK4WGQODE6IZiaFy+tCOHjB4LGVrxuc1JOsp0=;
        b=fvs5pgDHgJKwrQQsGVKxq/PglO4sT/vS+nqvfeeN542nj9ICAd9jBnKLwYhX5sHQXZ
         4b+IY3gMHtZ3nPLiqaub1255MaQTerPmzXSCGmpZDvHQ1TrTsyn3l6ygyxKI2Xp2gGaL
         FnOD54OxW4U9GnQilBpEkeLgaTW+j/cmZV1EnDUc34gwbRuv51m3mjBGZuGFtVoSULeJ
         /uXAn/FJ3QJQxC3kOVXbjT5w+/84H8syjd8zmL0t2Xwhi0obWcgvxKnTHiGaE5S7vB3N
         rHoTTOhaAPyYaczw2/DM2PJthB4bE4QlzJ1nI2YhIU5HvX9s00Sj2ixrjbeUSa3q1Zyb
         kF7A==
X-Gm-Message-State: AOJu0YzbyscYK9ckDME4OU10tajVcE0JfL91ClvdhTgKnGrfFgzYcs68
	GpJV0/IptSXoq8L4fmtRzaKMJafrKur3YIarjek0tYTpdxvvWU+G2wMgviEouJD+st5juAzr71D
	Cz44BJ1ImDNjNkX/tsRRsgaJq1C5UCfC6
X-Google-Smtp-Source: AGHT+IFY+rybCc5xDMxxoqXRJGwI/TxpDrmGS8ieAEouIpFoZDwqpbN7dIHSC2bzrkIieBeKsua28299xvrsvpj+mUI=
X-Received: by 2002:a05:6870:c797:b0:210:8cf6:4a9b with SMTP id
 dy23-20020a056870c79700b002108cf64a9bmr69098oab.21.1705938037571; Mon, 22 Jan
 2024 07:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240119142705.139374-2-karthik.188@gmail.com> <xmqq34utjbz9.fsf@gitster.g>
In-Reply-To: <xmqq34utjbz9.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 22 Jan 2024 16:40:11 +0100
Message-ID: <CAOLa=ZQNKCabBBx9OEmZzfEcpzmTSAh3do4EgoqMENiQW+Axgg@mail.gmail.com>
Subject: Re: [PATCH 1/5] refs: expose `is_pseudoref_syntax()`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 9:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> >
> > +/*
> > + * Check whether a refname matches the pseudoref syntax. This is a sur=
face
> > + * level check and can present false positives.
> > + */
>
> What does "false positive" mean in this context?
>
> is_pseudoref_syntax("FOO_HEAD") says "true", and then if it is
> "false positive", that would mean "FOO_HEAD" is not a pseudo ref,
> right?  What can a caller of this function do to deal with a false
> positive?
>
> Or do you mean "FOO_HEAD" is still a pseudo ref, but it may not
> currently exist?  That is different from "false positive".
>

Yes, I think this is what I wanted to say and what you say below is what I'=
ll
change it to.

> As the check is about "does it match the pseudoref syntax?", I would
> understand if what you wanted to say was something like: This only
> checks the syntax, and such a pseudoref may not currently exist in
> the repository---for that you'd need to call read_ref_full() or
> other ref API functions.
>
> Puzzled...
>
> Thanks.

Thanks!
