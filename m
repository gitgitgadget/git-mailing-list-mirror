Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05472C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 23:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A359C2082E
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 23:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cJxWr7PA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgAaXBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 18:01:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51252 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgAaXBM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 18:01:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CF7A3D641;
        Fri, 31 Jan 2020 18:01:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8CcleuHJ8+2E2eoOp+xhIGbMpp4=; b=cJxWr7
        PAmjTAXJUr54T2M9tJQmoVv/WN8PCxlnPDi9r1E8jVlCIgOubkDVp1yxAEV8OMqa
        GE4k+14F15lStr4/ZQZQK3nnYqiC38EHpZ1UmK8zlt4Aw8NhXEVcWNlu4Ym1AUv0
        ZS9TO8RvNdxFuxiWQbcnNhy7UnEP30f2Vxx8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J2BED6NMblqWMShDMg+9mjep25Gz8CaW
        A6diaiKrAIzeq5zxn+CA7QrarWZPYTTYScgoKf3+h98V3P/N8H6NJBaen/iw5kgD
        FEtn9v8/FmzqwhWaKUK33s9miwKCOx6Y/LShGxpW/O9JFH208QYGQc1oPlz9DJtg
        bvPyKXadUus=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 061D23D63F;
        Fri, 31 Jan 2020 18:01:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F4BA3D63E;
        Fri, 31 Jan 2020 18:01:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] doc: describe Git bundle format
References: <20200130225818.193825-1-masayasuzuki@google.com>
        <xmqqk1579xa4.fsf@gitster-ct.c.googlers.com>
        <CAJB1erXnNe0yGvL+wgU9RXAA6Vyx7T2dwM9NgCmUChOtL102NQ@mail.gmail.com>
Date:   Fri, 31 Jan 2020 15:01:07 -0800
In-Reply-To: <CAJB1erXnNe0yGvL+wgU9RXAA6Vyx7T2dwM9NgCmUChOtL102NQ@mail.gmail.com>
        (Masaya Suzuki's message of "Fri, 31 Jan 2020 13:49:53 -0800")
Message-ID: <xmqqy2tn8c3w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91BA8788-447D-11EA-A8E3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

>> > +prerequisite = "-" obj-id SP comment LF
>> > +comment      = *CHAR
>>
>> Do readers know what CHAR consists of?  Anything other than NUL and
>> LF?
>
> RFC 5234 defines core rules
> (https://tools.ietf.org/html/rfc5234#appendix-B.1), and these CHAR etc
> are defined there. It should be OK to use these rules.

That's not what I asked.  Do readers know that?  Did you tell them
that we expect they are familiar with the RFC convention?

It might be easier to make the above simple ABNF understandable to
those without knowledge of RFC 5234 by spelling out what CHAR in the
context of the above description means.  Or to tell them "go over
there and learn CHAR then come back".  We need to do one of them.

> I want to make sure the meaning of prerequisites.
>
> 1. Are they meant for a delta base? Or are they meant to represent a
> partial/shallow state?

They are meant as the "bottom boundary" of the range of the pack
data stored in the bundle.

Think of "git rev-list --objects $heads --not $prerequisites".  If
we limit ourselves to commits, in the simplest case, "git log
maint..master".  Imagine your repository has everything up to
'maint' (and nothing else) and then you are "git fetch"-ing from
another repository that advanced the tip that now points at
'master'.  Imagine the data transferred over the network.  Imagine
that data is frozen on disk somehow.  That is what a bundle is.

So, 'maint' is the prerequisite---for the person who builds the
bundle, it can safely be assumed that the bundle will be used only
by those who already has 'maint'.

There is nothing about 'partial' or 'shallow'.  And even though a
bundle typically has deltified objects in the packfile, it does not
have to.  Some objects are delitifed against prerequisite, and the
logic to generate thin packs may even prefer to use the
prerequisites as the delta base, but it is merely a side effect that
the prerequisites are at the "bottom boundary" of the range.

> 2. Do they need to be commits? Or can they be any object type?
>
> From what I can see, it seems that they should always be commits.
>
> 3. Does the receiver have to have all reachable objects from prerequisites?

I would say that the receiver needs to have everything that is
needed to "complete" prereqs.

Bundle transfer predates shallow or incomplete repositories, but I
think that we can (and we should if needed) update it to adjust to
these situations by using the appropriate definition of what it
means to "complete".  In a lazy clone, it may be sufficient to have
promisor remote that has everything reachable from them.  In a
shallow clone, the repository may have to be deep enough to have
them and objects immediately reachable from them (e.g. trees and
blobs for a commit at the "bottom boundary").

Thanks.
