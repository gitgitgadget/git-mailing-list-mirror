From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] add a Makefile switch to avoid gettext translation in
 shell scripts
Date: Mon, 23 Jan 2012 14:04:29 -0800
Message-ID: <7vr4yq6poy.fsf_-_@alter.siamese.dyndns.org>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
 <20120119195222.GA5011@blimp.dmz> <7v1uqq84es.fsf@alter.siamese.dyndns.org>
 <7vwr8i6prk.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 23 23:04:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpS0C-00079z-QB
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 23:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769Ab2AWWEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 17:04:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303Ab2AWWEc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 17:04:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D9E0778A;
	Mon, 23 Jan 2012 17:04:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gl44jT15uOTJN+8kNb1yJ13i5+0=; b=bLetc4
	PKPaWxYGoOcGHnXlIcdsXlZfwNrxziYcSE8SsPkFmC72eWPZHZ3qbg6ht/QISvUV
	guz8WdDjDEafyLpng3xWLFvEZL+9w35ZMnY1KKwAdNWH4s6txprpHH4JNQcZMM1G
	j/XIV7sLUM/ihaQ4sCg8i1sHRMWOZR/pWIRYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HDAs0Fm7B33uKXB6SclGp+zMoePQOYqq
	+D4UGsJg6+oLhQmKxWOAnFMAgPwBArpDXAOwGq4vIyAdJUkemYky6IfP6x0rkzxx
	GjMv+I8hMQf9bldUA/ZU5NCVaiiq4gK8HkwJNge7xEeIxS5S+4kF8zQEsvxgSwoB
	S/KQl+Kj3Wo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64C0B7789;
	Mon, 23 Jan 2012 17:04:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E65E27788; Mon, 23 Jan 2012
 17:04:30 -0500 (EST)
In-Reply-To: <7vwr8i6prk.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 23 Jan 2012 14:02:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39B5E116-460E-11E1-94A7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189016>

From: Alex Riesen <raa.lkml@gmail.com>

Some systems have gettext.sh (GNU gettext) installed, but it is either
broken or misconfigured in such a way so its output is not usable.  In
case the users of these systems are unable or not interested in fixing
them, setting the new Makefile switch should help:

    make USE_GETTEXT_SCHEME=fallthrough

This will replace the translation routines with fallthrough versions,
that does not use gettext from the platform.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile       |    4 ++++
 git-sh-i18n.sh |    5 ++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 9470a10..4435854 100644
--- a/Makefile
+++ b/Makefile
@@ -47,6 +47,9 @@ all::
 # A translated Git requires GNU libintl or another gettext implementation,
 # plus libintl-perl at runtime.
 #
+# Define USE_GETTEXT_SCHEME and set it to 'fallthrough', if you don't trust
+# the installed gettext translation of the shell scripts output.
+#
 # Define HAVE_LIBCHARSET_H if you haven't set NO_GETTEXT and you can't
 # trust the langinfo.h's nl_langinfo(CODESET) function to return the
 # current character set. GNU and Solaris have a nl_langinfo(CODESET),
@@ -1874,6 +1877,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
     -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+    -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
     -e $(BROKEN_PATH_FIX) \
     $@.sh >$@+
 endef
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 6648bd3..d5fae99 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -18,7 +18,10 @@ export TEXTDOMAINDIR
 
 # First decide what scheme to use...
 GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
-if test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
+if test -n "@@USE_GETTEXT_SCHEME@@"
+then
+	GIT_INTERNAL_GETTEXT_SH_SCHEME="@@USE_GETTEXT_SCHEME@@"
+elif test -n "@@USE_FALLTHROUGH_GETTEXT_SCHEME@@$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
 then
 	: no probing necessary
 elif test -n "$GIT_GETTEXT_POISON"
-- 
1.7.9.rc2.48.g92994
