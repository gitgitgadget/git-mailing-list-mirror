Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 944B81F404
	for <e@80x24.org>; Sat, 17 Feb 2018 05:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750960AbeBQFk4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Feb 2018 00:40:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61761 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeBQFkz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Feb 2018 00:40:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D47CFD301F;
        Sat, 17 Feb 2018 00:40:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=SJYF3WrTWWj6q9FowwdDDe2xxlE=; b=ZPzso0Y
        L9JykUqqoN9VoGs0XQsQs7GvXV8d6UFRWrbh8hYXnWRRBMGrfh6PTsEU0lImCXy9
        jH4AqNxP1nXSMZqWlotyKhgwtowIL0LCB/i80Q8D4dxOd4Gk1kWkgmE6hsokZcJc
        SUJz24aZDfuk4oeitkrPpyV3TPU1v2DUhc9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=qn5b4rJ2Ua+fla/l16ptn/QsaZLRNTRM0
        7BrXwPg+a2L5xp1wZpxdb/ktRwwb57A0/hvMpp2wwx4vmI2L2MhQHwR2Hqci0w4o
        JPe97UMhPHVCW7Hv+tB4lthRU/SHX8TpIA/atx4SBKoWW+0OKaZugv4iq44Sge30
        IDRCvmW+pw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB9DCD301E;
        Sat, 17 Feb 2018 00:40:54 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B4B7D301C;
        Sat, 17 Feb 2018 00:40:54 -0500 (EST)
Date:   Sat, 17 Feb 2018 00:40:52 -0500
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
Message-ID: <20180217054052.GU27038@zaya.teonanacatl.net>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-4-avarab@gmail.com>
 <20180215045301.GC27038@zaya.teonanacatl.net>
 <87sha2f0j1.fsf@evledraar.gmail.com>
 <20180215212338.GL27038@zaya.teonanacatl.net>
 <87k1vdf188.fsf@evledraar.gmail.com>
 <20180216175519.GQ27038@zaya.teonanacatl.net>
 <20180216220300.GC216564@aiede.svl.corp.google.com>
 <20180217004753.GS27038@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217004753.GS27038@zaya.teonanacatl.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Pobox-Relay-ID: 1EE75124-13A5-11E8-B417-D3940C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote:
> Hi Jonathan,
> 
> Jonathan Nieder wrote:
>> Todd Zullinger wrote:
> [...]
>>> +++ b/Makefile
>>> @@ -296,6 +296,9 @@ all::
>>>  #
>>>  # Define NO_PERL if you do not want Perl scripts or libraries at all.
>>>  #
>>> +# Define NO_PERL_CPAN_FALLBACKS if you do not want to install fallbacks for
>>> +# perl CPAN modules.
>> 
>> nit: Looking at this as a naive user, it's not obvious what kind of
>> fallbacks are meant. How about:
>> 
>> 	Define NO_PERL_CPAN_FALLBACKS if you do not want to install bundled
>> 	copies of CPAN modules that serve as a fallback in case the modules are
>> 	not available on the system.
>> 
>> Or perhaps:
>> 
>> 	Define HAVE_CPAN_MODULES if you have Error.pm and Mail::Address installed
>> 	and do not want to install the fallback copies from perl/FromCPAN.
> 
> Hmm, a positive variable like HAVE_CPAN_MODULES is
> appealing.
> 
> I don't know about listing the modules, as those seem likely
> to change and then the comment becomes stale.  It's nice to
> have a shorter name.  I could easily go back and forth.
> Hopefully some other folks will chime in with preferences.
> 
>> Would this patch need to update the loader to expect the modules in
>> the new location?
> 
> That's a good catch.  In checking how this ends up when not
> setting NO_PERL_CPAN_FALLBACKS, we end up installing
> FromCPAN at the root of $perllibdir rather than under the
> Git dir.
> 
> While we could probably fix Git::LoadCPAN, I doubt we want
> to pollute the namespace. ;) So we'll want to ensure the
> files get put in the right place from the start.  I'll try
> to fix that up.

I ended up adding a second variable to hold the FromCPAN
wildcard match, as I couldn't come up with any clean way to
do it in the same LIB_PERL{,_GEN} vars.

I tested it with and without NO_PERL_CPAN_FALLBACKS set and
with and without the system Error and Mail::Address modules
installed.  There's nothing which automatically removes the
perl/build/lib/Git/FromCPAN tree if make was run without
NO_PERL_CPAN_FALLBACKS set and then re-run with it.  I don't
know if that's something we'd care to support or not.  I
suspect it's simpler to require 'make clean' between such
runs.

(I had to restore the FromCPAN copy of Address.pm, as noted
in <87tvuif10e.fsf@evledraar.gmail.com>, of course.)

Here's what it looks like now (still subject to changing the
NO_PERL_CPAN_FALLBACKS variable).

---- 8> ----
From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] Makefile: add NO_PERL_CPAN_FALLBACKS knob

We include some perl modules which are not part of the core perl
install, as a convenience.  This allows us to rely on those modules in
our perl-based tools and scripts without requiring users to install the
modules from CPAN or their operating system packages.

Users whose operating system provides these modules and packagers of Git
often don't want to ship or use these bundled modules.  Allow these
users to set NO_PERL_CPAN_FALLBACKS to avoid installing the bundled
modules.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Makefile                                    | 14 ++++++++++++++
 perl/{Git => }/FromCPAN/.gitattributes      |  0
 perl/{Git => }/FromCPAN/Error.pm            |  0
 perl/{Git => }/FromCPAN/Mail/.gitattributes |  0
 perl/{Git => }/FromCPAN/Mail/Address.pm     |  0
 5 files changed, 14 insertions(+)
 rename perl/{Git => }/FromCPAN/.gitattributes (100%)
 rename perl/{Git => }/FromCPAN/Error.pm (100%)
 rename perl/{Git => }/FromCPAN/Mail/.gitattributes (100%)
 rename perl/{Git => }/FromCPAN/Mail/Address.pm (100%)

diff --git a/Makefile b/Makefile
index bdd50069af..49244fb116 100644
--- a/Makefile
+++ b/Makefile
@@ -296,6 +296,10 @@ all::
 #
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
+# Define NO_PERL_CPAN_FALLBACKS if you do not want to install bundled
+# copies of CPAN modules that serve as a fallback in case the modules are
+# not available on the system.
+#
 # Define PYTHON_PATH to the path of your Python binary (often /usr/bin/python
 # but /usr/bin/python2.7 on some platforms).
 #
@@ -2300,15 +2304,25 @@ po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 
 LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
 LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
+ifndef NO_PERL_CPAN_FALLBACKS
+LIB_CPAN := $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
+LIB_CPAN_GEN := $(patsubst perl/%.pm,perl/build/lib/Git/%.pm,$(LIB_CPAN))
+endif
 
 ifndef NO_PERL
 all:: $(LIB_PERL_GEN)
+ifndef NO_PERL_CPAN_FALLBACKS
+all:: $(LIB_CPAN_GEN)
+endif
 endif
 
 perl/build/lib/%.pm: perl/%.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	sed -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' < $< > $@
 
+perl/build/lib/Git/FromCPAN/%.pm: perl/FromCPAN/%.pm
+	$(QUIET_GEN)mkdir -p $(dir $@) && cp $< $@
+
 perl/build/man/man3/Git.3pm: perl/Git.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	pod2man $< $@
diff --git a/perl/Git/FromCPAN/.gitattributes b/perl/FromCPAN/.gitattributes
similarity index 100%
rename from perl/Git/FromCPAN/.gitattributes
rename to perl/FromCPAN/.gitattributes
diff --git a/perl/Git/FromCPAN/Error.pm b/perl/FromCPAN/Error.pm
similarity index 100%
rename from perl/Git/FromCPAN/Error.pm
rename to perl/FromCPAN/Error.pm
diff --git a/perl/Git/FromCPAN/Mail/.gitattributes b/perl/FromCPAN/Mail/.gitattributes
similarity index 100%
rename from perl/Git/FromCPAN/Mail/.gitattributes
rename to perl/FromCPAN/Mail/.gitattributes
diff --git a/perl/Git/FromCPAN/Mail/Address.pm b/perl/FromCPAN/Mail/Address.pm
similarity index 100%
rename from perl/Git/FromCPAN/Mail/Address.pm
rename to perl/FromCPAN/Mail/Address.pm
-- 
2.16.2

I thought about using '$(INSTALL) -m 644' instead of 'cp' to
allow users to set 'INSTALL = install -p' to preserve the
timestamp of the FromCPAN files, but that would only be
useful to users installing from the same tarball version
multiple times.  The intersection of users who care that
much about consistent timestamps and don't care about using
system perl modules seems small.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A person who smiles in the face of adversity ... probably has a
scapegoat.

