From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] fast-export: trivial cleanup
Date: Thu, 09 May 2013 11:52:51 -0700
Message-ID: <7v7gj89e9o.fsf@alter.siamese.dyndns.org>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-5-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5VotNSZC_xHc3r49bBFtNwU+drWa_Pj=skC3xzk-CGpKA@mail.gmail.com>
	<CAMP44s1DPwfiEDuUqUSBN1ShsgLDy9_2E0OD6nnwT7kJeJUCyg@mail.gmail.com>
	<CAEBDL5Ww6g8G-eM93ZFji3ZNEbKrpsTuibHkOk=aSnFapV0EEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu May 09 20:52:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaVxa-00082s-Nq
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 20:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594Ab3EISwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 14:52:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab3EISwy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 14:52:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AD7B1D259;
	Thu,  9 May 2013 18:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oj86GGvtbc73prPJaxH6t4DZia4=; b=WJQfEa
	GzsQHrv7+hGOBC67vmW1fKn0xtlElz6COLUFsyh6H8jsQi9E8VyEtom2Pnz5Ve+f
	erVfxQksmwdx/X/5j3jzVhzxORPvrP6pNhJhURyDYIHPdDYktTrtyb/SoFuFZ+Il
	hifW+Ns1cEL02C1X7j4SEklLAPfmSj8nQZOCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PStLjWcfWzfqHvNDJGeEGN6dWbPKTXL0
	ggXe9sVqx6+8+t23v8v8y/Qv7589oLp4Oq9d3Y+LYKzTkkZQgCnwraolAtEz83fQ
	RzUlI8LAmdtkdJ2jLT9wO9xEXz48SWu0AxfPUQfoY/S335kNaEHarTJUq6XUCyR+
	p7zdt6rN+eU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 900FD1D258;
	Thu,  9 May 2013 18:52:53 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2C5B1D255;
	Thu,  9 May 2013 18:52:52 +0000 (UTC)
In-Reply-To: <CAEBDL5Ww6g8G-eM93ZFji3ZNEbKrpsTuibHkOk=aSnFapV0EEA@mail.gmail.com>
	(John Szakmeister's message of "Thu, 9 May 2013 05:04:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A75FD8F4-B8D9-11E2-947C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223770>

John Szakmeister <john@szakmeister.net> writes:

> On Thu, May 9, 2013 at 4:53 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> [snip]
>>>> @@ -562,9 +561,7 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
>>>>                         break;
>>>>                 case OBJ_COMMIT:
>>>>                         /* create refs pointing to already seen commits */
>>>> -                       commit = (struct commit *)object;
>>>> -                       printf("reset %s\nfrom :%d\n\n", name,
>>>> -                              get_object_mark(&commit->object));
>>>> +                       printf("reset %s\nfrom :%d\n\n", name, get_object_mark(object));
>>>
>>> FWIW, this line is now too long (exceeds 80 columns).  Good catch on
>>> the casting though.
>> ...
>> The key word being *try*.
>
> I saw that, but you actively joined the lines, and there was no need
> to.  It didn't even require trying to keep it within 80 columns. :-)

That is somewhat a flawed argument.

Sometimes it makes it easier to have a single line that is slightly
longer than 80-col than split it across two lines.  "Now one of the
arguments to this function invocation is much shorter.  The only
reason the invocation originally was split into two lines was
because its argument list was too long, so joining them into a
single line _might_ make it easier to read.  Let's try to see how it
reads." is a reasonable line of thought, and at that point, it
starts to require trying to keep it under 80-col.

In this particular case, however, I do not think that the single
line is particularly easier to read, but I do not think the original
is better, either.  The easiest to read would be more like this:

                       printf("reset %s\nfrom :%d\n\n",
                              name, get_object_mark(object));

to show which argument corresponds to which %conversion [*1*]


[Footnote]

*1* When the format string has too many embedded LFs, showing it
    like this:

                       printf("reset %s\n"
                              "from :%d\n\n",
                              name, get_object_mark(object));

    is even better, but I do not think it applies to this particular
    case.
