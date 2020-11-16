Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB827C8450D
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6204D20855
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bZ98bwp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgKPMTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 07:19:17 -0500
Received: from mout.gmx.net ([212.227.15.15]:36485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgKPMTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 07:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605529149;
        bh=WfcFUT+UTR0ofGha5G3a2QsVnvExwp6SUu/hmPkYgJs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bZ98bwp5IV5GLIVin6xImtICXKBuWZURSMPYcvkqEMj+4euQNy/gfxzBgnapsns/s
         tdstiGc/8vGyvzgMMt5QFF01a9VR2J9bFfg7kBI1T5zR0UjrBKXS+jRHNCPfRAuZPY
         X9n5XfwzSxmmhk7PWfRugj3gD6qLhjCV+T2J85Rs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.61]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1jtB9u1R9b-00oapl; Mon, 16
 Nov 2020 13:19:09 +0100
Date:   Mon, 16 Nov 2020 01:02:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 10/11] add -p: prefer color.diff.context over
 color.diff.plain
In-Reply-To: <4ad92124-de1f-df66-093b-5089ad111cb7@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011160057560.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <pull.785.v2.git.1605097704.gitgitgadget@gmail.com> <48d8e0badfec5f0e576868f7a406ed7ede6c7200.1605097704.git.gitgitgadget@gmail.com> <4ad92124-de1f-df66-093b-5089ad111cb7@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KrqlI2seZVXcVzNjm+KWN3mP7/RO/zxX8rquIrLaIS7eL70h6x7
 AzkwTUfxifp5n9MU76SJ/icKJ4ELeniwox5zR9MMQmQk9FjPjre6cVhyNMDsfG40xNjh7sm
 zuW6y6dNHwGNZHFgrZQc6o29bQqKgv++9w8whTYT25zg2sF2Ugalf1ChTkXUHsr+Ib3fwOA
 GWBO7nKzczMLcBKwLcVNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q9qYr3UjSBc=:2+zRFH+AbMCGOXyxI1Kz+F
 lNfW3RRez021Bl5aMs4Av6BTM/7cel8Ssu7zGCJFRLzZbPNdqzDExj9uOUP41d8WxzV+FEXdW
 Ggy20OUPPDwL2uNBxKeP+19+iNFxYb33we98JWA7fnH/Q9O1jIjIo+tFZ3lkQcC32PA8ZsglT
 dGSSrKIfoFa7GAZQA6Ooyk2cdu4sZi4ZmtA5BIwFJzag3IJtkZVZfQGqzCmSdt/C2xJXVsYp3
 o6AJqkJfegV7Wf7VQUh0rBClFhyOLQ0eoUdfOdYv4yxseBC2luSZskZUuguqqIeyqRhcW1ep0
 AA5fuXJOLQljCF0uNoUCYaqYY85WYE0QswP/NNaY7i4xUKXAE/g25tcw2LyCLI+BDF3hC/MYz
 7/BybvIYE3zR5fYhCjVH5lEJpQ70F261I40qPxnF1catIYtdExPDmcbtOQUhhLwChx+yUvIE9
 XdK1wLDzZyOpfIZiZqPar4sFkOYHBGE8bydCkEvd/3EyZfcDowWUprzsi1A/9siBQ8zggoxtt
 OVBKh81vUaDDML6c/LTFDZdU1oNTUsIxq8s2P80dH+rra3uDnqcsuW6rNF8WvgUzSzgPgGT6A
 4HC7H6xZ3t1AtH3d0/vWEAeNj93+rbR/HEejnPs56Rz5IjGcBBQigLHpcaB/oUe9nJQPEhUKm
 lfnOIDBiYI9rRhKSQzNJieZ/4DDwRHCHKEznuSPZ+k7diYABQ5JJyWiEfjYC6+j3yWCrZezXK
 ucSSeFCoST1vlKhtDV+vPiKUpVv2QTZf+pfh6o7C6elnyU0Gid/QfGunq3ozKDl/rrb2waygF
 U9zFpFr5KX0rnJgstsSMd6BRYJItSev/4Ki9UAL3IlxnXTTrQExZgMQyG+7dsY0SKz+xuXvDU
 qKVo0jTlJ2u0Vb+nUKVtX5bKL2Vq37VS62ar6M2Ow=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 13 Nov 2020, Phillip Wood wrote:

> On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Git's diff machinery allows users to override the colors to use in
> > diffs, even the plain-colored context lines. As of 8dbf3eb6850 (diff.h=
:
> > rename DIFF_PLAIN color slot to DIFF_CONTEXT, 2015-05-27), the preferr=
ed
> > name of the config setting is `color.diff.context`, although Git still
> > allows `color.diff.plain`.
> >
> > In the context of `git add -p`, this logic is a bit hard to replicate:
> > `git_diff_basic_config()` reads all config values sequentially and if =
it
> > sees _any_ `color.diff.context` or `color.diff.plain`, it accepts the
> > new color. The Perl version of `git add -p` needs to go through `git
> > config --get-color`, though, which allows only one key to be specified=
.
> > The same goes for the built-in version of `git add -p`, which has to g=
o
> > through `repo_config_get_value()`.
>
> One nit pick: the built-in version does not have to go through
> `repo_config_get_value()`, it could get the values in a callback using
> `git_config()` which would match the behavior of diff but chooses not to
> (presumably it is more convenient to just look up the config values).

Oh, but that would require _all_ callers of the interactive patch
functionality to be audited, to ensure that the correct `git_config()`
call back is used.

That's positively not what I intended.

Instead, using `repo_config_get_value()` does not require that care, and
does not open us up to future callers that may forget to include the
required callback in _their_ config parsing.

In addition, using `repo_config_get_value()` already prepares this part of
Git's code for a future where the `struct repository *` pointer is passed
into every code path that needs it, so that we no longer have to rely on
global state at all.

Besides, since this patch is really about fixing the discrepancy between
the Perl version's use of `.plain` and the built-in's use of `.context`,
changing something as unrelated as how the config is accessed would be
inappropriate (even elsewhere in this patch series, which really is about
fixing interactive `add`'s color handling).

Ciao,
Dscho
