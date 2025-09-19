Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B17225D6
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314541; cv=none; b=qWzySJ1NBYjJi/IQxyTasJdFF0RHyrVKyWpeaBAFwHNUjlFO0c0AFJU7g/K3fCe2ziDWkU010an30FlMuShYKCEFcvjFdbIsNrjRb+HH28l9R1GS40Kad4z0BW4mWB8ZESDLE7N0aRV0oz7Ivo449x+d5UZoCp9dl5ZNwOeFld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314541; c=relaxed/simple;
	bh=pdYPF7DmUMYMlOjTICdGpHJEPSzteE0mQoM1fsVn4dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVUtXWhl4Moujp7ERIZ4R8z86rvy1qvWXt14clOd1zR5G30GmqECOahrNBaK+t+hiFgRZu/OWtmVTAvioy9urlf+Bdq0l4Ke6XkNQZSOV1vU7YnCyu9anD1XvgEvCd6K0WvoUMeHz1Mr5+Mu8/gm8RVpylTXuN+uOe21h28HzOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHzFGpj+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHzFGpj+"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5797561c8e0so2299759e87.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 13:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758314536; x=1758919336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdYPF7DmUMYMlOjTICdGpHJEPSzteE0mQoM1fsVn4dY=;
        b=dHzFGpj+uqdqEhsgwWf7u8vPhAToMWka9BCKV2l6X0lpDKOFwokupj4hUYc+lddgzL
         w72Zu9c8WqR4YB/m3WQhhcs8f2NH//84JzRAy9nRQu9KrXutxq1YT51D1v0f+6Zl+Dnt
         sO/kcuNYYk/HdCq/nVgmBPLzoLfIcwHagzfhMjXVlYT0ngGR0GWvRNtvSl7MA9ahJh/H
         gVZybp9UF94SFC9DvcXYssirSBAETtsIn6m+/sGKLFBGqwRkNJqXccd0wO8Pkc9kuhFQ
         GAjxBatppb5jehyMAFvPqdtJAUT1VL3LwOebURIUIsgL8qBrDKo991gmmk3Zo1YM1hqp
         rOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314536; x=1758919336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdYPF7DmUMYMlOjTICdGpHJEPSzteE0mQoM1fsVn4dY=;
        b=Q3YWfeVijCVDEY+OPV7fV1TLkjevmiuNJTHzKt3ybkjbN5yyAWggfSH4kuPSikDw2k
         YCuNVNuETDnF47AW4z5LPGjY5n+HHK+gNMcLa4GrlKWztBEwQ9yzH0Ay38kPUH2em/6d
         Ck8204EnzONE1pbj65vQudhUFE7LClXnWE3rKh6wIgZbQLFviPXMtW86Kl2r4UoqQvmU
         UxoUbflZr4ADnXK0LHsoT9fm6N4ukbsEcgsIXXl1X94WkECiP9u16UJX6+hR+ghj/lTo
         jqPw9wR13HO6urmMCElZUn9wSI1UnZTeQy0WVtuzv2rPvh1csxhhQpM0/hutISJGwdJ7
         u8eA==
X-Gm-Message-State: AOJu0YytfrN/odI4mKE4Hx/u6FiaCXErtaedm7cFas5RDqGDR4WcoImx
	G1fwaD0kb80lgcUaxdf00XCQHS4ww31yj0wFSGoEOjs3G1x9dgQL3VicHG8KCZTQzyXhQPbL0iP
	Y1cqijQLt63w7QLo1HEi5t9Y95YwkgbM2MMOG57w=
X-Gm-Gg: ASbGncs8kzODhVhQl/r6XvcPeYmMY7a713HCZ20Ocifo0fNcjOXWQUzsQ/7Q5VIgCHq
	X+nvlXOHNr5cqqDwe3BrjkxFX+GiT1UCt+l2yCFjyGMvfBIuzN9pfeZqUTaY+02Mib4h307ImQ+
	1uujk7/McLmHgbLYs8+CmeNbrkTHn2OxX+QQ1LaeWzRmPTd3I7UcgfyY01etrAFToAB+n47wr2k
	ZtPypWx
X-Google-Smtp-Source: AGHT+IG2MmJt1AAZ+NQ4qeGOm+ue8yKhseDZ6KiTyJsK9wqcqJsQ43cpSMPmOmLX6f4jlZRBCiXhxXw/fFSrLrzLFLc=
X-Received: by 2002:a2e:bea0:0:b0:337:f786:2f4a with SMTP id
 38308e7fff4ca-36417e0dd1cmr14648791fa.18.1758314536397; Fri, 19 Sep 2025
 13:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <17143ced6feea5927b66c0578f1c2fbb07378504.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <17143ced6feea5927b66c0578f1c2fbb07378504.1758071798.git.gitgitgadget@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 14:42:05 -0600
X-Gm-Features: AS18NWC76HnIiZmkJFJhG6MCfml7XslHKOZgS_mDNIzYdIZs30WY32diYjkxSvk
Message-ID: <CAH=ZcbBf65E6aNN-cCp_0Nupk9GD3apjKRWrfi_JfJcwWi_mCg@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] build: new crate, misc
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 7:17=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
To: Eric Sunshine

It looks like my gmail never received your email, so I'll respond to
my own patch.
> Please extend the commit message to at least give _some_ information
> about what the "misc" crate is all about since it is not at all
> apparent based upon the name.
>
> By the way, is "misc" really a good name? It sounds like it's going to
> be a dumping ground for anything which doesn't fit anywhere else.

I don't like the name misc either. What should we call the crate that
will be the new home for .c and .h files that live in the root of the
Git repository? varint is so tiny that creating a crate just for it
seems unjustified.

> Do I understand correctly from the comment that this crate has
> something to do with "xdiff", yet there doesn't actually seem to be
> anything here referencing "xdiff"? Am I missing something?

This crate has nothing to do with xdiff. I copy pasted the Cargo.toml
file from the xdiff crate and forgot to refactor the comment.
