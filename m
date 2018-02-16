Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2C71F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162502AbeBPRzZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:55:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61748 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162497AbeBPRzX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:55:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FC97C8E8D;
        Fri, 16 Feb 2018 12:55:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=Hq2U35AsO/qNb
        oFb9KU99OXXV9w=; b=Btxi/rPhjVU88rBnxzKY58NiMkstK+8WMKgW/6x6hH8IE
        5aHu2k9enlp9P57hlktcJzsmA94UwEWke8RyN96UlF5mWSM+p9FAK0Vkah1Exklw
        Ma8defqJEEFPtdVvX17eyS+eIu2uo/QiJdxFvhmIiYbMZUHA8VtytRNh/ZJ/Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=ANW7U7G
        mIhWJTUTbw6UlsDFC0PsdIJXueeharYwhrXeNA7F5lgB0oi6PwE/N75jEBv+kWsb
        Pbgym2W5H+S5H7LEikfUeT6x74kg/MpAmwzcdY6PI44aF+AY+kAxCxcg+vk5+g7H
        S/GC95bEQrnEfy7fNrdEruQk0QVTG7fFSnow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20FBFC8E8C;
        Fri, 16 Feb 2018 12:55:22 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D01DC8E8B;
        Fri, 16 Feb 2018 12:55:21 -0500 (EST)
Date:   Fri, 16 Feb 2018 12:55:19 -0500
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
Message-ID: <20180216175519.GQ27038@zaya.teonanacatl.net>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-4-avarab@gmail.com>
 <20180215045301.GC27038@zaya.teonanacatl.net>
 <87sha2f0j1.fsf@evledraar.gmail.com>
 <20180215212338.GL27038@zaya.teonanacatl.net>
 <87k1vdf188.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87k1vdf188.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Pobox-Relay-ID: 8EB13D5C-1342-11E8-8A0F-D3940C78B957-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Thu, Feb 15 2018, Todd Zullinger jotted:
>> What about moving perl/Git/FromCPAN to perl/FromCPAN and
>> then including perl/FromCPAN in LIB_PERL{,_GEN} only if
>> NO_PERL_CPAN_FALLBACKS is unset?
>>
>>  LIB_PERL :=3D $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm pe=
rl/Git/*/*/*.pm)
>> +ifndef NO_PERL_CPAN_FALLBACKS
>> +LIB_PERL +=3D $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
>> +endif
>>  LIB_PERL_GEN :=3D $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL=
))
>>
>> I haven't tested that at all, so it could be broken in many
>> ways.
>=20
> Yes that's a much better idea, it evades the whole problem of conflatin=
g
> the perl/Git* glob.

I did test this yesterday and it seems to work well.  Here
it is in patch form, in case it's helpful to you for the
next version.  It might well be better as part of a commit
teaching Git::LoadCPAN to respect NO_PERL_CPAN_FALLBACKS.

---- 8< ----
From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] Makefile: add NO_PERL_CPAN_FALLBACKS to disable fallback
 module install

As noted in perl/Git/LoadCPAN.pm, operating system packages often don't
want to ship Git::FromCPAN tree at all, preferring to use their own
packaging of CPAN modules instead.  Allow such packagers to set
NO_PERL_CPAN_FALLBACKS to easily avoid installing these fallback perl
CPAN modules.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Makefile                                    | 6 ++++++
 perl/{Git =3D> }/FromCPAN/.gitattributes      | 0
 perl/{Git =3D> }/FromCPAN/Error.pm            | 0
 perl/{Git =3D> }/FromCPAN/Mail/.gitattributes | 0
 perl/{Git =3D> }/FromCPAN/Mail/Address.pm     | 0
 5 files changed, 6 insertions(+)
 rename perl/{Git =3D> }/FromCPAN/.gitattributes (100%)
 rename perl/{Git =3D> }/FromCPAN/Error.pm (100%)
 rename perl/{Git =3D> }/FromCPAN/Mail/.gitattributes (100%)
 rename perl/{Git =3D> }/FromCPAN/Mail/Address.pm (100%)

diff --git a/Makefile b/Makefile
index 5bcd83ddf3..838b3c6393 100644
--- a/Makefile
+++ b/Makefile
@@ -296,6 +296,9 @@ all::
 #
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
+# Define NO_PERL_CPAN_FALLBACKS if you do not want to install fallbacks =
for
+# perl CPAN modules.
+#
 # Define PYTHON_PATH to the path of your Python binary (often /usr/bin/p=
ython
 # but /usr/bin/python2.7 on some platforms).
 #
@@ -2297,6 +2300,9 @@ po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
=20
 LIB_PERL :=3D $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/=
Git/*/*/*.pm)
+ifndef NO_PERL_CPAN_FALLBACKS
+LIB_PERL +=3D $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
+endif
 LIB_PERL_GEN :=3D $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
=20
 ifndef NO_PERL
diff --git a/perl/Git/FromCPAN/.gitattributes b/perl/FromCPAN/.gitattribu=
tes
similarity index 100%
rename from perl/Git/FromCPAN/.gitattributes
rename to perl/FromCPAN/.gitattributes
diff --git a/perl/Git/FromCPAN/Error.pm b/perl/FromCPAN/Error.pm
similarity index 100%
rename from perl/Git/FromCPAN/Error.pm
rename to perl/FromCPAN/Error.pm
diff --git a/perl/Git/FromCPAN/Mail/.gitattributes b/perl/FromCPAN/Mail/.=
gitattributes
similarity index 100%
rename from perl/Git/FromCPAN/Mail/.gitattributes
rename to perl/FromCPAN/Mail/.gitattributes
diff --git a/perl/Git/FromCPAN/Mail/Address.pm b/perl/FromCPAN/Mail/Addre=
ss.pm
similarity index 100%
rename from perl/Git/FromCPAN/Mail/Address.pm
rename to perl/FromCPAN/Mail/Address.pm
--=20
2.16.1

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Damn you and your estrogenical treachery!
    -- Stewie Griffin

