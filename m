Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2034D1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 17:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfHSRiF (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 13:38:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57637 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfHSRiE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 13:38:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3A096FCBB;
        Mon, 19 Aug 2019 13:38:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vnc3x8qNUEZU1/pGJdCx6r1X+a4=; b=hX1Tvd
        qMJYuqthH76pY+BzZe4CfFAODEwDD/poSY0HEKzpek7mb/t+gDFeo2xCKob7wFzI
        ly8lYm3ZXZVML3D5Yg3vlRBv9R3fWNXxcUnknP9RASGCzAd2UdcrSOaNjuyqf3RX
        KW2k2M6PSPhWM7SATqf5Qp6DJTwySH5TsEFFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Sjv4jsZhV8Uwv2Cls0splbQY9dQvl9yj
        U2ncPOdQAZgHrHIiuYHq7aYSnVGstgL3A4G2lQTAzw5cigxIEwDQU2tqzLIGV2Tp
        4xJA+yvsGTZoojTmGzfif5s9gpYZ1AJJ8zPjH8W1dVrlZJXRJy2E4DKQZqj7btEv
        B6N8QsNyJEA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EBC1F6FCBA;
        Mon, 19 Aug 2019 13:38:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 19BAC6FCB7;
        Mon, 19 Aug 2019 13:37:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: [RFE] Teach hash-object to be able to choose signature types
References: <009c01d55481$13d3ce20$3b7b6a60$@nexbridge.com>
        <20190817015123.GD365197@genre.crustytoothpaste.net>
Date:   Mon, 19 Aug 2019 10:37:57 -0700
In-Reply-To: <20190817015123.GD365197@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 17 Aug 2019 01:51:41 +0000")
Message-ID: <xmqqmug5xdhm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 169D5E24-C2A8-11E9-A10B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> trivial. I'm definitely not opposed if someone else is interested in
> picking it up or writing it; I don't believe my outstanding patches
> (which will likely show up on the list this weekend now that 2.23 is
> out) would affect it in any way.
>
> I'll try to push up the work that I'm doing into my "transition-interop"
> branch; it contains the work for literal hashing and a more significant
> refactor, which folks are free to ignore.

Thanks for pushing the SHA-256 transition forward.

>
> The problem is somewhat ameliorated by the fact that for most projects,
> there will be a mapping between SHA-1 and SHA-256, so it'll be possible
> to look up between the two, but it can still be confusing if the "wrong"
> one appears in commit messages, say.

