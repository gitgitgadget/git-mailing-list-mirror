Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDE33254B8
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 04:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790223241; cv=none; b=W9YLXlN583Oi6zqGSS3DK5xrKb1/UwWK806EeDV7CjJBxehvLsQQBhXj3CBewodC427GLRJOQ+UiucMm+brU2kpoGW2ghT4jCSMPG0RubQdDvn0uof551HVDCuwFFhdNjerPQs2PxcSm4VusCcz83yuS7xXaINaR4aXfDHMaWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790223241; c=relaxed/simple;
	bh=FeVv58y6MwW9p5pzC2khUWcDpUOgMXIkn3yygEOA6lQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ar4Uj/E2Lr+RjcQj7wKX9sqd86ysNjid7DhEsTgeCEGkpMESdaDwJth46W2ldHM0maIBWau5Z7JQFXbXI6W2pXYDV0FUt+FW6e4amR/wSjzoEM+0INz2xYOcvu6p/iJW8NHL3PboOnTT/Rx556ITFoExz0ABp/MNgFuEsNkYGgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VwvvDZ+2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aWD3t3Wq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VwvvDZ+2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aWD3t3Wq"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 667E31400090;
	Thu, 24 Sep 2026 00:13:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 24 Sep 2026 00:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790223239; x=1790309639; bh=swnPmI8UaW
	0t0GtOYyxOOV8GjOhEtXd8VwuNFiuHRZs=; b=VwvvDZ+2GdKUY2Kma6imKpDPpf
	5PGJRV5g4TxdSBMOgQrcvROuUshKrZQ374UTaHJQYd65E//nSVSqefuSGUAKkqQj
	hTJsm6FNU+EQgQjK6h7vwa1BXfUDmjmW9fXBVVjjgHieiTY5PlX+jhWNiEuUNalu
	vVuL/jRTqt6Qc8c2/ki5pqgd36QRF4H0dvVOE1hiHQATChF/NTSZ6xasXOZeRFVE
	AdwD/3oikZPtKqrv6JvTOQsvjARFgWr09Rt1E5bWFHB5oeSKr4na1tlsnoRrwkGC
	abLnwH5Da0kV4KKeTN1WDep8cGTH51a4e8zRuD3zkFznI66CG0TllSWbtizg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790223239; x=1790309639; bh=swnPmI8UaW0t0GtOYyxOOV8GjOhEtXd8Vwu
	NFiuHRZs=; b=aWD3t3WqGqqmR2U+B3NOXAmN0oWVTt9i8r25XG5gXvH1LtqBBgj
	A5nPCstzwGo2NkpwfjF28LAlKNyoXJFQgSGD/8bc0xRApK8jngbKuGc16NSCWdmG
	EHEWj7m1bxENU4dkU7WeJWmOf03R6yVDbBfdiBgiv/edXC27XmNVROT4HfirdNGU
	39CizJu3KKDQmv799HHlwTyJvu5jXFrTnOB0h40eTixvADo62OTU/qjlgfFuL02n
	R3EgDYZdC+Og+2qg1EWcrcNC9P0/8dp5pT1S/9/nKa3MEKSntLzGiDVeFjtn8c6X
	p/+DNlEnz8bgx3v7xvei/9hiGk9SMw8hBlA==
X-ME-Sender: <xms:h6O0aqOYiH6Ty-tHwhguGxPAEQZifAZ8gAm-qQYVwrVP4meL6lCh6g>
    <xme:h6O0av8vvgz6JOUFkmJSGM9GBFaOoSvKh233CKiFQZKqbJ_tJT7JgdXYtTrnWJp3K
    T9H7QM2LwrYC8PHSDTOdvzJWyP2LAIcT8FHLiIBNC6p5sL9lxGaQVo>
X-ME-Received: <xmr:h6O0amSXFxuqt95H2VBqLkqoUvVBIzLNcOxBRmqekmx92U3UGtt2M6heTfs3RBvi16YbuhYC7u4Mf34HhT2hdubdQy9NmNVlIkJs>
X-ME-Proxy-Cause: dmFkZTEGBIMRW1IF/qyGH3SxZLyXeLtOtFetaydDZdcGhOvK5yLxAL01Cst/xRJIm0kewr
    tqkQloAc8slghCbZ3/hOZYLucE0vv0s2W0wFTMwglsKSmD6KGvij3u90lBDz4NBxcF6FFc
    +faGsPjYo65XfCpReViTlaJVOOzFCDiFkoLanUrUT2uIrrDJUFwNiDndUzcA5lNpPvNiKS
    96l6s3FWJPCCTHc12sapcwM5D/ck+iooPFh3AWOKtm3K9whkOCKG954bZmhtpf6Fq36owY
    sk4TF2wHOdYEfAjT9AxZDl45yqSxCiFRW/G0xREyVB53mjQLmXCnoSv1jysCp5nhBdgQQe
    K4fxr4oAqlkKiBsTizdzhAi7j3Zf7wrayd2LWkXj5/mj7ZT7TQxwB9paAE/DuS2h4nw468
    bfOu+G8I2T3jcjveDfV+aw/V9vUVhOMiUKXAb236cAfB5GmmQwPvoyOfL1ScbAA8HTbdHk
    6NljVbfVLpfkXGtTM+/UpDnsU+n+GnKjtoTjZbe3v0xB245Av7/mOjJULy8Q7aCUXJvpdl
    bePPHl/AoXhf2f1SW2W2PD2BPBoajta9em+8E/06qSe2uZXVYRz+5ZrXenZKNpWPd9yUqv
    raXa3U+pnNv39plm5o0p91NqXiT8OHGBlScUgJgwV1iQgnIjz2GfUYwAu2MQ
X-ME-Proxy: <xmx:h6O0aplbX9wdyNgt7hPymJhPHfZB3XoAZ0_0WH3GAFETiefPzDjLhA>
    <xmx:h6O0auSrMk0PiyWHfI6imqA5_2j0qqBrRMbv3K8CYmc_8w5LaB6XVg>
    <xmx:h6O0avNVyOGQQQEEkTbQx5ObgX4fOrWhf4dM5RXxvdpT1mxEYdj3tQ>
    <xmx:h6O0avX9c51eVpx36d4x6nB8BjPbsa48eC4Nw-otVn97ZFhXJCbCzw>
    <xmx:h6O0aulqBxOYpBHOFnFnsw3oDFoH8t1BzlysZ4EbqAYETyBJmc_y67PE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 00:13:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3] git-contacts: allow inputting patch via stdin
In-Reply-To: <20260923-git-contacts-stdin-v3-1-56dd43c64d56@brighamcampbell.com>
	(Brigham Campbell's message of "Wed, 23 Sep 2026 19:25:30 -0600")
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
	<20260923-git-contacts-stdin-v3-1-56dd43c64d56@brighamcampbell.com>
Date: Wed, 23 Sep 2026 21:13:57 -0700
Message-ID: <xmqqtsnf477e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brigham Campbell <me@brighamcampbell.com> writes:

> $ git contacts - <patch
> $ git contacts patch1 - patch3 <patch2

The second one is an example that we could tell the command to read
these three files in patch1 and then patch2 and then patch3.

> -my (@files, @rev_args);
> +my (@files, @rev_args, $read_from_stdin);
>  for (@ARGV) {
> -	if (-e) {
> +	if ($_ eq '-') {
> +		$read_from_stdin = 1;
> +	} elsif (-e) {
>  		push @files, $_;
>  	} else {
>  		push @rev_args, $_;

But this does not match what I would expect here, which would be
to have something like this ...

        if (-e || $_ eq '-') {
	        push @files, $_;
        } else {
		push @rev_args, $_;
	}

... around here, and then tell scan_patch_file that "-" shouldn't be
opened and instead read from the standard input stream, perhaps like

        sub scan_patch_file {
                my ($commits, $file) = @_;
                if ($file eq '-') {
                        $f = \*STDIN;
                } else {
                        open my $f, '<', $file or die "read failure: $file: $!\n";
                }
                scan_patches($commits, undef, $f);
                close $f;
        }

or something.
