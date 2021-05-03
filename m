Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145E7C43460
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD99861244
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhECFWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 01:22:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50639 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhECFWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 01:22:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E542E13B71B;
        Mon,  3 May 2021 01:21:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nQyCOuOFGF8s65ugSHycHq5BEH22eyE3nKcEgr
        QEsPw=; b=fn5aSPzga3KY+eAY+NfzYKTs6/llBwsKNewuwOuULFkNSy6go11wfr
        r8d3g9uCo6625Y05cF+eN5mqgczwTavdV2UoGHBcm/CjUdS46d8jI09KY0/9H+7X
        ClshsrYetcKq/z2N0P+3l6gKv5/oazSk7AsT1Zjm6Mbtd5K/gEZIM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD68913B71A;
        Mon,  3 May 2021 01:21:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 342B913B719;
        Mon,  3 May 2021 01:21:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Josh Soref <jsoref@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/2] merge: fix swapped "up to date" message components
References: <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
        <20210502051423.48123-1-sunshine@sunshineco.com>
        <20210502051423.48123-3-sunshine@sunshineco.com>
Date:   Mon, 03 May 2021 14:21:12 +0900
In-Reply-To: <20210502051423.48123-3-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Sun, 2 May 2021 01:14:23 -0400")
Message-ID: <xmqqwnsg8kaf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6133BC28-ABCF-11EB-8062-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> +	if (verbosity >= 0) {
> +		if (squash)
> +			puts(_("Already up to date. (nothing to squash)"));

The original scripted Porcelain may have said so, but the placement
of full-stop in the above feels a bit strange.  Should we rephrase
it to

	Already up to date (nothing to squash).

as we are fixing the phrasing now?
