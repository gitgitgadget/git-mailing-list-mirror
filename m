From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] builtin: add git-check-mailmap command
Date: Thu, 11 Jul 2013 22:47:37 -0700
Message-ID: <7vbo68pbwm.fsf@alter.siamese.dyndns.org>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
	<1373554528-15775-2-git-send-email-sunshine@sunshineco.com>
	<7vli5crk8l.fsf@alter.siamese.dyndns.org>
	<CAPig+cQvnKSxZ5M6zW_r6Y9xwZ0Ch99JDq4SccYXCRof9svsOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 07:47:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWCn-0008Th-3r
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 07:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616Ab3GLFrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 01:47:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435Ab3GLFrk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 01:47:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F10FD2A008;
	Fri, 12 Jul 2013 05:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z6u73oAZSpdt2RolKYjjSdtYKWY=; b=C2U6rt
	YEOadL/1+s1qsBXENL6/T+xDqanlraOdNfvUle0aj9QH/Y/azN3jl11rPBIEMeR5
	EjRxy/JiD5m9viYXs9BuJTMZ3+CR2bu/Hw6FJTHe9ZbcsiSpoc8SFqVtB9lw+3gL
	T8lrITtMeOV38A9tEjHWXSLiEYjxUUh1p/NOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Poeu2FUvkHNciZi0rBME4zmpurYXtWsH
	S3DQyXR8QlEfQisW1FpQxL+v878s4T2bk5SgtLSgCO5dutvPGK0XtFWWszAkLjei
	fLohHWkKcICnRQ6rMrYW1HHBScwGzyuKxHnZayoLRW9wkLrL5vqgTDD+xLrsmbsv
	CeZDB1eyucs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4ECE2A007;
	Fri, 12 Jul 2013 05:47:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 527512A001;
	Fri, 12 Jul 2013 05:47:39 +0000 (UTC)
In-Reply-To: <CAPig+cQvnKSxZ5M6zW_r6Y9xwZ0Ch99JDq4SccYXCRof9svsOg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 11 Jul 2013 23:28:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8FE2882A-EAB6-11E2-AA35-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230160>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>         For each contact information (either in the form of ``Name
>>         <user@host>'' or ...)
>>
>> in order to clarify that the two forms of input is what you call
>> "contact information".
>
> Is this easier to read?
>
>     For each ``Name $$<user@host>$$'' or ``$$<user@host>$$'' from the
>     command-line or standard input (when using `--stdin`), print a line
>     showing either the canonical name and email address (see "Mapping
>     Authors" below), or the input ``Name $$<user@host>$$'' or
>     ``$$<user@host>$$'' if there is no mapping for that person.

I find it easier than your original, but I do not know if you would
want to repeat the "Name... or <user@host>" at the end.  It does not
seem to add much useful information and is distracting.

>> If there isn't, use "null_term_line" like they do.
>
> In check-attr, null_term_line indicates that _input_ lines are
> null-terminated. In check-ignore, null_term_lines is overloaded (and
> perhaps abused) to mean that both _input_ and _output_ lines are
> null-terminated.

That is unfortunate but it is good that you found the breakage.  As
we do not have --nul-terminated-input and --nul-terminated-output
options separtely, -z should apply to both input and output.  What
b4666852 (check-attr: Add --stdin option, 2008-10-07) did is broken.
What check-ignore does 

We should find a way to fix it.  I have a feeling that silently
fixing it and seeing if anybody screams might be the best course of
action ;-).

Also "git check-ignore -h" advertises "-z" as only affecting "--stdin",
which is also wrong.  It does affect both input and output as it should,
so it should be described as such, I think.

Thanks for noticing.
