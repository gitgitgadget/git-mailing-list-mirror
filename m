Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635037C929
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469420; cv=none; b=kFnSllUXK79NQJ0njDL0SOcFBYXl8wYCDvJssyjJwuiKhjeEbJd+fXGTxGP6nAJYscI9MjQUSekUy7pEV3H9z9/55AaAOi0qn1l1S4Wr3rS47UHbsDfqAvkUWkntVsFJByDGfXXk3pP9Bayo4+w6TJcJl7kVWZTFlztHjmBJ1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469420; c=relaxed/simple;
	bh=LC5Y0DneSh05VvydbKCq4AsjV1I24y1OHLuY3W/XmgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rmQDz0Q8Jm0mZt6dOGOcskMNSdrfdmOaGT+uV6bzjBt/ygbanCu/JAi+B0aW2Wv9dL1cEec9ZShB/85XIV+ywnmlYc3ErWRThs46hx5EXpewBLR6yDpG8wc5R0nL6f0TL3KsT9x/zJFRMXILKaErpPbL+N8pLZSi0p7ZGqS9kKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nlYcUyN4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XtrKXzCC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nlYcUyN4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XtrKXzCC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45D887A00E0
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 10:23:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 08 Oct 2026 10:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791469417; x=1791555817; bh=TEjgT+vQY5
	bDVpj+snINQ60FBwXaLZXEPEAmhbTrrCs=; b=nlYcUyN45woaH5gcmHGXD7a5Tz
	NW0sIsXhAGfCrhjx5dyV0h1fN1jGgB1Xoy8LrlPD0xIcOlCGWM+fHZO21mv2Y3v2
	E8jmlmm3WZZMcJ4Tc2egQ5Dw8jU0Embrmjzt/v+wMCkdZ5BuRpfrhY759k47ercp
	56xGsePpcgEUfYiOePb815JvYBaAxGD1xbgIRE9Dqa41YGNhEup2uNXErsrq8cnS
	VsrdfNbouojJWIGSEGcwmmoUcHszzaUTnVtBivZKp8d6TrTBmCE7zzIwd9011kYT
	DSRP6iqNGW13ef1Hb4bPzKXvtIpHDpe20RuvWEWeJCVoJ+RHD0dbXnXWdF5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791469417; x=1791555817; bh=TEjgT+vQY5bDVpj+snINQ60FBwXaLZXEPEA
	mhbTrrCs=; b=XtrKXzCCZIyWWJfc2O9+ZQgpuSo9+JTudW83m1OmwTbBblfApwt
	gljO9O+UEiBnEMf+1FsikErXWY/3jMa7YmBEao8hA96iGe7pM+QfWvVeDsZXOh53
	Q6eo7d5fh3fHDDFq8mJ4QNR33bI9/rhwhw611JtN93EwZak/TUQw/TnuCEeW+fek
	5Xa1LRti6AZDRsL9iBEfRNx8sI0tElfZQW0sbzpJZCgSji7Y2OqJXmxtv574Tlfw
	Ac4oYBj1h2gGEiZuGmPA85r23JJw9QsB5UPEo/WrV8hYMldUWL4qVoJjGgBkq8gH
	IGr4LM8gRZlHaGAfDIRPqsUbF7556Snamyw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791469417; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KjN3QeL8VVn0ouiYzB4+r0DPvM3vXYJ220HSsU7uK/Khzqp
	N7An1oLoAQIhAwRSkoHLRJ7W0wEnAKXHZZZgrC/PCclKZ/EnsOshTHRwbj011JAx
	Fa8ZV7gLZDtZULznH8kZEh3cqjsoRPt8CkJVZTjd33+PdzH15/qiOGBt7tHJF3h3
	V5VChL8RE+lO781qv+gWOAVTrVcouBPrm+7n6oHcAQEaJ4RywTzwZL/oA72KImr7
	Pm2Z/Fq25ouZRUIqGEBUnCJHTRxl3ec2cBJTHXty8NiAIFRt0SWwUjKTNhkDAWSr
	lZ4YpoQWw/FMeiUajL/SBu8i2gH/esvpJeLJyqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ea+o+GZc+DHB21CIN7cMrvciT5qobDwNPyUy2ZXdygA=:LC5Y0DneSh05VvydbKCq4AsjV1I24y1OHLuY3W/XmgY=;
X-ME-Sender: <xms:aafHav1m5AynyBGzLdux3dz3IcWX6sAfoH6To8GBUMxm75YkaBkuwg>
    <xme:aafHapm6FaxS5-_yln07lSXzpqlm_BITVgAMEIzF_7s-0_ljznJd13WZ5XQYH--rm
    d-JjLsuJJuOvnhSig7pdxbo5PyIE-_jMAuWD5Lx0WsngT59VUuqzFz->
X-ME-Received: <xmr:aafHamUTkwO1tZahqkAXplUB0Y5QwEgguC9AodptaaSs1wt-7iCUwwF9M-tDOsKR5ReZyxrPvHUYIDryPwydj9Y1Lde7XYJencB->
X-ME-Proxy-Cause: dmFkZTFcW+zZ1moFUdeTV9c6f1Kk4wkcoEiAoeD5qG5BIrq1rgvjLBe5r+HVBIaWPLRmIV
    PZ8Gwf2IDbLhl0sLg8XhCm+UR7hXwFScubSURmEeC2ISjbwtaYgMx0lcm2XW0SPDVoC9Db
    cWOWBl5m1eYSmGlujBDWfypgesWOR96Bw1EjboC++Cn+xo0kZz8Zwbo8yjM59a9Dlr4Z0P
    q9gO23ceQBm3D9iKqXn7x0SNrVA0/ZZxALTqFwRcr9BF71YivaNeZz+WU2Lcghr62KO+f9
    szfhhxCjb4o3sA0QsAOymJthTadfi5XhbpDnJDiic3cyNaGvRQVGwwmf4Yj5auwYUmkzfc
    DQl9HKfPMa4nrqNfSbhwXMerp/ijwkNTAzVv0XDRSGnvYw1w9sfdKLEPq2TsTq5g6vSzlA
    0296JG3e756iNNqPKywQTbgFqkOGMgMXd03PuKayC/3qSI2x0wJBGDobCqUcYRS1Pw0cGm
    UoXNoduFe58uALs41zUJskOcxgQSgo+02pgkj3uxSediUcCrpz1XaPMafB/D1hKuk+ZC7s
    tfwq2VZznVCfhLnpkc8apGc1k0A1hngVw7hRTNrL77kp4nUNzoP0pbDonYluvmHm3O4dcV
    lSDSjuEMdF2YOdYmCPkcv4Uxbd4Iw81nmhw9fEMdiyk255MGiIMoqP3j3hpg
X-ME-Proxy: <xmx:aafHavu8PVUD4qTp4aM2MgFm8sPncI94okYV9s0x6pU6YrkKK_zkKg>
    <xmx:aafHapZSc6jzcTT2UhtXkcFV-mgWSWiM0BtQ1xA6Zkz1KCi-JJlkuQ>
    <xmx:aafHauU1zuHhXM7513gJZV-2ifwr35ucbymZtpU9l6M0jJZMzbgUoA>
    <xmx:aafHauTxxaWx45gC-yk7ywOhVldjktNmfYEEiXmmsS5ALMJC1wNiDA>
    <xmx:aafHajHmYCTIXSDdFuSCd8zQfztkAUjIfghTkP9mMyhmZpITKOBbwuyY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 10:23:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  coygeek@gmail.com,  ben.knoble@gmail.com
Subject: Re: [PATCH] repack: do not rebuild packs on --dry-run
In-Reply-To: <20261008062521.25505-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Thu, 8 Oct 2026 11:55:21 +0530")
References: <20261008062521.25505-1-r.siddharth.shrimali@gmail.com>
Date: Thu, 08 Oct 2026 07:23:35 -0700
Message-ID: <xmqqwlrs2rvc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> "git repack --drop-filtered --dry-run" is documented to list the
> objects that would be dropped "without rebuilding any pack or
> deleting anything", but it does both.
>
> This is a bug in cmd_repack(): after printing the candidates, the
> --dry-run block falls through into the regular repack code.
> repack_promisor_objects() writes a new promisor pack, and with -d,
> existing_packs_remove_redundant() deletes the old packs. The command
> still exits successfully, so the user is not told that the repository
> was modified.

Very interesting finding.  I am curious if this was the case from
the beginning, or we broke --dry-run unknowingly as a side effect of
some unrelated changes.  If it is not too much, can you bisect and
document where we broke it in the log message?

> The existing guard only skips the implied "delete_redundant = 1", so
> it does not stop an explicit -d, nor the new pack from being written.
>
> Fix it by returning right after the candidates are listed, and add a
> test that checks the pack directory is unchanged with and without -d.
>
> Reported-by: Coy Geek <coygeek@gmail.com>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
> Bug report:
> https://lore.kernel.org/git/CACgTecOm+=vbf50tZNXhcYvRi1ZTsQwbjVoJAbQqs2CmXdJCxg@mail.gmail.com/
>
>  builtin/repack.c                |  8 ++++++++
>  t/t7706-repack-drop-filtered.sh | 19 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index c4360382c1..c048053912 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -391,6 +391,14 @@ int cmd_repack(int argc,
>  			oidset_iter_init(&drop_oids, &iter);
>  			while ((oid = oidset_iter_next(&iter)))
>  				printf("%s\n", oid_to_hex(oid));
> +
> +			/*
> +			 * add an exit here, so that dry run does not
> +			 * go on to rebuild any pack or delete anything, even
> +			 * if the user explicitly asked for -d
> +			 */
> +			ret = 0;
> +			goto cleanup;
>  		}
>  	}
>  
> diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
> index cb36115834..a1c475e4ec 100755
> --- a/t/t7706-repack-drop-filtered.sh
> +++ b/t/t7706-repack-drop-filtered.sh
> @@ -135,6 +135,25 @@ test_expect_success '--dry-run does not remove the filtered objects' '
>  	git -C repo cat-file -e "$BIG"
>  '
>  
> +test_expect_success '--dry-run leaves the pack directory untouched' '
> +	BIG=$(cat big_oid) &&
> +	packdir=repo/.git/objects/pack &&
> +
> +	for opt in "" -d
> +	do
> +		ls $packdir >before &&
> +
> +		git -C repo -c repack.writeBitmaps=false \
> +			repack --drop-filtered --filter=blob:limit=1k \
> +			--dry-run -a $opt >out &&
> +
> +		ls $packdir >after &&
> +		test_cmp before after &&
> +		test_grep "$BIG" out &&
> +		git -C repo cat-file -e "$BIG" || return 1
> +	done
> +'
> +
>  test_expect_success '--drop-filtered removes the promisor blob locally' '
>  	BIG=$(cat big_oid) &&
>  	SMALL=$(cat small_oid) &&
