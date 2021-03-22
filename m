Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520A6C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 14:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17586186A
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 14:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCVOlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 10:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhCVOk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 10:40:59 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F2C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 07:40:58 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id w63so3837599vkf.11
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nYw/WByVqBRwYM5yqPmdA7/RCx/ZL4/ZYip8OPXfzgM=;
        b=IH7YHBEmLP6mIHFheITZgaw6P+iHN0KOqbtCdSViA6trs5yBYT7j9hfdQ+YMwq+u1D
         0oZbDW9a3ePmn/r+7ov0P+LelatjW8sO48pQIJJWy1SvEx4S4kS8ybHlbDXRFwhTeYRi
         SxNuXyqqL6yp+tk1H0YWtyPuGAQR7MqD5hjzfXBUw8oVThqr/+KdZI32RqAAAlH9ZXdJ
         LuB1mhemZZUw2quc7y8hrdWgOTSGPKIEJz4/3DJa5CyBIE0vfYl3g4QI3pHm29lbpoyk
         gPdtw0MmMFSYeROw41vO7YQb2ViBA0nLBAymJ3v/+uL8Q+MNHqwc6fQhn6NF/f+J5sfy
         1STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nYw/WByVqBRwYM5yqPmdA7/RCx/ZL4/ZYip8OPXfzgM=;
        b=eV4NEXnH+n6B4ufH7Vz4A8/ytRhsJfAYzNHbv6bxbk8D6u906hQxknb/ivMVpdZkOH
         Su/EL5tYbbfS/nzpRaq2evVJsF5EmLGHvjIrCnCrjBvh9eLzq9yW7BXosi62edSNO8eL
         rrKkUS4+VSpXZH6KKXzKCnRJ2vMT/BsCwMyG+XsrKlg6TeHv8GV4Fv7kdhoe0wJ9kbW6
         9BhXVdlz597rmJpi/oRDm/u37cQ7bw2+TLcBXh9LHNum8bL6NwemVNAOkoECYbYndO7w
         3lXFVf0NZrpXt/lx3asqWDIB3xFwICs728xBW960E08eS8Y3JW+EuYShcv7L84K44mMO
         UyVw==
X-Gm-Message-State: AOAM532UnmIXAzyiPgjD/6bg/ZHfIkn23HXan+82kWa1eLP7ZjmyNZim
        EXRePYr1LVFnpQAbxrBzTweQ51octNH325T+9cXvFp+MgQvZrQ==
X-Google-Smtp-Source: ABdhPJxNSAr/8q2Q6sn02idRaef1rSz93TZ4Oa9MlBX1c+Zzu820qztBU+svoZVDlyf9vOAvQO/T6FDxi9jwqTNa3ow=
X-Received: by 2002:a1f:b686:: with SMTP id g128mr202486vkf.25.1616424057776;
 Mon, 22 Mar 2021 07:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
 <YFOuT6L0dsrCGTBk@coredump.intra.peff.net>
In-Reply-To: <YFOuT6L0dsrCGTBk@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 22 Mar 2021 15:40:46 +0100
Message-ID: <CAFQ2z_N8tCMZG62rNSY=HoRGuKnfk1W-Y_GOXz3SeaZO6=cWWA@mail.gmail.com>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 8:47 PM Jeff King <peff@peff.net> wrote:
> > I'm working on some extensions to Gerrit for which it would be very
> > beneficial if we could tell from the reflog if an update is a
> > fast-forward or not: if we find a SHA1 in the reflog, and see there
> > were only FF updates since, we can be sure that the SHA1 is reachable
> > from the branch, without having to open packfiles and decode commits.
>
> I left some numbers in another part of the thread, but IMHO performance
> isn't that compelling a reason to do this these days, if you are using
> commit-graphs.
>
> Just walking the reflog might be _slightly_ faster, though not
> necessarily (it depends on whether the depth of the object graph or the
> depth of the reflog chain is deeper). It might matter more if you are
> using a more exotic storage scheme, where switching from accessing
> reflogs to objects implies extra round-trips to a server (e.g., custom
> storage backends with JGit; I don't know the state of the art in what
> Google is doing there).

JGit doesn't currently support commit-graph, so it's hard to predict
what performance will be like, but isn't commit-graph is keyed by
SHA1? That makes it hard to do caching, especially when considering
large repositories.

AFAIU, commit-graph would help speed up reachability checks, by being
able to shortcut cases where the commit number proves that some commit
is not ancestor of the other, but you still have to do a revwalk to
conclusively prove reachability.

In our storage system, the revwalk runs on top of packfile data that
must be faulted-in (slow!) from datacenter-wide storage. It's made
worse because we don't support midx yet.

The application that I'm thinking of providing a way for automation to
deal with lagging replicas. This could be done by specifying a

  X-Need-GitRef: $repositoryname~$refname~$SHA1

header on Gerrit requests, that specify that the given $SHA1 must have
been in a recent ref update, and be reachable from $refname. The
reflog has this information organized in a form that suited very well
to answering these questions quickly (assuming the reflog is annotated
such that we can distinguish FF and non-FF updates)



> > Does this make sense, and if yes is it worth proposing a change?
>
> At GitHub we do something similar. We don't generally use reflogs much
> at all, but we keep a custom "audit log": a single append-only file that
> records every ref update in the repository. And its format just happens
> to be one reflog entry per line, prefixed by the updated ref.

The interest of having a standard/convention in Git would be to not
require reftable for folks that want to use this feature.

> And there we do generally annotate the FF-ness of an update by stuffing
> it into the free-form message field (in fact, we shove in a small JSON
> object, so we record multiple fields like the pushing id, IP, etc).
>
> But the main goal there isn't performance (and in fact we don't
> generally consult it for anything outside of debugging). The reason we
> record FF-ness is for later debugging or analysis. We don't prune from
> the audit log, and we don't consider it for reachability when we prune
> objects (since otherwise you'd never be able to prune anything!). So the
> objects sometimes aren't available later to compute, but we still want
> to know if the user did a force-push, etc.

We store reflogs in a global database table, which has this kind of
information, but the Google-specific format is harder to make work
with Gerrit, which is open source.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
