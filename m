Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 880941F428
	for <e@80x24.org>; Fri,  5 Jan 2018 23:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeAEXNl (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 18:13:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64409 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeAEXNk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 18:13:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C79DCD2768;
        Fri,  5 Jan 2018 18:13:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aSXpwsuo4i3/
        kWJwYZT8dsJDtYY=; b=NV8a6ZN3qyl1uwAqfc1w5FlcHTn7YooZInVxYz9dX+T3
        y8CJLKawfi9Xy7EsoShYaskloGI1o+SbTYAHZ0/eJk25rQXHGyWh3aFKht/ad5Ar
        Z2qkrAEXYLOgvnRINcRxuBSrnmgFn++IJadTaFYVgrIqcV+HZQy6rSKWP2Qzxqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gt76kn
        FJZbXJc2QCuWvrNAbML2FAOeMTol19EIgUOVLNt+uSkJb7DSyLF8eG/aMYXJox3k
        0GGByW0zUdn6Atnv7Cjz7FJg9F85oPZ0ml4JxMCoK7Kp/XvhoyeACvzLkaUo/BZ2
        Io4Wb4FTY4UvFV46t6le3JumouTjpVjKtzW3U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF83AD2767;
        Fri,  5 Jan 2018 18:13:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21FE3D2760;
        Fri,  5 Jan 2018 18:13:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on Windows proper
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
        <20180105221222.28867-1-avarab@gmail.com>
Date:   Fri, 05 Jan 2018 15:13:37 -0800
In-Reply-To: <20180105221222.28867-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 5 Jan 2018 22:12:22 +0000")
Message-ID: <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 105256DE-F26E-11E7-98EE-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Skip the newly added file creation tests on Windows proper, these
> already work under Cygwin, but as that involves a significant
> emulation layer the results are different under Windows proper with
> MinGW.
> ...
> diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
> index f606f91acb..50a53e7a62 100755
> --- a/t/t3070-wildmatch.sh
> +++ b/t/t3070-wildmatch.sh
> @@ -7,6 +7,14 @@ test_description=3D'wildmatch tests'
>  create_test_file() {
>  	file=3D$1
> =20
> +	# These tests limp along under Cygwin, but the failures on
> +	# native Windows are still too many. Skip file tests there
> +	# until they're sorted out.
> +	if test_have_prereq MINGW
> +	then
> +		return 1
> +	fi
> +

That looks to be a nuclear option.  For now it may be suffice, but
somehow it feels that it goes directly against Dscho's wish to treat
(or pretend to treat) Windows as first-class citizens and/or just
like other platforms.


