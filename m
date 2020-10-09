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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224FCC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B1B22251
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 15:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jEahvIe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbgJIPkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 11:40:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:59437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389165AbgJIPkT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 11:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602258016;
        bh=roQIsZT0SF8J17NYlyRI+k0MSOzvBoxUMwQi1urd4tg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jEahvIe+mBavh+i9ywvjyumaQCOYyoKsM7LIiP4HYidgDpsfZfTW4itRZ4CFu+HX+
         2LCebpI7ltT9ktS/nwYSFsVnaCLwoSnVRklU/FUE/pbLX94XjCBDeN/nYr7625PEG4
         LeaQfW2vycKxhkt8gMUGNl+zXQSkUv0mN+AiNphc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.92]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1kEUKJ17eF-00wEZY; Fri, 09
 Oct 2020 17:40:16 +0200
Date:   Fri, 9 Oct 2020 15:22:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-gui: accommodate for intent-to-add files
In-Reply-To: <20201009093455.yxh5xnyvcjqvn54a@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.2010091522150.50@tvgsbejvaqbjf.bet>
References: <pull.699.git.1597244777943.gitgitgadget@gmail.com> <20200826113030.xnutfxxfmdhgoq5o@yadavpratyush.com> <nycvar.QRO.7.76.6.2008260936010.56@tvgsbejvaqbjf.bet> <20200826145217.gx2prxltyoyuoxo3@yadavpratyush.com> <nycvar.QRO.7.76.6.2010090855260.50@tvgsbejvaqbjf.bet>
 <20201009093455.yxh5xnyvcjqvn54a@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9bOOK22/je8A77DlWVeLYlZcSqCP7dMI8xxUjSBXs/jh0Cm1Vts
 5g22VewQKeTMJen5Q5O2PF32W7gVPnEiM8pm0iQJgQ5VPfFvnIV/ONNosj+XFkZHyTo+xQb
 Els01ZrsBj1yTChfKFBJUTbwYYFtPA8lyBQBzzVv5/HWtWT6TyI7fu7kPRrTLvLCNVVNbd7
 +820wkBckNNgxjbdUKqTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3VzLRCBvORk=:ZSr2B56tUWU3EqXc1IPczG
 OimPyv+ewEGbyrG4VNbACnZf/617WouU1X0ieZlJ72dGC7fsBAAvcco3TmIM3CP/5p5RECKF2
 AeIilhtpfCjTTjUNm7kT1iwgTdfB3vjKPWnWkx8NmDYW/VMxwFakYK8n7GIWKwzM9zfLOFSWt
 qaYGUsp59Y5dB7svX5FqIaBOA4Iprp2KQ/rRT3USMnxHTfzJLgk9z3yuo0JVQa5dWoKxPpoYB
 ERSGJM4O31gP4809Y1NcfHZwt1D32afQgRKD7CmB914O1YmnpnHmberErYoL4lRss3PZxoWkg
 w9ZH0ik4w5w5iTvbw346bIq4R4vFl5Wdj2hAKRW71GieCoawCq3zS/r4s7jGreUTQaP/rrpcm
 7KdBRQLK+m7gzd5anf+8nzmA41uebR3HCEcuO+tjKcTMf+xEe4McS1N1ydDy54YfVrHE0SQTm
 Mi12EJagtwohH2g5taeZwU6PLcxjcrs472lDS5lUjKJ+oX5o2hRpqZYiIOs/Jh3MvCPk6ETzd
 0c6g2XSivT9Rhr9ALW7osfL3lJ9t6SEWkPVikduZmq6wgBGaV0oKXVotRy881UTax0jdCe5yq
 tQHOdPhQrqYddUTEfxSV6l75fn3IpsShxi56ERGH9cSLST7N3VbNfSypPCl/r/Wlwliy7tlL2
 bReoQTRLNl4TUDmS70lsC6JvBUs5cDMWJbB9NvZ1Jop871rnoi6zOYM2P0NQ85ckFLhKBuZz+
 0ePTa4MP5liYI5W++Wdskmr/tovQKPxp1aiqe8ry+ygTBpblhL/cBBZocDJy9OqZBUkDZeQ+K
 Jp81zyclRVEA9W2jwRZqUx3r+RVGNnf2qp8ZzJDz3oSINB39lsOQsC07BGp31qL0aUz5I/rHN
 1ZVT8rImmr/nUqxSwGdfLEATCcPkjlKjWg66DlH6kYOtY6BBBaNGFSebhtmfq9BSuE25aSlKQ
 pZnliVqUQaDRE+bGRrlw5h3r6VDQgu17c1uWr8ai+mP8Ocfue0lE89Rkvfur6nptP9OYZydWJ
 ToSY3NlHTkrBhQOdTMnp3YS0uWnHckLdVZ7wd5WyzKjlZQExaZEwuwp3ubcKdUVArKVCaM3C2
 3S/wtHVYCnLcQV1KUsqBmYqPbyYgr3WVFcaWsGyjIQ02mKh/LEYVwEbmpqqgWp7dyTx2pFXUr
 u/H129sam/3iYsvafz6F3ZzkOPuIhEDMjMFOUnlCcEuWNwLYkoVGSLMtuVHYjgC+esvn4KQjd
 UlWl8S34ReK5mxtUApmO8HUBgcHALXIdgMfL9mg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Fri, 9 Oct 2020, Pratyush Yadav wrote:

> On 09/10/20 08:56AM, Johannes Schindelin wrote:
> >
> > On Wed, 26 Aug 2020, Pratyush Yadav wrote:
> >
> > > On 26/08/20 09:36AM, Johannes Schindelin wrote:
> > >
> > > > On Wed, 26 Aug 2020, Pratyush Yadav wrote:
> > > >
> > > > > On 12/08/20 03:06PM, Johannes Schindelin via GitGitGadget wrote:
> > > > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > > >
> > > > > > As of Git v2.28.0, the diff for files staged via `git add -N` =
marks them
> > > > > > as new files. Git GUI was ill-prepared for that, and this patc=
h teaches
> > > > > > Git GUI about them.
> > > > > >
> > > > > > Please note that this will not even fix things with v2.28.0, a=
s the
> > > > > > `rp/apply-cached-with-i-t-a` patches are required on Git's sid=
e, too.
> > > > > >
> > > > > > This fixes https://github.com/git-for-windows/git/issues/2779
> > > > > >
> > > > > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de=
>
> > > > > > ---
> > > > > >     git-gui: accommodate for intent-to-add files
> > > > > >
> > > > > >     This fixes the intent-to-add bug reported in
> > > > > >     https://github.com/git-for-windows/git/issues/2779: after =
a file was
> > > > > >     staged with git add -N, staging hunks/lines would fail sil=
ently.
> > > > > >
> > > > > >     On its own, this patch is not enough, as it requires the p=
atches
> > > > > >     provided in rp/apply-cached-with-i-t-a to be applied on Gi=
t's side.
> > > > > >
> > > > > >     Please note that this patch might need a bit more help, as=
 I do not
> > > > > >     really know whether showing "new file mode 100644" in the =
diff view is
> > > > > >     desirable, or whether we should somehow try to retain the
> > > > > >     "intent-to-add" state so that unstaging all hunks would re=
turn the file
> > > > > >     to "intent-to-add" state.
> > > > >
> > > > > I built latest Git master (e9b77c84a0) which has
> > > > > `rp/apply-cached-with-i-t-a` and tested this patch. It works... =
for the
> > > > > most part.
> > > > >
> > > > > I can select a line set of lines and they get staged/unstaged, w=
hich is
> > > > > good. The part that is not good though is that a lot of common
> > > > > operations still don't work as they should:
> > > > >
> > > > > - I can't click on the icon in the "Unstaged Changes" pane to st=
age the
> > > > >   whole file. Nothing happens when I do that.
> > > > >
> > > > > - The file that is marked as intent-to-add shows up in both the =
"Staged
> > > > >   Changes" and "Unstaged Changes" panes, with the "Staged Change=
s" part
> > > > >   being empty. Ideally it should only show up in the "Unstaged C=
hanges"
> > > > >   pane.
> > > > >
> > > > > - Selecting the whole file and choosing "Stage Lines for Commit"=
 works
> > > > >   well. But choosing "Stage Hunk for Commit" does not. While the=
 changes
> > > > >   do get staged, the UI is not properly updated and the file is =
still
> > > > >   listed in the "Unstaged Changes" pane.
> > > > >
> > > > >   I think the difference here is because for
> > > > >   `apply_or_revert_range_or_line`, we call `do_rescan` after it =
to
> > > > >   update the UI, but for `apply_or_revert_hunk` we update the UI
> > > > >   "manually" in the function after we are done applying or rever=
ting the
> > > > >   changes. So the logic to update the UI needs to be updated to =
account
> > > > >   for this change. Or we can get rid of all that logic and just =
run a
> > > > >   rescan.
> > > > >
> > > > > And also, like you mentioned, we don't retain the i-t-a state wh=
en
> > > > > unstaging. But with some quick testing, I see that Git command l=
ine
> > > > > doesn't either (I tried a plain `git restore --staged`). So IMO =
we
> > > > > should mimic what the command line UI does and not retain the i-=
t-a
> > > > > state when unstaging.
> > > >
> > > > To be quite honest, I had hoped that this might be a good patch to=
 start
> > > > from... for somebody else (you?)
> > >
> > > I'll take a stab at this during the weekend :-)
> >
> > Just a gentle ping: did you get a chance to get this patch into a bett=
er
> > shape?
>
> No, I have not. I'll try my hand on it tomorrow and try to get it done
> in time for 2.29.

Thank you so much!

Ciao,
Dscho
