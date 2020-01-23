Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B21BC2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 20:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E804E21835
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 20:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mgdwr47L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgAWUX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:23:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50965 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWUX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 15:23:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5D9A3875F;
        Thu, 23 Jan 2020 15:23:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=617q5IRPpvhgxPj4CqIGu3SOqgQ=; b=Mgdwr4
        7LIjE/S1OXS8KqCxa9DEU7nXZZ7SEPLt3+aGkK5qdvdoQ/4NQy0RXfPRH/Chkp40
        2gxSarrMTBCRL9nxxVeNfH9WKMmFfuHxW4oHJhlCWNPSr4RSk/uaH/B2N3fbArz0
        vyiscwFjLIfiB2byHYQieVbMAW5BifL59YgF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GbjcPOADmJ4js4vnjVRbd7h6Cyx4rVEb
        EDPsSi0p717i0BcdEY6dZyaWLEnIT3D70HNHhzI+cy4pmW4p0Vo9tFN9XvKjwTgZ
        p9LIzuQFfLVifdqHDBrzS8UcVpmzyegYy0nf3lFKrjtVClKnlJfNNdXds+3mSJCG
        yc8bU6aY9V0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E1353875A;
        Thu, 23 Jan 2020 15:23:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F12B838748;
        Thu, 23 Jan 2020 15:23:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD0sTTjFXhV3Ad6+2zw2q=rLtDs=FKZrLkE_EaQXdg91Dg@mail.gmail.com>
Date:   Thu, 23 Jan 2020 12:23:23 -0800
In-Reply-To: <CAP8UFD0sTTjFXhV3Ad6+2zw2q=rLtDs=FKZrLkE_EaQXdg91Dg@mail.gmail.com>
        (Christian Couder's message of "Thu, 23 Jan 2020 17:54:54 +0100")
Message-ID: <xmqqftg553d0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35296FC6-3E1E-11EA-93F6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Peff replied to Jonathan's questions and reviewed the above patch V3 series
>
> See for example:
>
> https://public-inbox.org/git/20191209081129.GA1546451@coredump.intra.peff.net/
> https://public-inbox.org/git/20191209061853.GA38588@coredump.intra.peff.net/
>
> I then sent a V4 based on Peff's comments:
>
> https://public-inbox.org/git/20191218112547.4974-1-chriscool@tuxfamily.org/

I don't think I saw any review on the latest round---let me pick it
up and replace with the older round that is on 'pu'.

Thanks.
