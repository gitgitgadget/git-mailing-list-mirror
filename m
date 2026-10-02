Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB7233149
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964632; cv=none; b=G/FYNBj9XvZb2lp+S2vQeP4KsSuqFi2jvPDVgLCiNP52o9iHvhfVNu/PCTwh/9v7OO/SrRS8wuovtHT2mxftTtAq7+8bj+Vb/FdTvFZ5xeyd2xqWTa+XA97HXCCKIbF98iobvLD2RLdXvvcgAbb375qQTdyo7MULRtaoZPP8h0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964632; c=relaxed/simple;
	bh=ppyYkSIhaZSyFIxANJIBhQPoeOXzQsOGmbP13ahM0Bk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NABh0uUxasd0c9RlPdByDYOPttICCT7kMMqnsb6A79YexZHqVvTErgR6ZpDPFCahzDvxugMfd1v2bAAKd18jQ3ggwIHgiDoYzluF732DjsZ4URBQpmugYDtR+FbOMnb+jMZwgOMmIuyBeTrlPvNqQId21EZtIqU3v2xMfvJl4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=GmTh05Hi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ANEllL3p; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="GmTh05Hi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ANEllL3p"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06CF51400172
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:10:30 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 02 Oct 2026 14:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790964629;
	 x=1791051029; bh=KFRRyzpY3lFxM0ZWdzWKctRhhAC1oRR0LzNUETlLTUo=; b=
	GmTh05HiWoLqHimt4+yYKPzkfJXs1L0PmLu0jznnxy5La4YHP1lFHqXEdVXnFzmC
	kFNHigTj5cgmD2mLgVjTh9kAqfRmp6uo6ray0M3kM7FRSFGSg0c+ECvYEfa+3XhC
	HVh51tLcdeLsmwch4LG3eKug4b0rf4M72S+4VpkEjMY9+Y8WbXkVwZ5wQv9aH1mu
	DZIbdOuUWYndS3nfM8isxz7wm3lXpS97nkvu3suIpvZnUwjVt9skqM0QhboDsjOC
	vJwEggbtXtKHYIL7zrDIW+m28boFjeHzxwX/n8xSEcW8/duN3IuAK7rEu3B8Zega
	wo6bxB6mfBFAETAiabXneA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790964629; x=
	1791051029; bh=KFRRyzpY3lFxM0ZWdzWKctRhhAC1oRR0LzNUETlLTUo=; b=A
	NEllL3pK2CIWF16QLDgkAIgR/SJhLvjsF5cKAIM78hkvYTMqyxarbkpIsUdwBFeb
	0DaEa5RnLvJlqxFDy9X6CnkOJv79oePnAXeWoHRuyNuVsAAIhLNHSIJ5ZDcNrpyB
	fOO/npPXqIJwIc9yKIeAYLWDUdGVkmHglXYQLu7114Xxnykq9cvfW9R+nytjhtCS
	8LN8wU4m6VNg5Ef+UvMvrvZe3I9+oVIbk0a/+TsxAy3WLFq3ewMEIIm2pOxt08vY
	on7emNu66Im3A5Fl5ZV4eW5g9P76M84xZekvzLm9PffmIT3EU5X2NiY5RwVAbczZ
	6vRkONxleRTKgzpdRBUcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790964629; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YydlLLIobqy42VpaVNAJvArQzYr1Fz8fvyDxmsMKWewYUTY
	o786t0t9HCDKxppBLGLv88Hwy1SoAgWTl77xaUtsifstUVA6R0fg3RhEqSyyE3DK
	bF3YqZzK14+iUAYaiBIsd+1jGqFU0mTSpK3ioUDzaWmXjpujehX5b/y8OEneBabJ
	RT2wNpaOg0I4BlSDuYPEe0ztZN9MhFwr1GBtVYiFn9OV4w0fAKVMuK4dru+/cN5g
	zGEnOWUQFZnSD5TV6/RNGubfuaWqWYDtLHkzBcFrv4fSHrCNacYeLBHrnLvEj4rS
	kf/JwWiHCLBuxOP1Mrr/AgEYgt7UcrSPZsvHCUQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XIdzea9oVxDZ7hKd1Mjl+V1IwPshiHIrzpJvd9LzO2I=:ppyYkSIhaZSyFIxANJIBhQPoeOXzQsOGmbP13ahM0Bk=;
X-ME-Sender: <xms:lfO_ajZDBOsTV34shWLEkl0t-3K08fKo3HhEa8svKRIked-cs0kl8Q>
    <xme:lfO_atP1iYrchwumiZJtgVOh7wSX2lzXLUztM-uP3-dG6_LkIoJLb8O5Fl4W9Qs_q
    8M2_QQt1FBZr2ESWcWMt-_-T-6YU6J5-JCvF-YA1cXyR9attqRKcqUs>
X-ME-Proxy-Cause: dmFkZTFHcGHdXylEc3vllYlurnWaGcgPxQWdysH4bNiBlzWHcf9nDTdaRQQIaE0vD2/BAr
    ja0zk1lwKnetyY+NuW/pDpq3Rjqdy4zsjri45LP7GiCHpcsVjhHAYaRwfTmSl+1NGmnJ+7
    Qqp6v1VQEcXvvYpcSRsLGe3b8FB9SfKZ7R0EYR/H1Afgam9TYt9VnrqqTH4AHy9/Fyf+J0
    J6B27R7QMDYMgEug80CEs9OXXul/mo7YqatOB/PA1yaul3MyimJpzcl5mUPOgxkHwqvC7c
    BhEAMRfMEiDnYRlgZLdDMHlxOHLhouDAHc9r++Oq2v1EnXsAzawFqdDRxZ7GMZK5PMgAH5
    NPgE+rMZ7MkM0KFeoGC+bLzkv6ae2sgjWGf3EvJyIV9qZO2pGCWOd9T5UAGm+K30kmRJzw
    TStj14cK6+usalkQC7Q2Y42FctxBnsNG2kXI74cBlMmetzf20MuAGf2u0jbRMTDZkDhwEq
    buqJQv00lyvVMDRv7vYwPz/kMZZiaWpGA5wwbqGpBLygFfiveOl/wY2XkaAxyThCAI+0uX
    qFpPp0LwMHHLyE4SYJmqEVHjA5R+FWSTSNKYEVZ+OKUjKPV18fRI7k1HXGVtoHfPXzTMmi
    XPvsiXiccVz45jaWuHOAa1ne7CTZ1MMXYEzgexa9OOM+eD8tiSs8iGOBd2Vw
X-ME-Proxy: <xmx:lfO_al10mZ1b0s1GWhyZZY3S1b02gGreOsWdjiM_Kreuvs7TpxFngw>
    <xmx:lfO_aj2daM0Vv9dwRY72HBN_nzN0fq5c1qcdQd-AJdA7u53hxaGYlg>
    <xmx:lfO_ao88bbdDfh4y8xvu9IZug8-XmzjnrpfK8VKsyjsHnAVdKuzJtw>
    <xmx:lfO_ag3EUB4tqsqRsVbuF6ATuyLlBX1w3Z-9opd5VwNTGXXQg7FWFA>
    <xmx:lfO_auWpOCje5QHFvsZ8PqvkEOP53Fp9p_m3xqmrc1IfzMTSweBqHOtU>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B6F47780070; Fri,  2 Oct 2026 14:10:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7DtHL7goc9V
Date: Fri, 02 Oct 2026 14:10:09 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <bdc1fd67-83dd-4c66-9afe-7f35c572afa3@app.fastmail.com>
In-Reply-To: <xmqq7bk0vv38.fsf@gitster.g>
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
 <xmqqv77kvwgr.fsf@gitster.g> <xmqq7bk0vv38.fsf@gitster.g>
Subject: Re: [PATCH] doc: don't require a SYNOPSIS in section 7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 2, 2026, at 2:03 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> diff --git c/Documentation/lint-man-section-order.perl w/Documentation/lint-man-section-order.perl
>> index 02408a0062..ce60c34809 100755
>> --- c/Documentation/lint-man-section-order.perl
>> +++ w/Documentation/lint-man-section-order.perl
>> @@ -55,8 +55,23 @@ sub report {
>>  
>>  my $last_was_section;
>>  my @actual_order;
>> +my $section_tweak_done;
>>  while (my $line = <>) {
>>  	chomp $line;
>> +
>> +	if (!$section_tweak_done) {
>> +		# assume the first line is formatted like 'gitglossary(7)'
>> +		my $firstline = <>;
>
> Ah, this was obviously buggy.  Not <>, but we should use $line here.
>
>> +		$firstline =~ m/\((\d)\)/;
>> +		my $man_section_number = $1;
>> +
>> +		if ($man_section_number == "7") {
>> +			# section 7 usually do not have SYNOPSIS
>> +			$SECTIONS{SYNOPSIS}{required} = 0;
>> +		}
>> +		$section_tweak_done = 1;
>> +	}
>> +
>>  	if ($line =~ $SECTION_RX) {
>>  		push @actual_order => $line;
>>  		$last_was_section = 1;

I'm happy with whichever version of the script you think is easiest to maintain.
I saw that perl also has Tie::File built in which lets you just treat the file as an
array instead of worrying about <>. https://metacpan.org/pod/Tie::File
