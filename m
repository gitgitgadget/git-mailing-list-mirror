From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failures in t4034
Date: Sat, 18 Aug 2012 23:12:23 -0700
Message-ID: <7v7gsvquk8.fsf@alter.siamese.dyndns.org>
References: <80B6C6EE-130C-48C3-BBBB-5FCD1E7EFDEF@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 08:13:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2yl8-0005zq-K8
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 08:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668Ab2HSGM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 02:12:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab2HSGM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 02:12:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85C2295F4;
	Sun, 19 Aug 2012 02:12:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1kRinb0p9rkbRpiLjkR/shj4eFg=; b=mg4YDl
	ZWw4ceTaA8MjfTRdU7pmQFX7WUGsh4yBLDXqpRfmhWW2ojr5mOWrGLOod2/mRv+3
	+8W5qvOsFAfXs/rINEWDeVTjzM/ZkjbIg2lLnyrDOwMMu57v2fiWGj1xjJvJ4eoW
	g6vQ8IlKtHHjVFFvOct9vqlc1oUYn2DPNSMfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wGJvC/Gu9TMivauhwtjHXBx8JXCELNLN
	CTYYZK0K9un8wzoT6sXUTxmpqlFARv1THu0kUYFcOzQYl6Pi5CdnyjEG3NYidpe2
	RY+1fB/8RmjXqmlR37ziorlZVlbEACiyRKQWFQXCRVFgF2oRQdlhnieJqCnueNCu
	iUhAldRC/RU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73B3995F3;
	Sun, 19 Aug 2012 02:12:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5E4695F2; Sun, 19 Aug 2012
 02:12:24 -0400 (EDT)
In-Reply-To: <80B6C6EE-130C-48C3-BBBB-5FCD1E7EFDEF@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Sat, 18 Aug 2012 02:03:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8373812-E9C4-11E1-8945-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203709>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> I've been getting a couple of test failures and finally had the time to track them down.
>
> t4034-diff-words fails tests "22 diff driver 'bibtex'" and "26
> diff driver 'html'".  Bisecting shows that the file started giving
> me errors in commit 8d96e72 "t4034: bulk verify builtin word regex
> sanity", which appears to introduce those tests.  I don't see
> anything obviously wrong with the tests and I'm not familiar with
> the diff-words code, so I'm not sure what's wrong.
>
> I am running on OS X 10.8, with Xcode 4.4.1 (llvm-gcc 4.2.1).
>
> Test results follow:
>
> ---------- 8< ----------
>
> expecting success: 
> 		cp "$TEST_DIRECTORY/t4034/bibtex/pre" \
> 			"$TEST_DIRECTORY/t4034/bibtex/post" \
> 			"$TEST_DIRECTORY/t4034/bibtex/expect" . &&
> 		echo "* diff=bibtex" >.gitattributes &&
> 		word_diff --color-words
> 	
> --- expect	2012-08-18 05:54:29.000000000 +0000
> +++ output.decrypted	2012-08-18 05:54:29.000000000 +0000
> @@ -8,8 +8,8 @@
>    author={Aldous, <RED>D.<RESET><GREEN>David<RESET>},
>    journal={Information Theory, IEEE Transactions on},<RESET>
>    volume={<RED>33<RESET><GREEN>Bogus.<RESET>},
> -  number={<RED>2<RESET><GREEN>4<RESET>},
> +  number={4},
>    pages={219--223},<RESET>
> -  year=<GREEN>1987,<RESET>
> -<GREEN>  note={This is in fact a rather funny read since ethernet works well in practice. The<RESET> {<RED>1987<RESET><GREEN>\em pre} reference is the right one, however.<RESET>}<RED>,<RESET>
> +  year=<RED>{1987},<RESET><GREEN>1987,<RESET>
> +  note={This is in fact a rather funny read since ethernet works well in practice. The {\em pre} reference is the right one, however.}
>  }<RESET>
> not ok - 22 diff driver 'bibtex'

Thanks for a report.  Off the top of my head, there may be three
possibilities.

 (1) The compiled binary of Git is broken on your platform and not
     formatting the escape sequence correctly.  I somehow think it
     is very unlikely, as the code to do so is pretty much platform
     agonistic (color.c does not use anything fancy from system
     libraries).

 (2) The test script, the part that converts the escape sequence to
     human readable form, is broken---not written in a portable awk.

 (3) The implementation of awk on your platform was broken by your
     supplier, with the same infinite wisdom they broke the UTF-8
     pathnames on their filesystem implementation with ;-)

Can you help isolating the issue first to see if it is (1) or one of
the other two?

Run "cd t && sh t4034-diff-words -i" to force stop the test upon the
first breakage, and inspect the "output" before the awk script
test_decode_color munges it.  Does it show a red number 2 and green
number 4 on the line that begins with "number=" (or if you have an
access to a box on which this test passes, grab the raw output from
it by running this test, and make byte-for-byte comparison)?  
