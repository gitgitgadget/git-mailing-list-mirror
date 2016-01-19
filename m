From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place editing
Date: Tue, 19 Jan 2016 14:09:37 -0800
Message-ID: <xmqqvb6p8bmm.fsf@gitster.mtv.corp.google.com>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
	<1452790676-11937-3-git-send-email-tklauser@distanz.ch>
	<xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRRdca7PfkqppY2X7KSFpHX0yH19fxRL+w_=u9vg7NV9A@mail.gmail.com>
	<xmqqio2pbgov.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRi2knygjeaMtojAr65BE71B-z7q+s8V5rcGrV9Qja6jw@mail.gmail.com>
	<CAPig+cRozqCKdC2+nyG-UM6xFo_sSqa7OhGgcycyyDQujZHtHA@mail.gmail.com>
	<xmqqfuxt9ti3.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRHTs9q4k=CqtY2j=ZtTYMU6_SPeCHkQe4m5AGXOjg_Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tobias Klauser <tklauser@distanz.ch>,
	Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 23:10:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLeTO-0008Mx-QR
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 23:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933331AbcASWJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 17:09:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933313AbcASWJk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 17:09:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 57AD93D832;
	Tue, 19 Jan 2016 17:09:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6o+8uG9JEJSY86VPFq+TLK1Z3R4=; b=JQ7K/q
	coxqgrT6DE+ZrmNORUmPO/wqp5wZ/zOehIWZS52mD7Lsx2f6UPk/152rBalPYbZ6
	58izahztC6gtHgm/Gns+gWZiLJ7uOTfeOOHXcOoAFo8eG6UiLKvXXdbF2Zr8945L
	2bjwWeWrb2b+piidb48Hkx3ZrcCyZZ6K82aGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wIOhSkOf46oIeJbl96mtoUzKo3cN9x8B
	kKSU4EqezY4kebFUr89A9dm8wndHChuH/K9RtllayH/9CMv8l8f79bSnVbfgB0GG
	awg0MQ+nxE1OtqG7HkQE1o+cGQV7m77Xqu7JaUNoJdD9XG1GkUnCE4VBefEHgDNA
	xmvD74jQNS0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4FFF93D831;
	Tue, 19 Jan 2016 17:09:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C41F43D830;
	Tue, 19 Jan 2016 17:09:38 -0500 (EST)
In-Reply-To: <CAPig+cRHTs9q4k=CqtY2j=ZtTYMU6_SPeCHkQe4m5AGXOjg_Ww@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 19 Jan 2016 16:45:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 551473EC-BEF9-11E5-B4E1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284387>

Eric Sunshine <sunshine@sunshineco.com> writes:

> You suspect correctly. It was exactly the comment added by f400e51c
> that misled me. (t/README does, on the other hand, mention "root", as
> I noticed after reading your previous response.)
>
> Thanks for spelling all this out. Hopefully, others reading your reply
> (now and later) will be less confused than I.

It is not too late to fix that, though.

-- >8 --
Subject: test-lib: clarify and tighten SANITY

f400e51c (test-lib.sh: set prerequisite SANITY by testing what we
really need, 2015-01-27) improved the way SANITY prerequisite was
determined, but made the resulting code (incorrectly) imply that
SANITY is all about effects of permission bits of the containing
directory has on the files contained in it by the comment it added,
its log message and the actual tests.

By the way, while we are on the subject, POSIXPERM is more about "if
we do chmod, does filesystem remember it so that ls -l reports the
same?"  Output from "git grep POSIXPERM t" shows that some users of
it also assume that it requires "we can make something executable by
doing chmod +x and unexecutable by doing chmod -x" (and that is
fine--running tests as root would not make an unexecutable file
executable).  The tests that require POSIXPERM but not SANITY can be
run by root (I am not saying that running tests as root is safe or
sane, though) and are expected to produce the same result as they
were run by a non-root user.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 446d8d5..68c31ae 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -997,20 +997,28 @@ test_lazy_prereq NOT_ROOT '
 	test "$uid" != 0
 '
 
-# On a filesystem that lacks SANITY, a file can be deleted even if
-# the containing directory doesn't have write permissions, or a file
-# can be accessed even if the containing directory doesn't have read
-# or execute permissions, causing our tests that validate that Git
-# works sensibly in such situations.
+# SANITY is about "can you correctly predict what the filesystem would
+# do by only looking at the permission bits of the files and
+# directories?"  A typical example of !SANITY is running the test
+# suite as root, where a test may expect "chmod -r file && cat file"
+# to fail because file is supposed to be unreadable after a successful
+# chmod.  In an environment (i.e. combination of what filesystem is
+# being used and who is running the tests) that lacks SANITY, you may
+# be able to delete or create a file when the containing directory
+# doesn't have write permissions, or access a file even if the
+# containing directory doesn't have read or execute permissions.
+
 test_lazy_prereq SANITY '
 	mkdir SANETESTD.1 SANETESTD.2 &&
 
 	chmod +w SANETESTD.1 SANETESTD.2 &&
 	>SANETESTD.1/x 2>SANETESTD.2/x &&
 	chmod -w SANETESTD.1 &&
+	chmod -r SANETESTD.1/x &&
 	chmod -rx SANETESTD.2 ||
 	error "bug in test sript: cannot prepare SANETESTD"
 
+	! test -r SANETESTD.1/x &&
 	! rm SANETESTD.1/x && ! test -f SANETESTD.2/x
 	status=$?
 
