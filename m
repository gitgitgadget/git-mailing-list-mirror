Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86457C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 19:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651392072D
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 19:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewZ08c4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDUTEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUTEq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 15:04:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD17C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 12:04:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k1so17873310wrx.4
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 12:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=robzBPtEI66vyyE+EFamo2Z72hFrpas35NXd44Yk4zw=;
        b=ewZ08c4VD7rcMTXgWICwmUSGCQ/LOAOhyjjQMZlHfAZgBkqMrnLATSu+tySiWgjVUL
         nOWxu/0iHpQn1mAj+kdEQccahskFQ3UbbwwnzEASNzCj4uxUN9xnmFKGxPBVg00NyF+/
         uEF1Y0rGOValRWYgzxIiZh50Y0Z8zPOqYGZwHIrIlPB33ipZ2wg216D15EyxAd/HMWSF
         yfOQBDKmJ3S3lavMIGljxHvaYZvBOAImHyRhVIBPVghclM1VdhD6zLIX3okjT+o4lHmH
         FMxATfCEHnbMQEufeUe5JgW7uHqqu/Jx/vEGN5aJ7TvRb8OxDLYR+8ce8kNW29KIoVq0
         pNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=robzBPtEI66vyyE+EFamo2Z72hFrpas35NXd44Yk4zw=;
        b=Rm0tR/WcsjmA8kqkXsOMmAbV3TEM3iIJrSzwp5zhFN0ogzxqkMgjKRvcqFvDNCjyB5
         rHEz4USTaVMz3FpsC5C3VNeo9xOb37gRGDt1WfAJ6g1CuKSKuC02e7Xlbmaj5qW/EIyZ
         mQf18ECz4w7g6nriM/lhAUwbKDdzT4WYMEJylynn83arhvET7gpG3t0X7TKqMVPsZbRH
         1JbA2FlnKj0h4+CA1MrWAQw6NBhiKVrXDQrnSTxMzjQW74Rb2eMC8sH0pZ933JE5mBaQ
         Nrf0P1BYQ0l77jCpnFpz0FDf+9VgBUfKCWI9ZrL3IWdHh5pRUQM0SgPZGHLL6YbfvP2a
         GY0g==
X-Gm-Message-State: AGi0Pua+e11Gd/7KXzmIwC5aZC3D9JejgNPQfZLG7QTKt9qFl05uMUhw
        y6BOrLrYQ62QG7iJ9COowwoI5YHoiz7yuOwhsug3cQ==
X-Google-Smtp-Source: APiQypJCk0WcFXQlXXHLDdelJwI8PpPe9ddIZ0nUxkx3FeAAVddqaVcgXC6zM4RntKA46iLAUwrmnybODT14kxMlgUQ=
X-Received: by 2002:adf:8284:: with SMTP id 4mr25657842wrc.6.1587495884127;
 Tue, 21 Apr 2020 12:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
 <pull.539.v9.git.1587417295.gitgitgadget@gmail.com> <a30001ad1e8f94a0f3901c1694c3dd660ba1e7c0.1587417295.git.gitgitgadget@gmail.com>
 <xmqqeeshrev2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeeshrev2.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 21 Apr 2020 21:04:32 +0200
Message-ID: <CAFQ2z_Nm9tRVr0cBt=bV5OaTw-VRK5z1hqOwn-TmT=mNe9Xrgg@mail.gmail.com>
Subject: Re: [PATCH v9 09/10] Add reftable library
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 21, 2020 at 12:07 AM Junio C Hamano <gitster@pobox.com> wrote:
> Shouldn't this be executable, even though the readme tells the
> reader to run "sh update.sh"?

Done.

(should I post an updated version of the patch series for these minor
changes, or is it OK to fold them with the next major update?)

> > +set -eux
>
> Use of -e and -u are understandable but -x is a bit unusual unless
> one is debugging...

Done.

> > +((cd reftable-repo && git fetch origin && git checkout origin/master )=
 ||
> > +git clone https://github.com/google/reftable reftable-repo) && \
>
> I think you can discard most of the '\' at the end of the line, as
> the shell knows, when you stop a line with &&, you haven't finished
> talking to it yet.  That would make the result slightly less noisy
> to follow.  We don't rely on "set -e" in this project, but this is a
> borrowed file from our point of view---as long as we are using -e,
> wouldn't it make more sense to take full advantage of it and do
> without &&?

Done.

> > +cp reftable-repo/c/*.[ch] reftable/ && \
> > +cp reftable-repo/c/include/*.[ch] reftable/ && \
> > +cp reftable-repo/LICENSE reftable/ &&
> > +git --git-dir reftable-repo/.git show --no-patch origin/master \
> > +> reftable/VERSION && \
>
> > +sed -i~ 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|' ref=
table/system.h
>
> "sed -i" is probably GNUism that does not port well.

done.

> > +rm reftable/*_test.c reftable/test_framework.* reftable/compat.*
>
> I presume that this is because we copied everything that match
> c/*.[ch] and is not about removing what used to exist in reftable/
> directory locally?  Not complaining, but checking if I am reading
> the intention of the code correctly.

correct.

> > +git add reftable/*.[ch]
>
> As we flattened when copying from c/include/*.[ch], this "git add"
> can also be flat, which makes sense.  Don't you need to also add the
> LICENSE file in there?

Done.

> Two comments on the design:
>
>  - The list of "what to copy in" largely depends on the upstream
>    reftable library; hardcoding the patterns here would make it
>    harder to reorganize the files for the upstream project.  I
>    wonder if it makes more sense to reserve a single path in the
>    reftable-repo and hardcode the knowledge of what to copy out
>    there?  That would mean the resulting update.sh here can become
>
>         (git -C reftable-repo pull --ff-only && git clone ...) &&
>         reftable-repo/copy-out-to-git-core.sh reftable/
>
>    and the copy-out-to-git-core.sh script that comes with the
>    upstream reftable library is the only one that needs to know
>    where the license and C source files are in the same version as
>    itself, and how to produce $1/VERSION file using the commit log
>    message of the commit it comes from.
>
>  - The above procedure (with or without the "who should know what to
>    copy" change) would cope well with modified and new files in the
>    reftable upstream, but does not remove a library file that used
>    to exist (and copied to the git-core project) that no longer is
>    needed and shipped.  It appears that there has to be some way to
>    remove them.

You are correct, but once this is working to the extent that it's
accepted into git-core, I expect imports to be infrequent, and I think
it's not worth the effort to automate this further. If files are
renamed, the result will likely not compile, so this mistake will be
easy to catch.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
