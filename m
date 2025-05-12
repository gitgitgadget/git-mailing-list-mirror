Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E31114286
	for <git@vger.kernel.org>; Mon, 12 May 2025 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056733; cv=none; b=nnrqQrREOi36m+PMduYK5RCQtM7ZzvzTWXh51PuKGUrvDDLIv4z3pddRzauJWB1hn8nezCLU7nyZPBf77XrkgJs4bxPbOEUIdheNIJNYxB4NHtV0GrcaHAwWL1gK0M0Amh5Ab3h6xHoD2nHFxpErGn3mig0EWemZfVds+kg9gWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056733; c=relaxed/simple;
	bh=mUf5qIeRTVaSnY9LRbnFJmHggKF4hxrrb0q3gXUoC8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rfjt5Hap7pNVjshup9dyZCYhGnYGhdR1UFDZgoHnBegPC/WJrRrnOacN8WlPH5p/xLgTBoqgTRciDRdx6ciw0z7TReOf6b5BrNFZ7GP6C/aPm8gn0loMkLfZBHWBOsJDvFGRQ/z1hjQ6/obYFG7JsyIcoSH9upMU9jbBtfKiroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TseskDKv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a49u6cnX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TseskDKv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a49u6cnX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 458BF25400DE;
	Mon, 12 May 2025 09:32:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 12 May 2025 09:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747056730; x=1747143130; bh=X4LJa3qR17
	ebVsl6f23MrAnyxRBQSxiJPHBOcJ8pWQs=; b=TseskDKvVt+6kZ3pVMBJdVYFv6
	QbEYR32J2z7BApJyqMkxn+GpHDVlOvSsPk+mkoa3kkzIaJ3xe/C9xRqHCBNMqgsY
	zLgPkssRp3WqHBH2aDsYlZx75nwdNlErv98eKPqDhrpaP+eHvfLaBSEYUB7yZDZ/
	f/YZUJka17YeUEwvV2+IfkKOpyA/s+SabBGfOv6UJAm8UKrFf7DtxA27LOiZq/xj
	C5YF8FyVZJV68n5DdBB7PnexJ4cW2sM2hkQtOpsxM1Wa1UAfCl9BZOgHVZZLhG7n
	P7lsFqPOnfdxblPyU4barG6waUodnyQUzB5A+YP/kwe+2wj0+aFxt5YHyWHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747056730; x=1747143130; bh=X4LJa3qR17ebVsl6f23MrAnyxRBQSxiJPHB
	OcJ8pWQs=; b=a49u6cnX9vvyJ+2BpRvetxkbn5BmP2zYGGcQ2dPVdRHl3cxoI/+
	UjSwGPyU7xff86109KAAp71MRUXOIHGPd1RacvRZ5RxL7vz5+d/uUvjHIIgpyEAG
	5lpmJK7SbebUBTigBOmPrG4t5duOZOHrO8dwtlDzofjXFtoWSIrdK3grV+h93nUs
	qnTfttLb+XAikPjWFrvwFV6g+zhQT8OlCx6jSqJFKkqzK7uP7JDPf5vjrTo1BsaJ
	lxYiq1rMep0flrMhECjxqBGj72va7ONXOOHaDQ7wwMq0TCrJNYqFB/kWRiXm29Vp
	EoQ87XdpsNQ+li9MeE459KXt8m8gdYeFTiQ==
X-ME-Sender: <xms:WfghaPDpm2GPoOIXv_xP2klaHxabbJAopc50Po8YnPu13uPyrUYK4w>
    <xme:WfghaFhXxrQvGgXNGizIcvbV6xHNrB4oDUWDW5UXPoolXKC7ejo-bU-EsYqruC2gP
    xF6uIKN0oHfOaIUlA>
X-ME-Received: <xmr:WfghaKmYbPcMPrOpecNk7b-FJnfhmZsgpoi7r8SnIhhJX1UGrlU9q1ngE8VmA3z5NmPv_6Xf-MS5_WDJKUOJIA8rerUK1bkKdPt1WP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdejledvveejheetffffjedvtdfhveet
    geetueefteehjedvtefflefgfeevudefnecuffhomhgrihhnpehmrghnjedrohhrghdpgh
    hithhhuhgsrdgtohhmpdguohhmrghinhdrphhmpdhhohhsthhnrghmvgdrphhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopeiiihihrghoseguihhs
    rhhoohhtrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:WfghaBxCFHkmDi47BeZzNBoEx50lfKN8me_Jn33IQQSutG9urKWfuQ>
    <xmx:WfghaEQSGTcKfORF8tWwYX7MFn_1-LEE2p3DHsabhh0SBnTm9-HYKQ>
    <xmx:WfghaEZ7rEs5gcNtH-mE2wRLKRwF5w6R7sUebSvGZHoDDSeV3qW35g>
    <xmx:WfghaFTyVvrdOhxjISw2jwEY6Q47TDRZOlv7FN5l9CVTDwYjxP0SxA>
    <xmx:WvghaMKZx7GZl-oPUl4gosIxarhHu-B5PFJo2fFWgkrxaNKC0sfYOpDP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 09:32:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,
  sandals@crustytoothpaste.net,  Zi Yao <ziyao@disroot.org>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] send-email: try to get fqdn by running hostname
 --fqdn on Linux and macOS
In-Reply-To: <PN3PR01MB9597BC2E1B526A11D21BAB24B895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Sat, 10 May 2025 07:37:13 +0000")
References: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BC2E1B526A11D21BAB24B895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 12 May 2025 06:32:08 -0700
Message-ID: <xmqqtt5qvtt3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> `hostname` is a popular command available on both Linux and macOS. As
> per the man-page[1], `hostname --fqdn` command returns the fully
> qualified domain name (FQDN) of the system. The current Net::Domain
> perl module being used in the script for the same has been quite
> unrealiable in many cases. Thankfully, we now have a better check for
> valid_fqdn, which does reject the invalid FQDNs given by this module
> properly, but at the same time, it will result in a fallback to
> 'localhost.localdomain' being used. `hostname --fqdn` has been quite
> reliable (probably even more reliable than the Net::Domain module) and
> before falling back to 'localhost.localdomain', we should try to use it.
> Interestingly, the `hostname` command is actually used by perl modules
> like Net::Domain[2] and Sys::Hostname[3] to get the hostname. So, lets
> give `hostname --fqdn` a chance as well!
>
> [1]: https://man7.org/linux/man-pages/man1/hostname.1.html
> [2]: https://github.com/Perl/perl5/blob/blead/cpan/libnet/lib/Net/Domain.pm#L88
> [3]: https://github.com/Perl/perl5/blob/blead/ext/Sys-Hostname/Hostname.pm#L93
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> v2: Avoid chomping $domain and assigning it to $maildomain if the command fails.
>
>  git-send-email.perl | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Looks sensible. Will queue. Thanks.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 55b7e00d29..511f627ba6 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1393,8 +1393,22 @@ sub maildomain_mta {
>  	return $maildomain;
>  }
>  
> +sub maildomain_hostname_command {
> +	my $maildomain;
> +
> +	if ($^O eq 'linux' || $^O eq 'darwin') {
> +		my $domain = `(hostname --fqdn) 2>/dev/null`;
> +		if (!$?) {
> +			chomp($domain);
> +			$maildomain = $domain if valid_fqdn($domain);
> +		}
> +	}
> +	return $maildomain;
> +}
> +
>  sub maildomain {
> -	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
> +	return maildomain_net() || maildomain_mta() ||
> +		maildomain_hostname_command || 'localhost.localdomain';
>  }
>  
>  sub smtp_host_string {
