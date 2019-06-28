Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B19401F461
	for <e@80x24.org>; Fri, 28 Jun 2019 11:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfF1Lta (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 07:49:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:56729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfF1Lta (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 07:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561722564;
        bh=EelczYuPrRUMcTXXtviRiiKCe5jy1Jr9GW6ynUGgLsI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FoLQEKnqhHw+bHpFl0Xhi2Xo2yHgEWtI8LoC+m56qZEa2IXHjKTKzVpSzr7JkeRmJ
         08QlS44X9B1hrg4ILsRlFGYhPKw3P3schKjTrRiWK/Q2ZSCu3hjwLTP8gPDBKmXS5m
         VRDXaj4oKhXC5fVYU7seZWhRRgiJygoX+o9lFePE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6Zq-1iD6bN4Ahi-00hgCj; Fri, 28
 Jun 2019 13:49:24 +0200
Date:   Fri, 28 Jun 2019 13:49:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Vas Sudanagunta <vas@commonkarma.org>
Subject: Re: [PATCH 1/1] Let rebase.reschedulefailedexec only affect interactive
 rebases
In-Reply-To: <xmqqzhm2ang5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906281342280.44@tvgsbejvaqbjf.bet>
References: <pull.253.git.gitgitgadget@gmail.com> <fab124da41858b849ae74dfb1fe403bb834870f1.1561623167.git.gitgitgadget@gmail.com> <xmqqzhm2ang5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lbvZUl3JGdQbkaHgMvzZkhFkhLh2LywDFWfz4AYAEnsdWzcAAfc
 FjB5YrTRRtkeLDxWln/Y1UYNLNlOYZ74ONUGEu2j8o9suVBcJbEm+viHOeRn5bb/iGCNUPh
 WLmjm/LdHt0+a71vSthGzsPaF4rQyMvycEGtT8nVD7BWIEIMoxmEhwll0RNiu8NK1uk9ymC
 GCD1Pcy5/sQi7Ibl1Ci5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7qTBIq9Mco0=:s6Kv2wJVOOZsfK/ktG5bvB
 86STQSxhhGyf15UbuLEtAhhrylpsHYZF9oeFbDi8ZObBTKkkT2hPg+AdXtKMf+dGo5tVGvmRT
 PMm2PMPOo7CcSzY5h/xtHqFnJVWPeHRlUcubHA+K8AvDs72wXKhgcQoNrCftbK+uu9cgubh1C
 eylSyouXzey/f56uj7HhRYjWd5RvFQe/Du0d5geCEfu1EnkEk0ZQUZ0h7V9/qxaBOodlPxj9M
 /2qBEhDbi0q8yOBGZ5l7urtxXowuzk7rHKlna6C2z8XQ81XFxdID1WUDbmXcKi6SPTfySFhd1
 tFOPjGj47UROtFnWbBe+swtvfu0yB4oflrLk8OEap73ip9pyo/WW87lFazDx21LFRAL05OrNb
 8Az5y3i2LvhJ5RExwK60eMOcxiTGKyTajfBmeVtd8YzpoaWY7t9L2Dy7k1hW/mMWvp4S2wdZl
 uvIJnM8+DqFW64GxIzmn55OMvtjs2bYLhttCQLxTIwMqYFIQCEU4Xjg7J4eOBQd+jzp8MS2OX
 pBnS6v85xYXy6iJR67rJDhWYUMbawN7VYJHhTf4C+jQDR3Hd5XNBumNDauaKpP9DcFHHcaT4z
 I9afNy2W9Y/71XieSyUPowKVNmb8zhAeLSooPg0WxKRDimpxHgMynHZJKoFM/1zRYerMKyPAz
 1Kh5XLnHc87hzsEnr9yb1ZQoV8Le8ovbU99kWIO3CNZPjkTl1y08BqWfuvvnvPJot4HoqSF7G
 6KsOi68lGVwffejmtI1kmh9NEpX3qw8wYzMYOPooEQ5rCnhLor0YxprEYVb26lVn9pezBgchm
 NNirBqiHq0/i0pSZ4j2dE436Eq/a0bEWP4fkq3OWFLRBLet63Qxrt+oGft061r5LeUQ7/+utO
 R/EBU9A/6ErRUYx5sq9TzdvLoR3bKdTApkvglOlJeImKovBFPvxeAeQmHkR3eW+0j4KMYLvRf
 s0Jtv+Dp+UnNgJj9pEdbIQwY30ZPNDtkTq6jbmP2wJEmHInj3bECt58pF6HxKYA0Z54IDfbml
 4/mgz7WJrZU/+z+yzpyjpFct+fIclPtpECgyU0CDOTLmOlvZbYeblLCTpVfSDfiKrs0IWq3AH
 qVUxBuw2lpL693F1xdOI8mfCFuIsqPj1pRA
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 27 Jun 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > It does not make sense to stop non-interactive rebases when that confi=
g
> > setting is set to `true`.
>
> The reader is assumed to know that that config setting is only about
> interactive rebases, including "rebase -x", which probably is an OK
> explanation.

You're right, it is okay, but could be better.

> The subject needs a bit more work, though.
>
> "rebase: ignore rebase.reschedulefailedexec unless interative"
>
> or something like that, perhaps.

Right.

> > @@ -929,7 +930,7 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
> >  		OPT_BOOL(0, "root", &options.root,
> >  			 N_("rebase all reachable commits up to the root(s)")),
> >  		OPT_BOOL(0, "reschedule-failed-exec",
> > -			 &options.reschedule_failed_exec,
> > +			 &reschedule_failed_exec,
> >  			 N_("automatically re-schedule any `exec` that fails")),
> >  		OPT_END(),
> >  	};
> > @@ -1227,8 +1228,10 @@ int cmd_rebase(int argc, const char **argv, con=
st char *prefix)
> >  		break;
> >  	}
> >
> > -	if (options.reschedule_failed_exec && !is_interactive(&options))
> > +	if (reschedule_failed_exec > 0 && !is_interactive(&options))
>
> OK, it used to be that we got affected by what came from "options",
> which was read from the configuration.  Now we only pay attention to
> the command line, which makes sense.
>
> At this point, we have already examined '-x' and called
> imply_interative(), so this should trigger for '-x' (without '-i'),
> right?

Yes, at this point we have done all the parsing and automatic implying,
and check for incompatible options.

> >  		die(_("--reschedule-failed-exec requires an interactive rebase"));
>
> I wonder if users understand that '-x' is "an interctive rebase".
> The documentation can read both ways, and one of these may want to
> be clarified.
>
> 	-x <cmd>, --exec <cmd>
> 	...
> 	This uses the --interactive machinery internally, but it can
> 	be run without an explicit --interactive.
>
> Is it saying that use of interactive machinery is an impelementation
> detail the users should not concern themselves (in which case, the
> message given to "die()" above is misleading---not a new problem
> with this patch, though)?  Is it saying "-x" makes it plenty clear
> that the user wants interactive behaviour, so the users do not need
> to spell out --interactive in order to ask for it (in which case,
> "die()" message is fine, but "... internally, but ..." is
> misleading)?

Hmm. What would you think about:

  		die(_("--reschedule-failed-exec requires --exec or --interactive"));

?

It is still not _complete_, but at least it should be a ton less
confusing.

> > +	if (reschedule_failed_exec >=3D 0)
> > +		options.reschedule_failed_exec =3D reschedule_failed_exec;
>
> OK, here we recover the bit that is only stored in a local variable
> and pass it into cmd_rebase__interactive() machinery via the options
> structure, which lets the codepath after this point oblivious to
> this change, which is good ;-).
>
> >  	if (options.git_am_opts.argc) {
> >  		/* all am options except -q are compatible only with --am */
> > diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> > index bdaa511bb0..4eff14dae5 100755
> > --- a/t/t3418-rebase-continue.sh
> > +++ b/t/t3418-rebase-continue.sh
> > @@ -265,4 +265,12 @@ test_expect_success '--reschedule-failed-exec' '
> >  	test_i18ngrep "has been rescheduled" err
> >  '
> >
> > +test_expect_success 'rebase.reschedulefailedexec only affects `rebase=
 -i`' '
> > +	test_config rebase.reschedulefailedexec true &&
> > +	test_must_fail git rebase -x false HEAD^ &&
>
> These three lines gives us a concise summary of this patch ;-)
>
>  - The test title can serve as a starting point for a much better
>    patch title.
>
>  - We trigger for '-x' without requiring '-i'.

I changed the oneline to

	rebase --am: ignore rebase.reschedulefailedexec

This gives credit to the implementation details, as appropriate for commit
messages, and the error message still tries to be as helpful as possible
for users (who do not necessarily need to know that there are two
backends).

At this point, I am _really_ glad that we only have two backends left (for
all practical purposes, I don't count --preserve-merges).

Ciao,
Dscho

> > +	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
> > +	git rebase --abort &&
> > +	git rebase HEAD^
> > +'
> > +
> >  test_done
>
