Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668E5C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468B8611C7
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354396AbhJAVNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:13:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58662 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhJAVNU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 17:13:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A0A51644F2;
        Fri,  1 Oct 2021 17:11:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b7iNZSK9Z9dgqa4qq0wOIo4mn1cqfkEQOFCDOQ
        ZQJQs=; b=yL5SM5BjAkEtkRdQIUkou3sFNfvQQThhyDfEDVl1iqzXPaV6seuUWY
        GNXsNNcYiEgzE4D2reE2qh7WajuIkYuufCb22wBKH79iA/nm2rBJDlx6X4uTum+1
        ZNVwZ/T18ptA5A8n19zlntlfm+dgJwOpBAzvjAAIsneIZ1wJsJo88=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 809A51644F1;
        Fri,  1 Oct 2021 17:11:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17C761644EF;
        Fri,  1 Oct 2021 17:11:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 08/11] reset_head(): take struct rebase_head_opts
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <267e074e6dbd3c7cf733cd5ba4fa476d2d5e6fd2.1633082702.git.gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 14:11:32 -0700
In-Reply-To: <267e074e6dbd3c7cf733cd5ba4fa476d2d5e6fd2.1633082702.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 01 Oct 2021 10:04:59
        +0000")
Message-ID: <xmqq8rzc5u2j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 277B286E-22FC-11EC-BDA8-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This function already takes a confusingly large number of parameters
> some of which are optional or not always required. The following
> commits will add a couple more parameters so change it to take a
> struct of options first.

Would all the members in the struct always be used by the function?
If not, such a change will *not* solve the "confusingly ... required"
problem at all.

I am not necessarily against a change to consolidate a bag of
parameters into a pointer to a struct.  I am against a change that
is justified with a benefit that the change does not bring to us.

Thanks.
