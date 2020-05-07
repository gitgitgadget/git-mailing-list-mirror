Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A4AC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 11:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8D620870
	for <git@archiver.kernel.org>; Thu,  7 May 2020 11:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZGeEud5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgEGLS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 07:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgEGLS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 07:18:58 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832D6C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 04:18:58 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id a8so2734918ybs.3
        for <git@vger.kernel.org>; Thu, 07 May 2020 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t/+6u/Zc0YpSL3D0DfjhXQBXMytAlUJFoIFZ92A+7I8=;
        b=lZGeEud5R8f29OhN6BgblLX18IqYAdsj8Q8S7nPu2GlO6b4ixHsvGIReXaZHfTlIXU
         IFvmPVyHDKwBEdSQ0IZ+3+NDoG5i8IB/vRQCBgmt0ooYevW6k5J5l5DAaPS4usww7Abw
         w6WCx+UcVmsOxnM/VMDrKLzKq05qsH9mTO31IrIbDUQY8P3txaQFVQ5GW/4ot8I2mcC6
         FWvTol/I3iFlqQPycP8z3Y52ATBjzjuPfiE44zKyBABXiqAMlo/WJNCDiftNb54gL266
         qS0ctKKDIp063S5opbbUaiAtomawmF+wSPq76HPGGSTHSg74wht92a1aesy2ZFjX2owH
         BMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t/+6u/Zc0YpSL3D0DfjhXQBXMytAlUJFoIFZ92A+7I8=;
        b=C51xINbx7jpmzHfZWOQZ9REH1lF62XgKRFK9QMtOSeTXr1VgkeB2fwmTmMySEmiP6I
         Cz4MvZmFWTBPjkxn5KUtcJ73fFlYy8AC9fxI8oJE5joGKtaWbOKhEgxunvsksPaUeLUo
         uYCbmFW12vfftGL5lr7lIILtfXK1iHeZ8iHZDpGgStK/SbPdeQ5fQEAxb6fcqHxgSr8B
         JYA81IH1RJ8UYYHDJ3/XnBrOJ3eClSmEva4jGWMwACF1nJad7nNt9TtI/OLZQhQjN5g1
         QmFAoDsa5KYicTTxg6kuKwJKY+fvRw88kLK/JliGg69eYpKdFx2Nm3XBgWDurvhHbEa/
         Mruw==
X-Gm-Message-State: AGi0PuZTzXJ1JAUROvfAhUBS5U4J1pgJyKDpBB7Wy01wu/MntfDO2Ein
        JFTU+EJ0HRuWFupOpa+uLl3CVCPEd14fUrabOxIh5XvO
X-Google-Smtp-Source: APiQypLOh3Nt4tVIr/eqgXUHq8IHGrh1PI4o58B56XwuK42LIQilay/jOooRq80sp2ahpmTQzGBYs49vvKlLAcJgz+E=
X-Received: by 2002:a25:4446:: with SMTP id r67mr433209yba.41.1588850337601;
 Thu, 07 May 2020 04:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
 <20200505144131.30048-1-worldhello.net@gmail.com> <xmqq4kss64h7.fsf@gitster.c.googlers.com>
 <CANYiYbGf-szLeBP_JVpCYaWczeg1rNavDCXtEuwXUqiLNoUFtQ@mail.gmail.com>
In-Reply-To: <CANYiYbGf-szLeBP_JVpCYaWczeg1rNavDCXtEuwXUqiLNoUFtQ@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 7 May 2020 19:18:46 +0800
Message-ID: <CANYiYbHi90euK_O8KwPjikuSimWzScV7jT5yoxvT6pFHPJhRdw@mail.gmail.com>
Subject: Re: [PATCH v14 0/7] New proc-receive hook for centralized workflow
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=887=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=889:37=E5=86=99=E9=81=93=EF=BC=9A
>
> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=887=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=887:14=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Jiang Xin <worldhello.net@gmail.com> writes:
> >
> > > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > >
> > > This topic introduces a new hook named "proc-receive" for
> > > "receive-pack".  We can use this hook to implement a Gerrit-like
> > > centralized workflow.
> >
> > https://github.com/git/git/runs/651179641 shows us that osx-clang
> > job ends like so:
> >
> > Thanks.
> >
> >
> > Test Summary Report
> > -------------------
> > t5411-proc-receive-hook.sh                       (Wstat: 256 Tests: 273=
 Failed: 0)
> >   Non-zero exit status: 1
> >   Parse errors: Tests out of sequence.  Found (27) but expected (26)
> >                 Tests out of sequence.  Found (28) but expected (27)
> >                 Tests out of sequence.  Found (29) but expected (28)
> >                 Tests out of sequence.  Found (30) but expected (29)
> >                 Tests out of sequence.  Found (31) but expected (30)
>
> It seems that the status report for git-push ("ok <refname>") confuses
> the test. Will fix it in next reroll.

This morning I cannot find the specific error from the build log, but
now I find the error output inside the job tagged as "Run
ci/print-test-failures.sh":

    ++++ diff -u expect actual
    --- expect 2020-05-06 22:47:02.000000000 +0000
    +++ actual 2020-05-06 22:47:02.000000000 +0000
    @@ -2,5 +2,6 @@
    remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    remote: # proc-receive hook
    remote: fatal: protocol error: expected "old new ref", got
"<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    -To <URL/of/upstream.git>
    - ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive
failed to report status)
    +fatal: unable to write flush packet: Broken pipe
    +fatal: the remote end hung up unexpectedly
    +fatal: the remote end hung up unexpectedly

In order to increase the code coverage (thanks Stolee for sending a
nice code coverage report), I add an option "--die-readline" for
test-helper (t/helper/test-proc-receive):

                if (parse_oid_hex(reader->line, &old_oid, &p) ||
                    *p++ !=3D ' ' ||
                    parse_oid_hex(p, &new_oid, &p) ||
                    *p++ !=3D ' ' ||
                    die_readline)
                        die("protocol error: expected 'old new ref', got '%=
s'",
                            reader->line);

Hook "proc-receive" hook will die early with the "--die_readline"
option, and "receive-pack" should continue running because
"receive-pack" ignores the SIG_PIPE signal, but I don't know why the
behaviors of "receive-pack" are quite different on different
platforms.

I will rewrite the test case using "grep" instead of "test_cmp", and
may send another reroll tonight.

--
Jiang Xin
