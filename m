Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E050C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB6522260
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CZYzchQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbgJTB71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 21:59:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53292 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbgJTB70 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 21:59:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8ABE59CE25;
        Mon, 19 Oct 2020 21:59:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5IR9lQWvOIp6A7CXpjOg2eOU70Q=; b=CZYzch
        QXjchxrYe/rhtZbwFBnFgv91v/VR5rRicnLW6svQi4B015dONVsvvJkxsqdE+U3N
        Yy4NH7Xq/zjno57KxBydF01rKdNW9m27SILY1Xi2hqJ9VfGJ1PFscSmNjgPnJepv
        wNaYDp7go0oI3dnA2XAOUM3ucPsTje4VkaoiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PCHxpux91B/ZN/F5cfoHIgSVF/uB+iSW
        dZSAGdx24HlZ4faQtYZ9ntqZIW0s3Gk5Nfg7GQDk/Srjc1MfRPjJVnIWrqpwjLYX
        JpmvluJbA0x9OEAgoe8chRaRxs5r+WKl2tXheAJ3TPED/LZiOp/Pzl/dEsEXNy6e
        c6YO64scBxA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8329A9CE24;
        Mon, 19 Oct 2020 21:59:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 16A1D9CE23;
        Mon, 19 Oct 2020 21:59:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Joey S <jgsal@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [OUTREACHY][PATCH v1] t7006: Use test_path_is_* functions in
 test script
References: <ERmIkC3rLZ3BAyv2Nq_GK0CjWvEQw6ejl8V-HVvwCsyIv0guQV67nO8KMLi7eA9qO5mo_ZJ8XB360uP_LtP-LY1xsaRBXHsc0F1uSID-KPE=@protonmail.com>
        <20201020001103.GB2774782@google.com>
Date:   Mon, 19 Oct 2020 18:59:24 -0700
In-Reply-To: <20201020001103.GB2774782@google.com> (Emily Shaffer's message of
        "Mon, 19 Oct 2020 17:11:03 -0700")
Message-ID: <xmqqpn5dd5dv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E10D9E4C-1277-11EB-9B52-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Mon, Oct 19, 2020 at 04:26:07AM +0000, Joey S wrote:
>> 
>> Hi everyone,
> Hi Joey and welcome.
>
>> 
>> Signed-off-by: JoeyS <jgsal@yahoo.com>
>
> One thing missed by other commenters: the Developer's Certificate of
> Origin line - which is what this indicates - should have your "full
> name".

... and it must match the authorship.

> So in my case, I sign my patches 'Emily Shaffer
> <emilyshaffer@google.com>'. If I'm wrong that's fine, but JoeyS sounds
> like a name and initial rather than a full name.

Thanks for pointing it out.

If somebody from the "mentoring" group is taking a tally, it might
not be a bad idea to identify which style and procedure rules are
often failed to be followed by new contributors so that we can
figure out ways to make them stand out in our documentation set
(e.g. Documentation/SubmittingPatches but maybe a separate cheat
sheet might be worth having).

Thanks.


