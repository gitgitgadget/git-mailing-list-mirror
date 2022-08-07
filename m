Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA45C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 16:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiHGQsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 12:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiHGQsl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 12:48:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B084388E
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 09:48:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gk3so12666826ejb.8
        for <git@vger.kernel.org>; Sun, 07 Aug 2022 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=NBQ/xpFGecBaquomRX/nxrayIZPRIoJ2TVyzJDSrRX4=;
        b=QaZNhwX+kVCUOA+t6ugMomZnWB+YLSNf+IeKea8MNCT1AYgsK6pcl/fM3iJ+mJ0C8m
         Wmzv71nsyIIdW2WIMMliBZuDNapUqhu5S1Oa4YZNk2bvWspVBphIS0soypTI6wCv7AUV
         1cp8tSY0XmXeyGbwprgak7xDo8OxIzFrpeTEQyb9BrnV3rFdZPXoXiAW15ySJphpn/2D
         Tgyvad6KCBnCVJXcYm0tZEmbXmhBKi1u8YNp/MCQge/Kwh3f3vpFunmwJ/EbSvZjN+cN
         30l1WU5mj1opxK7iE4ErZVq1JpGHIzFc0+AT98/COHE9Id3hB/khsVtUD+MgZ2ZdbLGX
         vU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=NBQ/xpFGecBaquomRX/nxrayIZPRIoJ2TVyzJDSrRX4=;
        b=BjXimH0+QMAFnmreBskS3WgjMAAYQryjkmWKjyMtuvknafEFAa8J3X6q8fN943a1qL
         0XWebEv89ElfcGQSaQ2CPA58fi1e3moWfs6BQ/QCX2zd2Q0B1kgRDbgVD9/pVtq37av6
         2UeA5aAwuMr2qVSTPuxLmmCrm442gXduD/iwax9ZU42KFr7KoRw22k9lVMaKuAVSnwFC
         ftVSUDKP5e9VsIf5spScFFP/0OCP9vZ+mIHDGbi8BbfIu+O/rwIMShHkbh+LcEqK4NQp
         NZfe+BSqHmnU5SDiDk9JCkhXmpJFzKSBLktgVf9/IDIfrcOoAymSUQdJ2U0pZDH/23WN
         2y7A==
X-Gm-Message-State: ACgBeo2g4GmZVN76UgbQWj2xYfMF8KUoJO+Rz0Sw9CqmHmmc2QXPNhLT
        VVeoU1pw2OdBoTC3LjMVulbmmQEwfDGI4EZ5VXbxaQH+
X-Google-Smtp-Source: AA6agR7Q/V5iwu5xaFLlLCHQOkLr88evRqmdGvxNueuv1dFz8P3gLbBS5yWEVY+qNm4ftJCpZit2GTK2Q/a0ut5hbHk=
X-Received: by 2002:a17:907:75d9:b0:730:990f:6d6d with SMTP id
 jl25-20020a17090775d900b00730990f6d6dmr11355833ejc.638.1659890918738; Sun, 07
 Aug 2022 09:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <e564b1e3-0f34-dce3-400d-439a40ec4d48@intel.com>
In-Reply-To: <e564b1e3-0f34-dce3-400d-439a40ec4d48@intel.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 7 Aug 2022 09:48:27 -0700
Message-ID: <CAPx1Gvd9xLdJaWiTN1MrktyEMfKmAjTx9zxOVcOnRv7r9n_ZiQ@mail.gmail.com>
Subject: Re: [Question]: Question about "cherry-pick" internal
To:     "Wang, Lei" <lei4.wang@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 3, 2022 at 6:42 PM Wang, Lei <lei4.wang@intel.com> wrote:
> I heard that cherry-pick is just a kind of merge, the difference between
> it and the traditional merge is that it treats the parent commit of the
> commit you want to cherry-pick as the merge-base ...

This is indeed the case.

> [During merging:] If the [two] diff[s] modified the same
> line, then a conflict occurs.

This is also true=E2=80=94but it's not the whole story.

> If the above is true, but why when I cherry-picked a commit, a conflict
> occurs even the 2 diffs didn't modify the same line, they modified the
> two consecutive lines (line n and line n + 1), so what can be the
> potential reason for this?

In any merge, if the two sides modify *adjacent* lines=E2=80=94as is the
case here=E2=80=94that, too, is considered a conflict (at least Git conside=
rs
it as one; not all merge algorithms do that).

Note that if the two diffs modify the same line(s) in the *same way*=E2=80=
=94
e.g., both add the same text or delete the same text=E2=80=94Git will take
only *one copy* of the change, without calling it a conflict. In some
cases this may be incorrect: consider. e.g., merging the debits and
credits in a series of accounting records, where the dollar amounts
are identical, but the transactions are different.  If Alice spent $5
and Bob spent $5, the correct result is not that "$5 total was spent"
but rather $10.

Still, for the kinds of tasks *Git* is asked to merge, this is normally
the correct result, so it is the result Git produces.

Git is a tool=E2=80=94or rather, a set of tools=E2=80=94and its automated w=
ork is
never a substitute for expert evaluation.  You, the user, must do
some work here as well, to make sure that what Git did is in fact
correct for your particular situation.

Chris
