Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0543AAD55
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728206367; cv=none; b=Fz8sWcYVnmfRpfJVL+2mZ8v5NJPSZ+ZlNewFxe0AC2rnXsv9gSrn4CYXaI8H1uPREVezzMKFzg9loIrJA6BCzyf1bb1Pa4yKqwUO6ZthDZboIZp1yrDZp4piOVp8U4gArY8d68qqqmKSxFwDirwClIZRGCm6WgoSjKa1a0IamBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728206367; c=relaxed/simple;
	bh=Q1PvAFlTxdRcdsoeyQWDNVdUVgQNtQOIliFFMozI3Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ocx80VL7ogTzinQUPZezWRdivDuZo0qVb3loWvHAC54MOdM8FC1ITPd9HguV25Y1DUIqu8l5z9zQh7Z9GykdkYXGPIo2h+NBuHgZEvJ9QevwF9MhRX0YGSbngqFTgrdUd4EpaB2AYtyauP1YUJhaxbWjIhIRRdw6GUtW3jC6Y9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cb316db199so5133436d6.2
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 02:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728206365; x=1728811165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HypYrYTnjrgbUByVUAtBhw3AQ1LBwElZYrUwdCkHH8A=;
        b=VD3pINyx2M9dCJ1oaim6iERBJ6qzJ9+yOjY2BzA3lX6QzrXH9O4aDDCyl85VEgWd02
         k8SMUmqeaeCGKCTHu963+0NUi8FqWB8KC4wpH01xUJ+wTvErE61Y/D2cDShndZXbIQ18
         KvPlzSV5xRrNFiu6yHGFGvsAbAvVU8uM6IBuWh3ORaZ1inEzReVoyju7D20GJKZkseli
         7UjlmNfrHIUFSlw0mebvS6OZiQ9zBiMQuqCMJlvO3gUrafto+/xENTQv4jbH66nwHslt
         +EOp7ZAYSQ89Cwi7TWQF9et/RjqhyI2K1GCWp3xV8JT+k+c6b6z2nLuUS1ZUTMJgvrTZ
         hYIA==
X-Gm-Message-State: AOJu0Yw3J3WETp2bwvJLmZ9ELxuqFb13hxFnzmrhZyoWaOxBwMuweOn6
	2ByKxI+xu/XPqIEBjKfDrIfWkjP/vUVGgfHIlfvDz25dCRpohuNVF57rMSp/5Uun1xLzHaahMHD
	aPOZQ0fEpTO2RZPG0nCZLYSeKkcvIFQ==
X-Google-Smtp-Source: AGHT+IGiRJsGwYucfH4Aus1N5q+DAWqosSSS5UY+XNMd2GEsXcd8CM58W8HX6FHRAMLZLQEwl8Z7OVT2DXlosm3VCxA=
X-Received: by 2002:a05:6214:486:b0:6cb:31b8:43d4 with SMTP id
 6a1803df08f44-6cb9a03ccffmr60304776d6.0.1728206364881; Sun, 06 Oct 2024
 02:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com> <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 05:19:13 -0400
Message-ID: <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 4:31=E2=80=AFAM Usman Akinyemi via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The exit code of the preceding command in a pipe is disregarded. So
> if that preceding command is a Git command that fails, the test would
> not fail. Instead, by saving the output of that Git command to a file,
> and removing the pipe, we make sure the test will fail if that Git
> command fails.
>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>     After submitting the first patch, I noticed that the output of wc -l =
was
>     failing due to trailing whitespace. I attempted to fix this by using =
tr
>     -d to remove the whitespace. However, instead of squashing the two
>     patches into one, I inadvertently created another commit.
>
>     Eric Sunshine sunshine@sunshineco.com provided valuable feedback duri=
ng
>     the review process. He explained the details of the patches to me and
>     pointed out that using tr -d was unnecessary to resolve the whitespac=
e
>     issue.

Thanks. This version of the patch looks fine.

I notice that there are still quite a few instances of `git` upstream
of a pipe remaining in t3404 even after this patch. But that's okay;
fixing all of them would have made the patch far longer and more
tiresome to review, so it is not a problem that you selectively
converted only `git show` and `git cat-file` cases. It probably would
have been helpful to reviewers if the patch's commit message mentioned
that it only converts some of the instances, but it's not worth
rerolling the patch just for that.

So, I think it makes sense to stop here and consider this microproject
successful (unless some other reviewer notices some problem or
requests some other change).
