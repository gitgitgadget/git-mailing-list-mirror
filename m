Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E2AC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 15:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiBVPxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiBVPxt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 10:53:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC957ED86
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645545190;
        bh=aSRvJYc5muASdspb6A9gS/UuElpjrwny/s/GovOhttI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BOOr2uS+yn7h/WSRLBkgwJP+C5csgQRXJBiM7cjgwOej3usQpI7+TslRClxV0cA9D
         IAroyR9urS3p9tydAmjZeAAOWdm+YGC98W5F/zk+xSxTvMns9iKl8VRs81OkMixL1V
         Ky5ZAfOz8+uihAFXHeHjumY2jh3zvNnbFSsnBFWg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hZD-1nHsmK3SVt-004g68; Tue, 22
 Feb 2022 16:53:09 +0100
Date:   Tue, 22 Feb 2022 16:53:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH 06/11] bisect--helper: make `--bisect-state` optional
In-Reply-To: <xmqqh7977rj8.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2202221544300.11118@tvgsbejvaqbjf.bet>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <eddbdde222a01113d8facdcb17d6ec85676edbe7.1643328752.git.gitgitgadget@gmail.com> <xmqqh7977rj8.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QqzWW9BrRkh6SR43Ts+4RjqXkpZTNylt0CZxVfB3dVRqtrMpe7i
 d10UAlUuAUze93Q2pWsLhOqqW+eC5co6yrzAYencBMFVSRNL4I/8Cj9dLVXlogqb2PDH3+8
 X1qlYelMOAe9pgBh/PEkRFBUMkC8QhsfU0zZ/lXqotUnILVv25CuWS13+PivL2/cJa/cWHy
 fr1GudFpcGEPfYcZZmxsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y7O/RfCmfko=:6STRRe35NFxNzbtRWG9bTH
 gCOiATGxBq1xxTuXQF5Ysr9CG/wqXn8RAuVr4DWUW1XewX1Nr9S2a8V3MVhE0C4JjVa+te4dP
 V/C+6CqJgYO4oYSsIRZVlyTdCi3NqL/y4rsV+nO95/EW22VHiMmojdoOfQJg6bJFqoY1iwE01
 1RDkYNDF3FMoIl4/LQVIt1rb1drH6RL4thEvb1KffetVfOnUOXP/kXSQVjGyZRZF7h4/J29ew
 j5WHL0HgrqiLWI1n2Pm1M2yPunC4qcePOkrKSacEf9SlWSUy4P9ZrM5V0k9Pa0p0f5rRbOVPN
 RF6cmbq8ctHn2bEg70CLyQd09OugkNIBQcaPOHa5qBssQB/M0Q5xcwYRRFJuqwfJ9dOhlDA6h
 aTfFEi/AxZ746lS94qLTkoLMh9iu4o9eThKfajfmyNa0tHUBHwNTAOwjEZ7wESvVWNn3exyYx
 EdZSOkkv2LkpQwAYDSCifZKfbMPv2f9i7e8FObbywnVOJyi1SKprwiNecVrRnOr3591qVSWRI
 32DFQLTFoZGXbQgXSkw6Fp/3zNCmCVk6OTC6m4qlVnY0xbmR7Fc1Jqjt5vqjEwD0fhIZBRxen
 mRJf+fy2gcj3XbXXkxOgbArBz0iikfKTkUAMg9rVK/q3S3k9OUL7M4/qV7UpXdNLH8ZVwSn8F
 n4OSvAQSAx6p/qMN/wd9ZKfQHWe5INS/MWP3wl510NNrxg5hRMBwSLIz7RFVUziceNbrAQeP6
 gFlxJa61xDx+NTv/UiRhALtsq9nKspfX8z4URGP5MEDM7H0MKaGmIvmZ/3+sz+uXRcthM8EcR
 oVi1GxDw1XoL/S9VDJ4Oar9MPPjC3avI6/DZCpWUppn+A3T6FKcDOxDBaJUCrnlorN3sd0Y2v
 hpRKHPFFSXjkCG91EFBQlCLbJ10ErRrTB8fmvnlY3ZMuj6el2JzONsSVAusSRpMo/1LL7uOav
 GViPtl1hNZrJn/JyKQUiu1YfkMEXGORdMVvFdKjENqIIYTkQEWJKtve6uOEyZU/XYn1l9oa2v
 cV5+2aipKdy3mySspLaXUSQv3CcjvtA8QO2ld062+YMsXX1viyN3AXSEpx8tF6AjIY276uTkK
 4FFsC12oCNSplw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 9 Feb 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > @@ -1210,6 +1210,13 @@ int cmd_bisect__helper(int argc, const char **a=
rgv, const char *prefix)
> >  			     git_bisect_helper_usage,
> >  			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
> >
> > +	if (!cmdmode && argc > 0) {
> > +		set_terms(&terms, "bad", "good");
> > +		get_terms(&terms);
> > +		if (!check_and_set_terms(&terms, argv[0]))
> > +			cmdmode =3D BISECT_STATE;
> > +	}
> > +
>
> I do agree with "if we want to reuse this function without changing
> it much, --bisect-state must become an optional and the default mode
> of operation" as a goal, but I do not quite get this change.  From
> the rephased description of the goal, what I would expect is more
> like
>
> 	if (!cmdmode && possibly-other-conditions-like-argc-check)
> 		cmdmode =3D BISECT_STATE;
>
> and nothing else.

That would not work, though: we must ensure that the `argv[0]` is a
bad/good term (hence the need to call `set_terms()` and `get_terms()` to
retrieve potentially overridden terms and then the call to
`check_and_set_terms()` to verify that it was one of those terms).

> Between the case where --bisect-state was and was not given explicitly,
> check-and-set-terms is or is not called.  I
> can see that checking would be _nice_ when we try to decide if the
> first token makes sense as good/bad and the user wanted to do the
> "state" thing impolicitly, but if it is worth checking in implicit
> case, shouldn't we be checking when the --bisect-state is explicitly
> given as well?

I tried to keep the `if (!cmdmode) usage...` in place, and that's probably
what caused your confusion. I replaced it with:

=2D- snip --
@@ -1210,10 +1210,7 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
                             git_bisect_helper_usage,
                             PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKN=
OWN);

-       if (!cmdmode)
-               usage_with_options(git_bisect_helper_usage, options);
-
-       switch (cmdmode) {
+       switch (cmdmode ? cmdmode : BISECT_STATE) {
        case BISECT_START:
                set_terms(&terms, "bad", "good");
                res =3D bisect_start(&terms, argv, argc);
@@ -1221,6 +1218,11 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
        case BISECT_STATE:
                set_terms(&terms, "bad", "good");
                get_terms(&terms);
+               if (!cmdmode &&
+                   (!argc || check_and_set_terms(&terms, argv[0]))) {
+                       char *msg =3D xstrfmt(_("unknown command: '%s'"), =
argv[0]);
+                       usage_msg_opt(msg, git_bisect_helper_usage, option=
s);
+               }
                res =3D bisect_state(&terms, argv, argc);
                break;
        case BISECT_TERMS:
=2D- snap --

I am not the best judge whether this is more obvious because I am so
familiar with this code, but I hope that it is at least more concise.

> And the actual execution of the BISECT_STATE command is even more
> puzzling, below.
>
> >  	if (!cmdmode)
> >  		usage_with_options(git_bisect_helper_usage, options);
> >
> > @@ -1218,11 +1225,6 @@ int cmd_bisect__helper(int argc, const char **a=
rgv, const char *prefix)
> >  		set_terms(&terms, "bad", "good");
> >  		res =3D bisect_start(&terms, argv, argc);
> >  		break;
> > -	case BISECT_STATE:
> > -		set_terms(&terms, "bad", "good");
> > -		get_terms(&terms);
> > -		res =3D bisect_state(&terms, argv, argc);
> > -		break;
> >  	case BISECT_TERMS:
> >  		if (argc > 1)
> >  			return error(_("--bisect-terms requires 0 or 1 argument"));
> > @@ -1265,6 +1267,13 @@ int cmd_bisect__helper(int argc, const char **a=
rgv, const char *prefix)
> >  		get_terms(&terms);
> >  		res =3D bisect_run(&terms, argv, argc);
> >  		break;
> > +	case BISECT_STATE:
> > +		if (!terms.term_good) {
> > +			set_terms(&terms, "bad", "good");
> > +			get_terms(&terms);
> > +		}
> > +		res =3D bisect_state(&terms, argv, argc);
> > +		break;
>
> This case arm has been moved but because there is no fall-through in
> this switch statement, the movement is a no-op.  But the code has
> also changed with this patch.  We used to do set_terms/get_terms
> unconditionally, but we do not even do so when terms_good (but not
> terms_bad) is already set.
>
> Is this an unrelated bugfix of some kind?  This does not look
> related to "making --bisect-state optional and implicit default" at
> all.  At least the proposed log message does not explain why.

I had hoped that this part of the commit message would be clear enough:

	To prepare for converting `bisect--helper` to a full built-in
	implementation of `git bisect` (which must not require the
	`--bisect-state` option to be specified at all), let's move the
	handling toward the end of the `switch (cmdmode)` block.

Since my hope did not turn into reality, I split out that move into its
own commit (making the patch series even longer, but hopefully at least
making it more readable, too).

Ciao,
Dscho
