Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35207C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 23:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbiBAXUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 18:20:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63961 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiBAXUh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 18:20:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 202C1170D81;
        Tue,  1 Feb 2022 18:20:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WfAmxXa73acZBBaEHsvV1m2NtRDxwPqQseJHdB
        cPPX8=; b=jDMynXV28EQf+uszby77p74Bv3tLuZer5XzP5KvY+CBNgZyFfb4Qhn
        R/Wv7lKC4mFl9N+kuUtPzliuKEkzcLOn/8QPWsOJjQF19tEcdrqFZJ0Jfr1zBaKP
        MSe70kl4CklZmDbNMJID82K/bm418ub0qx4YKPBKfQBeTmGHN1IoM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1878B170D80;
        Tue,  1 Feb 2022 18:20:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A80D170D7F;
        Tue,  1 Feb 2022 18:20:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>
Subject: Re: [PATCH RESEND] subtree: force merge commit
References: <xmqqpmqy12u0.fsf@gitster.g>
        <20220201172601.262718-1-aclopte@gmail.com>
        <xmqqtudics32.fsf@gitster.g>
        <20220201195325.e5u6zrxabbszzlji@gmail.com>
Date:   Tue, 01 Feb 2022 15:20:33 -0800
In-Reply-To: <20220201195325.e5u6zrxabbszzlji@gmail.com> (Johannes
        Altmanninger's message of "Tue, 1 Feb 2022 20:53:25 +0100")
Message-ID: <xmqqpmo69nsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E90AF00-83B5-11EC-8EFD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> On Tue, Feb 01, 2022 at 11:19:45AM -0800, Junio C Hamano wrote:
>> Johannes Altmanninger <aclopte@gmail.com> writes:
>> 
>> > BTW is there a good way to tell "git send-email --in-reply-to"
>> > to prefill "To:" and "Cc:" based on the message I'm replying to?
>> 
>> I do not think there is, and I do not think it is readily feasible.
>> Given a message ID, how would you figure out these two values?
>> Hardcode the URL of mailing list archive and the rules to find these
>> values given a message ID?  What if you have a local mail archive
>> that you'd rather use instead of going to the public internet?
>
> The "b4" tool accepts message IDs and allows to configure how to look up
> message contents. This is the default:
>
> 	[b4]
> 	# Where to look up threads by message id
> 	midmask = https://lore.kernel.org/r/%s
>
> b4 has some powerful features but I think I just want something that reads an
> email on stdin and outputs the appropriate "send-email --in-reply-to" command.
> I'll probably parse the mail headers myself.

I know about "b4" and use it myself, but so what?  "git" is used by
a lot wider audience than those who can fetch patches from k.org.

So, I think it still is correct to say that it is not readily
feasible, without telling the command ways to turn a message-ID into
to/cc addresses.
