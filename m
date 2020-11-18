Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18702C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4DD824686
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GN+/ryzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgKRUrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 15:47:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50843 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKRUrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 15:47:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35C11901CA;
        Wed, 18 Nov 2020 15:46:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MzLsbUOiYPSrbbrGf/vkXbQabI4=; b=GN+/ry
        zgeh8MTu1hpXtRMoL80YF0+q4bX8sRFqcqnfR3lZDQDwVvVAQcEELvWwfGJJo9rh
        Sl560vz/dMqui8HoSwTIMMFefT2tWi0mZ2c25dcS/S/LCbOUckZNcgNyo6DJW99V
        pQSHvVwmnmB+PTOe0Xk8DChKT6Q5bHOuzPHLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dw1OsSEYxAhr+KaN4JdjQNfDSPmnbsd0
        2VdVPY5npKxX/Vl5s/Z0+vXO6UfpBcOvws/uPddYqAF2u+wNlhQv/JVS60oSt9nH
        kDjKIYdVevtqtDNQGWFqDLoxeG5XKUEtqsrdJKBmQKX5hsolgQMFysaYhd8u6w0S
        pnZMBq7LpU0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E060901C9;
        Wed, 18 Nov 2020 15:46:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3C9E901C6;
        Wed, 18 Nov 2020 15:46:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] t2106 vs. the default branch name
References: <pull.792.git.1605710947.gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 12:46:56 -0800
In-Reply-To: <pull.792.git.1605710947.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 18 Nov 2020 14:49:04
        +0000")
Message-ID: <xmqq1rgq1jgf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 331C79B4-29DF-11EB-89FB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Yet another thing I noticed while working on 
> https://github.com/gitgitgadget/git/pull/762.
>
> Johannes Schindelin (3):
>   t2106: adjust style to the current conventions
>   t2106: make test independent of the current main branch name
>   t2106: ensure that the checkout fails for the expected reason
>
>  t/t2106-update-index-assume-unchanged.sh | 31 +++++++++++++-----------
>  1 file changed, 17 insertions(+), 14 deletions(-)

This seems to partly replicate and partly deprecate what is in that
final stretch 27-or-28 patch series does to the same test script.
Are we taking this and then removing a patch or two from that larger
series?
