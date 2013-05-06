From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Mon, 06 May 2013 10:20:50 -0700
Message-ID: <7v4negrpn1.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<7vr4hmuk20.fsf@alter.siamese.dyndns.org>
	<CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
	<7v8v3tuu6i.fsf@alter.siamese.dyndns.org>
	<CALKQrgf6NcT2tEGMTczxR2WspOi4NjrN_kxmKN-QyE2Py3iSaQ@mail.gmail.com>
	<7vhaigrqay.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 06 19:21:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZP60-0004R1-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 19:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450Ab3EFRU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 13:20:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55281 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788Ab3EFRUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 13:20:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ADC91CAA6;
	Mon,  6 May 2013 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fOj0owFjf/P0GAXXCjaoSbR3spY=; b=ZuevZv
	bfCEal4R7V0kDDkFudcd7qChgR8FAg6RnRMo+Aa7sSkMY73yCLZUikfFL3L+7I6Z
	jwWVk/3wAORo856HXM/cIUHL3MyU+p88nek+lLj0M6j5ORwikPIOWMg1RMHEAjaB
	s2Y7uWmjjGgvKosK2UkIMNhL5OmU41O2NgBsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wCruuwHm4xq7Vs9zWGTjTnHIfNuhkJVo
	dtKASMlb6R2K9a8CjcL4COXv5Tyq4eOrOwWuS/zfaM/xGvUcFyxnPn9AOgyfzpdi
	qL6PbWiH5XkuT4XPwDA1LtpiMTO8Ot5Ki425q3A3Jcil8nkxi0rx6QZpEW0tU3T2
	FXdjxM/z8us=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 021F61CAA4;
	Mon,  6 May 2013 17:20:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B71E1CAA1;
	Mon,  6 May 2013 17:20:52 +0000 (UTC)
In-Reply-To: <7vhaigrqay.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 06 May 2013 10:06:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D970122-B671-11E2-91A8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223477>

Junio C Hamano <gitster@pobox.com> writes:

Just a few typofixes...

> Johan Herland <johan@herland.net> writes:
>
>> Let me try to summarize my views on how refnames should work in Git, to
>> see if we can identify where we differ on the principles (or if we, in
>> fact, differ at all):
>
> Thanks; I think I already said where I think we differ in a separate
> message, but a short version is that the point of remote.$nick.fetch
> mapping is to solve "The remote may call a ref $this, which is not
> the refname I want to or can use in my repository, so here is the
> rule to use when importing it in my local namespace.  With the
> mapping, I can name the ref in my local namespace conveniently."
> E.g. their "refs/heads/master" cannot be our "refs/heads/master" at
> the same time, so use "refs/heads/origin/master".

The last should be "refs/remotes/origin/master".

>
> The result of the above mapping, be it remotes/origin/master or
> remotes/origin/heads/master, should be designed to be useful for the
> local use of the ref in question.  If you further need to remap it
> when using it locally, there is something wrong in the mapping you
> defined in your remote.$nick.fetch mapping in the first place.
>
> We do not force any structure under refs/remotes/; it is left
> entirely up to the user, even though we would like to suggest the
> best current practice by teaching "clone" and "remote add" to lay
> them out in a certain way.
>
> Another thing is that refs/remotes/ is not special at all.  If notes
> hierarchies taken from a remote need to be somewhere other than
> refs/notes/, it is perfectly fine to introduce refs/remote-notes/ if
> that is the best layout when using them locally.  What is special is

s/the best/the most convenient/;

> refs/heads/ in that they are the _only_ refs you can check out to
> the working tree and directly advance them by working on the working
> tree files.
