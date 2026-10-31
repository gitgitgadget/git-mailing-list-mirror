Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793449930;
	b=bcy9MhXEmRrFwVcjwYXng/ejiwLAr6fLiWoeiCV3ZiI0+jTaFcghPyaFiqM5DAp4sstW
	 B2X/+5BJvjtnNnMFLNg415L5LK8aEB5wjWW+8sc3EQmP3Yo/YPDRjYdUvQvz62SYA81ex
	 r9O8vgYYWRa58KSBS2UdlLn6wHl0cN1+wKvEXy2aKqVW2eHPxzdQCBg9HrDNfKu2bMfJN
	 qeFIvlwQkpw+G0n4xfnhVmG9zu6Xg6ioRvyLzlMw15ekLMq4R89EyCAPxzG9O0bq97bX9
	 N6T1lHdcG1Z3m2cbsCrrPZ9zsmyPui56fi3oUuuD+SYoI3siIwFlysfsS2Dw2oOeuZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793449930;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=tzuH0vc+mZTfqvZzmEda8bxQh1ldfiX4GTnxtfAXmw0=;
	b=zrhWQtfGZ+SkyT1Vi+rC7raS+TDxfChZDgCjCW2ascmX9CWr5DXJG+w4ZpvQ7z9vJLUZ
	 ZyZB+ELemwdf9OLW4tuh43zcfbaISq240OiglL9XYAaEjrOfIO2cwhgm5PE6KfA0qv6wa
	 b6ZZ3mcnh4IS+ARdIV0Kl+FBsAERXmxg4OVIWb2p73gTaYRtydL1tyQkiKngsZtw0dsf1
	 QASufdFELGtoawnA9WaNYtmgDeFA3cUuZqbNgGxuSEYHDyWMvBEMcJWUt819L5gHn1k4C
	 3pdu4t9en0nr/7sbu7Nenz+FukHXjVSre1nuNIlvW3aTee0iDhBFt9aALQ0x0/2x/NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=c7f26i1S;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99085606A31C
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 12:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99085606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=c7f26i1S
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 69VCVonA031171-69VCVonC031171
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 31 Oct 2026 14:31:50 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xN8FS-00ElQn-DE;
	Sat, 31 Oct 2026 14:31:50 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 31 Oct
 2026 14:31:50 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id d120d4a4;
	Sat, 31 Oct 2026 12:31:49 +0000 (UTC)
Date: Sat, 31 Oct 2026 14:31:49 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Linus Torvalds <torvalds@kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>
Subject: Re: [PATCH] describe: count the distance correctly when commit
 dates are skewed
Message-ID: <20261031123149.yxap3%taahol@utu.fi>
In-Reply-To: <20261031065525.19883-2-torvalds@kernel.org>
References: <20261031065525.19883-2-torvalds@kernel.org>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-09.utu.fi (130.232.247.49) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgcBxoeCQQMGygDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhcSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlRSBwHGh4J
 BAwbKAMNGgYNBEYHGg9IWEhaUUgcBxoeCQQMGygEAQYdEEUOBx0GDAkcAQcGRgcaD0hY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=tzuH0vc+mZTfqvZzmEda8bxQh1ldfiX4GTnxtfAXmw0=;
 b=c7f26i1SJew/nbAameZ7O5BDucNmzfQhw2cx0uBVn2IzMXc8os3V74W53P4tSfKt1Zt+KszDJNr0
	RiOdi/iag5pKI4XO9PtMIBrAeEMmyQDotdhcSqX8PFUTz6IXt1RRfYW85G+b3Jmrr/rE8SItUbop
	BsS7UCi0x9v3kPK6rd4+0jBFpkuMeSL0TLWhRubh2+hz+M9zDoO5Vk630eElxEhFdiePJSteB41R
	qN8xNFiICpBtMnRjSPVmXAtXVxf1nrv1u5VLKWd5km9zqddUonBaW3p/b26qUonXOM1fNV9X2yY4
	aoCkwZ3UKyye30Zqoa8Bz40krK4QwxcwKXiU/Q==

Linus Torvalds <torvalds@kernel.org> wrote:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> The current merge window for Linux v7.4 showed annoying behavior with
> 'git describe', where it doesn't actually follow the documented intent
> of the result: the commit distance is miscomputed when the commit dates
> aren't entirely reliable.
> 
> This makes the 'git describe' output not match what the kernel
> calculates in its localversion:
> 
> 	linux$ git describe && uname -r
> 	v7.3-19342-g2a500a04d6f9
> 	7.3.0-19059-g2a500a04d6f9
> 
> and the kernel calculation is correct, and 'git describe' is wrong. The
> number that 'git describe' gives (19342) is nonsense.
> 
> The reason is that 'git describe' has walked the commit list past the
> actual tagged release due to walking the commits purely in date order,
> and is thus counting a few hundred commits that were already included in
> Linux 7.3.
> 
> The fix is to take the commit generation number into account when
> ordering the commits. That will still fail if the repository has no
> commit graph, but it at least improves on the situation in the common
> case. With that one-liner fix, 'git describe' gets the correct commit
> distance on my kernel tree:
> 
> 	linux$ git describe && uname -r
> 	v7.3-19059-g2a500a04d6f9
> 	7.3.0-19059-g2a500a04d6f9
> 
> See also commit 1b600e659a ("Compute accurate distances in git-describe
> before output.", 2007-01-27) which fixed a different issue in this same
> area. Clearly the *intent* is that the distance number is actually the
> real distance.
> 
> Also add a test-case for this. Thanks to Claude.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> 
> [ Using my kernel.org email to send this, because setting that up is
>   easier than fighting gmail ..   - Linus ]
> 
>  builtin/describe.c  |  2 +-
>  t/t6120-describe.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/describe.c b/builtin/describe.c
> index c0abc931a5..2cd597d919 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -328,7 +328,7 @@ static void append_suffix(int depth, const struct object_id *oid, struct strbuf
>  static void describe_commit(struct commit *cmit, struct strbuf *dst)
>  {
>  	struct commit *c, *gave_up_on = NULL;
> -	struct prio_queue queue = { compare_commits_by_commit_date };
> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>  	struct commit_name *n;
>  	struct possible_tag all_matches[MAX_TAGS];
>  	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 7a7c46658a..a75f9227d9 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -749,6 +749,33 @@ test_expect_success 'setup: describe commits with disjoint bases 2' '
>  check_describe -C disjoint2 "B-3-gHASH" HEAD
>  check_describe -C disjoint2 --expect-failure "B-3-gHASH" --candidates=2 HEAD
>  
> +#            T
> +#  o----o----o----x
> +#        \       /
> +#         `--o--'
> +#            B
> +#
> +# T is dated an hour before its parent, so a walk by commit date
> +# reaches T's parent through B before it reaches T.
> +#
> +test_expect_success 'setup: describe a tag dated before its parent' '
> +	git init skew &&
> +	(
> +		cd skew &&
> +		git config core.commitGraph true &&
> +		test_commit --date "2020-01-01 18:00" base &&
> +		test_commit --date "2020-01-01 18:01" o &&
> +		test_commit --annotate --date "2020-01-01 17:01" T &&
> +		git checkout -b side o &&
> +		test_commit --date "2020-01-01 18:02" B &&
> +		git checkout main &&
> +		GIT_COMMITTER_DATE="2020-01-01 18:03" git merge --no-ff -m x side &&
> +		git commit-graph write --reachable
> +	)
> +'

Just a clueless rewrite of the above.  I had quite fun writing it, so why not
to share... it works and might even offer some not-completely-bogus food for
thought.

	git init skew &&
	(
		cd skew &&
		test_config core.commitGraph true &&
		test_commit base &&
		test_commit o &&
		test_tick=$(($test_tick - 3600)) &&
		test_commit --annotate T &&
		test_tick=$(($test_tick + 3600)) &&
		git checkout o &&
		test_commit B &&
		git checkout main &&
		test_merge x B &&
		git commit-graph write --reachable
	)

> +
> +check_describe -C skew "T-2-gHASH" HEAD
> +
>  test_expect_success 'setup misleading taggerdates' '
>  	GIT_COMMITTER_DATE="2006-12-12 12:31" git tag -a -m "another tag" newer-tag-older-commit unique-file~1
>  '
> -- 
> 2.56.0.237.g993442f913
> 
