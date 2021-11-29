Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BEFC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhK2XcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:32:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59050 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhK2XcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:32:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9EB4116F313;
        Mon, 29 Nov 2021 18:28:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZlT9TJAQl85wMAXIXJBwZoe7fXKTIBVu9+ZYAG
        22/jU=; b=Ah4AJ3SrpvhvqCysCxoZ04x3wEfXnEfbiiWG3F4GTOZU2HKT4UOX56
        xvQthPPQ9QEik+a+DtCrkos+0XzY7Pz32qbfp2Is3Unv2liIn3YOn7LTob78aUej
        13ukep2ySEY6hvHwR09kuM00hDS8BC8RQ6lCpLB/IPr++lijIUt3c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 96D4D16F312;
        Mon, 29 Nov 2021 18:28:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B653916F311;
        Mon, 29 Nov 2021 18:28:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 3/6] refs: allow skipping OID verification
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <93fe3f03fb2a10f36aff4a6e4702053daeaa1d64.1638211786.git.gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:28:47 -0800
In-Reply-To: <93fe3f03fb2a10f36aff4a6e4702053daeaa1d64.1638211786.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 29 Nov 2021
        18:49:43 +0000")
Message-ID: <xmqqfsre4k40.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AAEF950-516C-11EC-A2F6-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * Blindly write an object_id. This is useful for testing data corruption
> + * scenarios.
> + */
> +#define REF_SKIP_OID_VERIFICATION (1 << 10)

That makes sense.  Readers would expect that this flag is passed
only from test-helper but not in the regular code, at least without
an option like "git update-ref --skip-oid-verification ..."?

After applying these 6 patches, I do not seem to find anybody who
actually flips this bit on.  Perhaps I missed a step or so?

