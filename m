Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F93C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 20:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A7F521556
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 20:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V5qsahKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgKCUVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 15:21:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54476 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCUVM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 15:21:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55634E4A13;
        Tue,  3 Nov 2020 15:21:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=48zYmQ3hur7qFuAauRcun1ietgY=; b=V5qsah
        KMXUduuxNRdxOin9NUmd5ajY2jfhuF3IfGTm4URuPjgE80kJUtg/dpqY6Gi/uw1w
        GbNoCEc5bpnHjAcpNKvocXwvY1uRTfiLGF6hMmu+7MBnFDrFanHHgx20Qdbz9bN9
        S8yTLNxUXqf7Nr1ahi6612obqRNTOQ7lwdL6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IzILnAc2uuJr2sjbrKTvhBqxBAhrmPKX
        OC1ANE8kdyuPDmakQYoo6jHEQ4+VGVLWWWyYkaiuPvz3K1p5MwKOeL3OM5Z7lIn5
        2qRdYpt693REsoqJYxuk0Ott851puJ/lqf4nwsbiWQSBoOkp0bmEKHRa4yB+lDd+
        XQD7o/QP+oo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EAF0E4A12;
        Tue,  3 Nov 2020 15:21:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82165E4A0F;
        Tue,  3 Nov 2020 15:21:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?xJBv?= =?utf-8?B?w6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] Maintenance IV: Platform-specific background
 maintenance
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
Date:   Tue, 03 Nov 2020 12:21:06 -0800
In-Reply-To: <pull.776.git.1604412196.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Tue, 03 Nov 2020 14:03:13 +0000")
Message-ID: <xmqqmtzyqjil.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B8EC956-1E12-11EB-958F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is based on ds/maintenance-part-3.

Ah, I forgot to ask those on CC list how carefully they read the
part 3 of the series, as it's been left on 'seen' for some time, and
I do not know if it is ready to start cooking in 'next'.

Thanks.
