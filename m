Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DE35FF5B
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637223; cv=none; b=nnObIObJ0rX4UsuThK0uMArZNtp0h63FMQ5e2109f33Ia5zWYA0wEtZ34Gcxh0pIszAgNuCOA3FEMj9o/yvy2ilsZm9PizjZVT2YhXD+T5wICj0gcubs3tFIu1/OQmQ0kMeKdqorxe+yqnwYcjFsIt2xaky41RBFmneAbSKFthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637223; c=relaxed/simple;
	bh=kZ089lZxZgrSq6kBLJJMsWZruu4RckNw8bnTLTT8EMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E+tqynFaJ6vsvDJU+eao5On6LMxRRUHldkwQ4Fwe0LzHoCyPt43mqEbkbGvu9kIW1z8xNn4m25IhRDvea5/gBnhoGohyYS2kfH8vIeh8f9r9p55X37gZKKmrVosYokEyTmDmFlYAEw4Vytmdqtc3VExzzZzfy0/PC2T6cPsYONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oJgocX1h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GCFldHhx; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oJgocX1h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GCFldHhx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DAFCEC029E;
	Thu, 13 Aug 2026 12:07:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 12:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786637220; x=1786723620; bh=+OawQq23fL
	NRP1/OSn2cz/Y8QtnEyvEK/Uhp4unmYRU=; b=oJgocX1hczr2xf6HpIePGOTPbl
	UMc7X4+I3s7iYmiev6E/jIRHbpAsDkLLmxyHi333SQuERNZsqB+fzSX2IKVbKNM3
	TmZ/gDUi5Rq6yvOh0+joQ+Zk3SuedndDxaBgSzNFFcfah0On31m2+l8Z5DKonvuc
	n2pAl7HXUzX+7dmxNK9RvRqh0ctVTcKuT8hP1zBT3o4gqLj4tvvSDWMRnxemeXS5
	7NdJ8zk7KVcKwi1fKDHEWeFQdHM9hH6LEl9J/P/wAK4tNmMpjclxz2WfjS70blaD
	2ptSG4bd3zi+TlYuIsDshYOmMDrRwtf3yWmlBskbKlW8199Y7ag42eSaoeNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786637220; x=1786723620; bh=+OawQq23fLNRP1/OSn2cz/Y8QtnEyvEK/Uh
	p4unmYRU=; b=GCFldHhxsKh6d6VsBLaLWgSnvJBQXv5Md8n3YKw3frGZp6XBU0c
	8vSYaXD97auPL5DPiGm3cpmj9NJ4emgGXauSw0CqwOdQGF3Yw3w1eDHgGDn27Ilv
	ffHU9QiuLU+b61kpmKrtFPLn8mcesXWy2ceZajz1dgzE1iQKn10NDp/XzOnraT/G
	YERXUs6JPT6/bHUgQoZrDwORB0Rm76dja3mFyxgrEMn2secLZo2lTrvM8zrnWVfC
	3UdQWiWUc5hHmR328Y0etrjhOuDJcKN2nnHJaj7ZaLjmoarH4LXXrgG/t0uzt8U1
	DXbDm3kPkwM124nD4MDQuq6oYfXSoGOX71Q==
X-ME-Sender: <xms:o-t9apRK4HRZuYLYEjmNG_JPbL9gU7OZctJbaE2st2Z2tBd3JVN1QQ>
    <xme:o-t9amf6YVa40_RGSXQwV-NGkHseERehYkowVfmsE67e9AuVN7LMgjz-49M2E161C
    rDpm6hDx-IwMwLxJfAWzTzyr_UNMSPHdqedylhSvfpYGitUNq7tQw>
X-ME-Received: <xmr:o-t9aoqCZ0DVQcoct2CQouk3Eaxm6JFfxmjmwX4xgIKOxyoKVvTSrr6dm_NpJseV9Bc0Ij1GOmAA6-OjX0k-0MpK9dxLX5CC4A>
X-ME-Proxy-Cause: dmFkZTFjs+rNAoOEOojmyYTjwdijo8yG3cg71z6RZd6mYiedOtenUVKXF2IBhG46SNVzCC
    ILLcgt/bExhXXDWuM5XH0Ar5JE8DAQ5Y/FNn9WvQtz/K04BLQXDXYQqMG9qF3wGG7US3ny
    rlraRhneQaX+uWN+YZP8dqCLbIbOznaUfqa6eiRTUCdZx1wY4Oa0woHmlCb1c61OyDg5jU
    RteSC3/K5xlVM5/897wWkxD8JI+jVIAF23mXaffqx7Ns6FGQuUcvnYBnp+rU12mX4bjfuX
    1aNa6UsWbVoDIPlyksMHzkeXtSLvMX7Qb8Fi1DnrksqkYD9bfgKMX435tv+mBuJ/VvUUMp
    j6KC1fFwrOrDsqv3pPx8dCshwsdPokCIkowKW1G0BCRb1ZmJC8+lZbuW2Zoipt5BfpYlqU
    Kw6VkJttGBvmDPgDAqXCLcTXRM2nehVpAq2KjIj/4uC+vx0pOXH7tb5Ym/8sdDPQWRqiYx
    JUri/Wqlc2HXea0u8kYMW0+47ipiouUHC6rcBA54E4l7zHaTPHTrgyRDlZ052N/BwxjItA
    OEJE8iKTXiT2OC67rPdNhPJA63GIuCPGRSiw21ZjxXvo2RGNW3Rt3d9TLEW5uIfnTRgA5j
    9KYfu1y4KJMnAlLreZHiEXvH3WPCXBpi1iEuc67R/mjI84BrTRPTiu6l4Hxw
X-ME-Proxy: <xmx:o-t9an8AgFK9TDeBxfDxrYu6dJy01zF6yrL5HktKaq5CW4JHR1_bBA>
    <xmx:o-t9akcffB6GvIEWbQ1HyJt4aUPHLmoE1ooD4hu1_-3IHTXoghI8PQ>
    <xmx:o-t9ahI6l3Web_s0h5xim56-tvp6pb2qXKX9SepVfTjPSwjTSOcaMg>
    <xmx:o-t9akhcMCL6WifEDvrueF_M1S4V1Lv2HQLE8p2RAH6aevmN4KKxwA>
    <xmx:pOt9alCMltz1uIuHqTwbwkkmikQWdcvxUuZ8Ah5WDzIWBPgnO6YAxDsl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 12:06:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: graysongordon-gl <graysongordon1@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  avarab@gmail.com,  ps@pks.im
Subject: Re: [PATCH v3] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <xmqq1pc3vx9w.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	12 Aug 2026 14:34:03 -0700")
References: <20260811170200.43097-1-ggordon@gitlab.com>
	<20260811204407.52471-1-ggordon@gitlab.com>
	<xmqqldabzamj.fsf@gitster.g>
	<20260812182509.67358-1-ggordon@gitlab.com>
	<xmqq1pc3vx9w.fsf@gitster.g>
Date: Thu, 13 Aug 2026 09:06:58 -0700
Message-ID: <xmqqmruqt36l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> graysongordon-gl <graysongordon1@gmail.com> writes:
>
>> v3: rename the test from t5567 to t5568. t5567 is taken on 'seen' by
>>     mm/lib-httpd-cgi-safe. t5568 is free on master, next, seen, jch and
>>     maint as of b9720e4723, and sits next to the other http tests. No
>>     other change.
>
> I thought I first asked whether we need a new script before
> suggesting moving it out of the way because 't5567' was already
> taken.  It is much better not to waste a scarce, shared resource
> such as a test number, and doing so avoids breaking the build if we
> are not careful.
>
> If we really need to add a new script, you would need to squash in
> at least a patch like this to avoid breaking Meson-based builds.
>
>
>  t/meson.build | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git i/t/meson.build w/t/meson.build
> index 3219264fe7..3d68f67680 100644
> --- i/t/meson.build
> +++ w/t/meson.build
> @@ -707,6 +707,7 @@ integration_tests = [
>    't5564-http-proxy.sh',
>    't5565-push-multiple.sh',
>    't5566-push-group.sh',
> +  't5568-http-verify-status.sh',
>    't5570-git-daemon.sh',
>    't5571-pre-push-hook.sh',
>    't5572-pull-submodule.sh',

BTW, exit status of ls-remote is lost without the following:

diff --git a/t/t5568-http-verify-status.sh b/t/t5568-http-verify-status.sh
index c9167a05c2..7ba70fc8af 100755
--- a/t/t5568-http-verify-status.sh
+++ b/t/t5568-http-verify-status.sh
@@ -38,7 +38,7 @@ test_expect_success 'create http-accessible bare repository' '
 # server makes the tests below fail loudly instead of silently vanishing.
 test_lazy_prereq SSL_VERIFYSTATUS '
 	git -c http.sslVerifyStatus=true \
-		ls-remote "$HTTPD_URL/smart/repo.git" 2>err
+		ls-remote "$HTTPD_URL/smart/repo.git" 2>err &&
 	! grep "cannot verify certificate status" err
 '
 
