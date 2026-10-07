Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0F3033CB
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353604; cv=none; b=qLiSto0FcWBxL2y5cuuHalzyRhC1tCs2qZoOwmWoRxK9K0HLmCBRVG0hqG5HT75CY51jjVB1TWG67O8RSPBfqI9er2oJjyC6kTfk9TaSUIFVjnAj1U/+KPWk+c8d3kHo7IoiWQQ9pXWWInubAtGfw20E0SZyxKHa0KSrHJCx/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353604; c=relaxed/simple;
	bh=EtQVHn9Rdijn3/yxhyWRcZGHsKpwYVRdYjsLpd7wulw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkjoA4QgTaAGFWKw2HW/og4mBMFp9O8FR3q6pHh4pFKolZSVU6kBa296Ppc78E1xF45wjfNlTbqXiNfZtyiafPfXrP1bY5EZum4/WDdkRfzGQK4YAX9ydDmSlr3+ECncCFeFUpnY8V9kHY+DeUVuND/Th0Ek6QLbfFMzSX+3mnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WIE9PYyy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGQnwXyj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WIE9PYyy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGQnwXyj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD94614000C4
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 02:13:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 07 Oct 2026 02:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791353601; x=1791440001; bh=5Zad8raSNZ
	oLU7YTdQNQog6qBR699Lcx1IFZrB8xulc=; b=WIE9PYyy7SmTIff0TpMK/mVm78
	E4sG8K5ABbQRppgWnTwOc2Hx1LLg63h1voswOb27XEcGLscBD42OYBsqUWXEWtOj
	5lrPbsCzFy2xfjnpUMNx1LnBESIbMFUjrVQcWh9slsuX/cZ+C+CYZym/GehE4nHt
	g57/TtXSW4D1ecoQy5Hsd6PTj3s31eXUFASx/sMCij3ivDRzxXOa54uhMsZW3zfE
	Y7WBt6KREWYKLerSrJs256eMgW3VdjXLdoRSur+ZOW+k9znTjQr/xImCi/Vt5DYs
	podm+72X7j5/VRj7ID9iTqlLcMVEMd1Stq9zVf06MrWlRyQtIljttAAdQItQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791353601; x=1791440001; bh=5Zad8raSNZoLU7YTdQNQog6qBR699Lcx1IF
	ZrB8xulc=; b=cGQnwXyjNDX7mmshVXz0hHfKRC4OV6rSRQma8ACfaKhMSpUfOSx
	FD0/2yl5thcwkhJBxnHnbFx6a+n2jKDf6tP+9kHKJtzWUCyUE7CVEhIhiFi4Y130
	TqH+GG5YGwU4nd2xvDYREdiMi62vIc81oiLLlktW0C1kNl8y2Uldmedle7Aje2gr
	IRPLkip/jYrYCbI7Uxovv98pSNR7HxTuA7DFS1IHVXOZNkVc4HiXX1ZJ6cT2FVHM
	MMWOCEk+cpBnFwEQkogvss0+JpZd1qTPiuAKlEMYlFkPPVYvH7mpb7HgWDVMb9Xl
	pceIJ/QGSFyfIGuvpuEqNUtVcyN1KjpdBiA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791353601; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sC4hPSla0OLqrrFYRIAusqegWAzYiW1QQGs+ascv85iuz/e
	przDp71wKfXDSPE2NAdN9TlEvEPjcumjoHSpKKi8uYFM3/tO984LNNmE71X+L2L8
	Qh2LuFaxfMAXd6BIrNWRoyCjaJaLwI6qwKHrtAUj3jILWX/U2pxUycW5eC+alzOI
	gkh6s/55DCYNuKhH5+Kj4mQuR9Hkwv1gdJ5giyx0be7wnVVaAt5+EhA+9hO3vSi4
	abWAPXKokO3bAdAayIiESofDRZUlr0WwIVuyl5YiWiunlUXjBqDrGcwA3Q55WN7K
	/5QNrF6HdGnuG/75uDniOi6g7Py4glSkw+6Qf7w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wesi5HANJEh6Yo2M6R88PFtFMKTlF68lfVRWgoR/loM=:EtQVHn9Rdijn3/yxhyWRcZGHsKpwYVRdYjsLpd7wulw=;
X-ME-Sender: <xms:AePFaqf_lLhjfrNNUw8KS6keNOYuaGcqCHfU0yelzMigGo2_msdJYw>
    <xme:AePFakbaXSmSNxqSjdIiy9Rz50X2hxJIyqucGRUtZ4L0vNySOBjt7MCov-f6a9yJV
    oxfZiGCLY5K7-Zr9YDzWUozgHQqdGjbwZz2Eit8LP9l8ez-pByhlgw>
X-ME-Received: <xmr:AePFatUccwPi9FKdFfD65RUEp567cVPvXS5zXIcYAwvn_Xfq1eFHlA>
X-ME-Proxy-Cause: dmFkZTGsPn5rD5vuqgoQXXrjOZKj/sdhs0mc1/mYqQZ70fZGv/fz0UVTvvJFN7X1zUUkEA
    tMbIbrtflq9WDoBexXVKXy0xjS60GcSYQ5fAwMiUEJJdukNjWUA3y10imRQngo8WzUuu63
    u6rF/pyNwe0wf632Mp/dO/3Rd5eIS9PAGkB/qk7d03r7vy2yyA9zPik22UW97knDCZylAJ
    4J+HSC/HBfN0kzNV+Z4NQCWlbCfvhlwWn/+P2Hngu/f/sFtCEqulvYfWYByRrTnpeTghYC
    kJNQ2+RxCnIwe3zJLLJKTA+2LLloX1tChVfEQ8uILVDnUbZ+0nRbHYCgahLpot/O8QqOi0
    FqkSt6NCZ6m+axk1JFmaGiJ4uBaD8du52cWI0GZip5ofG0q3ZzgbzKgxv6OSZCS1eViVo+
    phVilFWpP1K5XyfugVDKZMiU8JTc4Da8fuoCtH9YBiSp5flJ8Rc04c94UmFfiiI0rj4bo6
    DEBDGZSSRlFlqx3dyNOqtKclHwyEZ6YhB6Mz6jMHefDqvJEn5mfyrMWH8751GpqFIDwVkA
    c76aum1lcnJ05eKeoqTsFQrfJ8WsiDRT2OAGxD8E3jwziH8BrvQvyId8M5gt/a0igpbw6n
    p84H8O/TraX0KzKlP3YDYdJR/9BGVE2ak6T6w4ZIhPf6I+NVn1IATcJQJr0w
X-ME-Proxy: <xmx:AePFamgiDRiv64TpS9rtAOM6qcatR_4oVsaeIjDEx0uu2V6aUijfxA>
    <xmx:AePFarUB-Y-CkGWc_Xe1GIwGAdEeVn7Aw5KFquz8z6jdrGu4BEXBog>
    <xmx:AePFatMK_2hGQOowJFTh5CO7nLHKTy9SUZaE-t_g1EYU-lDniRAmOA>
    <xmx:AePFanYlp35jB6iTRdBg5jG2canA2mw1ph0_DgD8y19HqngA_Gxu6g>
    <xmx:AePFauvunlU5BKjqkYuUmw9Xc69DfsIT4eEhEx7M-GXSO4rc_pfVoECt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 02:13:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50d8fa29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Oct 2026 06:13:18 +0000 (UTC)
Date: Wed, 7 Oct 2026 08:13:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Muhammed Dilshad A <dilsheddilu123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] test-mergesort: plug memory leaks in sort_stdin()
Message-ID: <asXi-1RlWhqPMWjL@pks.im>
References: <20261007034205.32619-1-dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007034205.32619-1-dilsheddilu123@gmail.com>

On Wed, Oct 07, 2026 at 09:12:05AM +0530, Muhammed Dilshad A wrote:
> The sort_stdin() helper allocates an input buffer and a memory pool for
> the list of lines, but returns without releasing either. Discard the
> pool and release the strbuf after printing the sorted lines.

Makes sense.

> Add a test for the sort subcommand to t0071. The existing test only
> exercises the test subcommand, leaving these leaks undetected by the
> regular leak-sanitized test suite.

I was briefly wondering whether we could get rid of t0071 altogether in
favor of converting the tests into a unit test, and then drop the test
helper. And that's certainly doable, and I'd argue it would also be the
right thing to do. But unfortunately it wouldn't allow us to get rid of
the test helper completely as the "mergesort sort" subcommand is used as
part of our performance tests.

I would claim that the benchmark itself is of dubious value. It was nice
enough to have some numbers when we were working on the implementation
of the mergesort, but carrying it with us nowadays feels like a bit of a
waste as chances for regression are somewhat slim here. And if we ever
wanted to iterate further on the merge sort implementation we could
still introduce a new benchmark, that's easy enough to do.

But anyway, that's of course a much bigger scope, and I'm fine to just
fix the bugs for now.

> diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
> index 791e128793..3b8c428b14 100644
> --- a/t/helper/test-mergesort.c
> +++ b/t/helper/test-mergesort.c
> @@ -61,6 +61,8 @@ static int sort_stdin(void)
>  		puts(lines->text);
>  		lines = lines->next;
>  	}
> +	mem_pool_discard(&lines_pool, 0);
> +	strbuf_release(&sb);
>  	return 0;
>  }

The fix is obviously correct.

> diff --git a/t/t0071-sort.sh b/t/t0071-sort.sh
> index 2236a7e956..97890da29f 100755
> --- a/t/t0071-sort.sh
> +++ b/t/t0071-sort.sh
> @@ -8,4 +8,11 @@ test_expect_success 'DEFINE_LIST_SORT_DEBUG' '
>  	test-tool mergesort test
>  '
>  
> +test_expect_success 'sort stdin' '
> +	printf "%s\n" c a b >input &&
> +	printf "%s\n" a b c >expect &&
> +	test-tool mergesort sort <input >actual &&
> +	test_cmp expect actual
> +'

And having a test makes sense, I guess.

I noticed that there's another "generate" subcommand here that is
entirely unused. Do we maybe want to also remove it while at it? The
test suite passes with the below diff.

Thanks!

Patrick

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 791e128793..9200c4bb4a 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -114,16 +114,6 @@ static struct dist {
 	DIST(shuffle),
 };
 
-static const struct dist *get_dist_by_name(const char *name)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(dist); i++) {
-	       if (!strcmp(dist[i].name, name))
-		       return &dist[i];
-	}
-	return NULL;
-}
-
 static void mode_copy(int *arr UNUSED, int n UNUSED)
 {
 	/* nothing */
@@ -237,41 +227,6 @@ static struct mode {
 	MODE(unriffle_skewed),
 };
 
-static const struct mode *get_mode_by_name(const char *name)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(mode); i++) {
-	       if (!strcmp(mode[i].name, name))
-		       return &mode[i];
-	}
-	return NULL;
-}
-
-static int generate(int argc, const char **argv)
-{
-	const struct dist *dist = NULL;
-	const struct mode *mode = NULL;
-	int i, n, m, *arr;
-
-	if (argc != 4)
-		return 1;
-
-	dist = get_dist_by_name(argv[0]);
-	mode = get_mode_by_name(argv[1]);
-	n = strtol(argv[2], NULL, 10);
-	m = strtol(argv[3], NULL, 10);
-	if (!dist || !mode)
-		return 1;
-
-	ALLOC_ARRAY(arr, n);
-	dist->fn(arr, n, m);
-	mode->fn(arr, n);
-	for (i = 0; i < n; i++)
-		printf("%08x\n", arr[i]);
-	free(arr);
-	return 0;
-}
-
 static struct stats {
 	int get_next, set_next, compare;
 } stats;
@@ -388,14 +343,11 @@ int cmd__mergesort(int argc, const char **argv)
 	int i;
 	const char *sep;
 
-	if (argc == 6 && !strcmp(argv[1], "generate"))
-		return generate(argc - 2, argv + 2);
 	if (argc == 2 && !strcmp(argv[1], "sort"))
 		return sort_stdin();
 	if (argc > 1 && !strcmp(argv[1], "test"))
 		return run_tests(argc - 2, argv + 2);
-	fprintf(stderr, "usage: test-tool mergesort generate <distribution> <mode> <n> <m>\n");
-	fprintf(stderr, "   or: test-tool mergesort sort\n");
+	fprintf(stderr, "usage: test-tool mergesort sort\n");
 	fprintf(stderr, "   or: test-tool mergesort test [<n>...]\n");
 	fprintf(stderr, "\n");
 	for (i = 0, sep = "distributions: "; i < ARRAY_SIZE(dist); i++, sep = ", ")
