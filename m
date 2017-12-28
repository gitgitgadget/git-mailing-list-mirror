Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EAA91F406
	for <e@80x24.org>; Thu, 28 Dec 2017 20:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753875AbdL1U2n (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 15:28:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64125 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750854AbdL1U2m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 15:28:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F184C59F5;
        Thu, 28 Dec 2017 15:28:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ekp9fnw13iha
        ZO+52n+C3psYssw=; b=nwtm1yDsdZjh2Ent1dY2BUzbwln1tQ1RcQ9bqu0ISCTu
        gWqUD+OmRWl71nyFWUNVRG6fj6eE4/AmnnLAKy/SlYHkqQf5dqIZ25MstbvT9bXa
        ZSmXQeM2D2e60ECfyQWAfT4OnVxSzhie9YO01fdRW3cx5K5KX4Fkth+SnpfgFS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XKY1ry
        x/Nn9CEYo1yFPiIvrrOYIO5e49AVaZy/hkKlY6FYOwS/HsafMOwHOqK0iAUbgtof
        FUp5SDxs0HE5XesXnsdW8e1B56mhCml7wOT4F6d5R6PRDFMm1EQav3Ye9jJdixUD
        y4FQLHSdYHK7dqErUAA9U3uIx90JXp0my+I2Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 878ECC59F4;
        Thu, 28 Dec 2017 15:28:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAD3EC59F2;
        Thu, 28 Dec 2017 15:28:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 6/7] wildmatch test: perform all tests under all wildmatch() modes
References: <20171225002835.29005-1-avarab@gmail.com>
        <20171223213012.1962-1-avarab@gmail.com>
        <20171225002835.29005-7-avarab@gmail.com>
Date:   Thu, 28 Dec 2017 12:28:39 -0800
In-Reply-To: <20171225002835.29005-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 25 Dec 2017 00:28:34 +0000")
Message-ID: <xmqqh8sak360.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B13E0EBA-EC0D-11E7-867B-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	if test "$match_w_pathmatchi" =3D 1
> +	then
> +		test_expect_success "ipathmatch:    match '$text' '$pattern'" "
> +			test-wildmatch ipathmatch '$text' '$pattern'
> +		"
> +	elif test "$match_w_pathmatchi" =3D 0
> +	then
> +		test_expect_success "ipathmatch: no match '$text' '$pattern'" "

I somehow thought that you earlier decided not to SP align the test title=
s?

Not a big deal but aligning this one alone stood out and I ended up
noticing it, so... ;-)

