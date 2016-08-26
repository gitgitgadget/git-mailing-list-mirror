Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE1D1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 17:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbcHZRV3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:21:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56564 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752476AbcHZRV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:21:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B8FC373D0;
        Fri, 26 Aug 2016 13:21:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sf0Zafrnt31uZFhpCsx4WehgQa8=; b=C1HNWK
        ysldIPwo9R42TYmBYWy1GDwPiJoWTkqqHMoRrjkEqJr0LxIxQMCwkyyjjgl7i+1z
        EGaQK6rZ2hMntfsNwrO3rXot9B2WLOVKGZtyL/Nq19ATepRwD9XCn0rwEBMoTzSU
        p0JRdZTeQn0wY53lv094CurfPqJolFn71ug/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iv5liwudOC+JgU+t7zY0Z8mDkvfcpdED
        rcGGPoPlJctcHAZgFij4XCWSUyRoVCt41VQB25Uenfz6JAOqmLPc5XfpaNbH9z+V
        bQuciZXu8gxCF/pVJ4k1Nw32RHq6EV4Z7nPhRagpbft73skpkJSyVUcaMgjRBW4k
        fTxm1uiwxsk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5361B373CF;
        Fri, 26 Aug 2016 13:21:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3B21373CE;
        Fri, 26 Aug 2016 13:21:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 06/13] pkt-line: add functions to read/write flush terminated packet streams
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-7-larsxschneider@gmail.com>
        <xmqqzio0jxh7.fsf@gitster.mtv.corp.google.com>
        <D8C981C6-22F5-4922-BBF7-F71961B3271B@gmail.com>
Date:   Fri, 26 Aug 2016 10:21:24 -0700
In-Reply-To: <D8C981C6-22F5-4922-BBF7-F71961B3271B@gmail.com> (Lars
        Schneider's message of "Fri, 26 Aug 2016 12:13:35 +0200")
Message-ID: <xmqq60qnigyz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85328266-6BB1-11E6-A877-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> OK, what function names would be more clear from your point of view?
>
> write_packetized_stream_from_fd()
> write_packetized_stream_from_buf()
> read_packetized_stream_to_buf()

Would

    write_packetized_from_fd()
    write_packetized_from_buf()
    read_packetized_to_buf()

be shorter, still understandable, be consistent with the existing
convention to name write_/read_ a function that shuffles bytes via a
file descriptor, and to the point, perhaps?

