Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E651D1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 19:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeAQTFV (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 14:05:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51067 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeAQTFU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 14:05:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ACA8C77C7;
        Wed, 17 Jan 2018 14:05:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u8HkbzS4/9Ucwd0lQzkC+rG2TCw=; b=skYwxd
        PDQYgQvH2sAVYk0q2J5W0yi2EIsTJcBk/RP99xaJyQqJG49MfgdO1n+I5wjEogq1
        zq1xEncJmLmf7IMR/qkP5k9Ksocu38e3pFG4qn21JMAM2kY7xk956B37PZu2CEJp
        QoSVCxUVcVp5CKTkzuVnqIWcKfBbc+Vdk6zXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vbmam2kigWUssn4pRu98hptL4ekF8hDG
        arGEiY2/DPEI9OguicHn9nE71YBC/n113ShE1zgh2jPTMWbNVv7L7v8RtVoDhQTZ
        E+nRzk+ZRhKHLsg3XLfbA7At9tkOPcwGPU8ME2DC21i75HkqxNuAcSv1gC8NEV3i
        3hMiqX1n9kc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70BA3C77C6;
        Wed, 17 Jan 2018 14:05:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC40FC77C5;
        Wed, 17 Jan 2018 14:05:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Ludwig <chrissicool@googlemail.com>
Cc:     git@vger.kernel.org, Christian Ludwig <chrissicool@gmail.com>
Subject: Re: [PATCH v2 1/2] send-email: Rename variable for clarity
References: <20180117180801.31049-1-chrissicool@gmail.com>
Date:   Wed, 17 Jan 2018 11:05:17 -0800
In-Reply-To: <20180117180801.31049-1-chrissicool@gmail.com> (Christian
        Ludwig's message of "Wed, 17 Jan 2018 19:08:00 +0100")
Message-ID: <xmqq8tcws3v6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BF6FE38-FBB9-11E7-A268-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Ludwig <chrissicool@googlemail.com> writes:

> The SMTP protocol has both, the 'Reply-To' and the 'In-Reply-To' header
> fields. We only use the latter. To avoid confusion, rename the variable
> for it.
>
> Signed-off-by: Christian Ludwig <chrissicool@gmail.com>
> ---

Makes sense.

>  git-send-email.perl | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index edcc6d346..0c07f48d5 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -166,13 +166,13 @@ my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
>  
>  # Variables we fill in automatically, or via prompting:
>  my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
> -	$initial_reply_to,$initial_subject,@files,
> +	$initial_in_reply_to,$initial_subject,@files,
>  	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
>  
>  my $envelope_sender;
>  
>  # Example reply to:
> -#$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
> +#$initial_in_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
>  
>  my $repo = eval { Git->repository() };
>  my @repo = $repo ? ($repo) : ();
> @@ -314,7 +314,7 @@ die __("--dump-aliases incompatible with other options\n")
>      if !$help and $dump_aliases and @ARGV;
>  $rc = GetOptions(
>  		    "sender|from=s" => \$sender,
> -                    "in-reply-to=s" => \$initial_reply_to,
> +                    "in-reply-to=s" => \$initial_in_reply_to,
>  		    "subject=s" => \$initial_subject,
>  		    "to=s" => \@initial_to,
>  		    "to-cmd=s" => \$to_cmd,
> @@ -676,7 +676,7 @@ if ($compose) {
>  
>  	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
>  	my $tpl_subject = $initial_subject || '';
> -	my $tpl_reply_to = $initial_reply_to || '';
> +	my $tpl_in_reply_to = $initial_in_reply_to || '';
>  
>  	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
>  From $tpl_sender # This line is ignored.
> @@ -689,7 +689,7 @@ Clear the body content if you don't wish to send a summary.
>  EOT2
>  From: $tpl_sender
>  Subject: $tpl_subject
> -In-Reply-To: $tpl_reply_to
> +In-Reply-To: $tpl_in_reply_to
>  
>  EOT3
>  	for my $f (@files) {
> @@ -736,7 +736,7 @@ EOT3
>  				quote_subject($subject, $compose_encoding) .
>  				"\n";
>  		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
> -			$initial_reply_to = $1;
> +			$initial_in_reply_to = $1;
>  			next;
>  		} elsif (/^From:\s*(.+)\s*$/i) {
>  			$sender = $1;
> @@ -872,16 +872,16 @@ sub expand_one_alias {
>  @initial_cc = process_address_list(@initial_cc);
>  @bcclist = process_address_list(@bcclist);
>  
> -if ($thread && !defined $initial_reply_to && $prompting) {
> -	$initial_reply_to = ask(
> +if ($thread && !defined $initial_in_reply_to && $prompting) {
> +	$initial_in_reply_to = ask(
>  		__("Message-ID to be used as In-Reply-To for the first email (if any)? "),
>  		default => "",
>  		valid_re => qr/\@.*\./, confirm_only => 1);
>  }
> -if (defined $initial_reply_to) {
> -	$initial_reply_to =~ s/^\s*<?//;
> -	$initial_reply_to =~ s/>?\s*$//;
> -	$initial_reply_to = "<$initial_reply_to>" if $initial_reply_to ne '';
> +if (defined $initial_in_reply_to) {
> +	$initial_in_reply_to =~ s/^\s*<?//;
> +	$initial_in_reply_to =~ s/>?\s*$//;
> +	$initial_in_reply_to = "<$initial_in_reply_to>" if $initial_in_reply_to ne '';
>  }
>  
>  if (!defined $smtp_server) {
> @@ -901,7 +901,7 @@ if ($compose && $compose > 0) {
>  }
>  
>  # Variables we set as part of the loop over files
> -our ($message_id, %mail, $subject, $reply_to, $references, $message,
> +our ($message_id, %mail, $subject, $in_reply_to, $references, $message,
>  	$needs_confirm, $message_num, $ask_default);
>  
>  sub extract_valid_address {
> @@ -1310,9 +1310,9 @@ Message-Id: $message_id
>  	if ($use_xmailer) {
>  		$header .= "X-Mailer: git-send-email $gitversion\n";
>  	}
> -	if ($reply_to) {
> +	if ($in_reply_to) {
>  
> -		$header .= "In-Reply-To: $reply_to\n";
> +		$header .= "In-Reply-To: $in_reply_to\n";
>  		$header .= "References: $references\n";
>  	}
>  	if (@xh) {
> @@ -1489,8 +1489,8 @@ EOF
>  	return 1;
>  }
>  
> -$reply_to = $initial_reply_to;
> -$references = $initial_reply_to || '';
> +$in_reply_to = $initial_in_reply_to;
> +$references = $initial_in_reply_to || '';
>  $subject = $initial_subject;
>  $message_num = 0;
>  
> @@ -1700,9 +1700,9 @@ foreach my $t (@files) {
>  
>  	# set up for the next message
>  	if ($thread && $message_was_sent &&
> -		($chain_reply_to || !defined $reply_to || length($reply_to) == 0 ||
> +		($chain_reply_to || !defined $in_reply_to || length($in_reply_to) == 0 ||
>  		$message_num == 1)) {
> -		$reply_to = $message_id;
> +		$in_reply_to = $message_id;
>  		if (length $references > 0) {
>  			$references .= "\n $message_id";
>  		} else {
