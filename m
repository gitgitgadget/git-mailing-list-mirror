From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation: what does "git log --indexed-objects" even mean?
Date: Fri, 23 Jan 2015 11:49:05 -0800
Message-ID: <xmqqd265qnv2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Fri Jan 23 20:49:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEkEE-0006S7-Jg
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 20:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbbAWTtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 14:49:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751403AbbAWTtI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 14:49:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C02F930F73;
	Fri, 23 Jan 2015 14:49:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=5
	Uo1zEHX1DfwfDcp71C2DMpW28U=; b=a67/lAD3+DQx+S0wmlvkV0UvuGCJOB8kX
	t7qE9hv9O/0m6LfzjyYgt/7xIRsUB6otGfBABcSDl1QtdDnpN487W0U7bPZBB7id
	6xkIqImMhs0BmkzkBjy9Oid0KvPZelC0skePBixhLZUUkyldmsaORQUmqr3U3sTs
	vutyFmWhjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=wTF4Z+8ebSyJxjcQK0vaSwSyb8wzTHG3GQjyz7qMu9pg56G0Wjrg8EsK
	wAj8G2fdStgmh6sm5DQHIWHVDMacL1fhhMuyz4vua5FXZmBcDZIL9wQQvDZlV6DP
	I+CEag5PeBmoETeM/MpLGx0vlErMnrQ8ehmtO6kOkAfYyvSkmRc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A92DF30F72;
	Fri, 23 Jan 2015 14:49:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2321A30F71;
	Fri, 23 Jan 2015 14:49:07 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E44ABC52-A338-11E4-BEA0-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262951>

4fe10219 (rev-list: add --indexed-objects option, 2014-10-16) adds
"--indexed-objects" option to "rev-list", and it is only useful in
the context of "git rev-list" and not "git log".  There are other
object traversal options that do not make sense for "git log" that
are shown in the manual page.

Move the description of "--indexed-objects" to the object traversal
section so that it sits together with its friends "--objects",
"--objects-edge", etc. and then show them only in "git rev-list"
documentation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/rev-list-options.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2984f40..97ef2e8 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -172,11 +172,6 @@ explicitly.
 	Pretend as if all objects mentioned by reflogs are listed on the
 	command line as `<commit>`.
 
---indexed-objects::
-	Pretend as if all trees and blobs used by the index are listed
-	on the command line.  Note that you probably want to use
-	`--objects`, too.
-
 --ignore-missing::
 	Upon seeing an invalid object name in the input, pretend as if
 	the bad input was not given.
@@ -644,6 +639,7 @@ Object Traversal
 
 These options are mostly targeted for packing of Git repositories.
 
+ifdef::git-rev-list[]
 --objects::
 	Print the object IDs of any object referenced by the listed
 	commits.  `--objects foo ^bar` thus means ``send me
@@ -662,9 +658,15 @@ These options are mostly targeted for packing of Git repositories.
 	commits at the cost of increased time.  This is used instead of
 	`--objects-edge` to build ``thin'' packs for shallow repositories.
 
+--indexed-objects::
+	Pretend as if all trees and blobs used by the index are listed
+	on the command line.  Note that you probably want to use
+	`--objects`, too.
+
 --unpacked::
 	Only useful with `--objects`; print the object IDs that are not
 	in packs.
+endif::git-rev-list[]
 
 --no-walk[=(sorted|unsorted)]::
 	Only show the given commits, but do not traverse their ancestors.
