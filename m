Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7714C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 23:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC5020809
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 23:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bhsoPnT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgG3XGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:06:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59800 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgG3XGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 19:06:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97584E01B7;
        Thu, 30 Jul 2020 19:06:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LIC1Oh/8GTVqZ4eq1iKf+gc6Dkc=; b=bhsoPn
        T/nWxeLDsgviwvQjTcf08TWsOdvzOoAD4p0+baJnRPOnrIr1Yv28qjtxohLXTOc9
        ddw2nFNeHCz4gicSiGoMwS4RsPnnk2b6L9FFQo0DEmjw7+Fm6Me/tYhQeqGCMKj8
        ESAXp2f3fFh0/h3bF/JLTvWtChAGd/vklfo3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oqndJhWhZamk6D4TDUoFPG4aGVLvZJSq
        7FBRx8Dp0/KAiY8qI0ZiS4qV1QKNpcO7D0FgkeNBFcABMQeEZSXfES+8Q2FtBV96
        B4xWRCSLiQK8MWD3Ix3PV+ub+Q+5meqRIxN+8RoiYSVUU8Qxcc7/6GVg15IHgThI
        KCw/+BXuykI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69576E01B6;
        Thu, 30 Jul 2020 19:06:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A67FE01B2;
        Thu, 30 Jul 2020 19:06:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 00/20] Maintenance builtin, allowing 'gc --auto' customization
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 16:06:09 -0700
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Thu, 30 Jul 2020 22:24:06
        +0000")
Message-ID: <xmqq4kpo7gda.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 429B6878-D2B9-11EA-86AB-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * I added and updates Junio's patch from jc/no-update-fetch-head into the
>    proper place before the 'prefetch' task. The 'prefetch' task now uses
>    --no-write-fetch-head to avoid issues with FETCH_HEAD.

The update to tests for "git pull" looks reasonable, too.

Thanks.
