Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F23A901F
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976892; cv=none; b=DUNAzAoFSNJohWVqOJ8QLtF18pQLwYT6FDcU9pwcEEHPchfM/4fyUyO/57N0dsbThMbu3ceT2fykRDyGsz6lC4kavfDKfBTSdZ8NZ7cSQvh4lRpfW9MJL5HI1ybgSUw5u3Wb8y8AEEbQA4vWCNs9Vmb0DDGhJY8QxN3l5hiJ470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976892; c=relaxed/simple;
	bh=hsOquVGVb8k4QighAVzZZOGHYlsXyVX9G+0Xz9WUIpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rvez9cM99CCNX6G99+S7yV+LOpZt4GPN5Zr+qywXIUMHPRRXPN8+xkLWAZ22xEQi2M2pRI8uROhz5vOPX596b9OZU+Yip+s8HgBc2CQauONy9w1IA6IfeVRIfCloI7uBG9ZAES+S/w92GI+9tdTS6JAScaguV2OV+ctNK6W5KGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HQn8F/WO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGh4eA2i; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HQn8F/WO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGh4eA2i"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A4DB7A011A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:34:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 02 Oct 2026 17:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790976889; x=1791063289; bh=wpUJ6iYxMO
	el06Yhn5XzcCLecJohN8ICgun8aY0su0I=; b=HQn8F/WO9fRsci86EEkJVtTHYc
	oObVnEtF6vUMSk5iveA/PXQiLvDrEq4ttYjY1gFDJoGvB17RIzK0W8Lrc/h7HEXW
	LwNTowBEzDu/5aGS16LsYwaFo+q/JqICEhH8xx1nD0D51/t3/sk0Qa44Q35zceGP
	hqfqOlbB+jFqM0u3+euLFJWKdGGduNk0J4yk6J73qv4rFha+O+XfCj10So0Ol0vq
	dqjBTNMPSM058+TNEfY930Fq9FMRcg2IyGIi2+oDI4qUoTLKqJqCFDsken+OulSv
	jLIIAs6PtFF/8/7AHQanH6aYx7cADoFsizzNzVG+sFGOIhZKos9jL7ph1LVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790976889; x=1791063289; bh=wpUJ6iYxMOel06Yhn5XzcCLecJohN8ICgun
	8aY0su0I=; b=GGh4eA2infHY9jSNwTOSK1uOoa0tESr3Cubx1hY+Dt1HFEIjQcA
	wupcus2MhjwKd9PrNXHIZrKcG/fZYpgIZJI7K2y4xQ434dhj1rjV285z7Y3DOdZH
	6OGMdBvUvEW3Ims4w7gzhzyj+X9SfW7k4+iefxa1H0RafKhMGq5vlsb2lE6YGIBo
	Wv5LhBa7W7xQu7q0Fc5IUF7zvBQN9NH6uld1/p/wEL2LbluHgu9C9Jikvi8EP1Mj
	OLCfpfNbYDtOvexbMepR7jwf2TG+0rt70/+kRHfFVX6hj777nvr/WOsxFuQRVjFw
	c0oMsh70Nxh80jRuy/9yB2EN0oG28+3sy5A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790976889; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ei4ErpmUIv/uO/EYEIhWG0ydrs9UPELNdGvujEfhvAWr/Ko
	TMl2J6KcS4zYgBHiHAZm7iTyGJ0V5aOOW9WtIu3btpvNENLs4cCIFVTATxO+Vscg
	ifuw4sLFHGbPtlniykNwjAOMOEK6bvfOgbOR80I4hfqmoOS4PKdEkIe8+lGIzNjl
	8TFJtqqFYtxkaQgjNy4xKXCJlZs29FNCFiNWAlokOxtyFXbrjt6LyBvL1J70iqCO
	0aQHgueZoBuKXiFBjVVswPKPKqXFioWs/3dmtZFHV7KqdP/QFdT/JyodBDzW2V4s
	6kf6Us8K2T3F7Xwsjr0ijtamYLRzvra8MZrUTIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZuMyrwGSW1K4mrxu5VpPirbhz2ZN0rJD6j0DjH9b/Es=:hsOquVGVb8k4QighAVzZZOGHYlsXyVX9G+0Xz9WUIpg=;
X-ME-Sender: <xms:eSPAaha6TQOVeWbqOA8pgpXCYrkv_iS8xCia4exMkSgo4G4uSCqbzw>
    <xme:eSPAava_vkCpUYjswgtSCH4zS2AeSKJQJGpZvn6X6sxJwahQr0IcFmU5alf1rcnIC
    FUWkmxakK5Wn5tLfafDlSKSLgViX2imvqfDU9ptoLTff1w5SK9P4plz>
X-ME-Received: <xmr:eSPAao_NYKrhRCZGgAu0JXc0vSBXw94rRaaQv8qhjvVyrr2S8dah9_VEalNaMJStfyXFmYjgWsDT35zcxYCLSJo854Fr38TOggI1>
X-ME-Proxy-Cause: dmFkZTGGVSlFidHrElH6kF7BlFN5sClCJrfVEi0X6o2YeY4ZMMLEY6H2cdDaehnkBO9d3x
    TExk2cPZvwiUtnfRDKXAOfMNj8gYaUj2Gq7AxcRMdxT+saPNGYlJ5el7J5g7TKWks+1FIi
    X2MUqqskdN38OXu1XVrrBqGk7uWkd1w+Q4MUjpBVS/j8FK2agfNq49Rj+8Vf0OKVLDO8Zd
    3C4l89NhzoZCI6JsKfW0NGxBL1WQQJdndVlWbO9Tbb4emznNOVv4ZSFYqz/d09NIp0kmSu
    CM5NNjXe5VNixHmbGhuenbSdjd3Irf4SWS8mSRcnNjgXnAD6Ri96EMAyoZ081Ao8X9gdII
    JogCM/Fys6yaZ8jCVa/PcGpEE43r8oRk7wCX5atip+0ctWtMb5cBBqaVXzhjnYd0bV1AU+
    n3o9Twj9M+rUpJ+EiuyENMar3haXbuUpK1do3I+JSLyj7zesVOn5NklGxz8v9fh01E0SiY
    x4uKlmMzQSiKXYdb462uyNX/LbYCn5w0AMaBZJ3gHyB4Lwvdag/5c7bbmQPBPS7Wf4VsBA
    nCq1EK/7H4S1EVw8DfbB7qHShFS33OrY0ACWk7BJNRzlktTjMXUBoUxLbvqW8dFvorVu0o
    zt54Z4S01H0QQ+3u/WQDcVzexmYB5elSr6XTtI4bfyLIrwUXnyXr3EWuAVgQ
X-ME-Proxy: <xmx:eSPAaugN2t5rp_vFn-cbOZffDMeqyF1R8bMnZzGBIFg2lNsU637m_w>
    <xmx:eSPAaoeRd3p742J2uCDhuPkgCGy2N5o6MoAdNizucr-T9pTQVT79Ww>
    <xmx:eSPAalqOshrh0MeTybNrrWcRdP8UVDzOIp5CFNDBUiH-kEPuZDK9hw>
    <xmx:eSPAatCLzpiI5QGoeDRl92xXgSSqVQDEVvdICOg8GTQKmRAwlp3VzA>
    <xmx:eSPAaofcB3QiqLbfEaJSGs3iIJm9MfKeVhZBmbajFD4m8eqT1JCAE2yw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 17:34:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] doc: don't require a SYNOPSIS in section 7
In-Reply-To: <01891b4b-ce04-41aa-8065-d7b88e466dbc@app.fastmail.com> (Julia
	Evans's message of "Fri, 02 Oct 2026 14:20:47 -0400")
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
	<01891b4b-ce04-41aa-8065-d7b88e466dbc@app.fastmail.com>
Date: Fri, 02 Oct 2026 14:34:48 -0700
Message-ID: <xmqqo6dbvlaf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> +# assume the first line is formatted like 'gitglossary(7)'
>> +my $firstline = <>;
>> +$firstline =~ m/\((\d)\)/;
>> +my $man_section_number = $1;
>> +
>>  my $last_was_section;
>>  my @actual_order;
>>  while (my $line = <>) {
>> @@ -93,6 +98,8 @@ while (my $line = <>) {
>> 
>>  		for my $section (sort keys %SECTIONS) {
>>  			next if !$SECTIONS{$section}->{required} or exists 
>> $actual_sections{$section};
>> +			# Synopsis is not required in section 7
>> +			next if ($section eq "SYNOPSIS" && $man_section_number eq "7");
>>  			report("has no required '$section' section!");
>>  		}
>
>
> I just realized that this script is actually supposed to be able to process multiple
> files as command line arguments, and that this patch won't work for that.

Yeah, your version would then notice only the first line of the
first file, and my update would also do the same.

You can work from what I gave you and inside the "eof" part of the
loop reset the %SECTIONS back to the original (which means you'd
need to keep a separate copy of the original) and also reset the
"did I tweak the %SECTIONS thing already?  have I handled the first
line of the current file?" variable.

> I don't understand how Perl's `<>`  works when you pass multiple files as
> command line arguments and that might be too much of a can of worms for me to
> figure right now :/

"man perlfunc" section on "eof" has an example to show what to
detect and reset when you reached the end of each file within a
"while (<>)" loop.

               # reset line numbering on each input file
               while (<>) {
                   next if /^\s*#/;  # skip comments
                   print "$.\t$_";
               } continue {
                   close ARGV if eof;  # Not eof()!
               }

The explicit "close ARGV if eof;" is how the example resets the
$. counter (which by default counts all the lines coming from <>
across multiple files).

