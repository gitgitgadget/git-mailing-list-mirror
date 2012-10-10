From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] format-patch: tests: check rfc822+rfc2047 in to+cc
 headers
Date: Wed, 10 Oct 2012 10:02:24 -0700
Message-ID: <7vhaq2clb3.fsf@alter.siamese.dyndns.org>
References: <1349717609-4770-1-git-send-email-schnhrr@cs.tu-berlin.de>
 <1349717609-4770-6-git-send-email-schnhrr@cs.tu-berlin.de>
 <7v391nfmzn.fsf@alter.siamese.dyndns.org> <50755170.1080205@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?Q?Jan_H=2E_Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 19:02:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLzg9-0002XI-Rp
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 19:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653Ab2JJRCa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 13:02:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753816Ab2JJRCa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 13:02:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BDD5963E;
	Wed, 10 Oct 2012 13:02:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hPwMOWO4OnIK
	MULB+MwR7ncGw54=; b=SxGd4sejHBYLG9j2Ce81ePx8267C/Gi9PkN54tYAjxml
	9ku2leYHrHWTNQq7xXZwDtLmzsk0vYMww6TT9MgOlebbIrmhn9q2zJDpz7rI4aKe
	yy/sahmWai9irO004evYZV7A638Dm6NnvujgcHD/SozRWF1+Hyw1Cu5N/uMhDcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kAuwle
	iRWu2NYrUDTjV4I5CPtYxVgebj7wgvhXL037HDqgI5VKaLLC9LELkgmOHWGO+Qhv
	AcBPyYHUwTZ7nJ+voaYUz5KTxum/aDEdAbjWC93glUnkm7s/mD2nvXmeScmNLEYw
	wULXs5dHqffCxZbTp+R/DjoPaILcW9qoA2t6U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 689039632;
	Wed, 10 Oct 2012 13:02:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C35FC962D; Wed, 10 Oct 2012
 13:02:25 -0400 (EDT)
In-Reply-To: <50755170.1080205@cs.tu-berlin.de> ("Jan H. =?utf-8?Q?Sch?=
 =?utf-8?Q?=C3=B6nherr=22's?= message of "Wed, 10 Oct 2012 12:44:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 441911D0-12FC-11E2-B791-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207418>

"Jan H. Sch=C3=B6nherr" <schnhrr@cs.tu-berlin.de> writes:

> Am 09.10.2012 21:45, schrieb Junio C Hamano:
>> Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de> writes:
>>=20
>>> +test_expect_failure 'additional command line cc (rfc822)' '
>>> +
>>> +	git config --replace-all format.headers "Cc: R E Cipient <rcipien=
t@example.com>" &&
>>>  	git format-patch --cc=3D"S. E. Cipient <scipient@example.com>" --=
stdout master..side | sed -e "/^\$/q" >patch5 &&
>>> -	grep "^Cc: R. E. Cipient <rcipient@example.com>,\$" patch5 &&
>>> -	grep "^ *S. E. Cipient <scipient@example.com>\$" patch5
>>> +	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
>>> +	grep "^ *"S. E. Cipient" <scipient@example.com>\$" patch5
>>=20
>> Hrm.
>>=20
>> As we are not in the business of parsing out whatever junk given
>> with --cc or --recipient from the command line or configuration, but
>> are merely parroting them to the output stream, isn't this a
>> user-error in the test that gives --cc=3D'S. E. Cipient <a@ddre.ss>'
>> instead of giving --cc=3D'"S. E. Cipient" <a@ddre.ss>'?  Same commen=
t
>> on the new 'expect-failure' tests.
>
> Originally, I just wanted to emphasize, that --to and --cc are
> currently handled differently than in git-send-email, where
> all this quoting/encoding is done.
>
> And it is much more convenient to add
> 	--cc 'Jan H. Sch=C3=B6nherr <...>'
> than
> 	--cc '=3D?UTF-8?q?Jan=3D20H=3D2E=3D20Sch=3DC3=3DB6nherr?=3D <...>'
>
> Even more, since I would expect git to correctly handle
> addresses given in a format that is also used elsewhere
> within git.
>
>
> However, I agree that we are not responsible to check/quote/encode
> anything when the user supplies whole headers (though we probably
> could).
>
> But if I cannot convince you, I'll just drop this patch. :)

It wasn't about convincing or not convincing me.

I couldn't read, just from "expect_failure" and "Do some checks
for...", what the intention of the tests and the proposed future
plans were.

If the proposed commit log message (or comments before these
"expect_failure" tests) said something like this:

    "git send-email" historically did not parse the user supplied
    extra header values (e.g. --cc, --recipient) and just replayed
    them, but that forces users to add them in encoded form, e.g.

 	--cc '=3D?UTF-8?q?Jan=3D20H=3D2E=3D20Sch=3DC3=3DB6nherr?=3D <...>'

    which is inconvenient. We would want to update send-email to
    accept human-readable

 	--cc 'Jan H. Sch=C3=B6nherr <...>'

    and encode in the future.  Add test_expect_failure tests as a
    reminder.

that would have avoided such confusion, and even more importantly,
made it easier for us to start discussion on the proposed future
direction.  I am personally on the fence.
