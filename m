Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1B2CAB
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043535; cv=none; b=ZX3fgvsa1KBWCSXAZlidQ/anaxcuM+r6LZ64bxBxPyLOmEN43ACcRS0KWlRIpNTZB6ccrUm67SA7CtSs4kGihPTLX7nnNpvsXHqZ+93VeuEX41gb00+9XqWgM+VA3NvzKx7kcR9TFLd2dZ0yYT7XUcEYpuBY7Jyji1XbNLhDW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043535; c=relaxed/simple;
	bh=DX0EOM6GDSYRIDUODIs/Dl7eaYRY9bQoDaGaKOx7cPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJWtadpcEDNAtP7Y5Tetiv0IlHM7cvGyIK00+Bnq9RuCfVLNV8GKNW6l2vWu9Mpm3TPFeA8fXkStZDNvj+V1WP56ww7xonhK59BO41md5q+RVgIJwIvSpyJzMhXxW2Xsq2q29qX2hMT7eCux0oX/8SjQsY9LtjRgZFhwy0Tb9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czMTYz7X; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czMTYz7X"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6157ed5dc51so3107499a12.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754043531; x=1754648331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gW27xq6Jc1mPntzdnuN6p/uTwRh7VhgLQH5YbiAtKxs=;
        b=czMTYz7X5Fkkl/cfChCXHw4dkMqIZbjyy8vNT7q3AvxYlPdhbj3P/QFVPUGh4nP2L+
         5brJXSWJSVNiLUkZ3U8IIJkhQj84hjK19Kqu8kr3Kb0gJNN3gdVX/HZ6eChzG0y+2Jz4
         QE+XkPDdaxliC2iM5RE+LqkJR9WNVyjSklNmdXScFDqTdsUhNtKSIuZiOmXjARHFffR4
         k+GPQDf4lFBT6VbcW8s4ryVs6LZJWU15Pnfnq3meo8mVUTAdJINl9anPh+h6dqxPdbHN
         4Df0s8VjdElbCdD109l0Rm6sVz3IJvYWu5JGdfpfGfkcjE2eGbGHym31HiUgl9NO34XZ
         RAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754043531; x=1754648331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gW27xq6Jc1mPntzdnuN6p/uTwRh7VhgLQH5YbiAtKxs=;
        b=MZSV03ac7bGKI6aWZ8uXC6bbgVcSPEDHt8anGOtAznxi3iWeomEzux7zP7TrIWh5aY
         hGAB1eKmGVLwmEuQPE9j1EQs7JNgncRyReUq8D3O/JzRg/TaFsPgz3zyvVIuHgIV9aZD
         68d9FR4WPKDESLq90/d6soErWmob98NlOgnXxP4Gp6A1IHOVpEAk0pyjAae+197az0by
         TzOucRM6Fcw4O13RVYjD7W8QjCBM35cS9dHugp8tgaXEIy3YNeNNpt3JQ2jCQRRmwPhY
         obbkH7VA3YA433Cjwgdyx1FcQVomZ60ihJK15PJAMWYvmxPRzLmN/T5butc28NZIclvV
         nE0w==
X-Gm-Message-State: AOJu0Yzqy96Ujf5qch6McevWnmbTCj19d+7RXpTnKDPUSt3sgMv+c+Xn
	KEiJgldZiZ0W2UkJvkl+OIIzEjWOiNPquc3CC32egAB0UDkrJJmNZAjYgiAy4fmPjDqv9zc3uJ+
	ICUYT3ITF2Mq6S5HFxTmCH0F/OF4MPXg=
X-Gm-Gg: ASbGncsLftKuYxV5TTHwZFpzhkXhjC8Q1ijeNrsTdx16ZBJlAFg/iydaOurGN0O3a96
	EVHEI/jdOLTMM3Ay5i05A0aDH5zMovEv0Vg0+l2jaRI7S587Ry/YIiiOqOlDx9a4SetqFcIa0jt
	izqTudyiRvUpy7JX1O98+BGvTg4CbhYgazcV4IeV9NdGQB796Ml7CZd/IgRMWNdN0RSkxPWazx5
	lgDi3m10g==
X-Google-Smtp-Source: AGHT+IEjNskBncNTp7G2vadaShomZdBo1NQqlI+UQE/nBYcAAClKBdH2s8g/SjCjayq1BP/jm16r22ruAvoR+7SsP3E=
X-Received: by 2002:a17:907:1c95:b0:af2:3c43:b104 with SMTP id
 a640c23a62f3a-af8fda8328cmr1290557466b.54.1754043530975; Fri, 01 Aug 2025
 03:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716133206.1787549-1-toon@iotcl.com> <20250730175510.987383-2-toon@iotcl.com>
In-Reply-To: <20250730175510.987383-2-toon@iotcl.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 1 Aug 2025 12:18:39 +0200
X-Gm-Features: Ac12FXwSNPBxV8gGCmIKxr6G18caj3O6G_whipoRvtTa2_TxI7oibWA5FBlTItY
Message-ID: <CAP8UFD0AEKDmvQJTanL+ZS+U66WAZz=FKSJ3LPE1QHSEyH-zNw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 7:55=E2=80=AFPM Toon Claes <toon@iotcl.com> wrote:

> +[--] <path>...::
> +       For each _<path>_ given, the commit which last modified it is ret=
urned.
> +       Without an optional path parameter, all files and subdirectories
> +       in path traversal the are included in the output.

s/the are included/are included/

> +static void last_modified_release(struct last_modified *lm)

I think these days we tend to name those functions using "clear"
instead of "release"

> +{
> +       hashmap_clear_and_free(&lm->paths, struct last_modified_entry, ha=
shent);
> +       release_revisions(&lm->rev);
> +}
