Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851131F404
	for <e@80x24.org>; Thu, 15 Feb 2018 05:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeBOFJO (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 00:09:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64787 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeBOFJN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 00:09:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49370CFDF9;
        Thu, 15 Feb 2018 00:09:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=4SJiWDMYzHzDh
        M0bLpdUhRfsSTI=; b=wTo33ijma1+cYojqFwswMlr+xPTEMpVS66/pvk4r5nfcr
        LZhebskxQk4KStH3jaYkuqiyhS1egbglY8oIPiGAVEblfV5QG7AxAl9dkiGoTBF4
        l/9+GUykpXgQQ+SBopNtDGZ9l3JKP0zlCc4Slxz0tWn6WFaHcpOOHROb7H7MN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=AoTB2OM
        uTYzdJ/WI1LAC8Tacs3dNwI+lKK2q0JPiLito2xD0iP3MDMymILWJ7pU0SCK0TiA
        crwCzAp98wyLq299Jvzgm2YHZQISAwam+tu9e5LWv1v58IhjrhNnXxHorfP0b9hB
        511wLOZr6Vpqrc3CuwN5rEWaCkherEv+9g6k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4000FCFDF8;
        Thu, 15 Feb 2018 00:09:12 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACCDACFDF7;
        Thu, 15 Feb 2018 00:09:11 -0500 (EST)
Date:   Thu, 15 Feb 2018 00:09:10 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 3/8] perl: generalize the Git::LoadCPAN facility
Message-ID: <20180215050909.GD27038@zaya.teonanacatl.net>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-4-avarab@gmail.com>
 <20180214225754.GC136185@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180214225754.GC136185@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Pobox-Relay-ID: 5C152F3C-120E-11E8-B665-D3940C78B957-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Jonathan Nieder wrote:
> =C6var Arnfj=F6r=F0 Bjarmason wrote:
> [...]
>> +++ b/perl/Git/LoadCPAN.pm
>> @@ -0,0 +1,74 @@
> [...]
>> +The Perl code in Git depends on some modules from the CPAN, but we
>> +don't want to make those a hard requirement for anyone building from
>> +source.
>=20
> not about this patch: have we considered making it a hard requirement?
> Both Mail::Address and Error.pm are pretty widely available, and I
> wonder if we could make the instructions in the INSTALL file say that
> they are required dependencies to simplify things.
>=20
> I admit part of my bias here is coming from the distro world, where we
> have to do extra work to get rid of the FromCPAN embedded copies and
> would be happier not to have to.

Heh, a similar bias is what led me to suggest a Makefile
knob to prevent installing the fallbacks.  I neglected to
add you to the Cc list on that reply.  But I was thinking of
Debian and other distributions whom I know would similarly
want to exclude Git/FromCPAN from their git packages.  I
know it's a simple rm, but it might as well be a simple rm
in one place than spread across each package.  :)

It may still be worth considering whether it's reasonable to
make Mail::Address and Error.pm hard requirements, but I'm
not sure if there are any platforms where such a requirement
would be a pain.  If there are folks here who are happy to
maintain this fallback method, then a simple Makefile knob
gives us the best of both worlds.

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Historian, n. A broad-gauge gossip.
    -- Ambrose Bierce, "The Devil's Dictionary"

