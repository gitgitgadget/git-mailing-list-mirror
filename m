Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A24A433BD
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610489; cv=none; b=gixM1YJEJQ2zpziK8SwqxpYEQ0eE2nnyyGebVZ1MRCWFzQIRobpA9Rwjp3PTft2FFuXAl98uMq187XZHHYKje9BGeiw8uG3vXwatOjodZTkU0seXK7j9Kcr45IDbMVh+i62c8v8ECcBh20hrKehc6bQiXq0WGqpuUMzvGxZ4DOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610489; c=relaxed/simple;
	bh=JrPrBywtU0FEDz1n/oTLxnyTjhrgI6N59ojlhrBWq6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CazHvtE7udQyL5gggKiVO8o5nW3agveHCpVuM8K8jyNnnzr/vxQbW2Q9KVlck6QlcGcJpRt23V2WJpIUK/N6m6mqbUMhwmGRcrI6vtXS9vnzd5hSQH9qVK2Z6iaVkzimzSeaBEHVotUUMwF2b5S3mHLOckfrWe3pzHfuwQsL1Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oaty9/kO; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oaty9/kO"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 790273ADB8;
	Mon,  8 Apr 2024 17:08:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JrPrBywtU0FEDz1n/oTLxnyTjhrgI6N59ojlhr
	BWq6o=; b=Oaty9/kOF9mTIf3HKPkHn1/0xk4nfJWZULmU4NqGcBQq5ckfKe5+W8
	cXqVehDKNz2fBWcdQI65jyHuDCVBgX2pjL6W3X8MV6oyLqBlAL8iQaBPGk+gkFN0
	7tcezVlzqMrGWqJVJNWRijTs6osPnV4q8vrMeyq5/EFffO5idLyqg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5ED413ADB7;
	Mon,  8 Apr 2024 17:08:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2FD43ADB6;
	Mon,  8 Apr 2024 17:08:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v5 2/3] send-email: make it easy to discern the messages
 for each patch
In-Reply-To: <7f87383089011a98b0347d885b3b9d76cfddb91d.1712486910.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Sun, 7 Apr 2024 12:48:51 +0200")
References: <cover.1712486910.git.dsimic@manjaro.org>
	<7f87383089011a98b0347d885b3b9d76cfddb91d.1712486910.git.dsimic@manjaro.org>
Date: Mon, 08 Apr 2024 14:08:02 -0700
Message-ID: <xmqq7ch7a7gt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 16CEC6A4-F5EC-11EE-A9B2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> ...  To make the produced outputs more readable, add vertical
> whitespace (more precisely, a newline) between the displayed result statuses
> and the subsequent messages, as visible in ...

The above feels a bit roundabout way to say "the logic is that we
need to add a gap before showing the next message, if we did things
that cause the smtp traces to be shown", but OK.

> These changes don't emit additional vertical whitespace after the result
> status produced for the last processed patch, i.e. the vertical whitespace
> is treated as a separator between the groups of produced messages, not as
> their terminator.  This follows the Git's general approach of not wasting
> the vertical screen space whenever reasonably possible.

I do not see this paragraph is relevant to the target audience.  It
may be a good advice to give to a reader who attempts to solve the
problem this patch solved themselves, botches the attempt and ends
up with a code with the terminator semantics.  But for other readers
of "git log" and reviewers of the patch, "I did not make a silly
mistake, and instead correctly chose to use the separator semantics"
is not something worth boasting about.

> While there, remove a couple of spotted stray newlines in the source code
> and convert one indentation from spaces to tabs, for consistency.
>
> The associated test, t9001, requires no updates to cover these changes.

These are worth recording.

> @@ -1554,7 +1554,10 @@ sub send_message {
>  			exit(0);
>  		} elsif (/^a/i) {
>  			$confirm = 'never';
> +			$needs_separator = 1;
>  		}
> +	} else {
> +		$needs_separator = 1;
>  	}

If you do not add this "else" clause to the outer "are we doing
confirmation?" if statement, and instead just set $needs_separator
*after* it, it would make it even more obvious what is going on.
The codeflow would become

	sub send_message {
		do bunch of things that do not yet send e-mail
	        and possibly return or die

		$needs_separator = 1;

		do things that cause the smtp exchange and trace
		to be emitted
	}

That makes it obvious that the purpose of $needs_separator is to
record the fact that "this" message has already been sent and we
need to add a "gap" before attempting to send the "next" message.

Other than the above points, very well done.

>  	unshift (@sendmail_parameters, @smtp_server_options);
> @@ -1576,7 +1579,6 @@ sub send_message {
>  		print $sm "$header\n$message";
>  		close $sm or die $!;
>  	} else {
> -
>  		if (!defined $smtp_server) {
>  			die __("The required SMTP server is not properly defined.")
>  		}
> @@ -1921,7 +1923,8 @@ sub pre_process_file {
>  sub process_file {
>  	my ($t) = @_;
>  
> -        pre_process_file($t, $quiet);
> +	pre_process_file($t, $quiet);

nice ;-)

> +	print "\n" if ($needs_separator);
>  
>  	my $message_was_sent = send_message();
>  	if ($message_was_sent == -1) {
