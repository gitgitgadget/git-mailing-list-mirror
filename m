Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7C347505
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258582; cv=none; b=V5l9UqY/voZmVupkgLHSM3h0XJpXlg8A0HRJ1t/U1gM0w3TCIP2kzhy8gLAu11pqzQjWlfh7DhkxGj7VW90QDB/UCw6EV0ppYz574hqb4iUn+QGAnb/1aogawhxXfhcphr/ijCGw9YGdB4eBouOn5mPhEd1efs74ykZI1jFbT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258582; c=relaxed/simple;
	bh=1JRKOfJasy0Qaw3PVle+ldokrAkgiwqSseovZXP9yOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l2FmndEMr9sPT0p32m7cXmLZr3JDVPCUeJsuigDWn7ZmQftK6vGdulPBDiek5LitXHVli+o1S8du1LWCdw3z9XyPAl4Qxpmk5plda7nP72Z8Z+n65Q19Zj4OewgsOHQvBv4cpUPBMrUHlVBYpLEpdV3tgXhWj8KKAMOL1VYT1tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F8802nQI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H+Y4ROTB; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F8802nQI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+Y4ROTB"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 870BE7A01F3;
	Wed, 11 Mar 2026 15:49:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 11 Mar 2026 15:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773258576; x=1773344976; bh=V4Wah3kuTg
	jnCjf81ii940n+h6CqKGyo72bUoZjdc1A=; b=F8802nQIRlbMz6ick2jJv6A7oH
	qHkx/FUiafrvUBPR0JEkvCLKMyUxLt7jiDErfiBezBWiGJ4pLxeRkRj7zm7KDxiv
	SW1DatD3FAnpFKJmxNy8J3HOTaRsQgk3gX5F8BLR8eFoX3JAXwivMd+4YWtClYxu
	7fbxunL/du50qVsSCWj1mUkGjQBBQWRgUOA92BUqgNizdgl9J1CroObSg3BaxZZ/
	tt63zDmYP8bTuAPlIOy2KLwgSV4Xi8fGE/h7vgcysJYsIBzUbe6pdqJL30N3WA7W
	+it1ocna9GFI/fyxm9kOgZi/6RyEiEyunihHskFQhiuXDX9u9fKb/0joYzUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773258576; x=1773344976; bh=V4Wah3kuTgjnCjf81ii940n+h6CqKGyo72b
	UoZjdc1A=; b=H+Y4ROTBHJAKD9kIdxZkRXyFzQtcBvmkhzGp7G3xwWjHB4mAwoQ
	eyB0GjStoLXegAUyLfAdcDsdz05VBhGU5OqYITf4aV57Ms9TiriruBe6Wax0XkvC
	eeKsHR9Oe3LOIK61CbFmZTNx1Ack/MaSsYILJLK3F+MYbd75oxevJLb7qCi+1ux5
	4nkeT8KKytmZN1NF6xJkZ48J2+m2/SL/B/uO6gXGNXbsa4sfysBbtzM6nyVvu25U
	uSLXqSnkVeH4yZ55m0DV2tptXDXI83+nz49ac3rmN9uUBorasIW227CYz+An/OVD
	rNyLrQ551eNHJeYU6OBkWhGJ0OGEZYRW9Lw==
X-ME-Sender: <xms:UMexaVgFWhsdNmueQqarDQ6nCd9vbzcjWDJixO1TGzF26ouDlp6mzA>
    <xme:UMexack29fUcHGxmAhTk52M9JbxXVwpbpcTOKKns0OPFIp7dfKWLosszB-wCplJfJ
    Si4cixsM75GrkIlW-GByv5q6cyW123mPCgfcTjY08GlN10QNJSVlxE>
X-ME-Received: <xmr:UMexaYu-Cl-RZL5EUA_sMy7jP2mCsEAH10Ze4Ze4Kv3Hvh00wMLc2dJ0jCrvUwTaw2kkMyx4melAJNKtLZGbE67wBRy9Tj8Tdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggslhho
    ohhsrggsrghtvghrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilh
    drtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    hiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UMexaaa4dF6qF2jK1ZKNvZIsQrEVeb31nxe8Zq20lFYySgCndHBUfg>
    <xmx:UMexaYDyH8QvySf8SEsUnANM8PuyKsZox01x50xFhxidDdIYPj8DeA>
    <xmx:UMexaa_2GtUQ7XDbUtSJ1WXSE-RLwIycgLgpSjrPlMF3Z9gDaUajxw>
    <xmx:UMexacQ-d-oBf6eZ9BueRH6I8cNN9prIJ-BOvUFL2QLFvhNl38-68A>
    <xmx:UMexaVPnV3jRifG1WwGh7nR8gW1HIuqSbOKy3ns4EUKskydV9j5Km7Cs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 15:49:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com
Subject: Re: [GSoC PATCH] t9200: handle missing CVS with skip_all
In-Reply-To: <20260311194002.190195-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Wed, 11 Mar 2026 20:40:02 +0100")
References: <20260311194002.190195-1-pabloosabaterr@gmail.com>
Date: Wed, 11 Mar 2026 12:49:34 -0700
Message-ID: <xmqqy0jym9ip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> CVS initialization runs outside a test_expect_success and when it
> fails, the error report isn't good.
>
> Wrap CVS initialization in a skip_all check so when CVS initialization
> fails, the error report becomes clearer.
>
> Move the Git repo initialization into its own test_expect_success instead
> of being in the same CVS check.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  t/t9200-git-cvsexportcommit.sh | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Makes sense.  Will queue.  Thanks.


> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
> index a44eabf0d8..cba3b1a28a 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -30,13 +30,17 @@ export CVSROOT CVSWORK GIT_DIR
>  
>  rm -rf "$CVSROOT" "$CVSWORK"
>  
> -cvs init &&
> -test -d "$CVSROOT" &&
> -cvs -Q co -d "$CVSWORK" . &&
> -echo >empty &&
> -git add empty &&
> -git commit -q -a -m "Initial" 2>/dev/null ||
> -exit 1
> +if ! cvs init || ! test -d "$CVSROOT" || ! cvs -Q co -d "$CVSWORK" .
> +then
> +	skip_all="cvs repository set-up fails"
> +	test_done
> +fi
> +
> +test_expect_success 'git setup' '
> +	echo >empty &&
> +	git add empty &&
> +	git commit -q -a -m Initial
> +'
>  
>  check_entries () {
>  	# $1 == directory, $2 == expected
