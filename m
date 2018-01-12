Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 310A81F406
	for <e@80x24.org>; Fri, 12 Jan 2018 23:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965313AbeALXU7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 18:20:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56851 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965236AbeALXU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 18:20:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C17ABBB457;
        Fri, 12 Jan 2018 18:20:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=opaMtM7EJi/GK8he6n/e1HnBs7U=; b=MewrGa
        rRiUF9YLj52YnbAnx/Jc9bj7ynHmE+t3r6OFZhoKeFaiJjzAucPoduKW9ybO7Jqv
        1v1YbCHTrHYSjzXqfdjDgCIiOlkDjPS/ASRXt//fWSsST7/rORu0rrfpCou103sx
        FIGd2SjbgmZS/N4e2wWuJEC3Z18IPMsiANqj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YPkyiLH8eHMrt2IFuh4+CI+v7X3+f2oV
        P6X4GMEVYMhqvm/NWyEUwJksz1Ng+FK4tAO1yTBu5Av8BtxvnythOrMJxpHu68pY
        amviGtQM5bfoylYy4uCauf7Nm0DbcPVrLS9Nhy9UoOwd4oeh8WHZ5U/qU7Mc7FXe
        aXmJoTzBekA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9944BB456;
        Fri, 12 Jan 2018 18:20:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FD1FBB455;
        Fri, 12 Jan 2018 18:20:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/4] sq_quote_argv: drop maxlen parameter
References: <20180112133613.GF27499@sigill.intra.peff.net>
        <20180112133810.GA8290@sigill.intra.peff.net>
Date:   Fri, 12 Jan 2018 15:20:55 -0800
In-Reply-To: <20180112133810.GA8290@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 12 Jan 2018 08:38:10 -0500")
Message-ID: <xmqq373awtns.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E45F830-F7EF-11E7-A8B0-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> No caller passes anything but "0" for this parameter, which
> requests that the function ignore it completely. In fact, in
> all of history there was only one such caller, and it went
> away in 7f51f8bc2b (alias: use run_command api to execute
> aliases, 2011-01-07).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Just a cleanup, though it touches the caller you just added, too.

Yup.  This is a good change in the longer term.  I needed an evil
merge for a stalled topic in 'pu' to adjust a couple of new callers,
though ;-)..
