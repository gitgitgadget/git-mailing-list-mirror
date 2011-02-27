From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Sun, 27 Feb 2011 15:07:46 -0800
Message-ID: <7v39n9uldp.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
 <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
 <4D6A6291.8050206@drmicha.warpmail.net>
 <7v7hclulz0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mart =?utf-8?Q?S=C3=B5mermaa?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 00:08:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptpip-0008ME-8R
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 00:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab1B0XH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 18:07:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab1B0XH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 18:07:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 722404262;
	Sun, 27 Feb 2011 18:09:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rd/qhzAjH2ZAguB5v5k/p8RhIm0=; b=FiJh1X
	oa7csmE+k7IGD+Fzd5LJxOf0LyUKmScFy4eV5RnGkcLm8G7+cdXcl7WkMgiy2vY9
	7vzY5vn8c0rFfrCe0kErOHZGfXDgi4v7oxHxlq0CeLg6a+8w4cLhZ9gYodYmRCcr
	mz6ChgzvqjMoElPoPTy3bpU5wz3A5luW+JJdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t/1NIZ3eX4wL69FNzhYcDssPiAmSyBr6
	UDOREjvCJvb19Wf+xsOQL6ghhA8XoVFMDZxCIqbg9wBkFDuDo00Dm9fyXVGykWeT
	qrfdkhbhbbFvdIoKRFQSMY9KpEiiY4GFx4jJseEZomAqjO8Uqh4a5RJ6B42W1b56
	ePHzS3Wvxb4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F6624261;
	Sun, 27 Feb 2011 18:09:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 206B04260; Sun, 27 Feb 2011
 18:09:05 -0500 (EST)
In-Reply-To: <7v7hclulz0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 27 Feb 2011 14\:54\:59 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 959DC1E8-42C6-11E0-8AB2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168060>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> Wasn't the pager invented for sifting through output which has to be
>> several pages, but not not for that which could be more concise? ;)
>>
>> In fact, -D would be quite analogous to -M and -C in that respect.
>
> There is a big difference: -M and -C lets your recipient reproduce the
> state using the change you are trying to convey with the diff output in
> either direction (iow, "apply -R" works), but your "-D" would not have
> that property.

Having said that we have always valued "reversibility" and a casual -D is
not in line with that principle, I don't have a strong objection if the
new mode of operation is marked clearly as "nonusable if you are trying to
produce appliable diff (iow, don't send such a patch to mailing list--it
is for viewing purposes only)", treating it just like the --color-words
and the --stat options (there isn't even need to mark these as unusable
for that purpose, as people with common sense would be able to guess).

If we were to do this, it probably is a good idea to apply that for a
typechange patch (the one that is produced when a symlink turns into a
regular file and vice versa) as well.  It also might make sense to apply
the similar principle to shorten the output with -B when a rewrite patch
is expressed as a single hunk patch that removes everything old and then
adds everthing new.
