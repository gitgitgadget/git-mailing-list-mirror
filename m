Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D12CC433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338FC22284
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l3qlrmsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbgJIS5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 14:57:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56024 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388231AbgJIS5B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 14:57:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 062C7DC1ED;
        Fri,  9 Oct 2020 14:56:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EXHesWrSz3iOSKb/qP7oJokoE2k=; b=l3qlrm
        sLsARLWMJTMLobH/x2oTSbc2W10Ug+odgl720s1IAut84iMDCT0O2WpLIyxw3cVU
        HxLprjZkJsrRxCZLoRGFCCpFUcy2gvj1+lAQ5vYFawJCgEmT1RxECqPZcqir5OWJ
        MlTC1vzvC4Iw9pEQC9HoD+IaGyWqfv9ydP6V8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xRJdlZon4anIe4gjn04kT/wkKpsYSESs
        m5Hl9+v1d0WEk/6e4TfVvpnCQ7YScA5KcPVTsZlxKxwAtDeoGbn39V0Jm7p4Ibun
        4E34bVKzkMTIG/vquv4/+oSPo2O1x6szOfOmQgyb7maRv1MYOrK8no2g5Q3gVJYV
        MM7WG8QZ2wY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3543DC1EB;
        Fri,  9 Oct 2020 14:56:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8C6FADC1E9;
        Fri,  9 Oct 2020 14:56:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Webster <chris@webstech.net>,
        "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
        <20200922170745.GA541915@coredump.intra.peff.net>
        <xmqq1ritlmrk.fsf@gitster.c.googlers.com>
        <CAGT1KpU4Kjv2PEAA7-bNbGp2DFvfsKqABuUK68128xkLjdcEhA@mail.gmail.com>
        <CAGT1KpXz4nFBu2xkVSaoW4DgXc_5oB69MQRQW=365gfgd_R-mQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2010091519460.50@tvgsbejvaqbjf.bet>
        <xmqqtuv3tlkv.fsf@gitster.c.googlers.com>
        <20201009175917.GA963340@coredump.intra.peff.net>
        <xmqqeem7tgh4.fsf@gitster.c.googlers.com>
        <20201009181827.GA965760@coredump.intra.peff.net>
Date:   Fri, 09 Oct 2020 11:56:52 -0700
In-Reply-To: <20201009181827.GA965760@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 9 Oct 2020 14:18:27 -0400")
Message-ID: <xmqq8scfteh7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32D5932A-0A61-11EB-805D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 09, 2020 at 11:13:43AM -0700, Junio C Hamano wrote:
>
>> > As the other person in the discussion, I'm sufficiently convinced that
>> > doing this just for PRs is a good step for now. I.e., I think the
>> > "completed form" is just what was posted already (though I agree it is
>> > often convenient to the maintainer to re-post the patch as part of the
>> > ping).
>> 
>> Yes, and CC'ing those who were involved in the review would give
>> them the last chance to say "oh, no, that extra change you added
>> for this final submission was not something I meant to suggest!",
>> etc.
>> 
>> So, is <pull.709.git.1600759684548.gitgitgadget@gmail.com> as-is the
>> one we should take?
>
> AFAIK it's the only one on the list. :) So yes, that one is fine with
> me.

Thanks.

Another thing the resending does is that it can credit who helped
the patch into the final shape with Reviewed-by/Helped-by etc.  If
the maintainer must hunt for the names of those who had input to the
discussion and judge the degree of contribution for a topic whose
review has been delegated to trusted others, that defeats the whole
point of delegation (I think the attached clarification may help).

For this particular patch, I added Reviewed-by: naming you before
applying.

Thanks.

 Documentation/SubmittingPatches | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index 291b61e262..87089654ae 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -290,12 +290,14 @@ identify them), to solicit comments and reviews.
 :git-ml: footnote:[The mailing list: git@vger.kernel.org]
 
 After the list reached a consensus that it is a good idea to apply the
-patch, re-send it with "To:" set to the maintainer{current-maintainer} and "cc:" the
-list{git-ml} for inclusion.
+patch, re-send it with "To:" set to the maintainer{current-maintainer}
+and "cc:" the list{git-ml} for inclusion.  This is especially relevant
+when the maintainer did not heavily participate in the discussion and
+instead left the review to trusted others.
 
 Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
-patch.
+patch, and "cc:" them when sending such a final version for inclusion.
 
 [[sign-off]]
 === Certify your work by adding your "Signed-off-by: " line
