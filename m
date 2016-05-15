From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSOC Update] Week 2
Date: Sun, 15 May 2016 12:11:09 -0700
Message-ID: <xmqqoa875e7m.fsf@gitster.mtv.corp.google.com>
References: <1462706822-5189-1-git-send-email-pranit.bauva@gmail.com>
	<1463334359-14033-1-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	andrew.ardill@gmail.com
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 21:11:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b21Rh-0005Hy-38
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 21:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbcEOTLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 15:11:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751625AbcEOTLO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 15:11:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E3C9A1B5AF;
	Sun, 15 May 2016 15:11:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VShV5tIKBvLTwdtVfAToidDhb6w=; b=E/Si/E
	jNslGVyaXjpFNzTP04KhaAEy06FqhjpfzHOCo5MHexjrstrfAlzQKK5CeO4yr0PI
	kxEdt8M4fFiTKqN7pFcwYTjmXgcsySn24R3/FUSNSO4oCTPg8bOyDIzobi4D8bGF
	mdf7zz19qV390+SYsDb9aR5D0HjJnoFgpER50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Id4bJ/vNC1l94EQcZ+tWJLamXvlXKS2F
	6khY246RL7CXb5px6ZdOWMD4+4P5XFO0780fjgBfbC1U7d5x+LYtXamhgewG75O3
	dwu6BwKu2bLXTMdvCIfeFB8bw6yjpatU9csgfYW+dRx+OZ7HLredZ1yy4mZXfUqs
	tVtST/j+1Pg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB5521B5AE;
	Sun, 15 May 2016 15:11:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E6C71B5AD;
	Sun, 15 May 2016 15:11:12 -0400 (EDT)
In-Reply-To: <1463334359-14033-1-git-send-email-pranit.bauva@gmail.com>
	(Pranit Bauva's message of "Sun, 15 May 2016 23:15:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C9D95C5A-1AD0-11E6-86C8-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294678>

Pranit Bauva <pranit.bauva@gmail.com> writes:

>    is available for testing on the pu branch. I am encouraging people to
>    test it and provide useful comments.

Do not encourage people to "TEST".  In general, do not put too much
weight on testing.  The result would only measure a small portion of
what you wrote in the code, i.e. what you covered with the addition
to the test suite, plus whatever tests we already had.

Instead, ask people to review.  A new code passing the testsuite is
a minimum requirement, and that is far from sufficient.

>  * I have also converted bisect_log() and bisect_voc() whose patches[3] are
>    sent to the list. Junio is yet to pick these up.

Again, my picking them up is not a success criteria (and certainly
being on 'pu' does not count for anything--it is nothing more than
"Junio saw them on the list and bookmarked the messages".

You should worry more about people not commenting nor reviewing them
than me picking them up (which would typically come later).

>  * The main part (I think) was that I read about the method's which handled the
>    refs. It was an interesting read though I did not read upon the actual
>    implementations of those, I mainly covered "What does the method do?" and
>    "How to use the method in my code?". git-grep is my best friend for this.

Yup.

You would not be calling for-each-ref from a C rewrite of
bisect-clean-state.  Instead you would likely be calling
for_each_ref_in() to iterate over the existing refs/bisect/* refs,
recording their refname and objectname from the callback to
something like string_list, and then after for_each_ref_in()
finishes, iterate over the resulting string_list and running
delete_ref() on them.

And reading the implementation of for-each-ref and update-ref is a
good way to find the need to use these API calls and how they are
used.  API docs are your second step.

Overall, good progress for an early week.

Thanks.
