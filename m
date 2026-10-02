Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583F3A2544
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965270; cv=none; b=tBHS8NFiwhLwEWceZfka6s+s/6amwW0co6vUyASZc0nJ3mFbIJ3t7rUEP7sdz46aQsMdcGnnUE2fgW4/QDEHnw22pAUaj4tyMkmczbqZ6JE6WibEYDgwF+92308vuPMlONXYnfSHx7PDrz/BY3eINb9902f88SOoAZL9vQ9dmBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965270; c=relaxed/simple;
	bh=HW8T5JV7yCuvxkY7ovu2gFtz3OtTGtK+wZjVM1FL9/E=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ugXd3WZK63ShLzlvQCp+8Ygz/sQhc15KzRt9TXKtuAIkrZHhf7ersiJ2P5g4m6JovaAe2WSm/HeLi/331ddCfyRbi6oI/Od7OxfrR1vs3cXeeUaTCQX8imiF4k6xiGUCQ42NKX9lysibyOp2hhrWVFuQtCKzzydrUimqRPxp4OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=2v7YQ7dO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xWb95FuK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="2v7YQ7dO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xWb95FuK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A8E44EC03DE
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:21:07 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 02 Oct 2026 14:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790965267;
	 x=1791051667; bh=toONwHvxCk3vvNLoJ4vYRRkJrrCANG9dRGm9Xxxnjws=; b=
	2v7YQ7dO1shH7kMygHr6VY8QBKQBX6tfvTiC4lwVA89feqT60yDZiw2+KekWr2Vs
	0Qv+I8MegJ1evXYYCktXUA19a918DNML1v3r3VtTBtL0KQ4WtZ9IEJXS0CPK9irY
	fnkRAZDlJLN5WlqU066N/LD+Hf1hw8ZoXjZy0hASdIqB+nWGoWvoB+0Nz4VJeLU/
	3kQSM9mnyuX8yLq8kp6IGS9MLf2c9IPhw+xxICHFIsiXM8/ufk83qsgjCn6O7/tz
	m0krZ+J3MIuunAroi2qvQmoi5x1TZcJxOF5wpRIjWtnDc55BhrOC7Og28AXA1KvF
	fsbrPbjod36ErD3K5tN1fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790965267; x=1791051667; bh=t
	oONwHvxCk3vvNLoJ4vYRRkJrrCANG9dRGm9Xxxnjws=; b=xWb95FuKnEVveFN18
	ZmdQWnDE8I2yN0sZ1kTlRYSfyoDoEmkz3IxsH3pQek1L5gaxt8AFyG9YVHMv9+dC
	gDr4tskKVLEg2KahvjX6toXvcoLeHi95nu9iyT5P7Etd08yyqNC2+Vuz4x3n7z5j
	ytKYnHcqNED8OkgmnqqzeKown1072P9x7hj9VW6ufEDfNh2RTkD137zkUJdu1J6C
	kBKi/K7IFeNyLOnQ8paaWOO0RVimsk9+PbA6ynQGc4vFyVbKLitQ8qI9azyzvc7M
	8ujgfKhl9T9nND31WnPl8rTsdbdYHNqCoi3Asf4/bviGt8CDYueYwLOq8OQf6Hj7
	6udYQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790965267; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KF8N6GeaaWCbte8fGTH4/wqvp3fPZUCPSET7C1PGj8bkUcm
	bmHJUEo1KiojPGqaWJlqois/QDKjpHa0w5hW2pjZZm8uoi0ZnnzjQP8f8XFldSQn
	URtTMwyymd6CVzPCCVziJYaVgcVSVL3OcH4rcy58xbrVo2WS43LACDzrjKfR5OSi
	au+WLYRisWnYuJfegktEqq3JAvH7ZFUDRz6DnVAiWE1x25F54MxAlzeqQ4WX2mz6
	0WAplIP3i3FsewT8A+li3jaMlQPk3aVPeZBnX+ATFad7lFK3eJkDmMrUdkTDWxiU
	/mg9/6prFbBhC+3uTjTqIz17sxUTVL9yz2CT2hg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nQq+XMfY5LgjCl0hwbJF9lA4bnluVnTLdV4oV7FEQfI=:HW8T5JV7yCuvxkY7ovu2gFtz3OtTGtK+wZjVM1FL9/E=;
X-ME-Sender: <xms:E_a_aglSxtY7G5oz9g76xXLlGNz2gE0VnrMfce05d4tqcIZjN9l0cw>
    <xme:E_a_aqrX_-lRGbfRY9ziSVSz4v9IojAm35h8KmtuNPN6rnJfmG_4d4WYPnTQYOasX
    zgOiVWBYYvt_N7QvvH-UYn5t0rTYFmwZW2d0jlynOEI-FJqkUn4npXu>
X-ME-Proxy-Cause: dmFkZTF+b3M761Oow5mp7WIwhWj6U0c5LMr5x5PT0VG/aa+GmmvjwXbhzICDQx6n1hknag
    sGPRQiq4Wn2oW0GPyNGIJe6zZXE9iPEbeXr8vvIHWyf3OxJ9rkoFiV9tOf8aNBAVIh6PNT
    TkzGpQX1BMbv9K7FHIzWAef+MJ0oXHNDFnubAp4Y4KMee8LEFWN6p7PQrfHE/vSEtbyenA
    72odkAbV8oqbXKHldQEpadbdRxSTMbQ70x6bVv+z/8LkNyejPCHfvkPnzoh57Biy7FeE5r
    EseVaaLqk3vll7UY+MnvhUJ9RpvQ+mwA4icU7281mFXWXXVjOOkrJXQ08cjmOgnOi8sTHf
    DELvuWfRM5NKjiwWfk37EUdZeKbxrN48rN2fokAkdA7ItX1VbJlKYbwsyJC6y/pTMgZDsB
    2Ls59qmtmMW/jMICTekb1ZX3DJ8Lcaw8yY7ie2qRdVSUh3k6RK2WmrnrJ6DxyU8RyD2BlS
    0tMMXypQmeGKT3/uUHnS6WkaAxle9zQ0VRMzBwmnCGcwH0cBIHB6N6ZUDVFR20N8JDeq6/
    2Omlh7qzLpM7IbhzWAnOpkHAtkkiwZGXDt7EaiAEC9MFYKtA5LEHusT466UOC0Lk0scFPR
    tc5YBOuyQWe0BDych8lO+K5ecRShgRRZDVm9JMzEUlsgzRQlPj8b2DsCeerw
X-ME-Proxy: <xmx:E_a_anRNXZzh_3yueS7tsRBlVqJKei0jzvMiAGY7WR6yHx__aRYZRA>
    <xmx:E_a_amt7Go708owpIy0EXgJDFPW0QzcorzCqGGIJetTXmMN5QqRQpA>
    <xmx:E_a_akYsk8ayu-LVGXuQNTwGLlAzT_FK0ROml4bCFvSz685krO03Qw>
    <xmx:E_a_ajupkOg3UJupChJbafzXZ3FVZamBIS_AvRok2ciAG42lF4Kh6A>
    <xmx:E_a_anYQRtAfV5HOEacHDQ85DVaP3Je7Re3pS6G2X54a-Rhq4G2f-o1t>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8347F780070; Fri,  2 Oct 2026 14:21:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7DtHL7goc9V
Date: Fri, 02 Oct 2026 14:20:47 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <01891b4b-ce04-41aa-8065-d7b88e466dbc@app.fastmail.com>
In-Reply-To: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
Subject: Re: [PATCH] doc: don't require a SYNOPSIS in section 7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> +# assume the first line is formatted like 'gitglossary(7)'
> +my $firstline = <>;
> +$firstline =~ m/\((\d)\)/;
> +my $man_section_number = $1;
> +
>  my $last_was_section;
>  my @actual_order;
>  while (my $line = <>) {
> @@ -93,6 +98,8 @@ while (my $line = <>) {
> 
>  		for my $section (sort keys %SECTIONS) {
>  			next if !$SECTIONS{$section}->{required} or exists 
> $actual_sections{$section};
> +			# Synopsis is not required in section 7
> +			next if ($section eq "SYNOPSIS" && $man_section_number eq "7");
>  			report("has no required '$section' section!");
>  		}


I just realized that this script is actually supposed to be able to process multiple
files as command line arguments, and that this patch won't work for that.

I don't understand how Perl's `<>`  works when you pass multiple files as
command line arguments and that might be too much of a can of worms for me to
figure right now :/
