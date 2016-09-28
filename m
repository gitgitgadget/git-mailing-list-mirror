Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10F91F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 19:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932607AbcI1T2E (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 15:28:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56126 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932299AbcI1T2E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 15:28:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A56E541047;
        Wed, 28 Sep 2016 15:28:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=u3U6QrEiO0Nm
        ijkTl8ygHNhl2x8=; b=NZQyR8BYdM+M4owwES0DVlzi9pw451ya0pMZk/sIP9yB
        OROmErX3iQSVM44rfMfXDzngTH0wdBxr6S3e259TiHeznzxNGy/vSWM4H+BHhWg6
        tqfv+t5agDmBsXT3VRLw7srF/tLYXA8uKSo+dscz0m2mXYPFqOsXbE12NOmcJMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nBF5gT
        BxnMIrpgKjeBEHye3+ddb+dp1r4pE4TObJ/m+67phrh7gFKLxOB5mFmCDoKg6yPq
        io19ur3bolSZSoegyEhvo34Yeh07Eu/Can3UJDHuUFK5eHenShxVPcj+HPArIGFq
        pk1SIW8ppbkxPKVA/1sHBTk4bVP9GPSXOImy4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E92441046;
        Wed, 28 Sep 2016 15:28:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 281484103E;
        Wed, 28 Sep 2016 15:28:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
References: <20160928114348.1470-1-pclouds@gmail.com>
        <20160928114348.1470-2-pclouds@gmail.com>
Date:   Wed, 28 Sep 2016 12:28:00 -0700
In-Reply-To: <20160928114348.1470-2-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 28 Sep 2016 18:43:46 +0700")
Message-ID: <xmqqzimrj03j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABF13EFA-85B1-11E6-A23D-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The original commit d95d728aba06a34394d15466045cbdabdada58a2 was
> reverted in commit 78cc1a540ba127b13f2f3fd531777b57f3a9cd46 because we
> were (and still are) not ready for a new world order. A lot more
> investigation must be done to see what is impacted. See the 78cc1a5 for
> details.
>
> This patch takes a smaller and safer step. The new behavior is
> controlled by shift_ita flag. We can gradually move more diff users to
> the new behavior after we are sure it's safe to do so. This flag is
> exposed to outside temporarily as "--shift-ita" for people who prefer
> "git diff [--cached] --stat" to "git status"

Let's stop advertising this as a resurrection of something else.
The original that was unconditional was simply broken.

It is very good to refer to it (and its reversion), when justifying
why this version takes the particular approach to introduce a new
optional behaviour that can be toggled on selectively, by explaining
why doing this unconditionally was a broken idea that needed to be
reverted later.

But you would need to explain what problem this patch attempts to
solve and how before even going into that.  The above two paragraphs
are backwards.

As I already said, --shift-ita is not quite descriptive and I think
it should be renamed to something else, but I kept that in the
following attempt to rewrite:

    Subject: diff-lib: allow ita entries treated as "not yet exist in ind=
ex"

    When comparing the index and the working tree to show which
    paths are new, and comparing the tree recorded in the HEAD and
    the index to see if committing the contents recorded in the
    index would result in an empty commit, we would want the former
    comparison to say "these are new paths" and the latter to say
    "there is no change" for paths that are marked as intent-to-add.

    We made a similar attempt at d95d728a ("diff-lib.c: adjust
    position of i-t-a entries in diff", 2015-03-16), which redefined
    the semantics of these two comparison modes globally, which was
    a disastor and had to be reverted at 78cc1a54 ("Revert
    "diff-lib.c: adjust position of i-t-a entries in diff"",
    2015-06-23).  To make sure we do not repeat the same mistake,
    introduce a new internal diffopt option so that this different
    semantics can be asked for only by callers that ask it, while
    making sure other unaudited callers will get the same comparison
    result.  This internal option is also exposed temporarily as
    "--shift-ita" to help experiment.

After reading the three patches through, however, I do not think we
use the command line option anywhere.  I'm inclined to say that we
shouldn't add it at all.  Or at least do so in a separate follow-up
patch "now we have an internal mechanism, let's expose it anyway" at
the end.  Which means that the last sentence in my attempted rewrite
should go.

The patch to diff-lib.c machinery looks good.

Thanks.
