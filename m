From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Thu, 14 Mar 2013 08:05:42 -0700
Message-ID: <7vmwu6yqbd.fsf@alter.siamese.dyndns.org>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
 <1363179556-4144-1-git-send-email-pclouds@gmail.com>
 <7vehfj46mu.fsf@alter.siamese.dyndns.org>
 <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, git@vger.kernel.org, artagnon@gmail.com,
	robert.allan.zeh@gmail.com, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 16:06:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG9jR-0005xc-AI
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 16:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757955Ab3CNPFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Mar 2013 11:05:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757873Ab3CNPFp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Mar 2013 11:05:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80F9CB9BA;
	Thu, 14 Mar 2013 11:05:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=p5VoMqGrl5fO
	Iii3/4aV5UuO0NM=; b=QqbAdbAPwBvopIXSUoo6DkpiFliZz3tMQ/iIzZwWf1BK
	rjJVuafDhiIzjLdzPn1Cp/1l8i2v2DJ9ylwQ269kRcrpNU7Uo6RWew0BALiQ9h9z
	NY/mdf0iWyBQ/SR8UJWFSHWVTtgDvH5cm4arROR43ke73Lr2Mh/UAUvNkYn5oYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WHkB/w
	iuKo7U6P+l5hl/4Cqgpi33ljq21IG6HXVNIy0tNsZXP/0QY7JyKtJeEm2KhKuamt
	wAy3JyKL59zFGeqFyolVcIWgTVnIf1Hj2lJYpXYx2Cqn0X9t5+OTG6VFzGkOzfum
	vLTHDdGJ4PIhLa/KmrXcW6e5gKuJZ+7LkLMDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75515B9B9;
	Thu, 14 Mar 2013 11:05:45 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B39DCB9B7; Thu, 14 Mar 2013
 11:05:44 -0400 (EDT)
In-Reply-To: <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com> (Duy
 Nguyen's message of "Thu, 14 Mar 2013 17:22:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A52E682C-8CB8-11E2-8C3C-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218142>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Mar 13, 2013 at 10:21 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>>> +     statusUno::
>>> +             If collecting untracked files in linkgit:git-status[1=
]
>>> +             takes more than 2 seconds, hint the user that the opt=
ion
>>> +             `-uno` could be used to stop collecting untracked fil=
es.
>> Thanks, I like the idea
>> could we make a "de-Luxe" version where
>>
>> statusUno is an integer, counting in milliseconds?
>
> No problem.

A huge problem, as it breaks consistency and more importantly, the
suggestion misses the entire point of what "advice.*" variables are.

"advise.*" variables are bools that indicate "Have I learned this
somewhat tricky feature and/or characteristics of Git yet or do I
still need a reminder?"  There is no room for "I still need a
reminder if it takes more than N seconds".  You either already have
got it, or you haven't.

>> "to speed up by stopping displaying untracked files" does not look
>> like giving a balanced suggestion.  It is increasing the risk of
>> forgetting about newly created files the user may want to add, but
>> the risk is not properly warned.
>
> How about "It took X ms to collect untracked files.\nCheck out the
> option -u for a potential speedup"? I deliberately hide "no" so that
> the user cannot blindly type and run it without reading document
> first. We can give full explanation and warning there in the document=
=2E

But it makes the advise much less useful to introduce more levels of
indirections, no?
