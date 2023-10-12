Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984B1CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 01:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjJLBjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 21:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjJLBjK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 21:39:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8880C4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 18:39:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34F841E32C;
        Wed, 11 Oct 2023 21:39:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=SFtSGtGfVy2Mvmf+J1fFieV+qDIISviYkJJJ6V
        zlDvc=; b=dle/k1dxI/kfb42O+fb0M5NIMHJa6I3hQEQzwQyUtrMiYQITwHXvti
        Whb7Je/cctcD1uENT9/L4ZqYCUYShLDjsLnXr28FR5+/o8EE//UPab8O5pwfjSa9
        HfuHg6HN7IfD5v5geq6tKK4XVUd06AA5J1UUiarxP/nbr6OTi/V2A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1ED251E32B;
        Wed, 11 Oct 2023 21:39:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5D2341E32A;
        Wed, 11 Oct 2023 21:39:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christoph Anton Mitterer <calestyo@scientia.org>,
        git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <20231012000416.GA520855@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 11 Oct 2023 20:04:16 -0400")
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
        <xmqqa5sokdd3.fsf@gitster.g>
        <20231012000416.GA520855@coredump.intra.peff.net>
Date:   Wed, 11 Oct 2023 18:39:01 -0700
Message-ID: <xmqqh6mwipqi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FE0B7E0-68A0-11EE-A68C-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... Digging into the history and
> the changelog, this note is in "changes between less versions 487 and
> 530":
>
>   Don't output terminal init sequence if using -F and file fits on one
>   screen.

;-)

That is really a good one to dig out.  So in short, X was needed
because we wanted to use F, and we could drop it if everybody is
using recent versions of less, but the default to use FX at the same
time gives us the same behaviour between both newer and older
versions of less.

> ... And as you say, if there are people who really
> care about their LESS options, it is easy for them to override it.

Yup.  I really like the discovery of that changelog entry.

Thanks.
