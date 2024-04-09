Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C379D0
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626082; cv=none; b=bkQjocmygNlxPujCNFWZEkOJXEvGxbH5BGnOtD5+DqpFH2vTcScQX62ZOAmUymMIy4gUH/7owkkRA6+amdKUgmqiX+L/H0+vaShIvx6ZBv86CIkpPk9HOcOsRFBgnZXzwQzppen4WGRdjBnnTTiHn0YPKvxNOD1hNYVxn0ODNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626082; c=relaxed/simple;
	bh=QpnCmYfvCwgN0OBfvDw7oA5RqgOZirU5XkoTDr55sjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R5H0KtaveDuQgJKa0K7+hmlB3rg/PfDg703pBKm/g+JDBHP5ZNOEvi0nsabTwsEFjFffL9vTpbvKGhtfvbdlpS8ILQO3B2+e5QUoK9YXuqcwuZR9EAD6fsL9o4npNGZUYl+T1CHQkPWPF8rCvkhjJ3QKowy0y7ZSzALUUoHHQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ozCgV96e; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ozCgV96e"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6622D1F6887;
	Mon,  8 Apr 2024 21:27:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QpnCmYfvCwgN
	0OBfvDw7oA5RqgOZirU5XkoTDr55sjU=; b=ozCgV96eBM+tg/fCiNJlWMQAdY43
	9cL9w96AM3oXPXlyyhMKN2oqUVitkWiNlNa357S+wZ+YifSbYdy/LHCO2ciV/y8z
	9fEu6NB2PtYrkIB2rE5+ZdFE+KtZbx4af6v3cx2o8L0Zy2ldY6eMvGZ68YNqJBfg
	HPth13pc0Q4VyBY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E5C51F6886;
	Mon,  8 Apr 2024 21:27:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C32391F6884;
	Mon,  8 Apr 2024 21:27:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] launch_editor: waiting message on error
In-Reply-To: <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 9 Apr 2024 01:09:21 +0200")
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
	<96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
	<0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
Date: Mon, 08 Apr 2024 18:27:57 -0700
Message-ID: <xmqq4jcb495u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 661CC91C-F610-11EE-8F9E-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> However, even with a short message, feeding that LF makes the following
> "error: There was a problem with the..." clearer, separating it from
> possible messages that the editor could have printed.  So, add that LF.

Sounds sensible.

> +		if (print_waiting_for_editor && !is_terminal_dumb()) {
> +			if (!ret)
> +				/*
> +				 * Erase the entire line to avoid wasting
> +				 * the vertical space.
> +				 */
> +				term_clear_line();

I know this was inherited from the original, but overly verbose
comment is not being very useful here.

> +			else
> +				/*
> +				 * We don't want term_clear_line() here
> +				 * because the editor could have written
> +				 * some useful messages to the user.
> +				 */
> +				fprintf(stderr, "\n");

But I do not think this is emitting the newline at the right place.
The sequence would be (1) we say "we are waiting" on an incomplete
line, and then (2) the editor may say "There was a problem" without
first adding LF _before_ saying so.  Isn't adding a LF here too late
to let the editor emit its message on its own line, instead of
having it _after_ the short "hint" message?

Of course, after these two messages (one from us, and then the
error message from the editor) concatenated on the same line, we
would want to have the next error message on its own line, but
do we need to add an extra newline here for that purpose?  Unlike
our "hint: we are waiting" that we fully intend to clean-up by
using term_clear_line(), the editor that exits upon failure has no
reason to keep its final error message "There was a problem" on an
incomplete line without emitting the terminating LF before giving
control back to us.

The "I do not know if it is bad enough to have these two on the same
line" you seem to refer to indirectly by citing Lars's message
<20171127134716.69471-1-lars.schneider@autodesk.com> is my
<20171127134716.69471-1-lars.schneider@autodesk.com>, I think.  But
in that utterance, "these two" refers to "hint: we are waiting..."
and whatever the message the editor emits upon seeing an error.  The
suggestion I made 7 years ago has nothing to do with the behaviour
change this patch is making.

I think the code is doing the right thing.  It is doing something
different from what the proposed commit log message said it is
doing.  Let me try to summarize what I think this patch does:

	When advice.waitingForEditor configuration is not set to
	false, we show a hint telling that we are waiting for user's
	editor to close the file when we launch an editor and wait
	for it to return control back to us.  We give the message on
	an incomplete line, expecting that we can go back to the
	line and clear the message when the editor returns
	successfully.

	However, it is possible that the editor exits with an error
	status, in which case we show an error message and then
	return to our caller.  In such a case, the error message is
	given where the terminal cursor happens to be, which is most
	likely after the "we are waiting for your editor" message on
	the same line.

	Only clear the line when the editor returned cleanly, and
	otherwise, complete the message on the incomplete line with
	a newline before giving the error message.

Hopefully the above is a more reasonable explanation of what is
happening in this patch, I think?

Actually, having thought it through in order to write the above
explanation, I wonder if we can just call term_clear_line()
regardless of the value of ret.  Either case, the waiting is already
over and in the error case, we show another message after it.

There is another error message when we fail to start the editor.
Doesn't that codepath have the same problem?

I wonder:

 - moving the code to show "hint" down below start_command() where
   it could return error("unable to start");

 - moving the "if (ret) return error("There was a problem")" after
   the block that calls term_clear_line();

would be a better and sufficient fix?

Thanks.
