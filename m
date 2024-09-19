Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE4111AA
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726759051; cv=none; b=VKShCCCRHeuCpC6k5qsIIFgI/hGt1xz7UyrDIeuOkNxt8E0SeyGL/3b8dNYLZt940IABmuLlDkpvfhddTXhQ/ZAJ/y/GWnni/kaui9eB3Vedgcga07uqxwIj4CRtKSLRzFS6ZTfRQdZYXa3lMStOr6I13c3wo2N9SqVbU/pvlak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726759051; c=relaxed/simple;
	bh=5b4uZAR2URmJ1wjH6pfi9GjYE7vdH7Thka8qQ5tmhyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyaF8qpmsBE0RMM99lkZw/TazzJkVt9rP1bXDGD0t44qdjE4Z8Fj/tXR+CRnPCidv88uEy9jNcboOD+briKxCOQTvGeVlFjJNPJ3XCBPjVgAeATts8RM74wN+jeYLAvPj3rJqJ/2wZMAAX5a1hRxzCgIbRzp5A3GjGccJdBhkE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=precisioninno.com; spf=pass smtp.mailfrom=precisioninno.com; dkim=pass (2048-bit key) header.d=precisioninno.com header.i=@precisioninno.com header.b=F9J3aCgy; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=precisioninno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=precisioninno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=precisioninno.com header.i=@precisioninno.com header.b="F9J3aCgy"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-27c90f1e968so604954fac.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=precisioninno.com; s=google; t=1726759048; x=1727363848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBhRMX1GMz7s/xXrhYUXMb3UhAVHzFs7mxLXrFd1k7o=;
        b=F9J3aCgyIRBljZGhV4hcwg7F0hhgB3u/hZggNqS7uE9f0U5Mtp8WHxGn/Q0esyZA+A
         LWN1Qcd+vdxwckxFZz6MDzcw5/bsQ1ABhbspDssFnUE9OS8sOmYrtWmKmJAtSYYrKNJl
         mq3DsdZ2WeGjO55biKWvVuE9fcBXJJ9oWfTC5bogm1sJtOdBmEWQRdf2sCS3LRfE933K
         lB7YiSU9byhBbnau5D0SUUk4zhltKonQR+ezoKbH6l41vdGzg+dJejm2Qt8sOcGpG9Kc
         IXAD/ANtPwDKuyLwnw1OlYwyKt6NuGHQF+qUQhVFphdAZD4XUigKKSsHk4bTR9NaGTGQ
         JC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726759048; x=1727363848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBhRMX1GMz7s/xXrhYUXMb3UhAVHzFs7mxLXrFd1k7o=;
        b=lLyKWQ2CO2m8gMNwAVLXKAXNKVrgcdlJGHjt1b9YkrhsdNeWpk2JRFNFuo7ZvZjg1E
         MS215f9HmLfM5lLrzuGuwTqKqAkoSpAGAsVUwSfJz8DJJwjVaxwZhMZ9y2lvZ4prf9Y+
         9hkDLatrNn7MZocysw6vcqSakVCPR4FNFc4o34A6wptkN0Gtv4IdsRMS/bXfGQeR7GXM
         aOY5MjMAOYQp7/zRCe2fs0v0ctUM2AXnUrz9ey/1IarY+yosK8T+Q0o6ovTNVjQuotc1
         hO/cM8QYI2Mz0KHHbfapT4kNGlAFK8mCTtF1oO2Qx6nHM1Ti/+EJTrcPTJXxqQqK+7c9
         MYNg==
X-Gm-Message-State: AOJu0Yx9u+cQbV86LtHVKZ8G4XfQXRyp1POMn9tZKZfuRx2YvLn8z6ZJ
	qJzagSy/G4bQTa7iABcUuAbnE6Z3Ykt0oyazBOEI+CYV0BKSu+V6G4dd3mlrEjtRHtuZePznGdy
	WJLDI+ggkeKFeo3nTAnxqOUroQv9cu0BO5S+bzA==
X-Google-Smtp-Source: AGHT+IHNQU+XIvUoU1744dnmSfLCUF/B+DV7qI8+9KOJy1BfXeTHQcbBawuN+Ff9r6sBA8EkICSMDeBfKgRMAj7iR7A=
X-Received: by 2002:a05:6870:612b:b0:278:5a4:10cc with SMTP id
 586e51a60fabf-27c3f253a60mr19960060fac.3.1726759048288; Thu, 19 Sep 2024
 08:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKDm0rNaHbzoiPg=DeuCoxzooNAsxw2BJfc0wg7fC_-=o9uJ7w@mail.gmail.com>
 <7b4ce2fc-3763-4881-8459-e0c1f2cbc69d@gmail.com> <CAKDm0rMsXUpFSWRWkW0J0FUpEbot6wQqdzYTT5CLZ=3TGbV-OA@mail.gmail.com>
 <467f6fb4-5f83-416b-bc09-572a82f210ea@gmail.com>
In-Reply-To: <467f6fb4-5f83-416b-bc09-572a82f210ea@gmail.com>
From: Matt Liberty <mliberty@precisioninno.com>
Date: Thu, 19 Sep 2024 08:17:17 -0700
Message-ID: <CAKDm0rO6H4RTa5EXMrNvSy2swVegHveasY1koZXF5V7HvZzK0Q@mail.gmail.com>
Subject: Re: fatal from submodule status --recursive when used with grep -q
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes and also to have a 0 exit code.  No error occurred from my perspective.

Matt


On Thu, Sep 19, 2024 at 7:22=E2=80=AFAM <phillip.wood123@gmail.com> wrote:
>
> On 18/09/2024 15:28, Matt Liberty wrote:
> > I'm not trying to capture the exit status of git but of grep.  Compare
> > it to "yes|grep -q y" which doesn't generate any error even though yes
> > generates endless output.
>
> Sorry, I'd misunderstood your original message. So the problem is that
> you want "git submodule status" to be quiet (i.e. not print an error
> message) when it dies of SIGPIPE?
>
> Best Wishes
>
> Phillip
>
> > Matt
> >
> > On Wed, Sep 18, 2024 at 3:05=E2=80=AFAM Phillip Wood <phillip.wood123@g=
mail.com
> > <mailto:phillip.wood123@gmail.com>> wrote:
> >
> >     Hi Matt
> >
> >     On 16/09/2024 16:08, Matt Liberty wrote:
> >      >
> >      > If I try to grep the output I get a fatal error:
> >      >
> >      > % git submodule status --recursive | grep -q "^+"
> >      > fatal: failed to recurse into submodule 'tools/OpenROAD'
> >      >
> >      > I didn't expect any output but did want the return status (0).  =
I'm
> >      > guessing git is unhappy that grep -q exits on the first occurren=
ce of
> >      > the pattern.  I don't feel fatal is appropriate here.
> >
> >     I assume git is dying with SIGPIPE. As the only purpose of "git
> >     submodule status" is to write the status information to stdout that
> >     sounds reasonable. If you want to collect the exit status you need =
to
> >     consume the whole output so that the command runs to completion.
> >
> >     Best Wishes
> >
> >     PhillipSo
> >
> >      > I can work around this by writing to a tmpfile but would like to=
 see
> >      > this addressed.
> >      >
> >      > Thanks!
> >      > Matt
> >      >
> >
