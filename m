Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0761B25DB18
	for <git@vger.kernel.org>; Fri,  9 May 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821588; cv=none; b=eW5H3Ivk9NiFst2lo4E9Nf2epupY0YwBc7Wy3mDYbudZENOkfGTMzpph//N5BfWfWB5WVMRSbLNVEsKBGREHTDL8g55X8+IMZsP6nrogsUFYSwnA739fpgb0XfJ1yzSh2NsRVXVN6O5CHxUUbgEUTgJZ9a0/HMXPzR1zfXUcl9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821588; c=relaxed/simple;
	bh=tkFpcR0SVAlMae3bmBt6i1xJsvvoUAbXzIoEreKtv6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eYnXVuuqXPIp1MNiJOqBCKjdB1DYlv1IDg+5ts2g9swwbCOwGLafpNrMKPPRdgkTkBAZWNvBWkqyhNO3jkLjyCIcSoTeBMv/YeSTPbCTqTZH9PJsUUhuq3rKZKyZALtyjaVf0Gn0sl1SFSq9ooWxJ7vEwylOy5DBfNJ63FK+jWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e0FFUULt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDtz5jJ0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e0FFUULt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDtz5jJ0"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 00F4B1380161;
	Fri,  9 May 2025 16:13:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 09 May 2025 16:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746821584; x=1746907984; bh=URkCnadCJt
	BqR9qByidZXWwD82/HvxzeU+1rAgetKq0=; b=e0FFUULtOMr/fui25iq/vrM5Fb
	E3C1vdpvM7IjkyCl97t8Ajmpi0O4oJSd64S3zMUvIpJuuhWUUGP/G8oCs8M6mswr
	ER7J1mij1N+ojIzlYdh9jTN8OLTBEHQ7oLDbzlf6ooCm1uUiwq0Xk6bcmcCRFV+s
	IS8CJATWhgStoMYEC7UKPE2idY60DR+YhZPQ1aqDwekF9wnDcPp/rALMKGTx0Vp5
	KGsHvN78BWxvQWCpQnMf4M/hnlVaBoCdoRQIxpiqzGIvShWu9J3Fxi686NMoG9+7
	GR8shx66tKCTICBP9p625W4CLyPDSgd4nmWC9UBfnFVpFMUH8qKV/1XY6vtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746821584; x=1746907984; bh=URkCnadCJtBqR9qByidZXWwD82/HvxzeU+1
	rAgetKq0=; b=QDtz5jJ0MNgteq66DjyuYvKLHh+XOecJ+FrkaD7Pkpv7XqnOdua
	LSO7f3ymSDI/C3s7Li5RiV85XtRtE4Xj0y2Sy0pfjsvJI3R+OgB8zA1diLJKcdaQ
	sqARlqo54472ElJ/dbI2z4hLyzdYNaNpf7QwF8xOUqeZIyO/OuOX6RYfe3Wqg8iB
	uHvurXzsVdFsp9n2jTC37ACihcuB+MBO6VuR1LhhXwDU8PpVkbQqrMLVkX1hjD7S
	eHd2rytphz8Uxwyo7suQT2XB15ccsfRxFLwQzPJppNXNjGfhh5dYi9aQS2nO0gHe
	+eA4+udCsbBw4AXY2L01iFcarJwvCbNgWaA==
X-ME-Sender: <xms:0GEeaG-iWGns38kHsef41T7EDJmW-z_irpwaa81PRLEr-mW92JjnLg>
    <xme:0GEeaGv_9sSKrnpqMO-LiOlBbvBPbFUwqxQA7aEMyXDsMA1IJgCdEoDUgctb0gc21
    zGM2Tw2ldS9_LfaRw>
X-ME-Received: <xmr:0GEeaMA6qf6vtbl69LHcJ-2wWoxYXXOT-n5lhHCf0THcEYYrtJO6K5cZSC_J9QemwaoNwj3wf5OTt7Mui404kHG5lG2Q3_HYjxqL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleefheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepjefhlefgfeevvdevtddtteeigeekjefh
    heeitefhgeetueefgfetfeefjeeuleejnecuffhomhgrihhnpehmrghnjedrohhrghdpgh
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
X-ME-Proxy: <xmx:0GEeaOfvuWa2-1rIJd-kWWr8qHyaKMaZ1PMmHMK_bVjgzTLz_tLywA>
    <xmx:0GEeaLNz7IGgdwC_lbYIX-FIihLvZ4gNwy5OXAhAnzmccZkmY_vg8g>
    <xmx:0GEeaImxiiVWUbehSpg4VR7oPbtbkqn4FzVRBqIwFczziiEM1JIgyQ>
    <xmx:0GEeaNs-eII8DSu3PtZ0WwxZ5WYrnwLief22A-WvoD_RTk2fjgtiWA>
    <xmx:0GEeaAVL4Qhx6uConpsT6UmvjfqM9Hs015vqv8JiNnv_1wyDXgkhjvNE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 16:13:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,
  sandals@crustytoothpaste.net,  Zi Yao <ziyao@disroot.org>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH] send-email: try to get fqdn by running hostname --fqdn
 on Linux and macOS
In-Reply-To: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Fri, 9 May 2025 16:49:58 +0000")
References: <PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 09 May 2025 13:13:02 -0700
Message-ID: <xmqqseldzgoh.fsf@gitster.g>
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
>  git-send-email.perl | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

As maildomain() is called at most once in a process, thanks to
send_message() conditionally calling it only to set $smtp_domain
that is not yet set, I do not personally mind adding an extra
fork/exec here, but ...

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 55b7e00d29..735d8abc12 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1393,8 +1393,20 @@ sub maildomain_mta {
>  	return $maildomain;
>  }
>  
> +sub maildomain_hostname_command {
> +	my $maildomain;
> +
> +	if ($^O eq 'linux' || $^O eq 'darwin') {
> +		my $domain = `(hostname --fqdn) 2>/dev/null`;
> +		chomp($domain);
> +		$maildomain = $domain if valid_fqdn($domain);

... we do not know everybody's implementation, especially including
the non stardard ones, of 'hostname --fqdn'.  Some may stay silent,
or say something only to its standard error, when it cannot produce
a usable output, which is the above code expects, but some others
emit whatever it wants to to its standard output while signalling an
error with its exit value, when it sees some error (like "I do not
know about that 'fqdn' option").

In short, I do not have too much trouble against the idea to add
"ask hostname(1)" to the source of maildomain information, but I'd
prefer for the implementation to be a bit more careful to detect
errors, more careful than "if we get anything on its standard
output, it cannot be an error and we'd use that".  I understand that
the call to "if valid_fqdn()" tightens the condition a bit better by
looking at $domain, but we shouldn't be even chomping $domain or
feeding it to valid_fqdn() when we know the `hostname` failed in the
first place.

> +	}
> +	return $maildomain;
> +}

Thanks.
