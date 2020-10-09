Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_PH_BODY_META_ALL,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8025DC433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 09:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 079A522275
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 09:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KWqts5mC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbgJIJOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 05:14:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:40915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732712AbgJIJOY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 05:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602234862;
        bh=9qvSgScZyLfbEIdRI438miD9vlYA//olLa+zXF2lYZw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KWqts5mCf7qUtv6i+QsMnRfcUEpxovDt3K6fW5jB4z7H0Xy9kG9OCdMYM9ZG5gN/W
         GERf4v5RvcSBrnLCK9Y42+5HZYdiX5Bvdi1e8BqZzipmbXwaUVUS/fi6SuZmSBW51B
         Yl+j0Wex6Au9j5IUUE187wFjF4RHgXSAk5E1QMRM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.213.205]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMbO-1kf6DZ3hNE-00EKim; Fri, 09
 Oct 2020 11:14:21 +0200
Date:   Fri, 9 Oct 2020 08:56:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-gui: accommodate for intent-to-add files
In-Reply-To: <20200826145217.gx2prxltyoyuoxo3@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.2010090855260.50@tvgsbejvaqbjf.bet>
References: <pull.699.git.1597244777943.gitgitgadget@gmail.com> <20200826113030.xnutfxxfmdhgoq5o@yadavpratyush.com> <nycvar.QRO.7.76.6.2008260936010.56@tvgsbejvaqbjf.bet> <20200826145217.gx2prxltyoyuoxo3@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5HelY1QyCiPS0VPboofsFee5C+RUHjDUwS6+IRBwvhoscx7NUAS
 k+3onGcwdTV8rReaOnR3aDeXZ4hNCMmaNo/KEL12wXj9LQ52ajZ0AvBVbFNosfjW0Eek9/Z
 dA5iPSoKpBztMxTMFyM0quygKByMgLH8AqfaSfFPpS3Hw23B70/wmdL1ejhZ/qwh5hf7bN7
 VKNcXhbT9ySqENgRALNNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F39Nt3McUvM=:3kkQMlqeIOY3TICfdt+YXe
 8lE2i1fCVlWvUc0btfdo+AIl/lt+Vjk+cCpNzTRh4sKx552ZcsKFTAiPNp1b8Ywm4ksvFR6Ei
 Nkghh2icY4HYWInjNApK9h+/fZXRvQyUfhyZhkMBQjheWPxyAWFCeF7SQngUfUtiTrqIals8u
 fTCYeGZBKbF+Gs71jSelwxd5SCUA705PdZG2s/hfYgr874fH7UFdGZ2AbM/VhKJfKqUsQoaFQ
 rS/tlmoM+fiDKTNz4op0gXX4H5jeOj7N4+11VbMucPBVJMxH9m7yL1MTN2/S78TCbAyaYORvo
 jabAR7F/hfEIT4kTXGnk6vY1Bbg0Kk3j/d50AiNV0AuhuZ9nxOIShCcc83k4gp2nIUfQ8DU+h
 2dXaYobVpEuldHMaupb4POcyPpBjKux2crfKHt+1tcPwPTmlOQc+zkck4ghepDEok70tH5rJG
 +QpMZyFRDQ6HH79FmA7N/O1zEP6LyvcxnY4T1auysSQNPuk6gJwnBUkZcdBEzEgT8CfAUW2x9
 xXnx2G06Fs7PPWHUiJQhn/FhM6nwEABztX8aZBtgGj7VuxcgomKNYfC7JK/3Jl+qsXaj2R2//
 dyOXCho7lZ4Xh0r75rJ8TovR0RdPNLYWAHdBFXcV9mgLByh5vggFG1YnO+x5K5exJXaKQT0mH
 whFnMewgkD2qIzrSk09J8k7WXj7bndFKsVKsGbUm/lAsckCazNSc+QGs3XNcHQbVh+unFuKgn
 x1ln0t4rQZdeog9iSOKQFuzSllEyh54bOm7//JJS4sAau3iIbPfDkCbQNZeuAu13uJuJwjro8
 T3VcrPgy/WpgkJaww1GxtrNoCP6BsyeBLRfLAc9AW9wwmyJWRw3nZWQqk18MwFydOB48u3MbC
 CogYkrWqNFUkDfPGfAX0HMY+Dc8jwG+slt9yUZShgs+jTk1FTWPf7Jiq+vZXxRWVsWcnMDWnB
 +MOm6LUhW3QK7CHum9OTMNbBPxKY7BA8fK+byRfXZtsGeLxcripHFS9xJD7PpIhmoXKMKluio
 97xIMvGztWp3uUiQK6+fW8/7haRgGelgynkmPBvi36Sm2H4DYZgobitMxsOnILCsybUQFWfug
 +hmBMkdVIF1LKeeaOmxeLTTa0gTDrmJ4a5xFLDx5AHMZ2Nvk40TL9edPv74IvSwNH75Edxr4z
 xEyS5HWhVbxOwKMq8sMTG5mgqD61RLf2oEliamXUZhffx750cq8IxJIKqTa89pYw4dkA7x6Wf
 KLelOuWKSUu539R2H8Z/F3vFYigIkhBNOoBGe9g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Wed, 26 Aug 2020, Pratyush Yadav wrote:

> On 26/08/20 09:36AM, Johannes Schindelin wrote:
>
> > On Wed, 26 Aug 2020, Pratyush Yadav wrote:
> >
> > > On 12/08/20 03:06PM, Johannes Schindelin via GitGitGadget wrote:
> > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > >
> > > > As of Git v2.28.0, the diff for files staged via `git add -N` mark=
s them
> > > > as new files. Git GUI was ill-prepared for that, and this patch te=
aches
> > > > Git GUI about them.
> > > >
> > > > Please note that this will not even fix things with v2.28.0, as th=
e
> > > > `rp/apply-cached-with-i-t-a` patches are required on Git's side, t=
oo.
> > > >
> > > > This fixes https://github.com/git-for-windows/git/issues/2779
> > > >
> > > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > ---
> > > >     git-gui: accommodate for intent-to-add files
> > > >
> > > >     This fixes the intent-to-add bug reported in
> > > >     https://github.com/git-for-windows/git/issues/2779: after a fi=
le was
> > > >     staged with git add -N, staging hunks/lines would fail silentl=
y.
> > > >
> > > >     On its own, this patch is not enough, as it requires the patch=
es
> > > >     provided in rp/apply-cached-with-i-t-a to be applied on Git's =
side.
> > > >
> > > >     Please note that this patch might need a bit more help, as I d=
o not
> > > >     really know whether showing "new file mode 100644" in the diff=
 view is
> > > >     desirable, or whether we should somehow try to retain the
> > > >     "intent-to-add" state so that unstaging all hunks would return=
 the file
> > > >     to "intent-to-add" state.
> > >
> > > I built latest Git master (e9b77c84a0) which has
> > > `rp/apply-cached-with-i-t-a` and tested this patch. It works... for =
the
> > > most part.
> > >
> > > I can select a line set of lines and they get staged/unstaged, which=
 is
> > > good. The part that is not good though is that a lot of common
> > > operations still don't work as they should:
> > >
> > > - I can't click on the icon in the "Unstaged Changes" pane to stage =
the
> > >   whole file. Nothing happens when I do that.
> > >
> > > - The file that is marked as intent-to-add shows up in both the "Sta=
ged
> > >   Changes" and "Unstaged Changes" panes, with the "Staged Changes" p=
art
> > >   being empty. Ideally it should only show up in the "Unstaged Chang=
es"
> > >   pane.
> > >
> > > - Selecting the whole file and choosing "Stage Lines for Commit" wor=
ks
> > >   well. But choosing "Stage Hunk for Commit" does not. While the cha=
nges
> > >   do get staged, the UI is not properly updated and the file is stil=
l
> > >   listed in the "Unstaged Changes" pane.
> > >
> > >   I think the difference here is because for
> > >   `apply_or_revert_range_or_line`, we call `do_rescan` after it to
> > >   update the UI, but for `apply_or_revert_hunk` we update the UI
> > >   "manually" in the function after we are done applying or reverting=
 the
> > >   changes. So the logic to update the UI needs to be updated to acco=
unt
> > >   for this change. Or we can get rid of all that logic and just run =
a
> > >   rescan.
> > >
> > > And also, like you mentioned, we don't retain the i-t-a state when
> > > unstaging. But with some quick testing, I see that Git command line
> > > doesn't either (I tried a plain `git restore --staged`). So IMO we
> > > should mimic what the command line UI does and not retain the i-t-a
> > > state when unstaging.
> >
> > To be quite honest, I had hoped that this might be a good patch to sta=
rt
> > from... for somebody else (you?)
>
> I'll take a stab at this during the weekend :-)

Just a gentle ping: did you get a chance to get this patch into a better
shape?

Thanks,
Dscho
