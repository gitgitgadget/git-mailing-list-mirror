Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E423749C
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422939; cv=none; b=ocNqTh6ecXNMdG3OrortU/hQ8vEdWwJqnbDqdR+naHF8Xa7qETHgShEkndn5On+im4eufXqmJ2cFIEbc0ix7Dy452xqsOj5oyJH+PgoBCKtVWq6eGQ7I5+miwgrctjt37ralN0R0Owa9JK+IpQRpBYoEPvlsis1fZoGQV3UiU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422939; c=relaxed/simple;
	bh=R+ohI+Q6Yy/iw/WeEBMFGueDGwIdaTVfqDEssxNvdcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIPkFe2S20wtHtVBsAky299dVQDEQltGi26pSmZsxOLCTikrrptz4Yaf/K95WcTX6iG0VEe1Pd6EL7BYfLKssx/3Tim3zHdyU82syCJ3qYAgtAp1Hl8cHlYhxlvhWLJwLOp0mHFlsDMTTb/RVumeKyVltr+fApUKw3cbVPkVxAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GBcEtGYV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zqkDyVMU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GBcEtGYV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zqkDyVMU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 87368EC023B;
	Wed, 25 Mar 2026 03:15:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 03:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774422937; x=1774509337; bh=1fHW4zMv/n
	G+zq5kfFpgoY80Hgl+Gza/WoZuJvwJ+Ns=; b=GBcEtGYVnZBZ9ORC22SZMTF7nR
	xTiUhFiwqtRGKW71YFlZSN0Gw2pOFx7obplrPwwczXgwsqvvB5SnyIu0gToBfYkO
	iGyXeZKqdmMPJdLu75JwjwQfjIFh8jyUugdKe49y9JLN9KWIdvU4C4Et4nyK7wOD
	mLgocud1d29RuCcFYD0trhx+8spWXEkLBqVCTRYKljmwftWKTFof33NVv1AqifZm
	54kN6su7wcl7owE9TlmNUQrfcmzFWKpbu0lee7kV99YWTkeZBqhGIJ+V/LxIf9dp
	8szxXvLlZzIPq+HozAZtbXxJHVKy+qIgsOWQebkQybDNTMU1yG9OI97BQeyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774422937; x=1774509337; bh=1fHW4zMv/nG+zq5kfFpgoY80Hgl+Gza/WoZ
	uJvwJ+Ns=; b=zqkDyVMU4wzEKlkYkHut94J/Iqz6J1sX1HEl5mjfyR1QW6Cn92K
	BnCSqQQy8o2AluKGVOiOzkeoKZl+WHuhninwmWcsOt5wBEBCFYWYRHf7E1osaQab
	i2FpQGfcbXgHBjZv3M8vBaWTpzvSyvx1BJC2aycWB+//naJnQk8V5CpywQN1bbNn
	+/Ph4s8JdDwq7/RYRaYBKGVmokjKdUjcRABgV6Mz3Y199HgQhaBCgoAsqPii0X3F
	YMwt6kDuWSEIA6m+1qsq3YS/o54foef83h/oHYysTbivrEA5UwRl0WsYeE9BXTfD
	LyALOKiEcShYs8v2U8kCTttJ/Bh5fAxI6tw==
X-ME-Sender: <xms:mYvDaW3_MUsa_6B2CNQHz_iXw5rtwB5XNMOU7x64T9jTbxNuEUQVhw>
    <xme:mYvDafFO1cZnXD0ByUpK5JWWocZ1ejW1tW5rD47fZOSsvwCM2Vc1_GeyBb3mGJEyY
    N4lDC_8FGKZj6EnF8Amqxru-OeBzNK051vdCjAogekxtCmyHgm3>
X-ME-Received: <xmr:mYvDacgYNEZo4Jf6Yei_VzRa6F1oTVKZQSXiJUYUBX8Edtmw0WDRBlIYL5qFSVHq7SHcDKeBOGsiUV5PZSlckQP0gpem_B7oWm7qgbwVzKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mYvDaS-GrCIDkYcHFVcL0CMyQtRpF6ghdUdCZdGg9MtYNznvT59wjw>
    <xmx:mYvDabrZHSO12C0DQAVXhxRMIPabe3IertryytdSBwMQ3ib4k7812g>
    <xmx:mYvDaZ-7YmZmAF8wJMtUTVGxmRyuAWfLnhanDmeSg1cIksQ0OqG67Q>
    <xmx:mYvDaXVvwwBs2ilApdVsq7gzOmKQAIxizZdLE9sazad3DraYHTkbrw>
    <xmx:mYvDaSNIZOzihyTXG_y2OwDkubyOKyt9BNJ43wJ1qHc_BsBFRr4pN2RP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 03:15:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 47af8bf7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Mar 2026 07:15:35 +0000 (UTC)
Date: Wed, 25 Mar 2026 08:15:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/11] t6002: make test "set -e" clean
Message-ID: <acOLlLzphGMfZeN6@pks.im>
References: <20260325062114.2067946-1-gitster@pobox.com>
 <20260325062114.2067946-4-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325062114.2067946-4-gitster@pobox.com>

On Tue, Mar 24, 2026 at 11:21:06PM -0700, Junio C Hamano wrote:
> In order to catch mistakes like misspelling "test_expect_success",
> we would like to eventually be able to run our test suite with the
> "-e" option on.
> 
> We often use
> 
>       val=$(expr expression)
> 
> only for the computation, and it is good that "expr" exits non-zero
> with syntactically invalid expression (it exits with 2) and other
> errors (with 3), as we do want to notice such errors.
> 
> "expr" however also exits with "1" if it yields 0 or null X-<.
> 
> Make sure we do not fail unnecessarily under "set -e".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t6002-rev-list-bisect.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> index daa009c9a1..1a6ffd8fbd 100755
> --- a/t/t6002-rev-list-bisect.sh
> +++ b/t/t6002-rev-list-bisect.sh
> @@ -27,9 +27,9 @@ test_bisection_diff()
>  	# Test if bisection size is close to half of list size within
>  	# tolerance.
>  	#
> -	_bisect_err=$(expr $_list_size - $_bisection_size \* 2)
> +	_bisect_err=$(expr $_list_size - $_bisection_size \* 2) && test $? -le 1
>  	test "$_bisect_err" -lt 0 && _bisect_err=$(expr 0 - $_bisect_err)
> -	_bisect_err=$(expr $_bisect_err / 2) ; # floor
> +	_bisect_err=$(expr $_bisect_err / 2) && test $? -le 1; # floor
>  
>  	test_expect_success \
>  	"bisection diff $_bisect_option $_head $* <= $_max_diff" \

I've got this alternate fix, which I find a bit cleaner overall. With
`$((...))` we don't have to worry about the return value of expr.

Patrick

diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index daa009c9a1..f2de40b5ed 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -27,13 +27,16 @@ test_bisection_diff()
 	# Test if bisection size is close to half of list size within
 	# tolerance.
 	#
-	_bisect_err=$(expr $_list_size - $_bisection_size \* 2)
-	test "$_bisect_err" -lt 0 && _bisect_err=$(expr 0 - $_bisect_err)
-	_bisect_err=$(expr $_bisect_err / 2) ; # floor
-
-	test_expect_success \
-	"bisection diff $_bisect_option $_head $* <= $_max_diff" \
-	'test $_bisect_err -le $_max_diff'
+	_bisect_err=$(($_list_size - $_bisection_size * 2))
+	if test "$_bisect_err" -lt 0
+	then
+		_bisect_err=$((0 - $_bisect_err))
+	fi
+	_bisect_err=$(($_bisect_err / 2)) ; # floor
+
+	test_expect_success "bisection diff $_bisect_option $_head $* <= $_max_diff" '
+		test $_bisect_err -le $_max_diff
+	'
 }
 
 date >path0

