Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E861E866
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710733809; cv=none; b=PG+eLj+iPhgBOHaq6I6SQrNrJKCOrZ5sX7dW0SDY/TpXdwZWOJAnGS6dhEY+Ub1ABCd9zaMGtsihwZ5LjYbLbznnVeh86G/OXf4Rd9k99iZYpG0duQx4hIJHYapAiIdhTrTCLPiYem5Eouh2c0F5I+sGtLL58+QddjQjoS0b8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710733809; c=relaxed/simple;
	bh=4EtRdasyJpBlxHPbg844gUGYbUVz2dgDx9huYp/9Khc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3u5NIUy9jOrCPAN6rBEz/IGJVPti3LK7xh0wxxgTZZoB5pEunCM1P0vLqKjJmS3DgwFpE70cRFnLmpknKBsMu3aI1yCXOutjzjPNe+fE15VSWmztNoFiyfbrMGHYzZ4U700YTjL3ZGopsBEfbxbCBwS4IlmxpPkr4+oxd93VdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=g+MjpeAO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HqPoukJp; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="g+MjpeAO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HqPoukJp"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6883E18000D5;
	Sun, 17 Mar 2024 23:50:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 17 Mar 2024 23:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710733805; x=1710820205; bh=zBVNot+2a1
	f+ngDZYfF7KjEOA/APv85ZBK/FSTHSDyQ=; b=g+MjpeAOiqhuKi2Xh5Uq0DYGhk
	Ohee2UD5uWfBMUzpg43L1/m3v3BJt9GWMDVfDlugik8Q6fFSNbZf4jVjDeR0Vbm3
	H6YbpIMDcdvGYdDn8deaRdt6Jk/KgyNPQlCU71tLvBIqQAEG72HDEQKnV0azoF82
	D3v4Zx9HEXHGDftZLOMXrvcH1ih7MTOcsOw1+iXKzTyWjw/ef+tdziVheKff8LXJ
	gE+ColIoYReOY5ROH4fOvAQAiPcLVRsk9Ls+D/++kheOSt5w41LpU7R71uqdVYAJ
	KcB3wA1boD9ZMmoyLx4c7Kxf4tWrbXhLTSoNWlHXHCVH3ia3ctFXwcMjTdbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710733805; x=1710820205; bh=zBVNot+2a1f+ngDZYfF7KjEOA/AP
	v85ZBK/FSTHSDyQ=; b=HqPoukJpeGmdsxjLjvHkRSd934MGjMD80kbrqGs5lvoR
	PUH2R5kPYQDf/Kl2SJTajLJI5wuldmeJwvdUSYKeYycfO5PFHBgC05Pf+cfnbR7y
	yZTX3if/dyRelbzYkAONWrsvcsdIIVZnsCrWTKW975E8BDrOYWrx7NLfA63MRxjF
	GMK3Z/Qyb9IM7sV3X5ghrfXLRpaGncVBoGiIzM2RYMjpjlR7NYUYbBRx6ufxcBmK
	iCvvyKKM1QBy9xYfVYaczjaU9Fsde1+F320LH7mlf3BFf4G4PGgZAf72aUB0wmID
	W+KWAY39CZob8N5sEZn1PxlD28pNzZ6CLYBkr1d6HA==
X-ME-Sender: <xms:7bn3ZeUygJK6mmGINVHov5bAGKMQ2quuFHIr2qFM5YlCnIdsQazuyw>
    <xme:7bn3ZamFYVftuicYtrEhZE5Cls3N3pcbimzxKl-7OxwIizqoz871r_d6Bf3oCkeTq
    LRMBNseyamTn22CEPM>
X-ME-Received: <xmr:7bn3ZSYXyI_WK-1eLncaQuHjhV5veLDhFyhnmowZR-dycWGktSTuvrpSznS-LREEE7t3ddqN0oFDN8n24RIOIaExq-da6B7W1IaZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeeigdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrvghtvghr
    ucfjuhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
    eqnecuggftrfgrthhtvghrnhepkedvkeegheefjefgvddufffhveehjeffvefgiefgkefh
    udeifedugfetudfgtefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvght
X-ME-Proxy: <xmx:7bn3ZVVr6YwKIEi1m2rg2wTsqj6shgIMDiaJ1uQ4k-xNERCRfthGpQ>
    <xmx:7bn3ZYnVcJpQoXneF9NWuUu5VEAQpfnWlk-UXDqeB4xUjCvIajY-rw>
    <xmx:7bn3ZaedFkvvDEPdhA9Aeb6_QZRJrPtdLrc2LDN_w32wcEbDRzkgbA>
    <xmx:7bn3ZaG71uSe4ST1V8_yqBUifyCKoWMG3hy2L5CZZ1WPBFoceAfqmw>
    <xmx:7bn3ZWYbJM5DrnpNH_jZ1bmKlcssxSYfomOnntalJ1AqDb6JWYybBIhDza4>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Mar 2024 23:50:02 -0400 (EDT)
Date: Mon, 18 Mar 2024 13:49:57 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, David Heidelberg <david@ixit.cz>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v5] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
Message-ID: <20240318034957.GA2935525@quokka>
References: <20240315055448.GA2253326@quokka>
 <xmqqy1ajqvkb.fsf@gitster.g>
 <xmqq8r2ioh19.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8r2ioh19.fsf@gitster.g>

On Fri, Mar 15, 2024 at 10:57:22PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I am tempted to queue v4 with the z/ -> y/ fix from this round,
> > without any other changes from v4 to v5.
> 
> So, that is what I did before I pushed out today's integration
> result.  I however have an "after the dust settles" clean-up patch
> on top (not committed yet), which I am sending out for review.
> 
> ------- >8 -------------- >8 -------------- >8 --------
> Subject: diff.*Prefix: use camelCase in the doc and test titles
> 
> We added documentation for diff.srcPrefix and diff.dstPrefix with
> their names properly camelCased, but the diff.noPrefix is listed
> there in all lowercase.  Also these configuration variables, both
> existing ones and the {src,dst}Prefix we recently added, were
> spelled in all lowercase in the tests in t4013.
> 
> Now we are done with the main change, clean these up.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

And thanks for merging the patch!

Cheers,
  Peter

> ---
> 
>  * If we were early in the review cycle, we would strongly prefer to
>    do a "preliminary clean-up" followed by the main change, as the
>    clean-up step would be much less controversial and can be queued
>    earlier before the main change solidifies.  But at v5 the main
>    change is more or less perfect, so it is not worth rerolling to
>    split the clean-up changes into preliminary ones and change to
>    the main patch.  So this is written as an "on top, after the dust
>    settles" clean-up patch.
> 
>  Documentation/config/diff.txt |  2 +-
>  t/t4013-diff-various.sh       | 48 +++++++++++++++++++++----------------------
>  2 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git c/Documentation/config/diff.txt w/Documentation/config/diff.txt
> index fea89291c6..5ce7b91f1d 100644
> --- c/Documentation/config/diff.txt
> +++ w/Documentation/config/diff.txt
> @@ -108,7 +108,7 @@ diff.mnemonicPrefix::
>  `git diff --no-index a b`;;
>  	compares two non-git things (1) and (2).
>  
> -diff.noprefix::
> +diff.noPrefix::
>  	If set, 'git diff' does not show any source or destination prefix.
>  
>  diff.srcPrefix::
> diff --git c/t/t4013-diff-various.sh w/t/t4013-diff-various.sh
> index cfb5ad3d8d..3855d68dbc 100755
> --- c/t/t4013-diff-various.sh
> +++ w/t/t4013-diff-various.sh
> @@ -633,8 +633,8 @@ check_prefix () {
>  	test_cmp expect actual.paths
>  }
>  
> -test_expect_success 'diff-files does not respect diff.noprefix' '
> -	git -c diff.noprefix diff-files -p >actual &&
> +test_expect_success 'diff-files does not respect diff.noPrefix' '
> +	git -c diff.noPrefix diff-files -p >actual &&
>  	check_prefix actual a/file0 b/file0
>  '
>  
> @@ -643,58 +643,58 @@ test_expect_success 'diff-files respects --no-prefix' '
>  	check_prefix actual file0 file0
>  '
>  
> -test_expect_success 'diff respects diff.noprefix' '
> -	git -c diff.noprefix diff >actual &&
> +test_expect_success 'diff respects diff.noPrefix' '
> +	git -c diff.noPrefix diff >actual &&
>  	check_prefix actual file0 file0
>  '
>  
> -test_expect_success 'diff --default-prefix overrides diff.noprefix' '
> -	git -c diff.noprefix diff --default-prefix >actual &&
> +test_expect_success 'diff --default-prefix overrides diff.noPrefix' '
> +	git -c diff.noPrefix diff --default-prefix >actual &&
>  	check_prefix actual a/file0 b/file0
>  '
>  
> -test_expect_success 'diff respects diff.mnemonicprefix' '
> -	git -c diff.mnemonicprefix diff >actual &&
> +test_expect_success 'diff respects diff.mnemonicPrefix' '
> +	git -c diff.mnemonicPrefix diff >actual &&
>  	check_prefix actual i/file0 w/file0
>  '
>  
> -test_expect_success 'diff --default-prefix overrides diff.mnemonicprefix' '
> -	git -c diff.mnemonicprefix diff --default-prefix >actual &&
> +test_expect_success 'diff --default-prefix overrides diff.mnemonicPrefix' '
> +	git -c diff.mnemonicPrefix diff --default-prefix >actual &&
>  	check_prefix actual a/file0 b/file0
>  '
>  
> -test_expect_success 'diff respects diff.srcprefix' '
> -	git -c diff.srcprefix=x/ diff >actual &&
> +test_expect_success 'diff respects diff.srcPrefix' '
> +	git -c diff.srcPrefix=x/ diff >actual &&
>  	check_prefix actual x/file0 b/file0
>  '
>  
> -test_expect_success 'diff respects diff.dstprefix' '
> -	git -c diff.dstprefix=y/ diff >actual &&
> +test_expect_success 'diff respects diff.dstPrefix' '
> +	git -c diff.dstPrefix=y/ diff >actual &&
>  	check_prefix actual a/file0 y/file0
>  '
>  
> -test_expect_success 'diff --src-prefix overrides diff.srcprefix' '
> -	git -c diff.srcprefix=y/ diff --src-prefix=z/ >actual &&
> +test_expect_success 'diff --src-prefix overrides diff.srcPrefix' '
> +	git -c diff.srcPrefix=y/ diff --src-prefix=z/ >actual &&
>  	check_prefix actual z/file0 b/file0
>  '
>  
> -test_expect_success 'diff --dst-prefix overrides diff.dstprefix' '
> -	git -c diff.dstprefix=y/ diff --dst-prefix=z/ >actual &&
> +test_expect_success 'diff --dst-prefix overrides diff.dstPrefix' '
> +	git -c diff.dstPrefix=y/ diff --dst-prefix=z/ >actual &&
>  	check_prefix actual a/file0 z/file0
>  '
>  
> -test_expect_success 'diff.{src,dst}prefix ignored with diff.noprefix' '
> -	git -c diff.dstprefix=y/ -c diff.srcprefix=x/ -c diff.noprefix diff >actual &&
> +test_expect_success 'diff.{src,dst}Prefix ignored with diff.noPrefix' '
> +	git -c diff.dstPrefix=y/ -c diff.srcPrefix=x/ -c diff.noPrefix diff >actual &&
>  	check_prefix actual file0 file0
>  '
>  
> -test_expect_success 'diff.{src,dst}prefix ignored with diff.mnemonicprefix' '
> -	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ -c diff.mnemonicprefix diff >actual &&
> +test_expect_success 'diff.{src,dst}Prefix ignored with diff.mnemonicPrefix' '
> +	git -c diff.dstPrefix=x/ -c diff.srcPrefix=y/ -c diff.mnemonicPrefix diff >actual &&
>  	check_prefix actual i/file0 w/file0
>  '
>  
> -test_expect_success 'diff.{src,dst}prefix ignored with --default-prefix' '
> -	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ diff --default-prefix >actual &&
> +test_expect_success 'diff.{src,dst}Prefix ignored with --default-prefix' '
> +	git -c diff.dstPrefix=x/ -c diff.srcPrefix=y/ diff --default-prefix >actual &&
>  	check_prefix actual a/file0 b/file0
>  '
>  
