From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git_mkstemps: improve test suite test
Date: Mon, 05 Aug 2013 10:32:19 -0700
Message-ID: <7vfvuokpr0.fsf@alter.siamese.dyndns.org>
References: <201308030027.r730RNWS022924@freeze.ariadne.com>
	<7vr4e8m7ky.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Mon Aug 05 19:32:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Oe8-0005wV-AN
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 19:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab3HERcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 13:32:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35738 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab3HERce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 13:32:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D52D1368AA;
	Mon,  5 Aug 2013 17:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L0RlvhSFWN4mnwjMYJ7myxsptjo=; b=LhwLms
	fgSLA8V+kUEKubtMYD/3rCUCwsCMA3CTRm+A82TnTFyOeTN7KYboC5MIAPbEjIe+
	gdD5ZCNvnBiW8PqNwRqUhLCV2hyG0MwkRqlf3C/24OE9aalqH1lqK1iGS9+rYbH7
	9L9UxamHOHXOaoHqUWgQxspofu6n8wbzP0GTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C4rXdnIxUkHR48Qh6PDRXx3a4TXR85X0
	Pw5Dxetv5NpPfaGaP5klS5H9KcJ7Kd11/PBt72yzm0nfa329rkZXL1trZSh6csr+
	/vlN0UiqV3yqM8sWVRxYLoqVYcoRJ2mxwOOGxqTG0TPI7j6qWhX1ljbIn33ci2lS
	fbvAiCfBUc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C92A8368A9;
	Mon,  5 Aug 2013 17:32:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B87D368A6;
	Mon,  5 Aug 2013 17:32:22 +0000 (UTC)
In-Reply-To: <7vr4e8m7ky.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 05 Aug 2013 09:21:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC602F6A-FDF4-11E2-A2AB-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231680>

Junio C Hamano <gitster@pobox.com> writes:

> worley@alum.mit.edu (Dale R. Worley) writes:
>
>> Commit 52749 fixes a bug regarding testing the return of an open()
>> call for success/failure.  Improve the testsuite test for that fix by
>> removing the helper program 'test-close-fd-0' and replacing it with
>> the shell redirection '<&-'.  (The redirection is Posix, so it should
>> be portable.)
>>
>> Signed-off-by: Dale Worley <worley@ariadne.com>
>> ---
>
> Sorry, but I have no idea what commit you are talking about, and as
> far as I can see there is no such file test-close-fd-0.c in my tree.
>
> Puzzled...

OK, let's do this on top of a77f106c (run-command: dup_devnull():
guard against syscalls failing, 2013-07-12) which is at the tip of
tr/fd-gotcha-fixes that contains the earlier fix.

-- >8 --
From: "Dale R. Worley" <worley@alum.mit.edu>
Date: Fri, 2 Aug 2013 20:27:23 -0400
Subject: [PATCH] t0070: test that git_mkstemps correctly checks return value of open()

Signed-off-by: Dale R. Worley <worley@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0070-fundamental.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index da2c504..ff3776f 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -25,6 +25,10 @@ test_expect_success POSIXPERM 'mktemp to unwritable directory prints filename' '
 	grep "cannotwrite/test" err
 '
 
+test_expect_success 'git_mkstemps_mode does not fail if fd 0 is not open' '
+	git commit --allow-empty -m message <&-
+'
+
 test_expect_success 'check for a bug in the regex routines' '
 	# if this test fails, re-build git with NO_REGEX=1
 	test-regex
-- 
1.8.4-rc1-129-g1f3472b
