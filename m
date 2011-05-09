From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Git commit --patch (again)
Date: Mon, 09 May 2011 16:56:20 -0700
Message-ID: <7vsjsnmnrv.fsf@alter.siamese.dyndns.org>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
 <20110509144451.GA11362@sigill.intra.peff.net>
 <7vei47q0i6.fsf@alter.siamese.dyndns.org>
 <20110509220806.GC3719@sigill.intra.peff.net>
 <7vwrhzmnxf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: conrad.irwin@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 01:56:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJaJY-00074l-3g
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 01:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765Ab1EIX4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 19:56:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab1EIX4a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 19:56:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BE1415297;
	Mon,  9 May 2011 19:58:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PLBqs9aKnmqoU2D3GGN9k4melZE=; b=HqxBR5
	3rDkXbwRUf/iDfiLycD/jZrcxMJ6ZhELhT5yhuIUOmxc5IiDw7dNWwJqIGq+14lc
	IZz1HU/I03NK1u/0Hj7o5H8LC7qisutY+VQhW1JmaQ7q2d3jWKEwNyaQIyKdO+w3
	2M0Sd/KbheP3ahtU2kRAjuofgtS7uC5gnhfEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fK+TrXP8V8HKxG4d3Dp03aRDfWqxo6u1
	Aprkw7MA2cvtd7rjgzTGnbSg+t2tu5I2Eu2LjJ35lXoSSeOdrQcwj1Aestg9L9n3
	JgkwFfQCMVymlm83w6ZtIMFWtxTbUEDhlrGnNEZgHeSWWzbCoHi9Bq11DEZggYCp
	LQTPhwThW7k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E560E5292;
	Mon,  9 May 2011 19:58:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BC2CD5290; Mon,  9 May 2011
 19:58:27 -0400 (EDT)
In-Reply-To: <7vwrhzmnxf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 09 May 2011 16:53:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E31DC46-7A98-11E0-8343-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173294>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> It's unfortunately not quite as simple as having that test succeed, as
>> it changes state that breaks later tests. I didn't investigate deeply,
>> though.
>
> Yeah, that test that hardcodes the exact commit sequence is disgusting.
> In the meantime...
>
> -- >8 --
> From: Jeff King <peff@peff.net>
> Subject: [PATCH] t7501.8: feed a meaningful command

And then on top of that, Conrad's "allow commit --interactive <path>"
would come, with this squashed in.  The last "reset HEAD^" is nasty but I
don't have enough energy to fix 12ace0b (Add test case for basic commit
functionality., 2007-07-31) today.

 t/t7501-commit.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 3d2b14d..c2fd116 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -41,11 +41,12 @@ test_expect_success \
 	"echo King of the bongo >file &&
 	test_must_fail git commit -m foo -a file"
 
-test_expect_success PERL 'cannot use paths with --interactive' '
+test_expect_success PERL 'can use paths with --interactive' '
 	echo bong-o-bong >file &&
 	# 2: update, 1:st path, that is all, 7: quit
 	( echo 2; echo 1; echo; echo 7 ) |
-	test_must_fail git commit -m foo --interactive file
+	git commit -m foo --interactive file &&
+	git reset --hard HEAD^
 '
 
 test_expect_success \
