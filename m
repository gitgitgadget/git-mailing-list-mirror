Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6463A4E50AF
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626056; cv=none; b=utWuDgTIa29MC2phU43gzoyPWTSBdX1wFBI70guhS93rwGz24/10ITh6VILuat4cmYEJjhgvBOsxIcE224w8P58zU01WprIA9WMNs5uWWKKf1L0f/WKaEWjYMt9ThDId6DvUmXeTjOJnwMMgAvFnnpSho0N8uknLkp3nwFz+MV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626056; c=relaxed/simple;
	bh=sKfQz5yy29IpqCEGxLrk9oOzzRLeDk2aKwwrwt++UpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LLMGihSVBSc8Ajj52vcLWM4+tyrca1h9KpjbFw+gKsxgCJU98OnA6rx8Wfgbp18C3jUvvS7RQAmnYJQ0D3cb35QVG8d7CkA+DVntmpYAFquBbefx6+r+3fDFPSYEeB/Lt5sVniwGEXQFcj0YcdUf3+sZ8CyM17N/WZpSO7sxXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wLEYhAZA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDNnXcw2; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wLEYhAZA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDNnXcw2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A64977A00D0;
	Thu, 17 Sep 2026 02:20:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 17 Sep 2026 02:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789626053; x=1789712453; bh=DXXrlW+6A+
	baWNFW6CivBNL9CnGCdRFRUmpJsArDIbo=; b=wLEYhAZAuZxLwH37hS8PLkYbgB
	0SXMwQ+LTqd6e59I5MKNvPVigIBJLkHaKlU6Hzp1DbWeZXAf9/Qq+/jHN5AkzSsa
	Y2U5aTtSGGH2LOLE4cUSY2UrqmYwR2LAgf7noweh2ABxeo5dDnRmHAUyfyGfnose
	4vINdKDJCmqeiTQMIHDjtt5oi/nQWLg38n/C54uwvBUyzDzuzLhspPfbATsM2WSI
	UGMn3Yo/5tVT8a4e2+bK5wmUHNYBB8bnIDS/PGYWuJ4lG2mHT7Khi7q6ShKawI9B
	Nm1jgFbo0CuO2mngEqQrjxOojfVb14GnpKMfUwPhicWXIN3QhvLNRaNpb8EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789626053; x=1789712453; bh=DXXrlW+6A+baWNFW6CivBNL9CnGCdRFRUmp
	JsArDIbo=; b=hDNnXcw2AALHR67oOWOt8E2VSA4D4tI+5W/G7y0Dczee6z3H/hY
	rSmDES+rbtgd0ALn+4M9sjOvA21viT5Y1/evKyqlbv9dhRChpu00YT2z9AZfWwrV
	yz6zTenv5hHK78djqnUU32Bsw2WE/aZNTCAVG/ktJnsN31HRDxryiCyhkDMZlYep
	8UYbUFJBtyAGXR+Bm4IYQvEqkYSa3GfeLuih1fkoQvgXDEtYYSiFXngD5JIc5TfN
	e/lG7mNsDLphhZOZiQBAEO/38OQWhbiSfHERGfWiQDk0g48PvDJwuBMikDU3uLpI
	PBh00m1Js7Y9v8S820Pq897q5y7iJcBNHJQ==
X-ME-Sender: <xms:xYaralc78kvJRGyJlBJ_t9JAT2yjWVrXdyB7cQQ8TOFr4QAQqLAlbg>
    <xme:xYaraqplec-BIyX9_LxvmDEib8jPsdybilY3wfrNbm3DzWtIx1PiYAnyH3Yl9hmlH
    GtsqNM-7_AEkFGlXYgFSqW2N78Nt5DLvJS74anPlJAaH4N7Ggu6uA>
X-ME-Received: <xmr:xYarar4NPcEPnwmGvxvd_E0NZqVJ3K738v6GUQtDQcC7cxPqJuZtzQ-BbxuRhFsasoImVDQ6mWdfX8oB3vI9Eo1NLSPSy-zHKZc2>
X-ME-Proxy-Cause: dmFkZTE5Byix/1+dYlouTFJY9CLjy4cwsRL3LI4ppp2wZB/sNMQn2uB3orViZ1iFgY/yR6
    Pu6JtSfKed1v7ZL8cWG/WYzwIXaWY3GXS1r/DJDBA9pG3NU49K9X4A32JWi0Z4zqatnFuZ
    b8tlZ6qjaQypYEwrKD50n/RD9oEch2UpNJ9D1wgemgvdzuvRI3QHqB01u9kESKNBdsgkI0
    xahZx2of0DqNniSsaJ0QxtHoMuZmru2Wo/7ch2e4ZWeknsvQKqICjAbvpYGsQHaFNWFMYi
    Jp1S9RoKMnqDaQDpwF/PaXxBTcDVWhroMyovsTilKbcNmd95M9Bu4F8rqE7yDKWxGWwJSO
    TEXnpioy/c44e00IpNQtOo6ryAFD73vBaW87Xu3ajEzCY2CtKnOJykV0BviDQSsZLrQ4jv
    z98rcKpcxvY03cIqCu0P4m7LBt3MNd07BenPgaW8sz0jjFEBrZ6OD9kQlox89uToMnLppq
    DXnjp+/lnyoiQ9lqsF420ToT7SmoYfDTjaKrveZ1N0nTmzf6TcffuZHJdsZZ9xAmq2C9wO
    rQM/7ENWJadTuQ/6ICYDybV91PZnmesBXNO9rPx9bPwt9XI8p996mKlv3DCMveKoKYBnwV
    65lms107Rg8TAAYfPrG/DK0AcFx22XjFGHbkfuGlYItKxqaqk7LV01EtJvEw
X-ME-Proxy: <xmx:xYaraooRSnm7rtYirf1T39A5-VAkuS8NuJDXuYtkhXXeUJVDXSmnHg>
    <xmx:xYaraljv5HGWPZD3PZIJdV5qE07oYLYfBj0sIrWQj74qhwESM3JBWQ>
    <xmx:xYaraqJ5NC00xg2pUEuLhi5q8mOg7ZMmVvQ5MqHsGXL5Wa0gJEVn0w>
    <xmx:xYaratBfym_VcnCKpssrecsH5y6vcjk7HYGskUw23wM1paeQscivHA>
    <xmx:xYarasjbJnteBdA9AovVijpgreK_7EpWmD5L7P8v3deG-wbz_04cP5ef>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 02:20:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Royce Remer <royceremer@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] upload-pack: swap wanted-ref/shallow-info responses
In-Reply-To: <20260916203221.5265-1-royceremer@gmail.com> (Royce Remer's
	message of "Wed, 16 Sep 2026 13:32:21 -0700")
References: <20260915193009.222678-1-royceremer@gmail.com>
	<20260916203221.5265-1-royceremer@gmail.com>
Date: Wed, 16 Sep 2026 23:20:51 -0700
Message-ID: <xmqqa4pgv1oc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Royce Remer <royceremer@gmail.com> writes:

> When a server enables uploadpack.allowRefInWant, upload_pack_v2()
> sends wanted-ref info before shallow-info.  The fetch-pack client
> expects shallow-info first; receiving them out of order causes it
> to exit:
>
>     fatal: expected 'packfile', received 'shallow-info'
>
> This error condition only applies to protocol v2 clients performs
> a shallow fetch (--depth) against servers with allowRefInWant
> configured.
>
> Swap the send order so that upload_pack_v2() sends shallow-info
> before wanted-ref info.  This is a server-side-only change and is
> compatible with all existing client versions.


It seems that this bug existed in the very first set of patches that
introduced the ref-in-want feature, namely, 733020517a (fetch-pack:
implement ref-in-want, 2018-06-27) and 516e2b76bd (upload-pack:
implement ref-in-want, 2018-06-27).  There were a few changes on the
code around that area, but on-the-wire protocol never changed, so it
never worked correctly, but the ref-in-want feature is a rather
exotic thing to want in the first place, so it is not all that
unexpected.

>
> Signed-off-by: Royce Remer <royceremer@gmail.com>
> ---
>  t/t5703-upload-pack-ref-in-want.sh | 18 ++++++++++++++++++
>  upload-pack.c                      |  2 +-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> index 249137b467..9e2a090c9e 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -295,6 +295,24 @@ test_expect_success 'fetching with wildcard that matches multiple refs' '
>  	grep "want-ref refs/heads/o/bar" log
>  '
>  
> +test_expect_success 'shallow clone with ref-in-want' '
> +       rm -rf local &&
> +       GIT_TEST_PROTOCOL_VERSION=2 git clone --depth=1 "file://$REPO" local &&
> +       git -C "$REPO" rev-parse main >expected &&
> +       git -C local rev-parse refs/remotes/origin/main >actual &&
> +       test_cmp expected actual &&
> +       git -C local log --oneline refs/remotes/origin/main >log &&
> +       test_line_count = 1 log
> +'
> +
> +test_expect_success 'incremental shallow fetch with ref-in-want' '
> +       rm -rf local &&
> +       GIT_TEST_PROTOCOL_VERSION=2 git clone --depth=1 "file://$REPO" local &&
> +       GIT_TEST_PROTOCOL_VERSION=2 git -C local fetch --depth=2 origin main &&
> +       git -C local log --oneline refs/remotes/origin/main >log &&
> +       test_line_count = 2 log
> +'
> +
>  REPO="$(pwd)/repo-ns"
>  
>  test_expect_success 'setup namespaced repo' '
> diff --git a/upload-pack.c b/upload-pack.c
> index a52856d869..a70d237ad3 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1812,8 +1812,8 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
>  				state = UPLOAD_DONE;
>  			break;
>  		case UPLOAD_SEND_PACK:
> -			send_wanted_ref_info(&data);
>  			send_shallow_info(&data);
> +			send_wanted_ref_info(&data);
>  
>  			if (data.uri_protocols.nr) {
>  				create_pack_file(&data, &data.uri_protocols);
>
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
