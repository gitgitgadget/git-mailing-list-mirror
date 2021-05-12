Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E20C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CFE61363
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhELNTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:19:18 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:43857 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhELNTR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:19:17 -0400
X-Originating-IP: 73.26.133.58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620825487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2fOM8nwaMw2ruf4wKChW1TBJqy7CuLpxXz8waOH7c+g=;
        b=SzPc9YyRe+h/izgYYiVspkT37Q5NyVkotxZyiy2egYm2Oy/K154f+sMdaBjMTyw4b6rhm0
        EFUxNVjndpjOWaHcjUljjQD5swH9LHSwtR7g0jB2KFaGe+OEm/hXXlr1cIkrP+sbOtYPlP
        zoarATZ/HcuwfjeJi2YQvmBwwCqKGFQSdNyV9PH7IfH06/ZaP2Pet2fxTSOn5zqBXuDHq0
        2EkgcnAA/eb6QdInlZaW7c4m2krzVvyimKlhXJKfb3UdEGKgCuPX096DTGc4MiztT2TXDj
        YUe7mGwG4GMmNrKvWxl1gfuTkUguvMLJUlhnnC/tupd7MawUVeJ+6JjAKa1uFw==
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 503E01BF210;
        Wed, 12 May 2021 13:18:06 +0000 (UTC)
Date:   Wed, 12 May 2021 07:18:04 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: add sendmailCommand option
Message-ID: <YJvVjLTFsES2i8a0@gpanders.com>
References: <20210512033039.4022-1-greg@gpanders.com>
 <87y2cks3lt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2cks3lt.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 May 2021 11:04 +0200, Ævar Arnfjörð Bjarmason wrote:
>
>On Tue, May 11 2021, Gregory Anders wrote:
>
>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>> index 93708aefea..d9fe8cb7c0 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -159,13 +159,23 @@ Sending
>>  ~~~~~~~
>>
>>  --envelope-sender=<address>::
>> -	Specify the envelope sender used to send the emails.
>> -	This is useful if your default address is not the address that is
>> -	subscribed to a list. In order to use the 'From' address, set the
>> -	value to "auto". If you use the sendmail binary, you must have
>> -	suitable privileges for the -f parameter.  Default is the value of the
>> -	`sendemail.envelopeSender` configuration variable; if that is
>> -	unspecified, choosing the envelope sender is left to your MTA.
>> +	Specify the envelope sender used to send the emails.  This is
>> +	useful if your default address is not the address that is
>> +	subscribed to a list. In order to use the 'From' address, set
>> +	the value to "auto". If you use the sendmail binary, you must
>> +	have suitable privileges for the -f parameter.  Default is the
>> +	value of the `sendemail.envelopeSender` configuration variable;
>> +	if that is unspecified, choosing the envelope sender is left to
>> +	your MTA.
>
>Please don't include word-wrapping for unrelated changes in the main
>patch.

My mistake, this has been pointed out to me multiple times now. I'll 
remove it in the next revision and I'll be sure to avoid this in the 
future.

>
>> -	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
>> +
>> +	if (!defined $sendmail_command) {
>> +		$smtp_server = 'localhost'; # could be 127.0.0.1, too... *shrug*
>> +	}
>>  }
>
>This "let's not accept a 0" change seems unrelated & should be split
>into a prep cleanup / refactoring patch. On the one hand it's sensible,
>on the other nobody cares about having a command named "0" in their path
>(or a hostname), so I think it's fine to have the ||= Perl idiom leak
>out here.
>
>But also, this just seems like confusing logic. Per your docs "your
>sendmailCommand has precedence over smtpServer.".
>
>Why not make this "if not $sendmail_command" part of the top-level check
>here (the if this one is nested under), which is only done if
>$smtp_sever is not defined, if $sendmail_command is defined we don't
>care about $smtp_server later on, no?

I mostly left this the way it is to minimize the diff, as this is the 
style the code was already written in. I agree that explicitly checking 
whether sendmail_command is undefined is probably clearer to the reader.

>
>>  if ($compose && $compose > 0) {
>> @@ -1490,14 +1497,15 @@ sub send_message {
>>
>>  	unshift (@sendmail_parameters, @smtp_server_options);
>>
>> +	if (file_name_is_absolute($smtp_server)) {
>> +		# Preserved for backward compatibility
>> +		$sendmail_command ||= $smtp_server;
>> +	}
>> +
>>  	if ($dry_run) {
>>  		# We don't want to send the email.
>> -	} elsif (file_name_is_absolute($smtp_server)) {
>> -		my $pid = open my $sm, '|-';
>> -		defined $pid or die $!;
>> -		if (!$pid) {
>> -			exec($smtp_server, @sendmail_parameters) or die $!;
>> -		}
>> +	} elsif (defined $sendmail_command) {
>> +		open my $sm, '|-', "$sendmail_command @sendmail_parameters";
>
>Can we really not avoid moving from exec-as-list so Perl quotes
>everything, to doing our own interpolation here? It looks like the tests
>don't check arguments with whitespace (which should fail with this
>change).
>

Shell interpolation in this case is considered a feature, not a bug, 
i.e. we want to provide users the ability to use arbitrary shell 
expressions (as they do in e.g. aliases) or pass arguments. I also 
modeled this after the implementation for --to-cmd and --cc-cmd, which 
also run their respective commands in the shell just like this.

Also, this *did* cause the tests to fail since the tests write output to 
a path with a space in it. You'll notice that in the diff for the tests 
I had to wrap '$(pwd)/fake.sendmail' in additional quotes to resolve 
this.

>> @@ -1592,14 +1600,14 @@ sub send_message {
>>  		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
>>  	} else {
>>  		print($dry_run ? __("Dry-OK. Log says:\n") : __("OK. Log says:\n"));
>> -		if (!file_name_is_absolute($smtp_server)) {
>> +		if (defined $sendmail_command) {
>> +			print "Sendmail: $sendmail_command ".join(' ',@sendmail_parameters)."\n";
>> +		} else {
>>  			print "Server: $smtp_server\n";
>>  			print "MAIL FROM:<$raw_from>\n";
>>  			foreach my $entry (@recipients) {
>>  			    print "RCPT TO:<$entry>\n";
>>  			}
>> -		} else {
>> -			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
>>  		}
>>  		print $header, "\n";
>>  		if ($smtp) {
>
>Minor nit: Let's just continue to use "if (!" here to keep the diff
>minimal or split up such refactoring into another change...

Sure, I can do that.

Thanks for your feedback.
