Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D983C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 17:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiI1RNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiI1RN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 13:13:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63FEF088D
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:12:58 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D44391B6160;
        Wed, 28 Sep 2022 13:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PUP0iKXbHQoGTjwHlW6AbGq9A3ZVw8lFvweW2O
        VUaDM=; b=QE+jUu1TDGu56P+ZXK8IqgtypxnpT9HAvN1dbssHapGbgN82tkQwaz
        3Q7N0MAwqPt1Pg07sWR7vA7bw4IktvWP/ja/SMp1p2eGGZZrU6L6wfBz4pGqEkwL
        +wNAoQhj31Qx3d0xh13FBIRzM23GbtYusDZIWA1R+rexaXqhMk7Wo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC5EB1B615F;
        Wed, 28 Sep 2022 13:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 648041B615E;
        Wed, 28 Sep 2022 13:12:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julia Ramer <prplr@github.com>
Cc:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH] embargoed releases: also describe the git-security list
 and the process
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
        <xmqqa67h8zac.fsf@gitster.g>
        <CADq8SzUUoi6=6ggxkeTUf2y0WmeAMMjuq8_OCej0smF7OabPiQ@mail.gmail.com>
Date:   Wed, 28 Sep 2022 10:12:52 -0700
In-Reply-To: <CADq8SzUUoi6=6ggxkeTUf2y0WmeAMMjuq8_OCej0smF7OabPiQ@mail.gmail.com>
        (Julia Ramer's message of "Tue, 27 Sep 2022 15:56:20 -0700")
Message-ID: <xmqqtu4rv2wb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9D20030-3F50-11ED-A33B-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[moving git-security@ to BCC; those who have been following the
thread, please switch to the main list]

> All of Junio's edits and call-outs are reasonable and I'll incorporate
> them into the next version.

Thanks.

>> > +- Once the review has settled and everyone involved in the review agrees that
>> > +  the patches are ready, the Git maintainer determines a release date as well
>>
>> s/maintainer determines/& and others determine/ or "stakeholders
>> discuss and agree on".  You might want to mention that the schedule
>> for disclosure and release tend to be constrained by so called patch
>> Tuesday, which is the least flexible among various binary packagers.

By the way, this "we account for patch Tuesday" is not "the only 800
pound gorilla in the room inherently has rights to dictate their
terms".  It is merely that "other packagers are being nice and extra
accomodating", and when another even less flexible packager requests
a prolonged schedule, we might accomodate their needs, depending on
the nature of the issue.

On the other hand, the git users community may not be able to wait
for the next month to apply an unusually urgent fix, and a binary
packager with a coarse release granularity may have to be creative
on such an occasion.

In this hypothetical timeline:

    A---B-B-B-B-B-B-B-B---C

              D0----E0           D1----E1 (next month)

where

    A: problem reported
    B: solution proposed, discussed, and finalized
    C: public coordinated disclosure and release date

    Dn: cut-off date for "monthly security updates" for a packager
    En: date "monthly security updates" is issued by a packager

the wider Git user community may not be able to afford to wait until
date E1 of the next month by delaying C, even if date D0 for this
month's "security updates" for a particular packager comes before
the solution gets finalized.

If the coordinated release C falls after the deadline D0 for the
upcoming "monthly security updates" (not singling out Microsoft by
mentioning "patch Tuesdays" anymore, as this applies generally to
anybody whose release granularity is more coarse than other distros
find comfortahble for security fixes) for a packager, but if an
early round of proposed fix is seen, they can independently make
their own judgement to include the non-final fix in their binary
release at their cut-off date D0, while withholding the source at
least to the agreed upon coordinate disclosure date C, for example.

They may later want to update to the final fix by date D1 to be
included in their next "monthly security updates" on date E1, which
would be an extra work, but that is the cost of running a coarse
release schedule.

I do not know how to concisely phrase the above to fit in the
framework of your document, but some of the above issues were
brought up elsewhere, so I thought I'd better share it here.

Thanks.
