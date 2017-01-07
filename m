Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51BB820756
	for <e@80x24.org>; Sat,  7 Jan 2017 22:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932797AbdAGWAQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 17:00:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63854 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753519AbdAGWAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 17:00:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E32F15B230;
        Sat,  7 Jan 2017 17:00:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i1kMps6iTha3E3TlsVh3SRV+xvM=; b=ofLe1h
        ECTHSFUUKzl1pYHtVyAhfdeFtPDElDkmNllLyjouKf5uKsj5e3MRD5BMuhZLAh5C
        9oSn8Go37l7r+oqADhnp87p0UFii3W1pKrL7SdGH6CFQp8gc52tCgRDROErRL1aF
        AwNUatkp+13MQJfw8LhAn8MNTfL8FQTxUsgaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gFFU/9iN973NFTQANIPO1Wh4SBdgPHkc
        i+h8Zw5sQ53/TXXQApubqpyiNk7w/O1MyomslO5kyIpjHNJKl+miwivCVe+YyP74
        JER98PspdhxJV9mkvcnmgdD3kwV2HCoeom/D5e3nZ6RpGctvpx+aud6iFdEqro8F
        SFXzRsSFKVQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB5685B22F;
        Sat,  7 Jan 2017 17:00:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 36E665B22E;
        Sat,  7 Jan 2017 17:00:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?66eI64iE?= =?utf-8?B?7JeY?= <nalla@hamal.uberspace.de>
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by `asciidoctor`
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
        <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>
        <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>
        <1D7C66EA-E87A-4154-ACAC-8045D28477D2@gmail.com>
        <20170105164556.b3bzeqqzx4pvni4z@sigill.intra.peff.net>
Date:   Sat, 07 Jan 2017 14:00:11 -0800
In-Reply-To: <20170105164556.b3bzeqqzx4pvni4z@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 5 Jan 2017 11:45:57 -0500")
Message-ID: <xmqqfuku3504.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA3D4C76-D524-11E6-9A69-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As far as CI goes, I am not altogether convinced of the usefulness of
> building the documentation. It's very expensive, and the failure mode is
> rarely "whoops, running `make doc` failed". It's almost always that the
> output looks subtly wrong, but that's very hard to check automatically.

I've seen "make doc" break for me when it works for other people,
and if CI can check the formatting for various combinations of
versions of toolchain components, it would have some value.  But
otherwise, I agree that "make doc" in CI would not give us as much
benefit as we spend electricity on it.

If we are to make support for building with AsciiDoctor better, CI
that does "make doc" with both AsciiDoc and AsciiDoctor might be of
help---a "make it buildable with A" patch may accidentally break B
and vice versa.

> [1] I think we've also traditionally considered asciidoc to be the
>     definitive toolchain, and people using asciidoctor are free to
>     submit patches to make things work correctly in both places. I'm not
>     opposed to changing that attitude, as it seems like asciidoctor is
>     faster and more actively maintained these days. But I suspect our
>     build chain would need some improvements. Last time I tried building
>     with AsciiDoctor it involved a lot manual tweaking of Makefile
>     variables. It sounds like Dscho is doing it regularly, though. It
>     should probably work out of the box (with something like
>     USE_ASCIIDOCTOR=Yes) if we expect people to actually rely on it.

I do not mind getting convinced to declare that we will swap the
positions of these two documentation toolchains in some future date,
and a good first step for it to happen would be an easier out-of-box
experience.

Thanks.
