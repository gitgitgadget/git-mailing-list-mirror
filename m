Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995C7C432C3
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE3B206DF
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 16:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a6sjMX+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfLCQvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:51:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61275 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfLCQvC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 11:51:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 292EFA531C;
        Tue,  3 Dec 2019 11:51:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GHrhHTFvfkclBiGUwNS98JXTvHQ=; b=a6sjMX
        +0lwGqgk+REGZ0OXnfECPh3pmlfBIOIx/NrPp6KGgcEzDX6kVfosHsfdsI72xuQx
        TFPSqz0aqy1nWE9Zch6IQtazU4EYXY49GDcCaZqyj5oAyIr5uysKlRIT0cRNm3jr
        xUZOYYbMERrUA59ja+73K5FZsWdR1F7zuEJ1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eFLQheIFq5pgGWNg2ewl3rW5FOFJ98vU
        aji0fgMHlx/bXJi57ltATmsg4xZoirDvmZYGHZVfp6N6s0wB9wW2pUV4F2QB+QjS
        I3knV1vgzLAdvyROIu/XDk6jNRq+OTNbtUZ0Z+17z3y7Sd2EGFby4kxumvgR6w3v
        MC26ymryfiM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21750A531B;
        Tue,  3 Dec 2019 11:51:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5584CA5317;
        Tue,  3 Dec 2019 11:50:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Advice upon clone --recurse-submodules --reference
References: <cover.1574731649.git.jonathantanmy@google.com>
        <cover.1575316490.git.jonathantanmy@google.com>
        <20191203153910.GA6116@sigill.intra.peff.net>
Date:   Tue, 03 Dec 2019 08:50:55 -0800
In-Reply-To: <20191203153910.GA6116@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 3 Dec 2019 10:39:10 -0500")
Message-ID: <xmqqtv6h5p5c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13E893E0-15ED-11EA-B71B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Dec 02, 2019 at 11:57:50AM -0800, Jonathan Tan wrote:
>
>> Thanks everyone! Here's an updated v2 following Peff's suggestions on
>> how to write the advice part.
>
> Thanks, this looks good to me.
>
> I think Junio and I both wondered if the default should be flipped to
> "info", but I don't feel strongly about it, and this seems like an
> improvement in the meantime.

We indeed did, and I agree this is a good step regardless.

Thanks, both.
