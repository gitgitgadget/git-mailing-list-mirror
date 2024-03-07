Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6012C813
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818142; cv=none; b=mcB44e4cPwhC6EZElc7N+S4ct+gpGqXIkg76/XBoywV6/5id0s0h3fwR6KaMeNwjTbM+uvg/OglHAXBA2+5IxlExcwK9/5cOHBgocGZP4Kp6MMwSsoI9U7OzOR7GzLslVoL/VvtWOz7oAkkq+2xM4OX1kmc6bdL0V0R3K/NMdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818142; c=relaxed/simple;
	bh=Fxpr+oNI/ghCLaFtMfRNfIf0QGJn6sul8PpwHilahFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epsGVdFyrF+/UIhhdeSzKev9sF46AXWhaUGAS00PPahPfGd+qDk4Iul7/6t8PcTrUfzG8u+GUQlOsmQVFKIzGfxEP7Z5m+mb9AICmG3huo4dWnfW3LPpjdmCUI/7g3Uch4JXProa4iGnPzA9FDSZJjDn2Rf9UIy7qkbS88UqiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF8IsCJh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF8IsCJh"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so135691366b.2
        for <git@vger.kernel.org>; Thu, 07 Mar 2024 05:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709818139; x=1710422939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvnuZABzVjzu9f7fk9OiqM7f/BzBsQsF41QUu9RXuG4=;
        b=FF8IsCJhRqByqvF8eosY/sJyuHFIP0oZrNF4yKZ91CwJZtxLMGqwb5slGOnaw6mvyJ
         ZhoTTuOMwgNm/4YyvQQ5aVhBg3m1DEHHcbPI63KksY2Bedhn0n1oh9rBWnH9M/FwIk1d
         6Ik0GZXTFZyix+vmV3DTskNMgH4WR5YOPRAm/vDsumjwZ/jNRykP25VdSa4oCcoHhgJf
         JcRGk+mk1nEILk44Pr0yTgUiIUC2Pi5akt7aT4IXr7A9KjDIajb3srhAYayKnniIC9S7
         6RWey4vyRyAtUJjL0N+YGZr9F61MRVHnMR45OnFjET54gE5I57Hmsm/00GvnRh0rhRzd
         MA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818139; x=1710422939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvnuZABzVjzu9f7fk9OiqM7f/BzBsQsF41QUu9RXuG4=;
        b=R7QlFnQWEIjbfI4cGw4QFrCIvuAh9B7T11q0HGjngMN2kJvM2U4qZOt4TozDyQHn1F
         bGowo109ieW8k0kyJ+O+0bxOIBsuzL3K/HWdbTuqAOVMdDKil8NqJEHeDb/5n6H/Lkdd
         JmyXGP+A9FFAKpuo3bLsojPsqfzOYUM8EwNg44wY4nHXZybBQj9Gsdq0OxvgaBO66T22
         ADplP2lMHtmzSSGFE+7EEXoyevsnWG8LzjUXPWPpwrnvWrVBxGhlGlDkrgbLhNneZs8Z
         gfmi630+5/tRZyLNZCb5jlF376TAsXO9mt6VFW4fDMQcp/02H9OJvgFjnY3bHmb5E6Tk
         aHxA==
X-Gm-Message-State: AOJu0Yxa7iFYTt3HJYjp2FQ5RQbGCZzCqYUMNe6iQNSsfUpqvvBTksZ9
	K3j39X9cVJaSTAKKD2iMgc8sPigyjLW+3jQuVI3bbFAvNKkgIx5JfDQhiZ3zrQJWm3jgBi4JW/h
	q374vYY0jYRlnwqXhmPBY52c5X6Y=
X-Google-Smtp-Source: AGHT+IHNmpTfsI/2w9kdQ8QfycMujzAbrB+JWcAnkbwM9hBTWDQnQ7ZauY0Wc9aQNJADuKQqcROlbz5K/LKTdafaOks=
X-Received: by 2002:a17:906:270d:b0:a45:ab75:7628 with SMTP id
 z13-20020a170906270d00b00a45ab757628mr5572481ejc.52.1709818138606; Thu, 07
 Mar 2024 05:28:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1675.v3.git.1709676557639.gitgitgadget@gmail.com> <pull.1675.v4.git.1709716446874.gitgitgadget@gmail.com>
In-Reply-To: <pull.1675.v4.git.1709716446874.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 7 Mar 2024 14:28:46 +0100
Message-ID: <CAP8UFD31udQB2e=+G-LpCevuS+JxQdWqwaq=5qvGEn21595faQ@mail.gmail.com>
Subject: Re: [PATCH v4] tests: modernize the test script t0010-racy-git.sh
To: Aryan Gupta via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt [ ]" <ps@pks.im>, 
	=?UTF-8?B?TWljaGFsIFN1Y2jDoW5layBbIF0=?= <msuchanek@suse.de>, 
	=?UTF-8?B?SmVhbi1Ob8OrbCBBVklMQSBbIF0=?= <jn.avila@free.fr>, 
	Eric Sunshine <sunshine@sunshineco.com>, Aryan Gupta <garyan447@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 10:46=E2=80=AFAM Aryan Gupta via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Aryan Gupta <garyan447@gmail.com>
>
> Modernize the formatting of the test script to align with current
> standards and improve its overall readability.
>
> Signed-off-by: Aryan Gupta <garyan447@gmail.com>
> ---
>     [GSOC][PATCH] Modernize a test script
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1675%2F=
aryangupta701%2Ftest-modernize-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1675/aryan=
gupta701/test-modernize-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1675
>
> Range-diff vs v3:
>
>  1:  05ee9e8a458 =3D 1:  14c7137baea tests: modernize the test script t00=
10-racy-git.sh

This tells us that nothing changed in the patch since v3, so we can
only wonder why you sent this v4.

Did you fix some headers? Please explain.

>  t/t0010-racy-git.sh | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)

Otherwise, the patch looks good to me. Thanks.
