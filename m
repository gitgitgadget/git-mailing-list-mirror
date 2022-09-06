Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A92ECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 13:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiIFNKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 09:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiIFNKu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 09:10:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592AE1AF38
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 06:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662469829;
        bh=3kHU5Cj80w2KxVFvNjwD9iBaT3tw6z7CFhTMcLoVIuo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Vxw67B7pTYaKOFtz2jzB+zYsuPTXZfNf0lXv73w3Hq4Yi71fWq1ojZKlhoACrih2j
         U2/7RzL9Bnqv0YOeNL5+ym2jU159n4E6QeUAjK6jCK4llCuBZlcAi/fgBZpWSn3vWr
         hkJa/Y4nK6T0SrbEDxsKJ+Wi/GNwA95LX/L/dBig=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mBQ-1pWM7F35Se-0136WS; Tue, 06
 Sep 2022 15:10:29 +0200
Date:   Tue, 6 Sep 2022 15:10:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests: replace mingw_test_cmp with a helper in C
In-Reply-To: <xmqqwnbv7trp.fsf@gitster.g>
Message-ID: <354qp59q-r4r3-1971-5o09-71q224911orp@tzk.qr>
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com> <xmqqwnbv7trp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RTQuj4POHfIZfTWoI4B28sEeAjbDRWxvceOs8xl2lS3B33ml7N/
 npwd+a1YQBKXM2x9z8AeHo+2L6jb5Dj1LiFGroqwBgZj2nYDVsGnASTrvRScztUG4On7ogy
 Qsrz2OOWYNNdotPLYvk8b+lBjTIdudbw+tZXInKGeAZb3Vaua+b5y2vcT3sscfStSxOVfBF
 TuWMjbc/hnyoutTBk6SIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:esnCD5zin3g=:wAruoVaMeavl3VsWSimSce
 yr8w0rq0iN+IGGsIjEoAihNE0Emi73TQ9LXvL/TxzvLblXG6f/z2Ur9WXZg7PbK5EKCcv36UM
 OYC1wZi9kF2IcOmbsuMtjatTQGDc+kMknbXpARrR6IhphQ2gDfgad7BmJPz72XT+WcTd0coDO
 WXnLCTigKPkH5v/wsyDwC5VCfeqCxWvFB5fuILT69NfPPqLf0NZl1ThIn9ZlJwIup8OZF9FzW
 tTpsIiROmnK1bT2Ctpm5EOBxavTHNfpEBKCQ2d7jeCCzD9eDBRK/V/xLxeCGk4zlCpB8xB4Iy
 J5ALP7cTWTSiJMIT5EM0z2UFedUqQ1rwLVUA7vmKdgh5eLNJ0mXVwi56guHjYTe2+kldKR0jv
 LkYQ7WvN+ihmaFKrXEhFkTBKErZn4xC/PEHWO/V2Jq/udAEbzToXz9dsJmcdpeSiT3JouUhds
 phcE308k5wJUej8K6j8UG/QRbQKVxHZE1e8l3Jc+uFbs/rVaelSo6vHgExXiUgmzbf6yF1qmh
 +TjSVVH8zKUW2U0pcaYOwZs7SpLcuA6CjvWlPAdJYqk0r2E09fxwVWTekmlK0DlNDG9WMyNOH
 0PO9RRjuuVbIwHJQWh2Fl2R2ytqTcS02g/+WIMKrQdWPJGR9AZyOlbbwIjWfaUO/hNDbHCWa4
 alXOd56RQzeNGylNQFconcM57OY5X15GfP66VYPrLR+7ZiYYBWIDmyXX2Le+qlKlib8IJ6z+I
 Lasu9h0DD9c2KWUkc5sQzWgEnPbyUerhvdPpisH497b2x4xghkckZxKHagLXGJjZwHFpIh5vx
 E4XEffffGcagTUZ6RvJISqfbrpklhQGNft/At2bjaPTLNFuPnDiIQ2yffrDsGMKDmY1YjjLY3
 xMRqQMnj2mVokhXIuEyrMoClggcPWOkKC93Y+GKyBW7mDYPfQY1WMGLcybM0neMmB2OsSB3S/
 ASSx3xaMHfq5qJStxMA9+2L1xubLNF80X416ug5HX3H3ziSiXNcxx6Yy55bGcZY4KFFsX2XJr
 GNte/2JtQTbGftxLO+KQdtmSqFIQ4JK9B/vjxnohbISIo6qIftiVbqSySAqtLVRAqWow/KmjD
 DlP57VauunN+7jOwb2Y+FI3ICgFGKnxblVjirEBepxr2PKgUuQJjzl9pkyy4YVhPkzvoqZyTj
 yZTSgXvsWBjsn369KJuzZ5Qzeb
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 29 Jul 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +	const char *argv[] =3D {
> > +		"diff", "--no-index", NULL, NULL, NULL
> > +	};
>
> Don't we want to have "--" before the two paths?

Yes!

> > +	if (!(f0 =3D !strcmp(argv[1], "-") ? stdin : fopen(argv[1], "r")))
> > +		return error_errno("could not open '%s'", argv[1]);
> > +	if (!(f1 =3D !strcmp(argv[2], "-") ? stdin : fopen(argv[2], "r"))) {
> > +		fclose(f0);
> > +		return error_errno("could not open '%s'", argv[2]);
> > +	}
>
> It is tricky that you need to take "-" and treat it as the standard
> input stream in either argv[1] or argv[2] (but not both).  If would
> be a different story in an end-user facing program, but because this
> is a test helper, feeding wrong input is developer's fault, and I do
> not mind lack of attention to detail of error checking to make sure
> we avoid comparing alternating lines of the standard input.

No, you're right, I've added a guard that prevents `test-tool cmp - -`
from failing in obscure ways.

> > +	for (;;) {
> > +		int r0 =3D strbuf_getline(&b0, f0);
> > +		int r1 =3D strbuf_getline(&b1, f1);
> > +
> > +		if (r0 =3D=3D EOF) {
> > +			fclose(f0);
> > +			fclose(f1);
> > +			strbuf_release(&b0);
> > +			strbuf_release(&b1);
> > +			if (r1 =3D=3D EOF)
> > +				return 0;
>
> If both hit the EOF at the same time, we know they are the same, OK.
>
> > +cmp_failed:
> > +			if (!run_diff(argv[1], argv[2]))
>
> If one of argv[] was "-", then this wouldn't work correctly, as the
> other file is read from the beginning but the "-" side have consumed
> the initial part of the input and we cannot unseek it.  This bug
> needs to be fixed only if we expect a useful and reliable output
> from the helper.

Right. I've added a clause that says that we cannot show the diff because
`stdin` has been consumed already.

> But otherwise the idea is sound.  We compare them line by line,
> using strbuf_getline() to ignore differences in CRLF and LF that
> originates at 4d715ac0 (Windows: a test_cmp that is agnostic to
> random LF <> CRLF conversions, 2013-10-26).  Only when we find the
> input different, we use "git diff --no-index" to make the difference
> (and unfortunately more, as it does not ignore CRLF <> LF
> differences) visible.
>
> > +				die("Huh? 'diff --no-index %s %s' succeeded",
> > +				    argv[1], argv[2]);
>
> Nice attention to (possibly irrelevant) detail here.  I would have
> ignored the return value and reported "they are different" at this
> point, though.  The line-by-line comparison we did was the
> authoritative one, and "git diff --no-index" is merely used for
> human readable output.
>
> In any case, "test-tool mingwcmp" would be a better name that
> highlights the spirit of 4d715ac0 to ignore CRLF <> LF issues.  IOW,
> it does a lot more than "cmp" replacement, and we shouldn't mislead
> users/developers into thinking it is a plain "cmp" replacement.

Fair point. The Unix tool `cmp` does not care about line endings at all,
so when you come from a Unix background you will expect the same to be
true for `test-tool cmp`.

On the other hand, you will expect the same to be true for `test_cmp`,
too, which is not the case, and the root cause of why I had to come up
with 32ed3314c10 (t5351: avoid using `test_cmp` for binary data,
2022-07-29).

Having said that, I agree that the test tool name should reflect better
what the subcommand does.

I do dislike the proposed name `mingwcmp`. Not only because it is
misleading, as the purpose is not to compare MINGW-specific files but
instead the purpose is to compare text files (and, in fact, the tool works
just fine on Linux and macOS, too). But also because it would contribute
to just how much of a second-class citizen the MINGW-based build is in Git
land: From choosing to implement large parts, including the entire test
suite as well as the performance benchmarks, in POSIX scripts (which plays
to Windows' weaknesses in a big way) to massively favoring spawned
processes over multi-threading (which plays to Linux' strengths and to
Windows' weaknesses), to a still-inherent assumption that the underlying
filesystem is case-sensitive (think: branch names), to an implicit
agreement in the core Git community that patch contributions need not take
care of working well on Windows (but that that's the job "of Windows folk"
instead). This is kind of at odds with the fact that we must assume that
half of Git's users are Windows-based (we can only assume, based on
surveys, because we successfully avoid any kind of even opt-in telemetry
that would give us hard data). I definitely want to stay away from making
that second-citizenry even worse.

So I am going with the name `test-tool text-cmp` instead.

Thank you for your review,
Dscho

>
> Thanks.
>
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 7726d1da88a..220c259e796 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1546,7 +1546,7 @@ case $uname_s in
> >  	test_set_prereq SED_STRIPS_CR
> >  	test_set_prereq GREP_STRIPS_CR
> >  	test_set_prereq WINDOWS
> > -	GIT_TEST_CMP=3Dmingw_test_cmp
> > +	GIT_TEST_CMP=3D"test-tool cmp"
> >  	;;
> >  *CYGWIN*)
> >  	test_set_prereq POSIXPERM
> >
> > base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
>
