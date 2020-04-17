Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A95C2BB1D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 05:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B44C2223D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 05:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yBDSonDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgDQFiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 01:38:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63586 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgDQFiX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 01:38:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 323A3B27DE;
        Fri, 17 Apr 2020 01:38:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N692GINVSjaZMZCJnTFzNS7AQRE=; b=yBDSon
        DY/KKWBwQCQAaI8ak9RDCa6Jej4g+R12zVlrjdg2zp21+Jv0VYlcdPhrBRYA1Hds
        HdJP5+/sNT8JCDQtY/QaeeiVJa/0ouKck/P6BqyMFi6jMwD1R2Mi5rfve/KzvN1a
        YUN2KspHX6iNSM2hOO9MRF6UIqO93C5RjWlFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lS4eAjaYuCjzl9aBaqNgbbBWJkH3/4hc
        5eaV7xzZ9AjlOzuCg7/gipght13ZWyoi+I9v+2n25L3jnsdf/7hd89pk3ggimech
        7TmeJHtMYM41Lgy3T/nMqyZORMSTTM7iUyjh6uHcY+P8JBZ6Ex+W/9HJ3F1dT3VN
        Y1n5qbM696k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A932B27DD;
        Fri, 17 Apr 2020 01:38:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 78A41B27DC;
        Fri, 17 Apr 2020 01:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
        <20200417022416.GE2285@danh.dev>
Date:   Thu, 16 Apr 2020 22:38:16 -0700
In-Reply-To: <20200417022416.GE2285@danh.dev> (Danh Doan's message of "Fri, 17
        Apr 2020 09:24:16 +0700")
Message-ID: <xmqqr1wmwu2f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A45525E8-806D-11EA-8333-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> On 2020-04-15 16:01:52-0700, Junio C Hamano <gitster@pobox.com> wrote:
>> * dd/iso-8601-updates (2020-04-15) 2 commits
>>  - date.c: allow compact version of ISO-8601 datetime
>>  - date.c: skip fractional second part of ISO-8601
>> 
>>  The approxidate parser learns to parse seconds with fraction.
>> 
>>  Will merge to 'next'.
>
> I thought we haven't gained enough concious for "12:34:56.7.days.ago"
> Current code will treat it as "7 days ago at 12:34:56"
> New code will treat it as 12:34:56 (today?)

Yup, it clearly is a regression, and I do not think there is an
agreement that the regression matters in real life.

