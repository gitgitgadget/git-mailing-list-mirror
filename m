Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A7620899
	for <e@80x24.org>; Wed,  2 Aug 2017 16:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbdHBQXp (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 12:23:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56077 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751345AbdHBQXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 12:23:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C2ED8F532;
        Wed,  2 Aug 2017 12:23:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m6a2s3SWhb1TxQSQwss3Ti9slkQ=; b=OIoTQA
        kzpPCaImqYa38xwJy1jmA3Rh9JYDGMp/PnzCUh2+JaoyP92zluBPxlc8cHgTcUEx
        xA1NHpXQ6+gn2+Mg/fwIaYJQuaukleWr2srAKRiR+TbFrHK873bbfE83+SRTwuAw
        +2zGEv+36dqjffNbCn8/kKEPo9/vkd0PGIVG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Iko8NJFLLYwcRFFPgQZPUR+kdMHL8ppl
        LvB7Xhgx5RD2YTKFaq5KVBs1CAJAIaEeXxITypt1o3lWobgUiWqRYmuYYigUlNkj
        WJertmN3dfgAF1a/SlzI3sNqT1JgVRMFa6IF8/95uD2N/Tlweor7gAPyhJSqEoXX
        oAxOSHJBUUk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 048FE8F531;
        Wed,  2 Aug 2017 12:23:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64EC48F530;
        Wed,  2 Aug 2017 12:23:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Richard Jones <richardj@backbase.com>, git@vger.kernel.org
Subject: Re: Git log --tags isn't working as expected
References: <CACq05g+4HH9L_fiFLR8php=w5JkqB0792SzR9EZU-o+QHuoM8A@mail.gmail.com>
        <20170802083200.3rmnz6mx2wfoarng@sigill.intra.peff.net>
Date:   Wed, 02 Aug 2017 09:23:36 -0700
In-Reply-To: <20170802083200.3rmnz6mx2wfoarng@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 2 Aug 2017 04:32:01 -0400")
Message-ID: <xmqqa83idjlj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F010E13C-779E-11E7-9DBB-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   3. Use --simplify-by-decoration to show a particular range of commits,
>      but limit to ones that actually have a ref pointing at them. Like:
>
>        git log <COMMIT_ID>..HEAD --simplify-by-decoration

Nit: dashed options come first and then revs and then pathspecs.

> I think (3) matches what you're trying to do the best. You can't say
> "just tags" for the decoration, though, so you'll see branch tips as
> well. There's been some discussion about allowing specific decorations,
> but nothing merged yet.
