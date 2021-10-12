Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD55C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2448A60E0B
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhJLRtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:49:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54050 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhJLRtF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 13:49:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EAEE1004BB;
        Tue, 12 Oct 2021 13:47:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PuY8uJX0RaZfISXjRiFLP/2udaC0w1Y8NyZPP5
        2n8uc=; b=gjU7WKX5XZVsQNJ1PRMFWU9NhRWyx4/BA4i7Poumneb8FlCsEdwniO
        ZENF5pOlPBKXnvqfYlwoda3G5JuJSDd3LDrX5Yg/7+o0k0rmzP99rnByjLdbY0b6
        tfv9tD+idFO3ikjlgYLWXvlJs+k483/YfK+suj5X3pnUx50o+tJLM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53E161004BA;
        Tue, 12 Oct 2021 13:47:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9ACAB1004B9;
        Tue, 12 Oct 2021 13:47:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alex Waite" <alex@waite.eu>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing
 an underscore
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
Date:   Tue, 12 Oct 2021 10:47:01 -0700
In-Reply-To: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com> (Alex
        Waite's message of "Tue, 12 Oct 2021 16:25:04 +0200")
Message-ID: <xmqqk0ii3zl6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68425940-2B84-11EC-BBB1-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alex Waite" <alex@waite.eu> writes:

>   This works for all tested subdomains /except/ for those which contain an
>   underscore.
>
>   authenticates without prompting:
>     git clone https://testA.example.com
>     git clone https://test-b.example.com
>
>   prompts for authentication:
>     git clone https://test_c.example.com

Hmph, given that hostnames cannot have '_' (cf. RFC1123 2.1 "Host
Names and Numbers", for example), the third URL seems invalid.  Is
this even a bug?


