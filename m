Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769E11F461
	for <e@80x24.org>; Fri, 21 Jun 2019 15:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFUPLF (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 11:11:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59142 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUPLF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 11:11:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CB776898D;
        Fri, 21 Jun 2019 11:11:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OOMTyMxCjutbmKZYqYH4QHzlC2Q=; b=T52FLA
        ocHVjNHzieGj/buKtX7guiAXEhamTfnxbFUnVtijm4iDx/ZIuIP4Sb+6iV49Dp0T
        ADbp6kAmwCycSlJyleOXiGs8GVz7t5qEqEoh83AOMD+mfzDv104H6xO9G6Pd26hb
        zYfqc/+yCH6iHbsui+4jFYHXSIQnKAWIH/qEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N7CvWaKev1i3t5RAyx4+JzeQG+IgEqwt
        hXU3cjKb/9Ipr9x95zoeLoTONv8RCtwhKutmLwOXnp8nxlLNULK7SR7xm53PwzTt
        8Cyre4Njo+La24QR3S5vdf35oLxu6xjH8tFZp3mnkWX4Zam0Ic3THnPruU4aC5sz
        E10stmy4/zo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6533C6898C;
        Fri, 21 Jun 2019 11:11:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 862DD68987;
        Fri, 21 Jun 2019 11:11:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
References: <20190619095858.30124-1-pclouds@gmail.com>
        <20190619191709.GF28145@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1906211515160.44@tvgsbejvaqbjf.bet>
        <CACsJy8A=Vhwgv8cvs8s2f_aJ5W335s8CdqRQCDSFrdJu2j9fjw@mail.gmail.com>
Date:   Fri, 21 Jun 2019 08:10:58 -0700
In-Reply-To: <CACsJy8A=Vhwgv8cvs8s2f_aJ5W335s8CdqRQCDSFrdJu2j9fjw@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 21 Jun 2019 20:49:50 +0700")
Message-ID: <xmqqd0j7km7x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7608254-9436-11E9-BA71-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Considering the amount of code to output these, supporting multiple
> formats would be a nightmare. I may be ok with versioning the output
> so the tool know what format they need to deal with, but I'd rather
> support just one version. For third parties wanting to dig deep, I
> think libgit2 would be a much better fit.

Yeah, I think starting with --debug=json (or --debug-json) until we
see some stability in the output and got comfortable to the idea of
"version X" to mean what we output at that point, and then renaming
it to "--json" with "version: 1" in the output stream so that third
party can use it (and interpret it according to version 1 rules) is
the way to go.  Third-party tools are welcome to read --debug-json
output as an early-adoption practice waiting for the real thing, but
we do not want to be locked into a schema too eary before we are
ready.

Thanks.
