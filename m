Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993D6C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E499206B7
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FIL3NSnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbgAPUP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:15:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61887 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAPUP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:15:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 434D895746;
        Thu, 16 Jan 2020 15:15:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TI1sUK/dd4cMjftoE/MkPLvo9ZA=; b=FIL3NS
        nxycA9gN/nZcXOUG3pbXx4/l6Az8uXI4TuGBv1C603N+y9qJMPIod0EGQ/pjf9Ml
        2IWFKyStZkOdz9SPriJ/q7OunW+HykqWfyuT30xkkxn3muhLHoyJm4GtS8A7bBE3
        Wse4kF+cZMLiBX9PmPFk5A7TWJSj83V2AKsRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QVdZJjNfKTEjDOw5MKIT05uZ9ac7BxLy
        Yy/HZjgAaAUMnk4q8IYFrCJrVQo1YRr0GR4MtPquY3DC/3Oj0BCCok4/ifCuZ9fZ
        vVPXRc9mx3pYzqzbtbbciPPPpB65G+Y6JLX4MJdLHbAnOUinlei4CYbKtS+MgX+Z
        eXOWe6T4GSg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B6BC95743;
        Thu, 16 Jan 2020 15:15:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E08EC95741;
        Thu, 16 Jan 2020 15:15:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     1234dev <1234dev@protonmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can Git repos be hacked or otherwise manipulated?
References: <fOv65WlolaWZ638trkwZ6nnWIaRu14wx8bYkLdqzidlHPvhYpg1f6TSa_Z7w7iFEsXSLkMzQ6EYTwo3ggF3oXrDh5U4LM_i2Rzx0BkMh7zI=@protonmail.com>
        <20200114220826.GB3957260@coredump.intra.peff.net>
        <bvMqhQOr4uENl8j2zcFOY0ogJmUqTRofCGyPlPc_xaXQXSP5ds9lgdglXkjTZng9U5WSpo-Uc2_SzCTdpAvLTeruT-tW3GTDkWj9dfLznuM=@protonmail.com>
        <20200115180140.GA4081287@coredump.intra.peff.net>
Date:   Thu, 16 Jan 2020 12:15:49 -0800
In-Reply-To: <20200115180140.GA4081287@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 15 Jan 2020 13:01:40 -0500")
Message-ID: <xmqqsgkfgnt6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE379C76-389C-11EA-B7D4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 15, 2020 at 03:18:34AM +0000, 1234dev wrote:
>
>> To work around this problem, should we instead host this repo on a
>> public service? If so which one would you recommend?
>
> Oops, I forgot to mention the actual solution. :)
>
> Generally it is safe to clone _from_ an untrusted repo, even if it's on
> a local filesystem. So untarring the repo and running:
>
>   git clone evil.git safe
>   cd safe
>   git log
>
> should make it OK to run Git commands inside the "safe" directory.

Then there are those who are even more paranoid to consider that
foreign bits hitting their disk platter ^W^W working tree poses
risks (e.g. by background thumbnailers crawling there, getting
exploited by checked out payload that are not trustworthy).

;-)
