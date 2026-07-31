Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8C37997A
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785468299; cv=none; b=AM/GJt/tTjrnweYWcdrLLz9/gNIdN3v9frY5U5v8Z9o3ZnUaqtFQ4gR6WxCmyAi/CX/TornXYyWmetHw9T3y3PQRUNQfAlPLQqiruDi8oiSi+hYxdo+HtJ9+xuMBrw9GNSuRhUYzX+oW0WTSr4qzHLGeC00MFbR9HwFz5uioP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785468299; c=relaxed/simple;
	bh=k4ncaXsIhHP9JedfTC450bvJma6YV4nskyA5rOZDC8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dEk/tjcKa0kl4+WXFOogYlBMp5+bzl29zaayRFudf1kl0TfVC++7UypFSprk5x/eJgQ4rgUdMr6t5jthk0MUsuSVLbJgAn0TTvA7H3kIC1lFNIoDzIeeTuGHhLDRZXmOrjvnlG65Qy+VL1Nf6k0DgpSzbyf6LTLTMgiHpRAxeAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nFCXS6eM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QxQDe+r7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nFCXS6eM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QxQDe+r7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD3A41400070;
	Thu, 30 Jul 2026 23:24:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jul 2026 23:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785468295; x=1785554695; bh=bY0wU/U1a9
	mRS1d+/1R5kivGgntAf/x/SucsSIK3BCo=; b=nFCXS6eMdbVR2jg6SJxOMHNbJ2
	ETAyYEWQTplKtpj7IoEoBmg9Zbfve39px5XCmwJzBtUx13i8IB+n+2DF8PjBY6RZ
	FhhawyFnMIKAD275hXWS//SUUf46m4dOv72Be+qNpW++qLY3ZIb+A+Fgrdc5RNxV
	Gi9z8pfkx7aLZJo3u6ROYSq9/h6ttHMXQ9/jUB6EOWA28SNu2JH1P7GwKL7RSpjn
	fZa77Cd6Nkm7ABFCIRLPwIAKp7ihds2GHUkSQTr/EiN7ahU7RzPy0kjWni8SbbN9
	utZeedKu9fxiCOlqJQp2MqLYxI6XlXDj9+ZBZkyimZ1qLxhePnkLq7k3J87g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785468295; x=1785554695; bh=bY0wU/U1a9mRS1d+/1R5kivGgntAf/x/Suc
	sSIK3BCo=; b=QxQDe+r71BRtjEP2XBJnYGC/Zs1+c25bdNaZGLeg+B/inyCTA4J
	SD930X+AiqMBgD4Ix2sSDu4YrNHJzjvnlM/PFkH5FOlEBKtnfJRsUNWITYfD1/e/
	jyDC908PiUnHTaEHBb/x4znB5zmT9nd2nOUXZX35qWaF+OCeCNd/37WGzhu0YAqa
	eViYgsk+dX2W7d2maJAecYDFa20/C9TDhgoXTgEnG5RW7WDfqT/pkBbw/vRiRg+Q
	hWI89nq7g01kXPVaT/Zmua1cdzV5PTWcfvR1RGOnuglePJn3wV/wL0tPELCVyeZJ
	c/zHyOL9JTPjgkywVEjcIFExGHYrTfOtZrw==
X-ME-Sender: <xms:hxVsahVNbMv-W1fKdZwRnsXMCJfVkIWShQ1iN03hxKbCs0Zu_T05ng>
    <xme:hxVsapCni-GNsAKGbl5EmDDAP0cGPw3WRvWd1UWc2BTz7w4CnZ5Qd2IUwTMnMX52R
    ZhfvirjsAG74BlfGMC4N7gpwkxqq_d7rU_OPu1RFzc5lQ5xGID6>
X-ME-Received: <xmr:hxVsaqzAPw5BXlLaa0ikzFwGiy_8wD6H611QVOQ1xPt2B1fJIibzWKU8D44FazloV1b-PJWrlheH8OH11wRH_NsbA5sKJaSLJg>
X-ME-Proxy-Cause: dmFkZTGhVCq57x6YpvS0qOwXZMuFHwPu8ACTLihxQJZsxvwXiA2Vf+kkIGOHYPSfiRcyev
    0N4FkNOFndMeyo8hnqLTXXTyBoxbGEFoH4P/Hg126XUuyY7fAJ/1xsMWIUP2Sk4nFTsiE+
    PkKZmOu/1LXOzhHlhHP1DhMxv0OfAJ5tmWTXXohf2PmiyD/WKSV5sjR3GJ91HKmJ10BS0+
    qvFJ46FBu4fC3zRcR5WOutcYbPqT9pMvOsJpxxgrvShmi/VoiIQ2s1nhGdjblUT+GLhxos
    D2cKA22VW6DEk5QKJUTnNL2C3/QH7mc2EU7IEsvZp3SIRLJTKv6LJZxFecDKBLd35MVSbR
    b0FzAbhw+wvVwU8nGywLvkrD0Wj8eDD4jCr84K6vW5zs2mkCUma/xZ6CbxBjDftboRcENF
    +Pozz0c0Lc2aNpfQyNYjgAj6eNMHK5icPzXGL9sD8LgA8UnresPxp+JWGnusE2fvw7TFav
    xWhhf2/5VMKMuZPQYbSZi/ogBffauJDejnQpSDGQpY3OfnCGA0nAqzMZISAdHNpSe9G4TU
    TtBo87ISVxSYnCj2SRdYewBQSQrNnoVpGGpPzpthdUG/xzHqmc4DgnoV+YOhs9B3uY1GXO
    AJ7Go3+EXOS2kHhTYOhu392nbwnjs/mpLWEMke6W52mGFvw5hQ4rjRsUri+g
X-ME-Proxy: <xmx:hxVsauAUmged99fMbiHnbUF3EUiq70nyQbjuPsbn9BpTQkXD266lcw>
    <xmx:hxVsavaePZRLq_7FY2AB-8_QzUPsrAeIllSLWCnD6miFeduGTfjecw>
    <xmx:hxVsaugzZ2Sx8kqLMkp03rxiKSdSS2FyP26i0UYHuSgTxqObBLJGEQ>
    <xmx:hxVsap6TRvAFPUrlgVG7xZ__HjU4UHIJUbkA3tZOUuyO8-Ui8E5ZkA>
    <xmx:hxVsassCjK25Y7yZjWlls5o1P-Mx3YiJuoGd2ptIzIxnjejA5YUObIec>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 23:24:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [RFC PATCH 4/6] hex: label usages of hex parsing for object IDs
In-Reply-To: <20260729233215.398654-5-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 29 Jul 2026 23:32:13 +0000")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
	<20260729233215.398654-5-sandals@crustytoothpaste.net>
Date: Thu, 30 Jul 2026 20:24:54 -0700
Message-ID: <xmqq1pcjkfi1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> In preparation for a future change, label the hex parsing we're doing
> for object IDs by defining a constant called HEX_KIND_OID.  This is
> currently the same as HEX_KIND_MIXED, so there is no functional change
> here.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  diagnose.c    | 2 +-
>  hex-ll.h      | 2 ++
>  hex.c         | 2 +-
>  http-push.c   | 4 ++--
>  notes.c       | 2 +-
>  object-file.c | 2 +-
>  6 files changed, 8 insertions(+), 6 deletions(-)

OK.  It makes sense to say "we are reading object names", than "we
are reading hex spelled in both cases".  Are we throwing the "not
object names but derived from the same hash function" things like
packname and rerere database key into the same category?

> diff --git a/diagnose.c b/diagnose.c
> index fc11cea229..9c652d36a6 100644
> --- a/diagnose.c
> +++ b/diagnose.c
> @@ -112,7 +112,7 @@ static void loose_objs_stats(struct strbuf *buf, const char *path)
>  	while ((e = readdir_skip_dot_and_dotdot(dir)) != NULL)
>  		if (get_dtype(e, &count_path, 0) == DT_DIR &&
>  		    strlen(e->d_name) == 2 &&
> -		    !hex_to_bytes(&c, e->d_name, 1, HEX_KIND_MIXED)) {
> +		    !hex_to_bytes(&c, e->d_name, 1, HEX_KIND_OID)) {
>  			strbuf_setlen(&count_path, base_path_len);
>  			strbuf_addf(&count_path, "%s/", e->d_name);
>  			total += (count = count_files(&count_path));
