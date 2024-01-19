Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6F1367
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 02:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705633091; cv=none; b=PLwUpsPksb5AsY1hrTbw5++VQy1FViGlrD/Muh0Fj12A6e9+8n8I8U9ixZN29iy+Pts2N1dVroWsqhIepfarOUqeO7ic596Nkp6dVwbOqeQ2zW1UA/nhoQ3K7fH5gQUrA8MWJo/QC6tDxR+VpMCFBe0lBFurTwWUlxmlQRF5eNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705633091; c=relaxed/simple;
	bh=v1+xYFiAxe0rNgKuNr1l+qzQPTxA1RbX57NRe4w/MKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jW7qWfC5+8KIhJtY6Wc3hXbbE0hypOUrf2c851UpbT++wcitTmIdzd67LPApcjuiPrt7dz9cItz+oTdYfB+goyz5sgZuChnF5usxigytap9nAfy5m70H8tagJop9j9qTSEfAbnrkhvaBydRE48/Dwpz7IlRa3FlJmpB81rwrouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb0M5Pg3; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb0M5Pg3"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50ea98440a7so286564e87.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 18:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705633088; x=1706237888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbEmbMrBBPq97xtuV492bz34SSJHCVymJhV6VSj3Cic=;
        b=bb0M5Pg3jE21osYuhvDux4Is3l60VxbWvjBep1DpAmwhcM0flQGVEuUoDPBiDpeZ2M
         hDKNh1zwZchintjVgAefon8Vdx9VsvI6B3t2gW8ByXNJmmVcMCa3sxIumt+GhkatUe3a
         ti24OuoFvuP0QjlfWt3Y2NjgBLHEXsRXBY7yaCDy5Sby3KiESIkwGI4RHSRyGzbhynqI
         SUz1JS6JC0qU7cMTktFmQBY5iSB0UsBBPb0B8jY7XrVWqPwI8fUM179Ee/IAfLia+sgU
         OD6mZP79aPm7bC6WmvRtzl/gS49XkTLjYFExM6/4aUb5ujfmf9vsYSyoqEJhMIJoGJKu
         RPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705633088; x=1706237888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbEmbMrBBPq97xtuV492bz34SSJHCVymJhV6VSj3Cic=;
        b=Lnq/RRpkDwxZqhVSq0eeF/fCME6YgT9Dlpqw+PeEpFWTIqhr1vWebzvaA7lQpxNEZS
         Dw+MKwWMsHCyNUSSWjOcVb7bnfKJgLqm+jv5h+NIvKHnkPebEPQS4Hv27OBmLYYHZxyR
         7FSR7NzKLPIMzPdx/MHGb5NhevzSJUmeU9xwcqTIhnhfJwLUdGY5kqCHVxOmUnDFI9a/
         4TGazLGi3p9P1K/PJX8QtpNPz8LDiP8foOz3CoCfNJsYhynY3UY3eNNYkevWJbQ/dwI0
         WpftwTHWkFgxK+x9smMwVUqnDcPYnBTeErRUiJBKKI17xizDSZguStXGi3deL++/6sZV
         ouPA==
X-Gm-Message-State: AOJu0YwKJq34pZHM5Govpbgvc88yYaMa+KjopxdTspsJtjAFz7ze4T5j
	UvYYYpQ+yBDElQUU3hBfSd+o7ej0LTBY0Z+/obkk2boL/7s2/7PK43ZZttTkzpxnlisC1YuYONF
	dqltZvTXGJ7asakcaB6B9AhQHOqE=
X-Google-Smtp-Source: AGHT+IELxlRK+ZGZoahWq3XQUPcXLdQUSqXQT/eLNUmoDKN9L5W5jFCDYR4sT5mflP3MbEfZgMWCkQ26bfRD155bwj8=
X-Received: by 2002:a05:6512:3da7:b0:50e:7d4f:a31a with SMTP id
 k39-20020a0565123da700b0050e7d4fa31amr213733lfv.53.1705633088036; Thu, 18 Jan
 2024 18:58:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
 <xmqq8r5gfc3j.fsf@gitster.g> <CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
 <xmqqsf3nl2b3.fsf@gitster.g> <298F7067-D572-433F-A7DD-5256B43B97D7@icloud.com>
 <xmqqwms6qwr3.fsf@gitster.g>
In-Reply-To: <xmqqwms6qwr3.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 18 Jan 2024 18:58:00 -0800
Message-ID: <CABPp-BHaUDdtH6igDmOx_wv8xYh-uA=4L9zDDycrZLaa9c9KLQ@mail.gmail.com>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
To: Junio C Hamano <gitster@pobox.com>
Cc: Sebastian Thiel <sebastian.thiel@icloud.com>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Josh Triplett <josh@joshtriplett.org>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 18, 2024 at 11:14=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
[...]
> So, all it boils down to is these two questions.

Thanks for summarizing this.

>  * Which one between "'git add .' adds '.config' that users did not
>    want to add" and "'git clean -f' removes '.config' together with
>    other files" a larger problem to the users, who participate in a
>    project that already decided to use the new .gitignore feature to
>    mark ".config" as "precious", of older versions of Git that
>    predate "precious"?

Accidental "git add ." comes with 3 opportunities to correct the
problem before it becomes permanent: before commiting, after
committing but before pushing, and after publishing for patch review
(where it can even be caught by third parties) but before the
patch/PR/MR is accepted and included.  At each stage there's a chance
to go back and correct the problem.

Accidental nuking of a file (via either git clean or git checkout or
git merge or whatever), cannot be reviewed or corrected; it's
immediately too late.  And given that we're calling this feature
"precious", that seems a little extra unfortunate.

>  * What are projects doing to paths that they want to make
>    "precious" with the current system?  Do they leave them out of
>    ".gitignore" and have them subject to accidental "git add ." to
>    protect them from "git clean -f"?  Or do they list them in
>    ".gitignore" to prevent "git add ." from touching, but leave them
>    susceptible to accidental removal by "git clean -f"?

Good questions; I have no answers to these.

However, on a closely related note, in my response to Sebastian I
point out that the '$' syntax permits individual teams to prioritize
avoiding either accidental deletions or accidental adds on a filename
or glob granularity, so if folks are concerned with handling by older
Git versions or are just extra concerned with certain files, they can
optimize accordingly.  Sadly, the '#(keep)' syntax does not permit
such prioritization and always treats avoiding accidental adds as the
priority (which, in my opinion, is the less important one to generally
prioritze).
