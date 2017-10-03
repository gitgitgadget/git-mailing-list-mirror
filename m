Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E57620281
	for <e@80x24.org>; Tue,  3 Oct 2017 03:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbdJCDvQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 23:51:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53106 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750846AbdJCDvP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 23:51:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9348CB4EB3;
        Mon,  2 Oct 2017 23:51:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fy0T0oSxBR8/oiwwyAl/Krsg94U=; b=TXk1xH
        PVvvcy05Hl5Ct9XjlGuefQANQgmCKJ8ac989A5sr3axj5E3S9VpAU542yN127vAo
        J3tkWcKkOyFU1D/bUEjZ6e7Pgxmztbv85qVdCjj41bxjL5iZlmwbbegFI+/qKWVo
        qRIQ69pRC6mSEfc1gWLTCEImluuDlZBgP2F6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JocwCFppnXVPe3iA+wUXq6Ot82VXXtMI
        QbkBT7+a3JFoks75LYons7C93ABaRzEvyGrpzffRVxjFyqwsqUcuw4HUpys57u+W
        K+hphMTRaX2agPvT27ec8NOYMuJhOKuPMQ/8B7c2goEiVvYLOqyvTOTl1kPuO4O6
        6p4wpKUSBjY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B659B4EB2;
        Mon,  2 Oct 2017 23:51:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 068C7B4EB1;
        Mon,  2 Oct 2017 23:51:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v16 1/6] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
References: <CAFZEwPOjK25m84BgTF7AL72DL_K1dHf7OrYoX=_vky9r3GayNw@mail.gmail.com>
        <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
        <5ca7a863-5b85-23b1-4432-cf74dcc7c4e0@ramsayjones.plus.com>
        <CAFZEwPN2BeogeVqXp7xh+GPUF6SDJa5JwQ3knZzOD_H6zcEwvQ@mail.gmail.com>
        <72995d24-d337-39c0-0abd-64bce1c22028@ramsayjones.plus.com>
Date:   Tue, 03 Oct 2017 12:51:12 +0900
In-Reply-To: <72995d24-d337-39c0-0abd-64bce1c22028@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 3 Oct 2017 01:48:17 +0100")
Message-ID: <xmqqa818lwi7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A201964-A7EE-11E7-8406-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 02/10/17 14:44, Pranit Bauva wrote:
> [snip]
>>...
> Yes, I also meant to tidy that up by removing some, now
> redundant, initialisation later in that function.
>
> Note, that wasn't the only bug! (I have probably forgotten
> some of them, but look at 964f4e2b0, for example).

It seems that Pranit needs a bit more work to take known fixes from
your efforts and we should wait for the series to be rerolled?

Thanks both for working on this.
