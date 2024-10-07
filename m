Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E26A13CA81
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281110; cv=none; b=OMixizRXdimCf42G2nYAipmy6mPhAr81NljAmKkG5knplfzMHHgVaxu//ZbnWO7oUAyygpcV1DGfBfmVT+KdKa/GJ9k63KHE2EWFRvJxjtlWeWeDr7VJU+tPXdlCGvmZqLM6HMqPQaE9E1EJMnhUMEljL8Bx42smfVFzV4/Mq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281110; c=relaxed/simple;
	bh=rj+A8tBzeyIyXLn5AI+YK2Y3f/KI6BAr6m6Wx5oUbvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W29ul2CQygfnE7g375F/89EQT3+Bko02ibIghPE+2Q7Pv5OhdD4r6gXivaKcR9HwY1BVVw2cnR8p6yu90z/uQ1bismcy7UVkDuAQqwCWBVax0NpYqyCY3sfwzpcYS4dBCb0nGadvNYMz1xSmTnjFqKIEtTdHelb9vuHcwB7idI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=amaymsnj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kCt/Tlzp; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="amaymsnj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kCt/Tlzp"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 74E7C11400C5;
	Mon,  7 Oct 2024 02:05:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 07 Oct 2024 02:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728281107; x=1728367507; bh=0o2ELZfzbW
	+3mx6UJXp8kXoA1VLEXgwDuzXKB55Nd+c=; b=amaymsnjgjeKzJglp84+DDy6yt
	b3gMBp7NI+w4r9tUaqk/TLd76V3EvuITmbjKs/BfjRYpf1DrhW5TydL9i2S29bZW
	jAwu9+R6F5dQ6OXe6v4jfcllu6raW8ctwaRYln/XANuR4CQUDTednm3zLADRXpQQ
	BNBPuyJjaqWHnQpsA9hYMWovfXztLCcfEeJOdNlG6ouQ4lm8FnCcO+btmqmo5dnA
	J4vptDFC5Ddq3YjC6T57u/ID4ukCeYJKEhEZ+irsWktMomZAgSLsm3YuEXiOb5jB
	tTb0EDkynAcgri54adkAvZJhuaPl3RPeWcEx1cupBPl2jqFPAH18f0yXBFtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728281107; x=1728367507; bh=0o2ELZfzbW+3mx6UJXp8kXoA1VLE
	XgwDuzXKB55Nd+c=; b=kCt/Tlzp1wwsPPdw1SmvC7NqZHB0fz1laHus06v7wD9V
	ANUPgXiP3atXxJ+/tSTIhSV8PUee4h3B+AQcTEFNCfKYFjoNWxSbpU2r8LRvJ2pV
	NgZWRfYFz5WXeO0XJJYyTA/nc+fxpDIEkDUqIvqciYK5WpufsNqdWRoTf7/mQhV3
	SJt4N0SAMcX1Ta43BbvBimEtQ18qY1SpEGuMSlG7/mHX7Rsw9NBqHfIoFsMGmp++
	OnYZcJRxlj9y/ADOmK81PB90W1LEcIa7nY+qQfkjQkqXVS3Q1yRuoiSHcpIARcdS
	byNZkTCt73W/vFEZmfcI7HXGQRLuCoXlii9wW/QCdA==
X-ME-Sender: <xms:E3oDZzjljtNpjWQtLEoRNi2fkjMApU3YnfaNqGIVyOWlZUxvgpJAGQ>
    <xme:E3oDZwAFXp1iPKRCIJJKk6e81Io-CzGyjspVjed-Dshr38gZsUUo-2yS87xORgQuX
    itboloFg3c-CymLdQ>
X-ME-Received: <xmr:E3oDZzF55gxG5zp4w9KiyDqvC0MLVU-n8uPElXbd14crm4E6FhpxU611Ac0GsYna0v3Gw2ZX8E5hJivkMFP6Oxv3vCVM3q7ugPoKgYSekXS10m5FyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:E3oDZwQMEwvkX5zjM0aeTihTIMEaSBetG65m0v1fpwGXoZqsvRrqKw>
    <xmx:E3oDZwx625ur-__KEQklIdWyBJSq7Nbx6uY36jIKSWYLCEM-GN7_PQ>
    <xmx:E3oDZ25bEPjohYeg10pkDxGwk6HXBezsTbx8gNMG7cjgKphpVsRTeQ>
    <xmx:E3oDZ1xTIXFpUd72GEDtLSLI7U-3_yUps2EM2W1lG92X5t5WR4D11g>
    <xmx:E3oDZzzPUueed6ItVsrlYmKxZXFnnInuy0NKsqc7kgGKfo5i0FeX174Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 02:05:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb0bce53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 06:04:07 +0000 (UTC)
Date: Mon, 7 Oct 2024 08:05:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>,
	Eric Sunshine <sunshine@sunshineco.com>,
	shejialuo <shejialuo@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v3 2/2] [Outreachy][Patch v1] t3404: employing
 test_line_count() to replace test
Message-ID: <ZwN6D_-Ak1FoE0ix@pks.im>
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
 <37b1411ee2c420f1a8578d27a2f7d54ccd3f329f.1728230769.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37b1411ee2c420f1a8578d27a2f7d54ccd3f329f.1728230769.git.gitgitgadget@gmail.com>

On Sun, Oct 06, 2024 at 04:06:09PM +0000, Usman Akinyemi via GitGitGadget wrote:
> @@ -401,8 +402,8 @@ test_expect_success 'multi-squash only fires up editor once' '
>  	) &&
>  	test $base = $(git rev-parse HEAD^) &&
>  	git show >output &&
> -	count=$(grep ONCE output | wc -l) &&
> -	test 1 = $count
> +	grep ONCE output >actual &&
> +	test_line_count = 1 actual
>  '
>  
>  test_expect_success 'multi-fixup does not fire up editor' '

Oh, you already do the change I proposed on the first commit. It's a bit
funny that we first change things one way and then touch it up again in
another commit as it leaves the reviewer wondering for a bit.

But I guess that's okay, especially for a microproject. So overall I
don't see a strong reason to reroll this series, thanks!

Patrick
