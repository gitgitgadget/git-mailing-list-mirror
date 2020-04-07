Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FC8C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D0E20730
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ntP7q7Ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDGWVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:21:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54186 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGWVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 18:21:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 96F26AF9E4;
        Tue,  7 Apr 2020 18:21:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bkfrei75s5AmpJCK5mFxYIZehFw=; b=ntP7q7
        IgtHnsIvE/tgPuwDkZo2YSpnOHlqgNyjLtswZn4XrfqriI1QRUUYFXV2ZOGqdjAv
        yM4B8cIO/o6G6zAgVMaGwKNOBlKy9TYUsGZeKysC7W3J/Bl0Tk6FMTya0v+Dfapz
        SvyB3p3JKMNugITcsXOpAgeX/Wsh8CyTT4b2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m5X0vHArCQwfioe2HrUdd0OPajASCpDP
        tkBo1C+ic93uun+wYYbe99xJBByrR5Lrmvrc050kDfxji+3s9d3QkpcAKQ4J8dig
        QuXOtPvYYCOl8K2pjKPsfWPvZ62Fwtdz7RDXThXpH9WQkOu431xk984V55lDj/zG
        ckKTXuOiznI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EC78AF9E3;
        Tue,  7 Apr 2020 18:21:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D97C5AF9DF;
        Tue,  7 Apr 2020 18:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Emma Brooks <me@pluvano.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: teach --no-encode-headers
References: <20200405231109.8249-1-me@pluvano.com>
        <xmqqd08lwatm.fsf@gitster.c.googlers.com>
        <20200407034622.GA42812@pluvano.com>
        <xmqq8sj7t7d0.fsf@gitster.c.googlers.com>
        <20200407203111.GA1936475@coredump.intra.peff.net>
Date:   Tue, 07 Apr 2020 15:20:58 -0700
In-Reply-To: <20200407203111.GA1936475@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 7 Apr 2020 16:31:11 -0400")
Message-ID: <xmqq8sj7rl85.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F30E480-791E-11EA-80E5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Saying "--no-rfc2047-encoding" would be more descriptive to _me_, but I
> wonder if people not so familiar with the standards would find it a bit
> obscure. Another option is to invert it to "--8bit-email-headers" or
> something.

Yup, having "rfc2047" in the name of the option was one of the
things I considered suggesting, but I didn't for the same reason.  I
am OK with "--[no-]8bit-email-headers" (when --8bit, rfc2047 is
skipped).  Or "--[no-]email-header-encoding".

Thanks.
