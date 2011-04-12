From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/7] i18n: mark init-db messages for translation
Date: Tue, 12 Apr 2011 16:04:56 -0700
Message-ID: <7v1v17nk9z.fsf@alter.siamese.dyndns.org>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
 <1302464048-21806-2-git-send-email-avarab@gmail.com>
 <7v39lorli9.fsf@alter.siamese.dyndns.org>
 <7vy63gq6s2.fsf@alter.siamese.dyndns.org>
 <BANLkTincUmH7SjypXfDMXDfg8BxW4MW+Jg@mail.gmail.com>
 <7vsjtnpc0k.fsf@alter.siamese.dyndns.org>
 <7v62qjnkpe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9me3-0002wx-D5
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 01:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab1DLXFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 19:05:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab1DLXFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 19:05:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6426A5941;
	Tue, 12 Apr 2011 19:07:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JvK+3NGCyIeCG6YgHcbllSXRNM0=; b=cvaMwG
	oecgxWkk8SSMl7QsI7/+dL3GBJW+m6x1K5VIOxWAQ0XkNCdprfLCv/mJLR7sUUjC
	jDrEE8C55uOrqNBHYeTpWboVexQJjxALqJS4QU5HGMCNBCJahaHTt1Rk83RGxxcD
	01GoMm2SotGXxfA2UE7R43hW/5x1GtjH6rMHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GJZoztdJgcVHzWu2ERYwtDxZY7ORtOrm
	G0FoieMSSuaYC5byx/xZ1vkmL/st1+d1RL1n9bganT4o74ZlZgvReGoK1kXGdPC5
	/wihJ+uH+aJITz4xyqNSTvrMpU5AsYPR6DIE9NalPiGHV1R1Iq4JER4qivxUtBXE
	VH876v8VV/0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3AE30593F;
	Tue, 12 Apr 2011 19:06:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 211935939; Tue, 12 Apr 2011
 19:06:55 -0400 (EDT)
In-Reply-To: <7v62qjnkpe.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 12 Apr 2011 15:55:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91AB2F16-6559-11E0-B004-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171426>

Junio C Hamano <gitster@pobox.com> writes:

> +# Use this instead of "grep expected-string actual" to see if the
> +# output from a git command that acn be translated contains an
> +# expected string.  When running under GETTEXT_POISON this pretends
> +# that the command produced expected results.
> +test_i18ngrep () {
> +	test -n "$GETTEXT_POISON" || grep "$@"
> +}
> +

I spoke too early.

The common pattern is either to ensure that the actual output has an
expected string, of to ensure that the actual output does not have an
unwanted string.  So this has to be something like:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3e7c2bb..874bcc5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1085,6 +1085,23 @@ test_i18ncmp () {
 	test -n "$GETTEXT_POISON" || test_cmp "$@"
 }
 
+# Use this instead of "grep expected-string actual" to see if the
+# output from a git command that can be translated contains (or does
+# not contain) an expected string.  When running under GETTEXT_POISON
+# this pretends that the command produced expected results.
+test_i18ngrep () {
+	if test -n "$GETTEXT_POISON"
+	then
+	    : # pretend success
+	elif test "x!" = "x$1"
+	then
+	    	shift
+		! grep "$@"
+	else
+	    	grep "$@"
+	fi
+}
+
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
 rm -f y
diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
index cc34e55..30c2225 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -29,9 +29,9 @@ test_expect_success 'checkout chooses branch over tag' '
 	test_cmp expect file
 '
 
-test_expect_success C_LOCALE_OUTPUT 'checkout reports switch to branch' '
-	grep "Switched to branch" stderr &&
-	! grep "^HEAD is now at" stderr
+test_expect_success 'checkout reports switch to branch' '
+	test_i18ngrep "Switched to branch" stderr &&
+	test_i18ngrep ! "^HEAD is now at" stderr
 '
 
 test_expect_success 'checkout vague ref succeeds' '
