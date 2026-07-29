Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A953BF66D
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360582; cv=none; b=bTfufkndDFmiMSTGS3E8EBrPD8yRdVa/hYD4pkj2kwdSVwPmjNl9YBP/wk/OGtTSMGQ8tbt18dj2rb+G6FfFfvs9lrPaLfdE6pl7u8ENISdfIyYXkTbUOlsbb/zhLCow02HljDqkmyFIYqWwaPR98LxbUae1o+DXt1I6jOXhjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360582; c=relaxed/simple;
	bh=eYuO2RLBpoWHkEXLvwCmA9d4OfIb/wpED6I32FHSjOU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IC9u5GoUW5THLKOZ9vggTKHPq1TPrjO5i0i1zgzXttSzIyRynsfyzsOhS+k2Y22S48wA7wPvSit5FcohTsgskx7MvkNcEiP3ziqNeQWpWcU1kqn7IbGWxLFHg5R9fReH2dZ0yofGXyF/2iT0BLCi+xmG8O8iKbGjfRm0/20dvJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zr/64GxR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fkhQdM0M; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zr/64GxR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fkhQdM0M"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F05FEC057A;
	Wed, 29 Jul 2026 17:29:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jul 2026 17:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785360580;
	 x=1785446980; bh=ffWLOvoeugE5q1YBM1Bsu35ATfZKFVNBsuiWTWKSRlQ=; b=
	Zr/64GxR7Ej0idEOsjTgj8HYDxiYKAcVAxoCrNnd3PjFRcpp2a46gO2py2njRo+u
	dt8sUhP6RmUqYnMQ2uYQfi7M7Zr5pyFiSY1DTSR7pPKg9ehEExWHgf3GT3Vh/wWD
	OUtRwAjNuJC3gYnmyOOO2qhzh/OjCWzyLUcj/QQrMMwG48XlYwSInVy4e97/cb6E
	wEBi5rTutxWl8ZKC5LteJNsyoJVEyFFN9/sUA0II1T0Q3Kt0dPFoXEttdv/eGy+f
	6BOps6J+3lR65hTRKtxugQugpeEMQWiKpqqcLxrU8WMXPYckAzAVbE24OPCmaTaQ
	POkjCrqHjHzNP3pQY0lzNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785360580; x=
	1785446980; bh=ffWLOvoeugE5q1YBM1Bsu35ATfZKFVNBsuiWTWKSRlQ=; b=f
	khQdM0MdpbocXGuQd9BuSuSVfgYChnXwZP0YNuWV/DpqV64lyk5TGRyM+Uiu5M5x
	I2FLd+Lt8HXqqzqXnJfXxzOB4Z+2j6tR4h5NkeLNu5R1NRuxzfvG2CIktrsu9Ngi
	HEBiiymy3Ty7f1CjOVTQYpVEdorChJrpxhGr8Wc+UhkLaPGZC5950ey3ZER0Y/pl
	woM+Z3dRCR4Ck7DjJtNep8TznqSjodJvnQSFzS6d31/FiFvtPB8lnVTWIUwDWCTK
	sA982hzLSyDQoI4w9TZSD3iaDfEcSRTQh7noadXfzTdYxgwcsjfcG6w1024Kytjt
	y/WcpGyP3yI1m2ph3LieA==
X-ME-Sender: <xms:xHBqas9EPl7ZN-T_VSghdl9zqAEWTJhRCz89Pl7EQ77NCs4adfZFEw>
    <xme:xHBqarsGWGYmzhDGpA2NAym_vb1rPclBo2vEiTrXMFZcc4y-NUe2G21JieUdC1DqS
    RRU1xNLhdYA5aTbvgGowl9QQew1xociwFAHeQUP5GxwKvC-pexhZEw>
X-ME-Received: <xmr:xHBqanDt1HW8wpBg4FUBjwILUn7ns3nzeGI9zF0dLn5I8qmhRA8lDyuhN06CVEq6gkpN-p4Q5bZBEty9sbLPa7zULShhap53XQ>
X-ME-Proxy-Cause: dmFkZTFoqSfiqY/77gZmBcADrnKHslF2Hol+fZBsgKxaDhu8B8L4tLV37oscjo6KvPXFou
    Uu81YSRJUPE66D5wBqcnJjZlnZipZ2SMS6ths8q6o0sPcg8aRM31EGhzFXYjRqU2fBwOBw
    q/Ko/YPvCUk06Lx1XUHC7k4oJTv3OJCa26ULxhDiL8ofDG6dFNC0n+m9PuJCZaJi0TxQIu
    OCaj+QJRtj+xwbYC3qg2y79HV4tLrIjP/gH3Redm7fdQsZgLG7dKDaTP5YE3mDGNRevEaA
    fZHYstKNbK15ESgdS5fZ0PLayILda1FK2omozJMoN9Ya8tIs7su5hxhhMzdb3tcSI182W7
    9VsiKyWFh3JBf1Fd2wZHXkADEExfEJhc+GT4ZAnDs8o+GxJBqXE37vIOW+KzLzwwxiThRW
    bgiq3pjLI4lK1RNzsed4C9WmpepH6pEF1q5jSUMrZg14nsLC5sxOHzQuk0AicYWTwTD1fd
    C1uuyNjtJn8p9Rmy1PhByyT2SDKEtnv2rPlWYcD6DIIMUbJirK49b9VtKdkU2mDeurkVUO
    k8r6ITCymZ1jNhTAyHalqLItp+npzI8NG3CPgAPGAC5fPQ0bOI7jMq5RdKmGSXT8rnOpee
    2nlRIDObZ7ldUrlt3ZgKu2Str84y7YR2hZoraFprNNRM/af8n91eKmcrZt5w
X-ME-Proxy: <xmx:xHBqarXGW1X5ZOKxECEHjeNE4OQr5pgKPoOt06khgPJ7zIa3pdhqMA>
    <xmx:xHBqatBut56weU-1Ff0JnWfHqeOCaje9pwg_OBHf1AdZwrsg4xC8wg>
    <xmx:xHBqam9c_zeMLpCFBLuM1A8aZVXaT8p9KU31KAqNnmx5Twr8dONV3g>
    <xmx:xHBqasEoBUWbaJcX0yT5HOfys6VhjhIF6o9YpYXvTRig_IQugnwA4g>
    <xmx:xHBqajCFsfy1FsfNnzo9lfMy68hQso9Y5BvF7Mw7XeWcx1UcXgscimVC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 17:29:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2 0/4] A new batch of synopsis conversion
In-Reply-To: <pull.2185.v2.git.1784841567.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Thu, 23 Jul 2026 21:19:22
	+0000")
References: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
	<pull.2185.v2.git.1784841567.gitgitgadget@gmail.com>
Date: Wed, 29 Jul 2026 14:29:38 -0700
Message-ID: <xmqqldato56l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The conversion to synopsis continues. Now the commands are less common, so I
> may propose larger PRs if it's ok.
>
> Changes since v1:
>
>  * swap formats following comments
>  * switch all listing blocks to 4 dash fences

All of these changes look as expected.

Shall we mark the topic for 'next'?

Thanks.
