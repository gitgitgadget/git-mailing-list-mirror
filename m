Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BEB44366
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710225477; cv=none; b=IapJT3vNefyW9NhkV10/cHjzHZHmsuVq9vCjuoXZV4sTEqYvxlU7qOycrf1IO4myCI7KoOcubyO10d731l18sKgCAe2laEE2CL/ehy6l+Ue/dW34S1juFuhYXT/PYz9KL9nmY+2BAf+ZaZCV+FH7f4RDjrUwXS+s/jrIuSFw4Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710225477; c=relaxed/simple;
	bh=/QkKPnv4Xd6PdJSaJw+umSWzHLkIdXK5S7gtZuDMV4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ5lTm4CxVsMRFk00UwBNfLfvlwP6yoPiKyBYgnNX+4iB47yAB+XU5AAIash0x5n8QGk5SJwTVOz/tSt7axhl9E6oKqXby0LIGvuzvek3OjY6uTVXCRF/a4MsR9QlvwvWDlfVHL6L9nHLHveg8F6kP6IHNUeyGc6bg1kbmPh5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdArZofp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdArZofp"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a462a1b7754so206318566b.2
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710225474; x=1710830274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUXnq748yGQ9U4UPxd9w+cyqGJ2Q5pSjJY+QXhdtyHU=;
        b=DdArZofpBQP4CTW8gN7RGKGm3VaQUXi7mbQm6HkVXlG7xvXN67hhd5msT0kI3q4Dih
         7ieblfoobeqxkR7Rr9Dzc+PnyVnE3Exmi4mYWdeQpDwScwaTiPWEi9w/yghznkDI1ogh
         ibpZFLZvbY6YtW1V30pGPp9QdVrQ4aGBgEnPnLLO6UG6LrHfgY0ro+Oz1PwyP/ouS2Fq
         Lnk2nfLPjEd9zhgDi6JfaftNwjeZZ7POu8SbNZwZ2eKZ/rOvClF6deB/NwPidI2jJTPM
         PbrMyhJTAkfxp43F0kA4bXjrzLdSbd7cA9yD8vceN/T6exixwkdQ3KkrZmfK/LNtD3rN
         MOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710225474; x=1710830274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUXnq748yGQ9U4UPxd9w+cyqGJ2Q5pSjJY+QXhdtyHU=;
        b=XAeXgx+h7GJb/4iJDKsOHQqYsP0te+m05k43FIl9qddsB5eqmu2KlgCBsDnp9DpATo
         OtRDa4Jgp+sISQVugLLlcPMEmZ1uK5OyQ23bmtWRY96JkjFmf1YewGrq3c5woKCTOdow
         u5gRP7DJAHbA7pCg9xduIA5gu7rEJqYqKx3qbdbcs/tEbJ4Bm34DcNYRaTodKuZ9FxMa
         oO+7MAlxn54+Qg5+dM2BhcIARjprcbgtSrfRQQi5nufFTQQjVH+jFRV3JYWXQFVe9HlR
         NKdoMmzywPxPf02WptNq5vQk3QCV9GZRHQZyXf0verb5MNgXhohCtdvVmztQbCRV1pz7
         zFdg==
X-Forwarded-Encrypted: i=1; AJvYcCWM/3kPSyoxpG9FSssb/rmV6dV/NJN6nXF97CysgOa+vNHMPlNty1BqLN0ZKpDSwz1XTBk8QPo/GeysD0jkrrkVDvC/
X-Gm-Message-State: AOJu0YycgphHgwabBGy5/hEipXkdWAZ9hOEsWIl1so4afT2I6wnc0uHO
	a9OmLCibhdVUZ8BrD5PHkBDTOOgiPQ8H8wC1xNsBTw+sQ7SKsb96i6IVW4Khu2VkkRHBGzl8CfR
	dHUJwBFXB6JavePqcHg246DgsyPc=
X-Google-Smtp-Source: AGHT+IE9V3oTscnDnzo085SpREXsKXVWcL6IJEtz6gn1Jttcsq0eAd2d0KaBJb7m8VsrObc8Z3svz+tcwK/vsqqfuag=
X-Received: by 2002:a17:906:7f1a:b0:a45:2e21:c779 with SMTP id
 d26-20020a1709067f1a00b00a452e21c779mr5238157ejr.4.1710225474120; Mon, 11 Mar
 2024 23:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com> <xmqqy1apudvv.fsf@gitster.g>
 <9166fa83-4ed5-41fd-83f7-337fd524d0e2@seichter.de> <cf21edb2-7681-42a9-8b58-beca5d04c179@seichter.de>
In-Reply-To: <cf21edb2-7681-42a9-8b58-beca5d04c179@seichter.de>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 11 Mar 2024 23:37:42 -0700
Message-ID: <CAPx1Gvd4FjCTSn4oUWNDtLS2G4V3yrddggafX0WHfHEdojtCNQ@mail.gmail.com>
Subject: Re: [PATCH v2] config: add --comment option to add a comment
To: Ralph Seichter <github@seichter.de>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:22=E2=80=AFPM Ralph Seichter <github@seichter.de=
> wrote:
> I have now tried several times to inject a LF into a comment string ...
> Variable expansion with LF=3D"\012" ...

You must use a literal line feed, e.g.:

    LF=3D'
    '

(a single quoted newline) or, in a shell that supports this syntax:

    LF=3D$'\012'

(note $ and single quote: double quotes here do not work)
to get the line-feed into the shell variable.  You can also capture
the output of a program that emits the line-feed, but these are the direct
assignment methods.

For instance:

    $ LF=3D$'\012'
    $ echo "foo${LF}bar"
    foo
    bar
    $

Lacking such capabilities, it's easy enough to use the printf shell
command to produce special characters as output (which you can
then capture, but various shells may also have Special Rules about
such captured output, so the direct assignment method is better, in
my opinion).

Chris
