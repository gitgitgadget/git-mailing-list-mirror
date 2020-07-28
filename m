Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF12C433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ADB920768
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wg7/9nFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgG1VSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:18:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63802 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1VSL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 17:18:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17F75D9443;
        Tue, 28 Jul 2020 17:18:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ydKxv0AjGoHLcGQUjZU06oQj+aw=; b=wg7/9n
        FzSKSZhk01RDDvA5G3/Wlh/m/1KsiAwD7KNeAqW/+GEcbC6MUZUjlV8Bfi7sy4mJ
        s5RxMg4NgQCLC8ExRK1eQ++C6GnI1mlS9kFn8wJylOQlQoqhlIShf1RpZaNXrluO
        JHUzKtfYGnIsK/TzxCybUyYyzdqJOtZAqpkAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gL1Fd6kFNNzYLLZEp3jXkYkcnOisFB0W
        8nW9VA4IvU8+KS3qDb6+kuzivtfyd7ynZFEbPguzYaIUiXZ/e3wwFOuCpFPcSGyT
        c6CRBeZFez1v9Ykp7X79hdrcaIfItqCO/o6JKUa3PrOCyvtIUIKzFXBR5jKIF0la
        74syBsnwvns=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 10429D9442;
        Tue, 28 Jul 2020 17:18:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5AA76D943D;
        Tue, 28 Jul 2020 17:18:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 11/11] strvec: rename struct fields
References: <20200728202124.GA1021264@coredump.intra.peff.net>
        <20200728202823.GK1021513@coredump.intra.peff.net>
        <xmqqr1svcpcn.fsf@gitster.c.googlers.com>
Date:   Tue, 28 Jul 2020 14:18:05 -0700
In-Reply-To: <xmqqr1svcpcn.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 28 Jul 2020 14:16:24 -0700")
Message-ID: <xmqqmu3jcp9u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4DBEBDE-D117-11EA-9ACB-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I'm actually not that fond of "items". I almost went with just:
>>
>>   const char **v;
>>
>> as the variable name which contains it usually provides sufficient
>> context. But I worried that people would consider that too inscrutable.
>
> I'd agree that v[] is a good name.  If it is too short, I can live
> with item[], but not with items[]....

What are individual component of a vector called?  An element?  If
so, elem[] would be much better name than item[].

