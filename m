Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC01C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 17:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518AB60ED5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 17:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhJVRy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 13:54:26 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:49977
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231472AbhJVRyZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Oct 2021 13:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=cessssaigkdq5uletp7pzdlghxldyiuc; d=coderkalyan.com;
        t=1634925127;
        h=Mime-Version:Content-Type:Subject:From:To:Cc:Content-Transfer-Encoding:Date:Message-Id:References:In-Reply-To;
        bh=bZVsDR5PMuLCD6luEPNtHhPH+jy1OcWoX8zs8+O1h6U=;
        b=ax4GMOxAdLPxA/95mJG3/GJmTAH1U1HgRVvIRKYwGSX9r4sb7uDsfXhWFkVUkbuH
        QN39oeGnbzrFZckWpX7e03Pn58NdIYQXn7OHMSxiSQmVNs3H8XLIL6qkQQX68i0xf+p
        HFcQa0R4/fPQV6SwLNSUSzNC71CPpNmnv/OdCWCA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=7v7vs6w47njt4pimodk5mmttbegzsi6n; d=amazonses.com; t=1634925127;
        h=Mime-Version:Content-Type:Subject:From:To:Cc:Content-Transfer-Encoding:Date:Message-Id:References:In-Reply-To:Feedback-ID;
        bh=bZVsDR5PMuLCD6luEPNtHhPH+jy1OcWoX8zs8+O1h6U=;
        b=Ugpz1KKNdJpVO7lWr1OREvzisusx0Falmhr+7NgdtxEHmtlFl+xZSCxWTrapyQKZ
        HLbBVxBxWW2CBDsgcfeFZj1OzDJBL6Dv962F2PTbTSQPzcThwQZrcjeF2g1k3+tB+SN
        W73cMqVVAzVRxNpI1PvpRvBKjUWA+Yaffn/J9cSY=
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: RE: Git submodule remove
From:   "Kalyan Sriram" <kalyan@coderkalyan.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 22 Oct 2021 17:52:07 +0000
Message-ID: <0101017ca921a6a0-96383fe2-4d73-47cb-83f7-4152b2c6ed7e-000000@us-west-2.amazonses.com>
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com> <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net> <xmqqbl3ihu6l.fsf@gitster.g> <016801d7c74b$64bb9a90$2e32cfb0$@nexbridge.com>
In-Reply-To: <016801d7c74b$64bb9a90$2e32cfb0$@nexbridge.com>
Feedback-ID: 1.us-west-2.6woXiZ10/hvs78i2LW4ugcJq1GLEuVeUxt3YeADpvNg=:AmazonSES
X-SES-Outgoing: 2021.10.22-54.240.27.185
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri Oct 22, 2021 at 6:47 AM PDT, Randall S. Becker wrote:
> On October 21, 2021 6:47 PM, Junio C Hamano wrote:
> >To: brian m. carlson <sandals@crustytoothpaste.net>
> >Cc: Kalyan Sriram <kalyan@coderkalyan.com>; git@vger.kernel.org
> >Subject: Re: Git submodule remove
> >
> >"brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> >> On 2021-10-21 at 17:25:38, Kalyan Sriram wrote:
> >>> Hello,
> >>>
> >>> I was curious why git-submodule does not have an `rm` command.
> >>> Currently I have to manually delete it from .gitmodules, .git/config,
> >>> .git/modules/, etc. See [0].
> >>>
> >>> I'd like to contribute my first patch to this project by adding this
> >>> feature, but wanted to check first with the community if there's any
> >>> particular reason it was chosen not to not be implemented, or if it's
> >>> simply that nobody has gotten around to it - it seems to be a
> >>> relatively common feature someone might want.
> >>>
> >>> Anyway, please let me know if this is something that would be
> >>> accepted, or if anyone has any comments or suggestions.
> >>
> >> I think the reason it hasn't been implemented is that nobody's gotten
> >> around to it yet.  I certainly would find this useful and have wanted
> >> the same thing myself, so I can't see a reason why the right series
> >> wouldn't be accepted.
> >
> >I tend to agree that nobody felt the need strongly enough.  Code tends t=
o accumulate without ever getting removed, and removal of a
> file,
> >removal of a directory, or removal of a submodule is a much rarer event =
compared to other changes people would need to make.
> >Adding such a feature would have been much more work for those who faced=
 such a rare occasion to want to use it than just doing it
> by
> >hand and committing the result.
> >
> >I'd imagine that the happy-case implementation should be fairly straight=
-forward.  You would:
> >
> > - ensure that the submodule is "absorbed" already;
> >
> > - run "git rm -f" the submodule to remove the gitlink from the index
> >   and remove the directory from the working tree; and
> >
> > - remove the .gitmodules entry for the submodule.
> >
> >and you'd leave the final "record the state of the index as a commit" to=
 the user, simply because the user would want to have other
> >changes related to the removal of the submodule in the same commit (like=
 changes to files in the superproject that refer to the
> >submodule contents or removal of other submodules).
> >
> >The hard part is unhappy-cases.  There are too many things that can go w=
rong and you need to handle all the error cases correctly
> so that
> >you do not leave the user's repository in an uncontrollably messy state.
>
> Just my rambling:
>
> The really unhappy place is when a user deletes the upstream submodule
> repo itself after not seeing it in main any longer during
> some cleanup adventure, then someone else tries to check out an older
> commit that references the submodule.
IMO this seems like a pretty unlikely situation to be in, which doesn't
warrant *not* adding this feature. I get the idea, but how commonly do
people checkout old commits and play around with them? In any case, this
seems to be the project maintainer's problem, not git's.
> This particular unhappy
> place seems a whole lot like 'git branch -d' vs '-D', where it might be
> good not to allow the submodule rm if it is referenced in a
> commit (insert acceptable criteria for not forcing it here, which
> probably doesn't exist).
But wouldn't a submodule always be referenced in a commit? The first
thing anyone does after adding a submodule, after all, is to commit it
into the repository. Later on, you may decide you don't need that
submodule dependency anymore...
> A prune-like operation, as with workspace
> prune might be a little safer - but not much.
Sorry, I'm having a hard time understanding. What would this look like, and=
 how
it would be safer?

Thanks!
Kalyan
