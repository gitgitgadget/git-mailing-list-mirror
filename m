Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D17A3CC327
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944829; cv=none; b=S/E3aQRWQksQLQ2XbkdFUIaliUS5YbMKOmUO+2Sl3rpX5DKZzFm2g1jIarenaoq4wdmPZlYXhL8Xut3kjViyiHdFBxFGijZ/VXgKmbUZPy2botI5lSTiK+0kbJ93XZ5H1VG5yCdErPZjL3WdNLLH95K/yVdj9S4zz/p42yyelSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944829; c=relaxed/simple;
	bh=C8QsErMKg5vzU6ECnbQ20YE/AqWUXKgP2ns2bze9Ygk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CF2glUwwoVHTX8JioPl1UFci3kNAeL/KWUQySabn5wZW5I810z/vwRkt8mhgIwftkyl3+eOoN6UC6uH2dECK3SMXjpLJ6kb2/KKhDQxJuTkJ4P0tEAowX7k5xABYxDvoiPtbT+FOxMkkCWknAWSdy6nNaH/uy4SFe7gGSs9Xk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KMWjjcBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJ448wq8; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KMWjjcBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJ448wq8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6391A1D0007C;
	Wed,  1 Jul 2026 18:27:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 18:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782944827; x=1783031227; bh=KQJF1FuxpB
	9xudsE+zRCZgSQ83MfUW1TksM2r4hdcNE=; b=KMWjjcBM/tVboeVbboUVPNCap4
	q5OqWF0nknLzhmCjBvNjLJgPRnwP1Bqu6QwBi0X2TOfr0g+tTyagdKY2ZJKjOR3o
	5G+evKKX+hk14Nxa2qcITzlT9zWVvac/tN2AzuhQTUz/Dv5FY+icWcPf4nXZSlFI
	mfpBwvwjG674Ey81l6nQyTn35phXxQYLO6FeC637w3B5BZZxV7qdNvV06bT3VAwb
	niofqKp5fGnx5WG2uOfbucfnr713jl0AwD4i/gY/Al8+h++zwnZqwXgif0FtG28q
	WIoihFQH/iDMWouYeumxQVU1bs2wuxujIqjJecyz7FTLVZSaucGu0VvBcSIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782944827; x=1783031227; bh=KQJF1FuxpB9xudsE+zRCZgSQ83MfUW1TksM
	2r4hdcNE=; b=ZJ448wq8RdTyi9JxymDDtz6a7xHD8mLSf/3CibcnK5NvuIX040J
	UVoQsxpzmHGWzXugUhYWjOQ3uJzRnt9uoi8kqlg+LhHN9i7GpMjrz5ApxURZiDey
	sucNSos0/QUmkeB6wpdIl+ZnXacbSH4hq9i6kYqp3L23D1DWQ4xXc7817or/Ijfq
	WcfP32FFbYBsLS4rdqHIqeDNzk3Y5qJI/TuVvSJNYgJnHLu1urQCOb5KYT+/SJkd
	PnYDg6h8i5vggewpS7Av1tolv9pMgiKMSuejIn9DI9P4kTao71QpZQbpJHI8D91i
	XW1NSoqiEcaUnhebkADdmO+c1s5/cIWb2OQ==
X-ME-Sender: <xms:O5RFakg2GJL9SE-rXHhYglKx9MQloDxPzlT9YiUu2GnPbwo-NaJPkg>
    <xme:O5RFannaXd1s6cBJK7dYw4YvnASwjrV0YpKVTFV2mUXNsj6YwlvBoEMn62P1Uz54m
    xydF_zeGOKpPMtsd8cU4VO9pzHdMvwWSO5pA3W-3JLegBTqjDBzhw>
X-ME-Received: <xmr:O5RFaorJ6sHmo6HOj5RdmTZeJsgavZdfQvVrQ9izQep--xMDgnK-euFiIXyUaP9jb2liiKJ_eW-SuznbDInIgxcfMQPM_Fll0HhJ_7k>
X-ME-Proxy-Cause: dmFkZTFf6lRxYhvY+9fBBVuoGORAsi2PiHiZK0YiFf3g+t8qVq4XoY0VXS5Hnu3UVCDCOH
    8cW112+QiAyvoll8C50N1lTMSSphP6Re7M1+YfjhNk7aWh7EOcXYXHSuQB/l0DJS//GHhN
    ZZHN9SkEqzpQFoHAknyVnnzriD5r8fbgzCkWYG9Hu1V7Px/vr78zCPvJ1TDcjj3zP4R/DO
    iavnIJ+dB7YsOvUQSZtw+F4F8vpPx1CW18bDcZQuC3ezE2mP5TY518pp3sStV1Ej7hRiqm
    CIbJpQWdgxJZ3U9hmzZKWK3ME+JnerXLTxOqRey5U4R/V8/MqnyYfuSFARKDXLkFtjIKSA
    cEMNAqNRcsEgkW15vojnOXyjp+TCY+VnGPgQTjD+QWatEydYbP3vhuFW1S3s5Ce/WF7Aly
    9cHmkHI2bvrlMkoqXLsAmKFYd4Ca6coLdBz/q/NYlYDcFNtJgaSe2v160RGk9sMqYY5cZx
    gEV1HO+M3r5XQ1O22X6u7deQBgpb5bTqO5L6fUgT5cLBMVP2T+njYnwZVQh+C7VlRpnKV0
    RS3OGZ7AB1KAaXCGdEWvVipWvbVCj0PKLPpkM/mZ7NAP+sBe0qAK3PWmK/MflWKW+/Hzht
    Wv1SJCAcM5cSg+1AM60shgYj80w2oGklcY/1/TJ6gIwOQl0mZejKOMTsxW+g
X-ME-Proxy: <xmx:O5RFaoEBg6YD3pj8qBWa80bHVO5KA6cnQpkf-m-6QAcfYqxJJS26SQ>
    <xmx:O5RFaszXoyhyjhbfgzFQQgYv4CTxyeq1viSVt6t45vPp2534aIoAHg>
    <xmx:O5RFalo9n-HJnQXHg4JBo-0BWYeGDyXcTYgT1U7I85nw8HdtZ0H8hg>
    <xmx:O5RFaujhENgzcNzyNT8KocU2vZnwMbJNi3sX7zn4uQzmdvRkzjbzlA>
    <xmx:O5RFahKyOwMsd3rN9B3UXi3mYk_W32D146MU1zlU09sx9fkOe9isSIub>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 18:27:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] t1517: skip svn tests if svn is not installed
In-Reply-To: <20260701212442.1430084-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 1 Jul 2026 21:24:39 +0000")
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
	<20260701212442.1430084-1-sandals@crustytoothpaste.net>
	<20260701212442.1430084-2-sandals@crustytoothpaste.net>
Date: Wed, 01 Jul 2026 15:27:04 -0700
Message-ID: <xmqqzf0al51j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +test_lazy_prereq SVN '
> +	test_have_prereq PERL && test -n "$NO_SVN_TESTS" && perl -w -e "
> +		use SVN::Core;
> +		use SVN::Repos;
> +		\$SVN::Core::VERSION gt '1.1.0' or exit(42);
> +	"
> +'

If "have_prereq PERL" is not satisfied, SVN is not satisfied.

If NO_SVN_TESTS is an empty string (or unset), "test -n" fails, and
SVN is not satisfied.  Questionable---am I misreading this part of
the logic???

The perl script would not barf only if use SVN::* succeed and then
SVN::Core::VERSION is strictly better than '1.1.0'.  If not, i.e.,
libsvn-perl is not available, or its version is older, then we fail
with exit(42), and SVN is not satisfied.



>  test_expect_success 'set up a non-repo directory and test file' '
>  	GIT_CEILING_DIRECTORIES=$(pwd) &&
>  	export GIT_CEILING_DIRECTORIES &&
> @@ -138,6 +146,8 @@ do
>  	case "$cmd" in
>  	instaweb)
>  		prereq=PERL ;;
> +	svn)
> +		prereq=SVN ;;
>  	*)
>  		prereq= ;;
>  	esac
