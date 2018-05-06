Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93D442023D
	for <e@80x24.org>; Sun,  6 May 2018 03:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeEFD42 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 23:56:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40297 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeEFD41 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 23:56:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id v60-v6so24632636wrc.7
        for <git@vger.kernel.org>; Sat, 05 May 2018 20:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XxC+iPuSjDLEaXkBxlzaHOleIc6NA8D3pfYUeMzP2Z8=;
        b=Mk+jlKFOo1XUXbEni9Vl+8KWotcRIRznL8NkFcehEnVH/uwpIUwKdZZX7FQT497Uc2
         iKAGKOwKxvGmSTEb9xqE3WBtYVOY4I+cBJpsCW4Zet508F62pYBR5XnWRA8Dy8Z/R+Ev
         NgHIi5ch2Dx984t99Cc5bZRq1o/3PXq7Q5xcM0yrlmH9yltnbYtHcrtVjYdewo3tfnGV
         EmBbQPgltHKC4QlNiskb0ZV4leUnALMq7MPU65Y4OoJPldTy+fhVf4AcXGnG/yybHtTY
         beJJ3a4pmxdCLevIu1A7wGaGcvnUjWhMQgJjWO+FXVWxJIXFSVs+AuPIMNUFWJ8loAux
         cMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XxC+iPuSjDLEaXkBxlzaHOleIc6NA8D3pfYUeMzP2Z8=;
        b=blr+ZHOS9n1DS9iuiQNGQGJcCIDAQ4R7n+f9rg/nGpg9/g3WhOaZHo9M/dhDXJz+tT
         v/WCK91YLed6PlAIC3omkrnAq6cReme2UuFDT6akXp6HcwXIC5HtHAmYD5v3Pnzh9T8f
         WZ3jgVcmkfOchfSL96vCedPqiE3SMncM8fFl2KRnJyFw3nwSjxasOlJQZWzewaUPXrL8
         /i+L4iticexCgjzBxk76bD563AxGP1+IUaFWQ2XPOy2fjp7Fvyz9+d+66UzTnhcCTWX5
         F6QEvd9+1oZpOQAvLsxEi4dongMkp9nd0HXlNyeackzadwbNETf4mfId/PGpnnEdJizI
         iyDw==
X-Gm-Message-State: ALQs6tBqfVnLHSiUW1Mcpl8tgx/2R7KMIB4d1SXmceAnZEY4x2zJf71f
        +N7XN6CG3/Vv3tT9nGqMEZ0=
X-Google-Smtp-Source: AB8JxZrtiGGO+0oa4OCjsOQAn1oF5+9GgNTIS0zkZjaRaTIXsa6QMHZluPC/dwkXBPoFpm6H9mzv/g==
X-Received: by 2002:adf:c5cb:: with SMTP id v11-v6mr24830132wrg.151.1525578985934;
        Sat, 05 May 2018 20:56:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c50-v6sm27471224wrc.11.2018.05.05.20.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 May 2018 20:56:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, Simon Ser <contact@emersion.fr>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCHv2] git-send-email: allow re-editing of message
References: <20180504130811.3398-1-sir@cmpwn.com>
Date:   Sun, 06 May 2018 12:56:24 +0900
In-Reply-To: <20180504130811.3398-1-sir@cmpwn.com> (Drew DeVault's message of
        "Fri, 4 May 2018 09:08:11 -0400")
Message-ID: <xmqq4ljlsahj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> When shown the email summary, an opportunity is presented for the user
> to edit the email as if they had specified --annotate. This also permits
> them to edit it multiple times.
>
> Signed-off-by: Drew DeVault <sir@cmpwn.com>
> Reviewed-by: Simon Ser <contact@emersion.fr>
>
> ---
> Thanks for the review Eric, updated to address your feedback.

Instead you could credit him with Helped-by:, perhaps in place of
Reviewed-by: somebody who does not have any commit in our history,
which does not help others decide how good this patch is because
they do not know how much trust they should place in the ability to
review of somebody they never have heard of---Simon may be a super
human programmer whose name alone should assure us that a patch
endorsed is good, but the thing is, that won't happen until we know
that.

The patch looks good.  Eric may say "This round looks good to me"
before I have a chance to queue it, in which case I'll add his
Reviewed-by: and queue.  In either case, unless there is something
else comes up, there is no need to resend this patch.

Thanks.

>  git-send-email.perl | 38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2fa7818ca..b45953733 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1330,9 +1330,14 @@ sub file_name_is_absolute {
>  	return File::Spec::Functions::file_name_is_absolute($path);
>  }
>  
> -# Returns 1 if the message was sent, and 0 otherwise.
> -# In actuality, the whole program dies when there
> -# is an error sending a message.
> +# Prepares the email, then asks the user what to do.
> +#
> +# If the user chooses to send the email, it's sent and 1 is returned.
> +# If the user chooses not to send the email, 0 is returned.
> +# If the user decides they want to make further edits, -1 is returned and the
> +# caller is expected to call send_message again after the edits are performed.
> +#
> +# If an error occurs sending the email, this just dies.
>  
>  sub send_message {
>  	my @recipients = unique_email_list(@to);
> @@ -1404,15 +1409,17 @@ Message-Id: $message_id
>  
>  EOF
>  		}
> -		# TRANSLATORS: Make sure to include [y] [n] [q] [a] in your
> +		# TRANSLATORS: Make sure to include [y] [n] [e] [q] [a] in your
>  		# translation. The program will only accept English input
>  		# at this point.
> -		$_ = ask(__("Send this email? ([y]es|[n]o|[q]uit|[a]ll): "),
> -		         valid_re => qr/^(?:yes|y|no|n|quit|q|all|a)/i,
> +		$_ = ask(__("Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): "),
> +		         valid_re => qr/^(?:yes|y|no|n|edit|e|quit|q|all|a)/i,
>  		         default => $ask_default);
>  		die __("Send this email reply required") unless defined $_;
>  		if (/^n/i) {
>  			return 0;
> +		} elsif (/^e/i) {
> +			return -1;
>  		} elsif (/^q/i) {
>  			cleanup_compose_files();
>  			exit(0);
> @@ -1552,7 +1559,12 @@ $references = $initial_in_reply_to || '';
>  $subject = $initial_subject;
>  $message_num = 0;
>  
> -foreach my $t (@files) {
> +# Prepares the email, prompts the user, sends it out
> +# Returns 0 if an edit was done and the function should be called again, or 1
> +# otherwise.
> +sub process_file {
> +	my ($t) = @_;
> +
>  	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
>  
>  	my $author = undef;
> @@ -1755,6 +1767,10 @@ foreach my $t (@files) {
>  	}
>  
>  	my $message_was_sent = send_message();
> +	if ($message_was_sent == -1) {
> +		do_edit($t);
> +		return 0;
> +	}
>  
>  	# set up for the next message
>  	if ($thread && $message_was_sent &&
> @@ -1776,6 +1792,14 @@ foreach my $t (@files) {
>  		undef $auth;
>  		sleep($relogin_delay) if defined $relogin_delay;
>  	}
> +
> +	return 1;
> +}
> +
> +foreach my $t (@files) {
> +	while (!process_file($t)) {
> +		# user edited the file
> +	}
>  }
>  
>  # Execute a command (e.g. $to_cmd) to get a list of email addresses
