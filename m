From: Joe Perches <joe@perches.com>
Subject: [PATCH V3] git-send-email: Add auto-cc to all body signatures
Date: Wed, 02 Dec 2015 09:00:02 -0800
Message-ID: <1449075602.3716.27.camel@perches.com>
References: <b2937bc06d1bff456b84e51d6edee0bb1afc5f31.1311902983.git.joe@perches.com>
	 <1311903782.20837.42.camel@jtkirshe-mobl>
	 <1323313119.1762.58.camel@joe2Laptop>
	 <7v8vmmj1ng.fsf@alter.siamese.dyndns.org>
	 <1323377486.1762.71.camel@joe2Laptop> <87mvtti2ul.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jeffrey.t.kirsher@intel.com
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:08:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4AtQ-0000FU-VL
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 18:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725AbbLBRIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2015 12:08:31 -0500
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:52713 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756060AbbLBRI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2015 12:08:29 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2015 12:08:28 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave03.hostedemail.com (Postfix) with ESMTP id BF7872902B1
	for <git@vger.kernel.org>; Wed,  2 Dec 2015 17:00:06 +0000 (UTC)
Received: from filter.hostedemail.com (unknown [216.40.38.60])
	by smtprelay03.hostedemail.com (Postfix) with ESMTP id B0F386A932;
	Wed,  2 Dec 2015 17:00:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1431:1437:1515:1516:1518:1535:1544:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2687:2693:2828:3138:3139:3140:3141:3142:3355:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6119:6261:6299:7903:7974:9010:10004:10848:10946:11026:11232:11658:11783:11914:12043:12109:12517:12519:12555:13095:13138:13161:13229:13231:13894:14394:14659:21080:21221:30022:30054:30062:30064:30080:30083,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: way25_57eb2137f252d
X-Filterd-Recvd-Size: 5124
Received: from joe-X200MA.home (pool-173-51-221-2.lsanca.fios.verizon.net [173.51.221.2])
	(Authenticated sender: joe@perches.com)
	by omf05.hostedemail.com (Postfix) with ESMTPA;
	Wed,  2 Dec 2015 17:00:04 +0000 (UTC)
In-Reply-To: <87mvtti2ul.fsf@rasmusvillemoes.dk>
X-Mailer: Evolution 3.18.2-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281892>

Many types of signatures are used by various projects.

The most common type is formatted:
	"[some_signature_type]-by: First Last <email <at> domain.tld>"
e.g:
	"Reported-by: First Last <email <at> domain.tld>" (no quotes are used)

Make git-send-email use these signatures as "CC:" entries.

Add command line option --suppress-cc=3Dsignatures to avoid
adding these entries to the cc.

Signed-off-by: Joe Perches <joe <at> perches.com>
Acked-by: Jeff Kirsher <jeffrey.t.kirsher <at> intel.com>
---
> It's been four years, but I recently ran into this. I mistakenly thou=
ght
> that git would actually pick up cc addresses also from Reported-by, s=
o
> the reporter ended up not being cc'ed. Is there any chance this could=
 be
> revisited,

Here's a refresh if desired. =A0I still think it's sensible.

=A0Documentation/git-send-email.txt |=A0=A03 ++-
=A0git-send-email.perl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0| 11 ++=
++++-----
=A02 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index b9134d2..0866ae2 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -306,8 +306,9 @@ Automating
=A0=A0=A0patch body (commit message) except for self (use 'self' for th=
at).
=A0- 'sob' will avoid including anyone mentioned in Signed-off-by lines=
 except
=A0=A0=A0=A0for self (use 'self' for that).
+- 'signatures' will avoid including anyone mentioned in any "<foo>-by:=
" lines.
=A0- 'cccmd' will avoid running the --cc-cmd.
-- 'body' is equivalent to 'sob' + 'bodycc'
+- 'body' is equivalent to 'sob' + 'bodycc' + 'signatures'
=A0- 'all' will suppress all auto cc values.
=A0--
=A0+
diff --git a/git-send-email.perl b/git-send-email.perl
index e907e0ea..536e264 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -83,7 +83,7 @@ git send-email [options] <file | directory | rev-list=
 options >
=A0=A0=A0=A0=A0--identity=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0<str=
>=A0=A0* Use the sendemail.<id> options.
=A0=A0=A0=A0=A0--to-cmd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
<str>=A0=A0* Email To: via `<str> \$patch_path`
=A0=A0=A0=A0=A0--cc-cmd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
<str>=A0=A0* Email Cc: via `<str> \$patch_path`
-=A0=A0=A0=A0--suppress-cc=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0<str>=A0=A0*=
 author, self, sob, cc, cccmd, body, bodycc, all.
+=A0=A0=A0=A0--suppress-cc=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0<str>=A0=A0*=
 author, self, sob, cc, cccmd, body, bodycc, signatures, all.
=A0=A0=A0=A0=A0--[no-]cc-cover=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0* Email Cc: addresses in the cover letter.
=A0=A0=A0=A0=A0--[no-]to-cover=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0* Email To: addresses in the cover letter.
=A0=A0=A0=A0=A0--[no-]signed-off-by-cc=A0=A0=A0=A0=A0=A0=A0=A0* Send to=
 Signed-off-by: addresses. Default on.
@@ -421,13 +421,13 @@ my(%suppress_cc);
=A0if (@suppress_cc) {
=A0	foreach my $entry (@suppress_cc) {
=A0		die "Unknown --suppress-cc field: '$entry'\n"
-			unless $entry =3D~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc)$/=
;
+			unless $entry =3D~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc|si=
gnatures)$/;
=A0		$suppress_cc{$entry} =3D 1;
=A0	}
=A0}
=A0
=A0if ($suppress_cc{'all'}) {
-	foreach my $entry (qw (cccmd cc author self sob body bodycc)) {
+	foreach my $entry (qw (cccmd cc author self sob body bodycc signature=
s)) {
=A0		$suppress_cc{$entry} =3D 1;
=A0	}
=A0	delete $suppress_cc{'all'};
@@ -438,7 +438,7 @@ $suppress_cc{'self'} =3D $suppress_from if defined =
$suppress_from;
=A0$suppress_cc{'sob'} =3D !$signed_off_by_cc if defined $signed_off_by=
_cc;
=A0
=A0if ($suppress_cc{'body'}) {
-	foreach my $entry (qw (sob bodycc)) {
+	foreach my $entry (qw (sob bodycc signatures)) {
=A0		$suppress_cc{$entry} =3D 1;
=A0	}
=A0	delete $suppress_cc{'body'};
@@ -1516,7 +1516,7 @@ foreach my $t (@files) {
=A0	# Now parse the message body
=A0	while(<$fh>) {
=A0		$message .=3D=A0=A0$_;
-		if (/^(Signed-off-by|Cc): (.*)$/i) {
+		if (/^(Signed-off-by|Cc|[^\s]+[_-]by): (.*)$/i) {
=A0			chomp;
=A0			my ($what, $c) =3D ($1, $2);
=A0			chomp $c;
@@ -1526,6 +1526,7 @@ foreach my $t (@files) {
=A0			} else {
=A0				next if $suppress_cc{'sob'} and $what =3D~ /Signed-off-by/i;
=A0				next if $suppress_cc{'bodycc'} and $what =3D~ /Cc/i;
+				next if $suppress_cc{'signatures'} and $what =3D~ /by$/i;
=A0			}
=A0			push @cc, $c;
=A0			printf("(body) Adding cc: %s from line '%s'\n",
