Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FBBC433E1
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E312064B
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PZSp4kMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGOSPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:15:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64657 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgGOSPi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 14:15:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ECEF4DF8AA;
        Wed, 15 Jul 2020 14:15:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ISS8st4BGfdDKDNRgHGq69rjyGE=; b=PZSp4k
        MQoAOW3zyDiB7qhQJVIp0i/E3IG3rt4HyvogvrGQpO/8jTXNPI5E9mABmGxaVqG0
        LrrM1Ub6UtFW8pf27+P/N3OCBMJ8IECoF+jluL3VG022u4Q2QTZhGm/cHIluYrpG
        dpYZVCbEvb65aIL+aYsBrFOHdfLb9YBHt8LrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y/WNWvSOILYQXR8pBUbHHT8jNt039mqu
        0KKLAdbctHytMacCtMWp5mdF7FsNSvXa17Q906axROxmzg+hzNRARit7DwqUuEVz
        NVBLAyc6XgNI4+zOHwQ6G7S89CS4up/L3QhiX0W7wHYp12BGDO9kIhzP/is31lB6
        FwxSLq4hZxI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4E8CDF8A9;
        Wed, 15 Jul 2020 14:15:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3E93DDF8A7;
        Wed, 15 Jul 2020 14:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Xin Li <delphij@google.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] setup: warn about un-enabled extensions
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
        <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
        <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
        <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
        <xmqqpn8wkben.fsf@gitster.c.googlers.com>
        <xmqqlfjkk8zv.fsf@gitster.c.googlers.com>
        <31f52913-8745-18b4-63fc-37d2a9aea8d0@gmail.com>
Date:   Wed, 15 Jul 2020 11:15:32 -0700
In-Reply-To: <31f52913-8745-18b4-63fc-37d2a9aea8d0@gmail.com> (Derrick
        Stolee's message of "Wed, 15 Jul 2020 14:00:42 -0400")
Message-ID: <xmqqd04wk5kr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CECBDC2-C6C7-11EA-BFBD-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Of course, the _other_ option is to revert xl/upgrade-repo-format
> from v2.28.0 and take our time resolving this issue during the
> 2.29 cycle. I'm not sure how disruptive that action would be.

Yes, that is becoming very much tempting at this point, isn't it?

In any case, I've pushed out 'seen' with the "these extensions that
used to be honored in v0 won't interfere with repository upgrade"
patch I sent earlier, and I am hoping that it would be a reasonable
middle ground that won't regress things for users while making sure
we do not honor random future extensions by mistake.
