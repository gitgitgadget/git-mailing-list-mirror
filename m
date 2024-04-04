Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375E6A008
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258649; cv=none; b=saNLtcai/Q1u/lzWH5lFdRxrw0/oMnvoy4TN49Y77ereUIzpsxZnj+8UPZQRtFQszR5xUfjoVdFXvdDHi0H95S4A7pmvTMuFPFcG2fL3UaQG5QfoY8dWIKCmYsTFdjgbhMT2/Vt35Ry+qYV7bt5UbpaPvI+Fjec5XaWClfKlzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258649; c=relaxed/simple;
	bh=cCyeMTcH75bAnMme9JedBo0ozJYu24hU4TLXgdqyTAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qw1T+XCJPwN2qbv724N6qeDHXE76L/DzP7nMUbKHyprTd5jfSCI3/8rhv3e2LC3TPqXAtdsZ9WaaFwkZLZt9Xc2eW00iv/caNOR9/TqW5cr7H9BNVyW9GbpYFCmIyWNWPJLv9W55pstunwgUGTYwSZU04EFWFQt6UUGEHVfVmMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DV4phxOo; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DV4phxOo"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D30BD1F65C8;
	Thu,  4 Apr 2024 15:23:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cCyeMTcH75bAnMme9JedBo0ozJYu24hU4TLXgd
	qyTAE=; b=DV4phxOo3Zq8oDNyYEyk/FyHe0umlaGRAu2q0nFNhObTovdZXkRwE/
	/Ju3SkRLRdVbeUUu9DfMgeCCStcVJcWm6pr3HeIJMf/y6eLsSGTB8WM/Akaxhm+z
	9QNf713jRnfGBCGG30UEN+/ZYgibOG+4XYQ3cNg1qnwV+zuEa36UY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CB4491F65C6;
	Thu,  4 Apr 2024 15:23:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 375F01F65C5;
	Thu,  4 Apr 2024 15:23:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RESEND] send-email: make produced outputs more readable
In-Reply-To: <62553db377c28458883b66bcdc0c58cc0f32d15b.1712250366.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Thu, 4 Apr 2024 19:07:32 +0200")
References: <62553db377c28458883b66bcdc0c58cc0f32d15b.1712250366.git.dsimic@manjaro.org>
Date: Thu, 04 Apr 2024 12:23:57 -0700
Message-ID: <xmqqy19tylrm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E30FCC68-F2B8-11EE-9268-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Notes:
>      * send-email: make produced outputs more readable by separating
>        the result statuses from the subsequent patch outputs
>     
>     This is a resubmission of the patch I submitted about a week and a half
>     ago. [1]  The patch subject in the original submission was selected in
>     a bit unfortunate way, which this submission corrects, and also improves
>     the patch description a bit.  There are no changes to the patch itself.

I tried to cram a bit more information than "output more readable"
that lacks in what way the result is easier to read.

    send-email: make boundaries between messages easier to spot

perhaps?

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 821b2b3a135a..62505ab2707c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1576,7 +1576,6 @@ sub send_message {
>  		print $sm "$header\n$message";
>  		close $sm or die $!;
>  	} else {
> -
>  		if (!defined $smtp_server) {
>  			die __("The required SMTP server is not properly defined.")
>  		}
> @@ -1686,9 +1685,9 @@ sub send_message {
>  		print $header, "\n";
>  		if ($smtp) {
>  			print __("Result: "), $smtp->code, ' ',
> -				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
> +				($smtp->message =~ /\n([^\n]+\n)$/s), "\n\n";
>  		} else {
> -			print __("Result: OK\n");
> +			print __("Result: OK\n\n");
>  		}

It would be nicer to instead add a single separate

		print "\n";

after these if/else alternatives, without touching the existing
message lines, I would think.  That way, existing message
translations do not have to change.

If we were to change the translatable string anyway, it would be
even better to remove the newline from the translatable part of the
message, rendering the thing to:

	if ($smtp) {
		print __("Result: "), ..., ($smtp->message =~ /.../);
  	} else {
		print __("Result: OK");
	}
	print "\n\n";

Strictly speaking, that is an orthogonal clean-up, so it may have to
make it into two patch series, one for preliminary clean-up "to
excise terminating newline out of translatable strings" patch that
adds a separate print that adds a single newline, plus the "make it
easier to spot where a message ends and another one starts" patch
that makes the new print statement that adds a single newline to
instead add two.  In a patch as simple as this one, however, I think
killing two birds with a stone, i.e., directly go to the "if we were
to change the translatable string anyway" final shape in a single
patch, would be fine.

Thanks.


