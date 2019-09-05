Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAC921F461
	for <e@80x24.org>; Thu,  5 Sep 2019 20:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfIEUhO (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 16:37:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61689 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfIEUhN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 16:37:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE9DE858ED;
        Thu,  5 Sep 2019 16:37:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R1W6++uun+JBN7hW/yRhZOG2KNs=; b=qT+CUk
        t1NrZK9R3jTTt0tnvPKuWyJ9WBupo2X/UGqS8HXoSdNCUQ8LPczHSYMx4McGYwBX
        qB6r3v6xvmkOTbXPXJv+EYyjyXk3hfP10j/b6kp0jdSGUrnEVPQn3KaEIlLCNHFW
        lwFwsSRbf2PZ1CECgl3HQxCbyKlKnT0rKWbQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AaDc0F3iT08H478j7ShLi7hStK9FBQPC
        pOCJtMHn8PW+4sAC/S3Qp6ortPptUs6wPiykwi4eMjveznK37uGTAmhRTQgYtFpE
        mJRih0ljcZvD9ioYWApVBR8XlUug9HbiY7VC1wZOHTJ/shyq7jy9Oh0bpdlZ3Rsu
        RTflDM6jlY4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C5F24858EC;
        Thu,  5 Sep 2019 16:37:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 01BB6858EB;
        Thu,  5 Sep 2019 16:37:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
References: <pull.328.git.gitgitgadget@gmail.com>
        <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
        <20190904030829.GB28836@sigill.intra.peff.net>
Date:   Thu, 05 Sep 2019 13:37:06 -0700
In-Reply-To: <20190904030829.GB28836@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 3 Sep 2019 23:08:30 -0400")
Message-ID: <xmqqa7bipjil.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE7BB846-D01C-11E9-BD43-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Do we want to to have fetch.writeCommitGraph, receive.writeCommitGraph,
> and then a master transfer.writeCommitGraph?

If anything, it may be good for consistency.

I am not sure if it is a good idea to trigger writing the commit
graph when accepting a push, though.  It tends to be a lot finer
grained than fetching, right?
