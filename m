Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4F0C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 18:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiGMSLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 14:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGMSLq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 14:11:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CAC286FB
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 11:11:44 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BDC8A1B5347;
        Wed, 13 Jul 2022 14:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6RZahrNfK9Atgre7DlIKK0QIoEy1dhahTFlFrI
        kC7Ws=; b=rMzByoGShasRO+GVSEj5lrEQddGTpuohfeq5Rk2O+HkVsLIxeyhqvP
        jouCfBwVgJBSNWZ4t0E1LCfnMw5GRF2eRHODDbl3UNR6isK66/Y883CFbLWlwD3A
        dfgHmj2dNoHCYjAkKCJNzMty+5qRKJF/d+mx95wSj/c43iEeIFWnE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B5E761B5346;
        Wed, 13 Jul 2022 14:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 698061B5345;
        Wed, 13 Jul 2022 14:11:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v4] submodule merge: update conflict error message
References: <20220629224059.1016645-1-calvinwan@google.com>
        <20220712231935.2979727-1-calvinwan@google.com>
Date:   Wed, 13 Jul 2022 11:11:39 -0700
In-Reply-To: <20220712231935.2979727-1-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 12 Jul 2022 23:19:35 +0000")
Message-ID: <xmqqbktsdgro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E4834AE-02D7-11ED-8129-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Changes since v3:
> Thank you again Elijah for the helpful feedback! I have removed any code
> touching merge-recursive.c, and refactored the rest into merge-ort.c.
> The error message has been updated as well as any relevant test cases. I
> had added a jump in v3 to "ret:" in merge_submodule() to accomodate
> early returns, but this has been proven to not be necessary since an
> early return means the submodule was either renamed or deleted, and this
> case is already taken care of with the message "CONFLICT (modify/delete):"

Unfortunately a34edae6 (merge-ort: split out a separate
display_update_messages() function, 2022-06-18) moves the code this
patch touches to a separate function.

If this is now an ort-specific topic by dropping merge-recursive
support, perhaps we'd need to coordinate with the other branch.

I think en/merge-tree is ready to be merged down to 'master' in a
few days, so I'll wait for [v5] of this patch after that happens.

Thanks.
