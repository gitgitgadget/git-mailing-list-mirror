Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB98BC34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719D12173E
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YC0rtl3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgBRVdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:33:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51242 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRVdU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 16:33:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 024D2402C2;
        Tue, 18 Feb 2020 16:33:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SeiGwQlSbGz/+ktfVPJBYRZuZl8=; b=YC0rtl
        3lv6yh888eIPEBF9AGgNXO4gPEmDNDgDQ36ewRpeLAxtg8rc9nBEAOjh+sfxI3QW
        KZlSyuMhCh+edPYoAYQuVw2Qo9BxfE8xoDDvY6yp9z6TKRA6Ww4CO7tZ8JRSdDIn
        2VvSi/i7zxjgDU5+vyS07Cnp/PtdxXO27yPoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LCofB90Da7Aq0QgFKEbLtCMtMHqeBD56
        Wx31uWS84q5eTRQZUjmWWy9dwB3Hw/ULLh/hVYH6MY2R/NIdj4BcZaArNYclvVC4
        aNKG4Un74z6Be79vbJakuXi+brBZPCMxm5ARbmFYjuxH+wpN90x7QQ2y8M+887Oh
        ZJ8aOuPXrdk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEB91402C1;
        Tue, 18 Feb 2020 16:33:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C4B7402C0;
        Tue, 18 Feb 2020 16:33:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] t3424: new rebase testcase documenting a stat-dirty-like failure
References: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
        <pull.712.v2.git.git.1582059331257.gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 13:33:17 -0800
In-Reply-To: <pull.712.v2.git.git.1582059331257.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 18 Feb 2020
        20:55:31 +0000")
Message-ID: <xmqqh7znins2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 475AC8AC-5296-11EA-ACDE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  t/t3424-rebase-across-mode-change.sh | 48 ++++++++++++++++++++++++++++

t3424 is already taken by en/rebase-backend topic that has been
cooking for some time by now.  It seems 342? are all taken and the
next available may be t3433 perhaps (please double check with 'pu')?
