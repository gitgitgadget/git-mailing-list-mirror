Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B55C22FDE6
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852536; cv=none; b=sbCttzWiPnwZb2CSuIFEh8lw/bNqML36MxZzh3IXAlPRWbxsKbEJL8rC3aY1duRLFVWCd5g+DpHxNyWmtxVoLQQOMQs3LmrpDS82Ui34kV4Xg4TkWOkZcMYIViLFVZnJeh1qCbtZcouw7bK32h9ZQjvo2Tn4F33PLEPXNr4eX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852536; c=relaxed/simple;
	bh=AJljIufw5z/eEfpKPaW8jv8Kv+uZZbk63RTlVPzNGrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ksL2Zq11TWZFR57lEC0g5/XsoOBaANraqJTFdueH7lXI6Pg7U+xSNT2CS10oaEhEUt0WQkW/wmm2L8aIHVUv6QmSh3/BKCE0PF5ne8340WVVvyQLNlPazuI5Vjr3oHmPXgZDikUbiKWzaJdoEiTkxvhExiStcSJNLtUplaLXSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OTVHM79i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ANOAjkX+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OTVHM79i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ANOAjkX+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F825140012E;
	Thu, 27 Aug 2026 13:42:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 27 Aug 2026 13:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787852533; x=1787938933; bh=PQVFIdtsNT
	/AW5GX8ATUy8Idplb1p1gEbc8RmsOweaU=; b=OTVHM79iNM7KhXmDWkfqyegNHF
	zLmQ6ynZeosmP3MTvqSeVXwOCbdtNSa5pFyFBMzXJfnvNgxtjmI5otzhhOZ91KVH
	k5TxtNp7VCVzXiPeEwkUx0cc4GVfV39YxBtrY+qu+uoKZoTE60oDutL25go+FEnz
	CjKLb3qecE50TwCcQokAg3RhIENAVEzQbPuCOmnuPXSAxZkQFKVx7xlJ1SeN/XVL
	NWaPUa/dC+RaWR5ELrwlOk/rrVOdtdKmlsKgvoDG/+IcTrKkesIUwZHi/fYgfXlC
	PIuLX3XihkVCdy6ov5uV0loB3nx544XuYZcFOkWndSS1iYGDUsRqIStFVdmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787852533; x=1787938933; bh=PQVFIdtsNT/AW5GX8ATUy8Idplb1p1gEbc8
	RmsOweaU=; b=ANOAjkX+QwY4P0PnrMJApjGoKrHMnnzPdA8LP15Du47z9AhOAdU
	heyhlG/StpPHYdSbLPuIx489dzeDF8Kss+WVrcSkbSAa8OoKcnLUFVZF/glv6Ac6
	RN+VndoYxfl/bLyZFSiHckxsNpSkK1cjL6XRi+C3qISp8zXypo4EroNHZWbF8NNr
	0SktJGwcUQhd5noMFX5ewgErxwibPNQvVdBboDM3Fz3t8zAYUE9/Vlxk8bzWVt3z
	cP5hfaC+rB6cd/Tvd3TO+JKrv7bS63hFbzGg/j+4u3jlqXasxnxz5No0XVQmBNs0
	vDHQRBr3wQ+gQsTUezp56Q1baLDSPF3rN/w==
X-ME-Sender: <xms:9XaQat0ErwWoZEosK8Xs4YHZcMR8KEIjPpsIvhwp5nVDCI3tY7PuKw>
    <xme:9XaQariXcX0GFaQOKK5khtMbWON8tVgGMmAJfugS8EdOAH7zBZM0Zti-3k1PLGzIa
    DCifQmqp6y93OBtL2jQubsPchwL-8B7y6CMqYhND8MaX6Vo_UGesw>
X-ME-Received: <xmr:9XaQarTxyhk-cHFEFQgOVHhu7YEyM4iHa2_jmCiBzTi998vKGJSGU-VJM5MPEguI6z1runrLdUpd3opZR-U6TJb3RSeIY1YS3A>
X-ME-Proxy-Cause: dmFkZTEeGOGHKOjWwK4D0QkNkD5MdHnRzl5r9v2aRxiAod8WvufT+DpBm5w63e/5X4Rm56
    vqyozRX9T/WU55SOELeyK8EkGiP8qlrZQkNekhKJ2SqtUOv/1HSJcP8D1ibKkyD2AhsM4P
    RgnQKIqask1FCyLA7JyLzb7W4FJvRPTw1EzP8toVN5rhTIRQ1fN/mkwyY+tiDQCShCZP/9
    4yeBUQB+zmsjQJ+2Sn+4ZMvl6u6Db0+5gZHxsHukk1q8A472+durT8x/r4G3vTu+Bcz1eZ
    nr1ktfTcrxuIj6jclAyVgZGpmQOXlN0PrlpB8s+yitK4tOHIlFmXjolDC/OK+Gx5wC4XbS
    w/wBEBGJZlXjMyy7Ja7DW26pvdp4xMTj2acCeMoj0wJL68MuYpK9LdXux9Rv3mmcIdfm7F
    3teaCS55x5vDx4zPddDn6db9C5VawvLehD1ID0uAqLAeozI5itu0ac5DW/H/eLZKf0WbeK
    dTyoE8uT8RNecnTrkciRQdrV9rQEyDLQdNHK6UaeEIktKuIiHPj7cu5/3AVuSWjYCG4IFD
    fXQ6GntK4/988XhpbfuZtTiOUdeZQB9HzBBvgC3/7G8SZZs6wZ28QfLzVn0SRxTUTCIDvn
    e3kKa8gkLMd16mTeq8CXKbT4cSbzvZZcY4HS2I9jierhqxARh2jl5Wh9bDFg
X-ME-Proxy: <xmx:9XaQakglSyP6WBNFXDKgq_13wkgNTPo3867vIn48DLPq4wgmhHKQkA>
    <xmx:9XaQaj4LP8NbWTNW6E11qXamEG1IRqOxnO3mOc27U0a8LDI6jkpH1Q>
    <xmx:9XaQapD-qvFG8joq8KHjJd0xsyziymTjaJ5OLo990ggpaH-COc2rew>
    <xmx:9XaQaibNFoFNp_zIAigI7PoqpbOBz7rKWnWUlAdDKNI6985WPi5sjQ>
    <xmx:9XaQapsSWBSL13bSyDOdigk2PGenFAPOckxiDDupwxWhI7zfO_InIhWA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 13:42:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Wesley Schwengle <wesleys@opperschaap.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] git-svn: don't print v1-layout migration noise when
 there's nothing to migrate
In-Reply-To: <20260827165134.848207-2-wesleys@opperschaap.net> (Wesley
	Schwengle's message of "Thu, 27 Aug 2026 12:51:33 -0400")
References: <20260827165134.848207-1-wesleys@opperschaap.net>
	<20260827165134.848207-2-wesleys@opperschaap.net>
Date: Thu, 27 Aug 2026 10:42:11 -0700
Message-ID: <xmqqy0dr8npo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wesley Schwengle <wesleys@opperschaap.net> writes:

> -	print STDERR "Migrating from a git-svn v1 layout...\n";
> -	mkpath([$svn_dir]);
> -	print STDERR "Data from a previous version of git-svn exists, but\n\t",
> -	             "$svn_dir\n\t(required for this version ",
> -	             "($::VERSION) of git-svn) does not exist.\n";
>  	my ($fh, $ctx) = command_output_pipe(qw/rev-parse --symbolic --all/);
>  	while (<$fh>) {
>  		my $x = $_;
>  		next unless $x =~ s#^refs/remotes/##;
>  		chomp $x;
>  		my $info_url = command_oneline(qw(rev-parse --git-path),
>  						"$x/info/url");
>  		next unless -f $info_url;
>  		my $u = eval { ::file_to_s($info_url) };
>  		next unless $u;
> +		unless ($migrated) {
> +			print STDERR "Migrating from a git-svn v1 layout...\n";
> +			mkpath([$svn_dir]);
> +			print STDERR "Data from a previous version of ",
> +				     "git-svnexists, but\n\t",
> +				     "$svn_dir\n\t(required for this version ",
> +				     "($::VERSION) of git-svn) does not ",
> +				     "exist.\n";
> +		}

Delaying the initialization and messaging is a reasonable idea, but
you lost a SP in the message (there might be other changes I failed
to spot---I wasn't especially being careful).

>  		my $dn = dirname("$svn_dir/$x");
>  		mkpath([$dn]) unless -d $dn;
>  		if ($x eq 'svn') { # they used 'svn' as GIT_SVN_ID:
>  			mkpath(["$svn_dir/svn"]);
>  			print STDERR " - $git_dir/$x/info => ",
>  			                "$svn_dir/$x/info\n";
>  			rename "$git_dir/$x/info", "$svn_dir/$x/info" or
>  			       croak "$!: $x";
>  			# don't worry too much about these, they probably
>  			# don't exist with repos this old (save for index,
> @@ -120,21 +124,21 @@ sub migrate_from_v1 {
>  			foreach my $f (qw/unhandled.log index .rev_db/) {
>  				rename "$git_dir/$x/$f", "$svn_dir/$x/$f";
>  			}
>  		} else {
>  			print STDERR " - $git_dir/$x => $svn_dir/$x\n";
>  			rename "$git_dir/$x", "$svn_dir/$x" or croak "$!: $x";
>  		}
>  		$migrated++;
>  	}
>  	command_close_pipe($fh, $ctx);
> -	print STDERR "Done migrating from a git-svn v1 layout\n";
> +	print STDERR "Done migrating from a git-svn v1 layout\n" if $migrated;
>  	$migrated;
>  }
>  
>  sub read_old_urls {
>  	my ($l_map, $pfx, $path) = @_;
>  	my @dir;
>  	foreach (<$path/*>) {
>  		if (-r "$_/info/url") {
>  			$pfx .= '/' if $pfx && $pfx !~ m!/$!;
>  			my $ref_id = $pfx . basename $_;
> diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
> index 6d7d2aa491..a27f7f6171 100755
> --- a/t/t9107-git-svn-migrate.sh
> +++ b/t/t9107-git-svn-migrate.sh
> @@ -1,15 +1,22 @@
>  #!/bin/sh
>  # Copyright (c) 2006 Eric Wong
>  test_description='git svn metadata migrations from previous versions'
>  . ./lib-git-svn.sh
>  
> +test_expect_success 'migrate is silent when there is nothing to migrate' '
> +	git svn migrate 2>err.log &&
> +	test_grep ! "Migrating from a git-svn v1 layout" err.log &&
> +	test_grep ! "Data from a previous version of git-svn exists" err.log &&
> +	! test -d "$GIT_DIR"/svn
> +	'
> +
>  test_expect_success 'setup old-looking metadata' '
>  	cp "$GIT_DIR"/config "$GIT_DIR"/config-old-git-svn &&
>  	mkdir import &&
>  	(
>  		cd import &&
>  		for i in trunk branches/a branches/b tags/0.1 tags/0.2 tags/0.3
>  		do
>  			mkdir -p $i &&
>  			echo hello >>$i/README ||
>  			exit 1
