Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC8A55
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749364758; cv=none; b=ZnKocKesCzuPvAIAtEJDCWuTSUqTtfq9ir31WxIDItQr7BhVt1gmeF75VX8Owm6o624IV7nNM19KcUSSUe8W1Nn8ygeLUDWyDM2sVc3fN2R5UOcK1I3+ysfXAt56kX1zxWqX0ZP6VQ13ZAYmGqdSEKrqWb3QM1EesUIEJQ91KBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749364758; c=relaxed/simple;
	bh=dESI6RRHhPt3o0LTFuT4amwPtUwo/E0dIduauHm3v+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2RydMcWQ2wSLGvd/FRff+uuSY/y/FwFuwoA+7Za0G61JCul8pej4Si7cj1ICf0R+HBYlxkcq9iZdbfbbrHadptps8dKL0nNuQbvDf4162okaBxCtU91EHGBbNnpJ2FfG2OCxhOWq+hHYaARYlYjaXP3lLrWrZseXyjCZHuAAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKdJjf6C; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKdJjf6C"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so3687170a12.3
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 23:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749364753; x=1749969553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfqmgzJDDN1trtycvMA6oB+JvgUyKtPjVIYaDz5qO2c=;
        b=QKdJjf6CB/fah9yLRaIeZhIgzbXWsvRmXbeHaXAsuQ+S6a0oUGvL6Fezn3unSYyMs6
         CJsCouvTai7B+IXo5mwLV8dNEwiJlMlNbTPiLAbRQ9zCYGsg9xhiyAd+SN0IXEFmGTbh
         g7QjzT6xArz6dePgXEj/wDjF7O8ouITeTv9cxEYu+wefYhiyytz+QSV83JrVo4sBpWjk
         WRGx7f6r9HFf7cxYtOfIDtheWg9spKN3pVj11iWPRAjURn3GDwk3ZuAQJen+1B1691dn
         uMNXyrS2Un2EjcstNl9k9PiQ9JQV4ajM7E8MjqOvGLHQkptVoLdeQTRDxlZJXyHO5q3N
         OSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749364753; x=1749969553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfqmgzJDDN1trtycvMA6oB+JvgUyKtPjVIYaDz5qO2c=;
        b=Y9z2t9Eo3TT8m36b0I9VVlIsnIuLsPQt2dWqJ2a6mrZIgNsfvbuuFSDMEagoVcYIwh
         /ic1hXk+qPqcAhyqahTQ2Z0+gxvKrHqLoR/pto+4ClqPOUDh/Awm1A0/hQL6DqDAjIxQ
         crdKyiQQUrUCzmsVyXrjyU6aQfQR1NfePDzw+nC3hd/kTb86R98FAT7KrvWBhmfOx+EQ
         9exePtMdLSMEzxUR8WOwr+ukI5jdFQFRUfyTU0gsD2pPF57/FXY77ffyGh4c0RohhY8u
         srBvMacLzYU2gS2Abn+lgYeQDfg9snN1s+kw5xPD1lPFhq8YnQm9W65YMZTwgNHeB9i1
         K/Pw==
X-Gm-Message-State: AOJu0YxF6iH2SJv+oqQPpe8hJGc8PgDm0ehmnjehwr4GS9gjzMg8yn1X
	7qBfDc94OPiG1IyDt8gNrhuWfKFw+lmsJbEGfWPqofD0tAwUvoJ0gjyCv1dj7q8JemCJLcX7py7
	3reQo3qUyKYNRSB+aSqYwUCEpjrnyUyg=
X-Gm-Gg: ASbGnctczsGtsmDsTEXBckI0HR7yq4AjUCf85k0HSDp7vH9afECirj49pV2/zb4uSVC
	P7gSdEypjOZMCt8xKBBFeR3a0jrHVbtVkpFKDWnaigkMK9nGK8YNVyagMF2llWdX+0cnuEDyiZv
	D+a5TNJ6NWgr1Cn+fyudAmQWrHrckOA6u9cNY=
X-Google-Smtp-Source: AGHT+IE2GXpVH7CXCGxY0qP+OAItFkQurNa+iLX3ltiQc5ODJCenf8+wy39SizEFbolVSRs4mvcqjLKFDsaadCLMefY=
X-Received: by 2002:a17:907:928e:b0:ad8:e477:970c with SMTP id
 a640c23a62f3a-ade1a9330bdmr744934166b.23.1749364752572; Sat, 07 Jun 2025
 23:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603131806.14915-1-ayu.chandekar@gmail.com> <20250608003134.7488-1-ayu.chandekar@gmail.com>
In-Reply-To: <20250608003134.7488-1-ayu.chandekar@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 8 Jun 2025 08:39:00 +0200
X-Gm-Features: AX0GCFub4dcB4O7vGadsBZtbjBg51eXl8G6n79pkBZDrwLcX2i3FPTf0JvhhQWY
Message-ID: <CAP8UFD2z4AhtArDn31jY8HkAXrNU-rkQwRE9=M-ntEdsQ3e40w@mail.gmail.com>
Subject: Re: [GSOC PATCH v2] environment: move access to "core.sparsecheckout"
 into repo_settings
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, shyamthakkar001@gmail.com, ben.knoble@gmail.com, 
	ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 2:32=E2=80=AFAM Ayush Chandekar <ayu.chandekar@gmail=
.com> wrote:
>
> The setting "core.sparsecheckout" is stored in the global
> `core_apply_sparse_checkout` and is populated in config.c. Refactor the
> code to store it in the variable `sparse_checkout` in the struct
> `repo_settings`. Also, create functions to set and get the value of the
> setting and update all the occurrences.
>
> This also allows us to remove the definition `#define
> USE_THE_REPOSITORY_VARIABLE` from the file 'builtin/backfill.c'.
>
> This change is part of an ongoing effort to eliminate global variables,
> improve modularity and help libify the codebase.
>
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---

When sending a v2 like this one, it's nice if you can describe what
changed since v1 here, after the line starting with 3 dashes "---".
Providing a range-diff here, when it makes sense, could be a good idea
and help reviewers too. Speaking of reviewers, thanking or just
mentioning them is nice too while at it.

>  builtin/backfill.c        |  5 +----
>  builtin/clone.c           |  2 +-
>  builtin/grep.c            |  2 +-
>  builtin/mv.c              |  2 +-
>  builtin/sparse-checkout.c | 20 ++++++++++----------
>  builtin/worktree.c        |  2 +-
>  config.c                  |  5 -----
>  dir.c                     |  2 +-
>  environment.c             |  1 -
>  environment.h             |  1 -
>  repo-settings.c           | 13 +++++++++++++
>  repo-settings.h           |  5 +++++
>  sparse-index.c            |  4 ++--
>  unpack-trees.c            |  2 +-
>  wt-status.c               |  2 +-
>  15 files changed, 38 insertions(+), 30 deletions(-)
