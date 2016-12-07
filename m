Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563491FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932578AbcLGWIR (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:08:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63568 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752156AbcLGWIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:08:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 900CF57BFC;
        Wed,  7 Dec 2016 17:08:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CQKS3uMcSQTflLEtxOpgRtrVNV8=; b=qu3oO/
        EWYctzZiZaugWS4xQwFdup5qKQ04twA53tdIhMSCmclf2zzeyZTw18cxhtIX81UY
        p9Sn9dZrM+0k/SpHNMC2NCgt9KGrWUYSCjz5z1rcbdHRkryYKZ9k5n7NXytobdCF
        3hoM2UkampLXP8osR7RMVNNWDPKllxH3KkPSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=waAY4732PthdpRMfAuuCQiGbp+MCVyWl
        yOJCWPz2S7oDnTQ84pRwfTpbuIwNabiuLy/EEwf/lQuyDlg3RqLBWbxNx0ZIglhS
        1H8uxNd4zZXeLTQztgikIQ6GFC2eRFxbwhat2jWMvLLZMamEFq7ULwrhg9XECfRV
        6lXfBCmatqw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8872D57BFB;
        Wed,  7 Dec 2016 17:08:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 032E357BFA;
        Wed,  7 Dec 2016 17:08:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/2] describe: add support for multiple match patterns
References: <20161207023259.29355-1-jacob.e.keller@intel.com>
        <20161207023259.29355-2-jacob.e.keller@intel.com>
Date:   Wed, 07 Dec 2016 14:08:13 -0800
In-Reply-To: <20161207023259.29355-2-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Tue, 6 Dec 2016 18:32:59 -0800")
Message-ID: <xmqqa8c7wfxu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6900EB0-BCC9-11E6-97A5-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> ... Suppose that you version all
> your official releases such as "v1.2", "v1.3", "v1.4", "v2.1" and so on.
> Now, you also have other tags which represent -rc releases and other
> such tags. If you want to find the first major release that contains
> a given commit you might try
>
> git describe --contains --match="v?.?" <commit>
>
> This will work as long as you have only single digits. But if you start
> adding multiple digits, the pattern becomes not enough to match all the
> tags you wanted while excluding the ones you didn't.

Isn't what you really want for the use case a negative pattern,
i.e. "I want ones that match v* but not the ones that match *-rc*",
though?
