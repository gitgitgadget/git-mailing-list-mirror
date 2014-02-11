From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and arguments
Date: Tue, 11 Feb 2014 10:07:35 -0800
Message-ID: <xmqqa9dxr09k.fsf@gitster.dls.corp.google.com>
References: <xmqqr47fx001.fsf@gitster.dls.corp.google.com>
	<20140209.145205.1882309246743951569.chriscool@tuxfamily.org>
	<xmqq61omu96d.fsf@gitster.dls.corp.google.com>
	<20140210.205936.813126606054805390.chriscool@tuxfamily.org>
	<xmqq38jqsnc2.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Nq-LkE=FW5dnBZKKd7-ORJPo1BFs3sY+MLGxuXEWuTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 11 19:07:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDHkH-0006MM-IJ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 19:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbaBKSHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 13:07:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48302 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbaBKSHk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 13:07:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7634969C11;
	Tue, 11 Feb 2014 13:07:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9fn2zqdgJ78spG/m/iNH6dTGQPo=; b=D109zi
	3O3Teal7Wv7ncqftD4jMSsOi9Da6ZjEMF+9OKXQvek6/4AacAUsDuEW9XUozpC/x
	5gsukdWaj1WwHz9jpNVdp/ehkTfTv0zVjGVC4Q9jC9RDCHVVDu0tC9rjuUXJNDqW
	zzRySvk9uKFM/tUAPkeD55iIfnhVKYqstVgm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xdN8QvwN+iJZiuPxIzUH5u92NhDva1yp
	oshgFN2QmOhPu3Qk569wqCtBqOuKqPUkP3eP+NfXoYCW2QbGX1MB1WHj8PHDODv7
	FSVfEb77RP5FKhYU7T1bAo4H5mOT62ubSe+geUEMcyUdT7ZDz9zIpSExyC86JtL8
	AiU3C0ZDsjk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 586DB69C10;
	Tue, 11 Feb 2014 13:07:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4564E69C0C;
	Tue, 11 Feb 2014 13:07:37 -0500 (EST)
In-Reply-To: <CAP8UFD1Nq-LkE=FW5dnBZKKd7-ORJPo1BFs3sY+MLGxuXEWuTw@mail.gmail.com>
	(Christian Couder's message of "Tue, 11 Feb 2014 16:02:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6390CE50-9347-11E3-BE4E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241951>

Christian Couder <christian.couder@gmail.com> writes:

>> Even if we assume, for the sake of discussion, that it *is* a good
>> idea to separate "under this condition" part and "do this" part, I
>> do not think the above is the only or the best way to express
>> "distinct values allowed for the same key".  How do we argue that
>> this from your example
>>
>>   if_exists = add_if_different
>>   if_missing = add
>>
>> is a better design than this, for example?
>>
>>   if_key_value_exists = ignore ; exact matching <key,val> exists
>>   if_key_exists = add          ; otherwise
>>   if_missing = add
>
> The question is what happens if we want to say "if the same <key,
> value> pair exists but not near where we would add.
>
> With the solution I implemented, that is:
> ...
> With the solution you suggest, should we have:
> ...
>   if_key_value_exists_not_neighbor = add ; exact matching <key,val>
> ...
> or:
>   if_key_value_exists = ignore_if_neighbor ; exact matching <key,val> exists
> ...
>
> And what happens if we want to say "if key exists and value matches
> <regex>", how do we express that then?
> Or what happens when we want to say "if key exists and <command> succeeds"?
> ...
> With what I suggest, we can still say:
> ...
> And then people might ask if they can also use something like this:
> ...
> and it will look like we are trying too much to do what should be done
> in only one script.

I think the above illustrates my point very clearly.

These numerous questions you have to ask are indications why
choosing "this condition goes to the left hand side of the equal
sign (e.g. exists)" and "this condition goes to the right hand side
(e.g. do-this-if_neighbor)" is not working well.  The user has to
remember which conditions go to the variable name and which
conditions go to the action part.

And the made-up alternative you listed above is not a solution I
suggest to begin with---it is a strawman "if we assume such a
splitting were a good idea" in the first place ;-).

What I was wondering if it is an better alternative was the below.

>> The latter splits remaining conditional logic from "do this" part
>> (no more "add_if_different" that causes "add" action to see if there
>> is the same key and act differently) and moves it to "under this
>> condition" part.
>> ...
>> I am trying to illustrate that the line to split the "under this
>> condition" and "do this" looks arbitrary and fuzzy here, and because
>> of this arbitrary-ness and fuzziness, it is not very obvious to me
>> why it is a good idea to have "under this condition" as a separate
>> concept from "do this" settings.

That is, not splitting the logic into two parts like you did,
i.e. "if_X = do_Y_if_Z", which invites "why is it not if_true =
do_Y_if_X_and_Z, if_X_and_Z = do_Y, if_Z = do_Y_if_X"?

One possible way to avoid the confusion is to say "do_Y_if_X_and_Z"
without making the rule split into conditions and actions---I am
NOT saying that is _better_, there may be other solutions to avoid
this two-part logic in a cleaner way.
