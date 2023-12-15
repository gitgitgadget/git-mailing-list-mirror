Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0510A16
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67f0cfd3650so2424866d6.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702622444; x=1703227244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oO1qk3c9R5Emh22kuHJRm6eR8kTyp5Qz+P6f4cM+W9I=;
        b=JZA2nTWMOyRUXttozVooAIgRtz9uNlMdxQjC4jc0lK+ckVOhTLb0Bs80W2Aw1g2VtX
         zYMBZn2gDYfBGOQO2EvBHW5S0kLSIgh9s8OUjjmJJZpAGrWsipIx5Un8dzZzl6ucw5ko
         +EqpAhgBULJzEssIkd/TcFHYCWIRzE8Fpbbfv3Enrnf6iLl+blleTMRYQ/HQdKn2dGoz
         /Hk3XPI2jIolnXNJGFTDU3drZbt0JXu0SwPmUSKsR5cgqGLnJalXIfToC/8mzrtXh2eX
         G7tLs6YFVzVq5NhqV1+mOhiXLL0dqlLccfDk2eyALuKuzq2Y6qsKdnJYJC91x9gVVwjt
         R0PA==
X-Gm-Message-State: AOJu0YynrJKpOv3CPHTK34OBKm+YV/26LTxKMw0uSab9uuu2WXMY+SCw
	qAt2bSZKX2ivtBQ0Px6jzrROT1xvBOXGrx8IWIQhd+XCp8c=
X-Google-Smtp-Source: AGHT+IHT8h5OQjs8S2u28kbmLfbmmJZOwmpt2oY13p5wGZn1dEzv0L66CinKlqM/8AdTt5nsKYR92JLr8XiV643DivI=
X-Received: by 2002:a05:6214:10c3:b0:67a:a3dc:3f71 with SMTP id
 r3-20020a05621410c300b0067aa3dc3f71mr12391441qvs.59.1702622444500; Thu, 14
 Dec 2023 22:40:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
 <8c3e1cb5eae13210070cc14f5f2a3f8c0dfc39c3.1702620230.git.ps@pks.im>
 <CAPig+cQozi+aiTc5Bve4OHrfuSRGUCSkKmhoYtkGTmn64Ps-rw@mail.gmail.com> <ZXvyL2wtoTIt6OVc@tanuki>
In-Reply-To: <ZXvyL2wtoTIt6OVc@tanuki>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 15 Dec 2023 01:40:33 -0500
Message-ID: <CAPig+cSBjsosRqoAafYN94Cco8+7SdUt0ND_jHS+jVPoM4K0JA@mail.gmail.com>
Subject: Re: [PATCH v3] tests: adjust whitespace in chainlint expectations
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 1:29=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Fri, Dec 15, 2023 at 01:24:20AM -0500, Eric Sunshine wrote:
> > Just an aside, not strictly relevant at this time: =C3=86var has propos=
ed
> > that check-chainlint should not be creating conglomerate "test",
> > "expect", and "actual" files, but should instead let `make` run
> > chainlint.pl separately on each chainlint self-test file, thus
> > benefiting from `make`'s innate parallelism rather than baking
> > parallelism into chainlint.pl itself. More importantly, `make`'s
> > dependency tracking would ensure that a chainlint self-test file only
> > gets rechecked if its timestamp changes. That differs from the current
> > situation in which _all_ of the chainlint self-test files are checked
> > on _every_ `make test` which is wasteful if none of them have changed.
> > Anyhow, with his proposed approach, there wouldn't be cascading line
> > number changes just because a new self-test file was added.
>
> I was indeed also thinking along this way and would tend to agree. I
> punted on it as I honestly only really care for fixing the immediate
> issue that the post-processing causes for me.
>
> Are you fine with deferring this bigger refactoring?

Oh, yes, of course. Please don't read my aside-comment as a suggestion
that you should tackle such a change or that there is any urgent need
to change how this all works. The currently proposed simple
solution(s) to allow you to get past this issue are perfectly
acceptable.

(As a further aside, just for completeness since I already mentioned
part of his plan, =C3=86var also really intended that the test scripts
themselves, "t/t????-*.sh", should be run individually through
chainlint.pl by the Makefile rather than sending all of them through
it in one go, thus once again taking advantage of `make`'s innate
parallelism, and only checking for &&-chain breakage if a test
script's timestamp has actually changed rather than checking all test
scripts unconditionally on every `make test`[1,2,3].)

[1]: https://lore.kernel.org/git/220901.86bkrzjm6e.gmgdl@evledraar.gmail.co=
m/
[2]: https://lore.kernel.org/git/221122.86cz9fbyln.gmgdl@evledraar.gmail.co=
m/
[3]: https://github.com/avar/git/commit/ff8b4a12b30ac5ca521a64e74b0fd968ab2=
d4585
