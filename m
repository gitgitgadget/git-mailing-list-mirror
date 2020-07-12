Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1A4C433E0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 12:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046D0206F0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gu0Cv900"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgGMMFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:05:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:35213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgGMMFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 08:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594641931;
        bh=fBiVkRe0rFhm/uAEnYppqaMQ0BxLQeM/PQwL4kCJDMY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gu0Cv90052GYa0DxncoGcRA3vXOIg9A2fOTWOiqWViIy64r3dt6Lsiy4kzHAraAbM
         w4AYjIxh92BO5FLtiqqQhQ5UYNflDRgoBMfqQLah0sgEwOg2r1kg9pOtmts7VmGqiZ
         Zgr03HUImvqOd7XgKAMQVkHPgVI7dHTK5zhtbRe4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.26.78] ([89.1.215.195]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTRN-1kG4bO21tF-00NTAT; Mon, 13
 Jul 2020 14:05:31 +0200
Date:   Sun, 12 Jul 2020 02:46:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, pc44800@gmail.com, stefanbeller@gmail.com
Subject: Re: [PATCH 4/4] submodule: port submodule subcommand 'summary' from
 shell to C
In-Reply-To: <20200706111559.GA10820@konoha>
Message-ID: <nycvar.QRO.7.76.6.2007120230400.50@tvgsbejvaqbjf.bet>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com> <20200702192409.21865-5-shouryashukla.oo@gmail.com> <nycvar.QRO.7.76.6.2007031712160.50@tvgsbejvaqbjf.bet> <20200705173458.GA5204@konoha> <0a2e53d4-7fc5-183d-663d-7a8f52b2a685@gmail.com>
 <20200706111559.GA10820@konoha>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bpnhWrj0GZLEJe/YeC4Z0ot8tVbzDSmi4JYTpgzLspZnbUVc061
 4jItBix/YY7FnrehjPrcEwGjdvWBauGobOFijRETK3IviHMiuMSmBSyK9fC19THbFw9xWiq
 A8kNaXl6XGynxNNnek7XaCtW+1vhuy9LPTukOGRNaa3u5FsXZKkUbkzEKCH8CQNDeu1j/w6
 G44SZFg+ZBEZWYPLorK9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6RWwrQJR8lQ=:X+Ropndj6M07YdHpvE0qtl
 ZCYGEnUO8aG+NbN8zTY15O+fvFCu/xoN5rM1ihcvvMlWK6UW+3EcBuMfD6pvyWQZ2yUMdX0of
 +vhNfKmfeWeGzPt4aPF/Ct4Mu3ftUa/fT7sxlX/mz1j3BsLmq+D+phKYPAUaoh7GlSXzV1LZt
 h1YBGZgUdwNNN97XLWAZX0XPc/w++Tj2U2Ew8Asgtd8DILYcwa4IjqbR4KPzLfaMk5xy96Pya
 onM85UEL3ZV15gduktuAmI7uGG/8US7u85XEpOo3OPnX0Kgfx2P6S1jbacXEn3dj4vhkpsRe7
 8zws2jKHAbj5s8jV3DPJAFPlKOPo9HiuecmNgJp9lJb2NsmmuMeQZqW+LyKPYEexMnLG9Hue2
 gW7/RCCoJQ0YwEQESKOhORw3mahnIEdiXgvW/NULqqfH7+tUQa41XVit9BMDEajLKB4ZPRBMq
 xQhzyLEtHFHX40NyKM6O5jOjptu6eDNrTdGqKek23TjINBvZOqW7FDZ8HDxTRTR1nYrm1tGlN
 GohIJhoSTA7uRMJX6c+XFstu6d/Duh0P1ypR1G9T/7MntrZPCw6c3jLkpwywCwdJxdh+MpsA0
 t8yoe231PjOBE8xVz/winkqNpu4LTAMsy39t7TXeDNioqYeGiz6YOchLPcFbjZn8Jq+AbZyLU
 bsI98PSXewY7WLruHu2qomg+jRVHQOGM3uhTCAK3mRyMZOWNOPnc4PvLU7oZc+dLkrlbcUYRC
 GL322C6jfHESyIIPIsFSWdTqL+I+SgzCR3ARTcLHn4sqWc5+vJRzyJj63eqCk+rm7ftWidoRj
 8gVfqGiAq1mQXIUxFPnQq8vN8+8XYPXkZAnPQ5ERQe/vZZoJ9AfO4ltbUBnmx8anEv3RSt2hx
 qA0StrD/arAcqIly9BeiDS3kqv0JbIFfUaUsv+TSgn3fQoKP0KDmBv9UV240DKLCG6PlONugu
 vVILjkSEXjBn6F/COkgNwcRkw3dz/qTYqNiPwJsWgthtuUAr/YaNJ9uKqceymJ3VLPyEra849
 hy/tMvoBk0mGcGTO29km7x5Va+7RcolvDpJO0vSw5n3mgfwsDfRNOflHThNF4yPs4qPDkGeiu
 Ay1yNuklMJMWyuml1wVU8x4CP5mpuuo2AKO7yMwRL1L5X6LcKlSkYWjTMZ12UbQCekGDppDtT
 cjkptxfyJNG//Kdt1u359ZgOl98n3IMY+53+RGSj3fI9i/3Vefv5OI22DhgfIN4YJbAAHsb+x
 1+u6OZUwJ/aMbBsFJU8GWlwMrG5gl33pYCiG3Ag==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Mon, 6 Jul 2020, Shourya Shukla wrote:

> On 06/07 02:46, Kaartic Sivaraam wrote:
> > On 05-07-2020 23:04, Shourya Shukla wrote:
> > >> On Fri, 3 Jul 2020, Shourya Shukla wrote:
> > >>
> > >>> +static int module_summary(int argc, const char **argv, const char=
 *prefix)
> > >>> +{
> > >>> +	struct summary_cb info =3D SUMMARY_CB_INIT;
> > >>> +	int cached =3D 0;
> > >>> +	int for_status =3D 0;
> > >>> +	int quiet =3D 0;
> > >>> +	int files =3D 0;
> > >>> +	int summary_limit =3D -1;
> > >>> +	struct child_process cp_rev =3D CHILD_PROCESS_INIT;
> > >>> +	struct strbuf sb =3D STRBUF_INIT;
> > >>> +	enum diff_cmd diff_cmd =3D DIFF_INDEX;
> > >>> +	int ret;
> > >>> +
> > >>> +	struct option module_summary_options[] =3D {
> > >>> +		OPT__QUIET(&quiet, N_("Suppress output of summarising submodule=
s")),
> > >>> +		OPT_BOOL(0, "cached", &cached,
> > >>> +			 N_("Use the commit stored in the index instead of the submodu=
le HEAD")),
> > >>> +		OPT_BOOL(0, "files", &files,
> > >>> +			 N_("To compare the commit in the index with that in the submo=
dule HEAD")),
> > >>> +		OPT_BOOL(0, "for-status", &for_status,
> > >>> +			 N_("Skip submodules with 'ignore_config' value set to 'all'")=
),
> > >>> +		OPT_INTEGER('n', "summary-limit", &summary_limit,
> > >>> +			     N_("Limit the summary size")),
> > >>> +		OPT_END()
> > >>> +	};
> > >>> +
> > >>> +	const char *const git_submodule_helper_usage[] =3D {
> > >>> +		N_("git submodule--helper summary [<options>] [commit] [--] [<p=
ath>]"),
> > >>> +		NULL
> > >>> +	};
> > >>> +
> > >>> +	argc =3D parse_options(argc, argv, prefix, module_summary_option=
s,
> > >>> +			     git_submodule_helper_usage, 0);
> > >>> +
> > >>> +	if (!summary_limit)
> > >>> +		return 0;
> > >>> +
> > >>> +	cp_rev.git_cmd =3D 1;
> > >>> +	argv_array_pushl(&cp_rev.args, "rev-parse", "-q", "--verify",
> > >>> +			 argc ? argv[0] : "HEAD", NULL);
> > >>
> > >> Oy. Why not simply call `get_oid()`? No need to spawn a new process=
.
> > >
> > > Then everytime we need 'rev-parse', we simply call 'get_oid()'? That
> > > will save us a ton of processes?
> > >
> > > But I think we do need to capture the output of 'git rev-parse --ver=
ify
> > > ....' so I think it will backfire to use 'get_oid()' or am I just be=
ing
> > > too dumb and not catching on something?
> > >
> >
> > I'll leave this for others to answer.
>
> I will resolve this one after Dscho answers then.

The `rev-parse` command _would_ essentially call `get_oid()` and print the
result (after converting it to hex, which you don't need, because the
caller actually would parse the hex string anyway).

You can verify my claim by following the code:
https://github.com/git/git/blob/v2.27.0/builtin/rev-parse.c#L956-L982 (it
is slightly harder to follow because the `--verify` option makes sure that
only one rev is shown, which means that the `get_oid_with_context()` call
is separated from the corresponding `show_rev()` call).

So there really is no need to capture the output of that `rev-parse`
command.

It is a different story, of course, when capturing the output of Git
commands _that are run in a submodule_. Those currently still need to be
spawned.

> > >>> +
> > >>> +	if (!capture_command(&cp_rev, &sb, 0)) {
> > >>> +		strbuf_strip_suffix(&sb, "\n");
> > >>> +		if (argc) {
> > >>> +			argv++;
> > >>> +			argc--;
> > >>> +		}
> > >>> +	} else if (!argc || !strcmp(argv[0], "HEAD")) {
> > >>> +		/* before the first commit: compare with an empty tree */
> > >>> +		struct stat st;
> > >>> +		struct object_id oid;
> > >>> +		if (fstat(0, &st) < 0 || index_fd(&the_index, &oid, 0, &st, 2,
> > >>> +						  prefix, 3))
> > >>> +			die("Unable to add %s to database", oid.hash);
> > >>
> > >> Umm. The original reads:
> > >>
> > >>                 # before the first commit: compare with an empty tr=
ee
> > >>                 head=3D$(git hash-object -w -t tree --stdin </dev/n=
ull)
> > >>
> > >> It does not actually read from `stdin`. It reads from `/dev/null`,
> > >> redirected to the input. And what it _actually_ does is to generate=
 the
> > >> OID of the empty tree.
> > >>
> > >> But we already _have_ the OID of the empty tree! It's
> > >> `the_hash_algo->empty_tree`.
> > >
> > > I did not know this 'the_hash_algo'. I will use it. Thanks! :)
> > >
> > >> I hope that this is covered by the test suite. Please check that. T=
he test
> > >> would succeed with your version, but only because tests are run wit=
h
> > >> `stdin` redirected from `/dev/null` by default.
> > >
> > > I guess yes. My work passed because the tests are written this way.
> > >
> > >>> +		strbuf_addstr(&sb, oid_to_hex(&oid));
> > >>> +		if (argc) {
> > >>> +			argv++;
> > >>> +			argc--;
> > >>> +		}
> > >>> +	} else {
> > >>> +		strbuf_addstr(&sb, "HEAD");
> > >>> +	}
> > >>
> > >> The conversion to C would make for a fine excuse to simplify the lo=
gic.
> > >
> > > This was kind of like the 'shift' in shell. What equivalent do you
> > > suggest?
> > >
> >
> > I think that's just a general comment after the other comments found
> > just above about simplifying things.
>
> Alright. But I do have to simplify the logic right?

You do not _have_ to. But it would make for a good opportunity to do that,
I think, as the code is really hard to follow.

The idea here is actually not at all hard to understand, though: use
the speficied rev (falling back to `HEAD`) to compare to, unless it is a
yet-unborn `HEAD` in which case you compare to the empty tree.

It is very, very similar in spirit to the code in `do_pick_commit()` in
`sequencer.c`:
https://github.com/git/git/blob/v2.27.0/sequencer.c#L1765-L1774

The only difference is that you will also have to fall back to using
`HEAD` if the argument in question turns out not to refer to a revision
but is actually the first pathspec.

Ciao,
Johannes
