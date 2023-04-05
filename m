Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877E3C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 10:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbjDEKKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 06:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbjDEKKV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 06:10:21 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E2130D4
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 03:10:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4DBFD3200A48
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 06:10:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 05 Apr 2023 06:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1680689415; x=1680775815; bh=fV87wPhFwNCFZz5tn4lIYvcBz
        o1AxbF9a2ZHt85JsLA=; b=lhV3Z9XyzDYiWTOd+tWHO2SGzKphJ3PzQQC4Nr/xs
        bJQi34yE5dlYo6AaO8Vo8kx85lSwHcrhcnA93WROCvrOIjpjt56IPyXAZmYvISR1
        HCHFGtmAqY1Qa2zUBM+tCfVsDYZSlmUxe0HiMEfdJnywjvimgHKwbUhwmgBdubIR
        +la4GtunxNeOAlA9dtl1iJkHvptSmVxElNhNCLulxCEeyCoJFTfm+didJlALcUde
        olUouZKnmvHrWq1yRhRNOvZn6hd1BcXyOhcvbXyDqjW3RJmYPGzY+9Duxume3Ote
        6BGbSlKDBaK8yEfcn7lcMeFUFxqpnvMJ8N7Nqw5cLJW4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680689415; x=1680775815; bh=fV87wPhFwNCFZz5tn4lIYvcBzo1AxbF9a2Z
        Ht85JsLA=; b=DdIZG05GYXLkBlULoiczmAAHA1Au4BeyN3ypjenkTaSbSRKLLto
        75NP/LIXNf/TSdQw/n9JxHf+92mU9o0+kb4NS5MKdctHq3SjydQxSeo4oQfwZIbR
        xfUwCijILVgmAZ3oPEYkPQtNfPiPA7HzPdXwbWY1PQhp23yHMrbaH5CpRv4kL1lV
        h1cbsb5RDkEBYNqq8UKhq1L/GMVRM6kZ0DpSk9N5AAQi8AOYkMu6SuIgh/SYaGhS
        /Nvecgw+ooYiMJEqX7WdS/bb7W98eQMvyzjv1jUhlMwWeZuTjTqw1RFO/WreUOeE
        sQqPa8VMJvp+nQi8C93T3FjWL25KzacudiA==
X-ME-Sender: <xms:B0ktZCM6A_dKi9CFiDXC0B5VzMG12byAXTANaVxtHjJNgIqws-_7aw>
    <xme:B0ktZA9P1Uz8hJjHo5ubpeTN6pZ21G4CoohIdWZER8uFlisb3NmwYOK2kbk_Def5Y
    8siYGkc8Mn5yWz3QQ>
X-ME-Received: <xmr:B0ktZJR7DjdtaQ8ae6HswIaY8lU_pvgvvucODV9XCT1wAlqnNzFwmD6n3olVOTU7QsEB1k1OlNDRoyfdVeBjtOQ101-QhWfLR6L_nP3RHz5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepvdfhveekffegudfgteejhffftdeuvdehtdejke
    dvhfegtdehvdffkeeuvdejvdegnecuffhomhgrihhnpehtleelleelrdhshhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hm
X-ME-Proxy: <xmx:B0ktZCsChf1UZw_lRw1lD-_5MIkXaYS6LF_bioVl7PW220csyaTC0Q>
    <xmx:B0ktZKdSfPd1TlOnTh3pm89ov81QkKICGdjM89vNsWT1BiCRsvKcnQ>
    <xmx:B0ktZG3XC5eXAsbodvl4nG6V1tQApsUB4RUMszTvsBBMu1Zhtkld0w>
    <xmx:B0ktZMq0iJH4Xd1uarxVweg47vPhGZb03SJwc1QI3rhJuHXDCiUIkQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 5 Apr 2023 06:10:14 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id b2b594a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 5 Apr 2023 10:10:05 +0000 (UTC)
Date:   Wed, 5 Apr 2023 12:10:10 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] global: resolve Perl executable via PATH
Message-ID: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8A1ujGGfUxGaIsO6"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8A1ujGGfUxGaIsO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The majority of Perl scripts we carry in Git have a `#!/usr/bin/perl`
shebang. This is not a portable location for the Perl interpreter and
may thus break on some systems that have the interpreter installed in a
different location. One such example is NixOS, where the only executable
installed in `/usr/bin` is env(1).

Convert the shebangs to resolve the location of the Perl interpreter via
env(1) to make these scripts more portable. While the location of env(1)
is not guaranteed by any standard either, in practice all distributions
including NixOS have it available at `/usr/bin/env`. We're also already
using this idiom in a small set of other scripts, and until now nobody
complained about them.

This makes the test suite pass on NixOS.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/build-docdep.perl                    | 2 +-
 Documentation/cat-texi.perl                        | 2 +-
 Documentation/cmd-list.perl                        | 3 ++-
 Documentation/fix-texi.perl                        | 4 +++-
 Documentation/lint-fsck-msgids.perl                | 2 +-
 Documentation/lint-gitlink.perl                    | 2 +-
 Documentation/lint-man-end-blurb.perl              | 2 +-
 Documentation/lint-man-section-order.perl          | 2 +-
 compat/vcbuild/scripts/clink.pl                    | 5 ++++-
 compat/vcbuild/scripts/lib.pl                      | 5 ++++-
 contrib/buildsystems/CMakeLists.txt                | 2 +-
 contrib/buildsystems/engine.pl                     | 5 ++++-
 contrib/buildsystems/generate                      | 5 ++++-
 contrib/buildsystems/parse.pl                      | 5 ++++-
 contrib/contacts/git-contacts                      | 2 +-
 contrib/credential/netrc/git-credential-netrc.perl | 2 +-
 contrib/credential/netrc/test.pl                   | 2 +-
 contrib/diff-highlight/Makefile                    | 2 +-
 contrib/fast-import/git-import.perl                | 2 +-
 contrib/fast-import/import-directories.perl        | 2 +-
 contrib/fast-import/import-tars.perl               | 2 +-
 contrib/hooks/setgitperms.perl                     | 2 +-
 contrib/hooks/update-paranoid                      | 2 +-
 contrib/long-running-filter/example.pl             | 2 +-
 contrib/mw-to-git/git-mw.perl                      | 2 +-
 contrib/mw-to-git/git-remote-mediawiki.perl        | 2 +-
 contrib/mw-to-git/t/test-gitmw.pl                  | 6 +++++-
 contrib/stats/mailmap.pl                           | 2 +-
 contrib/stats/packinfo.pl                          | 2 +-
 contrib/subtree/t/Makefile                         | 2 +-
 git-archimport.perl                                | 2 +-
 git-cvsexportcommit.perl                           | 2 +-
 git-cvsimport.perl                                 | 2 +-
 git-cvsserver.perl                                 | 2 +-
 git-send-email.perl                                | 2 +-
 git-svn.perl                                       | 2 +-
 gitweb/gitweb.perl                                 | 2 +-
 t/Git-SVN/Utils/can_compress.t                     | 2 +-
 t/Git-SVN/Utils/fatal.t                            | 2 +-
 t/check-non-portable-shell.pl                      | 2 +-
 t/lib-gitweb.sh                                    | 2 +-
 t/perf/aggregate.perl                              | 2 +-
 t/perf/min_time.perl                               | 2 +-
 t/t0019/parse_json.perl                            | 2 +-
 t/t0202/test.pl                                    | 2 +-
 t/t0210/scrub_normal.perl                          | 2 +-
 t/t0211/scrub_perf.perl                            | 2 +-
 t/t0212/parse_events.perl                          | 2 +-
 t/t4034/perl/post                                  | 2 +-
 t/t4034/perl/pre                                   | 2 +-
 t/t7519/fsmonitor-all-v2                           | 2 +-
 t/t7519/fsmonitor-watchman                         | 2 +-
 t/t7519/fsmonitor-watchman-v2                      | 2 +-
 t/t9700/test.pl                                    | 2 +-
 t/test-terminal.perl                               | 2 +-
 templates/hooks--fsmonitor-watchman.sample         | 2 +-
 56 files changed, 78 insertions(+), 56 deletions(-)

diff --git a/Documentation/build-docdep.perl b/Documentation/build-docdep.p=
erl
index 1b3ac8fdd9..fe6a1e724d 100755
--- a/Documentation/build-docdep.perl
+++ b/Documentation/build-docdep.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 my %include =3D ();
 my %included =3D ();
diff --git a/Documentation/cat-texi.perl b/Documentation/cat-texi.perl
index 14d2f83415..5b44d64f7d 100755
--- a/Documentation/cat-texi.perl
+++ b/Documentation/cat-texi.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 755a110bc4..3fe43b8968 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -1,5 +1,6 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
=20
+use warnings;
 use File::Compare qw(compare);
=20
 sub format_one {
diff --git a/Documentation/fix-texi.perl b/Documentation/fix-texi.perl
index ff7d78f620..61287a0a9e 100755
--- a/Documentation/fix-texi.perl
+++ b/Documentation/fix-texi.perl
@@ -1,4 +1,6 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+
+use warnings;
=20
 while (<>) {
 	if (/^\@setfilename/) {
diff --git a/Documentation/lint-fsck-msgids.perl b/Documentation/lint-fsck-=
msgids.perl
index 1233ffe815..fd2209e4f8 100755
--- a/Documentation/lint-fsck-msgids.perl
+++ b/Documentation/lint-fsck-msgids.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 my ($fsck_h, $fsck_msgids_txt, $okfile) =3D @ARGV;
=20
diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.p=
erl
index 1c61dd9512..b27418ee16 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
diff --git a/Documentation/lint-man-end-blurb.perl b/Documentation/lint-man=
-end-blurb.perl
index 6bdb13ad9f..d1ee7ba130 100755
--- a/Documentation/lint-man-end-blurb.perl
+++ b/Documentation/lint-man-end-blurb.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
diff --git a/Documentation/lint-man-section-order.perl b/Documentation/lint=
-man-section-order.perl
index 02408a0062..27921ef66f 100755
--- a/Documentation/lint-man-section-order.perl
+++ b/Documentation/lint-man-section-order.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink=
=2Epl
index 3bd824154b..74be842ebd 100755
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -1,4 +1,7 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+
+use warnings;
+
 ######################################################################
 # Compiles or links files
 #
diff --git a/compat/vcbuild/scripts/lib.pl b/compat/vcbuild/scripts/lib.pl
index d8054e469f..6f2c2cb89f 100755
--- a/compat/vcbuild/scripts/lib.pl
+++ b/compat/vcbuild/scripts/lib.pl
@@ -1,4 +1,7 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+
+use warnings;
+
 ######################################################################
 # Libifies files on Windows
 #
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMa=
keLists.txt
index 2f6e0197ff..43d64909cb 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -848,7 +848,7 @@ string(REPLACE "@@INSTLIBDIR@@" "${INSTLIBDIR}" perl_he=
ader "${perl_header}")
=20
 foreach(script ${git_perl_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
-	string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" cont=
ent "${content}")
+	string(REPLACE "#!/usr/bin/env perl" "#!/usr/bin/env perl\n${perl_header}=
\n" content "${content}")
 	string(REPLACE "@@GIT_VERSION@@" "${PROJECT_VERSION}" content "${content}=
")
 	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
 endforeach()
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index ed6c45988a..ea32de593c 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -1,4 +1,7 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+
+use warnings;
+
 ######################################################################
 # Do not call this script directly!
 #
diff --git a/contrib/buildsystems/generate b/contrib/buildsystems/generate
index bc10f25ff2..41c1967496 100755
--- a/contrib/buildsystems/generate
+++ b/contrib/buildsystems/generate
@@ -1,4 +1,7 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+
+use warnings;
+
 ######################################################################
 # Generate buildsystem files
 #
diff --git a/contrib/buildsystems/parse.pl b/contrib/buildsystems/parse.pl
index c9656ece99..03050ab28d 100755
--- a/contrib/buildsystems/parse.pl
+++ b/contrib/buildsystems/parse.pl
@@ -1,4 +1,7 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+
+use warnings;
+
 ######################################################################
 # Do not call this script directly!
 #
diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 85ad732fc0..a9ce8edb85 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 # List people who might be interested in a patch.  Useful as the argument =
to
 # git-send-email --cc-cmd option, and in other situations.
diff --git a/contrib/credential/netrc/git-credential-netrc.perl b/contrib/c=
redential/netrc/git-credential-netrc.perl
index 9fb998ae09..514f68d00b 100755
--- a/contrib/credential/netrc/git-credential-netrc.perl
+++ b/contrib/credential/netrc/git-credential-netrc.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/te=
st.pl
index c0fb3718b2..4387379d52 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use warnings;
 use strict;
diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makef=
ile
index f2be7cc924..9da2a0b442 100644
--- a/contrib/diff-highlight/Makefile
+++ b/contrib/diff-highlight/Makefile
@@ -1,6 +1,6 @@
 all: diff-highlight
=20
-PERL_PATH =3D /usr/bin/perl
+PERL_PATH =3D /usr/bin/env perl
 -include ../../config.mak
=20
 PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
diff --git a/contrib/fast-import/git-import.perl b/contrib/fast-import/git-=
import.perl
index 0891b9e366..440790523d 100755
--- a/contrib/fast-import/git-import.perl
+++ b/contrib/fast-import/git-import.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Performs an initial import of a directory. This is the equivalent
 # of doing 'git init; git add .; git commit'. It's a little slower,
diff --git a/contrib/fast-import/import-directories.perl b/contrib/fast-imp=
ort/import-directories.perl
index a16f79cfdc..5ea90dada9 100755
--- a/contrib/fast-import/import-directories.perl
+++ b/contrib/fast-import/import-directories.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Copyright 2008-2009 Peter Krefting <peter@softwolves.pp.se>
 #
diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/imp=
ort-tars.perl
index d50ce26d5d..d28c7b1a4a 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 ## tar archive frontend for git-fast-import
 ##
diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms.perl
index 2770a1b1d2..18444e0157 100755
--- a/contrib/hooks/setgitperms.perl
+++ b/contrib/hooks/setgitperms.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Copyright (c) 2006 Josh England
 #
diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
index 0092d67b8a..a85d3badd1 100755
--- a/contrib/hooks/update-paranoid
+++ b/contrib/hooks/update-paranoid
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use File::Spec;
diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-=
filter/example.pl
index a677569ddd..0ca49e370b 100755
--- a/contrib/long-running-filter/example.pl
+++ b/contrib/long-running-filter/example.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Example implementation for the Git filter protocol version 2
 # See Documentation/gitattributes.txt, section "Filter Protocol"
diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.perl
index eb52a53d32..cb0cd63ea7 100755
--- a/contrib/mw-to-git/git-mw.perl
+++ b/contrib/mw-to-git/git-mw.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 # Copyright (C) 2013
 #     Benoit Person <benoit.person@ensimag.imag.fr>
diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-gi=
t/git-remote-mediawiki.perl
index a5624413dc..9ae596f3b7 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -1,4 +1,4 @@
-#! /usr/bin/perl
+#!/usr/bin/env perl
=20
 # Copyright (C) 2011
 #     J=E9r=E9mie Nikaes <jeremie.nikaes@ensimag.imag.fr>
diff --git a/contrib/mw-to-git/t/test-gitmw.pl b/contrib/mw-to-git/t/test-g=
itmw.pl
index c5d687f078..9005837713 100755
--- a/contrib/mw-to-git/t/test-gitmw.pl
+++ b/contrib/mw-to-git/t/test-gitmw.pl
@@ -1,4 +1,8 @@
-#!/usr/bin/perl -w -s
+#!/usr/bin/env perl
+
+use strict;
+use warnings;
+
 # Copyright (C) 2012
 #     Charles Roussel <charles.roussel@ensimag.imag.fr>
 #     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
diff --git a/contrib/stats/mailmap.pl b/contrib/stats/mailmap.pl
index 9513f5e35b..469af8240c 100755
--- a/contrib/stats/mailmap.pl
+++ b/contrib/stats/mailmap.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use warnings 'all';
 use strict;
diff --git a/contrib/stats/packinfo.pl b/contrib/stats/packinfo.pl
index be188c0f11..51823ac942 100755
--- a/contrib/stats/packinfo.pl
+++ b/contrib/stats/packinfo.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # This tool will print vaguely pretty information about a pack.  It
 # expects the output of "git verify-pack -v" as input on stdin.
diff --git a/contrib/subtree/t/Makefile b/contrib/subtree/t/Makefile
index 093399c788..b22cd62236 100644
--- a/contrib/subtree/t/Makefile
+++ b/contrib/subtree/t/Makefile
@@ -8,7 +8,7 @@
=20
 #GIT_TEST_OPTS=3D--verbose --debug
 SHELL_PATH ?=3D $(SHELL)
-PERL_PATH ?=3D /usr/bin/perl
+PERL_PATH ?=3D /usr/bin/env perl
 TAR ?=3D $(TAR)
 RM ?=3D rm -f
 PROVE ?=3D prove
diff --git a/git-archimport.perl b/git-archimport.perl
index b7c173c345..3f46e0c1dc 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # This tool is copyright (c) 2005, Martin Langhoff.
 # It is released under the Gnu Public License, version 2.
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 289d4bc684..c674c22e4f 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use 5.008;
 use strict;
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 7bf3c12d67..56011991d6 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 # This tool is copyright (c) 2005, Matthias Urlichs.
 # It is released under the Gnu Public License, version 2.
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 7b757360e2..9388efddf2 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 ####
 #### This application is a CVS emulation layer for git.
diff --git a/git-send-email.perl b/git-send-email.perl
index 07f2a0cbea..d532c08439 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
 # Copyright 2005 Ryan Anderson <ryan@michonline.com>
diff --git a/git-svn.perl b/git-svn.perl
index be987e316f..1ba835613b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 # Copyright (C) 2006, Eric Wong <normalperson@yhbt.net>
 # License: GPL v2 or later
 use 5.008;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e66eb3d9ba..943099a024 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 # gitweb - simple web interface to track changes in git repositories
 #
diff --git a/t/Git-SVN/Utils/can_compress.t b/t/Git-SVN/Utils/can_compress.t
index d7b49b8d54..0cdedb25bf 100755
--- a/t/Git-SVN/Utils/can_compress.t
+++ b/t/Git-SVN/Utils/can_compress.t
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
diff --git a/t/Git-SVN/Utils/fatal.t b/t/Git-SVN/Utils/fatal.t
index 49e1438295..75aaf1633d 100755
--- a/t/Git-SVN/Utils/fatal.t
+++ b/t/Git-SVN/Utils/fatal.t
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index dd8107cd7d..6fbec0162e 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 # Test t0000..t9999.sh for non portable shell scripts
 # This script can be called with one or more filenames as parameters
diff --git a/t/lib-gitweb.sh b/t/lib-gitweb.sh
index 1f32ca66ea..882c2e96f1 100644
--- a/t/lib-gitweb.sh
+++ b/t/lib-gitweb.sh
@@ -7,7 +7,7 @@
 gitweb_init () {
 	safe_pwd=3D"$(perl -MPOSIX=3Dgetcwd -e 'print quotemeta(getcwd)')"
 	cat >gitweb_config.perl <<EOF
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 # gitweb configuration for tests
=20
diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 575d2000cc..1791c7528a 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use lib '../../perl/build/lib';
 use strict;
diff --git a/t/perf/min_time.perl b/t/perf/min_time.perl
index c1a2717e07..2595eae616 100755
--- a/t/perf/min_time.perl
+++ b/t/perf/min_time.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 my $minrt =3D 1e100;
 my $min;
diff --git a/t/t0019/parse_json.perl b/t/t0019/parse_json.perl
index fea87fb81b..7e455dee3c 100644
--- a/t/t0019/parse_json.perl
+++ b/t/t0019/parse_json.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 use strict;
 use warnings;
 use JSON;
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
index 2cbf7b9590..d8e967bbcb 100755
--- a/t/t0202/test.pl
+++ b/t/t0202/test.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 use 5.008;
 use lib (split(/:/, $ENV{GITPERLLIB}));
 use strict;
diff --git a/t/t0210/scrub_normal.perl b/t/t0210/scrub_normal.perl
index 7cc4de392a..0c21a5438d 100644
--- a/t/t0210/scrub_normal.perl
+++ b/t/t0210/scrub_normal.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Scrub the variable fields from the normal trace2 output to
 # make testing easier.
diff --git a/t/t0211/scrub_perf.perl b/t/t0211/scrub_perf.perl
index 7a50bae646..5ebdd5fec5 100644
--- a/t/t0211/scrub_perf.perl
+++ b/t/t0211/scrub_perf.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Scrub the variable fields from the perf trace2 output to
 # make testing easier.
diff --git a/t/t0212/parse_events.perl b/t/t0212/parse_events.perl
index 30a9f51e9f..122a245c5d 100644
--- a/t/t0212/parse_events.perl
+++ b/t/t0212/parse_events.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Parse event stream and convert individual events into a summary
 # record for the process.
diff --git a/t/t4034/perl/post b/t/t4034/perl/post
index e8b72ef5dc..87500971d0 100644
--- a/t/t4034/perl/post
+++ b/t/t4034/perl/post
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
=20
diff --git a/t/t4034/perl/pre b/t/t4034/perl/pre
index f6610d37b8..5ab5aa42f3 100644
--- a/t/t4034/perl/pre
+++ b/t/t4034/perl/pre
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
=20
diff --git a/t/t7519/fsmonitor-all-v2 b/t/t7519/fsmonitor-all-v2
index 061907e88b..ef7c754afb 100755
--- a/t/t7519/fsmonitor-all-v2
+++ b/t/t7519/fsmonitor-all-v2
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index 264b9daf83..b22904964c 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
diff --git a/t/t7519/fsmonitor-watchman-v2 b/t/t7519/fsmonitor-watchman-v2
index 14ed0aa42d..013d349b15 100755
--- a/t/t7519/fsmonitor-watchman-v2
+++ b/t/t7519/fsmonitor-watchman-v2
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 6d753708d2..2785e177d2 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 use lib (split(/:/, $ENV{GITPERLLIB}));
=20
 use 5.008;
diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 1bcf01a9a4..1c29027aa7 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 use 5.008;
 use strict;
 use warnings;
diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--=
fsmonitor-watchman.sample
index 23e856f5de..367d46266c 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
--=20
2.40.0


--8A1ujGGfUxGaIsO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQtSQEACgkQVbJhu7ck
PpSvuxAAlQadxP8f3TlSILPHkcCgzi4+OrbYZiOPJbyAvKUA6y9d1PMP5CsNShSS
ZuxgkCLRUrvmTe4SMAAUl0vyuFW5JUzus8JcqYMuvRAZrput26glNpnWQ7gEScbZ
YTAymMaDl3o1rlDDKXSemjWmrLQvMgymHDoESNbntt93rrHI6seaYnAaMyZAnHJz
w2V15on5vbG99aLP8dKI6FbM4tkNQLnxn+dP+2dENCP5tYuGrD3pPuhcHUQKdJvG
Jfxp5BHH/TRYBTofYFpXlZL87vUtmDDV9M8YsOY6cI3FptuVviQAP40/ZEmxDIqR
rKEVMm7UXgS49/coCuNshDiiWdTF1EMKlbL/ho2O5VblXlo2xKtAfifn4ztFXp+5
zI6t6u06Dp/7HWoIylnxVksAka39T4JicG40Jmp2izs+RSQjm9VC0bPDZUWLCa9F
I2JnBxQ9DOp0BqTxYtvKas/EkNwWSk86M9Mj9UeWkTyklpH3xoAQhdsN2hb9w+yv
3KdSRyjdYE92zeaa0cXzNw6lATdKXC4RkWGyGxZLI0R2CplJf5axEw2OYulWQnG0
Kp1DyiDJ8EyoxU1D92GutR234MymZvyrCrPabkMR6WnCl0CI2H2oVGre3QqZJVDh
mhyl1fykZCxfUC7dF+8it6tejni4J+3YCQ2HOz+jVeJsbWavG0Q=
=WXPV
-----END PGP SIGNATURE-----

--8A1ujGGfUxGaIsO6--
