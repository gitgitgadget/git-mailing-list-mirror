Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98D6FAB
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XmhgzAgx"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C16FAF
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:26:48 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 60D8B1BBF23;
	Fri, 10 Nov 2023 00:27:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=p4QGsiXOUIFeza6E/DSd4bIygQgLbtNZhqvyTc
	Su7kY=; b=XmhgzAgx7S0NeWCOsjm4DgTl2k3XN0OW98cB7facEStQSR0A4DR4th
	w18kZDKet0dPajd+CbqyxRN7yKT80A7OaRRK9bw0HjUvJDH1awPjJbBMJsbca0fH
	jH19dEv/wH7zmVc1uKqwS8qeCD/QVsGVY8y+ZX8wFkXncqCm3wDaY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 57D531BBF22;
	Fri, 10 Nov 2023 00:27:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C2D4E1BBF21;
	Fri, 10 Nov 2023 00:27:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Malik Rumi <malik.a.rumi@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: recover lost file
In-Reply-To: <xmqqmsvmw8oc.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	10 Nov 2023 13:09:55 +0900")
References: <CAKd6oBxF8m09QnqZ46joVpcR3mrR4MRSO+kL8vELGwVhD=rgXg@mail.gmail.com>
	<xmqqmsvmw8oc.fsf@gitster.g>
Date: Fri, 10 Nov 2023 14:27:47 +0900
Message-ID: <xmqq1qcyw52k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E2D8DDAE-7F89-11EE-B408-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> You only said "a lost file" without giving any specifics, so it is
> totally unclear to readers of your message how strings like
> "titlesplit" and "filesplit" relate to what you are looking for.  In
> the above I randomly made a blind guess that it might be a function
> name, but I may be totally off the mark.
>
>  - Do you mean "I think the file I removed had a name with either
>    titlesplit or filesplit in it?"
>
>  - Or do you mean "I know that the file had a definition of a
>    function whose name was either titlesplit or filesplit?"
>
>  - Or something completely different from the above two?
>
> If I know all of the followings are true:
>
>  - I had the necessary contents committed in Git;
>
>  - I do not remember the filename at all, but I am sure I deleted it
>    and committed the deletion some time ago;
>
>  - I know the lost contents I am looking for had a string "frotz" in
>    it.
>
> then I would probably try
>
>     $ git log -Sfrotz --diff-filter=D -p
>
> which will look for all file deletions throughout the history,
> limiting the output to those that had string "frotz" in them.
>
> But again, it is unclear what useful clue you have to locate the
> lost file from your description, so ...

If the scenario were

 - I know the file were once committed in Git;

 - I do not remember the filename, but I think its name had either
   "frotz" or "nitfol" in it;

then I would try this instead:

    $ git log --diff-filter=D --summary -- '*frotz*' '*nitfol*'




