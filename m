Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DAF20450
	for <e@80x24.org>; Wed,  1 Nov 2017 02:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933050AbdKACpB (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 22:45:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53751 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932210AbdKACo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 22:44:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C36FB9E50;
        Tue, 31 Oct 2017 22:44:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=55s8VC2eXL4nxCZWQ85URXOjR5E=; b=Kgqd4P
        xuBaKCpcrnrpGdYQHqGvbI2/w6sGlsVxQIQPqjQQ5VAfQo1DvZu/VwA6lfSj+nDY
        Lr6VN6dLdq1SQG5Lo58jUgBbdk7x8/p2cQdtf8TFJeaoaoULEgG+dnJ86Gx0tyAQ
        2sYwX10JrQcJAnU8ZEBxOSOIbgx+iCKvuMlJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tog6N770nNEgzh5A430MA//PV1Uasdk+
        u33OzBixCeZuz8ro0n7+3LCLJa8bhsh2zljg1zFAW0xJeMmZSwdBJdM5WZGbcmCl
        l+L8tjwKQKn/zoi4zHQXJkfrfuv2TCsj8BmrD2ac4wtWdZQgPn9DkFbd7M6OU4Lc
        cqBKzcKSpZw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23633B9E4F;
        Tue, 31 Oct 2017 22:44:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89C22B9E4E;
        Tue, 31 Oct 2017 22:44:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Payre Nathan <second.payre@gmail.com>
Cc:     git@vger.kernel.org, matthieu.moy@univ-lyon1.fr,
        timothee.albertin@etu.univ-lyon1.fr,
        daniel.bensoussan--bohm@etu.univ-lyon1.fr,
        Tom Russello <tom.russello@grenoble-inp.org>
Subject: Re: [PATCH 1/2] quote-email populates the fields
References: <20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr>
        <20171030223444.5052-2-nathan.payre@etu.univ-lyon1.fr>
Date:   Wed, 01 Nov 2017 11:44:56 +0900
In-Reply-To: <20171030223444.5052-2-nathan.payre@etu.univ-lyon1.fr> (Payre
        Nathan's message of "Mon, 30 Oct 2017 23:34:43 +0100")
Message-ID: <xmqqk1zawwd3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5FBFFE4-BEAE-11E7-A2EE-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Payre Nathan <second.payre@gmail.com> writes:

> From: Tom Russello <tom.russello@grenoble-inp.org>
>
> ---

Missing something here???

>  Documentation/git-send-email.txt |   3 +
>  git-send-email.perl              |  70 ++++++++++++++++++++++-
>  t/t9001-send-email.sh            | 117 +++++++++++++++++++++++++--------------
>  3 files changed, 147 insertions(+), 43 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index bac9014ac..710b5ff32 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -106,6 +106,9 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
>  Only necessary if --compose is also set.  If --compose
>  is not set, this will be prompted for.
>  
> +--quote-email=<email_file>::
> +	Fill appropriately header fields for the reply to the given email.
> +

The cover letter said:

    This patch allows send-email to do most of the job for the user, who can
    now save the email to a file and use:

      git send-email --quote-email=<file>

    "To" and "Cc" will be added automaticaly and the email quoted.
    It's possible to edit the email before sending with --compose.

and I somehow expected to see the body of the e-mail this option is
"quoting" to be also inserted in the text.  After all, that is what
"quote" means.

But the description above (and the code below, judging from the way
the reading from $fh that was opened form $quote_email stops at the
first blank line, aka end of header) says what is happening is quite
different.  The contents of the file is used to extract what the
user would have given to --cc/--to/--in-reply-to from the command
line by looking at it, if this option were not available.

I personally prefer the "pick up the header information so that the
user do not have to formulate the command line options" behaviour
that does *NOT* quote the body of the message into the outgoing
message.  So:

 * Do not call this option "quote" anything; you are not quoting,
   just using some info from the given file.  

   I wonder if we can simply reuse "--in-reply-to" option for this
   purpose.  If it is a message id and not a file on the filesystem,
   we behave just as before.  Otherwise we try to open it as a file
   and grab the "Message-ID:" header from it and use it.

 * The description "Fill *appropriately* header fileds" is useless,
   as what looks "appropriate" to you is not clear/known to
   readers.  Instead, say what header is filled with what
   information (e.g. "find Message-Id: and place its value on
   In-Reply-To: header").

   For that matter, "To and CC will be added automatically" in the
   coer letter is still vague; are you reading To/CC in the given
   file and placing their values on some (unnamed) header of the
   outgoing message?  Or are you reading some (unnamed) header in
   the given file and placing their values on To/CC header of the
   outging message?

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2208dcc21..665c47d15 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -57,6 +57,7 @@ git send-email --dump-aliases
>      --[no-]bcc              <str>  * Email Bcc:
>      --subject               <str>  * Email "Subject:"
>      --in-reply-to           <str>  * Email "In-Reply-To:"
> +    --quote-email           <file> * Populate header fields appropriately.

Likewise.  If what's "appropriate" is clear to the readers, the word
in this description adds no value because everybody would know how
fields are populated.  Otherwise, it does not add any value because
everybody would have no clue how fields are populated.

> @@ -652,6 +654,70 @@ if (@files) {
>  	usage();
>  }
>  
> +if ($quote_email) {
> +	my $error = validate_patch($quote_email);
> +	die "fatal: $quote_email: $error\nwarning: no patches were sent\n"
> +		if $error;

validate_patch() calls sendemail-validate hook that is expecting to
be fed a patch email you are going to send out that might have
errors so that it can catch it and save you from embarrassment.  The
file you are feeding it is *NOT* what you are going to send out, but
is what you are responding to with your patch.  Even if it had an
embarassing error as a patch, that is not something you care about
(and it is something you received, so catching this late won't save
the sender from embarrassment anyway).

> +
> +	my @header = ();
> +
> +	open my $fh, "<", $quote_email or die "can't open file $quote_email";
> +
> +	# Get the email header
> +	while (<$fh>) {
> +		# Turn crlf line endings into lf-only
> +		s/\r//g;
> +		last if /^\s*$/;
> +		if (/^\s+\S/ and @header) {

I wonder how significant this requirement to have at least one "\S"
on the line is.  I know you copied&pasted this from the main sending
loop, so this is not a new issue and not something we may want to
fix in this patch.

> +			chomp($header[$#header]);
> +			s/^\s+/ /;
> +			$header[$#header] .= $_;
> +		} else {
> +			push(@header, $_);
> +		}
> +	}

You do not use $fh after this point.  Do not force readers to
realize that fact by scanning to the end of the function--instead,
close it here.

> +	# Parse the header
> +	foreach (@header) {
> +		my $initial_sender = $sender || $repoauthor || $repocommitter || '';
> +
> +		chomp;
> +
> +		if (/^Subject:\s+(.*)$/i) {
> +			my $prefix_re = "";
> +			my $subject_re = $1;

What does "_re" mean in the variable name $subject_re?

> +			if ($1 =~ /^[^Re:]/) {
> +				$prefix_re = "Re: ";
> +			}
> +			$initial_subject = $prefix_re . $subject_re;
> +		} elsif (/^From:\s+(.*)$/i) {
> +			push @initial_to, $1;
> +		} elsif (/^To:\s+(.*)$/i) {
> +			foreach my $addr (parse_address_line($1)) {
> +				if (!($addr eq $initial_sender)) {

This if() condition makes a policy decision; shouldn't it honor the
setting of "--[no-]suppress-from", "--suppress-cc" and friends?

> +					push @initial_cc, $addr;
> +				}
> +			}
> +		} elsif (/^Cc:\s+(.*)$/i) {
> +			foreach my $addr (parse_address_line($1)) {
> +				my $qaddr = unquote_rfc2047($addr);
> +				my $saddr = sanitize_address($qaddr);
> +				if ($saddr eq $initial_sender) {
> +					next if ($suppress_cc{'self'});
> +				} else {
> +					next if ($suppress_cc{'cc'});
> +				}
> +				push @initial_cc, $addr;
> +			}
> +		} elsif (/^Message-Id: (.*)/i) {
> +			$initial_reply_to = $1;
> +		} elsif (/^References:\s+(.*)/i) {
> +			$initial_references = $1;
> +		}
> +	}
> +	$initial_references = $initial_references . $initial_reply_to;

I cannot see how this can produce correct result by simply
concatenating them with nothing in between.  Shouldn't you make sure
there is a SP in between, at least?

By the way, if you are adding a new variable $initial_references,
make sure it is initialized to either an empty string or an undef
(and if you choose to do the latter, the right hand side of this
assignment cannot blindly reference $initial_references that could
still be undef); the way the existing code handles $initial_reply_to
may serve as an example.
