Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB44EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 19:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGYTcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 15:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGYTbu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 15:31:50 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D381FFA
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 12:31:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B700D1E5D9;
        Tue, 25 Jul 2023 15:31:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=odvqWAHUVreFyjJ0MvIthfKlIyZRrP9oYpdx9c
        3cmyg=; b=A/zNxh6r+9tKW9bC0rIgSuWmSFrEdkz8bMTbMKuAyQFlok+hMMrs8Z
        SD2ByLgZwAjHgAPv0jqAGF3XToCru5xOSBRNRSFae2nLiSKOrmafeR691M4ZCzw6
        sOfX8F8Wse/C7AyhwHlUkQlANvDwhXWj51L4QYu01IQzrpZILmjaQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B020F1E5D8;
        Tue, 25 Jul 2023 15:31:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 54C6B1E5D7;
        Tue, 25 Jul 2023 15:31:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Calvin Wan <calvinwan@google.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 2/2] wrapper: use trace2 counters to collect fsync stats
References: <20230720164823.625815-1-dev+git@drbeat.li>
        <xmqq5y6e2xl7.fsf@gitster.g>
Date:   Tue, 25 Jul 2023 12:31:45 -0700
In-Reply-To: <xmqq5y6e2xl7.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        20 Jul 2023 12:26:44 -0700")
Message-ID: <xmqqo7jzlrdq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E48FEF64-2B21-11EE-AD03-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I also spotted this change since v1:
>
> - Rename trace2 counters to use "-" (not "_") as inter-word separators.
>
> Since I do not seem to be able to find any review comments regarding
> the variable naming in the v1's thread, let's ask stakeholders.
>
> Are folks involved in the trace2 subsystem (especially Jeff
> Hostetler---already CC:ed---who presumably has the most stake in it)
> OK with the naming convention of the multi-word variable?  This is
> the first use of multi-word variable name in tr2_ctr, and thus will
> establish whatever convention you guys want to use.  I do have a
> slight preference of "writeout-only" over "writeout_only" but that
> is purely from visual appearance.  If there is a desire to keep the
> names literally reusable as identifiers in some languages used to
> postprocess trace output, or something, that might weigh
> differently.

I heard absolutely nothing since I asked the above question last
week, so I'll take the absense of response as absense of interest in
the way how names are spelled.

Therefore, let me make a unilateral declaration here ;-)  The trace2
counters with multi-word names are to be named using "-" as their
inter-word separators.  Any patch that adds new counters that do not
follow the convention will silently dropped on the floor from now on.

Let's move this patch forward by merging to 'next' soonish.

Thanks.
