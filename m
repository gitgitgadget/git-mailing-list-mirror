Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081ECC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 19:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A0E610FC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 19:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhHMTxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 15:53:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62338 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbhHMTxe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 15:53:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B274DF620;
        Fri, 13 Aug 2021 15:53:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XtywFYG7V1OYg3jW/4QFnRZnWA7XDKFRXSLj6A
        TcfZY=; b=aMc2szRCZVovOopMz09eRlDgOtxfS+VqjZQjPUZeN0XbsIOrfv7c9z
        Qou1IIguodawXrGFESdWxIiP942/eWKi5QMcYtFlBgfC91I0uHNGpfpCjLuUQWn6
        T8Z7ijhy2pyiik1TrUaT3KpnOd68AzTONO4uq/19YK1Da16Zvm5tQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3F38DF61F;
        Fri, 13 Aug 2021 15:53:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D422DF618;
        Fri, 13 Aug 2021 15:53:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mahi Kolla <mahikolla@google.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
        <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
        <xmqqeeaz70ph.fsf@gitster.g> <YRW0pGXXWnY7C470@google.com>
        <c74a9d75-cd89-d020-dcb3-76509bc95284@gmail.com>
        <CAN3QUFa3TRh9rvV3xS8XWd-dTvMqS=2j5Vhvp0wP33oPte9_2w@mail.gmail.com>
Date:   Fri, 13 Aug 2021 12:53:00 -0700
In-Reply-To: <CAN3QUFa3TRh9rvV3xS8XWd-dTvMqS=2j5Vhvp0wP33oPte9_2w@mail.gmail.com>
        (Mahi Kolla's message of "Thu, 12 Aug 2021 21:12:15 -0700")
Message-ID: <xmqqeeaxw28z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1167D188-FC70-11EB-95F2-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mahi Kolla <mahikolla@google.com> writes:

> Unfortunately, the submodule.recurse variable can't be used as the
> opt-in flag because this would cause commands to run recursively even
> if developers don't have submodules in their project (aka don't run
> git clone --recurse-submodules).

If you cloned without recurse-submodules and lack submodules,
wouldn't it be a no-op to have submodule.recurse set to true, so it
would not hurt anyway?

IOW, that may already solve the original problem you wanted to
solve---those who want their submodules recursively descended into
by default can just set submodule.recurse to true (in ~/.gitconfig
presumably) and after "git clone" with --recurse-submodules they
will get what they want, no?  Am I missing something obvious?

Thanks.





