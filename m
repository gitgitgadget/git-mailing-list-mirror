From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: unpack-trees: avoid substituting only a verb in sentences
Date: Thu, 12 May 2016 16:28:34 -0700
Message-ID: <xmqqoa8ac0v1.fsf@gitster.mtv.corp.google.com>
References: <xmqqy47ec2n2.fsf@gitster.mtv.corp.google.com>
	<1463094986-7344-1-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 13 01:28:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1026-0001TR-IZ
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 01:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbcELX2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 19:28:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752208AbcELX2i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 19:28:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3A661B748;
	Thu, 12 May 2016 19:28:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yCVdFH9VZgmJknOCqJZq/NsgUAQ=; b=RgrjdT
	ubcck1loEdX5s2TzQ/HxSKOXxFuWnYhsEECUzOq0zBxVZWUsHIsCatWxkb2F0DFS
	RF3A/RQ5HOT32+WgZJMZYosOn07fs9HxzJEwn33+teNwZqk8haWF2WfIpL2UUoYy
	5jrN/JDPzDv/Ik355O+CgWPkDcaz4NgNVu3Yo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vzWSEIGARDfow7a/LDV3XPWUqa/y+Arx
	mUnMZvBcTEg7Kg7u0lpIA5ZAe8nVzzXNmXRafWRmjE09aiWu4OQ4iswHiXf/xdBL
	JjQw1tlFA8iOdeSk4o/tAAtPrwIq11KcCppiIl6yANWQk4xkMIw++FqutZyhzEBm
	PzJmTFWAjoM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A7CF1B747;
	Thu, 12 May 2016 19:28:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F5CF1B745;
	Thu, 12 May 2016 19:28:35 -0400 (EDT)
In-Reply-To: <1463094986-7344-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Thu, 12 May 2016 23:16:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3FCB88E6-1899-11E6-BFAF-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294490>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Instead of reusing the same set of message templates for checkout
> and other actions and substituting the verb with "%s", prepare
> separate message templates for each known action. That would make
> it easier for translation into languages where the same verb may
> conjugate differently depending on the message we are giving.
>
> See gettext documentation for details:
> http://www.gnu.org/software/gettext/manual/html_node/Preparing-Strings.html
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>
> I removed "Please," in favor of "Please" as Junio C Hamano sugested.

Thanks.  I think we should squash the following in, as all these
messages are now i18ned and without being marked with test_i18ncmp,
GETTEXT_POISON build would fail to pass these tests.

 t/t7609-merge-co-error-msgs.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-msgs.sh
index 0e4a682..6729cb3 100755
--- a/t/t7609-merge-co-error-msgs.sh
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -37,14 +37,14 @@ EOF
 
 test_expect_success 'untracked files overwritten by merge (fast and non-fast forward)' '
 	test_must_fail git merge branch 2>out &&
-	test_cmp out expect &&
+	test_i18ncmp out expect &&
 	git commit --allow-empty -m empty &&
 	(
 		GIT_MERGE_VERBOSITY=0 &&
 		export GIT_MERGE_VERBOSITY &&
 		test_must_fail git merge branch 2>out2
 	) &&
-	test_cmp out2 expect &&
+	test_i18ncmp out2 expect &&
 	git reset --hard HEAD^
 '
 
@@ -53,7 +53,7 @@ error: Your local changes to the following files would be overwritten by merge:
 	four
 	three
 	two
-Please, commit your changes or stash them before you can merge.
+Please commit your changes or stash them before you can merge.
 error: The following untracked working tree files would be overwritten by merge:
 	five
 Please move or remove them before you can merge.
@@ -65,14 +65,14 @@ test_expect_success 'untracked files or local changes ovewritten by merge' '
 	git add three &&
 	git add four &&
 	test_must_fail git merge branch 2>out &&
-	test_cmp out expect
+	test_i18ncmp out expect
 '
 
 cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by checkout:
 	rep/one
 	rep/two
-Please, commit your changes or stash them before you can switch branches.
+Please commit your changes or stash them before you can switch branches.
 Aborting
 EOF
 
@@ -87,21 +87,21 @@ test_expect_success 'cannot switch branches because of local changes' '
 	echo uno >rep/one &&
 	echo dos >rep/two &&
 	test_must_fail git checkout branch 2>out &&
-	test_cmp out expect
+	test_i18ncmp out expect
 '
 
 cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by checkout:
 	rep/one
 	rep/two
-Please, commit your changes or stash them before you can switch branches.
+Please commit your changes or stash them before you can switch branches.
 Aborting
 EOF
 
 test_expect_success 'not uptodate file porcelain checkout error' '
 	git add rep/one rep/two &&
 	test_must_fail git checkout branch 2>out &&
-	test_cmp out expect
+	test_i18ncmp out expect
 '
 
 cat >expect <<\EOF
@@ -132,7 +132,7 @@ test_expect_success 'not_uptodate_dir porcelain checkout error' '
 	>rep/untracked-file &&
 	>rep2/untracked-file &&
 	test_must_fail git checkout branch 2>out &&
-	test_cmp out ../expect
+	test_i18ncmp out ../expect
 '
 
 test_done
