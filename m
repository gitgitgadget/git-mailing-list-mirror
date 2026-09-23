Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F479568548
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191616; cv=none; b=lCRUlNeUCOfEt+I3KWvEgUAbBKr1/bqhU+O0LCh2iPTPefCfm5522g76Tx5sv0Q4d1bwPNJtYMUE9h8tGJc8n7fTUAh6ldxG1CjYXhnYzTApqmXcL9mv6cvAPyOMemu+OhdZzJFnP8Ej9ApyNP8Jx2TFP51CSaw8EeWfom/jtaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191616; c=relaxed/simple;
	bh=BNbVbuGw3RbkPD+SZeeFIO5q/Tle6+bkOilCpIxl3DM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M5uEIPzAODYFTeohLW0/JXymxsItwYH+Q3MfxgFYkT3gfQzxtm5d8D0yd9+p3gt36F+z58PBwJ17ht938jjS9q1dyMFCjhbuxkbmP/kjoFDJ4jnMVafCRelCmQRuDV4WB0k4+YBkK7k5/RJl4kw9PllK+/fZwSSJ/dlLB/XpymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D8hN3bqj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b5IKLwin; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D8hN3bqj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5IKLwin"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 29AE6EC016D;
	Wed, 23 Sep 2026 15:26:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 23 Sep 2026 15:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790191613; x=1790278013; bh=+3aMnsMlrG
	FKmCgw/dEy3ukiUjwCOHcQQqFzedCo2Ds=; b=D8hN3bqj64G0LBDJq9O/CliQyv
	Ljd/5RGcgVKVXKZZubPci4/iapuwJHqV8fpr602uL+9cTWqY2EgMLGa5H20BdjWz
	7Uj3W2Qf9SXcbruPwvEFqN2Rjd4k+5z+1OVcZdMhuXBnIGAMx/3f2QqLfK1xkNoe
	be1xxlRj2q4AVyLrNctnaacjiZtkPAfSekLJ0x1ihYzJieliPa6+wDuDDiKKQzzt
	ahLCiqVpbK1/Qq5A/c8nySm/GUYFWOnai5qaHGq9P7OLDpzMQMAZW1RtpF1gaa3T
	m5pGPhXZwicxmmaU4Y2VJskn9hb95c+oiTZprGqQPvkz/o8dyGBJoMPCaGvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790191613; x=1790278013; bh=+3aMnsMlrGFKmCgw/dEy3ukiUjwCOHcQQqF
	zedCo2Ds=; b=b5IKLwino0zjzLl+NM2Zj/4tyAebq+p+PrP6dqUjYGq7/32Vj0p
	qgmSLZFg8KW6VCF1+2mZbX4gK80ujrx0y7DYPluto6MT80IyGvz7j/izKbLl5no5
	KtBSRn8d6y0E0q8ICZL3mImw6TjLv9GiCwO16rXgBjuWU5OClsqLQrkVIyqeiFi0
	V3+DnQiQj4Ui5uoVOov7ifMQKfzJ5SNswbJFwVqxQRYrrAmRWr1qbjoJKzUGumN+
	EUiDUv7VeaX2vwXHgwpdwS1Sti0wny1xlyV4RTvC3RdcdrH30oGHcHja4suEKd+R
	l807Owaqz/01f2BHZOlyULCbDlDk5oWgfng==
X-ME-Sender: <xms:_Ce0aiBavSF5zZmH6vvRKyPSFrwLEWnuhv6qio9uJytcjZ-zjUgNWQ>
    <xme:_Ce0agNhiUlSXz-ZGNQWjRVd8sJkS47P8CmYsepGJlVjdgxcYe-pFj9vN7JnO_FJX
    ruPPZVJJPU0EcLA3sxMwqg3g4KEE1jG2O5f-KjtGSCl9dlGARXklsQ>
X-ME-Received: <xmr:_Ce0avZaLg7i0m0izy9dcVcn0v7HY8DiPedxJSbksfENL1qCfzVJ7Pb__7P8DB8NQE1VUbd9vDrz19Fkcdsp6UHQyXPp0Ed6MYsD>
X-ME-Proxy-Cause: dmFkZTFHaZeN7KZjc1yVEPGjYdyYHl+XlUZBZkz/ajQ4+EOrWSmTTc9DColtBkMft/qkYM
    7/xnUX3eR5RFvmPPKxube5EqVBqmLEjD8xZZr0APYIwntofue1IUhrSVY4t40NLGhR9IcM
    kTK5uQVQluCOG7aFu9kn48RNz7UwgyjTLK7o//b6wIdi7cbaakckCBS+AqxmBhGP7I8Lqm
    suP72Ue4kUjMchztfyT+FxQhbBzkFVxoG4NT7ar+VjuPoAe6L8gDs/zii+9lvpEAE4dRT4
    qr7ScecYNbGNbbw0DUp+RVvl0Pk0nvO41c3oooMsDPvFDReKWqB6djN3Y+qXyDU7kuFMMy
    HNTjGLdKCM/hgDRZ+xsxBciCNknwqMgxqqAMDIuH6GPAaF5a+WbOBgiqnQ6m5bGaXGNk9r
    mmaj6IpAjuAKKpsd20g7txyHKQ3LoFgTe/wtm1RF9hN1lFzIjGTBt352omcTUC02E1yjH7
    WaxV4nkYHYJx2uH74uy8xc4ZdwGVXFcajxblI+3IGFznm1BqYwXnPSj9rZrE4sjnM0OgkK
    94Y+fkFuWweaZa8nsB6HEYyKJRkJMANsSS19eI2GSA3lR+Gen9+mxJ4p4nb33dQKzdWT/B
    kTCCtd5fQhWAG+imp6mPVuhF8fVlNh3Ll6maxC9H1ANAaMayTZnn7apDC0/A
X-ME-Proxy: <xmx:_Se0ansuK8LfbOJwN5EN_P-jUGBanrRJP40r_yjX_JFJKS8MCEO9qw>
    <xmx:_Se0apMb_2E1MiK96a_yslfdTxK9CQw8xtM5Kz87pLZgliOXOzF4Ng>
    <xmx:_Se0am7uGGEdL0ifbzuI4p_7ZWcC5akEPm0_pT9mJEec4oiZUN5cvQ>
    <xmx:_Se0anTPRP188eiQHkfAskC180RwliMulwU1EAWFx5P38oqxaENsng>
    <xmx:_Se0ak9B0Vv34bboI66qGf7yEuUvOLB2KWZybqp2nHXo3FBWHxWe_r-W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 15:26:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  ps@pks.im,  r.norouzi@proton.me
Subject: Re: [PATCH v2] reflog: fix default expiry periods
In-Reply-To: <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com> (Pushkar
	Singh's message of "Wed, 23 Sep 2026 10:21:41 +0000")
References: <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
	<20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
Date: Wed, 23 Sep 2026 12:26:51 -0700
Message-ID: <xmqqpky3ahvo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> The default reflog expiry periods were swapped when they were moved to
> REFLOG_EXPIRE_OPTIONS_INIT() by 85658275702b (builtin/reflog: stop storing
> default reflog expiry dates globally).
>
> This caused reachable entries to expire after 30 days instead of 90 days,
> and unreachable entries after 90 days instead of 30 days.
>
> Reported-by: r.norouzi <r.norouzi@proton.me>
> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> ---

The above reads very well.

>  #define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
> -	.default_expire_total = now - 30 * 24 * 3600, \
> -	.default_expire_unreachable = now - 90 * 24 * 3600, \
> +	.default_expire_total = now - 90 * 24 * 3600, \
> +	.default_expire_unreachable = now - 30 * 24 * 3600, \
>  }

and the fix is very straight-forward.

> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 8f78cf4b01..c494aa5ef0 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -153,6 +153,51 @@ test_expect_success 'reflog expire should not barf on an annotated tag' '
>  	test_grep ! "error: [Oo]bject .* not a commit" err
>  '
>  
> +test_expect_success 'reflog expire uses the correct default expiry periods' '
> +	test_when_finished "rm -rf reachable-keep reachable-expire unreachable" &&
> +	git init reachable-keep &&
> +	(
> +		cd reachable-keep &&
> +		timestamp=$(test-tool date timestamp "60.days.ago") &&
> +		timestamp=${timestamp#* -> } &&
> +		test_commit --no-tag --date "$timestamp +0000" old &&
> +		git reflog expire --all &&
> +		test_stdout_line_count = 1 git reflog refs/heads/main
> +	) &&
> +	git init reachable-expire &&
> +	(
> +		cd reachable-expire &&
> +		timestamp=$(test-tool date timestamp "100.days.ago") &&
> +		timestamp=${timestamp#* -> } &&
> +		test_commit --no-tag --date "$timestamp +0000" old &&
> +		git reflog expire --all &&
> +		test_stdout_line_count = 0 git reflog refs/heads/main
> +	) &&
> +	git init unreachable &&
> +	(
> +		cd unreachable &&
> +		test_commit --no-tag base &&
> +		base=$(git rev-parse HEAD) &&
> +		timestamp=$(test-tool date timestamp "20.days.ago") &&
> +		timestamp=${timestamp#* -> } &&
> +		test_commit --no-tag --date "$timestamp +0000" old-20 &&
> +		old20=$(git rev-parse HEAD) &&
> +		git update-ref refs/heads/main "$base" &&
> +		timestamp=$(test-tool date timestamp "40.days.ago") &&
> +		timestamp=${timestamp#* -> } &&
> +		test_commit --no-tag --date "$timestamp +0000" old-40 &&
> +		old40=$(git rev-parse HEAD) &&
> +		git update-ref refs/heads/main "$base" &&
> +		git rev-list --all --objects >reachable &&
> +		test_grep ! "$old20" reachable &&
> +		test_grep ! "$old40" reachable &&
> +		git reflog expire --all &&
> +		git reflog --format='%H' refs/heads/main >actual &&
> +		test_grep "$old20" actual &&
> +		test_grep ! "$old40" actual
> +	)
> +'

This one is curious in a few ways.

For reachable ones before and after the cut-off timestamp, we have
separate blocks to test them independently, but for unreachable
ones, we dedicatge only one block.  Is there a good reason for this
distinction?

As some people worry about repository set-up and tear-down cost, it
may please them more if you create a single test repository, prepare
four cases in it, and test them with a single "reflog expire --all".

On the other hand, it makes it easier to debug these tests if you
create one test repository for each of the four cases and test them
independently, but if we are going that route, we would rather want
to have one "test_expect_success" block for each of these four
cases.

This "one test_expect_success block that has three repositories, one
is used to test two cases and each of the other two is used to test
the remaining two cases separately" arrangement looks puzzling.

