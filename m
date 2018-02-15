Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1C81F404
	for <e@80x24.org>; Thu, 15 Feb 2018 21:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161926AbeBOVXm (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 16:23:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62725 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161516AbeBOVXl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 16:23:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B3FADC189;
        Thu, 15 Feb 2018 16:23:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=y+K3yfREB+Su7
        N93IUfuV8UxfOM=; b=hanP0pn09ZDgcxpnvTD5kq4WNhuWYCE7SUwd6NV90LPv9
        fSvdyJJ2ZIZFE1ZA3u7gbXdc8tPD0NRaoefcjCPBFaVHjwxyLHWiG+tQiIxBU3Jc
        VSEgx2xUYU/xBbKQr6BNSwFsxTNVQRT4L1sa9cg/KCht5aU0X96P+vBLQvo/2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=rVWG96L
        rUpVP/nz2ixwr0gur2oDbJqNbwdlxONCdYKtf0o4Uc1VH+j3U3gmLM8QdzLq9Dpb
        OHs+kauat4HloakO4X2e5Tzk+UADMLrKpmk/wHc5uXxS1aTx96gpWRprdJ9T/RZ4
        5l5oJCKL6il2gEPXivKt7fjy5WrTZd3RXMdQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B469DC188;
        Thu, 15 Feb 2018 16:23:41 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB012DC185;
        Thu, 15 Feb 2018 16:23:40 -0500 (EST)
Date:   Thu, 15 Feb 2018 16:23:38 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 3/8] perl: generalize the Git::LoadCPAN facility
Message-ID: <20180215212338.GL27038@zaya.teonanacatl.net>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-4-avarab@gmail.com>
 <20180215045301.GC27038@zaya.teonanacatl.net>
 <87sha2f0j1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87sha2f0j1.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Pobox-Relay-ID: 7E502880-1296-11E8-AC74-D3940C78B957-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[I dropped bbourbie@slb.com from the Cc: list, as it bounced
on my previous reply.]

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> That makes sense, I'll incorporate that in a re-roll. I like
> NO_PERL_CPAN_FALLBACKS or just NO_CPAN_FALLBACKS better.

Either is an improvement.  Starting with NO_PERL_ seems
like a slightly better bikeshed color. :)

> I'd really like to find some solution that works differently though,
> because with this approach we'll run the full test suite against a
> system where our fallbacks will be in place (although if the OS
> distributor has done as promised we won't use them), and then just
> remove this at 'make install' time, also meaning we'll re-gen it before
> running 'make install' again, only to rm it again.
>=20
> The former issue we could deal with by munging the Git::LoadCPAN file s=
o
> it knows about NO_PERL_CPAN_FALLBACKS, and will always refuse to use th=
e
> fallbacks if that's set. That's a good idea anyway, because right now i=
f
> you e.g. uninstall Error.pm on Debian (which strips the CPAN fallbacks)
> you get a cryptic "BUG: ..." message, it should instead say "we couldn'=
t
> get this module the OS promised we'd have" or something to that effect.

Teaching Git::LoadCPAN to never fallback sounds like a good
idea.  At least then if the packager intended to avoid the
fallbacks and didn't get it right the error message could be
more useful.

Hopefully that's not a common problem for packagers though.
(And adding the Makefile knob was intended to help make it
easier for packagers to achieve this common goal.)

> The latter is trickier, I don't see an easy way to coerce the Makefile
> into not copying the FromCPAN directory without going back to a
> hardcoded list again, the easiest thing is probably to turn that:
>=20
>     $(TAR) cf - .)
>=20
> Into:
>=20
>     $(TAR) cf - $(find ... -not ....)
>=20
> Or something like that to get all the stuff that isn't the Git/FromCPAN
> directory.
>=20
> Other suggestions most welcome.

What about moving perl/Git/FromCPAN to perl/FromCPAN and
then including perl/FromCPAN in LIB_PERL{,_GEN} only if
NO_PERL_CPAN_FALLBACKS is unset?

 LIB_PERL :=3D $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/=
Git/*/*/*.pm)
+ifndef NO_PERL_CPAN_FALLBACKS
+LIB_PERL +=3D $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
+endif
 LIB_PERL_GEN :=3D $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))

I haven't tested that at all, so it could be broken in many
ways.

Thanks,

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The nice thing about egotists is that they don't talk about other
people.
    -- Lucille S. Harper

