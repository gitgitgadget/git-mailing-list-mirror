Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA7F1A704B
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119854; cv=none; b=jJWalEZAaQ+o5DTvYlHaBB2+bJ9mSahG6lETLDKdf3vbVL9KbiAdb0irR9EjZwgJ/a+UcubTjeT3L1ICgCacPYKnNYjPaeXPT/6QzBZnBHGtm6SyQkbmieVMQ5Xt6WeiIKnsghbnTgiEygOcOAdF6xsM0TD9ptm4ym8p5d8xhEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119854; c=relaxed/simple;
	bh=5Btm6tcQhA9kwfTE3UJV7mfnShKBIFqXlpagWqFCumQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TWV6euL953eMtC1WimdlPQRTA8lmhCtnwoyzfM9kJwMO5VJFN2BOG8BlIlPVyXOgZ71aCkND9yC4ttyGBDTPdLoAhrQhtM+sXFBpxow3U3w6x87VsteXDx0DWkfgfOgtvTUGyCEft8LXtPaAeJ7dG8evUd7m35SHjOnit0o64w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OBwZEqFC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EoID2+Jj; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OBwZEqFC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EoID2+Jj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E415C1D0011D
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 09:17:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 04 Oct 2026 09:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791119850; x=1791206250; bh=1jVN+WzqT3
	BJfpoww+VLelGzb1DZPptOgoEPdv3WDY0=; b=OBwZEqFCAMnLJqjHAOt5qwzDax
	B1KHixdsH20Wlju2yE20wGVizbDybrpItxVJsouScCQoEvWf86QMce1ruNXvvvQK
	FLvp8PTbq8c2YZKAHWIo+FY5OUMBhoZOjNjwkXcZ4g8b2JwsBL2gHDJhKEY8MC7R
	iCwRAFYiN35Oe7atCtWP2OwlTKKjaBtFT5ok489GPrH0ZxKcmMOq8qeLQ2sbVQRE
	p4EGcN547hd/Y6zbCY6aisOqzX2Ydobe7kBciSdX18MVZrocCV0XJHrsRBiCx0FA
	VJUguMR+OtkdzqZc6/9reJbyN1kl6WSOgaxwgBr2Qn4hXC8v3TdoVkOTUraw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791119850; x=1791206250; bh=1jVN+WzqT3BJfpoww+VLelGzb1DZPptOgoE
	Pdv3WDY0=; b=EoID2+JjOuL2jw6j0NDbV/Zn54YUs89v9Tj+D3EMnL/jwsMJVpA
	RCnxLoLYnpYaA98Che8OZVYAP9G4rERzxlLUdwftCPqER+thaW037RipCiJYs/qe
	5PvtZXRdeMdOkSQ9EsevhMiQDfJQUO5ymgHmN/ecuMkXn3vG7APTzs6bSbetyKS8
	8Vkyt/+ZavtqZCrUWGVSesayXO4NbCDK+M47nCxC541J4H9sbTfgmcxdMOxJmWEh
	Zk/pZqspPp/ZksKwM6WG2iClwcgjWFyIXrBl54ioZEl4SG2zAna511uo8IXaDyzK
	sSsr+d6ZKENdv/iGd1Stz798mGEkBCcEY1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791119850; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:JHlwB+2tRNgMYmR3JetrsOzu2ZK9iP99f6Ps2BYjxOQ/Lyq
	KaBKxn6Bzk8tsp3+GRqHcqfhqKurOa9jpufI0Pp+zbixTUR/zbmGeoHINb9E42e0
	1y6L5ju+nU5WTU6sDae8w4jjjlMTvS4Vwr31Zn0DUXNpE9nZj6z+7MlnfBP3Z9vh
	j4IxmJ/RdX47nSPIO4NE6tL+sNpDZxZgyGIZskpg9HrxRGafeYFgl2zqB07NMetI
	RFMtuleOcv1eVkZillyIUtieiCwX/M38dAhvhgR/D4c8VmNb11PMf6oEJGPDmavr
	ya7wkfqniMI8u1RqL25NgjFBH65WV1ZbZOnmaTQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:TfErRisC1GJdU+16z6vcq0+ID0xzQDPaB30ivXYtRp8=:5Btm6tcQhA9kwfTE3UJV7mfnShKBIFqXlpagWqFCumQ=;
X-ME-Sender: <xms:6lHCauWAZMNg8W2YPvkeYI6gr2uSMZj3GlZ0GFmsbIE1BOLtpp6ITA>
    <xme:6lHCamEyx4mEMZuBujVeb6bvsLBz525fDTkfx-SMXGXH5ldJlTzambyvyNQcWxjS8
    2gY6Ag_9QoQhlmf8u5vDLGXEv1du5i3wu8d9_cFZhunBL6Nt7UZdQ>
X-ME-Received: <xmr:6lHCao3DILbYPDkw8rToVw3VFqZhfWQKYo8Xf-F1qSui8rWMnNNhQ75EX4CUW1FA1IPy-uu4g1FgS3qeCnXdIrLponJdDrPvzGeb>
X-ME-Proxy-Cause: dmFkZTFCx+75Adi2WLtews0JlDvGKmCB6l5XnnchZjgCoOpeuWXdhHSoRfLJW46pAOTsIT
    bma91rNXkGvPyGeC1nk+6tGA6oFJqJ9oHiKkQsccf/JAKP7hJrLqK2JXw6Sum+rc0tclJO
    N0CfB+XBE3hyCjhdH7EEFX9UWqkwoddhL/3D4SpaCL/xZrKuANA+E7PCc+pmMmqEfC/fJh
    Bm6WdJMzzL1Z24h0IklYr1b+5CYH1Diqls4WR/TGkwht7C0O8TEi5osArVoYlZKE1ZF36m
    2ro5fr/0KQuRevRlXw8CSz7nAIm5TmVyndORShQ65pkGcELpR2zEyB/tnPt6gdKnrUOOoi
    AdcPqFknA5MUTAEoPJd8r9dd4DE9K/6+CnXE2O0fHFKxPrkITumyq5/eldEIG2VowLrlKg
    yzNS1Ar+rEdlIfL2ymDJ5fqEPk+BeLg4ytOCC9ktZMtf8SrUymk81UI3udrOozIvMoZNtm
    HBAhil/p5kNPCXkk3n70+py//r+N0medRPzO/Xq/bmU5y99niGYK3yuaHmLysGVAMdJWQ8
    o8e+yTgH3Jvro5MFmmZBMDK+fsE+JzNmLPQC/xwKWL5fAOpOzTlZiZKnDT6j1V8QXPsnr6
    QJgWpB3pZiaIGaJSonr+R2se6q0BU4i1EU1T/6zC5inOwLnCNYc92TYXwXnw
X-ME-Proxy: <xmx:6lHCagOutbwKF2ZGE0JwQCzap0lAO3wQyYF7vuHmRORm6S-JI_-3Sw>
    <xmx:6lHCav4icpygksUqNuatq5R_GRZYbgMa_A0g6GwD9FWxTm3vhqruqA>
    <xmx:6lHCai1iagQAjDeVDuaW2gPuJBpxqb7wzLGkQpm3GwlTRS3RqSNAmA>
    <xmx:6lHCaox8bfQrcnFPujq7br3dzOj7hLxuFm90ZbgH2FaWekue_PU6vA>
    <xmx:6lHCapbHxDbQn2sBXPtlVhwpqKLCXJs6NpAA1cIJYzeIDl2vsShlG-Qx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 09:17:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Tuomas Ahola <taahol@utu.fi>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: don't require a SYNOPSIS in section 7
In-Reply-To: <pull.2246.v2.git.1791033057232.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Sat, 03 Oct 2026 13:10:57 +0000")
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
	<pull.2246.v2.git.1791033057232.gitgitgadget@gmail.com>
Date: Sun, 04 Oct 2026 06:17:27 -0700
Message-ID: <xmqqece5vc48.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Changes in v2: Tuomas rewrote the Perl script changes to be both more
>     declarative and and more correct. Previously it didn't work if there
>     were multiple files passed on the command line.

> diff --git a/Documentation/lint-man-section-order.perl b/Documentation/lint-man-section-order.perl
> index 02408a0062..160c65e1be 100755
> --- a/Documentation/lint-man-section-order.perl
> +++ b/Documentation/lint-man-section-order.perl
> @@ -13,6 +13,9 @@ my %SECTIONS;
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

OK, this, together with the explicit "close ARGV" later in
postcontext upon seeing eof, lets us do a "special" thing on the
first line.


I think for the purpose of "doc lint", this implementation is good
enough, especially with documented "assumption".

If we wanted to shoot for a bit more robustness, on the other hand,
we would want to handle when $1 is left undef ...

> +		# assume the first line is formatted like 'gitglossary(7)'
> +		$line =~ m/\((\d)\)/;
> +		$man_section_number = $1;

... here.  Perhaps like

	$man_section_number = ($line =~ /\((\d)\)/) ? $1 : "0";

If we left $man_section_number undef, ...

>  	if ($line =~ $SECTION_RX) {
>  		push @actual_order => $line;
>  		$last_was_section = 1;
> @@ -92,7 +103,9 @@ while (my $line = <>) {
>  		@actual_sections{@actual_order} = ();
>  
>  		for my $section (sort keys %SECTIONS) {
> -			next if !$SECTIONS{$section}->{required} or exists $actual_sections{$section};
> +			next if !$SECTIONS{$section}->{required} or
> +				$SECTIONS{$section}->{optional_in_man_sections}->{$man_section_number} or

... this will access

	$SECTIONS{$section}->{optional_in_man_sections}->{undef}

and may trigger a warning on use of uninitialized value.  

Also, this would autovivify $SECTIONS{*}{optional_in_man_sections}
for sections that don't have optional_in_man_sections hash (like
NAME and DESCRIPTION), which may be harmless but needless.
