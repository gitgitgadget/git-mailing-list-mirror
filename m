Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B351C63697
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 18:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C95A246CA
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 18:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OX3gBKN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgKSSGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 13:06:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51415 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgKSSGX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 13:06:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED5A69805D;
        Thu, 19 Nov 2020 13:06:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fIPV78qB0Tq/xVhzBIOoQ9vkMqE=; b=OX3gBK
        N22AJLnybUs309oFLGtkk+4zbpIruc3E5bqtKANN6zCNrTjhrSfbnDR2An/+9iIs
        8f974ulDIjdCPb1giLnkdHi0zvpvGk8qeq4zMziud2s6sZS9V56k0eJTu1HFVxLS
        gavsDJ0ZOUcSbb5vHSkanQr4d0GR9PmWkLvEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FCFXILoTfrOSQ1VD4CBfy9c2VSeoqLC1
        ApIalXXeDZzhJVwsiWtoX8/BI2OJOen70TMTFlUCLvr0/opX8FwVs8G6FYrUE5ZH
        aHykRB6igGf+GpS48bQ+eWSOR5nsZlhniLQy3V9w4MwUz15V75SVQWkN3MR9T3JN
        lcqKGqOmSJU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5D9A9805C;
        Thu, 19 Nov 2020 13:06:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 674449805A;
        Thu, 19 Nov 2020 13:06:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: ds/maintenance-part-3 (was Re: What's cooking in git.git (Nov
 2020, #02; Mon, 9))
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
        <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
        <20201116235642.GA15562@google.com>
        <xmqqh7po7r3w.fsf@gitster.c.googlers.com>
        <20201117010709.GB15562@google.com>
        <29212864-ab96-5757-cbfb-f5621a43f8d8@gmail.com>
        <xmqqlfez6alb.fsf@gitster.c.googlers.com>
        <f8b1a1cc-dcda-0e53-4c46-bb5bfff3fdd4@gmail.com>
        <xmqqd00ayttk.fsf@gitster.c.googlers.com>
        <2c2db228-069a-947d-8446-89f4d3f6181a@gmail.com>
Date:   Thu, 19 Nov 2020 10:06:19 -0800
In-Reply-To: <2c2db228-069a-947d-8446-89f4d3f6181a@gmail.com> (Derrick
        Stolee's message of "Thu, 19 Nov 2020 08:25:50 -0500")
Message-ID: <xmqq5z61z0f8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDDF4C56-2A91-11EB-80B8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/18/2020 9:16 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>> 
>>> I will get started on this fix as a series on top of part-3.
>> 
>> Thanks.  Not just part-4 but Dscho's test update also depends on
>> this, so let's see it corrected soonish.
>
> I got a decent start yesterday, but I'll put this at the top
> of my pile for today.

Thanks.
