Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E35C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 23:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACD3206D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 23:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n9GjKWz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfLUXzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 18:55:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56192 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfLUXzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 18:55:03 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57BEA1AC92;
        Sat, 21 Dec 2019 18:55:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eyYZ+K2EkFekIgI+lhRVxZTaEls=; b=n9GjKW
        z1vvbHMSiIyKwLa9VkViPv2hw1PQr3ZrfaUB0D7Yd3eavINw1GCu++F0gECPQHXV
        y+rfFMKHIC1hqnL2uMlRApAoD8MtyZld3V7kWRTtVrCQ2tC2g17WA67zLDziQ9MR
        G9n9IbHqIwSMvr7ujFlvMx5roPWYsaidyBQLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vntxkYB++dGGY10ZFadoVTpauXXojmRI
        pXfJWtJysqjR4n3qhgwNWp+j46heBCHxst8uHVhXPuqCLsLu0J3N5RgUpsOeqnoe
        nLXh3z1mb3ETRXzVxwXpCpV8uxIhWeiloifRPBklswdYIoQL551G8LmZ3H4DeFg5
        VHZxeABUyAA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A9751AC8F;
        Sat, 21 Dec 2019 18:55:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 107001AC8E;
        Sat, 21 Dec 2019 18:54:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/1] [Outreachy] commit: display advice hints when commit fails
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
        <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
        <xmqqlfr8b28v.fsf@gitster-ct.c.googlers.com>
        <20191219185427.GA227872@google.com>
        <xmqq7e2sazlh.fsf@gitster-ct.c.googlers.com>
        <xmqq36dgayma.fsf@gitster-ct.c.googlers.com>
        <CACg5j249Ttouiua7iSfMGi7ZaKOanb0TCbMFmEjVtzKsPur4PA@mail.gmail.com>
Date:   Sat, 21 Dec 2019 15:54:59 -0800
In-Reply-To: <CACg5j249Ttouiua7iSfMGi7ZaKOanb0TCbMFmEjVtzKsPur4PA@mail.gmail.com>
        (Heba Waly's message of "Sat, 21 Dec 2019 17:37:16 +1300")
Message-ID: <xmqqa77l6xpo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C625EFE-244D-11EA-A39A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

>> Any contributor working on this topic should be competent enough to
>> realize/notice it once it is pointed out---even though lack of
>> proof-reading before sending may cause such a mistake by
>> carelessness.
>
> I have no reason not to believe that this is crossing the line.
> No matter how much a reviewer disagrees with the proposed changes, I'd
> appreciate
> keeping a mutually respectful discussion during the review process.

I do not see any lack of respect in saying that I believed you are
competent enough that a short "Huh?"  answer was sufficient.
