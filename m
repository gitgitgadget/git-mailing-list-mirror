Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925F3B83EF
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791285481; cv=none; b=gJoj4/1wJIhP0rPmPxzKcJvEnSUFQ4cmoGivwMBqP7jZ/Q6aCL6Yqgql9bVtBBw1JMWSP1LvXbUpi5+napPnT3er8fojI62cfy47XP+qCsZ2DsqSvV7bEreqcQQ75f45BrUWPUlKUyEiys3sGaUnCOT+guF1Dn/BpkBukVFkjWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791285481; c=relaxed/simple;
	bh=n3isS5TZg8zRXd9Nw3ncpX6FAO8a+gh4YaJZZt+W79Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OkhKseerRakEgLiArp+x4WiXpdlci+uohzpW0rgtkv0AZ+C9ZqHU20oXcHEtyXhzTBt3u8kSjR8G+xgbyKR1GIKRpnF+BJStRL8gIWqG/3JkRZdQKFqEQXVLxyz3d1JRx1yYEzyv2IiewI0tHIVTp6daYSCqYgD7ZzEDk7VebY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=UKw8ruFd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tRUog2Xj; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="UKw8ruFd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tRUog2Xj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D6C21D00156
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 07:17:58 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 06 Oct 2026 07:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791285477;
	 x=1791371877; bh=2geDUkbvpZNHTbiaMZIriWAWtjylBwJP02dNk5IXlSQ=; b=
	UKw8ruFd0ylt6RCB7rwSk7E3+EctiHTHW1ZPULHDIB0mOtqXZN4iQen2opIaNIW7
	YIBFLT32G+rWnUSiaDJ8q5V/Y7J6QwrnjK0/qpame4pRVbXxECAaID5vkYj2KXaO
	NrCwOgz6AnDu8cktNc3ZMohtE1xc6vWuJEEosymqZOcwq+/fiuoU2UKnMBLYZAJU
	/snI0H1zrUbNebuSjNYGMhfcGSO78FK5Px4AI1i02xa4qjBbiRiN6Z17RBr691aG
	NhMuRm7nfymLHn9Qb+E0Dz3ykWzTnTSoinKXj+4BgBDtHGprSrGsHQ71PJzdf/Z0
	Pd+Zap33l/WARFQrv+KIEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791285477; x=
	1791371877; bh=2geDUkbvpZNHTbiaMZIriWAWtjylBwJP02dNk5IXlSQ=; b=t
	RUog2XjHH+oBMjiyyhH0CxvP3bd7S8hH1a/rLTyD+bxUvC5WLBCS7QifRmH+/uyI
	W4pOhTInQxLsOri1VvCZdrInH8JpdEjJ836FBfURfrQ70m/dFc+FAzpV7CUwQZay
	lmAXw3qoYDiMMHMnt3MPyI/7DZdXWTlo7XIPpoyP2W2Ed243y1yT++Pl2OjI/Qj3
	SGf4Me3qgxxGK+oPFckMes4SXWT7LVzPOnc+P0DmZ48+HMNuA8zD84VobIW5/gQF
	ZetpOIk6FSw5SzU3HxFD9orWH0BXd0tmV8ZCEIExEIEHKpYAXCDr75vkdtijrv1S
	6e1n8klx/JGUXddvhz9dA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791285477; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Qn2NuK42u5N+wAUbvo8RJ2/E9ewf4uayZsLEHGrXlkVDjb6
	cCJndnJHI1Je3nwH1pdCp0KcMztuhCiEQ3fIX6trd2j/PEFR0LmBVemrpQ1sPtmU
	/o4WU44QBAocTS2o4xXvveqb/Sf+PFnkKaC3Ma5XJTnxTtckEAH9tRssPpiRI+cv
	KdfC5K0/oKo8UdnnbXURVwJaJMISpS9ACdLbwcT6e6sLgIlYWqLiwFG+TVt3fhnE
	BZqxFDNTWWfXHyatc9jUlhGd6XkXeHgBBFplO7l1+nCPtmNu0NMz3NmMNEeyPF0G
	Dj0xi47wBDxgt781ZAsBLwxFNLsALSKpm08qZiQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9No0hjLq2+WBm01FCTi676kOFunwMpkWZ1eIvHsnQBo=:n3isS5TZg8zRXd9Nw3ncpX6FAO8a+gh4YaJZZt+W79Q=;
X-ME-Sender: <xms:5djEatV1gA5WAt3bdtOWscAi2vpVsntqOaBCGIkjn4_FSwoMQ-VRRw>
    <xme:5djEaoZdesi3HTKcHaiSv3vptiMuSix_psE_pboMDJNERBweHG6SosLzJGnpNGIzr
    ORW8TwPyK7U_Y6DRbc-Nz7iYDfLSpTLcY_UGhtxQV2F25oiGnfGaaFH>
X-ME-Proxy-Cause: dmFkZTE7c5ihfHKv5WhyOqs5OZu39hhCiQLK+U1tDl+KuEDFqLUifYW9CTomDRcJ3EDJFQ
    4DpBY8FRGY/wP+TNH8dynJa1PCdq6lAXZVUPccLN4M85cbF1VjAYO8HqtbCR0ueOERb2IN
    nQwW13mSBZQuE7kCdHVEzfLzEvTWb8mQ/jCba/CRMgxaVjfT3w23mDApNg5J0lUVtPM0l0
    Zg0J4/ci1LJojoH54Tx2uUrp4rrGVyPUoIsVu66Bijx3igFaCTBjsdyyrNivffBl144iOD
    riy0UQaQ4kjGrHkeUmkTk4liHrf7UuZ6CyuWlYl55P+HanL6ElyLmax5UQaAEyItQTGube
    65SVOVCSGGgYBVX4t83UliqdTd5squi77c7/zwf/mf0/EICOAg44FlVyLsvuJIzM6hTwig
    wqfKNF5qpchm9UfzGwS8iG2OVRKBlGqAtOKirMT30LIBTjfTqwUHL40aYz1j1SZSJkir6p
    5+sDJ15CdDX01ekqRhyw+vJockhOT/sJ96CRoSzOu1An37e4o8tJftLxIsWydMtNcIB9HJ
    2swteP3gJ+rVWBAcwYyrDZ9NgDTkkrAKqXvVzINCqrZjB/5Ia3KECd4f6GX+LuHwHupO9j
    swgHT+TiX743UXOrGguUbr5/WAElO2QbmXZF7M1cK7nI0E5g1YSl0n45DlsQ
X-ME-Proxy: <xmx:5djEaq9uVuk_FaBKwszVI1cC25Xm6G1gl60nUi0wdii4tJ3bIthZtg>
    <xmx:5djEaohosqVlxQp5dwVHFRg7zzicd4dWIoaYYZx81hQeMn8YBpltzQ>
    <xmx:5djEaqfngdF5avgZfnEej8nhVheveHoMC_QjuGbMKM6xy9F-hdZWIQ>
    <xmx:5djEavr5-ZixJq3XTE2AwmzHa3JKlfpHnjtR5zsW_S-OTO7h_rXWgw>
    <xmx:5djEat_jc3OYe_Ne46qgOwxjY1Mxgp5bXAs-iSeIrG9Bx5NwQqfunqkb>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8A4C4780075; Tue,  6 Oct 2026 07:17:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7DtHL7goc9V
Date: Tue, 06 Oct 2026 07:17:36 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Tuomas Ahola" <taahol@utu.fi>
Message-Id: <afb72458-bc22-4a7a-87ec-83c77e83aeaf@app.fastmail.com>
In-Reply-To: <xmqqece5vc48.fsf@gitster.g>
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
 <pull.2246.v2.git.1791033057232.gitgitgadget@gmail.com>
 <xmqqece5vc48.fsf@gitster.g>
Subject: Re: [PATCH v2] doc: don't require a SYNOPSIS in section 7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Oct 4, 2026, at 9:17 AM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>     Changes in v2: Tuomas rewrote the Perl script changes to be both more
>>     declarative and and more correct. Previously it didn't work if there
>>     were multiple files passed on the command line.
>
>> diff --git a/Documentation/lint-man-section-order.perl b/Documentation/lint-man-section-order.perl
>> index 02408a0062..160c65e1be 100755
>> --- a/Documentation/lint-man-section-order.perl
>> +++ b/Documentation/lint-man-section-order.perl
>> @@ -13,6 +13,9 @@ my %SECTIONS;
>>  		},
>>  		'SYNOPSIS' => {
>>  			required => 1,
>> +			optional_in_man_sections => {
>> +				'7' => 1,
>> +			},
>>  			order => $order++,
>>  		},
>>  		'DESCRIPTION' => {
>> @@ -53,10 +56,18 @@ sub report {
>>  	$exit_code = 1;
>>  }
>>  
>> +my $man_section_number;
>>  my $last_was_section;
>>  my @actual_order;
>>  while (my $line = <>) {
>>  	chomp $line;
>> +
>> +	if ($. == 1) {
>
> OK, this, together with the explicit "close ARGV" later in
> postcontext upon seeing eof, lets us do a "special" thing on the
> first line.
>
>
> I think for the purpose of "doc lint", this implementation is good
> enough, especially with documented "assumption".
>
> If we wanted to shoot for a bit more robustness, on the other hand,
> we would want to handle when $1 is left undef ...
>
>> +		# assume the first line is formatted like 'gitglossary(7)'
>> +		$line =~ m/\((\d)\)/;
>> +		$man_section_number = $1;
>
> ... here.  Perhaps like
>
> 	$man_section_number = ($line =~ /\((\d)\)/) ? $1 : "0";

Or maybe like

   `$line =~ m/\((\d)\)/ or report("first line should look like `somename(1)`");`

or some similar error message
