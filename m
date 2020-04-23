Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D57C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0882077D
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oXPqcmpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgDWVyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:54:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52662 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgDWVyr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:54:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D38566258;
        Thu, 23 Apr 2020 17:54:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ojd5nwRGtbB03XRRCczy8eeIr4o=; b=oXPqcm
        pAmQl1YK/XlCdagtyDXggOU78o+7Caz8sTQqpoYjCEQxmIKx1xrSJRbMpNx9Chg2
        I6AuVSNh4/zpGjZUs3J2z0K1eEe/qiJ4XKEwb4TzwUOsHdtmIhejiXKvWOYoKTqH
        BTxlcaZqowmm1XX1NCRH/kDDdBW4yH4Y8jIaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wsOm1MqI+AyhHuxBvN6bwivbk6n/MPCK
        +maux+2v279+vHAihjQV2rcNvq0h+r9ec00GKUlKtccaateBe/qVAsTfGHtednb7
        wB/XXhuDsXxFhRhrDamhGALnsq8jQD/l5+bBr6IoyuwIaBcK+yFSiqseETekRoYI
        SLV11eP7vsg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 829AD66257;
        Thu, 23 Apr 2020 17:54:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EEFDF66256;
        Thu, 23 Apr 2020 17:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     peff@peff.net, lkundrak@v3.sk, jrnieder@gmail.com,
        git@vger.kernel.org
Subject: Re: Git 2.26 fetches many times more objects than it should, wasting gigabytes
References: <20200422104000.GA551233@coredump.intra.peff.net>
        <20200423213735.242662-1-jonathantanmy@google.com>
Date:   Thu, 23 Apr 2020 14:54:44 -0700
In-Reply-To: <20200423213735.242662-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 23 Apr 2020 14:37:35 -0700")
Message-ID: <xmqq7dy5g95n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B151CEA-85AD-11EA-93C7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> But in v2:
>
>   if (!haves_added || *in_vain >= MAX_IN_VAIN) {
>
> ("haves_added" is irrelevant to this discussion. It is another
> termination condition - when we have run out of "have"s to send.)
>
> So there is no check that "continue" was sent. We probably should change
> v2 to match v0.

That sounds like a good change.

Thanks.

