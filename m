Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D61BDC8
	for <git@vger.kernel.org>; Fri, 10 May 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369667; cv=none; b=DGW5FxRJbxxvOWXRifWVuRDkQLa3jOlbZVOfL1ETKc1qyHXPhxFZ7WQHXvckQErSUxFRKHRx9Ez6v0zw49Q28vqh7oPMFszsL1C0roB9hZi6h8uX9QImCoSzdhLp7qPGUxI6fZknhCEIj2SAcLTI/Ma9xw0kiwZgdiz4f4xBSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369667; c=relaxed/simple;
	bh=84dFulvftpwfQN+hJHp4M0Yx5ZaKBu0M0YuXckeLRqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8LaNV57n2qJj6lLVW3wwckQUSKKEgsK5LciScGya9A3j/77Pq4aqanyFTL3mYnNp5FQiOn9S2FQrnBJR1RnMlM2dSalNv18YXpU02rRwCdrPNUG5AhehCTiICsbWK5vcjNIiLIuo431d1WMvBNAORA8UT1YCEH4S9QpnuphpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqQYQEs1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqQYQEs1"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43dfe020675so93811cf.0
        for <git@vger.kernel.org>; Fri, 10 May 2024 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715369664; x=1715974464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rb03l1EPKzAE86o9Yc6suTubG6I8t7V2Ft8obC8RlTY=;
        b=GqQYQEs1+lPiQmyXufTcXpsuaNhFwLNlw7S0IwZWuImtEXqofZEmcTx+Gpscts6Av5
         MC84guh8NQlgN4f6vmHtaXgtowZkauDRV2E9NRH5q0+xJTxDSmI9S9P6NnC0j/Ryckct
         Kpd9UNk/U/gb0eUvXuqT2O7vZ9tDCXr5Oqw2rhBqRIWR+XoZXG3aHmTgZyNugI70Ar/v
         bgQCVeiUtcHzG2vc4zEdQN6TeGV/rJZesNf6Q+x2YB62i573oqki92rj8uZQocVMMqmb
         ga2AGvP6rp8KZENOzMhb2QExvgrY9LV9eCO8npLsCIvn6sIVHjMOYy0q8GiRck3Xbhcj
         j5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369664; x=1715974464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rb03l1EPKzAE86o9Yc6suTubG6I8t7V2Ft8obC8RlTY=;
        b=izJMUtNMm5m4fOdqymWyhwAPjyCCJDQG6BhiZ50TjkxzvE7ruLwYtO/0uXymbq3y72
         /r59bPhP3ToQauAkd+edA3M6eoQyUgPJHHerpKswIoFpn79S4V/bqRM3yWwgoQPBZu4g
         iW0vK5dDmfzuaZ9VUgwZVeEEc/Eu0+ffwMpq46zjN3b/9Mkttfhpf+UtqQ197hjD7RcP
         FH/S6jTvl4pEymJ2sp87Ou6XpUqd0MCRsSKk4wllMuX82aJn4UPW0k4a+QbtouZHgeVx
         L3zFk3ArvoMtvTCKWwnNyBTL+YaauW6IK5JMTBY0LgVE5B9eXKfYMdazM0DbNyN4/WMF
         ElSw==
X-Gm-Message-State: AOJu0YzN8hzzBOa9kQ+LdeNU2U5gAlxetfsRLWtMcJV/VGuchy4wLC2c
	Qcw9GFbkaZdYmnYxbCpVeZol8uoYrxPNK0hps/F7zN+C0P9WvT+jhwRJyf77Ay4aRG859vL07pa
	F8pRqDd4yAuctXNbeyRUH44GfqKjYHPcabzhL
X-Google-Smtp-Source: AGHT+IGOC1o7eR2l+gi7XF6IxhYRJDyBlY267aBv3CLEwFg45KUmAlu0FD2mulSj/ssGAkV71N9s78HQgnKiphTtKqM=
X-Received: by 2002:a05:622a:5447:b0:439:a979:ccb2 with SMTP id
 d75a77b69052e-43e094e8ec6mr406521cf.16.1715369660449; Fri, 10 May 2024
 12:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510172243.3529851-1-emilyshaffer@google.com> <xmqqv83l4i86.fsf@gitster.g>
In-Reply-To: <xmqqv83l4i86.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 10 May 2024 12:34:07 -0700
Message-ID: <CAJoAoZmvzZaLN6cQkH4XeD9-=OwWFjT1adRA1oFHaUVyVWwLXQ@mail.gmail.com>
Subject: Re: [PATCH] trace2: intercept all common signals
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 11:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > From: Emily Shaffer <nasamuffin@google.com>
> >
> > We already use trace2 to find out about unexpected pipe breakages, whic=
h
> > is nice for detecting bugs or system problems, by adding a handler for
> > SIGPIPE which simply writes a trace2 line. However, there are a handful
> > of other common signals which we might want to snoop on:
> >
> >  - SIGINT, SIGTERM, or SIGQUIT, when a user manually cancels a command =
in
> >    frustration or mistake (via Ctrl-C, Ctrl-D, or `kill`)
> >  - SIGHUP, when the network closes unexpectedly (indicating there may b=
e
> >    a problem to solve)
> >
> > There are lots more signals which we might find useful later, but at
> > least let's teach trace2 to report these egregious ones. Conveniently,
> > they're also already covered by the `_common` variants in sigchain.[ch]=
.
> >
> > Sigchain itself is already tested via helper/test-sigchain.c, and trace=
2
> > is tested in a number of places - let's also add tests demonstrating
> > that sigchain + trace2 works correctly.
> >
> > Signed-off-by: Emily Shaffer <nasamuffin@google.com>
> > ---
> >  t/helper/test-trace2.c   | 17 +++++++++++++++++
> >  t/t0210-trace2-normal.sh | 22 ++++++++++++++++++++++
> >  trace2.c                 |  2 +-
> >  3 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
> > index 1adac29a57..8970956ea8 100644
> > --- a/t/helper/test-trace2.c
> > +++ b/t/helper/test-trace2.c
> > @@ -231,6 +231,22 @@ static int ut_010bug_BUG(int argc UNUSED, const ch=
ar **argv UNUSED)
> >       BUG("a %s message", "BUG");
> >  }
> >
> > +static int ut_011signal(int argc, const char **argv)
> > +{
> > +     const char *usage_error =3D "expect <bool common>";
> > +     int common =3D 0;
> > +
> > +     if (argc !=3D 1 || get_i(&common, argv[0]))
> > +             die("%s", usage_error);
> > +
> > +     /*
> > +      * There is no strong reason SIGSEGV is ignored by trace2 - it's =
just
> > +      * not included by sigchain_push_common().
> > +      */
> > +     raise(common ? SIGINT : SIGSEGV);
> > +     return 0; /*unreachable*/
> > +}
> > +
> >  /*
> >   * Single-threaded timer test.  Create several intervals using the
> >   * TEST1 timer.  The test script can verify that an aggregate Trace2
> > @@ -482,6 +498,7 @@ static struct unit_test ut_table[] =3D {
> >       { ut_008bug,      "008bug",    "" },
> >       { ut_009bug_BUG,  "009bug_BUG","" },
> >       { ut_010bug_BUG,  "010bug_BUG","" },
> > +     { ut_011signal,   "011signal","" },
> >
> >       { ut_100timer,    "100timer",  "<count> <ms_delay>" },
> >       { ut_101timer,    "101timer",  "<count> <ms_delay> <threads>" },
> > diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
> > index c312657a12..c34ccc518c 100755
> > --- a/t/t0210-trace2-normal.sh
> > +++ b/t/t0210-trace2-normal.sh
> > @@ -244,6 +244,28 @@ test_expect_success 'bug messages followed by BUG(=
) are written to trace2' '
> >       test_cmp expect actual
> >  '
> >
> > +test_expect_success 'trace2 reports common signals' '
> > +     test_when_finished "rm trace.normal actual" &&
> > +
> > +     # signals are fatal, so expect this to fail
> > +     ! env GIT_TRACE2=3D"$(pwd)/trace.normal" test-tool trace2 011sign=
al 1 &&
>
> Is it deliberate that this does not use test_must_fail or is it an
> oversight?  The same comment applies to all other uses of "! env".
>
> We often see the use of "env" in conjunction with a test that is
> expected to fail because
>
>     test_must_fail VAR=3DVAL cmd
>
> simply does not work.  If you are not using test_expect_fail, then
>
>     ! VAR=3DVAL cmd
>
> should be sufficient, but it would mean that you will be happy even
> if the way "cmd" dies is not in a controlled way (e.g. due to
> receiving a signal).
>
> Ah, perhaps that is it?  Is "test-tool trace2 011signal 1" raise a
> signal to kill itself and after showing the event in the trace
> stream it is expected to die the narual death of receiving the same
> signal by re-raising it?

Yes, it is because test_must_fail expects "natural" death. You can
tell test_must_fail which signal you'd expect to receive, in theory,
but I didn't get it to work (and it will be tricky to provide the
correct signal in shell - I had originally hardcoded signal ints in
sh, but then moved the signal enum->int resolution into
helper/test-trace2.c because the alternative is doing some nasty
grepping on other shell utility outputs, since the signal codes aren't
platform/arch consistent).

Anyway, I will try it without `env`.

>
> If that is what is happening here, not using test_must_fail is
> absolutely the right thing to do, but then I doubt you need "env"
> there.  Also, if we know what signal is raised, then we should also
> know the exit status from this (i.e. signal number plus 128 or
> something) that we want to validate?  I dunno.

We could? But I don't feel strongly about it. If I specify the exit
status, the test will be brittle if we change the exit codes later
(for example, 128 or -1 for all error exits is kind of an antipattern;
it might be nice to ask Git to return meaningful error codes depending
on what went wrong, in the future). We are already checking later on
during the test_grep that we exited due to a fatal signal.

Thanks for the feedback - I'll get going on a v2 and aim to send it
later today, since I don't hear you saying that the patch's overall
goal is objectionable.

While I'm at it, since you pointed out ! instead of test_must_fail, I
wondered if I should change "! test_grep" as well - but when I grep t/
it looks like it's not usual to use `test_must_fail test_grep`, but
instead to use `test_grep ! <omitted pattern> <file>`. I'll change
that too.

I also wonder - do we want to capture SIGKILL as well? Some people may
have muscle memory for `kill -9` (I do, for better or worse) instead
of gentler `kill`. My intent was to notice any indication of user
frustration resulting in manual termination, which would include `kill
-9` too...

 - Emily
