Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE93C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 02:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6526D21775
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 02:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O2unLfx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgGaC6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:58:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61207 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731161AbgGaC6f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 22:58:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AAD63E19D2;
        Thu, 30 Jul 2020 22:58:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bSIwa/JVabdi80kzwTYNDIDgiqg=; b=O2unLf
        x8c+/tgMZxYmiVEw6yLftvCkvaLatGrJLY+JRuJET7MVwxbot2Kct0FerocDEcpj
        THvFisB4n7KUhYRR9bpF9gwrL1Hv34Y1GYbrOmsrdBLgxUCeCjupuKnVt0vxB5pA
        2IrPrrUxB/VH4FTHq/fHz7Zn8z24RLu+BStXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rqb3V3sev/sgNy9OLsAn5JWGB10YeAst
        JO192T8EoQGjDkrsB2IiHcsM2sfSQL95mJAQdtjLnvz76YI4/Kt8e9HRuDgrWYfg
        3/3+JEBlqKwC4Q9bPVwNKmjKgX6qRdvkbYuvOAwDdMFmLgPBQEvZ+hGXwhMz/Ytt
        ee2aGPZsMmU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A17BEE19D1;
        Thu, 30 Jul 2020 22:58:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DFFCAE19D0;
        Thu, 30 Jul 2020 22:58:30 -0400 (EDT)
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
        <xmqqzh7g60mk.fsf@gitster.c.googlers.com>
Date:   Thu, 30 Jul 2020 19:58:29 -0700
In-Reply-To: <xmqqzh7g60mk.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 30 Jul 2020 16:31:31 -0700")
Message-ID: <xmqqlfj04ch6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B711BAF2-D2D9-11EA-937C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  * This series is now based on jk/strvec, as there are several places where
>>    I was adding new callers to argv_array_push* and run_command_v_opt()
>>    which have been replaced with strvec_push*() and run_command(), using a
>>    'struct child_process'.
>
> It probably has been a good way to gain experience with the renamed
> API for you to rebase this series, but I think we'd have to spend a
> similar amount of effort yet again, as I expect that the jk/strvec
> series would be rerolled at least once more, with the items[] array
> renamed to something else, like v[].
>
> Let's see how it goes.

So, ... jk/strvec got updated, and just applying these twenty
patches on top no longer compiles, so I rebased them ;-)

I also adjusted the merge-fix for the 6 patches on es/config-hooks
topic before making tonight's final push-out of 'seen'.

Thanks.
