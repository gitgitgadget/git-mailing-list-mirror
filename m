Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40E2620229
	for <e@80x24.org>; Fri, 21 Oct 2016 22:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755338AbcJUWON (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 18:14:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52001 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754732AbcJUWON (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 18:14:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 661CD48297;
        Fri, 21 Oct 2016 18:14:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4ihrVgjsoySzug1VwUsfucO6nWI=; b=UMzitr
        /MPUONOWtZOtHIm/9CwUMtT6m5zMcH58wILDHv0qEuQYclH5rN8QYMUeHWj+xxxp
        CP4Vekl2DC5pYLtJzZgapwVcQKwJ2u5BpjUau9yJB1LJyGJHVp2C1lxQKZfm2lne
        7sHt6kh7rLBXZuXA13lxyhH04Kl50VX0jRxoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mVUfzUeRZ85j+cbyVpTHEJZSZi5Ax6Ea
        Wc/VOi/X4jKlpHIBEYehQ0b3CQyL3zQvCYkkyfyESv4wS4gcHd8L0/juUEPeQ4pT
        fD7hig1uA2CPmovzlLDVkUutGwx1v4KlgMR6YtbXHMs5zZv05A1CD3plphSFO6DH
        fmZpkmrQ0y4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CBE748296;
        Fri, 21 Oct 2016 18:14:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E472C48295;
        Fri, 21 Oct 2016 18:14:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] fetch output is ugly in 'next'
References: <20161021002654.qo6kcya4gocp73rs@sigill.intra.peff.net>
        <CACsJy8Bxn1qV+xXNnCpuOQ7qWNsz3oLt5-VG=VXZvV9dvJVvTQ@mail.gmail.com>
        <CACsJy8CkK8K0ty3fv9qyD7wwB+81VPB-P1UUCbDJTJ4iM0Y+Cw@mail.gmail.com>
        <xmqqd1itd4t2.fsf@gitster.mtv.corp.google.com>
        <20161021214218.u46qf3lch3wwiutp@sigill.intra.peff.net>
Date:   Fri, 21 Oct 2016 15:14:08 -0700
In-Reply-To: <20161021214218.u46qf3lch3wwiutp@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 21 Oct 2016 17:42:18 -0400")
Message-ID: <xmqqa8dxbb9r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B14AF878-97DB-11E6-8992-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The "right" fix is to queue up the list of ref updates to print, find
> the abbreviations for each, and then print them all in one shot, knowing
> ahead of time the size necessary to align them. This could also let us
> improve the name-alignment.

Heh, that was what I was starting to code while listening to
Jonathan and Stefan talk in a meeting ;-)

