Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9821605AC
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848069; cv=none; b=QiaFEWeJsCT7pmqPCToTg/+A8OLfFvYFXpxBl4jqT5NcLaZDKn2h8tZ2cSxC/SocBnjAxZ866vocg1kzqZciVQJVi3QghNDW9+cwKYv43rIgH5qvJnNpAxbmQj/wTyoB83MkOewj6gZkHRRoH155exzC7kjlhxxfM0pWR/tauFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848069; c=relaxed/simple;
	bh=tbBmA7/aJFbiFf+oBqhwU17kWNAR2EVo7LqvYvlbx+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FZAet91GExvmYFzSVr/ZszxRI+07ihTbMa/zoxs6Mj12xdEMkxwhBESlbLnDCfC5wMcglLONoowFxKgu3wqCxcFuin2zFVScg50Fjjoqr4RBWG7aseoUeuKwc4eaqubTOtzLuLkxeSHDW1hrIBZ7YYpQzsoi7BhL/dJv8ZbyOKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t078Id1R; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t078Id1R"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so8141212276.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 10:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707848066; x=1708452866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbBmA7/aJFbiFf+oBqhwU17kWNAR2EVo7LqvYvlbx+8=;
        b=t078Id1RDTJIgJ7Xx2/OQImtCaWwqDtC+M3OFhL/ydw2vUdnES1kASUPlufjipS+6D
         ydY3pDYGcyeGljQ47v0/3DJ6AIOHyQHM3aW9t58iqGI9AFzXIQK3Q/ktaLVKo+nDNSjv
         zCLnVs3nBnMdxbjuGRlBj0gnIlhTGPVO7MLmStItdjkc2lfxdawifuuU31lvVpP/x7Yi
         r7EI+YGcZ07k7pNoxXGWrLzbYldE5tv10f6P9zVSHIuFh6fSHqA2CtRgQ6AkXekaGl2U
         D6nmDqiIaBz0PrR9rv75Yl9u6voUfBpfZDbLagzmwojBY+t+y1XNFHNDkgro17FhycW8
         vShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848066; x=1708452866;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tbBmA7/aJFbiFf+oBqhwU17kWNAR2EVo7LqvYvlbx+8=;
        b=uTM/Nw4pfJTN5eAKjLKITGGf3PyXtAl8hVABDlK8yCC+XeGmmOi4FTNUzVr9w3Xv6X
         Q1Mf5qgjLr0O4IByW8+5QulvTgI1LAHVyR8DknsAwkicgpd2th1VgwoZrtOhzqbH95DA
         5dyO+vFV2SKL4u82wmyJp3MxxffOvW9Vp1FkkkNMhPlnjDv2ynqzVjNVGv0tiYeqipS1
         YHujWgXuqAhS8aGvINNyXNc+oqrNoh3OXA7pHvk4UDfm83+ZMd1XoE5qK4/O4By9o55/
         pgffHVD9NsrJVWSicwZ4ei7kxgTJvw8miE0DjSNcCeT9DrtPFGAFGsOhiO9ulqlFmN0M
         w5Iw==
X-Gm-Message-State: AOJu0Yy4NWumd3EgXKIZi4nKaB1gN2ZLUSfhzlRstfAoxImO02/Mutbj
	JBoJNUnI6VJsvSU6NfXFaqfCJCx5gABoTyhCmQTEJr/jr9MPV0it1AVqnEHHF07IMHlWJPqR0GJ
	byg==
X-Google-Smtp-Source: AGHT+IHGIz021quLMAu9hGNLiHFJQD/4m9yUy2yrvbQdqDfyuQCZ7lTZGhIyli4KwgFZDMxNEAXqJ3TqMco=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:701:b0:dcb:abcc:62be with SMTP id
 k1-20020a056902070100b00dcbabcc62bemr9569ybt.6.1707848066667; Tue, 13 Feb
 2024 10:14:26 -0800 (PST)
Date: Tue, 13 Feb 2024 10:14:25 -0800
In-Reply-To: <CAP8UFD2-M20uuo4G8HykRL=1g9634wKUT9R6DBG6nmLBqGpxzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <26df2514acbf4d51f40f4b1b9f33a357fa424ac7.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD2-M20uuo4G8HykRL=1g9634wKUT9R6DBG6nmLBqGpxzw@mail.gmail.com>
Message-ID: <owly4jecb5a6.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 27/28] trailer_set_*(): put out parameter at the end
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Linus Arver <linusa@google.com>
>>
>> The new trailer_config_set_*() functions which were introduced a few
>> patches ago put the out parameter (the variable being mutated) at the
>> end of the parameter list.
>>
>> Put the out parameter at the end for these functions for these existing
>
> s/for these functions for these/for the/

That wording is much better; will update.

>> trailer_set_*() functions for consistency. This also avoids confusion
>> for API users because otherwise these two sets of functions look rather
>> similar in <trailer.h> even though they have completely different out
>> parameters.
