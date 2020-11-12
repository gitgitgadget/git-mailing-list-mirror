Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F9EC5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17BE20A8B
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KfhZNrdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgKLOFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:05:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:43571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgKLOFG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 09:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605189901;
        bh=nx12jBQgYhiNHEQhMOCctWIhp0CglQr9jMRCF459CJU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KfhZNrdTXCmwM3iJwILI2HLBgvzRLpZoYxOpQOsyVpHMrMXp5Wu+xB8a5vtUY0nAm
         XtBnJdZ6NoVd8UyHAN3fONTpx5PlKnVml2utW1RVaFzRHCZm607RAoSAE6TWkQClFk
         64E6KqwE40+R3+MBfj09jigGNNj67882vS5H3/L0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD2O-1k97bK3fCU-00eJBq; Thu, 12
 Nov 2020 15:05:01 +0100
Date:   Thu, 12 Nov 2020 15:04:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 9/9] add -i: verify in the tests that colors can be
 overridden
In-Reply-To: <20201111180713.GC9902@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2011121448550.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <38355ec98f04783367d74e38cda3ce5d6632c7ac.1605051739.git.gitgitgadget@gmail.com> <20201111023549.GB806755@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011111635140.18437@tvgsbejvaqbjf.bet>
 <20201111180713.GC9902@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sqqnFDeYRPVM7e61dVTJHKShtua7EXcD5vyB5k42TyYOuD9vz77
 5K7R6mmKPrxOMGXZFamhjYzodWhWaJCkrxu7duTXmPFsJy22d9UPTQjnznE8WbUYgyl4Jqq
 R5kVQl/4UyZYViWeBr2m8eb+l8V3uGun5WniFoarhC1b0ZleAeizGdRzHge8TflrcGfh4Dg
 J4Pb5o2Gk+NPZiP/PbfnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4KY+ZnLjRfg=:4++1pghrCedWOS7uFLXfmU
 oM+oObh5gpDwnEY9pxedD6G2DiqTnMH4I1loF/Sjd0PK9zoj5l9nrqCeeNmob7faJ8Yc9tGJo
 P7DLip8fsR0hjcoIlQ3M59Nwr7IPNW3yG+NFIL0MuZkLsPgPhW6yDDH9BI+bB6Bj95il734FK
 pMcvaNdBe7e9qbg17bSE0I0HtZpDcAOSkKUwiyX25/7BRpzge/tpzjtPKNMpX5v8RZ+VSGyJr
 vYV+FwkKcsir9O1NmoB1B+eEyALwvaFeUh7O7MrGOGxNDC/T4LqhiD5vV3ejVU1K5WuiJRR0q
 dowlL4EignjvQ/pixc45VUtLFUVWxq1Mp6OCDiYCnvRoLprGwY5kqaBPvqDG/4DyQW/I+m5H1
 +ImGJMdB8+3w8Mh3ZUi8p+WL5tF0+oVT7CZAnuCvfdps5Lc9Dj2hmfo+/uIBiw98WwviHAHKB
 v0ewgav4dzx6PaSJCsDATldwCXx8ljxKGYfx+FHl3rgSV+lfUMtQtg64SsIB8a2GkLdeOssU7
 4xd0mWuKjmm44oqQ6ZYkHwXUAvofgr/fhqxwWY4hW1oPjba+QUtNat4egtQJ9r/0fmfwcxivR
 2vqjrCiuFNWGi6g+l1gs8pJfdRAvHwfO21tqhy5gCcQyF3zWRAowrz8qdHn4yLLj/Yy6csYHS
 UrL4jFLiczQ79fFHB64D5sGgJ4rOIqawVszqyqtyJy19Ncwk0MiM+YmJ8TxmNKLorKrYYYmYF
 zX28lRllidUtaQmMyTgCTuADAl3G+HLVI8C4miZd8e/P4uHRREAUEea73cR/8HEFTYMD0VWrM
 pHtAMO5vPKFrCKOaXB1gVAK36DjnqMucHPF+jSW6t8ToavrzjQRpZxuw34lbqkD4LcAHs3H+A
 MpnlymQZU5Bawch4ASrFOAtqBhW9AdWFRqYc2fPvI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 11 Nov 2020, Jeff King wrote:

> On Wed, Nov 11, 2020 at 04:53:13PM +0100, Johannes Schindelin wrote:
>
> > > If we are using dash, then surely BASH_XTRACEFD does not matter eith=
er
> > > way?
> >
> > It kinda does, though. Dash _does_ respect the `BASH_XTRACEFD` variabl=
e,
> > funnily enough, but does not hand the settings through to sub-shells,
> > whereas Bash does.
>
> Really? That's news to me, and doesn't seem to trigger:
>
>   [bash uses it]
>   $ bash -xc 'BASH_XTRACEFD=3D3; echo foo' 3>trace
>   + BASH_XTRACEFD=3D3
>   foo
>   $ cat trace
>   + echo foo
>
>   [dash does not]
>   $ dash -xc 'BASH_XTRACEFD=3D3; echo foo' 3>trace
>   + BASH_XTRACEFD=3D3
>   + echo foo
>   foo
>   $ cat trace

Gaaah! I totally forgot that `BASH_XTRACEFD` is only heeded by BusyBox'
ash (and only when built with `ENABLE_ASH_BASH_COMPAT`), not by `dash`.

Sorry for the noise.

> > Oh my. I really had tried to avoid going _this_ deep. The `.meta` sett=
ing
> > is not even read by the interactive add command:
> >
> > 	$ git grep -w meta git-add--interactive.perl add-interactive.c \
> > 		add-patch.c
> >
> > comes up empty.
> > [how and why add--interactive.perl reads color config]
>
> Hmm. Right, I knew about that weirdness. But I assumed that the builtin
> add-interactive was doing the diffs in-core. Otherwise, why would we
> have seen the failure to load diff.color.frag in the first place?

Oh, that's easy to explain: as you can verify reading
https://github.com/git/git/blob/e31aba42fb12/git-add--interactive.perl#L88=
5-L898
the Perl version of `git add -p` insists on (re-)constructing the hunk
headers manually, and obviously it needs to color them manually, too. And
https://github.com/git/git/blob/e31aba42fb12/add-patch.c#L649-L672 shows
that the built-in version of `git add -p` slavishly follows that practice.

> Philippe's simple example just did "git add -p". So now I'm doubly
> confused.

Right. I should have been more precise in what parts are used of the diff
that is colored via the internal diff machinery. The hunk headers are not
used. The hunks themselves are, unless edited. The file header is, too:
https://github.com/git/git/blob/e31aba42fb12/add-patch.c#L683-L714

> The answer seems to be that render_hunk() always _replaces_ the colors
> we got from running the external diff. Whereas the perl version only
> applied coloring when reading back in the results of an edit operation
> (and likewise used the frag color when generating a split hunk header).

No, the Perl version also insists on applying `fraginfo_color`, see
https://github.com/git/git/blob/e31aba42fb12/git-add--interactive.perl#L88=
5-L898

> I'm not sure that what the builtin version is doing is wrong, but it
> seems like it's putting a lot of extra effort into parsing colors off of
> the colorized version. Whereas the perl version just assumes the lines
> match up. I do wonder if there are corner cases we might hit around
> filters here, though. The lines we get from a filter might bear no
> resemblance at all to diff lines. The only thing we require in the perl
> version is that they have correspond 1-to-1 with the unfiltered diff
> lines in meaning.

They do have to correspond 1-to-1 because the assumption is that the
individual lines will then correspond one-to-one, too. This does not need
to be true, of course, but then the filter is probably less useful than
the user wants it to be.

> > For those reasons, v2 brings more changes than I had hoped for. In the
> > end, it is a better patch series, obviously. So even if I was reluctan=
t to
> > work on all this: thank you for prodding me.
>
> Heh. Sorry and thanks, I guess? :) I'll try to read over v2 carefully.

No need to be sorry on your side. _I_ am sorry that I did not add that
test case during my re-implementation efforts in the first place.

Thanks,
DScho
