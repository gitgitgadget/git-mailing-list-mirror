Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA8BECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 17:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiIURfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 13:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIURfT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 13:35:19 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D396F844CC
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 10:35:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19C24151D25;
        Wed, 21 Sep 2022 13:35:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6/vs4w7O/CR/g4xT4ko6mVEbWGTGgzSFNzjgZt
        PguVM=; b=tzHs+QBm/4UnCmvyz6bAIbPLTI0RD/V7OikGiFydeg4cUejgoDJFg0
        QO7dodPzpOECZPEX2Nwj9PzUW8C48FGEbmjpDykv87QL7wT15W8HDmB5S12v38GV
        mNt4Rywl8cRfA6U6CjhiZ3OLn10K5gnz9aX9U03I7z26WUtXt9MaM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12C7A151D24;
        Wed, 21 Sep 2022 13:35:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C4B3151D23;
        Wed, 21 Sep 2022 13:35:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: don't translate literal commands
References: <20220920050725.326383-1-alexhenrie24@gmail.com>
        <YyoPXmNGAvl6p+C2@coredump.intra.peff.net>
Date:   Wed, 21 Sep 2022 10:35:14 -0700
In-Reply-To: <YyoPXmNGAvl6p+C2@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 20 Sep 2022 15:07:10 -0400")
Message-ID: <xmqqa66s4oml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0D7DF9A-39D3-11ED-9E64-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Sep 19, 2022 at 11:07:25PM -0600, Alex Henrie wrote:
>
>> These commands have no placeholders to be translated.
>
> I think this is the right thing to do, but your commit message made me
> pause for a second. When you say "placeholders", I think you mean %s,
> etc. And yes there aren't any here, but that is not the reason not to
> translate. The reason not to translate is that the strings are commands
> which are given to a machine.

I had the same reaction.  The strings shown in the choices need to
be given as spelled and there is no i18n there.


> So maybe something like:
>
>   There are no human-readable parts of these strings; the command you
>   type is still "git maintenance" even in other languages.

I think calling that "no human-readable" would probably give another
confusion, though.

The title uses a good phrase: "literal commands", so the latter half
of your rewrite should be sufficient.

    The command you type is still "git maintenance" even in other
    languages.

> Regardless, the patch looks good to me. Thanks for catching it.

Yes.  Good finding.

Will apply.
