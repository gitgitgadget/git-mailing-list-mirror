Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92294C433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6021D2072A
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fvG/WHN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgG3Ass (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:48:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64494 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgG3Ass (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 20:48:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 242EC82223;
        Wed, 29 Jul 2020 20:48:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9tbM0LHPsvQ32slEQoyd/bF2CKQ=; b=fvG/WH
        N81fdh+jzP9dTr65GW6Wmt8hXNm/2QbH5bpLgBIhME/bStHpNhx+Jnh95/vE33K5
        MYj8fQ2pMUPT0CfLLn+0NzCX+2QwCiMzJV1LmPRjY/sp/8nmPIAYFX55ocRJazdK
        rjQrGMRyONyG6pTP4L4S/J6Uq6UWnSEA+gh1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kQEmnHvSpqxWV2F1GC/MHe4iKF68J1+l
        urfF3pxTSqwU18IsQiQCBfFH+kDxHURmdM9yTQUOLwI5ZR9TXPLxkb+Z1kTjfXTD
        Lfucl/+MvToOy68LkflNMpJlPVGCgQHlla4riyz3FuY1YB9fqa+eKrgF0F359Xki
        Vy+iQNdBNd0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C42182222;
        Wed, 29 Jul 2020 20:48:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A071382221;
        Wed, 29 Jul 2020 20:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Introduce --first-parent flag for git bisect
References: <pull.686.git.1595951056.gitgitgadget@gmail.com>
        <20200730002735.87655-1-alipman88@gmail.com>
Date:   Wed, 29 Jul 2020 17:48:45 -0700
In-Reply-To: <20200730002735.87655-1-alipman88@gmail.com> (Aaron Lipman's
        message of "Wed, 29 Jul 2020 20:27:32 -0400")
Message-ID: <xmqq1rkt96aa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C472916-D1FE-11EA-9161-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Lipman <alipman88@gmail.com> writes:

> Junio, thank you for the feedback and the explanation regarding
> count_distance(). I've gone ahead and implemented all your suggestions.
>
>> In chronological order, please.
> I submitted my initial patch through GitGitGadget. I don't see a way to
> control the order GitGitGadget sends emails,...

Ah, I was referring to the order of sign-off, helped-by, etc.
Somebody writes a patch that is left on the list, you pick it up and
polish it for perfection, and send the result to the list.  

So based-on would come first because it happened first, and then you
worked further until the result deserves to be signed-off and
finally you sent it out.  So your sign-off comes the last.

