Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5661F991
	for <e@80x24.org>; Wed,  9 Aug 2017 15:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbdHIPuP (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 11:50:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56801 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752332AbdHIPuO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 11:50:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D3C0AABE89;
        Wed,  9 Aug 2017 11:50:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UtqHZ5afJPbp0Yk2CHZjjkD/Ivw=; b=JPMoeW
        txsgsXCegARLgUx8WYdXXcl+vF7IZJVVXpaxN8A4w9LxHrF43bAvoVvCi+9yImiG
        5xpVLL/hpnnC3ki+Q0fzNTASt5XWARnnWtNhR1TK8nSflkcbV9c6FJQGQT9NlcWk
        HSJfYby7d+sWQ/iKSFO/PXB3yq0ij66+HRkeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iPGq7x8wB4l77yummtUgCpqd+WsRm0XI
        7l/eOoPpo/DUcaeYAcbweasgjtY3DfCf2eAw3S+MnFUHGYEnS6cV4q2FotVLKjN4
        y+jt0waZs06zfX3vde0gW+ZdjN/mJBTLSedh2F3F6dDFUliX5VGIu69SqP6YtNWe
        RP472fQ0GAM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB666ABE88;
        Wed,  9 Aug 2017 11:50:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C47FABE84;
        Wed,  9 Aug 2017 11:50:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ian Campbell <ijc@hellion.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] filter-branch: Handle rewritting (very) old style tags which lack tagger
References: <1502179560.2735.22.camel@hellion.org.uk>
        <20170808080620.9536-2-ijc@hellion.org.uk>
        <20170809102040.l5sb6ukqh2225zqm@sigill.intra.peff.net>
Date:   Wed, 09 Aug 2017 08:50:06 -0700
In-Reply-To: <20170809102040.l5sb6ukqh2225zqm@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 9 Aug 2017 06:20:41 -0400")
Message-ID: <xmqqlgms7nbl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B667BBE-7D1A-11E7-9E29-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 08, 2017 at 09:06:20AM +0100, Ian Campbell wrote:
>
>> Such as v2.6.12-rc2..v2.6.13-rc3 in the Linux kernel source tree.
>> 
>> Insert a fake tag header, since newer `git mktag` wont accept the input
>> otherwise:
>
> Hmm. Now your resulting tag will have this crufty "unknown@example.com"
> header baked into it, won't it?
>
> Should we instead make git-mktag more lenient (possibly with a
> command-line option to reduce accidental omissions)?

That sounds sensible. Thanks for injecting a dose of sanity.
