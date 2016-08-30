Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C2531F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 16:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758454AbcH3Qzg (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 12:55:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55245 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756753AbcH3Qzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 12:55:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0E9A38839;
        Tue, 30 Aug 2016 12:55:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0XEgWwO7Cf+RHmjleDgQqyu/AJg=; b=BDg++D
        P344ZIB/7RFKfyr5/NKbf2pSFiEh6hF0xpHG7Y6NxexZLUaIQnSfR3LJiy3dPrdG
        PMR7MxWlrvrxTgfM2vBX64weujSJerANcXbjoU4r/sXUd5urkWBGDeiAL0NZEwBy
        jYVjEnULeyo6peB9y+1FnWcfi8XdBKUDNc8A8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nB0jHBjS4xTFy6fLgomTyr8V+t6Rj27o
        YvLE7IEL0H54p4TaFU2i98vJXqPwJ+VMTK/I+L7qgNb7n8auNuzuyeec4TbXw3V3
        AhNjscvy4IddEA6X4ZtWGllHaDrLJgf2Qln95ASGdVO542mx3Uv9ShbJsvNVvpS4
        cZgN8jFp180=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97BA738838;
        Tue, 30 Aug 2016 12:55:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E7E338837;
        Tue, 30 Aug 2016 12:55:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Subject: Re: [PATCH v6 10/13] convert: generate large test files only once
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-11-larsxschneider@gmail.com>
        <CAGZ79kZ5utc+0iXKPh=tu4rD9H6+AKZmc08_jLxQhgiuFUA+Yw@mail.gmail.com>
        <E574E25A-F87F-416C-88E5-E3CE1F6B54D0@gmail.com>
        <xmqq37lncvj6.fsf@gitster.mtv.corp.google.com>
        <49AB8322-E322-486E-AF36-2C46BC55C82A@gmail.com>
Date:   Tue, 30 Aug 2016 09:55:31 -0700
In-Reply-To: <49AB8322-E322-486E-AF36-2C46BC55C82A@gmail.com> (Lars
        Schneider's message of "Tue, 30 Aug 2016 13:47:23 +0200")
Message-ID: <xmqqshtm5h8c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90BFD862-6ED2-11E6-819C-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> True, but applying rot13 (via tr ...) on 20+ MB takes quite a bit of
> time. That's why I came up with the 1M SP in between.

Ah, OK, that makes sense (it may not necessarily make it a good
decision, but it certainly explains it).

> However, I realized that testing a large amount of data is not really
> necessary for the final series. A single packet is 64k. A 500k pseudo random
> test file should be sufficient. This will make the test way simpler.

;-)  Thanks.
