Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809ACC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6BA2311B
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kuxbq2nG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgHFRJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730034AbgHFRGC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:06:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB5C0617A2
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 10:02:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qc22so36305489ejb.4
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RdiEwoccOGLtRxK6FMvgDW3uw1i9JkIpVv5IFqqfAEs=;
        b=Kuxbq2nGIc2mORvyKV+w1XGWj4wt3LIi/owqB2WOWC6FVFzBuIPQEswUMFT9FKZUOa
         iHBkTIRoNtBJt1xCv3KX5eAxpVmGVrHxo7GtM+lVb3Y5OrVIJmXdcC1+kS5Jgzd25kXv
         nOgWPqYnQqQZ6FprA1yVWi6ZRuK2kD599WbUaTSM0KR3V4lRfSxYRw6q5KvlfesFexKD
         /HhVPNB+kBH/vJDyTg55uCLAEM3w/pNDfm6mpKY8RtwUksYFvesg4wF47uxjXCbEg1eD
         o6qGmUsofd3A5U//FHxSYY9yH2QSICILtcrnWDI60DSJ0uVZZd2eb7tVlxR22rRyHmXo
         l1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RdiEwoccOGLtRxK6FMvgDW3uw1i9JkIpVv5IFqqfAEs=;
        b=oErK7oEZn7uWHL7j9pF+zQhJ//5YhEnD089C2xLzJstI/noi6mZ8/bu71ZsfvbrOD/
         i3bTmMpcOT8hyg112O5kVe/GmWMg2e7HPlOzys5q4HJTIAnickdXmTAWpGcxRK2lrNm8
         Ww9oyhJYXntlYiAA8UF+YiEPJ+I4Gi0b/MD/Wbix+zzU4N/sqwmj2GwHC1AAw+kaOgha
         jJSrSzIKAovYrzKdFl346R30qtmtrVV5Qm7UWh/i/kiUvLtd8cmliIHOVKFjyoPTcEVY
         Y1cy40MPQdIRF3NIMqYxl65hcLf13kVKYk3NWjYmt6T/vC/qafk3+zS8eJ4eb9dFFwaX
         C6Rg==
X-Gm-Message-State: AOAM533PHya5q2hpKRjGL+XtymI/dGzzScpONcgYN18v2dq81qYpAZvc
        BROTLGq90bYH92s0znkuz50=
X-Google-Smtp-Source: ABdhPJzXDImN3yPbd0tSza2pfxYVvNFM+rWmca2xhMiGImmjnZZyTtfvYOPZ/7w7TPqNoNWfXwJdOg==
X-Received: by 2002:a17:906:1104:: with SMTP id h4mr5291663eja.456.1596733352917;
        Thu, 06 Aug 2020 10:02:32 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:6810:6f57:8109:3b42? ([2a02:a210:ca2:9c00:6810:6f57:8109:3b42])
        by smtp.gmail.com with ESMTPSA id z10sm4075762eje.122.2020.08.06.10.02.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 10:02:32 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH 8/9] maintenance: auto-size incremental-repack batch
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <c3487fb8e3e72949080f51f341655f37b5f2f03f.1596731425.git.gitgitgadget@gmail.com>
Date:   Thu, 6 Aug 2020 19:02:30 +0200
Cc:     git <git@vger.kernel.org>, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, Jeff King <peff@peff.net>,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FA8F54A-C92D-497B-895F-AC6E8287AACD@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
 <c3487fb8e3e72949080f51f341655f37b5f2f03f.1596731425.git.gitgitgadget@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

> On Aug 6, 2020, at 18:30, Derrick Stolee via GitGitGadget =
<gitgitgadget@gmail.com> wrote:
>=20
> From: Derrick Stolee <dstolee@microsoft.com>
>=20
> When repacking during the 'incremental-repack' task, we use the
> --batch-size option in 'git multi-pack-index repack'. The initial =
setting
> used --batch-size=3D0 to repack everything into a single pack-file. =
This is
> not sustainable for a large repository. The amount of work required is
> also likely to use too many system resources for a background job.
>=20
> Update the 'incremental-repack' task by dynamically computing a
> --batch-size option based on the current pack-file structure.
>=20
> The dynamic default size is computed with this idea in mind for a =
client
> repository that was cloned from a very large remote: there is likely =
one
> "big" pack-file that was created at clone time. Thus, do not try
> repacking it as it is likely packed efficiently by the server.
>=20
> Instead, we select the second-largest pack-file, and create a batch =
size
> that is one larger than that pack-file. If there are three or more
> pack-files, then this guarantees that at least two will be combined =
into
> a new pack-file.

I have been using this strategy with git-care.sh [1] with large success.
However it worth to note that there are still edge case where I observed =
that
pack count keep increasing because using =
'--batch-size=3D<second-biggest-pack>+1'
did not resulted in any repacking.
In one case, I have observed a local copy went up to 160+ packs without =
being able
to repack.

I have been considering whether a strategy such as falling back to the =
'(3rd biggest
pack size) + 1' and 4th and 5th and so on... when midx repack call =
resulted in no-op,
as that was how I fixed my repo when the edge case happen.

Such strategy would require a way to detect midx repack to signal when =
no-op happen,
so something like 'git multi-pack-index repack --batch-size=3D123456 =
--exit-code' would
be much desirable.

>=20
> Of course, this means that the second-largest pack-file size is likely
> to grow over time and may eventually surpass the initially-cloned
> pack-file. Recall that the pack-file batch is selected in a greedy
> manner: the packs are considered from oldest to newest and are =
selected
> if they have size smaller than the batch size until the total selected
> size is larger than the batch size. Thus, that oldest "clone" pack =
will
> be first to repack after the new data creates a pack larger than that.
>=20
> We also want to place some limits on how large these pack-files =
become,
> in order to bound the amount of time spent repacking. A maximum
> batch-size of two gigabytes means that large repositories will never =
be
> packed into a single pack-file using this job, but also that repack is
> rather expensive. This is a trade-off that is valuable to have if the
> maintenance is being run automatically or in the background. Users who
> truly want to optimize for space and performance (and are willing to =
pay
> the upfront cost of a full repack) can use the 'gc' task to do so.
>=20
> Create a test for this two gigabyte limit by creating an EXPENSIVE =
test
> that generates two pack-files of roughly 2.5 gigabytes in size, then
> performs an incremental repack. Check that the --batch-size argument =
in
> the subcommand uses the hard-coded maximum.
>=20
> Helped-by: Chris Torek <chris.torek@gmail.com>
> Reported-by: Son Luong Ngoc <sluongng@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Generally, I have found working with '--batch-size' to be a bit =
unpredictable.
I wonder if we could tweak the behavior somewhat so that its more =
consistent
to use and test?

Thanks a lot for making this happen.
Hope this patch would make it in stable soon

Cheers,
Son Luong.

[1]: https://github.com/sluongng/git-care=
