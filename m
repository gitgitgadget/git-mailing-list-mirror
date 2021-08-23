Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7493C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B562661378
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhHWUAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:00:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:39973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhHWUAy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 16:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629748803;
        bh=AcCGQ5loyvVEkgKfo+tJMPaO/Bm79DdRHoKS+tWPmrE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bRza1ota2bf+Lsbxel1sBekgdDYEjlEQRhlSiX2gP50cPacHQg/OjO2yw+Qj/oR9p
         uHDQLw0Yy7/k9T/m7al6zC0l8IJoNDCvJlktnf8G5PNRqp8QrpK5j9MMu1X8QooBhO
         UWc253l/H7sefqvKAmMsNAN8T/B5lcJy+XC9JanE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1mRmDv3Qfd-00RmqJ; Mon, 23
 Aug 2021 22:00:02 +0200
Date:   Mon, 23 Aug 2021 22:00:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 8/8] sparse-checkout: clear tracked sparse dirs
In-Reply-To: <CABPp-BFUoPQUQDRaRj3Rq2gShOD8WPv6Oh-Wdj4m-7sf=okY6Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108232158420.55@tvgsbejvaqbjf.bet>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com> <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com> <febef675f051eb08896751bb5661b6deb5579ead.1629206603.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2108191015260.55@tvgsbejvaqbjf.bet>
 <CABPp-BFUoPQUQDRaRj3Rq2gShOD8WPv6Oh-Wdj4m-7sf=okY6Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YsJwi05QWo+VR6EAWtv07LIBLzhInwQIOttw6HQ63aJLX9I39Xh
 kiWyXX/v+Lm2f3oZJ8Wco2zO9R2NU7CJNuqsujWDbWTxvhov3x4eky0z6wQXIgFAsTf94zs
 M4pk4Uf0jQxp75wcBf1h3jHh80Fki4/YjTF1gFJFq2g84Ve3pb8ioJvdjoyChesZr2kiRrd
 Uzx4DayOYETDVVvw442rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6GMWYI3z7mA=:5BNg2Y33udHjbrLDZ0k3JM
 oeh9eEsY/FdURE2yb3q9y9nowAbXrxnTDdiHs/Ob17uon2RwoAYElnHpZbKS2mrgzVSWy6wsL
 yYuo6q2U94hpy4Gbpbo55tZcuWhmcngt9mutRdUjCucihcifu1spicdhmN96B6KBwLqLOP0CP
 u3V0A3IuHEHJx46JSqXfZfuhBwFgSYF23Ni5X55r4YOyS2XTfrPBXQ6u309+4iFwKIuCvEper
 TUhDM6y61CxYOdm0W1IIYgNOfJN9QWK9s9nXtbd2apmerF1nrIS0Ko57ntsTYcU+gHvNQDUTj
 KDLRb3rAsezCqlMZFFHJn8SPqFz2PBw2aELmHkvc3YNy0LOkUZFa9Avj7WDKW/WN5EYf9FC87
 S6pXYfihAB3wcXyVCNJiROYaWe/loioL9mNgryqTWp9GSQIfSX6ewBPbfVtAkQezVYIyAZU9R
 VmTMGmw+/F2xiWSouWGBU5euGHVGaMktFYIyYFmeeAc3vsn9Y2VIYhCO9jF573Fs3MIatxzgF
 y2QFpMCB1zaucorK4DcWP0SdddgxEmU5s7l0avE0/jT+lhnyGImBuwPuLR8hO8kf5LAYcSy4j
 eB8+oTQE2qig7qmVsK7g29DLH9iMMbJHRQhV0f3/E5ywgl8P2NHD0B1et+KFqA/KxQBvDKYnu
 XPU5rRO8o7lkk8sK9AWEfHH53bPf6hDgsJzbfSLueeMjjlVjfm4giVGet4T+GDsWEETsOVucK
 nMgAXaWR+NJ2dywx1DcuPms1oL5ti0WzJiCKyFl27TVGYV4QyLoEx1Vv0/zIIcfCoKHnKGTA4
 T+qvqjWMst/Xkm5MPiK4pbwwOH0i16mlHRd/s2KszaYKWxyXHydJqCmOcBdvNDCmgA6Eh+Q8K
 mn4efgWPw6/1lBdxlwuuxZL9z6O2l9v5GDe0yT1Tu6d9IdldcW4Yn6zxmnohsfXfpAYn71ju6
 Z84mmbtd2mHtL+ucKN9yBC28l+zsz/A4hFWcfK/2NCTqNbP1tUkOKNt/Yuom3HTHeyqtIXXir
 MbEYbsO9YlPTn2TvKp76wml5LH2F+G7gMBu0W63SIXiVvR0IHBlvFELO8/kX5hthA+zmAq0vd
 f/1HY8QZ4PsUxtsBkMIzJkOnVqhik1Rve96jogorTJStjuHhDMkr9Jhlg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 20 Aug 2021, Elijah Newren wrote:

> On Thu, Aug 19, 2021 at 1:48 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Having said that, even after mulling over this behavior and sleeping
> > over it, I am unsure what the best way forward would be. Just because
> > it is easy to explain does not make it right.
> >
> > It is tricky to decide mostly because "ignored" files are definitely
> > not always build output. Apart from VIM's temporary files, users like
> > me frequently write other files and/or directories that we simply do
> > not want to see tracked in Git. For example, I often test things in an
> > `a1.c` file that -- for convenience -- lives in the current worktree.
> > Obviously I don't want Git to track it, but I also don't want it to be
> > deleted, so I often add corresponding lines to `.git/info/exclude`.
> > Likewise, I sometimes download additional information related to what
> > I am implementing, and that also lives in the current worktree (but
> > then, I usually am too lazy to add an entry to `.git/info/exclude` in
> > those cases).
>
> I do the same thing, and I know other users that do as well...but I
> don't put such files in directories that are irrelevant to me.  I create
> cruft files near other files that I'm working on, or in a special
> directory of its own, but not under some directory that is irrelevant to
> the areas I'm working on.
>
> For reference, we implemented something like this in our `sparsify`
> wrapper we have internally, where 'git clean -fdX <all sparse
> directories>` is executed whenever folks sparsify.  (We have our own
> tool and don't have users use sparse-checkout directly, because our tool
> computes dependencies to determine which directories are needed.) I was
> really hesitant to add that cleaning behavior by default, and just made
> it an option.  My colleagues tired of all the bug reports about
> left-around directories and made it the default, waiting to hear
> complaints.  We never got one.  It's been over a year.

It is really nice to hear that you have evidence from users using this in
practice. I find that very convincing, and it weighs much more than all of
my (very theoretical) considerations.

Thank you,
Dscho
