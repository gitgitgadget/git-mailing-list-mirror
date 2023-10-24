Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C33440E
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DAE10CF
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 11:02:29 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77774120c6eso307479685a.2
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 11:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698170548; x=1698775348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRw7j0ndZv7Qu3WHMFuUcSIjsbzH78wMPbwKu+LnEis=;
        b=jA50sq05MoJerHt5OtZmV2CL5ZIxtS9wwuWkd9isEQCjMKM0VzHfJOttqwMzmYQ4D6
         7I2lPdWpXIqHX4YGfMc9jsi2MxyQs6ysGyve1Y91TCK9frIk3/qGvAIkZjw1g0sR7QTe
         e86byHCX04P0Trs3YTY8/mUWZ6gqdg+ecoqnX8G+Bq04IsXYDE4gvZ28nxZH2F5dkmb3
         14dqvHbsLmSotYB/hksdAxQ38iOAFrZhx/qpsGuosFnf1vp38dxNtrBdxDwWGV6JCLNy
         JTSyGdOd0CUOGY2Y0uI+k/mYsKL09GMrdE7xjhoP79sarozAsuBS2qN0PV5BMERqEi5B
         aVHQ==
X-Gm-Message-State: AOJu0Yx5OfM776VJzq9xgXobKkDXengrqILM0LvMO/rHjDtyafmt7JeK
	l3bOVKMBmcyg3zy02fe+HX4GBbxEN93mDxE8AXE=
X-Google-Smtp-Source: AGHT+IEgQxgF+xWFTGydpB/yg5md8MYRP/NLUEwJ7qX+SrjUtPMQZR8ckoxx3l4BdduZyfAw/fhmSAlky3XcI3/CwiM=
X-Received: by 2002:a05:620a:458d:b0:776:fad0:cc3c with SMTP id
 bp13-20020a05620a458d00b00776fad0cc3cmr14692139qkb.4.1698170548117; Tue, 24
 Oct 2023 11:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698152926.git.ps@pks.im> <29c0c0c6c9728f286efd0b78996f9a1394957862.1698152926.git.ps@pks.im>
In-Reply-To: <29c0c0c6c9728f286efd0b78996f9a1394957862.1698152926.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 24 Oct 2023 14:02:17 -0400
Message-ID: <CAPig+cQH4cV1KnwUWjFz-dRn1dQ9OWdmwaUpTMSjYwJGtnX5Gg@mail.gmail.com>
Subject: Re: [PATCH 04/12] builtin/show-ref: fix dead code when passing patterns
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:10=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> When passing patterns to `git show-ref` we have some code that will
> cause us to die of `verify && !quiet` is true. But because `verify`

s/of/if/

> indicates a different subcommand of git-show-ref(1) that causes us to
> execute `cmd_show_ref__verify()` and not `cmd_show_ref__patterns()`, the
> condition cannot ever be true.
>
> Let's remove this dead code.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
