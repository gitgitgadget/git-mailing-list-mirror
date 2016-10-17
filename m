Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27DC1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 17:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934662AbcJQRuZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 13:50:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54912 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932599AbcJQRuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 13:50:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDEDF46BF9;
        Mon, 17 Oct 2016 13:50:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f1c1ZVyrD+m5Gb0nFFXPj2KcuQA=; b=r728DJ
        850Nvrq4xH29QQQk5Lb4ElCe8xGegmYp2aBywOMpBLia1cHqy92bpu9UM7Ird/w/
        0k7R2e92thXI1C1p4VnHBgVGJmTwAwPyy/yKS6Ns4inJXL1T5GyNenPxpJYVdNwq
        yD5lL7S3va+VSoLVWjXP2j1X1teWSSeQZXkyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sVNHbw0fPodUYzTy8hELWFvhJhdDQrhs
        t7RwLQNupZJq54yFI2Y6x0xrsA79NHFcN3dJUnJpnZIv+j8k+GercHzmbkSK5RQB
        2l/TT6CdrtZiLxg4p8o4WjjQQzvrcXiSWuVfXq2I0sXDxKm5BJaMjoKqQ+uDV304
        LEl7rAnE/c0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5B6D46BF8;
        Mon, 17 Oct 2016 13:50:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4067E46BF7;
        Mon, 17 Oct 2016 13:50:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [RFC] Case insensitive Git attributes
References: <C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com>
        <CAGZ79kZ6KaQ5gjGiEFQ-pRJCDAyS0oH=_4dK0nCU9hx8wZwdfw@mail.gmail.com>
        <alpine.DEB.2.20.1610171056170.197091@virtualbox>
        <CACsJy8BBLcZvB1FswcEKS1KgvjMjo_uaVqOTgjmMJkjnmoye+w@mail.gmail.com>
        <alpine.DEB.2.20.1610171241240.197091@virtualbox>
        <CACsJy8ASnvryrrWvr4ACWL_9oeKgE_4SUqcRHGf+Y6kcaeDUhg@mail.gmail.com>
Date:   Mon, 17 Oct 2016 10:50:21 -0700
In-Reply-To: <CACsJy8ASnvryrrWvr4ACWL_9oeKgE_4SUqcRHGf+Y6kcaeDUhg@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 17 Oct 2016 18:02:50 +0700")
Message-ID: <xmqqzim2vp9e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DA6FCC0-9492-11E6-BC39-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I agree. Which is why I wrote "we probably want something in the same
> spirit but limited to .gitattributes and .gitignore only". In other
> words we could have core.someName that makes .gitattributes and
> .gitignore patterns case-insensitive (or core-sensitive). If it's
> present, it overrides core.ignoreCase. If it's not present,
> core.ignoreCase decides. I'm just not sure if the new config should
> cover everything involving filename's case in git. That's too big to
> fit in my head.

Once I stopped thinking about this as "filename's case", it does fit
my head ;-)

I view the proposed knob as making patterns in .gitattributes and
.gitignore case insensitive, iow, it is a lazy and useful short-hand
for (mentally) editing "*.c attr" to "*.[cC] attr" without touching
these files.

And I agree that the knob that is missing in today's Git should
default to whatever core.ignoreCase's value is, iow, on case
insensitive filesystem, attr and ignore may match case insensitively
in today's Git, but when the knob is introduced, it should allow
forcing case sensitive match there by setting it to false, just like
the knob is proposed to be used in the oppositite direction to force
case insensitive match regardless of the case insensitiveness of the
underlying filesystem.
