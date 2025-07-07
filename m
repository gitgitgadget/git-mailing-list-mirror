Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F6925E828
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878932; cv=none; b=OtGCFpTMSukofQMri3LIJXNcktnj/nVObQy9lrCaLuchg1ougWUYbUAV7sJ3LX1iuWuMEd2DlvcOh9E6pcnobZC6AgAwkaeJg1rswPpPZ14VY1uyGzd6CsD2+yTxnzifTBGI/tv81dymV13Q9fXUFH2Nnt5IJEO5YigBZ9B/ndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878932; c=relaxed/simple;
	bh=/gQhKVtQQzEZnXILw2FA8N/Txagfu9svv96IjnpJTNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArI1EeqtxkeOxOH/Actc+YACd6qdkY+osCalbsvSMtpwmCsZRpc3+SAPA2GthimphM4zf8HzgKmHpr08LzaqW/zwYQa4f0rgRWX/4XgdB/9mgz25XvaHa503JNeXKsPF2rnfc1LvJfYEZrcRqQ16ptkKjXnRvmzx5tCRd8CLby8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e+keRDjk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZqMFCefN; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e+keRDjk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZqMFCefN"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BE92EC04AA;
	Mon,  7 Jul 2025 05:02:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 07 Jul 2025 05:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751878929; x=1751965329; bh=hotTWbnoza
	zWXKvbOZskBBwG+jMH+jH+JZQmLfZAINY=; b=e+keRDjkirDR44JHX5OsSTcgHc
	bhWJkAswlADfbFK9rnUWdp2lr6nKK2sPPdkOkp/ObwUfQs023qY8h4B7BpYCuuWm
	xG/HDz8ums3z4gQAWN/Lc+WhoA4nAOlXtFKqyX6pgAwWPfQwrql0hqMIfoGi1Yf2
	UHEK+i/QtMqGvJ6jBwFI1Fg0jOlY3VLNgHqwwLH1g0QpOOWWIfORTvyspYF3jLO3
	FOZkA18DdJxAyIWa15lXvaQr9ByYbYRQZCuXBnan/2Y/YvXz9vqNOsUYHjxgcayv
	L/cpHedfEsyxbQZ2sPsAoTvp2OnYSHiOpSuymr0RUgX03QerZ0UpII5muZaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751878929; x=1751965329; bh=hotTWbnozazWXKvbOZskBBwG+jMH+jH+JZQ
	mLfZAINY=; b=ZqMFCefN0Clcmu+yScGGD53p5BsCpsdxPzERBhTeimNrARdIW2p
	05vBVL5CwHZlg4eZKSbWnKOnYPcEymaUGVrF7NvMpr8KqS0CrFqLPjaMMaMEEnZ1
	5Lv8JIA591Qh73yuHY5JR47+6prQ+xcmoYJ+lOb28bgptp+0Q8Fz0iSaDc9dBzCU
	/sVq4ZbKrOBiQok9H4Fdwy+GQv0yhxPpZCia5a2/0KdnQQrR+A1NZaOWMgcf5kV/
	orljj+tsWZDRCA1YP2HJ5pw0FRI97JBp934BrR9GeTB5CE6jdVAbzWzSe2ZywOMr
	NyIaCbaGuoUJiNfzbDU/+1Q/w0UChVpOx5A==
X-ME-Sender: <xms:EI1raEQnNqQh8bryDMEv7TtQa2JHUIEv3hscNO-RTZrlPzUgPjcpOw>
    <xme:EI1raPWrSahmgmHIXyuqBvLVEiPy-ZTeuQk0CTmhrhqxnSeRrgQpx3Qp1DHFWoSGj
    iHIc7IzpYwtmtYgSg>
X-ME-Received: <xmr:EI1raITDZ2LYZK9xJTgrizNCJrB2xubaQjzs_cVCGiRvgrQb6tg28r-qvgeOfdPbuyzFAcWt_h4BcHzIHF9pxPnKHSTNcF30C0nShCQnDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehrvgguohhsthgvsehrvgguohhsthgvrdighiiipdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfshesghhighgrtghouggvshdrug
    gv
X-ME-Proxy: <xmx:EI1raJmrOx3pvrhJ0gVYoUQ6zby-4d23xgkHQ2BYOT5ybWhk8Ra8Sw>
    <xmx:EI1raO7l7D_uNZXHV1QcoWilQfI4icJkdo2oTMMNEroC8BN67UYbqA>
    <xmx:EI1raPgVtN3GNEKNmEd0R-irp83H6MyroRpRr4t2eVLDxpM7epF-qA>
    <xmx:EI1raLElcxDm63Glj_Jyfe7UmGUHlDI9BOPaVCvrj4i7ycPEuYl5YQ>
    <xmx:EY1raL6YlsIcAtpIV5e5A79jRmg-6fb15rq7-0i95-50e_v8-0VD-8KJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 05:02:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id def859a4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 7 Jul 2025 09:02:05 +0000 (UTC)
Date: Mon, 7 Jul 2025 11:02:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: redoste <redoste@redoste.xyz>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Fabian Stelzer <fs@gigacodes.de>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] ssh signing: don't detach the filename strbuf from
 key_file tempfile
Message-ID: <aGuNCGNk96DK4GzX@pks.im>
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250706173450.12995-1-redoste@redoste.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706173450.12995-1-redoste@redoste.xyz>

On Sun, Jul 06, 2025 at 07:34:49PM +0200, redoste wrote:
> diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
> index 065f780636..1a8d96f355 100755
> --- a/t/t7528-signed-commit-ssh.sh
> +++ b/t/t7528-signed-commit-ssh.sh
> @@ -390,6 +390,22 @@ test_expect_success GPGSSH 'check config gpg.format values' '
>  	test_must_fail git commit -S --amend -m "fail"
>  '
>  
> +test_expect_success GPGSSH 'check temporary files clean up when signing commits' '
> +	test_config gpg.format ssh &&
> +	eval $(ssh-agent) &&
> +	test_when_finished "kill ${SSH_AGENT_PID}" &&
> +	mkdir tmpdir &&
> +	TMPDIR="$(pwd)/tmpdir" &&
> +	export TMPDIR &&

I think this exported environment variable now leaks into subsequent
tests, doesn't it? We may want to do it in a subshell.

	mkdir tmpdir &&
	TMPDIR="$(pwd)/tmpdir" &&
	(
		export TMPDIR &&
		ssh-add "${GPGSSH_KEY_PRIMARY}" &&
		echo 1 >file && git add file &&
		git commit -a -m inline -S"$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
		echo 2 >file &&
		git commit -a -m file -S"${GPGSSH_KEY_PRIMARY}"
	) && 
	find tmpdir -type f >tmpfiles &&
	test_line_count = 0 tmpfiles

Patrick

> +	ssh-add "${GPGSSH_KEY_PRIMARY}" &&
> +	echo 1 >file && git add file &&
> +	git commit -a -m inline -S"$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
> +	echo 2 >file &&
> +	git commit -a -m file -S"${GPGSSH_KEY_PRIMARY}" &&
> +	find tmpdir -type f >tmpfiles &&
> +	test_line_count = 0 tmpfiles
> +'
> +
>  test_expect_failure GPGSSH 'detect fudged commit with double signature (TODO)' '
>  	sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
>  	sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
> -- 
> 2.49.0
> 
> 
