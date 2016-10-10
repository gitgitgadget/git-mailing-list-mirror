Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC5420989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbcJJSPM (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:15:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50123 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752534AbcJJSPL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:15:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04C7443C7E;
        Mon, 10 Oct 2016 14:15:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UZLVLuWOUutTZ59K7ZXdEmwPOmU=; b=dB0Pr3
        lZH0I5nFrlek4/hGIMezRXT9r13s19mDtFVKfXt55CxA60S7STItS5bB30yHOUXA
        7ZdtvJORXR1pAr+b25/ilhoI1kzeJKLokYRcFmkIs8BPE6ehfxQa9qz27NzsAESk
        HseRlMYpodFAmH/bmtEOYlud7miYsWZhKa48I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wvbxy+gRb3dj3jh37GwiVN1YuipXmp+W
        9MXmNBoTodK9NvDgKZLuzC4vhCEtfbNj7H4K45GO5wgr3bqNEbCqreMIci93vgaQ
        2U3zAIL3K1LBZjUcRGL1c+GT+WzKKoTf/F96eo5ORhtZkoiyoVQEo2c8sl8SL7OG
        qF9MznOXO34=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0BE343C7D;
        Mon, 10 Oct 2016 14:15:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A3F343C7C;
        Mon, 10 Oct 2016 14:15:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clean up confusing suggestion for commit references
References: <20161007095638.GA55445@book.hvoigt.net>
Date:   Mon, 10 Oct 2016 11:15:07 -0700
In-Reply-To: <20161007095638.GA55445@book.hvoigt.net> (Heiko Voigt's message
        of "Fri, 7 Oct 2016 11:56:38 +0200")
Message-ID: <xmqqlgxwf4us.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A8C2B28-8F15-11E6-B7B8-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

>  If you want to reference a previous commit in the history of a stable
> -branch, use the format "abbreviated sha1 (subject, date)",
> +branch, use the format 'abbreviated sha1 ("subject", date)',
>  with the subject enclosed in a pair of double-quotes, like this:
>  
>      Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)

As long as the "like this" example is there close to the sentence
"use the format ...", I do not think it matters either way in
practice, but I think this change is adding unnecessary confusion.

Both the 'subject' and 'date' on that line are meant to be
placeholders, so where you see subject, you replace it "with the
subject enclosed in a pair of double-quotes" as the next line says.
But then you would end up with:

     Commit f86a374 (""pack-bitmap.c: fix a memleak"", 2015-03-30)

which is not what we want to see.

