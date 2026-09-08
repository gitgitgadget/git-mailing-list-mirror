Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229753546EE
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838667; cv=none; b=ez1024kJOP68knwAXaG3sqTQkrdJudISptDCawQ9DENUg3tSan1HhKSNHJPvzyPregNpPNWgxW732sRlIosWMGTFhdF+7v1wxHKkQlSwliNL7q0GMZ3mTyr7SPkNRkmU1Bm36HzaO4uHZwVPxSHlnyp7FfkWzp5oIpxPq6wnJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838667; c=relaxed/simple;
	bh=5WhhsdKl2zwsk7XIAvD5iIei8QlKO6c7y6Q3XIOKMQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tIx2wCnmgFxCSCDrqv80kub2d1wx2bKWEpIMOIt9pZb+XMdy0Om/CCL+l3bQRtyINsGqCVM9b2ihR9mVo6lxWxBNPufI8NYLMd6PLJ/1p8vQHtGKk3syq1jICy55FrK88I6A91GOUh08Tjj6skYyx5fobkAEJQIzfCGLxy8BTSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fNSJHeNG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lxlW7ju0; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fNSJHeNG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lxlW7ju0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 844037A0021;
	Mon,  7 Sep 2026 23:37:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 07 Sep 2026 23:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788838623; x=1788925023; bh=20AVcqfgq6
	vTl1x/pdkBPXIZ/Y1UlKV9dJoC+stSVp0=; b=fNSJHeNGnOBndL7uotkd+yadwu
	zRN0JU5TsJVpsi0tYTHdRTzGdsk1qbnftlHsU/pHdUkp9IUgc4TOlBVa4xMzMBPh
	fklg47XO0jVURn8gB2EtJeiayO1jey2MRgTu2u6tOphRVpQKx+T+HewXJ5l/5nce
	00T79O0meprOQUPL5OwUbM4GhYfjE7HnlZiy120y0A60R3/Qzb3Fgwv/wosC+lEB
	/lvRM64PUBeXPhYwXt1uTViu0A2M9qX4ycrQFFwQK6NYPluEOfSDiYwz3h2WNGiC
	wzMwd+2hGJyeF8pFkh89uiJIF5ZFgtiLqfekQviqNNJtxMObG9vEfP31w98A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788838623; x=1788925023; bh=20AVcqfgq6vTl1x/pdkBPXIZ/Y1UlKV9dJo
	C+stSVp0=; b=lxlW7ju0P31izRENy/pcssezhUbM3wm33JokorUKohI2aTZujaA
	Mov/LqSdwA6w88uYcCHIouLadMC00sD5LS+zZy923lCkpXUXs4XZp78MO2FyeXGi
	SMiIycsQu4IYZOhk6cfqolptuF4xK2MYdltGfwPCUs7sHCHypCx5G43dRYoNYRiO
	5a52WBOJHeHf+zOQ0RxVUqwEuPhe3gnLy92RESJ5IIeicwO9gx9jCbttkkuirOZ+
	Iwa69LPFm0dyx+7uAj0s+xWQ1RFX7LD8zQMoP4U5bmNGWPCn5tucZABDPlRc5Jr3
	YTxRR3/ZNztKomianlsK3g7QMYyR/jQ5TFA==
X-ME-Sender: <xms:34Kfaq0r2hTZjn4wulOROMkeqYQYPSo6aSSXHwUNJ0fU8ZdyIOqgKw>
    <xme:34Kfakj-b9_ojo0kwujI39Cx7pKR-Cil4xGW_Tf2xvkdJs9Sf7Zed5YPboaC074Ab
    cYQV-hLrH9ajVbafJ4hgF45wdhm8b-pWPu4K5Ci_ddl4xeTO9d7nqc>
X-ME-Received: <xmr:34KfagT9AdCL0scWPumWgjETdwPyv0w_XQ-zYIWSOoMk8Uy1J_kF4zZajay-yinVBbfG-Uj51R8D-Yc0FSMa_oA58Lu1yG_mGzI_>
X-ME-Proxy-Cause: dmFkZTGjoue84Xhw5LY7qQ/8s/n97kP7svCI/XWWmk9ZIHeIBBztc7+WLZu1nLiLwJ/+Lb
    hiIg2L+IJBqi39S41CWur7Tm1pdoQHO67/4nN3CMKkTmLA0oFEhecrUjaIbS9Y2r3PyAMc
    wZ0l8iq+wtpgZpkliWtk67n3KBRzBnUtTgzMaGoowP4HbtdMQmq+XRHfxA1JskUNzJ4HQq
    +A+Esbl0URiWHnNGJWnRxGgMCkYiswNJLC/u5Fs29KW1/QIVJwi+LrrOURct92HmqA3vP1
    EOnNh7HREOFXPa32XP1/zS7sKQtCVPt5ndazZzQ3AdcYKuaScgaqEPIX5R7PitdtSXr4jU
    yDBBfCqrNf1jdc5RybdxEOl/ki9YTcJauwf2ETTkmbM+iAhIRQ2ic8B7RnGCJ8aMuS8E9v
    fpyjLWx9nCZNzwVzxVBhLBZH6p6bygk/U0rfdLawkueJkKrgduZ/qcQYW6him6l2aUfsmZ
    b2P9bxc4Ew5XfUYYluITVpHbvlctsVFx1IXlkMMbsSRLW7dTq7E9NXxeMlwdEh9GuiCw0D
    qEtUE8hvVfnPB9gWiyHqpLKQ/kVOhLuT7kMCnS+ksn2iR1GWllKgP5hCh1b9dQfrDOYI3D
    LMKJLWzHa3p669XhibDiYEYUAPw42SaBnGH3MXxjsYblBDBSqYsclp1nTZTg
X-ME-Proxy: <xmx:34KfaljWpPrAJwUwqBTKa0vTX4W9-8uP-RXMQrUbmUEVd85Y-MPTzA>
    <xmx:34Kfag7PQyRmDCZ40zwG-obNraQoLsiP7YabBtjVYBiRekLi-36Tjw>
    <xmx:34KfaiA-X2yWOTV6-BYY_R065M3moSwFd_tAwRkxuVqoxzKmOS4mHw>
    <xmx:34KfanY9sSnwbqJn_oTGminBY454tvWgeJXOL3cCSGLJI2pEYPDS5Q>
    <xmx:34KfasM_Cg5RmnICqnG9n0mNQfLzb_Q5ht8euGnIkEpCotry94XPI1W2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 23:37:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] lint-gitlink: don't use empty lower bound in .{0,8}
In-Reply-To: <20260907184858.13475-1-taahol@utu.fi> (Tuomas Ahola's message of
	"Mon, 7 Sep 2026 21:48:58 +0300")
References: <20260907184858.13475-1-taahol@utu.fi>
Date: Mon, 07 Sep 2026 20:37:01 -0700
Message-ID: <xmqqo6e8za5e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> The regex quantifier {,n} was added in Perl 5.34.0 as a shorthand
> for {0,n}.  That makes it too new an introduction for Git which
> targets Perl 5.26.0.
>
> Even though Documentation/lint-gitlink.perl is a development helper
> script, let's stick to the general Perl version requirement for
> consistency, and use an explicit zero in .{0,8}.

I am curious how you found this.

I somehow find it unlikely that you were sticking to Perl 5.26, ran
"make -C Documentation lint-docs" and saw your tad old Perl complain
for syntax too new.

Perl 5.26 is from May 2017 while Perl 5.34 is from May 2021 if
https://cpan.org/src/ is to be believed.  

Will queue.  Thanks.


> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  Documentation/lint-gitlink.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
> index a92e887b4c..6a87633dd4 100755
> --- a/Documentation/lint-gitlink.perl
> +++ b/Documentation/lint-gitlink.perl
> @@ -42,7 +42,7 @@ sub report {
>  while (<>) {
>  	my $line = $_;
>  	next if $line =~ /^\s*(ifn?def|endif)::/;
> -	while ($line =~ m/(.{,8})((git[-a-z]+|scalar)\[(\d)*\])/g) {
> +	while ($line =~ m/(.{0,8})((git[-a-z]+|scalar)\[(\d)*\])/g) {
>  	    my $pos = pos $line;
>  	    my ($macro, $target, $page, $section) = ($1, $2, $3, $4);
>  		if ( $macro ne "linkgit:" ) {
>
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
