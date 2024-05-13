Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362D1DA24
	for <git@vger.kernel.org>; Mon, 13 May 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634478; cv=none; b=GrSYGsTkeQmfayBQO3eJJEzpzoJ90JbaJQ/jeVoM+chraAuheDAMHK+9gPapynw+/YhidA3ml9rUe0dF+X3VR3QMDqN24Z1dpubiiZxDjD0pbKOogB6La1bHONFbkWLoG9KQENoITmhD2hhB99/3EcdUtOODJNerO20ALEforSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634478; c=relaxed/simple;
	bh=FvpWS3UW1S+/FHdJ6g/wPusxTdSAvkXVz3NwIWKZJ3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2E5Cjp8VF4nkpRLv1wju3DpNMZn/yehgDL3bu0S40NnDds/6+CIzKk2sWIxElT6Jk2Z7oTm8RfQFj80Rm2DJxC7b8IM4GqIOIdzwRFaTqHT5+s3m76W9EzdGu1DvtTaunZfynj7yz8N2AEo1qkNHCwFAmD674EjV2zPITb6b8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcDDdq6x; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcDDdq6x"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51fdc9af005so7808390e87.3
        for <git@vger.kernel.org>; Mon, 13 May 2024 14:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715634475; x=1716239275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFLN7fwEUl9PpVXN1aSrT39LqWVkjSKYwK+ljI4Bc+I=;
        b=hcDDdq6xc0mL1e5alRMZ8k/TVUBcaw85Xh4H59oFtH5QiVQHiE2ql6/9sFwvj4Bd3b
         gH5mkaGGDxrr3e2P3/XxRsICdnQD3fIKCigC8uNZVO2S2JLZUHOdmLU3gxEKGVVX/hVL
         euKlqztLMYC0O6OOAOIVjc5sJ65Nj/X8yhHNcDJ85ey4HnDLCNoZBQZQXzVfYIgm929H
         z8u5StoxgoOimuvLrmFm/pDr93iPPElkP+kyJucSpm+joVGTOjjdibqNosHmvjRVnnc3
         G93RcC9JC+ohpjP/PHbt6Qvto+gLXdh6z35ABBMTT5YWs5fW9nYEXGchhCuIamXEqT3U
         cUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715634475; x=1716239275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFLN7fwEUl9PpVXN1aSrT39LqWVkjSKYwK+ljI4Bc+I=;
        b=XNnzx3c9+LuI3V1PrDtWZt3z6d6hDyp7NkY262BFrAtwZGvqjo2wYVl12w9FLLhWqz
         l3qoaAMYr5UiNoeA2Nc+N8FoYN+4AqtNwMF+Vbi8xU47BA8m9MO3o1KrgKdIqTcnjmwO
         X2FQBCazExf/slSIC8wI8EI5vTse8BlT9EArdl2rAJZcWAkGhWr9uRiDkK6YcrTs94FV
         INgGDd+Y6/FZlqX9sBJzpfK6+066PCQ1d7yXfyTXMEW7GSfI8EQLuY3JiRjUOA1vzWXQ
         tZkn5CLr0DWLsblh7v7mGMUAySqjg3kG+MrMojH9dig/kM2wMqOmcAyMXcJLdyGL4K/U
         aWNA==
X-Gm-Message-State: AOJu0YwItDvM/7DQxj8znoTrfnleltxofiiTOgwTTQkXguH8H7w8/27q
	ZnhgDkUMfpoYKAjGDWv4jMgAOr9jEdkg4qLpj1J67kB+RkRCbjND5xMdoWLE0QysSU4HtBMn+QV
	IdpnIpk7RP8Cn2bDXt41O/K6iC0Dl5pXnUaOQ
X-Google-Smtp-Source: AGHT+IELigGJh09XfbdBYZceD23/RlmQaj3MFSuZCP+zkZfpgmQudqUP83kxcO7Xig9hDgaak+fUdCRLfLy3r4r1pj8=
X-Received: by 2002:a19:2d04:0:b0:51c:778f:b569 with SMTP id
 2adb3069b0e04-5220fe7931fmr7522882e87.29.1715634474759; Mon, 13 May 2024
 14:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715582857.git.ps@pks.im> <20240513192112.866021-1-gitster@pobox.com>
 <20240513192112.866021-3-gitster@pobox.com> <CAO_smVg7mdQHp+sg4-vVUEOVRBEoZjqXZu=Kk8PuYc9mtYeMXg@mail.gmail.com>
 <xmqqy18de9kq.fsf@gitster.g> <xmqqseyle8aw.fsf@gitster.g>
In-Reply-To: <xmqqseyle8aw.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 13 May 2024 14:07:38 -0700
Message-ID: <CAO_smVgj85+LdGyhwgyzrCV-KYJ7r+zhJq-cBq_2wa+Qs1bbjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] t1517: test commands that are designed to be run
 outside repository
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 2:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Kyle Lippincott <spectral@google.com> writes:
> >
> >> Do we only expect failure because of a temporary condition (the bug
> >> that is mentioned in the commit message)? If so, we should probably
> >> add a TODO, FIXME, or some other similar style of comment that
> >> describes that this should be fixed.
> >
> > test_expect_failure is description enough for that purpose.
>
> We say this in t/README:
>
>  - test_expect_failure [<prereq>] <message> <script>
>
>    This is NOT the opposite of test_expect_success, but is used
>    to mark a test that demonstrates a known breakage.  Unlike
>    the usual test_expect_success tests, which say "ok" on
>    success and "FAIL" on failure, this will say "FIXED" on
>    success and "still broken" on failure.  Failures from these
>    tests won't cause -i (immediate) to stop.

Got it, thanks for explaining. With that, this change looks good to me.

>
> Which means that when somebody rans out of things to do, grepping
> for test_expect_failure may give them a good place to start ;-).
>
> Note that there were a few very rare occasions that what was marked
> as "known breakage" with test_expect_failure turned out to be what
> was working as intended.
>
> Thanks.
