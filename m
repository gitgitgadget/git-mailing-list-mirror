Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE57B1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 01:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfDXBLy (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 21:11:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59580 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfDXBLx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 21:11:53 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Apr 2019 21:11:51 EDT
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9D0260B3D;
        Tue, 23 Apr 2019 21:05:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pR7x5ce8NXeOuhW+60bgltMwAy8=; b=Ckif7/
        TCjR8wAkG3vOT/YMKWlv7j3K4AXMoKMeysIcVV5mcuhsK4R/eJNTmNYBaBlHtsu8
        me7DCv4KjD5W+mz3hZ0jEj8o8hIjI9OWeqMATIRar0icGcCuqQnFqMndCjD/NGPe
        fYjLVBH9ICsf41VG+CqPScF3qtK6023Ry7ilA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VirkuWLggkJ7lgtzjrzqye9uOG7v2pu2
        36irLK5FjymKcp/QzNaCyhHnHQtmmCYOqJassKC6QbCOgdD6FmobDxsz2uAkS6Cu
        53nihK6y57SPNPA5NXQPP1uk1Pv2CcyeX+9T35nxDpyOjP+y9P1NndWp1vGIUORt
        ELLQqi+69lA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B236C60B3C;
        Tue, 23 Apr 2019 21:05:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E6D0160B3B;
        Tue, 23 Apr 2019 21:05:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] revisions.txt: mention <rev>~ form
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
        <CACsJy8DB3k=9PaQT4CBz-K3=yjQ1oJAtz6p00PAOjy047XvAyA@mail.gmail.com>
Date:   Wed, 24 Apr 2019 10:05:54 +0900
In-Reply-To: <CACsJy8DB3k=9PaQT4CBz-K3=yjQ1oJAtz6p00PAOjy047XvAyA@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 22 Apr 2019 16:59:43 +0700")
Message-ID: <xmqqh8ao43gt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DB72104-662D-11E9-8199-EE24A11ADF13-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Apr 22, 2019 at 1:14 PM Denton Liu <liu.denton@gmail.com> wrote:
>>
>> In revisions.txt, the '<rev>^' form is mentioned but the '<rev>~' form
>> is missing. Although both forms are essentially equivalent (they each
>> get the first parent of the specified revision), we should mention the
>> latter for completeness. Make this change.
>
> Do we really support this, or is it a bug in rev parsing code that
> treats <rev>~ like <rev>~1?
>
> Hmm.. digging... ah 621ff67594 (rev-parse: fix meaning of rev~ vs
> rev~0., 2008-03-14) at least it's not an unintended bahaviour.

commit 621ff6759414e2a723f61b6d8fc04b9805eb0c20
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Mar 14 11:49:40 2008 -0700

    rev-parse: fix meaning of rev~ vs rev~0.
    
    I think it would make more sense for rev~ to have the same guarantees that
    rev^ has, namely to always return a commit. I would also suggest that not
    giving a number would have the same effect of defaulting to 1, not 0.

Yes, I remember that one: if rev^ means rev^1, rev~ should mean
rev~1, not rev or rev~0.

