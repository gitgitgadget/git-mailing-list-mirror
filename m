Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5868FC43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 15:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1E1206DB
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 15:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u06bM9CV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgC2Ptp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 11:49:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50781 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgC2Pto (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 11:49:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2D25CADE5;
        Sun, 29 Mar 2020 11:49:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a9r0NSWPJNUDLJ5rEfLAIQ8C+y8=; b=u06bM9
        CVzgoLhmpkFkFRnLaIIv5iJr2PdftaxgaolPfLiocxhK8KRbI2QdljAOPMeTI+XZ
        jr0MXLlSCHVPWxzu3d9N8IUdDo3wcxy/VNXTfcbRlUV8hn4q69hupFYfEqHwxghj
        MLWj7TQ+m48TSJC/oHENkRnxsP7BiDzpGwGPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rnu/gQOs5v7zcQB7kMZqvzRBBJv3aW5u
        Ny532OUNEnLmlp55SxylxaHHuGpNlyqv3d+zcox5LOxSAzUlQ6AXX7hRGh0FBSRB
        jfeuDHf2ZQVZ+DwbRnizRy6tTIgLb3R89rvI5et4ALCesFXD6tESVLOfL0kTNvBI
        tv/dJDEuC00=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DAD73CADE4;
        Sun, 29 Mar 2020 11:49:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2DF12CADE3;
        Sun, 29 Mar 2020 11:49:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib-functions: simplify packetize() stdin code
References: <20200327080210.GA604725@coredump.intra.peff.net>
        <20200327080300.GA605934@coredump.intra.peff.net>
        <xmqq1rpdhaid.fsf@gitster.c.googlers.com>
        <20200328112010.GC639140@coredump.intra.peff.net>
        <20200329150226.GA16068@coredump.intra.peff.net>
Date:   Sun, 29 Mar 2020 08:49:38 -0700
In-Reply-To: <20200329150226.GA16068@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 29 Mar 2020 11:02:26 -0400")
Message-ID: <xmqqv9mnb1pp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E67AD820-71D4-11EA-AFA7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here it is as a patch on top. I doubt it matters that much (there are
> only two stdin calls in the whole suite). So I'm not sure if this patch
> should be "eh, why not?" or "meh, pointless churn".

Me, neither. ;-)
