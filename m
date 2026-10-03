Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F273F5BC3
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791027554; cv=none; b=O10Lvvc83NXRvCkZlxGQarFKAV5G3zdtFzg1RNZrbisVBy5Kz9ErDJtnEf//27FyFtNq0v5wSIePWyeBqGk+hHs1kkQw7mzAj9601Sv0pTAamcLzb/tGQHeVoDdR2Yao0H1qoUmBhBVHzyXPQPMbMky3uQhGsOW46H8INUN21wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791027554; c=relaxed/simple;
	bh=uqtYU9mfqtJgz/4pNjxz+Rhqv5R9yIsIJ+ap+gS1CCc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h16c/kTFhbm1VAvmhBWR1H752+Ei05HuDnSTjntVgoCApcZ821wuh3yJ4QeLJrXmpK7cmh9ZB9TigSF8Bqz9ZMkMNb7ACKuNsTuBKNDUUTu0TIESvRy1actUl+Icuo1hURnWRn9bJPk+975M2mFXSPrA7M3JaeG8HRe5OTFylNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=tKIEZsQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kN3zLeEv; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="tKIEZsQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kN3zLeEv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A78D37A01A8
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 07:39:11 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Sat, 03 Oct 2026 07:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791027551;
	 x=1791113951; bh=6qliTWQcPam0DmcSRIy9wlgBiVs2l5HtuqCBd9qjVIw=; b=
	tKIEZsQXMNVDggURafhBk98mPQh4IARJBDx6y9cwJ3Vk82EhAimFL+Z8fuKuCCAz
	0U2Hfpj/7eZ3xJm0P1ISD3Ycy0xdagDforFraZh2VT+F9h6Nc+j/RPCTA5oaKzek
	Q4zbENs3ZntqsjKz3FaWlzzQ4mMXDQUKZ30sJzw8uE5gY5R+BpDw4+ahZbzMPRIR
	d+6bk+i2YgqZ8sqWexjfkHYtJoBDjsm+qCvS+fagZHwED7nOmb+ZkT6gedhZO9d+
	4lVxKjssVxgk6E0fu5XoS78IV2/J4VOpcRF5dcGiu4uzybh7iEkFovye/SfSjhWY
	sa/HXtzNud3LtR2CJbhTSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791027551; x=
	1791113951; bh=6qliTWQcPam0DmcSRIy9wlgBiVs2l5HtuqCBd9qjVIw=; b=k
	N3zLeEvMl69/4Xv1+UaS+ih4fJdjjc9vGMorrKqjKDRL+uvsMA1I+PH2ltaRX6ka
	CuV6t+LtGEA3lHq77dlwOOKpBrVYWgM9tERQz0rgCwRveoF/jkiTxNGiy/T8UNxE
	YVYiFS409q7rU3vGfmJkBfHz0qRsXyWz6hsngKIhW6maUc6wizIUMVpOonzFKIGt
	QxHB7xclZdGuWwNN/diPEt1RH7Q6Tjp4jxxw/t1XT+MIFk+NqVoRuo/Bp2r0Nn9K
	mD6s0N7FupooJVHwsGt/t0H7CScP6t43xBTJoZCyBrLgfvMxIE44nLBJP+FgScXB
	kSA5NuFMyeIxTQXg9Zg4Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791027551; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IV88X/7YxkRK30P6N1OvifFYkd6nMrchZt2e2DDmDJ+gMUN
	420NsMP/qbRKMNbbRHdGN8d/N73NjX+m/ZauryTaK5fSo1oDmL4ccZk/Sso84eSv
	wyotvEtqDYojQRkGboa0aSZ4CCwxf8Gcnncb9jqAs2iy5s20v8Mki+iWF6x1jCUv
	5x6PT4wMbTEkDLJLb4PVh7a56VQjRLigMtcmLw4R0LJFQBn/PIERkm5xy5pF7GwU
	BGbhlCCvECLq6xhWmappoIB50OKdTS0QVX3/K8Lnptv6k4776pf9/XF5lqdyjpsZ
	VBYX8EVR4f1hC1IF/m6ey6RCE/pKJks5TnoDj2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:05xyMfkC0fU/wrWaYcJPc898MWB2qY3kIpNVy2mKzVE=:uqtYU9mfqtJgz/4pNjxz+Rhqv5R9yIsIJ+ap+gS1CCc=;
X-ME-Sender: <xms:XunAaiX0T_uik5OtGKHRAJV9QN8TCvKs8BgF2Y8LqnQebN_l8PfePg>
    <xme:XunAapYFD9q70NhcHZjgyR-Kh8QboPt3_xOwwthgTOYusH4NBBVEROEyObtiJNxsW
    r4Zr8xBahoGSVVmGQdMEgVwzbcTttRSV1u8NNrRn8S5y8ET2qPg2m8E>
X-ME-Proxy-Cause: dmFkZTEnt+R0FLSQ2tpM5SarBG4eJds0lgcvScikmK2OltE30dF1YFljk+RbwzDIqL79RA
    OJNv1hI+rMjCU8pjvMjI+4kQm+46NYxc86pJ06SlWOEIiErwZAxdWJE0kB80hxnzgbiaFv
    7eG6SVyiS6mzaobOlm5AZKri4n2X4Llyn3pAOlkeMqINIWwlZY0ZIO396ZsDwa5Gg6S1ze
    PK4VCBfeF11YIau9MfdGGA5koN+OEztteagB5zL+UyUA2UCCb8yk+tfkV+hZztEY/3dBEm
    nx5grmQvc60YytA/ta1p952n0nAiRo85YYNuJy2SiH6hD/ftf6pev8wGzXWMgUqdvBK/Oh
    uza5f9YjL3oJzciLgPnBYs+gRq7vupw7cvbKQ9r8mEJJu1CyA0tLMRCuwtGTCCAsEpNw0/
    MJ1qfH6H28swTxmEYPEHxhehownoC9CR2X0st2pYMpW9UAn0n/UaNiZJrP7qTO1vFXBbLz
    y8Zj9p1XXv+4JQ61JMbW/DNI5gdfGZBhc7xWCDDa5Nnybi0ECJLUd6btLxO4wGHXJuackt
    5JhVAqSSU3wnHpNKHKH3yb1LPBtIZqqzjNaZ5gSSXQb95lg7CNeiag9xBoFhwFT6PfSHM4
    1b5nSZH/IkGFRYKbH5gRbjWDpwnLg8nvMq+rzGurh6Zpi8AUmXtadENR8M2Q
X-ME-Proxy: <xmx:XunAav-P1COm0Mwq9TAYH6gHjaWhLj_d5jb6lPC7i5i875HqylFNfA>
    <xmx:XunAaph3FPXe5Iv1ZWFT8sqOR4pGG0vxpqUf0xsNTzchI7CBd2fsjw>
    <xmx:XunAanexinqT04CfiTVnDdgt8lJLcr8tLqhjoEkUBcK_Pr4jVhXlWw>
    <xmx:XunAaorHyOJT4Aptn4BEabzpEAjiBVt9h4Mk5wQ33CL5obt9wvA3vQ>
    <xmx:X-nAau-HBKPtERuiKG4njkLlKctp4OCHAybys04Vzp2NqQgKEvP5OGl3>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BA860780070; Sat,  3 Oct 2026 07:39:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7DtHL7goc9V
Date: Sat, 03 Oct 2026 07:37:00 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Tuomas Ahola" <taahol@utu.fi>, "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <79451beb-15c4-42f3-92fe-1b7fd284b21c@app.fastmail.com>
In-Reply-To: <20261003073303.G-Gck%taahol@utu.fi>
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
 <01891b4b-ce04-41aa-8065-d7b88e466dbc@app.fastmail.com>
 <xmqqo6dbvlaf.fsf@gitster.g> <20261003073303.G-Gck%taahol@utu.fi>
Subject: Re: [PATCH] doc: don't require a SYNOPSIS in section 7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Something slightly more declarative I managed to hack up:
>
> diff --git a/Documentation/lint-man-section-order.perl 
> b/Documentation/lint-man-section-order.perl
> index 02408a0062..160c65e1be 100755
> --- a/Documentation/lint-man-section-order.perl
> +++ b/Documentation/lint-man-section-order.perl
> @@ -13,6 +13,9 @@
>  		},
>  		'SYNOPSIS' => {
>  			required => 1,
> +			optional_in_man_sections => {
> +				'7' => 1,
> +			},
>  			order => $order++,
>  		},
>  		'DESCRIPTION' => {
> @@ -53,10 +56,18 @@ sub report {
>  	$exit_code = 1;
>  }
> 
> +my $man_section_number;
>  my $last_was_section;
>  my @actual_order;
>  while (my $line = <>) {
>  	chomp $line;
> +
> +	if ($. == 1) {
> +		# assume the first line is formatted like 'gitglossary(7)'
> +		$line =~ m/\((\d)\)/;
> +		$man_section_number = $1;
> +	}
> +
>  	if ($line =~ $SECTION_RX) {
>  		push @actual_order => $line;
>  		$last_was_section = 1;
> @@ -92,7 +103,9 @@ sub report {
>  		@actual_sections{@actual_order} = ();
> 
>  		for my $section (sort keys %SECTIONS) {
> -			next if !$SECTIONS{$section}->{required} or exists 
> $actual_sections{$section};
> +			next if !$SECTIONS{$section}->{required} or
> +				$SECTIONS{$section}->{optional_in_man_sections}->{$man_section_number} 
> or
> +				exists $actual_sections{$section};
>  			report("has no required '$section' section!");
>  		}

This looks great! Will use for v2 and mark you as a coauthor, thank you :D
(let me know if there's a better way to do that also, still learning the process)

I wasn't sure what `$.` was before but this makes it clear that it's the current
line number (and https://perldoc.perl.org/perlvar agrees). Apparently
`$ARGV` is the name of the current file. (different from @ARGV)
