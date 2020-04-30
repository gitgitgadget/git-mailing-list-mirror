Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15B9C4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 15:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4BC20661
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 15:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewe2GHmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgD3Pdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726344AbgD3Pdl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 11:33:41 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FC8C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 08:33:41 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id e16so1187452ybn.7
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QCUn1lLrbSybsDRwmlO7IfFnSEdWgur0oBu7lmSsUIg=;
        b=ewe2GHmpILt3avIJnfS7+fWlrp/NNfimBAWb7rMoFvJcPed9hrnbCMYDc6NhjnVh8o
         vQjFKyhJi/XHYI4FfXq9DFeKoEEqtVvVexUwyuTK4x863e6Mx4FwD9DBT6DwBvqOhGbl
         pW8v6stPbfsV/poDz+TjUWwrHLrvC4s3wwAlT0n/OriSgrD+cp1G6rMI1ojjA7r3Yp7S
         iLcidR9k4vZLYm5Gq9PEY1dI6KrryW9ldt/AJy5jSKknATnFvI/qg794u1snU3A1Y4DA
         yC1JOdP+eYLwMdstivUdu4krd0u/d9HZiqm7c/maN+sUh8JyxEm6jaihfSadWPvk3Wv3
         01qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QCUn1lLrbSybsDRwmlO7IfFnSEdWgur0oBu7lmSsUIg=;
        b=Zbr8gEXl+iLE8MMzvKAcqbPnKGmTyd+P5u0/c4LTm7r993Sn55Yj/7ib2rXFd01kec
         O/MkwAKZ4/PIEEIo0tRC18SBc7AUpIPebGtZ/RuzHatCL8kUEYUOdt3za8ngyyMrgxdU
         KIatNU0U9cxpzBmZKu3ghkOTbOZMELsN//FACIRNc2Ha3QHvbVxqPiJwK8zsFrRnZ70r
         cUrz2nIAaJOVYnAT0QrcHykSDaF4YabYavXO2vcHrRYhao08QuXHTMtcDfP8CRZczIwb
         T7TEuirA4IK/GMS2QHYvdBJ6D+lvHar1/cZXIU0/nerzWnMnOtasjxAInTde0qe7ONZ3
         Lhuw==
X-Gm-Message-State: AGi0PuY0BzJejO/tr4EFBhbN4oPkAxGc0SbCgFF7I/9lwyl0O9+R9aHb
        eY+eVOgx1dsSqtudcvbVauiHCtcNZgPvVRTbGmY=
X-Google-Smtp-Source: APiQypIh5HTpDiZyCK65JqGY0yU6C8Oi6sFWB0YIb3wFp7/tpmM8O/N5BqNAGzz9eeAmJyRlCutAZHMAe+Qya13ia2A=
X-Received: by 2002:a25:4443:: with SMTP id r64mr6486936yba.41.1588260820267;
 Thu, 30 Apr 2020 08:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq3697cax0.fsf@gitster.c.googlers.com> <20200414123257.27449-4-worldhello.net@gmail.com>
 <xmqqo8rs7ntb.fsf@gitster.c.googlers.com> <CANYiYbE84Jj46m0ZTfAepc7t4v4KcqU9R99WGY9b7cdTXBfw_g@mail.gmail.com>
 <xmqqzhbc61jv.fsf@gitster.c.googlers.com> <CANYiYbGNTMpdvW7AGs-drOuwhzcR_CJnsCE9TjAWujZtb3cfEg@mail.gmail.com>
 <20200429075604.GA637261@coredump.intra.peff.net>
In-Reply-To: <20200429075604.GA637261@coredump.intra.peff.net>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 30 Apr 2020 23:33:27 +0800
Message-ID: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] receive-pack: add new proc-receive hook
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2020=E5=B9=B44=E6=9C=8829=E6=97=A5=E5=91=
=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 28, 2020 at 01:00:00AM +0800, Jiang Xin wrote:
>
> > For over a week, I have not received more comments on reroll v13 on
> > this topic ("jx/proc-receive-hook"). Therefore, I invite Peff and
> > Couder to review because I think it would be very interesting to add a
> > centralized workflow to Github and Gitlab.
> >
> >  * [PATCH v13 3/8]:
> > https://public-inbox.org/git/20200418160334.15631-4-worldhello.net@gmai=
l.com/
> >
> > This patch introduces a new hook "proc-receive" on the server side. It
> > won't break anything except GitHub's "spokes" architecture (I guess).
> > Because in Alibaba, we have such issue when we implement our own
> > "spokes" architecture.  In order to make this special push operation
> > (on a special ref such as "refs/for/master/topic") idempotently on
> > multiple replicas, we extended the protocol of "receive-pack" and let
> > "spokes" to send a request with a flag, which specifies one replica as
> > master replica to execute the "proc-receive" hook.
>
> We don't do any magic ref-rewriting like this, so we wouldn't turn such
> a hook on. Presumably without such a hook, the protocol would remain the
> same (i.e., if there was no rewrite, then the report-status response
> wouldn't have the extra field).
>
> And I'm not sure if you're proposing to also use it as the trigger point
> to coordinate the ref update across replicas. That wouldn't be helpful
> for our architecture. All Git client connections to GitHub terminate at
> a proxy layer that handles load balancing, authentication, and routing.
> For pushes, that's the layer that multiplexes the packfile to each
> replica, and it drives the ref update through an out-of-band procedure.
> So there is no master replica at all; they're all talking equally to the
> proxy layer which coordinates things (and the same is true for non-push
> updates; they're coordinated by whichever entity is trying to perform
> the update).
>
> We do run receive-pack on each replica backend. We have a hacky patch
> for a config option that tells receive-pack to just skip the actual
> ref-transaction, leaving it up to the proxy layer to do. I've been
> pushing for us to actually abandon receive-pack entirely, since most of
> its heavy lifting can be done by sub-programs (for-each-ref for the
> advertisement, index-pack to receive the pack, and update-ref to update
> refs). But it's a non-trivial change, and the benefits are only
> moderate, so it hasn't quite been worth the effort yet.
>

Thanks to Peff for providing technical details of the architecture.  I
understand that "receive-pack" of GitHub backend is not involved in
references update (executing the commands), so the "proc-receive" hook
won't be turned on for GitHub's architecture. While in our
architecture (inspired by "spokes" of GitHub), the proxy will deliver
not only packfile, but also commands to all three replicas. The proxy
will execute "receive-pack" on the replica with a special argument, so
the proxy can talk with "receive-pack" with an extended protocol.
After running pre-receive hook and release the packfile from
quarantine, the replica will stop and wait for the proxy to
coordinate. After creating a distributed lock, the proxy will tell all
the replicas continue to update the references.  One problem we met is
the proc-receive and the post-receive hook must be executed once. We
can make the execution of the hooks idempotent, or let only one of the
replica run the hook. We choose the latter.

> So I don't really have much of an opinion on it either way.
>
> Reading the commit message for patch 3, I do have one small comment. I
> see this:
>
>   The reporting function from "receive-pack" to "send-pack" is extended
>   using a backward compatible way by adding key-value pairs after an null
>   character, like:
>
>       # OK, run this command successfully with optional extended-status.
>       ok <reference>\0ref=3Drefs/pull/123/head old-oid=3D...
>
>       # NO, I reject it.
>       ng <reference> <error message>
>
> but we should probably avoid trickery like stuffing extra data after a
> NUL byte. We could quite easily extend the protocol with a new
> capability here. The server advertises "report-status-v2" or something,
> and the client responds with the appropriate capability to indicate that
> it understands. And then the new format can be something more
> extensible, like:
>
>   pktline(ref=3Drefs/heads/master)
>   pktline(status=3Dok)
>   pktline(old-oid=3D...)
>   pktline(rewrite=3Drefs/pull/123/head)
>   delim-pkt(0001)
>   pktline(ref=3Drefs/heads/other)
>   pktline(status=3Derror)
>   pktline(message=3D<error message>
>   flush-pkt(0000)

The above status report is from "receive-pack" to "send-pack", and
another place that we need to extend is in `print_helper_status()` of
`builtin/send-pack.c`, which will send report status in the following
format from "send-pack" to remote-helper (such as remote-curl.c):

    ok <ref>
    error <ref> <error message>

BTW, I don't know why not use "ng", but use "error" here.

I agree that adding new capability (report-status-v2) is a better
solution, but I think the above extension is a bit wordy. We add
additional 18 characters for each "ok <ref>" status, and add
additional 32 characters for each "ng <ref> <msg>" status. Can we
extend it like this:

    ok <ref>
    [optional key-value pairs]
    ng <ref> <error message>
    [optional key-value pairs]

E.g.:

    ok refs/heads/master     # no extensions
    ok refs/for/master/topic  # send 2 commits, and create 2 changes
    rewrite=3Drefs/changes/123/1
    new-oid=3D...
    # use rewrite key-value pair as delimiter,
    # because plain text is in use from "send-pack" to remote-helper.
    rewrite=3Drefs/changes/124/1
    new-oid=3D...
    ok refs/heads/next
    ng refs/heads/release non-fast forward

--
Jiang Xin
