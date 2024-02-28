Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A04363
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079099; cv=none; b=UH6zCpOiJ+XUKFH06YAOfPsjuI3tN6Uh+BraorS8ndoA9KRzQaxwq7QFmbWnWsut9LdQTgsDyNVAo/vgM2o+OHpwDyAIAqm0ZR/GeJMbPkRQpGbCoKuyY/kzJkTrBC3WDUysN+Q/XsavwP1K+ThjqHhlv/pXyBSNIUwetHT07Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079099; c=relaxed/simple;
	bh=zwyA+jvOyPUqvTNqqnLRz5t5ZLVosAsWLgiciCbYVWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7z8ubyEG15Q+kUsqiI4talk5mz0TY4OeMrcNuKJAsDjmtveeL3sdTo5o/cxbrL9grBqn/kKVB6VKi9xOgNAXfywyQbNHAwr6LX4p3OsuopkWq4fVZwztIJkWsNpPXeYap1093KZnbWU9PHlonlXDv3un3mtd0kttyvmVS2Fs7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPIJ3PGD; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPIJ3PGD"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-608d55ab7b0so35882177b3.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 16:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709079097; x=1709683897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/SvE0kHQuCSPVGJEJF/OkdcC5WMTG+8WxGDoULF1Kg=;
        b=LPIJ3PGD1Ilg7nKOTQhxV/TaiabaFD0aU9iPGmQNn8VtXnF78G/kcJrTagYvRldSun
         h+zy2Twi5Cohv2MSY+yRGuN0q8Rvy6UwDid613PvJTKai5WE2LKn+Hypd3fSWtIbzSpL
         5i80WDHtK1t4pyAv0L7Or1ipfRGhushLAGqRPuSS/J20w386cNSQDDgeak4ri2lOtBzn
         c8i+M1AYgGlvIdaOFs7qXNs8V9valC4F/WSidz/ODRofCWHNtLe4lXX4bY7jsphtYAOo
         N6fUehohR51KI8VKVtgz0X0vLmoCtZcyl1o+Y9lmiZjGov1/1nRJk43z7igBME2pHkVG
         GHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709079097; x=1709683897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/SvE0kHQuCSPVGJEJF/OkdcC5WMTG+8WxGDoULF1Kg=;
        b=UMUCPl05l7ikPLVYRefvzHyXaGXcbhBMYvIhyiTrE1PqoTinnAX3AOC7aCmvryZaHr
         Si5/zVkVFaMV/3fZBh8m9i/Oc2qjXpvLk/teoqBK3WhLc2RVD8Ini7Y+4lTrsCkfIdZp
         I+E+JywHR6vbl7dB3xu04CdF0YqyT6mD+Vi4kyn3SxCqg0An8HbDMsyBtTfmGEbpeP3K
         yDKLE/ZkdZXQgGIOzdM6Gv3wD/+318zNaEfKOhXwvbqipPh7/WRCD5wcgjOswwg4c6jJ
         M8iQEsjT3U+089OUSxsWSqojhr4IRYvkiFy/m/KZxMEwhtC9OHN45jehHXOD8NyPZA0G
         mR9Q==
X-Gm-Message-State: AOJu0Yz6LHgY9VinvnNIbhUYTtHi8yXczsAc5xdr178koB/WakdNyW4b
	47zud9hctzdj2OiKNggyoHbAp1No0bjyWdvTAPSSbxUdhwlzP/LNAqVN2k9Fb5jQRYtRGPzKK/Q
	uHSGKdKHgOUyLiLrWbnZkGNtJjoA=
X-Google-Smtp-Source: AGHT+IEBRcdAMl5I8MUb2VtCr600LbcpSUBwX9zWG6zVdKEHrnMpG2CmWXSgCRZ8cD/yMnGqZ3lSGHv5/sE6wFFCv1w=
X-Received: by 2002:a81:4914:0:b0:608:1cf8:bfc1 with SMTP id
 w20-20020a814914000000b006081cf8bfc1mr3597762ywa.41.1709079097011; Tue, 27
 Feb 2024 16:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706741516.git.me@ttaylorr.com> <d2f11c082d3bf10d9127c330a7d59b7e47ac4f21.1706741516.git.me@ttaylorr.com>
In-Reply-To: <d2f11c082d3bf10d9127c330a7d59b7e47ac4f21.1706741516.git.me@ttaylorr.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Wed, 28 Feb 2024 08:11:25 +0800
Message-ID: <CANYiYbGEbvJHyDG1cQ9gKuRxdcCfwED6N2Ddn-PtVGSsmwOs4Q@mail.gmail.com>
Subject: Re: [PATCH v6 13/16] commit-graph: new Bloom filter version that
 fixes murmur3
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Jonathan Tan <jonathantanmy@google.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 9:50=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote:
>
> diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/=
commitgraph.txt
> index e68cdededa..7f8c9d6638 100644
> --- a/Documentation/config/commitgraph.txt
> +++ b/Documentation/config/commitgraph.txt
> @@ -15,7 +15,7 @@ commitGraph.readChangedPaths::
>
>  commitGraph.changedPathsVersion::

The word commitGraph is in camelCase here.

> diff --git a/commit-graph.c b/commit-graph.c
> index 6c3fbae142..6f9cab181e 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2501,6 +2499,13 @@ int write_commit_graph(struct object_directory *od=
b,
>         }
>         if (!commit_graph_compatible(r))
>                 return 0;
> +       if (r->settings.commit_graph_changed_paths_version < -1
> +           || r->settings.commit_graph_changed_paths_version > 2) {
> +               warning(_("attempting to write a commit-graph, but "
> +                         "'commitgraph.changedPathsVersion' (%d) is not =
supported"),

To fix mismatched config variable, s/commitgraph/commitGraph/
See: https://github.com/git-l10n/pot-changes/blob/pot/seen/2024-02-27.diff#=
L32

--
Jiang Xin
