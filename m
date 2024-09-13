Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D953154C0B
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207529; cv=none; b=jQ9C7Yh9GZz49XgIfXq4LNp6xn6xW+qJDA9/9wEmW4d+DWclsuaQ2N7i/YX9maegYwXmrIC8ImVt/DtFhrgT6eFpGCyYpbaAVBhrCxTvOuuUDEuzBFAXMUktQhDI/3Fe9ybdEreKwvR1iszQN2MfhRVkenHJNxhOX2bZOeXMpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207529; c=relaxed/simple;
	bh=GKMP9OZ+AXa48AHAn97KD1YNtKg+ffp8oOfTm+ZHKkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a57sJO2wk25A7ppLKnALJCJ+9H5BnwBPZgTFWpN8GNFUAQZxXtTDsSETKa50fL8nJO6OgJYEU+hL2uS8Et2FjVIDuA2ea6qQdEDDMpI4H4o9n7OWHlF9y8tw/JCTNwXkaUbqemRneoj4qq7DwOo9H5oUURJC5jPU9siOHe+L5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JbTsUjti; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8ipiV4x; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JbTsUjti";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O8ipiV4x"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 976FE13801F4;
	Fri, 13 Sep 2024 02:05:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 13 Sep 2024 02:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726207526; x=1726293926; bh=hEv6shlOSX
	3YBM+RnqJvFaAJ2e7XH14rqQ9l62CMFV8=; b=JbTsUjtiTUw3FFf34LiBJkhW16
	EkGTFL3mI6f7o8MbgbEwZ/z5PBybfg4C5fi/jDA6CMm9y48awAP8eskDEIYT29C9
	q8gu7zSXR6uNVgWzBRA+5Y9dAMUHm8rnOjvRUzYkavS/pzcQgQz/kdsd7VpT4g+k
	FdRx4h7tjH9bGGTcGLN/OA5LR0hywTJEGpJ9C7wiVKxNEArUQtF/EJLEzzU+7ZbP
	a0EMU25O+sz9/Pm1tpTk+2nsR4B+CZHEZ1XqEeAXcnq+R2M4Jta/ZtPij0WFq8r1
	/Ic7jhyHFTVyyaKEeFx/hNaAPpxAiookj5w7WU4TSWEsprpFPuczgqQU5eAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726207526; x=1726293926; bh=hEv6shlOSX3YBM+RnqJvFaAJ2e7X
	H14rqQ9l62CMFV8=; b=O8ipiV4xdD81+1iC9hHv+YGw2GdTqjzR9QSTYCtp9CH+
	q0dt4s7C6WP5DdQG6TJOqVEzNiuJrFp6MMHnHy+7BPhFIm8G85+MR10o85ky7F7n
	RClA1IkNg7LUQBcuUvtyJ+rdFTW/Vdtiv1+B2PRLDb1VKQpKuiwBzh5S8jxwTJOH
	vu6PZXzb/CJXLDBjDJ3JG23byTLU4nBelTj2pJ6GYk4UBaCMpedUH8eEeaW7D1k3
	1F3/Xzzmh7vPhZgDcxMB3oGJBiW2RFy91XPssKJZoG1fCH+ONE5A3mI+zm8mWTT4
	lzalM8cz7Z+DRwvWC9MWm6iMXNnZNzIKSBlujWQ0AA==
X-ME-Sender: <xms:JtbjZsCxxHgqVZwsubdpsIkR5Ftygg0IeVwn0SrUTXmnpouvjQAZSg>
    <xme:JtbjZuhKaMjIERSRQFuu9rtYqwMowgiX3Nb-BzNhx93_g7KfT4skTmqig_8ncA7bP
    6MMzp4fyPxGx00gKQ>
X-ME-Received: <xmr:JtbjZvms9Dw1OXV0-sTVHtYoDN-Br_ufFUFBp5c5_I7PAKDPiK4rJeL80dK6VHb-s_ea-0oo878ZKyW7DFsyNGVZDqlyEzd5g1vSBndN47yaFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejiedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtoheprhhoughrihhgohhlihhvvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JtbjZizIBHC5YXE7GoQXar9P1XpsMdGH8Qq9w3VmMWDMc0Rrd8rY5Q>
    <xmx:JtbjZhSHtOpLxeG5ep8s-ELM0rH3qNtbQinWw4jfn4FytZwbezM2-w>
    <xmx:JtbjZtYXkH8m80DsAUGiiMfMgDxJTRYpMNZY5kwQRO9pLEGqKD31kA>
    <xmx:JtbjZqT7qcWKawAS7-HAtiSg6rBckmPf2ZXcSzXQkcZcaJGsabw_TQ>
    <xmx:JtbjZjdi9zEIlZ3VKDv4zx_vxhxBIB0plW1vK6hkptPuQxvFi8I6YgvU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 02:05:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 60c6ce3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Sep 2024 06:05:13 +0000 (UTC)
Date: Fri, 13 Sep 2024 08:05:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Rodrigo <rodrigolive@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] Git.pm: fix bare repository search with Directory
 option
Message-ID: <ZuPWIzzYda5aVjMa@pks.im>
References: <20240912223413.GA649897@coredump.intra.peff.net>
 <20240912223604.GA650605@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912223604.GA650605@coredump.intra.peff.net>

On Thu, Sep 12, 2024 at 06:36:04PM -0400, Jeff King wrote:
> diff --git a/perl/Git.pm b/perl/Git.pm
> index aebfe0c6e0..cf1ef0b32a 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -197,11 +197,11 @@ sub repository {
>  		my ($bare, $dir) = split /\n/, $out, 2;
>  
>  		require Cwd;
> -		if ($bare ne 'true') {
> -			require File::Spec;
> -			File::Spec->file_name_is_absolute($dir) or $dir = $opts{Directory} . '/' . $dir;
> -			$opts{Repository} = Cwd::abs_path($dir);
> +		require File::Spec;
> +		File::Spec->file_name_is_absolute($dir) or $dir = $opts{Directory} . '/' . $dir;
> +		$opts{Repository} = Cwd::abs_path($dir);
>  
> +		if ($bare ne 'true') {
>  			# If --git-dir went ok, this shouldn't die either.
>  			my $prefix = $search->command_oneline('rev-parse', '--show-prefix');
>  			$dir = Cwd::abs_path($opts{Directory}) . '/';
> @@ -214,8 +214,6 @@ sub repository {
>  			$opts{WorkingCopy} = $dir;
>  			$opts{WorkingSubdir} = $prefix;
>  
> -		} else {
> -			$opts{Repository} = Cwd::abs_path($dir);
>  		}
>  
>  		delete $opts{Directory};

Makes sense. We already knew that the $dir was relative, but only
remembered to handle this in case the repository was non-bare. Now both
cases use the same code to translate the relative path to an absolute
one.

> diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
> index ccc8212d73..4431697122 100755
> --- a/t/t9700-perl-git.sh
> +++ b/t/t9700-perl-git.sh
> @@ -45,7 +45,8 @@ test_expect_success 'set up test repository' '
>  '
>  
>  test_expect_success 'set up bare repository' '
> -	git init --bare bare.git
> +	git init --bare bare.git &&
> +	git -C bare.git --work-tree=. commit --allow-empty -m "bare commit"
>  '
>  
>  test_expect_success 'use t9700/test.pl to test Git.pm' '

I didn't even know that this hack was possible. I guess the alternative
would be to use git-commit-tree(1) with the empty tree ID, but that'd
also require us to update branches manually via git-update-ref(1). So...
a bit gross, but hey, if it works...

Patrick
