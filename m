Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ABF1D6DA1
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740824604; cv=none; b=GVh4VooTvhMhuEMS4R+XKIX1/UdcUQBGMCAnhZelnG0C2FWZ/sgy8FTte3nW4NDqOENx7KyjVfPq/0OikyB2SgLdOgZK+GuVn97AjVNMdjWZhIf8gWweSp5MldecUgpYY3sgJhRs9oWdVA8NPg42HztC937qwIWxiLRS/33Q+kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740824604; c=relaxed/simple;
	bh=E8FeTWfaCtX56DAF5Z+ZXVboS6+tpMdpT4dqq1zb9fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESEhPyz+Kxs1H5ZPUmdjbQpNQL5Ah5Lvi0Ad+9wyWpSM7pQuh67k6vMmYKrVuZ/n34Ot5wGgCz5qKvuC+O4lKezYIp9p+lmoFaRA+LKMdreed29o6pcwH2BQ56TVeFTERd1dqFM5dShfBFsquIZpmK3IDGAKEMIZXYPIvtG5He4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGxX6ldP; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGxX6ldP"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so3177166e87.1
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 02:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740824600; x=1741429400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8FeTWfaCtX56DAF5Z+ZXVboS6+tpMdpT4dqq1zb9fc=;
        b=SGxX6ldPnK+64NTVw5rxL/ICphEXN4qTI1jIFDc4Bnx2FTP1IESiYVx+UHc5Wi65Bl
         cRjHiuBBDkQp/1AFksKou7E9vyyOaSu8DpaGgUmwhYkjw3b2D/mDy+3Tc0RUc9zeTQOH
         zZdO5Y8Hp3uVheY86WfgxYGDVQIj9StSbFFsNBcGWk/ZVKrXwygRpxkSk7JR3GuHY5g7
         4nQJoBLJuDYsJVFnKgwYqK0D6qnpsvZfErM5iOlOqXLZx6R8kXABm/X1q+AqljQ0Y6k+
         Snn2zdJGY+DV452AMV/EF2FAse97UijiQZkpvY+1i6nhjrUQzY6YZrbK2/p+9szwtlWO
         O/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740824600; x=1741429400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8FeTWfaCtX56DAF5Z+ZXVboS6+tpMdpT4dqq1zb9fc=;
        b=T3/rbAgL+AzIqbMRATvtkHjinZAjJf99WAuG8qMW23Q1jEOTU4WoQzZIX0CYoFPOBO
         D4ATLxAooKhJyISOrMGf/OlFdpL/xtzh+ogru1F1s5gsihYdQk0WJvDJH9Wl4iJVjFmS
         n3wiWnI/stJVHDye3B7bP3qkwZ4kTL8nHq+GkEy3jqdHIvAO2U0MdUczC2XhwV6PQNpK
         Hh0+e/RvlLvCvDrzCFkVdeji55DNer+A8Bzg9qK/4SE13B89aeB/a13txBHnk9vyeAGS
         zEch9iUkURRHGfQEn+1HE3GyoXhEJ4MPejdSd2FTPP60pkEBQsnh+c8cA6oYLWUGyGHz
         uwoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVltQF7uQzA+d07//nz2JU9vRIYJBziXWdaz9JCTLGQF25rPR4jOfD0Q+9Ngh+3f2hIjVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCRgCUBgKalJjyBGR0dE4Ba9r8LcCl3WU7ncxWTHOR0emjFclz
	80zH2p8kyDcUuCFVPpafJbzMK+FSbue2omwvIcOSo933Gv0FtTyYnmg6L0Bggb8DleeJz4XRAAv
	iZPQx24/3pmRdIfj7gwoM2Maas5WIxeq2CPc=
X-Gm-Gg: ASbGnctrZDfAoatxO2ds8cJvMJen0A+xxAf+sOz9qHyg9v4lqe39c+MGF3mOywF31Rl
	jXtY8z78PlphXm5XoHCO1Lskr8LtUjLUt2EceOCN2Ym6IlKDng+VEPUzEpnPpMimOp4waU8OpJi
	LN1UHtC8kbuK5Lpg7pXcx7Zi/mnnU=
X-Google-Smtp-Source: AGHT+IFA6MFuy6tbvYrZaJXok6GsoJxoHY+60Ebqxoe7/+iJsKFhJCESVzHI+pgdCHUxxUaYd+vLhoOC3iM08O8wgdc=
X-Received: by 2002:a05:6512:3e0c:b0:545:2953:1667 with SMTP id
 2adb3069b0e04-5494c31ab08mr2541871e87.13.1740824599935; Sat, 01 Mar 2025
 02:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com>
 <xmqqv7sxki36.fsf@gitster.g> <3a180cca-0573-474a-8835-8015dbe09541@gmail.com>
In-Reply-To: <3a180cca-0573-474a-8835-8015dbe09541@gmail.com>
From: Scott Chacon <schacon@gmail.com>
Date: Sat, 1 Mar 2025 11:23:08 +0100
X-Gm-Features: AQ5f1JpYlrB2VqIojSscPyNurQsEPl5XpayVL8U1x8giz2Y_SQJ4HrvV3MhXqoc
Message-ID: <CAP2yMa+YoxRaf48mS7mUbNnsfCm2Z=FT5Gohq_oWz0Q8XnH_eQ@mail.gmail.com>
Subject: Re: [PATCH] bundle-uri: copy all bundle references ino the
 refs/bundle space
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Feb 26, 2025 at 12:36=E2=80=AFAM Derrick Stolee <stolee@gmail.com> =
wrote:
>
> The intention of the design is to avoid having the bundle URI fetch
> changing tag refs, especially annotated tags. Those tag updates are
> expected to be advertised in the "git fetch" output. It would probably
> be best to peel the tag refs to a commit and then create a fake branch
> for the bundle.

The issue for this and also for the other suggestion you have later on
is that I'm not sure how this can be easily done with the bundle
command. It seems like everyone would have to write some sort of
script to create a special type of bundle so that all these objects
are referenced in a way that makes the bundle-uri helper actually get
most of the objects that are needed.

Is there some option to rev-list that does this? Or are you saying
it's better to write a script?

> The biggest question I had (and tried to get ahead of on the PR) is
> the use of a test to demonstrate what kind of bundle files cause this
> issue. It would be important to demosntrate that the repo is still
> usable if "refs/bundles/tags/v1.0" exists and points to a tag object.

I have written a test and I'll submit the new series in a minute, but
I'm not sure what you mean by 'usable' in this context. Is there a
situation where Git gets mad if there are annotated tags that aren't
under refs/tags?

I have done these test clones and nothing bad seems to happen having
them in refs/bundle/tags/v1.0 that I notice, but I don't know how to
write a test that specifically verifies that.

> So I'm OK with relaxing this to be more flexible, but I'm not sure
> why the bundles couldn't be created using "refs/heads/", possibly via
> changing the ref names during bundle creation.

So same point here. I think the bundle-uri functionality isn't
particularly effective if the creation of the bundle needs special
scripts to create in a way that is expected.

One other approach would be to add an option to `git bundle` that does
this sanitization (unpeeling things into fake branch heads), like some
`--bundle-for-uri`, but I feel like just using `--all` and having the
clone handle it in the way I proposed might be much simpler and more
usable.

We could also immediately delete everything under `refs/bundle/tags`
after the fetch if we don't like them there, but still having them be
available for the fetch negotiation.

I'll send a new series with the existing tests updated to look for
`refs/bundle/heads/*` instead of `refs/bundle/*` and adding a very
simple test to see that the tags were unpacked as the next step.

Scott
