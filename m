Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE2C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 16:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A020E20826
	for <git@archiver.kernel.org>; Thu, 21 May 2020 16:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ix0B3Lbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgEUQeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 12:34:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50526 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgEUQeH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 12:34:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12FD868AAC;
        Thu, 21 May 2020 12:34:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=svQbBh338uCQ0RfV1cISWFsIQbQ=; b=Ix0B3L
        bzUD9BvKWIxYcJA5XPTEjAkcwkObMeABxKy9N1ObzDmzz4eehE5RUKror3fu4liJ
        YS1Iu4VcDGzMn33vX3VkTv70YVCNO7azp0MIGQ6mMY4M9wo88Q+pHbOvlrG4QDQV
        T79ODYFJ9vVFg7+1XmhfCNeN/W9TW1+BZDTbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QkW28CogzG2CsiWXnfy3a+mvNPeoVgh5
        bUW/ldGz3Tu2lrNScsnJKk3qBxFjtP01ryVB0Hi+YUvPnaD2Grie67RO2WTdhqgk
        a/3lvVUqmRivuOlY9bxMrFEJH7fa0cAwDQntpgL33ApNu+vCwumuhRajvNaaaP+b
        tym8waFku5g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2FE768AAB;
        Thu, 21 May 2020 12:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D68368AAA;
        Thu, 21 May 2020 12:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Protocol v2 in v2.27 (Re: Re* [ANNOUNCE] Git v2.27.0-rc1)
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
        <20200520193156.GA4700@coredump.intra.peff.net>
        <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
        <20200520220023.GB3648@google.com>
        <xmqqlflmtaxq.fsf@gitster.c.googlers.com>
        <20200521021533.GC3648@google.com>
Date:   Thu, 21 May 2020 09:34:03 -0700
In-Reply-To: <20200521021533.GC3648@google.com> (Jonathan Nieder's message of
        "Wed, 20 May 2020 19:15:33 -0700")
Message-ID: <xmqqh7w9tfgk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E247B554-9B80-11EA-96EF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> The patch looks good; do we have the master list of things that are
>> under control of feature.experimental knob in the documentation, or
>> is it a feature that we do not have to have a centralized control?
>
> Good catch.  Here's an updated patch with (1) a commit message and (2)
> that doc update.

Heh, that wasn't a rhetorical question but me being just too tired
and lazy to go hunt for the list ;-)  The addition to the section
in this patch looks good, too.

Will queue.

Thanks.

