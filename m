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
	by dcvr.yhbt.net (Postfix) with ESMTP id 730821F461
	for <e@80x24.org>; Mon, 24 Jun 2019 10:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfFXKtB (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 06:49:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:45943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfFXKtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 06:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561373335;
        bh=/YLgmKyh+TmHHd/5fcgEvac1CeMJnk3lgEGBjpGn3rc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J17SLaC22NQDvp/pkv3kcW/mOWT0QbpZvIjcJp3DdhgFKyb0EG8IYXER8cqSKSWFD
         h38MOUlxfkH9l11tzJ2LofZT7RQWu2B0k0CG2YZehv4tHagoOuQCYJ+L2grt8964N3
         QFvAw1/YzLmvUlLU+b63HZPU8gvxVjmZc147Cry8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQkE-1iRhv5062y-00vQVF; Mon, 24
 Jun 2019 12:48:55 +0200
Date:   Mon, 24 Jun 2019 12:49:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Morian Sonnet <moriansonnet@gmail.com>
cc:     sunshine@sunshineco.us, MorianSonnet@googlemail.com,
        gitster@pobox.com, gitgitgadget@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] submodule foreach: fix recursion of options
In-Reply-To: <201906221054.x5MAspEQ003711@linux-5.fritz.box>
Message-ID: <nycvar.QRO.7.76.6.1906241241080.44@tvgsbejvaqbjf.bet>
References: <pull.263.git.gitgitgadget@gmail.com> <pull.263.v2.git.gitgitgadget@gmail.com> <c46e5bd1403b45d25192220ce689fcd55d897981.1560371293.git.gitgitgadget@gmail.com> <201906181515.x5IFF8bg005587@pool-147-74-zam859.wlan.kfa-juelich.de>
 <nycvar.QRO.7.76.6.1906191928420.44@tvgsbejvaqbjf.bet> <201906221054.x5MAspEQ003711@linux-5.fritz.box>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:v+VrdyjKpOFprBdDjigYHFoQtKP/bucPds7pZvGcen5h4IsESn/
 XW6LPVzAiuiigGgCbQcQOGt9viZ7moN23wVByjCtC5y9370Ed4dOClem7M4jx1Iny+VyEea
 VpSz/mUexLZxoK5cDt08kKbzJVhkve4r95cRMhk0RHjVXeG9uzbr2iL2iWAr3wDtwAfQAnu
 2HK0eFCmuMpgTdmaSw9uA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kmA0Ww+I0js=:+8cWZDL9UZwy7R6515d4Kt
 CraxLSVHGeTMOV5nItI31XkqvgrgvpXLXedYAr+0OCGIqLrowTSs/Cg4+tNTgn6KlsTBa1cN0
 XzLrtCqIoYoRUtsQpM0B7bzz3Bf9YDgbbnK+lXsTsbc6vdyg0OfwO9F504RJ/BP0hjwJptRdo
 3vQqKjxtbjb6vVa98nVU48QuQI508SQJ7f4tDTD+cM7oHnb3iB0a5+ypzpG6WumSDdkBV/KCT
 2IV+J48TI3KD+5ilZyadkbYfxMZ5BdVkucoV0QzUdn6C/Fjzh/fB2FoeIwzuGWU7R6h1p/Yes
 SOk4y8jOZ37T7Mpcj1nSMRxeHFyDGAyxcmrVxAP6320DyGpn3e3MAF3Q48cO3Ew17TC3/4GwT
 bgT0O1b9vAmfvxfDpfpvqTGG41C/D30tLDCW/y6l32rUhGcgdSKd6oS88fvQncjeKY3yPaAkv
 1BCWb3t0aWpL5ysKPifaQ28TZFqGGm3oBlszO9m+Kb+AEN/N/WxreJBepghwCllm/zCbeURNm
 1kZLSwBtGP5Ui7lCc92hlUnAC0wmTvgm1rPYBUZsbPt544WtJdlKAvDb62KupMuBOhNGri06F
 XnSej8eFPxtE2JyiAhtQkk2AZt1soeVrRLgHtW6S8RhvIvLOnWISJ7K1212dWFnWQKNckpXgk
 cy8hCn9DK/Ua5rOxMOXwcMipJxUqVYm60MwRDGvJPNdiomc81zYl63JwuPfAsC+lqardyn94u
 nSxE8ur+PPZP+8EsaOKcG6pAqrSmY50wEBZVY5VhC88cgZMl9CHPq6ero24Fx/mIST7BRsO6x
 eCQhpXake0WoYMnviyZN0KuvJEFYjMz7PuPvUq1sW1QOtI4z2Qfhq+TE50QGf5ZjH9B51avM2
 P14SFKuaLCaCaX+aoeYTTgQamlw8/j2j9Jjjcb8tWCL4JRGITfgJWMa/5tHHusJoRROfTzEq+
 6ecGjkugeVVtDMn2f7fF0xLKIQlHxW0V0kKWF9dLLkDYx/2oh7Fiq
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Morian,

On Sat, 22 Jun 2019, Morian Sonnet wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Tue, 18 Jun 2019, Morian Sonnet wrote:
> >
> > > "Morian Sonnet via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> > >
> > > > Calling
> > > >
> > > >     git submodule foreach --recursive git reset --hard
> > > >
> > > > leads to an error stating that the option --hard is unknown to
> > > > submodule--helper.
> > > >
> > > > Reasons:
> > > >
> > > > . Above call is internally translated into
> > > >
> > > >     git submodule--helper foreach --recursive -- git reset --hard
> > > >
> > > > . After calling
> > > >
> > > >     git reset --hard
> > > >
> > > >   inside the first first level submodule,
> > > >
> > > >     git --super-prefix <submodulepath> submodule--helper \
> > > >       foreach --recursive git reset --hard
> > > >
> > > >   is called. Note the missing --.
> > > >
> > > > . Due to the removal of PARSE_OPT_KEEP_UNKNOWN in commit a282f5a90=
6 the
> > > >   option --hard is not passed to
> > > >
> > > >     git reset
> > > >
> > > >   anymore, but leads to git submodule--helper complaining about an
> > > >   unknown option.
> > > >
> > > > Fix:
> > > >
> > > > . Add -- before the command to execute, such that now correctly
> > > >
> > > >     git --super-prefix <submodulepath> submodule--helper \
> > > >       foreach --recursive -- git reset --hard
> > > >
> > > >   is called.
> >
> > This is a good explanation, even if the format is not exactly close to=
 the
> > existing commit messages ;-) If you look e.g. at
> > https://github.com/git/git/commit/e5a329a279c7, you will see what I me=
an:
> > there is much more "prose" (and less bullet points) going on.
>
> Ok, I see the differences. Shall I adapt the commit description?

Well, I would if I were you ;-)

> My test so far was designed to not actually check whether git reset
> --hard has shown any effect.

Right, but the test case's title suggested that...

> Taking the test "test "foreach --quiet --recursive"" and the test
> "option-like arguments passed to foreach commands are not lost" for
> example, I suggest the following:
>
> 	git -C clone2 submodule foreach --recursive "echo be --hard" > expected=
 &&
> 	git -C clone2 submodule foreach --recursive echo be --hard > actual &&
> 	grep -sq -e "--hard" expected &&

Please without the `-sq`.

> 	test_cmp expected actual

Sounds good to me, especially with this suggestion:

> As final comment: One could change the flag --hard to something which
> will definetely never be an option flag for both, echo and git submodule
> foreach, e.g.  --this-will-never-be-an-option.

Personally, I'd go for `echo --an-option`, and yes, you are absolutely
right, the intention of your bug fix is not so much to fix the recursive
`git reset --hard` as it is to fix _any_ recursive command with
command-line options.

To be honest, I had missed that `git submodule foreach --recursive`
executes commands even in uninitialized submodules... I could even see how
some users might consider that behavior a bug... are you sure this is the
case? Is this `echo` really executed even in `nested2`?

Ciao,
Johannes
