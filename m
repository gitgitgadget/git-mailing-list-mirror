Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033C28A1F8
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427289; cv=none; b=LGvhtIfUghSSe+oMxh51/Y/+pZ31y3JlbDmJNSyRT/kFzVlBZlCUvFq2HS3LC9vQRnjVRPNK5bmodm0zdbmIetJs9y+I9mWUX3F/hCAAM9GurVI9YfOPZ2UFtnl7K+KC0j22OGVHklWsDpW7FLxmAw3NF1ZGU514ZO1NI5D/MkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427289; c=relaxed/simple;
	bh=tpxOfGWZMNVj0Mqspm03TIBYvpdKsCUOrmZbGDF0TLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GNozOwZxlVdsLMR1UDNLwg8yphZEX21BUPo0aNt2cGaXeylO9y0qhAagqBXZpqRSsRduy/DhIy4LJhV+9en3xT1s0LmWVS0gu1Nqfj4ztlDI9udRoJhNwZWTUpow1cWQJsXj79V9yRfx+o/3ITcLbn4F5knwrRtjF4TLo9fh0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GrllaxSc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T6HY2By3; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GrllaxSc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T6HY2By3"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 209BC11402B2;
	Fri, 20 Jun 2025 09:48:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 20 Jun 2025 09:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750427286; x=1750513686; bh=zE2lvu/OBs
	7Qj3H8uo+6KJ4PnCYWcI1atrqL7TWbcmA=; b=GrllaxScI1I8exWOWNMf0F7Sqd
	x6zrw07cX4EjswEHCLVcHcNybGtWuyL4Q1SQdy47tbdclIQGghgS9BxzTm1RAzMI
	oTMAvIrgvbt6yTuB2k1wsGwCfQz2sqf3Ax/bys14HlRpv2v47jS0fWLUoW8T1xp/
	vH4RyhfSvzznAu5+OLUMosV7GA2c556YbykRAS48mfr36RkyRstnOAVXrXAxb27x
	wzP959+x+83SKaKpO3QDLr2jIqweIgXRHbTULysggQHvLKWMfBzD0E/x6Fv7Uhhy
	Rn7Bn5i4kkWMDuuC9Os9XLmK+6shgRiuvrIRUfq13YN1VWttWkDN8XOgLSLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750427286; x=1750513686; bh=zE2lvu/OBs7Qj3H8uo+6KJ4PnCYWcI1atrq
	L7TWbcmA=; b=T6HY2By3pavDHRgsobKm8xnI0WpnfTPIQRn2w6ChTBYeaPBEFVl
	5ghOKTN7ZGefNpMaEK/IV29fxK9LHPTLYWn0NhMycVX0VkfZoZbSi9/4bPdaU0pM
	+fulLH50EPWSWLAwPx6iF0ua8N9ngH6ocguItDtHx16308hHFJjIWOfWz/wZBFYI
	YxBZ3YvVAC4gL4yx7WK69IXro5CL6kB8Vre+sewFcnylWoJUTkrvgaI3x9GaXtFs
	64HPTR7Gb/2UybppDUgQk6lB2k3rXxYML3uhZW2MfyaSoHBS1ykOgCkIgs6QJopj
	WJ1pUsZR4adbzclFjykzFA1aU3+DfBzQcsg==
X-ME-Sender: <xms:lWZVaCZkMPX079u4Xp3tRzClVpIZlyxknDLg7dNByBSLvQrcoaUhmg>
    <xme:lWZVaFbkkm6OsXwjzTc87DzE1BSljKl-XN0wmU5rrzmr5XEyzG6_K4XpgJxjk0gfs
    jfNIIEnB7gihyLC6g>
X-ME-Received: <xmr:lWZVaM_UWBgEgKdrrYD2Ual-vgusSeC5Q-z2svjXjsyMdKE54uHW0gnppKi3U_fD06f8oVDv78pT4V2Ouhip6QqNbJEhFcM795xn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepmhgrgihimhesghhuihigohhtihgtrdgtohhophdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lWZVaEoCvCJzNWAh21s0OW2sC9wc-j0lQSc50Vur6k1IJwFFwfmwGA>
    <xmx:lWZVaNo5lzg6XWv-eT-0LaI7yaY5yXLacC9n9BAcGNbTxvUryznw8w>
    <xmx:lWZVaCQaPNj3Nmib-_MEJfnkR0ZtSAgy5Pl2wu-zy32Jzp172BZk6w>
    <xmx:lWZVaNoK4dRsAzSp8QolBBOWblI3xYtUjtVMO4A7zjL5E00x4i9LZQ>
    <xmx:lmZVaNAP47xs8mFsC7Cp-Ur7Wgr8Ifqy4ZugkdxowogiERFLop3pjC8e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 09:48:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maxim Cournoyer <maxim@guixotic.coop>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] contrib: Honor symbolic port in git-credential-netrc.
In-Reply-To: <20250620041239.27839-1-maxim@guixotic.coop> (Maxim Cournoyer's
	message of "Fri, 20 Jun 2025 13:12:39 +0900")
References: <20250620041239.27839-1-maxim@guixotic.coop>
Date: Fri, 20 Jun 2025 06:48:04 -0700
Message-ID: <xmqqmsa27cdn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxim Cournoyer <maxim@guixotic.coop> writes:

> Subject: Re: [PATCH] contrib: Honor symbolic port in git-credential-netrc.

Please downcase "Honor" and drop the final full stop, per convention
(see "git shortlog --no-merges --since=2.months" for examples).

> Symbolic ports were previously silently dropped, which made it
> impossible to use them with git-credential-netrc.

Wouldn't it make sense to issue a warning message when a defined
$nentry->{port} is not unrecognized?  Wouldn't it make sense to
do so even before we add this new feature?

> This is a supported
> use case according to 'man git-send-email', for --smtp-server-port:
>
>    [...] symbolic port names (e.g. "submission" instead of 587) are
>    also accepted.
> ---

Missing sign-off?  See Documentation/SubmittingPatches

>  contrib/credential/netrc/git-credential-netrc.perl | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/credential/netrc/git-credential-netrc.perl b/contrib/credential/netrc/git-credential-netrc.perl
> index 9fb998ae09..ad06000b9f 100755
> --- a/contrib/credential/netrc/git-credential-netrc.perl
> +++ b/contrib/credential/netrc/git-credential-netrc.perl
> @@ -1,4 +1,4 @@
> -#!/usr/bin/perl
> +#!/usr/bin/env perl

An unrelated change to introduce the use of /usr/bin/env in this
patch is unwelcome.  Besides, this is a source that is processed
by the nearby Makefile, which uses the toplevel genererate-perl.sh
to turn the "#!.../perl" line to name the correct $PERL_PATH before
the build product gets installed, so I suspect that this change is
totally unnecessary.

> @@ -267,7 +267,9 @@ sub load_netrc {
>  		if (!defined $nentry->{machine}) {
>  			next;
>  		}
> -		if (defined $nentry->{port} && $nentry->{port} =~ m/^\d+$/) {
> +		if (defined $nentry->{port} && $nentry->{port} =~ m/^[[:alnum:]]+$/) {
> +			# Port may be either an integer or a symbolic
> +			# name, e.g. "smtps".

Do we know symbolic port names are always limited to alnums?  Or on
some systems some byte values in the fringe, like "_" or "-", are
also allowed?

Overall, I think it is a worthwhile to address this issue.  I just
do not want a patch that says "alnum seems to be good enough to
cover the ports I happen to care about" (or a patch does not even
say how it came to the conclusion to use :alnum:)---we should do
better and explain this change with something like "from THIS
SOURCE, the names users may want to use come from this set of names,
where THESE are defined as valid characters, hence we allow not just
digits (for numeric ports), but allowing also :alnum: is sufficient
to cover these symbolic names".

Thanks.


>  			$num_port = $nentry->{port};
>  			delete $nentry->{port};
>  		}
>
> base-commit: 9520f7d9985d8879bddd157309928fc0679c8e92
