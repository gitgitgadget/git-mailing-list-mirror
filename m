Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096F820898
	for <e@80x24.org>; Wed, 19 Jul 2017 23:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754098AbdGSXD0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 19:03:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54347 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752288AbdGSXDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 19:03:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D9E895760;
        Wed, 19 Jul 2017 19:03:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FYhaJ/kTjn0ObskBF7HDH8AEZos=; b=Isetj3
        zeTOYF406ae1qnY6Xpz+WAbVT2K9UTD+5VvKfNkJ1/IrDs1IFDaTovtiE/MZReG5
        a65n5ufIlO+8aNguMOYy1u2vNHjw7QZ2GgIk9Ge8Xt8b/0gaP5bhEW+HPpJKcoLZ
        Ehd59IxCuMg1JKitvnoM+eCgEigcC2L5TZ/KE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Agw6A6nuem7p3AiFMKBZAd77Wp/w2if1
        JNUR5cCl18mj+3cPYEe685wyq4dbhfd8+lkvYpgbD2t31ti88B6msdKVYoVTFLIr
        JdgvVsItV2hKSL1C55992pbH1Ri2qqRFVSnYh1ueMC2RCqTFyMJbWr5H9YuciwT1
        F+LELr5Sh54=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 235C29575F;
        Wed, 19 Jul 2017 19:03:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A6CF9575E;
        Wed, 19 Jul 2017 19:03:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
        <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
        <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
        <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
        <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
        <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
        <alpine.DEB.2.21.1.1707191456010.4193@virtualbox>
Date:   Wed, 19 Jul 2017 16:03:21 -0700
In-Reply-To: <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> (Johannes
        Schindelin's message of "Wed, 19 Jul 2017 15:25:09 +0200 (CEST)")
Message-ID: <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77112F58-6CD6-11E7-914B-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But there may be hope. Since the character sequence "PRItime" is highly
> unlikely to occur in Git's source code in any context other than the
> format to print/parse timestamp_t, it should be possible to automate a the
> string replacement
>
> 	git ls-files -z \*.[ch] |
> 	xargs -0r sed -i 's/PRItime/PRIuMAX/g'
>
> (assuming, of course, that you use GNU sed, not BSD sed, for which the
> `-i` needs to read `-i ''` instead) as part of the update?

I somehow missed this bit.

Given that this needs to be done only once every release by only one
person (i.e. the l10n coordinator who updates *.pot file), as long
as the procedure is automated as much as possible to ease the pain
for the l10n coordinator and clearly described in the "Maintaining
the po/git.pot file" section of po/README, something along that line
does sound like a very tempting approach.  If it works well, it is
certainly much easier for normal developers than the other possible
alternatives I mentioned in my previous response.

It is brittle as you already said, but perhaps a bit of anchoring
like \<PRItime\>, the brittle-ness may not hurt in practice.  

I didn't look at "git grep PRItime" output for hits, though.

