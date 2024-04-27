Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68C23A6
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714238858; cv=none; b=G2z6hUVYgn2KsNmFzH/Wu5cbepTAUv+2Kk8gOqIl5Sb8ksPydicoTmEJ/onJjLv4bCHzqY4A470lasmoQ/fRCNKNmxvPDHNwyJgVwCJPrKMd2FfSxieWzjdxSToGTOiu5bxpSxJ34MLjPSIRFmoorCjUug5sCQREEbi/BEiiT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714238858; c=relaxed/simple;
	bh=zKNW6fSs30uU2SWj2Du3ixyohJYsG1gHzTu/PMG5aww=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=onfHiwaPRN2DoLr3D3K2L/Oc3jqGhDf7ZczV7lDNDW6lmDLE/3WHi0OfpzEzOgEdrEpCMG5+Jsv5fWkE71UfW/S/sk5YicwN+FnoR5MzQjQpluzzuOdpIf0bubp1Hc/PeSBfbXsi0tN5vLhsgXA4lG41jR2X+4MnAxH7Q7n2bzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=EpEFST4T; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="EpEFST4T"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714238847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dmxvs5zRWFvXycOnlUrbDsu8jEpGOAjzZ9nOsGB9f5E=;
	b=EpEFST4TJ23FBeyQxzyi9dhikMzyn+2erdplX0/LDEN4X13/WlEqp3cBQ4I8kY3AuyC9IV
	DKeppqTnl4QZTmvJ53Uu295WmMghBID1xeT9TVXy/bY4AnTKJLPwnqZzgFqtQrUOxk6qGV
	QgRgwrXn3z3NhdGtEEaF0MtQWzZ15h5s++ULBvO7uY6YCGgrL96lZurtRHskrdGXjubE0o
	z6PNzljMzx42l0igGEtin+O+b+yOLy92LJ8T/MYSIcBhE6794fJ1+x6rf6fPL+TdOZlrOT
	QmcnlbhC2iRnUs7TpW2N/Bjrx16ZKXpXvNuqIO8Z3/TjtWugKu+cCcfjfpyK6Q==
Date: Sat, 27 Apr 2024 19:27:26 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v6 2/2] send-email: make it easy to discern the messages
 for each patch
In-Reply-To: <7dcc6f23cc7cb823cb19ec63c69c60e4@manjaro.org>
References: <cover.1712732383.git.dsimic@manjaro.org>
 <c78b043b5a6cf0de712d36e6e000804bd6e1316d.1712732383.git.dsimic@manjaro.org>
 <xmqqh6g9w5bf.fsf@gitster.g> <7dcc6f23cc7cb823cb19ec63c69c60e4@manjaro.org>
Message-ID: <0216a0e8369b8a3592dda90e5680be31@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

Just checking, is there something I can do to get this patch
series moving forward?

On 2024-04-13 08:27, Dragan Simic wrote:
> On 2024-04-10 18:28, Junio C Hamano wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> 
>>> When sending one or multiple patches at once, the displayed result 
>>> statuses
>>> for each patch and the "Send this email [y/n/a/...]?" confirmation 
>>> prompts
>>> become bunched together with the messages produced for the subsequent 
>>> patch,
>>> or with the produced SMTP trace, respectively.
>>> 
>>> This makes reading the outputs unnecessarily harder, as visible in a 
>>> couple
>>> of excerpts from a sample output below:
>> 
>> It is unclear where the boundaries between the messages in the
>> example are, though.
>> 
>>>     ...
>>>     MIME-Version: 1.0
>>>     Content-Transfer-Encoding: 8bit
>>> 
>>>     Result: 250
>> 
>> Is this where one message ends, and the next line "OK. Log says:" is
>> the beginning of the next message?
>> 
>>>     OK. Log says:
>>>     Server: smtp.example.com
>>>     MAIL FROM:<test@example.com>
>>>     ...
>>> 
>>>     ...
>>>     MIME-Version: 1.0
>>>     Content-Transfer-Encoding: 8bit
>> 
>> Is the above about a single (i.e. the second) message ...
>> 
>>>     Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
>> 
>> ... and the user is asked about that message?
>> 
>>>     OK. Log says:
>>>     Server: smtp.example.com
>>>     MAIL FROM:<test@example.com>
>>>     ...
> 
> Huh, I understand your confusion and those are all valid remarks.
> However, my intention was to include excerpts that are long enough
> to illustrate the points to someone already familiar enough with
> the outputs produced by "git send-mail".
> 
> If that isn't good enough for the intended audience of the Git
> repository log, I unfortunately see no good way to provide excerpts
> that are long enough to eliminate any doubts.  Such excerpts would
> need to be half a dozen screens long, which would turn the patch
> description into a monster.
> 
> With all that in mind, perhaps it's the best to simply delete all
> excerpts from the patch description, if you agree?
> 
>> And is this about a separate (i.e. the third) message?  Without
>> making these clear, it is hard to agree or disagree with the claim
>> that the current presentation is hard to read.
>> 
>>>     MIME-Version: 1.0
>>>     Content-Transfer-Encoding: 8bit
>>> 
>>>     Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
>>> 
>>>     OK. Log says:
>>>     Server: smtp.example.com
>>>     MAIL FROM:<test@example.com>
>>>     ...
>> 
>> This is obviously in the realm of subjective preference, but I find
>> that the prompt line is distinct enough among all other output that
>> we do not need an extra blank line to locate them.
> 
> Basically, I went with a rather simple reasoning:  the confirmation
> prompts, just like the SMTP statuses, aren't part of the emitted SMTP
> traces and patch descriptions.  They're different kinds of emitted
> messages, if you agree.
> 
> Thus, separating the prompts with vertical whitespace is actually
> consistent, and should help with the overall readability, by taking
> the prompts visually out of the other produced messages.  In other
> words, it's about keeping different kinds of emitted messages
> separate, with the focus on the SMTP traces and patch descriptions,
> instead of making the prompts locatable.
> 
>>> diff --git a/git-send-email.perl b/git-send-email.perl
>>> index f0be4b4560f7..1d6712a44e95 100755
>>> --- a/git-send-email.perl
>>> +++ b/git-send-email.perl
>>> @@ -1361,7 +1361,6 @@ sub smtp_host_string {
>>> 
>>>  # Returns 1 if authentication succeeded or was not necessary
>>>  # (smtp_user was not specified), and 0 otherwise.
>>> -
>>>  sub smtp_auth_maybe {
>>>  	if (!defined $smtp_authuser || $auth || (defined $smtp_auth && 
>>> $smtp_auth eq "none")) {
>>>  		return 1;
>>> @@ -1510,6 +1509,7 @@ sub gen_header {
>>>  sub send_message {
>>>  	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, 
>>> $header) = gen_header();
>>>  	my @recipients = @$recipients_ref;
>>> +	my $confirm_shown = 0;
>>> 
>>>  	my @sendmail_parameters = ('-i', @recipients);
>>>  	my $raw_from = $sender;
>>> @@ -1555,6 +1555,7 @@ sub send_message {
>>>  		} elsif (/^a/i) {
>>>  			$confirm = 'never';
>>>  		}
>>> +		$confirm_shown = 1;
>>>  	}
>>> 
>>>  	unshift (@sendmail_parameters, @smtp_server_options);
>>> @@ -1576,7 +1577,6 @@ sub send_message {
>>>  		print $sm "$header\n$message";
>>>  		close $sm or die $!;
>>>  	} else {
>>> -
>>>  		if (!defined $smtp_server) {
>>>  			die __("The required SMTP server is not properly defined.")
>>>  		}
>>> @@ -1664,9 +1664,11 @@ sub send_message {
>>>  		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), 
>>> $subject).$smtp->message;
>>>  	}
>>>  	if ($quiet) {
>>> +		print "\n" if ($confirm_shown);
>>>  		printf($dry_run ? __("Dry-Sent %s") : __("Sent %s"), $subject);
>>>  		print "\n";
>>>  	} else {
>>> +		print "\n";
>>>  		print($dry_run ? __("Dry-OK. Log says:") : __("OK. Log says:"));
>>>  		print "\n";
>>>  		if (!defined $sendmail_cmd && 
>>> !file_name_is_absolute($smtp_server)) {
>>> @@ -1923,7 +1925,7 @@ sub pre_process_file {
>>>  sub process_file {
>>>  	my ($t) = @_;
>>> 
>>> -        pre_process_file($t, $quiet);
>>> +	pre_process_file($t, $quiet);
>>> 
>>>  	my $message_was_sent = send_message();
>>>  	if ($message_was_sent == -1) {
>> 
>> I'll let others comment as the "blank around prompt" smells quite
>> subjective and do not want to be the sole reviewer on it.
>> 
>> Thanks, will queue.
