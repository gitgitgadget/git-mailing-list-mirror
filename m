Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AB3C38A2D
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 00:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiJ0AEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 20:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiJ0AEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 20:04:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D021408A
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 17:04:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y12so16304edc.9
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 17:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=canva.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1VmcQZ3zbaKgUyWL83HE4cBXrq0toBRa9Vv9fuI/18=;
        b=cZmOYrQrbQj/1fwRngtnrDjA7MRfFfmeCIGNlRVYSQI7B8UOh8JZMVc/1dlvjSmWBd
         juExac/wLaWFSYFmp/3T8e4DR0cLtx7NslQBg2xcCAp1bR5Nq5nY87xo8SX6KoYjw1or
         G666UAA4z3PHTn93lYPQYvGX4yFrQzNbk73+mqc+S+AcohsTsw7MewCQhJ5zMMJ0majy
         DoB6kV8dBKx3vZMnF3M2St69w1XcNIQRAmJgIWK0bop+RmtFJDORXKW7RZ1GflYOBPkN
         VMDCOvGmBWKO7q79qbYqW30xrANFqcTCiE2vyW9STyl1fO9W0qfbz1J9RYUWXnNPMN5X
         n7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1VmcQZ3zbaKgUyWL83HE4cBXrq0toBRa9Vv9fuI/18=;
        b=gfIw9z0HUSJtzJjbim/zn7eGX2EpVjAdsUF+IrqBv3+YQ1+5ZLdGFUSqm3shrqDJXJ
         o5TaM2j3bKRETFQvUx3J8+K0Uuw4L2wUNtknCYspMbdEJGAFUAqR0JVSB8B8vz/0yY4z
         WIfUCKGPb4VgPiyS9vsJDHYDBkL2qWIV6xY0m2w4SLZdnLlWcB0Ez/dBTe0nqDtGrTSf
         uzIHvpM9TDB8hmvthLE8bw3j8R1wzTvqxz+od+qtnYH7Z2KBo25ptuju+93j9Wb6skIx
         iJXyMuAxHpWvyzeZVcrVPdlXnMHG9PpvTSwMP2rTMnA9tCJHFSf+uFj8qBgTW8Fgtjn3
         tpxQ==
X-Gm-Message-State: ACrzQf1FxXM2Xh5/U3M9OjMNiU/uO1HeFN2XRHa5qpGcyYeV5aPWtTtk
        Ue2TOFN2tUH5YRkhofVtGz/gOTeOi2bBeZK1gIWtNXYaJCS8u+qjPNDLWUwZs/W2bbQkKJ2+bm+
        xYTKtZ5AVzqw0avg1eXKJNxqLVRKjsf54our+Gc3dw0ZsfxDWlTlnrpnXNMQheB+qft2fntHsiF
        pzZX6wj3c469IthaqWr6CyHy30wVa41B9el9csoQ==
X-Google-Smtp-Source: AMsMyM4O+PsPMuWBKtJsbYRp4KKUK9W3yKvndLaqz2wqxayXlOmcScTcm+zGSi1Mt4yhwPKDCLyGy5fkJTDhJqBr/Is=
X-Received: by 2002:a05:6402:144a:b0:461:8e34:d07b with SMTP id
 d10-20020a056402144a00b004618e34d07bmr22409017edx.426.1666829077794; Wed, 26
 Oct 2022 17:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1368.git.git.1666742722502.gitgitgadget@gmail.com>
 <xmqq35bbmfz6.fsf@gitster.g> <d4103788-5153-11f2-487f-5cc795d261a8@jeffhostetler.com>
 <xmqq8rl2lgl3.fsf@gitster.g> <0bb8dc64-aad1-e3c1-66ef-c2e8d6600189@jeffhostetler.com>
In-Reply-To: <0bb8dc64-aad1-e3c1-66ef-c2e8d6600189@jeffhostetler.com>
From:   Anh Le <anh@canva.com>
Date:   Thu, 27 Oct 2022 11:04:01 +1100
Message-ID: <CAOZNrpHkh+FWTLAJhCZVPdh2fo1sq1YfgsG5Ou3vO2013njCaA@mail.gmail.com>
Subject: Re: [PATCH] index: add trace2 region for clear skip worktree
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anh Le via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: canva,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Junio and Jeff for the feedback! I hadn't considered that
`ensure_full_index()` would mean the loop can only at most restart
once. I'll action the feedbacks:
- count both loop iterations separately with int instead of intmax_t
- remove the restart counter
- don't log metrics if it's 0

Regards,
Anh


Regards,
Anh


On Thu, Oct 27, 2022 at 5:29 AM Jeff Hostetler <git@jeffhostetler.com> wrot=
e:
>
>
>
> On 10/26/22 12:01 PM, Junio C Hamano wrote:
> > Jeff Hostetler <git@jeffhostetler.com> writes:
> >
> >> In the worst case, we walk the entire index and lstat() for a
> >> significant number of skipped-and-not-present files, then near
> >> the end of the loop, we find a skipped-but-present directory
> >> and have to restart the loop.  The second pass will still run
> >> the full loop again.  Will the second pass actually see any
> >> skipped cache-entries?  Will it re-lstat() them?  Could the
> >> `goto restart` just be a `break` or `return`?
> >>
> >> I haven't had time to look under the hood here, but I was
> >> hoping that these two counters would help the series author
> >> collect telemetry over many runs and gain more insight into
> >> the perf problem.
> >
> > Without being able to answer these questions, would we be able to
> > interpret the numbers reported from these counters?
> >
> >> Continuing the example from above, if we've already paid the
> >> costs to lstat() the 95% sparse files AND THEN near the bottom
> >> of the loop we have to do a restart, then we should expect
> >> this loop to be doubly slow.  It was my hope that this combination
> >> of counters would help us understand the variations in perf.
> >
> > Yes, I understand that double-counting may give some clue to detect
> > that, but it just looked roundabout way to do that.  Perhaps
> > counting the path inspected during the first iteration and the path
> > inspected during the second iteration, separately, without the "how
> > many times did we repeat?", would give you a better picture?  "After
> > inspecting 2400 paths, we need to go back and then ended up scanning
> > 3000 paths in the flattened index in the second round" would be
> > easier to interpret than "We needed flattening, and scanned 5400
> > paths in total in the two iterations".
>
> Good point and I was wondering about whether we might see "2 x 95%"
> values for path_count in really slow cases.  And yes, it would be
> better to have `int path_count[2]` and tally each loop pass
> independently.
>
> I guess I was looking for a first-order "where is the pain?" knowing
> that we could always dig deeper later.  That is, is the lstat's or
> is it the ensure-full and index rewrite?  Or both?
>
> We have other places that do lstat() over the cache-entries and have
> added code to spread the loop across n threads.  I doubt that is needed
> here and I didn't want to lead with it.
>
>
> >
> >> WRT the `intmax_t` vs just `int`: either is fine.
> >
> > I thought "int" was supposed to be natural machine word, while
> > incrementing "intmax_t" is allowed to be much slower than "int".
> > Do we expect more than 2 billion paths?
> >
>
> You're right.  An `int` would be fine here.
>
> Thanks,
> Jeff

--=20
**
** <https://www.canva.com/>Empowering the world to=C2=A0design
We're hiring,=20
apply here <https://www.canva.com/careers/>!=C2=A0Check out the latest news=
 and=20
learnings from our team on the Canva Newsroom=20
<https://www.canva.com/newsroom/news/>.
 <https://twitter.com/canva>=20
<https://facebook.com/canva> <https://au.linkedin.com/company/canva>=20
<https://twitter.com/canva>=C2=A0 <https://facebook.com/canva>=C2=A0=20
<https://www.linkedin.com/company/canva>=C2=A0
 <https://instagram.com/canva>



