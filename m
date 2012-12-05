From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add basic syntax check on shell scripts
Date: Tue, 04 Dec 2012 22:02:57 -0800
Message-ID: <7vobi9kpda.fsf@alter.siamese.dyndns.org>
References: <201212021417.25525.tboegi@web.de>
 <7vzk1vrs63.fsf@alter.siamese.dyndns.org>
 <CACsJy8BxviWRHqGvptsJVmkFM6HQa9HnLWsh5V6Ec6Fqv52sGA@mail.gmail.com>
 <7vobi9mwt4.fsf@alter.siamese.dyndns.org>
 <CACsJy8BtX9fMkGDoVGKzgz7SSinbt0561B1ZKHu6fs+n8ewKGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 07:03:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tg84j-0008JZ-Me
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 07:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab2LEGDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 01:03:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab2LEGDA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 01:03:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8541063C3;
	Wed,  5 Dec 2012 01:02:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OkGzMTjMp2RFbYCnmoorshYXgyU=; b=KoDTvE
	3Wj0gtucdDyE5t7ca6q88TstBPObm4lidQtLH+rqzz6YJsTdZTvtnKacgCGZGk/R
	C+XyA4/qdDXUkPTLk/HWV+PGOqoS1A9h0IFtRh+/dR3P2TCFS/epUPMJnIQ7QveT
	Q9q559fK4wy/L22xQS5fgD2xZByUYhORq6ZKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DGPbRGQY5DgQtqAoWv6O/VXKl0fn+BMo
	+L0m4F0r0mPRsWFUOorDaK+Zv1AuNrT/ubg5zB6FinJvvHrbRh1OchyISCCkTRh0
	iuS3714HuCRQfqKhfKStCoVYmJWz/nS/39yKbI6bF83HryB8y7JvegN3g+YuebSA
	Yv8ZgdKvdn8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 726C163C2;
	Wed,  5 Dec 2012 01:02:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBF1A63C0; Wed,  5 Dec 2012
 01:02:58 -0500 (EST)
In-Reply-To: <CACsJy8BtX9fMkGDoVGKzgz7SSinbt0561B1ZKHu6fs+n8ewKGg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 5 Dec 2012 12:43:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B7B4C04-3EA1-11E2-9471-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211106>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Dec 5, 2012 at 2:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Or a project commit hook?
>>
>> Surely.  It is OK to have "cd t && make test-lint" in your
>> pre-commit hook.
>
> No, what I meant is a shared pre-commit script that all git devs are
> encouraged (or forced) to install so bugs are found locally rather
> than after patches are sent to you. The hook content does not really
> matter.

Honestly, I do not really care (yet); what you are talkng about is
merely an addition to Documentation/SubmittingPatches, which is
trivial.

The content of the hook is much more important.

If it has too many false positives, it is not worth even encouraging
its use to less experienced ones, as they will have hard time to
figure out which errors matter and which erros can be ignored.  It
will make contributing to the project harder, not easier.

As I do not think (1) we would be able to do a good job reducing
false positives without writing a full POSIX shell parser, and (2)
we would want to be in the business of writing POSIX shell parser
[*1*], I am somewhat skeptical.

And if we cannot come up with a reliable hook in the first place,
there isn't much point in discussing a policy to encourage such a
hook, is it?


[Footnote]

*1* Is there a free one that is portable, perhaps written in either
Perl or Python, to which we can easily plug our own logic?  In order
to catch basic errors, I think it is sufficient to tokenize the
script into independent series of simple commands, even ignoring
variable substitutions and evals, and just have a bunch of "we do
not allow option X to command Y" rules (e.g. "no -i to sed", "the
first argument must be 'git' for "test_must_fail").
