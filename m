Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B441362
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264558; cv=none; b=L+r4REN/+aULsW2eW5NsnFtu1IVFPuArTFYcUf9YtzhKhoUcBGopB6nLo8kvp6SEZyrk42fRXZztdYIWV9Y/SCiGEig0oDbt2872ikfPtf824KyixTQKf+DJq4dEUJRUBHYKKA8L/9H0jgfdIGlAYtUZlDNxb3x57Hshp6y3ZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264558; c=relaxed/simple;
	bh=jVTP9tSnAaW0h20lJbaBkxc92k3q5afZEkfrL8J3n4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9cANOnIDfoVjIyqFbfoVqpfFPN0+/zhf6PtmT70+6ZViKN88hEHLMfMQrRp6gCJPSK418WW9BnIDm6VzxCzZAavjr1UC1MkvaClP85HQTaiZ4N3mQLyK0dLD8czToszfk8+nXR5i3Ahw4FaFC8MGVWwYOPPr11U/6V5sULDUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfnlfBAy; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfnlfBAy"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-84198253281so213705839f.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 14:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733264555; x=1733869355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujo3AKv4v6FWquf57BC5YT646JRWYdDvfwFXeAUGjAo=;
        b=NfnlfBAyFFlyIXuzQ+SN9yqArQ814S+rPaNwuymw3FqdQcQJN7zRbCQ0tgxyYgscqB
         wUNyUKw0fW4cq1lcpCZVqrxhRL85alaGJI5mGYpEvZNRflXdZrbVj1DIXVCvNliIR0t/
         wysWLFN+PwC7NWKh4QLwUB1NzaTW/FXAFPJL7ecgX8/NL4rePLrK0pIIKKxs8l53p3ny
         B1xMuU81dn3NY2H9wX869O/WZyZVmgcsJ3iECMsLMs2lZSf8j7y/TI70vxHlEAQ0D+Vf
         4nQE8o9xmhwU160NDV/xgju2yOkOncB0X04fawEWIicDEnmblY/o8SGihQjQI6hN9K7s
         4pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733264555; x=1733869355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujo3AKv4v6FWquf57BC5YT646JRWYdDvfwFXeAUGjAo=;
        b=cOU+ZBr6GD1zZdjpfQAyQTDZxgWzbuGEsYTMnPYOw/To8JLENe/OYsi0hvR5pmVAkg
         X1QbVCWl6pJX07V3Y+CxcUObA79Mxy4MOH8E4yTjVNnTZk0sGlK/9bjm/s+L4TnOs/yK
         Tz2mxODJvO+UwZbno2Nklz+RU58zhAEYCJlHxGQ3ALlz01Qtv1gzphemPAxxvyPymAfY
         Vctqmd3166JSz2DHC3S4cRA/BBNAyT/inojDp69pNfiA/xDMaawZseBfjCjMyDt5uHFz
         HSxTHxH6ptGqy+h0724pXfNx/QkPmjNAAMDTuDXmGXqLVVUBJV/Rd01gke5y1Cs4eTHU
         Gt3g==
X-Gm-Message-State: AOJu0YxZ8z54Cu2Tbw5GqZvbsw7e1xCLzdfNuh9qc3+Xq6OKvjHKsEAN
	ozPiE1Z97jheqQ/n0fUgMGp//vfLe1GhFMD5SEXuJQdqaBW0YKPHhxTISkyXZgifNjcikjzcffo
	iVwJ1hdni+w2FoOlNsEOxi0EgFUo=
X-Gm-Gg: ASbGncv0WZMavAg3CVshBxKCuI+f8eosFMd2nv1EzXxB4/2rDieP+o1QMStwgo6gd3V
	Ptx3Qgktt+qORMCFrZ3UmqANLsVFgbLvMAb4d9Syn943nhg==
X-Google-Smtp-Source: AGHT+IH4EfCcOMFalArZ+u5Fm2ODmIEb0IcfEo61SNs93iUADiVAWgC2Upljx3FE0daI509f10CGkX5Yd8tHSXEXPSA=
X-Received: by 2002:a05:6602:27c5:b0:83a:a746:68a6 with SMTP id
 ca18e2360f4ac-8445b5519cbmr639685039f.5.1733264555698; Tue, 03 Dec 2024
 14:22:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1838.git.git.1733257083739.gitgitgadget@gmail.com>
In-Reply-To: <pull.1838.git.git.1733257083739.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 3 Dec 2024 14:22:24 -0800
Message-ID: <CABPp-BEiYvz-0MDS92iSb1Bj_UyBBUjy6D5SDsbPcoPnjzjucg@mail.gmail.com>
Subject: Re: [PATCH] doc: mention rev-list --ancestry-path restrictions
To: Kai Koponen via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Kai Koponen <kaikoponen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 12:18=E2=80=AFPM Kai Koponen via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kai Koponen <kaikoponen@google.com>
>
> The rev-list documention doesn't mention that the given
> commit must be in the specified commit range, leading
> to unexpected results.
>
> Signed-off-by: Kai Koponen <kaikoponen@google.com>
> ---
>     doc: mention rev-list --ancestry-path restrictions
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-183=
8%2Fgkaikoponen%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1838/g=
kaikoponen/master-v1
> Pull-Request: https://github.com/git/git/pull/1838
>
>  Documentation/rev-list-options.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-=
options.txt
> index 00ccf687441..459e5a02f52 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -412,7 +412,8 @@ Default mode::
>
>  --ancestry-path[=3D<commit>]::
>         When given a range of commits to display (e.g. 'commit1..commit2'
> -       or 'commit2 {caret}commit1'), only display commits in that range
> +       or 'commit2 {caret}commit1'), and a commit <commit> in that range=
,
> +       only display commits in that range
>         that are ancestors of <commit>, descendants of <commit>, or
>         <commit> itself.  If no commit is specified, use 'commit1' (the
>         excluded part of the range) as <commit>.  Can be passed multiple
>
> base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
> --
> gitgitgadget

Might be worth linking to the thread where this was discussed (in
single-commit gitgitgadget PRs, that'd be done in the PR description),
over here: https://lore.kernel.org/git/CADYQcGpXm=3DRTEYyxqdSowQ4Vg9jmXuCzO=
Opd-TgDX8U814BReg@mail.gmail.com/

Anyway, patch looks good to me.
