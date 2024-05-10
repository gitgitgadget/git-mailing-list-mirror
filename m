Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE921B285
	for <git@vger.kernel.org>; Fri, 10 May 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363869; cv=none; b=fZb/3p+nS549qElbZc8pEM24j+sxvXSR0wagGWJwOjNMhZPZ0bwIvTGd8sVgcu1ZzdP6BRhIcL2awB89+vx9vkUsXq1GnvYjJUfiUaWWyslFvnGV8aIdkZ/n1k190PgaVlZz+Mu9KOOHh3uIvRxnqwevFBb78oRwnOQK9GfbVq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363869; c=relaxed/simple;
	bh=uXO/2JJSTdhkqoJy6FWV1R3xqLRb8p6EGmdlbe+q/I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5cLQ+a8vNcrG0ZWHHGpL/Fub2q1V9xs3zwnv982f7mZR/QklnCOn9fReqoba/3ozBpTLDD0eDADjj4Un5JxwzTWlNARg1/ncICzUdwa0u2c1uY1EWXVpm/7oMsA80g8oJmJJPqXQfPC8EB/6gnwxYOM9l9bv1QX7DW6qnJAm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KKci4RgY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KKci4RgY"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43dfe020675so45071cf.0
        for <git@vger.kernel.org>; Fri, 10 May 2024 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715363867; x=1715968667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQYtCvk03OYNgRPSoROaZzmlqHXZTmcWcDNzOqVbbrg=;
        b=KKci4RgYI5rTC7ezLmpDHs6ukupyusgB7J8O3pZP8E2Y6t+nqeDhzBnD+h29euznz6
         izjw+Xp/dfyfcWnKXviISIgWNO4yUwkvW0F6LFsj2zo0zWQ/wArTGZj9ELI+DH69gPjV
         LmmI1IAQaEQ7MNmCypY+TQ1qdSJiQibLyeHLUCMUy8EisKj4ozP5UaOCqKAaBsKHwnYC
         EApPe7z47RQ7lQqlJHQDVpd9gPQIrDSd8X2VRZasRUkjROfR0FObMymWZ7bABw5XI45Q
         OXjfASkFtFYfsaL3UHKyb+GQRtogfCAc1XuCE4bU4B90lpq11P2KN1SOR3hQaVjEpR9E
         HSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715363867; x=1715968667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQYtCvk03OYNgRPSoROaZzmlqHXZTmcWcDNzOqVbbrg=;
        b=jheoDUa7vLM5G5nNxAmHAUT2sKjfA713QCMGEHPug0y+A+Un0kXC2yDmniuqFNVR3R
         /BriYzU4jfXrOQvex/lgnMbGI1N3KBI7y3UDY0OAXxjuMAOkriKdNAc7rkO8jYYJg7jf
         tebNT31AqFLYmIkl5n1l9bdBebfKWWZME2aTFKz6xkVCjLeW9EuTwPB+fniSml4wAbZg
         fkAC+znN6CFGqt8YcDNS9RbRUxOECkFUnPx1sHbq2dAWgydY+Op/qjrxXhPPaZEmHGvv
         akA3k6mhyE00za52vYjsVTu0uKipCcPj6f8V/eH+qyn5d58hJN3mxEN4hoCu5iAG/MAJ
         +8fg==
X-Gm-Message-State: AOJu0Yz+SWETs8QgKBh9lOzPgDhnT9KoNr8WiYc3J/aYLU1l5r5m76FH
	vuIoAUDcKSoFRBpZ5M7c53EbagzJo7XnKDJLiOaHUjuIeDoY5q358x4+rpFBo6gX8rMGrvTM1Ek
	2V7Wd2di9/Twfl4hwJMSM8bYEq4lTqtDtAQAGY1Oc1ncWVT/oWtoUY64=
X-Google-Smtp-Source: AGHT+IEFWzrDj55hilxV7nYr8b+NPgHUZ3OgWXTRhvQwBi1nzEl4HcbuuP7o6u6yR8kqusjhAsW/a+0JN6ppt4uLqkE=
X-Received: by 2002:a05:622a:2a17:b0:43a:b51c:46ca with SMTP id
 d75a77b69052e-43e09732ec3mr13831cf.29.1715363866812; Fri, 10 May 2024
 10:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510172243.3529851-1-emilyshaffer@google.com>
In-Reply-To: <20240510172243.3529851-1-emilyshaffer@google.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 10 May 2024 10:57:33 -0700
Message-ID: <CAJoAoZkkDxhJtXfLx-4++9JuaSr5xJ4Da4_ijVZP05DkLhHDcQ@mail.gmail.com>
Subject: Re: [PATCH] trace2: intercept all common signals
To: git@vger.kernel.org
Cc: git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 10:22=E2=80=AFAM Emily Shaffer <emilyshaffer@google=
.com> wrote:
>
> From: Emily Shaffer <nasamuffin@google.com>
>
> We already use trace2 to find out about unexpected pipe breakages, which
> is nice for detecting bugs or system problems, by adding a handler for
> SIGPIPE which simply writes a trace2 line. However, there are a handful
> of other common signals which we might want to snoop on:
>
>  - SIGINT, SIGTERM, or SIGQUIT, when a user manually cancels a command in
>    frustration or mistake (via Ctrl-C, Ctrl-D, or `kill`)
>  - SIGHUP, when the network closes unexpectedly (indicating there may be
>    a problem to solve)
>
> There are lots more signals which we might find useful later, but at
> least let's teach trace2 to report these egregious ones. Conveniently,
> they're also already covered by the `_common` variants in sigchain.[ch].
>
> Sigchain itself is already tested via helper/test-sigchain.c, and trace2
> is tested in a number of places - let's also add tests demonstrating
> that sigchain + trace2 works correctly.
>
> Signed-off-by: Emily Shaffer <nasamuffin@google.com>
> ---

Missed including the CI results. They're passing[1] with the exception
of the osx-gcc run, which seems to also be failing on the latest
'master'[2] and looks to be failing in setup rather than in test run.

1: https://github.com/nasamuffin/git/actions/runs/9035666915
2: https://github.com/nasamuffin/git/actions/runs/9036080205/job/2483220912=
9

>  t/helper/test-trace2.c   | 17 +++++++++++++++++
>  t/t0210-trace2-normal.sh | 22 ++++++++++++++++++++++
>  trace2.c                 |  2 +-
>  3 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
> index 1adac29a57..8970956ea8 100644
> --- a/t/helper/test-trace2.c
> +++ b/t/helper/test-trace2.c
> @@ -231,6 +231,22 @@ static int ut_010bug_BUG(int argc UNUSED, const char=
 **argv UNUSED)
>         BUG("a %s message", "BUG");
>  }
>
> +static int ut_011signal(int argc, const char **argv)
> +{
> +       const char *usage_error =3D "expect <bool common>";
> +       int common =3D 0;
> +
> +       if (argc !=3D 1 || get_i(&common, argv[0]))
> +               die("%s", usage_error);
> +
> +       /*
> +        * There is no strong reason SIGSEGV is ignored by trace2 - it's =
just
> +        * not included by sigchain_push_common().
> +        */
> +       raise(common ? SIGINT : SIGSEGV);
> +       return 0; /*unreachable*/
> +}
> +
>  /*
>   * Single-threaded timer test.  Create several intervals using the
>   * TEST1 timer.  The test script can verify that an aggregate Trace2
> @@ -482,6 +498,7 @@ static struct unit_test ut_table[] =3D {
>         { ut_008bug,      "008bug",    "" },
>         { ut_009bug_BUG,  "009bug_BUG","" },
>         { ut_010bug_BUG,  "010bug_BUG","" },
> +       { ut_011signal,   "011signal","" },
>
>         { ut_100timer,    "100timer",  "<count> <ms_delay>" },
>         { ut_101timer,    "101timer",  "<count> <ms_delay> <threads>" },
> diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
> index c312657a12..c34ccc518c 100755
> --- a/t/t0210-trace2-normal.sh
> +++ b/t/t0210-trace2-normal.sh
> @@ -244,6 +244,28 @@ test_expect_success 'bug messages followed by BUG() =
are written to trace2' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'trace2 reports common signals' '
> +       test_when_finished "rm trace.normal actual" &&
> +
> +       # signals are fatal, so expect this to fail
> +       ! env GIT_TRACE2=3D"$(pwd)/trace.normal" test-tool trace2 011sign=
al 1 &&
> +
> +       perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >act=
ual &&
> +
> +       test_grep "signal elapsed:" actual
> +'
> +
> +test_expect_success 'trace2 ignores uncommon signals' '
> +       test_when_finished "rm trace.normal actual" &&
> +
> +       # signals are fatal, so expect this to fail
> +       ! env GIT_TRACE2=3D"$(pwd)/trace.normal" test-tool trace2 011sign=
al 0 &&
> +
> +       perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >act=
ual &&
> +
> +       ! test_grep "signal elapsed:" actual
> +'
> +
>  sane_unset GIT_TRACE2_BRIEF
>
>  # Now test without environment variables and get all Trace2 settings
> diff --git a/trace2.c b/trace2.c
> index f894532d05..3692010f5d 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -231,7 +231,7 @@ void trace2_initialize_fl(const char *file, int line)
>         tr2_sid_get();
>
>         atexit(tr2main_atexit_handler);
> -       sigchain_push(SIGPIPE, tr2main_signal_handler);
> +       sigchain_push_common(tr2main_signal_handler);
>         tr2tls_init();
>
>         /*
> --
> 2.45.0.118.g7fe29c98d7-goog
>
