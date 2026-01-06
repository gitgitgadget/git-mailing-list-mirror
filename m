Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E010322B72
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686892; cv=none; b=UZvT5ifIg8ryZyRI14DAIN5p5EpYyLfNurS9PEEbSkcliNx/VAIBQwfiVB9x0gSx+SDuI985mGA+qgiUx2Fs/8yY8JCHUCAij6U2EAmdpDwXXfvgPBkAJLs8weGmtGotk3LiFD4pt9C0xUcqIpS/WSvk3dwNv2+IGXkdLzxMyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686892; c=relaxed/simple;
	bh=EaDnU/wPputMDeBP8tW8gkOQxH8nITiKgoPq6QR+qXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AE0/nk8pYlbn4Kq8KohZBbIUxImzCyDl71PxbuYjHFmqXnav4Fvs4lvY7yw2n3pjPSGZUeDiwaxdu8475/cq5gdVJseHyAR5RLMsvc9z1osYZPnkrBzkbsfk9boq80XtZTRpzrjUfnmTMKx9qO2YWiYMnjB7/kqpP1J5z5DaxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/BVYdvn; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/BVYdvn"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-11beb0a7bd6so3675016c88.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 00:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767686889; x=1768291689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EaDnU/wPputMDeBP8tW8gkOQxH8nITiKgoPq6QR+qXM=;
        b=B/BVYdvnDfPr6GaOiu2DSXDvBq+2Lnwo5pRwEtixq6/fEowKLsU8lkns4FrZmGcJtl
         vsXm1HvUPYNpjmweK6oyWUNB+g+P3ZpS3RzudPczyqIW00H1a4ZRRSFoPZwe2P9UKS2G
         gs6adqPK1Q3Autzkp6Yyqi0eKqMlMBV6WvSYn7klOv3aUdysIENcdxcdrLgPJ+wZ7swN
         FPmrXthFkxfhzXDowu0av19YnR7SovAiDQXpppgacDfURyOdI4fGMr0+xkTjfelN3mjy
         imI81UXePNdYtGkUhmYVRdaiL374xTwZ/7AxXgESE7NipBl8ikoaY4C1EB3U1MwVNwbF
         6U5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767686889; x=1768291689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaDnU/wPputMDeBP8tW8gkOQxH8nITiKgoPq6QR+qXM=;
        b=u8SVFLwlTMc+2AykreGgFrMguUmA05I3Wglpo5PnxLQVZzqJNhFUc5q0f9nlVQ44FG
         wrZuq+vAFmOJAVXfx8HdiSJLfW+xvShjQyunKKynD0KSZQ0SuRZsdhN0qj+emXLq3BpB
         fa90xFWrYdOhJj8qAPCiShWqIZKrg8ZNUDZpUHTB9pbKV9PUJb+qfqq/EBQ8gceTmCid
         rhJtES8KWP6U31NDpxYkLIbB6/Fai4ZKBr/8TwVTXVQkS9kXw1sd8QHgWlw/B6zrLF5/
         sEHxQXXaEPggnnK6SfR2lSHokH3sfLwZFx7mVZ9k7p++HyNfIYl5Dsuq91eWOTRGba0G
         7BnA==
X-Gm-Message-State: AOJu0YyqY0UD7+d5I2cKU5F+NbmagA1ZeByIAzE+fnvWmXkx24NOChIb
	URJ905fREVvfUF2ncKvguJjIUPYYESHxT1GmEkk3GjqlhwZa8uTI4bee/oR9aBRaDZbjxRRFrcn
	o7yM0ojrHRTp/yuRz66IdgFO1ChKdXXs=
X-Gm-Gg: AY/fxX6lZaA7tv8vNWcjPdk4TE3M7fNZyrPVJv+/SCdsx/JbozXJiC2zz6TkRGxjL/1
	LY689HXVyRA/l7j3T3OTyEc2eQpOoyst6sLHZUwUycVVrdNb0qGcWnuOI9p2qVVAfRMGyt/wjXA
	8XHG9T5AnmTeRXadpUFH0+sU8NKJ4Qk7wNtOe++4y1Y5TLdYqd3dEMtJ08cb3hlcsjK7EGjoBlX
	1XU2CYVu2LCxS9a/VFbOzCy+jTJGLPqoEfljfp/+po6QHmG8QAnQXnXd2guQgxA16G1OGvLBVE=
X-Google-Smtp-Source: AGHT+IGxLkFqA6orseSCaaMPDJ1GwmO+OsFCE936MT6aaImpZqcO56oXqRcAq6xylLBWhIZdJYJP6dIKZkcWunBzijs=
X-Received: by 2002:a05:7022:d99:b0:119:e569:f86a with SMTP id
 a92af1059eb24-121f1ae250bmr1161252c88.7.1767686888959; Tue, 06 Jan 2026
 00:08:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVfzMsN2ouY3UBFG@ubuntu> <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
In-Reply-To: <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 6 Jan 2026 09:08:10 +0100
X-Gm-Features: AQt7F2rPJUvJh8pOO7hHwxfwRkkaHiIMFUVslWmltxg3KvJEUcqXxuQo4Q5pY1Q
Message-ID: <CAD=f0L-hv1ZYGDyHRCYu3BqgrbvutS+JVn0D3kBq-wq--qgY7A@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile" into repo-setting
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, 
	Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Jan 2026 at 15:23, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Olamide
>
> On 02/01/2026 16:32, Olamide Caleb Bello wrote:
> > When handling multiple repositories within the same process, relying on
> > global state for accessing the "core.attributesFile" configuration can
> > lead to incorrect values being used. It also makes it harder to isolate
> > repositories and hinders the libification of git.
> > The functions `bootstrap_attr_stack()` and `git_attr_val_system()`
> > retrieve "core.attributesFile" via `git_attr_global_file()`
> > which reads from global state `git_attributes_file`.
> >
> > Move the "core.attributesFile" configuration into the
> > `struct repo_settings` instead of relying on the global state.
>
> This changes when the config setting gets parsed which unfortunately
> regresses the user experience when the setting is invalid.
>
> If I run 'git -c core.attributesFile=~does-not-exist rebase -i' with git
> built from master it fails immediately with "fatal: failed to expand
> user dir in: '~does-not-exist'". With this patch applied it prompts me
> to edit the todo list and then fails when it tries to checkout the
> commit we're rebasing onto. Because "git rebase" expects reset_head() to
> return an error rather die if the checkout fails it is left in a strange
> state where only practical course of action for the user is to run "git
> rebase --abort".

Yes I tried this and I experienced the same behaviour.

>
> It is quite common that moving from parsing config settings eagerly by
> calling repo_config() at startup to parsing them lazily via 'stuct
> repo_settings' causes regressions like this. We really should find a way
> to address that before moving more settings into 'struct repo_settings'
>

Yes, I came across an initial discussion about `prepare_repo_settings()`
and the issues about the appropriate place to call it but it seemed there was
no resolution then.
