Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BF6C433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09302078B
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g5uqttZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgGJUPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:15:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65418 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJUPS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 16:15:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FECBD370B;
        Fri, 10 Jul 2020 16:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lvn8PSwr6OdiY9kvAmfpmhRhLSY=; b=g5uqtt
        Z8mtw2R6jUNXzTtP5/c4A0ukSBDMg66A2IOZQeApFcHoB0BZuqsPJwxCDj/3cSP2
        2tuw4rKyOr9CD76qUQhsMMhHQYUSTn6Y579jfBME4nugOOEb39nruSmHuDGOcbfj
        xZiKhBzcsKxTgvjMlvX1Ti5azpZYa0DVjD87w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q8A1GsDNExzjTnDNkYullbM6SJz9AQ/z
        wbUD9/T6zZDcltPdkJzwtZGY72wAaJ9PV4HR9AZDlHGbJf1dMPl+KuVZTJyMv0YE
        pdmbtKVsDYpBhRj3SmBkZsIMu6ZuLFs+CPpKo2HrAZxjwlP1MawkgsOE3vGUihAZ
        cwUcj7KUCNc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85613D370A;
        Fri, 10 Jul 2020 16:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E59FD3703;
        Fri, 10 Jul 2020 16:15:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/38] SHA-256, part 3/3
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
        <68cc8fe8-3400-501a-ead5-a9c008605e74@gmail.com>
        <20200710195507.GK9782@camp.crustytoothpaste.net>
Date:   Fri, 10 Jul 2020 13:15:10 -0700
In-Reply-To: <20200710195507.GK9782@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 10 Jul 2020 19:55:07 +0000")
Message-ID: <xmqqft9zt9dd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F6F48C2-C2EA-11EA-B903-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-07-10 at 15:14:37, Derrick Stolee wrote:
>> On 7/9/2020 10:46 PM, brian m. carlson wrote:
>> > This is the final part required for the stage 4 implementation of
>> > SHA-256.
>> 
>> WOOHOO! What a milestone!
>
> I'm also excited about this.  It's been a lot of work, but we're finally
> here.

Thanks.
