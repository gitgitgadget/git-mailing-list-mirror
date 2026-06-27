Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C42609E3
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782526177; cv=none; b=lry6qqSpt5XCa/xWcqjaEnteGvKhhg5aZIyOf5eAieFGmmLamuSLanD+Wx3BJzsf7enOAb7eG0XrOhMaopLGq4ES1KmqKmUdkACs5IcLgwrXuu9+ICGe9cIdeoreJIC5moR6AqPN0hTXQ9kg1PWtNALFcxNREkNTerCFvXz59uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782526177; c=relaxed/simple;
	bh=gpKMSR2VJkF2A0+nolQ+I7UJqH6/Qv/+QhAOmwOMciw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z3Fvi1rqKFejpQYFfhMSnGtQnchRV0LLk73HIgHd5npv5btj5AGqftct0C/wVCceGrt8ViV6sruLNPyVynoCe89x6xTyMskEAHw1IHLhCF5gt9avzEk38aHQBfPRX23nZeuXNsGrwLa9j/16N1d+8XVlko+qHmbb6wBveQ4ZkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i94Y2/u6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QyYZXEUm; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i94Y2/u6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QyYZXEUm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CD6A2EC0276;
	Fri, 26 Jun 2026 22:09:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 26 Jun 2026 22:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782526174; x=1782612574; bh=gqTTSCRcNx
	uSImN8y8WlvJ3Zfo9gq9NkfN20E8h6oAk=; b=i94Y2/u6U48oP19x5+m9myqVZt
	p529/uW4QguN7on/Lpq7NgcldWJ8qtvsk18bEcT3HzK1WXe9EkJ5IDPC/fOrRXjR
	/SE5yoy4ThpNYbGVnqDH0p6E5eNgpBg6Ep4yYShBsm90KKfD0RIm9zXtlLPZluda
	Rb+ncXub3FG917SIWIa1Cxyt3pfedVA7DsK7/egLpNcZ4aOMldy1OAKnWiYKulLM
	xL//jL9vMTWvjymTYlidbzQaq4uKD76UbliRlKqJWhW2MoUkqFzfcqAYfYc9tCuy
	fmwZwffwrbpozHyls7mCJ40k0pCXeOJAReA5aXzzDkc0Ze8pz3OuNMPnKG+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782526174; x=1782612574; bh=gqTTSCRcNxuSImN8y8WlvJ3Zfo9gq9NkfN2
	0E8h6oAk=; b=QyYZXEUmfNQ2taoYlGgGYMmjysiPf+DD8a6k9afTkA18axeV+lD
	3f877TS65m7Y48sqvci4Nsu7JbtYepU5ia/1SD/+BdjX5rrIuA8aKl8RH1j63WbV
	8XBO2kuKd5lkYhWD+Nnfgw6vCs0EZ0oz6jTnkYYP/5NCGXN5qJ067hWSLk19nrOX
	qV4meTyhJIRtZBVq4rqs9YQBO1k7m3+SUjItTAv7OeHK0amcUF/XgC54Y/Ttv0me
	OhGukEZ5intEMfjpqxRhtfkntdZSC8ZCE4wTqzU83qW7QuiJwdneqeB6nYNuapBJ
	mCOf/p9JKrJgPG99NZUxVCHKg2W9+D9snhQ==
X-ME-Sender: <xms:3jA_alx7i1gShjt8hB3FkJ_I68SEy6pJYTsoE3uHDX3vKaNHnm_N1Q>
    <xme:3jA_ao9veXxtgC2a5Hs-zzSYtJEvcxGoaCjx98JrYjCluB24FP54w13dedVf6jbVL
    QbQ7_beSfjkvCoOzia4NRfpd0iN-3t0FMEBgRKbG7si8aGNxlol>
X-ME-Received: <xmr:3jA_apJUhjzZd5uzhG8xTJhHWCGRneiJYGCCBi5E8JhG_7MD2cc4ijrse_1pEBz2LKvWHOtkXeXUNnMzR-ugBQOxV2RunvTXIEVQE8c>
X-ME-Proxy-Cause: dmFkZTFwMRSlnUMwuviLAV3bV68Heu71AtEt0MCqmS0tj/WMy3GGbv5JUpN3OQSaRCMw/7
    YNBv5OATxna5w0FjJ87xxOZ5tB/OLr6N8NcRbseW/S4PvrZhlaVwJ8I0wP3YoG7DeNsaWC
    dZSVY7TztoNxb1a+lTa3YJ0Wlp5A39hm02kp2Fu9BAHvXER5CzKQl9pmX407UXUCcKM5Ox
    0uDx4mpYmYCxKF0Ie/CzIXzaMr2bipCWRM27QGS5As/dEkPd37IrsTcIF/yM+MJgLWlZZW
    RPrmvg8wZM1NYgX/BQqmV6WgBYy4PpNBy61NtpxhialPSTO02Gw5erEoG6QyYBBdrfpxcu
    dJzQrrlHO764Hh9N9zROd+DzAxYTDEI37k5fpEKp0zDmxtTiD76xqRiD9DZ3lsYuR83VVK
    5cWr0U5QXa/k3i/Ls6eljOYdi/oMBkfwoc7x9RKgSDNgDb2Cai1ySgpxQOhqwNqoRqRfG7
    AnV2grAKibSPgNgaO9xXb7ndNDlDo5NG1ycqlSi6yTsbR88VK2DE+rZUrBRvemceR0e6aN
    vKiWF34gLuc79RWmELF6Nh8IWw6+wy2MryF4bNMx2wXJYXAD/6PHbgX2VTp5CYkifyxhPq
    iTFZYh/iOnyDH4rs/qwLrlYnelnN3siDrOp3Y3pknUClaGWJb7V52n3dcEaQ
X-ME-Proxy: <xmx:3jA_auedsuv27P3oKKVRscxr6ntIbvSkLDSPmK-pRwq7ZJRjN91FQA>
    <xmx:3jA_ao-UVB7Ciul_AHZAfRDfjdPQMPqG78-AQbpxQ96FqKAoPgiveA>
    <xmx:3jA_arrZf2z124yjsBndTGwzo1Wb0UqnGSjTbUC3mLkaRZip1avXog>
    <xmx:3jA_atBGjSGCQi3Ww5k8FPEbNe55vxNT_GjeOi8BQIjtYywZNVz3KA>
    <xmx:3jA_anOs1W_CZX-YOR90tvx50fc_CE97r-THh5MrkAEvl87GQatrxVCf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 22:09:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 08/10] pack-objects: introduce
 '--stdin-packs=follow-reachable'
In-Reply-To: <aj8cOhH6hGVZIFft@nand.local> (Taylor Blau's message of "Fri, 26
	Jun 2026 20:41:30 -0400")
References: <cover.1782500507.git.me@ttaylorr.com>
	<e3d2e46443d0b32ce29215563dde04ebcf850679.1782500507.git.me@ttaylorr.com>
	<xmqqpl1d56dd.fsf@gitster.g> <aj8cOhH6hGVZIFft@nand.local>
Date: Fri, 26 Jun 2026 19:09:32 -0700
Message-ID: <xmqq8q8068f7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

>> > +	if (packed_object_info(p, ofs, &oi) < 0)
>> > +		return 0;
>> > +	if (type != OBJ_COMMIT && type != OBJ_TAG)
>> > +		return 0;
>>
>> We do not care about non commits, non tags.
>
> This should not be an &&, but rather an ||. We only want to handle
> objects which are either commits *or* tags via this function.

My comment above did not mean to say anything is wrong in the code;
I was just thinking aloud.  We return for blob or tree because they
are not commit and they are not tag.  If we say "||" then we return
for everybody, because anything that is a commit (failing the LHS of
the "||") cannot be a tag (satisfying the RHS of the "||").

