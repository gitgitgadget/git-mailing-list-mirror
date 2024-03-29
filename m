Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94D11182
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 02:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711680242; cv=none; b=nkCEjb14oXjiaWLJ+HwNmnnpTHLdEhAZamtAHIokFXnqMYMy3Wd02BL06V1CRAeL31ZLjEGCbDPKkLilcviCWHLmafrJNvxtGMWlRqbL4o9AAhjpx0IPtb00BE5nOGGoqNcsd/CmBpJZ6J8/zEKMtPCj8wWH9Ww9RBs/fDe5piM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711680242; c=relaxed/simple;
	bh=7LHgMKa1N+o2dJZk8rHOXWT9K1lYU1a71NhvCiU2gpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZS7iJS3zs8qLKy3vbyiR3R/AlwjsgRldusOCCNkAJFKinNjlPxLzhAS5TRZ0lu/3NGBxbS5/pb7lsyERj7rOvbAACamO9g399qQMVmgqPX4V6qjz/Gqi/iTSQl3wEN29dZQP7FhNTTFF6HdY64PIwxTtIv0im4+Y8EB5MI+c2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690bff9d4a6so9586636d6.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 19:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711680239; x=1712285039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHY3HjDz7KW36k468xp66rGFXZ1QbktgM3Sxt+/xT6g=;
        b=WS/tE7AQRoHLdE4lONiTryHAs7z+M614AhBfjCkRKtgLQcy42SMZNaZLaQ0jxKtHcn
         f7BQ+g+4BBUaJOr841CaaP35w77g8DEGXGRfWFl2XtRFvBDsxESt6eXlVeZSNiCUn22i
         JtD9r80Lve5Ryke0jutQlZHszk9oz1fjjweYuhMDBt8FRq1+ViVcK7kH1Don/krbTCDC
         w97SUSb6fQNE6nmW7UHQLdoOxwAHmm5WZAlG+tbm+zgk7JaHACRD7OXMnPlRnlA6ohPx
         B9Abs8bZimfPDZVZO6boDZcbAkFW2Tv7+BGSSYwvQf+BC/KZyaBYNibMOyQ8YLEMQHvY
         AtcA==
X-Gm-Message-State: AOJu0YwV+G/XeLlBudfGYK1uODtWo/GMPhpL3ua96vAQb3swOKS7IGGN
	XxmR8QOB5dyfLIn0v/LIwuN/nElq/8bR+GS47sa0uQs3la8SbjXzZ6QohClRhoo7/Ry0Ed6DjPm
	USi7cTIn/Lox6zLYTRvFXK3zpp63n56YKD+A=
X-Google-Smtp-Source: AGHT+IGX5Bo3IZCXr24uSK7QaXifwIGbj2L/6Ix+V/nqTBlriPYk8XYAcWmKfDtRMsvrBNYeXlrzbcF9CEpL6ZMDLsM=
X-Received: by 2002:a0c:f68e:0:b0:691:8262:ec48 with SMTP id
 p14-20020a0cf68e000000b006918262ec48mr900197qvn.35.1711680239482; Thu, 28 Mar
 2024 19:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmsqhsvwk.fsf@gitster.g>
In-Reply-To: <xmqqmsqhsvwk.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 28 Mar 2024 22:43:48 -0400
Message-ID: <CAPig+cStHRX-wZKwdcO33wCjd4UU3MO-rVisyOFZ1vPbGaN51Q@mail.gmail.com>
Subject: Re: [PATCH] do not set GIT_TEST_MAINT_SCHEDULER where it does not matter
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> 31345d55 (maintenance: extract platform-specific scheduling,
> 2020-11-24) added code to t/test-lib.sh for everybody to set
> GIT_TEST_MAINT_SCHEDULER to a "safe" value and instructed the test
> writers to set the variable locally when their test wants to check
> the scheduler integration.
>
> But it did so without "export GIT_TEST_MAINT_SCHEDULER", so the
> setting does not seem to have any effect anyway.  Instead of setting
> it to a "safe" value, just unset it.

I agree that the missing `export` makes this a do-nothing assignment.
In fact, that problem traces back to the original 2fec604f8d
(maintenance: add start/stop subcommands, 2020-09-11).

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git c/t/test-lib.sh w/t/test-lib.sh
> @@ -1959,9 +1959,9 @@ test_lazy_prereq DEFAULT_REPO_FORMAT '
>  # Ensure that no test accidentally triggers a Git command
>  # that runs the actual maintenance scheduler, affecting a user's
>  # system permanently.
> -# Tests that verify the scheduler integration must set this locally
> -# to avoid errors.
> -GIT_TEST_MAINT_SCHEDULER=3D"none:exit 1"
> +# Tests that verify the scheduler integration must set and
> +# export this variable locally.
> +sane_unset GIT_TEST_MAINT_SCHEDULER

Clearly the idea was to protect the scheduler-configuration of the
person running the test in the event that the test author forgot to
set GIT_TEST_MAINT_SCHEDULER to one of the legitimate "testing values"
before invoking a "destructive" command, such as `git maintenance
start`. By defaulting to `none:exit 1`, the problem would be caught
and reported before any damage could be done to the configuration of
the person running the tests.

So, I'm somewhat skeptical of the new direction of simply unsetting
GIT_TEST_MAINT_SCHEDULER since that outright removes the intended
protection. I'd have expected this problem to be addressed by
exporting GIT_TEST_MAINT_SCHEDULER, not by making it easier for an
absent-minded test author to break his or her own configuration.

Having said that, it you do want to go the route of eliminating the
(intended) protection altogether, I have a couple additional
observations:

First, this change requires a corresponding update to the lead-in
comment ("Ensure that no test accidentally triggers a Git command that
runs the actual maintenance scheduler, affecting a user's system
permanently.") since it renders that comment incorrect.

Second, it seems very unlikely that GIT_TEST_MAINT_SCHEDULER will be
set in the user's environment anyhow before running the tests, so
unsetting it here seems unnecessary and pointless. Instead, a cleaner
approach would be to simply remove the entire hunk in t/test-lib.sh
dealing with GIT_TEST_MAINT_SCHEDULER, including the comment.
