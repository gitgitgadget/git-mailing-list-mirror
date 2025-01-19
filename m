Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC4D1779B8
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737328106; cv=none; b=pR/db3NqjzR8pSR+61UKE/aouNt0L/UB1M6lRfc8p87lJYB4Bl51bp7/FH4xEd95WdR0OoakUbaoUtkXM92/XimTXmhQ1yAptvKsPfBG0KGdNWCnlEAV8BkfcGcZY3pwSv5iLNr5mRE01NJEvpkXYKhCUyAImAkPQJM73Fa2WIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737328106; c=relaxed/simple;
	bh=Ua2Gvd+eWfxI16xLYBwGXeK47JJjL8nPlD4ZSsTV57o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBmolkP2dgNqn5wuMY7/Q+70WCW16PlawCa8KUNNV4tp6PPgrFucrq8eU+yEBohTgAOIMGSIRji+GFAJcXJF+8AmGJQxwW1t3t29yD+wQAlQH86GsHqyKenFjcjdXwrkJRA1fR4E+CRxnPt+ZTSTDhA+tqTUtUofUY3Vkh6IS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfVos3Tw; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfVos3Tw"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so791542966b.0
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 15:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737328103; x=1737932903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ua2Gvd+eWfxI16xLYBwGXeK47JJjL8nPlD4ZSsTV57o=;
        b=gfVos3Twb72tuzGMhR9BJqKqPAtb+5CYydboNyQHBjGr1dnq2MHyqwX/wDdJkEYtTo
         tBKbK/bNw83xkg+bjGvLE9+Uk/4gmZOToGio6UHQ7WlsYLP3/89ogtF4FTeHq8Z0GsqP
         MsDO5R3c34u/hljURAtA0uHfbLBjE//V20Yy2VNRhELrTyLya/qK3Mb9c7pdPo1tGkrZ
         CfYSJZ9mZgrz6cqdDHwHZC3NvPNXcB6iB1kx3MvQp99N44zqYfpoxKqrsqc457TaIhMh
         h3cCXnVYmMQp9vg0kBnBTwek0iuF85mIyNC9kWZf4XfbnQjVeFjaEdOsdo4vqbLNWKig
         /wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737328103; x=1737932903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ua2Gvd+eWfxI16xLYBwGXeK47JJjL8nPlD4ZSsTV57o=;
        b=eEFG9sQgUKr7ECBr51svorskVmDLzVd8KhWK/ixRARJuIGJhAwi6uahoz3xxxInGJi
         CNJvH0BODax4TALvD1cghBYCpU0nWmeOanf1F0XqYSZ/5mHwze6NGSVBGDYucIuG5A2y
         JN8xhEvUsJaWZrZ1SwKY4xWTgWtWD0fggBRTW2jaFNij48JtX219voGsuKnOvfvTmria
         +cogoB/mvUfdUR5nh7IAg8Kyhwb9XfnGcR08sGkftax12ih4enf51ltcwNfDcDvhlpyF
         iVT5hpKJv7CUfP351v+QbaICdkdLik3yJhIliZLYYvKUQ3bwnwIw+kRtcagXb3t5C++S
         fWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxZKBYEyTivj/gP7BcF3h9A2rn+MZyxnGOk4bpGQdj7/3ADargFub2u1RNyvq9MjRGSPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2D7Q9TqXlofw/mU8cegIQ6QdCWwMW1BnI4erjJHuMMp+bNiGQ
	jmFCqcqaNcRlYCdtRV3vA4mFiBmnou/vIkfSEyNmICM9Ki8oAPM/vF6qWgAlmTe3FGHsQFuudpq
	YfBQ9/lpkHxKVxVSnxBRUoZ0BMu8tKNa0
X-Gm-Gg: ASbGnct/3S08/SQ0hGA5P8Bo/K3jGKSoJSmYm6+ySP975ePjl1AcOSXfOuYmekWL5p7
	pwiv77cfb/+ERB3DsByULBPo47Du5zMhesMYTHIdgoykdQAiJAb2UhOoDTSiFf+BFcTz9xhk26G
	zeul80i7E=
X-Google-Smtp-Source: AGHT+IFeUS3qSzN9ddqZtFqRCe2ZsGf7v+6+6XaRapn+hDJzoyo9bIsyNNP3ZwOF5XBOTOycfaG2mxFre3lxpS6ROtg=
X-Received: by 2002:a17:907:969f:b0:aab:eefd:bfd8 with SMTP id
 a640c23a62f3a-ab38b4c047amr1229281466b.49.1737328102375; Sun, 19 Jan 2025
 15:08:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAODtcdcTjquNUBaTWKzyy54J5NoH7WO+9uMzJ+wWRDf0Na3OPA@mail.gmail.com>
 <Z40mlmfnUOXI2ghd@tapette.crustytoothpaste.net> <CAODtcdf-+QpPpB5R-hLkKWKacwM=N3=XRDs-tK60W9WzUJu7xw@mail.gmail.com>
 <CAODtcdfS+TVmrwohtHFUXRZRwC1WmF5ENpZLVoZTyJgA--SC-Q@mail.gmail.com>
In-Reply-To: <CAODtcdfS+TVmrwohtHFUXRZRwC1WmF5ENpZLVoZTyJgA--SC-Q@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 19 Jan 2025 18:08:11 -0500
X-Gm-Features: AbW1kva96nLJR4iI_jOfZ7__-AxKUUTdwg3MStx7piw9-5gTh57sCVdFIkZScYE
Message-ID: <CALnO6CDwL3XHwMhHbX+7C87-pX+RBRDt3djKfr3LpqTFKpPV1A@mail.gmail.com>
Subject: Re: Rebase
To: Al Grant <bigal.nz@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 3:39=E2=80=AFPM Al Grant <bigal.nz@gmail.com> wrote=
:
>
> Yes. But I'm keen to understand how to deal with a merge conflict.

[and also]

> Which I have now aborted. I dont understand why I even have to deal
with merge conflicts when I want to keep the code in feature and make
it main.

I recommend reading the book, esp.
https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging#_b=
asic_merge_conflicts.
There is also an advanced section
https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging.

As for why you get a merge conflict when rebasing, see for example the
StackOverflow about rebase using a 3-way merge
(https://stackoverflow.com/q/36993683/4400820) or part of the
remembering-renames documentation
(https://git-scm.com/docs/remembering-renames, but it renders poorly,
so also try `open $(git
--html-path)/technical/remembering-renames.txt`, substituting `open`
for your platform equivalent).


--=20
D. Ben Knoble
