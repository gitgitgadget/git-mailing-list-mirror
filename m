Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E54A35
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059505; cv=none; b=BKOoeny7vCnYA1EfyuLnb/Ly5p+LFCLbxYjvg6CyaUpVy3KcFQO5sSruG5Qs2lOD4XbfEuwdQyJD7FqrYYMUqT4qGFxHPfDa9L6teWX9zEour8T1Zaf9oybUPvjRXqUinVECen4VKIffCLn/mvEahaoCSR4zoyDXwLgqu/09yhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059505; c=relaxed/simple;
	bh=RWmnXCkvJ5mBwY/cdZeBkBVziEakxEsZqbUqUtZPjvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hwe2rO3BnnW/zvbmtkfkZTm77jtxgJfi8ZPUvSJLEeRVqS07lyHQ7ZY+UFmaOuvfkQS3SFkPR/uinNSF7o3/F55HA9fS1oXF3i8LhzRQQ30AiOTVyniJ1LUSQwvBsUDBC8H7MxywLOL7USC/7FaO9n17DctY/01qcIB3HnC4G6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnQsiaHJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnQsiaHJ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b739b3fc2a0so100353066b.3
        for <git@vger.kernel.org>; Tue, 25 Nov 2025 00:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764059502; x=1764664302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PiyvsTSaYJfZoowXr+/qhyZYnQsXSJEH7/AWQ+7m1tM=;
        b=bnQsiaHJu+46TtZxrytRervsjSEMgNlj6kU1ph0j9uxVVoxoDpp3X50M7o5+H/L1AQ
         sr7r0P4dA8rYYw6UDJCtBzU9GqS7SnZT2IoHla4/tz/eX6JorYUzS74rQNinG08k0BkG
         eaOUG/wO/JddXkgrh8JQL6C5Fvp3XrFtfL41GGEXKnQ1pI6/ePLk1Ehc4QBjNVzjYY4p
         z+bRNcAh1ND+CJAZ9gqWN/QCBqe0UAq2Vn3RRyryocR0nBz//q42SbMO5aYEdjRQ4Smw
         EHFkq8NoFHW0ie8CsHwfCbVV9nYIDxP1O65CZ9otg+XzMRjvK8ZB1BrpJENvm6xvVbrf
         fyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764059502; x=1764664302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiyvsTSaYJfZoowXr+/qhyZYnQsXSJEH7/AWQ+7m1tM=;
        b=rbxAbBozYF/EfVxPKjLX6g+fRFX6QHko28vZYCKB2mkx++HvH1cf7hsoS/viuwCNGI
         b/s64sB3YM3/aQWl6/HdfVq2mvKRac8txsY2RMq420UArpQLtCQMwd3a854Y5RGnoIdM
         dXwboZHx7jOG+9369IQCEpbt4RR8opRR6kZjdcfEIrrNijRaA0SMMRurgnU4w+LYGZr+
         bz+2NgyCNArKYWMsVibXgmPbVk8axwHcTeP3heq4cvcTISlOSL2f+9htwaMWyPgbWgAs
         NzSoqmRKMXRfstd/vjJR//lLXAl0K7nsbfh+Il/e8UIrK1/9h0+uIeNiZazj/ix0LSmQ
         pTpg==
X-Gm-Message-State: AOJu0YxU+KkiTF2KS41JSsml/QHkeDU+ot3PwPvdedf0VdwLi9wQ6E1r
	KengEfAb7Zj4YSN8kVE2BCBnDQsSpXqeXgEyUnLD6qcCga80sJL8GtCx
X-Gm-Gg: ASbGncvw23ksdOFv0mS1MhDUxxacN1fIqxD09k4keWLWfv+lcJjKmZwRj7Vligovfdk
	zDpqXqwVbcInLtWudyIwHic9wjfy+V7gsl4DwtCBUTDnR8JXBYNy6iZS6QV/W0T+iEkIbtuEElC
	bTWVZVaXDN0CdoDFDkpqNIDZBKXYHglqXpn4SZZFallEDYJPWPm6AxwlhcXq8Ba/lJrWdtJ+C89
	igDnHbZkVsIFfd91rX1edPNFEOymtHmeE3udfq+fSwyjT/RhXDg89y7M/uHrJlsoG2Cwgo90j47
	RhZAAA3WT1+Lwm45cpZXuVl4FnCzCIGv4IpCpo2qZKu404E/iwMZbWds0LldWOz5B20movJwspZ
	yiSnGFwNHk9ILHgntSCscK26m6s+bJeWiEyiHOaE2TgHN1sP7ap0rdB7EJxe6r25ZD3baOTni/D
	dzk2qgjnOHZriIS8g6assAimaSjGqQ9YGX
X-Google-Smtp-Source: AGHT+IHUBHsntlaxpvPpOS9zV6bN75Iwt5jPLKVT7bQUqEfS6daE1qhwTkZtREmb8FnmDnBAHYpUyw==
X-Received: by 2002:a17:906:6a0d:b0:b6d:4df9:68bc with SMTP id a640c23a62f3a-b76c535650dmr205287966b.1.1764059501609;
        Tue, 25 Nov 2025 00:31:41 -0800 (PST)
Received: from localhost (94-21-29-8.pool.digikabel.hu. [94.21.29.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654ff3c40sm1531986766b.47.2025.11.25.00.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 00:31:41 -0800 (PST)
Date: Tue, 25 Nov 2025 09:31:24 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 05/11] builtin/history: implement "reword" subcommand
Message-ID: <aSVpXPtrqa0cBsEm@szeder.dev>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-5-407dd3f57ad3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027-b4-pks-history-builtin-v6-5-407dd3f57ad3@pks.im>

On Mon, Oct 27, 2025 at 12:33:53PM +0100, Patrick Steinhardt wrote:
> Implement a new "reword" subcommand for git-history(1). This subcommand
> is essentially the same as if a user performed an interactive rebase
> with a single commit changed to use the "reword" verb.

s/verb/instruction/

The behavior is not nearly "essentially the same", because 'git
history reword' doesn't check out the reworded commit.

This is a substantial drawback when writing a commit message for
anything non-trivial.  I, for one, often like to take a look at the
"big picture", i.e. the actual file content in the reworded commit, in
case the diff included in the commit message template doesn't show
enough context, or even run Git commands built from that particular
revision to be able to accurately describe its behavior.

OTOH, I understand that this might be deemed desirable in some cases,
like when rewording a commit to correct a simple typo, because source
file mtimes stay intact, or when the worktree contains modified files.

It would be great if this new command could somehow support both use
cases.

In any case, this significant behavior difference (and its drawbacks)
is not mentioned let alone justified in the commit message, it is not
documented anywhere, and it is not really tested, either.


> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-history.adoc |   7 +-
>  builtin/history.c              | 331 ++++++++++++++++++++++++++++++++++++++++-
>  t/meson.build                  |   1 +
>  t/t3450-history.sh             |   6 +-
>  t/t3451-history-reword.sh      | 237 +++++++++++++++++++++++++++++
>  5 files changed, 573 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> index 6bdfeb50e8b..bd903875120 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -8,7 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history of the current branch
>  SYNOPSIS
>  --------
>  [synopsis]
> -git history [<options>]
> +git history reword <commit>

I'm not sure I like this interface, because I have to know in advance
how to specify the revision I want to reword, and I usually don't know
that.  Choosing the commit from the rebase instruction sheet seems to
be much simpler, more intuitive and less error prone.

