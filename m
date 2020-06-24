Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566EAC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FC42082F
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UY1iZgHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404664AbgFXQ0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:26:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61798 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404468AbgFXQ0w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 12:26:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D5C3609A3;
        Wed, 24 Jun 2020 12:26:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FDCcSSKBFojhHps6DGyuQGExw6M=; b=UY1iZg
        HeKE9usTJAgP51lLsleZqWrHQnfDU2dhECl4nIoFjmMULZDHB60uaQS+x1r0RV3U
        D/UlUAOJiqy29tqf72UP/zO8kzj0DQZM6J/wW7ppgLzzuC/Ot5ZKou/h+QBuCLy8
        6S2PL9vIRAEczo0NlBFhgLnjwC4N0k/fWcNzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RGRFJ2kWet1vAb8KAVHIB4+FannhVUEt
        yMOw3acVrsyuswDCZ9AmE6gFakAXgwvML/aWon7CHsMw499ai2NhV5YPVu7DWSOI
        smjfi0Qyhb8u9QXod7hrGYVX+V/EQavetCd3eWnu+sNbuwweYW8Gjwgg+NQLWDja
        vgu1KrrXZZI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 744B0609A2;
        Wed, 24 Jun 2020 12:26:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03EC9609A1;
        Wed, 24 Jun 2020 12:26:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/9] Allow overriding the default name of the default branch
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 09:26:49 -0700
In-Reply-To: <pull.656.v4.git.1593009996.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 24 Jun 2020 14:46:27
        +0000")
Message-ID: <xmqqk0zw77li.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 818162C0-B637-11EA-BF20-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v3:
>
>  * We now avoid the phrasing "specify a specific" in the messages.
>    
>    
>  * The git submodule patch has a better commit title now, and it also
>    adjusts the documentation more completely now (thanks, Philippe!).
>    
>    
>  * A code comment in builtin/init-db.c was updated to no longer talk about a 
>    symlink when it comes to HEAD.
>    
>    
>  * Made it the responsibility of the caller to warn about reinit &&
>    initial_branch.

It looked all good to me.  Will replace.

Thanks.  Hopefully we can go 'next' with this round---knock wood...
