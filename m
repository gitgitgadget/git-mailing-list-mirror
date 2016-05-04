From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 04 May 2016 14:34:23 -0700
Message-ID: <xmqq4madfqxs.fsf@gitster.mtv.corp.google.com>
References: <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
	<1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
	<F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
	<5729DF25.7030503@ramsayjones.plus.com>
	<xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
	<xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
	<20160504192516.GD21259@sigill.intra.peff.net>
	<xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
	<20160504200635.GA22787@sigill.intra.peff.net>
	<xmqq8tzpfrt0.fsf@gitster.mtv.corp.google.com>
	<20160504213149.GA22828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 23:34:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4RD-0006db-7o
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbcEDVe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:34:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752124AbcEDVe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:34:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B199718523;
	Wed,  4 May 2016 17:34:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IlkbIA6W/2ZYeE2xarVeZMLvNuA=; b=TthvRa
	CR3tY2jSPMwBlxMD/OQnhjyqVGXErwTHsKoD5mxo2JIoEPdZb4yBAQrVGmY9qxa2
	jq+XfSHbFBg8N/2fFuZPFqVha65ADa4/M47NDhDcas4PjUuW3+AkR3KYv+QlBszg
	PgTAOpd3XhIiH6NCWVLiT6q8jaktNkXOvm8SI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RLTtuNu5gPqorRQBOtbRNSLSBWokrffZ
	YHMO3a7f1jbmcy+i2+lqYB7L5iXHqLw2RAdy/lkG46iZsA9umDhW0iQ23M2RqvEE
	5i63JkXXg0y9BPYlQCVYbsWiTM+e7mjjXshJ3Y1+nh8+xaiRu2i2vfAHZyFGVbrC
	wMvP0gjC85w=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AAC7718522;
	Wed,  4 May 2016 17:34:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34E6D18521;
	Wed,  4 May 2016 17:34:25 -0400 (EDT)
In-Reply-To: <20160504213149.GA22828@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 May 2016 17:31:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F9114D5A-123F-11E6-B162-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293597>

Third time's a charm, perhaps?
 
-- >8 --
Subject: [PATCH] ci: validate "gitlink:" in documentation

It is easy to add incorrect "linkgit:<page>[<section>]" references
to our documentation suite.  Catch these common classes of errors:

 * Referring to Documentation/<page>.txt that does not exist.

 * Referring to a <page> outside the Git suite.  In general, <page>
   must begin with "git".

 * Listing the manual <section> incorrectly.  The first line of the
   Documentation/<page>.txt must end with "(<section>)".

with a new script "ci/lint-gitlink", and drive it from "make check-docs".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/Makefile |  5 +++++
 Makefile               |  1 +
 ci/lint-gitlink        | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100755 ci/lint-gitlink

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3e39e28..e9cd43d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -204,6 +204,7 @@ ifndef V
 	QUIET_DBLATEX	= @echo '   ' DBLATEX $@;
 	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
 	QUIET_GEN	= @echo '   ' GEN $@;
+	QUIET_LINT	= @echo '   ' LINT $@;
 	QUIET_STDERR	= 2> /dev/null
 	QUIET_SUBDIR0	= +@subdir=
 	QUIET_SUBDIR1	= ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
@@ -427,4 +428,8 @@ quick-install-html: require-htmlrepo
 print-man1:
 	@for i in $(MAN1_TXT); do echo $$i; done
 
+lint-docs::
+	$(QUIET_LINT)$(foreach txt,$(patsubst %.html,%.txt,$(DOC_HTML)), \
+	../ci/lint-gitlink $(txt))
+
 .PHONY: FORCE
diff --git a/Makefile b/Makefile
index 2742a69..61bd0ab 100644
--- a/Makefile
+++ b/Makefile
@@ -2496,6 +2496,7 @@ ALL_COMMANDS += git-gui git-citool
 
 .PHONY: check-docs
 check-docs::
+	$(MAKE) -C Documentation lint-docs
 	@(for v in $(ALL_COMMANDS); \
 	do \
 		case "$$v" in \
diff --git a/ci/lint-gitlink b/ci/lint-gitlink
new file mode 100755
index 0000000..6b6bf91
--- /dev/null
+++ b/ci/lint-gitlink
@@ -0,0 +1,56 @@
+#!/usr/bin/perl
+
+my $found_errors = 0;
+
+sub report {
+	my ($where, $what, $error) = @_;
+	print "$where: $error: $what\n";
+	$found_errors = 1;
+}
+
+sub grab_section {
+	my ($page) = @_;
+	open my $fh, "<", "$page.txt";
+	my $firstline = <$fh>;
+	chomp $firstline;
+	close $fh;
+	my ($section) = ($firstline =~ /.*\((\d)\)$/);
+	return $section;
+}
+
+sub lint {
+	my ($file) = @_;
+	open my $fh, "<", $file
+		or return;
+	while (<$fh>) {
+		my $where = "$file:$.";
+		while (s/linkgit:((.*?)\[(\d)\])//) {
+			my ($target, $page, $section) = ($1, $2, $3);
+
+			# De-AsciiDoc
+			$page =~ s/{litdd}/--/g;
+
+			if ($page !~ /^git/) {
+				report($where, $target, "nongit link");
+				next;
+			}
+			if (! -f "$page.txt") {
+				report($where, $target, "no such source");
+				next;
+			}
+			$real_section = grab_section($page);
+			if ($real_section != $section) {
+				report($where, $target,
+					"wrong section (should be $real_section)");
+				next;
+			}
+		}
+	}
+	close $fh;
+}
+
+for (@ARGV) {
+	lint($_);
+}
+
+exit $found_errors;
-- 
2.8.2-498-g6350fe8
