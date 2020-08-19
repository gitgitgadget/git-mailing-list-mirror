Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30829C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B3C207DA
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OWM5Ia1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHSTJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:09:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52831 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSTJS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 15:09:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4758F4DD1;
        Wed, 19 Aug 2020 15:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KyiU5T+obXBN9vnl+079zSzm3zk=; b=OWM5Ia
        1g2g7qZggBSDH3+j89O59sbERV1sttU08levCxJT1y4Su0Q/kj4yFaJh/3R37iZE
        GLJ5y4HoIOu0Gpkfv48r7z0o2WJCjhJNYnS2N5QwnsTxyr0whtWgHWszRg25dc+Z
        pcZU/0olOGSW4aeTq/wBEJhMS2LyYZeZlksLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XNefn9aeKom0pNsGXBwH3G7RtYkH8Hzf
        7mVIyI89NQ+mn4l8O63rC4WnymHguY9BGVrvNbJMt/E3zKNpfp0iQry7zRD22Yej
        d4zBdwuCn8nMJKxGGZHJok9l/YyzqK3VkjgCGMLFdrxYNwqfY9z2OkD4wldwYI2l
        SaqD2tXGgSQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCB74F4DD0;
        Wed, 19 Aug 2020 15:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1D310F4DCF;
        Wed, 19 Aug 2020 15:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Lukas Straub'" <lukasstraub2@web.de>,
        "'git'" <git@vger.kernel.org>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Brandon Williams'" <bwilliams.eng@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jeff King'" <peff@peff.net>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
References: <cover.1597853634.git.lukasstraub2@web.de>
        <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
        <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
Date:   Wed, 19 Aug 2020 12:09:11 -0700
In-Reply-To: <04aa01d67659$2dc217b0$89464710$@nexbridge.com> (Randall
        S. Becker's message of "Wed, 19 Aug 2020 14:47:18 -0400")
Message-ID: <xmqqimdetpuw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77F96592-E24F-11EA-9AD4-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> Just putting my CSIO hat on here. We would need a system-wide setting to
> prohibit users from using this capability.

Or just discard this patch, which is a lot simpler.  I don't see any
need for this one.
