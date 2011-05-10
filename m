From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 9/9] t3703, t4208: add test cases for magic pathspec
Date: Mon,  9 May 2011 22:51:18 -0700
Message-ID: <1305006678-4051-10-git-send-email-gitster@pobox.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:52:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJfrX-0001Nk-3q
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 07:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab1EJFvy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 01:51:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab1EJFvx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 01:51:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B3A45CAD;
	Tue, 10 May 2011 01:53:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FZquB9IGqN2y
	j7bzuMjslRXbXgA=; b=jL3UjhBXwKPzgtYNVDI8hUDXoKTqElZbNHsW0pBDxBLj
	hgbNaYmC6dx+PFm0gxnHCgNjrYZyjkiCgBJ8jD9e8daEF5jZeF1TDjOxu19Zt1FN
	fRsyMdV5HHYTkOz0gjGw48iO8ol55QA75DFxMqLXMS6HjlTB86Ss1rt2+54HciI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DE5GVK
	tIWeE6MhyN7sPAmjl9tTHsk7k7DtOea7+5EKPBHIp+3CN8zE0VkjXjNAh9Lm153+
	fWaJBpiFtlgUnXOYgpnpr625Id8tq2RQUuoUnuPl5NvU7dAIKVn3YbOJqDt/jSiz
	CVnCA6HqvhH/vuJ9Cr8pRlhJeTctcs3Sf1Ay0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87E615CAC;
	Tue, 10 May 2011 01:53:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 77B5C5CAB; Tue, 10 May 2011
 01:53:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.290.g1b565
In-Reply-To: <1305006678-4051-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E546B1C4-7AC9-11E0-A73E-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173313>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

While at it, also document ":" syntax.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/glossary-content.txt |    3 +
 t/t3703-add-magic-pathspec.sh      |   78 ++++++++++++++++++++++++++++=
++++++++
 t/t4208-log-magic-pathspec.sh      |   45 +++++++++++++++++++++
 3 files changed, 126 insertions(+), 0 deletions(-)
 create mode 100755 t/t3703-add-magic-pathspec.sh
 create mode 100755 t/t4208-log-magic-pathspec.sh

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index 0ca029b..0318024 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -327,6 +327,9 @@ icase;;
 +
 It is envisioned that we will support more types of magic in later
 versions of git.
++
+A pathspec with only a colon means "there is no pathspec". This form
+should not be combined with other pathspec.
=20
 [[def_parent]]parent::
 	A <<def_commit_object,commit object>> contains a (possibly empty) lis=
t
diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathspec=
=2Esh
new file mode 100755
index 0000000..9e6708a
--- /dev/null
+++ b/t/t3703-add-magic-pathspec.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description=3D'magic pathspec tests using git-add'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir sub anothersub &&
+	: >sub/foo &&
+	: >anothersub/foo
+'
+
+test_expect_success 'colon alone magic should only used alone' '
+	test_must_fail git add -n sub/foo : &&
+	test_must_fail git add -n : sub/foo
+'
+
+test_expect_success 'add :' '
+	: >expected &&
+	(cd sub && git add -n : >actual) &&
+	test_cmp expected sub/actual
+'
+
+test_expect_success 'add :/' "
+	cat >expected <<-EOF &&
+	add 'anothersub/foo'
+	add 'expected'
+	add 'sub/actual'
+	add 'sub/foo'
+	EOF
+	(cd sub && git add -n :/ >actual) &&
+	test_cmp expected sub/actual
+"
+
+cat >expected <<EOF
+add 'anothersub/foo'
+EOF
+
+test_expect_success 'add :/anothersub' '
+	(cd sub && git add -n :/anothersub >actual) &&
+	test_cmp expected sub/actual
+'
+
+test_expect_success 'add :/non-existent' '
+	(cd sub && test_must_fail git add -n :/non-existent)
+'
+
+cat >expected <<EOF
+add 'sub/foo'
+EOF
+
+test_expect_success 'add :(icase)foo' '
+	(cd sub && git add -n ":(icase)FoO" >actual) &&
+	test_cmp expected sub/actual
+'
+
+test_expect_success 'a file with the same (long) magic name exists' '
+	: >":(icase)ha" &&
+	test_must_fail git add -n ":(icase)ha" 2>error &&
+	git add -n "./:(icase)ha"
+'
+
+cat >expected <<EOF
+fatal: pathspec ':(icase)ha' did not match any files
+EOF
+
+test_expect_failure 'show pathspecs exactly what are typed in' '
+	test_cmp expected error
+'
+
+test_expect_success 'a file with the same (short) magic name exists' '
+	mkdir ":" &&
+	: >":/bar" &&
+	test_must_fail git add -n :/bar &&
+	git add -n "./:/bar"
+'
+
+test_done
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec=
=2Esh
new file mode 100755
index 0000000..ff7f485
--- /dev/null
+++ b/t/t4208-log-magic-pathspec.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description=3D'magic pathspec tests using git-log'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit initial &&
+	test_tick &&
+	git commit --allow-empty -m empty &&
+	mkdir sub
+'
+
+test_expect_failure '"git log :/" should be ambiguous' '
+	test_must_fail git log :/ 2>error &&
+	grep ambiguous error
+'
+
+test_expect_failure '"git log :" should be ambiguous' '
+	test_must_fail git log : 2>error &&
+	grep ambiguous error
+'
+
+test_expect_success 'git log -- :' '
+	git log -- :
+'
+
+test_expect_success 'git log HEAD -- :/' '
+	cat >expected <<-EOF &&
+	24b24cf initial
+	EOF
+	(cd sub && git log --oneline HEAD -- :/ >../actual) &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git log HEAD -- :' '
+	cat >expected <<-EOF &&
+	41d179c empty
+	24b24cf initial
+	EOF
+	(cd sub && git log --oneline HEAD -- : >../actual) &&
+	test_cmp expected actual
+'
+
+test_done
--=20
1.7.5.1.290.g1b565
