Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E580C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 18:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F002075B
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 18:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FGrSEVR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgHXSi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:38:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61765 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXSi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 14:38:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D728D3B36;
        Mon, 24 Aug 2020 14:38:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=spv+fk6AUMrOTEuOOGIHN3ybmj8=; b=FGrSEV
        R9duNw/1wZcYeaFCI8fprirQBLU3Q7FLC75ii4jukf7Oysy+3EabKRgXgiBaWBLI
        uHOdnO2FaexnZVtZnjXzu2OBAyChnBwFZsXVpZhC2P6WDRTsDwb2nsBPrWlDtdaC
        X6X5E26r0uweETwMw4p8n2o5+y7xgwWkh2qII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zkubj9EnMYhtUP6NE4UhtV3t2lEyao2Y
        pIdr2cY5s5oCVy1PsaGbiMMDrazsEm10lDMyseDT07zCteMfy6xieCO3DdhWDrOd
        LWPNaUu3fqYJQ1o54tNH5vJPCZeUVh6E0pnsTp9KXgByLe+EMJ21tpZHJn9ON4Qa
        88Y8sh8eyCI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04D56D3B35;
        Mon, 24 Aug 2020 14:38:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 43ACAD3B32;
        Mon, 24 Aug 2020 14:38:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ramold\, Felix" <Felix.Ramold@kuka.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: For how long will restore and switch be experimental
References: <VI1PR0102MB327987955EE48E5CB6DD140AE8560@VI1PR0102MB3279.eurprd01.prod.exchangelabs.com>
Date:   Mon, 24 Aug 2020 11:38:52 -0700
In-Reply-To: <VI1PR0102MB327987955EE48E5CB6DD140AE8560@VI1PR0102MB3279.eurprd01.prod.exchangelabs.com>
        (Felix Ramold's message of "Mon, 24 Aug 2020 09:30:37 +0000")
Message-ID: <xmqq4kor6g8z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FECC852-E639-11EA-A0B8-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ramold, Felix" <Felix.Ramold@kuka.com> writes:

> The features git-switch and git-restore where added in 2.23.  I
> think they are great and I want to use them frequently. Also teach
> colleagues.  However, they are still marked experimental, and may
> change. I don't want to learn or teach something that will likely
> change.  Can this be changed to stable?

We are still finding bugs in it, and the details of how they work
may still change, so "will likely change" label still applies.

But we do not plan to say "ah, the experiment was a failure, and
everybody has to unlearn that switch and restore ever existed" at
all, so at this point it is safe to use it.  You just need to be
prepared to adjust your muscle memory in minor and still not
anticipated ways.

Thanks.


