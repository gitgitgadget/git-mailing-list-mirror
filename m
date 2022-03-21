Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071F5C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 17:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351912AbiCUR7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 13:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351910AbiCUR7l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 13:59:41 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6AE11A12
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 10:58:12 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id e4so13983162oif.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k8UcA00NPPr6aSt7Pj9LiSuI3KmT3FCQBgPaEDkGwkY=;
        b=OoTJ9UcRYN0IB7z1zpYmFACK/8wqiSVF8BeUzKnLY7o5z17xvU/6VFz017rNXFNBUp
         fB8Okkm+iKqAKoqQK2rNbHfR8rbWt5xtrr+j1/TCDCYIjJq+WqtizGJZD/rO43wx6Jzy
         1BHpy/ClVs9MRDA7DjzUM69byCwKrGoqoFGRV7Co6k0fFMf2EO8VlzbrLgkAVIB6IFaJ
         qoXIKRLEEedpma1eCVcTiW5fd1uKlA6KJKVtOa9KvBrnQl/iFwuYuNi4R+sTwlPVfQr+
         AG0uZAEzTScNkAmqpeOXQ1roDEkNsHzCknS3kHMJnLI5ioa61pT/uXoLwCBo/XJrf63s
         C+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k8UcA00NPPr6aSt7Pj9LiSuI3KmT3FCQBgPaEDkGwkY=;
        b=aNJLw0CfHRdZWqU6vg4YrcqhKz/sUxkl9aaOqgzepjbgbMj9IgJyVaR5/RyApEBzat
         X9yHK+30HVJNHvTsHBHU55SyeXQzp+gxIu+Eou1clN0i4+7zTHy7KXWrCPQcMR5z9uRi
         pJZMTG4nw3y50vR8/NdZQzHiN7pGRB+sqoD0Vtt0TAzUl8xd3Y/uvU5gsL1BEPopwUfz
         WQA/ZGLOR9dbBCa8Gn0NJ0YazljWy3U2XrBZvDIxf9yOILRkJSd6KrGdGe2Pp3PlF7Jp
         M1AQrA2np25QVtKCkOki7vvPX2WhTrm01cIPlb46Y7ugf8IImlZQkY8RbSQ8532FZiWu
         ixCw==
X-Gm-Message-State: AOAM531x/ekzJozt9/BhAS5JhmzsOicHQ/Au1RFhZCzE8nBpCwdAiIwK
        TTBBaxInsyzVwwH+yjME8IC71eELT5sXiEKPoXPNwg==
X-Google-Smtp-Source: ABdhPJxVUAAE606FAvAEQAobBYPtm9/8I8Oec/1ZT8X5TR6RFI9nKnRuTsBb7QQfuuc2VlMof4QAl1rNfKJuMbCz6bw=
X-Received: by 2002:a05:6808:1386:b0:2d9:a01a:488a with SMTP id
 c6-20020a056808138600b002d9a01a488amr156578oiw.213.1647885491295; Mon, 21 Mar
 2022 10:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
 <20220309002729.3581315-1-calvinwan@google.com> <CACf-nVeEBDQse0coA7QpQmQ92y9kDwXoTmayD8_NY2OHNZ5v+g@mail.gmail.com>
 <xmqqzglylslh.fsf@gitster.g> <CACf-nVf-O5+_nMrdBiRJ5sHg7g+DjTkPy1VuErDnEXJ0-9OJ0A@mail.gmail.com>
In-Reply-To: <CACf-nVf-O5+_nMrdBiRJ5sHg7g+DjTkPy1VuErDnEXJ0-9OJ0A@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 21 Mar 2022 10:58:00 -0700
Message-ID: <CAFySSZAunjiEsSMETdYB3TFVppPD5RfjQjMmvTqwy6mEteninA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] fetch: add repair: full refetch without negotiation
To:     Robert Coup <robert@coup.net.nz>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

Documentation for the config setting is an acceptable solution!
Apologies for the late response -- wanted to wait and see if anyone
else on the list had any last thoughts. Also I noticed you were hoping
that Jonathan Tan could take a look at your patch on the What's
Cooking thread. Before I sent my first review out, I discussed your
patch with him so he's been briefed.

Reviewed-by: Calvin Wan <calvinwan@google.com>


On Thu, Mar 10, 2022 at 6:29 AM Robert Coup <robert@coup.net.nz> wrote:
>
> Hi,
>
> On Wed, 9 Mar 2022 at 21:32, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > The way I read Calvin's suggestion was that you won't allow such a
> > random series of "git fetch"es without updating the "this is the
> > filter that is consistent with the contents of this repository"
> > record, which will lead to inconsistencies.  I.e.
> >
> >  - we must maintain the "filter that is consistent with the contents
> >    of this repository", which this series does not do, but we should.
>
> I don't think we should strive to keep this "consistency" =E2=80=94
>
> >  - the "--refetch" is unnecessary and redundant, as long as such a
> >    record is maintained; when a filter settings changes, we should
> >    do the equivalent of "--refetch" automatically.
>
> =E2=80=94 we don't know how much data has been pulled in by fetches from
> different promisor and non-promisor remotes (past & present); or
> dynamically faulted in through branch switching or history
> exploration. And I can't see any particular benefit in attempting to
> keep track of that?
>
> =C3=86var suggested in future maybe we could figure out which commits a
> user definitively has all the blobs & trees for and refetch could
> negotiate from that position to improve efficiency: nothing in this
> series precludes such an enhancement.
>
> > ... isn't "git fetch --fitler" that does not update the configured
> > filter (and does not do a refetch automatically) a bug that made the
> > "refetch" necessary in the first place?
>
> I don't believe it's a bug. A fairly obvious partial clone example
> I've used before on repos where I want the commit history but not all
> the associated data (especially when the history is littered with
> giant blobs I don't care about):
>
>   git clone example.com/myrepo --filter=3Dblob:none
>   # does a partial clone with no blobs
>   # checkout faults in the blobs present at HEAD in bulk to populate
> the working tree
>   git config --unset remote.origin.partialclonefilter
>   # going forward, future fetches include all associated blobs for new co=
mmits
>
> Getting all the blobs for all history is something I'm explicitly
> trying not to do in this example, but if the next fetch from origin
> automatically did a "refetch" after I removed the filter that's
> exactly what would happen.
>
> We don't expect users to update `diff.algorithm` in config to run a
> minimal diff: using the `--diff-algorithm=3D` option on the command line
> overrides the config. And the same philosophy applies with fetch:
> `remote.<name>.partialclonefilter` provides the default filter for
> fetches, and a user can override it via `git fetch --filter=3D`. To me
> this is how Git commands are expected to work.
>
> Partial clones are still relatively new and advanced, and I don't
> believe we should try and over-predict too much what the correct
> behaviour is for a user.
>
> I'd be happy adding something to the documentation for the
> `remote.<name>.partialclonefilter` config setting to explain that
> changing or removing the filter won't backfill the local object DB and
> the user would need `fetch --refetch` for that.
>
> Thanks,
> Rob :)
