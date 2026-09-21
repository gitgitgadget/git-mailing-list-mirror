Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C36515965
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031154; cv=none; b=WMyBs0ABJas2hNfddqdTxxjrwEer1Ik3aW+2/6TTfZMVclz1IbYCKaSk4G3OmHfoOfaF7Xbhi4/VQ+nQEelOV/jIzHmx327SeeheyvhEipAMt7u38qAldwGmyGQjzwh5+ij2axmvuch2lZH0w77qc5fkZ+FRh3VYvhAGam3glD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031154; c=relaxed/simple;
	bh=886UmToGhoCnm38U7UpROOlmjKP3N0pPqbm9wv8cRDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CY1SA9nlIo8PFJ7wpfH2gj1GTk+/A4LiFtcfRCU5f8e6UIiFqttvIDQ+2YLJBkvPUl8eEU99+/on4mHnIXbt4Fsek9on3Yihoq7MrAq/5tT/euwZaMg+YCqiIIivEnvYfjL19ENJQLZPU+SuIvNgaDqHCHHxY/ZKiOucV/X6bCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n+JS3PIn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VHG8y7yZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n+JS3PIn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VHG8y7yZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A1CBEC02AF;
	Mon, 21 Sep 2026 18:52:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 21 Sep 2026 18:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790031150;
	 x=1790117550; bh=Sa+VTfakiBS7q6qMZomKrq7H7CDEK/w47z1sttVoPw0=; b=
	n+JS3PInDJiFBGRe7jtT7b1MrN04HCf3Y/2E6bXhqdvyP7P1Py9XD21IXJDi6R3U
	PV284KjHgpg+ttog6AOdeSQ6BWOsxzZGvwfDU7AeiK3G9Kwj62667iGAUxazIC6V
	hN0D9BV2KyHDfug1coBs+Wtk3xQHKdMf0j9iKjVJU5aqsNrS5Ze3smfTKfd/8xrv
	8Nvuw1YY6+fkvcPUZ68C6HfT5ey4rlUHK2Im24w4ihY5Tr8HL6LpitVd01HLzgG7
	xjQrz4lgnjlyEFp4kQX1HjBQu1gPXsYa4CWKcSw1eXKR/i4jP80P8xUuDHnmtJAw
	x6Js2g9QpnHNNCTw6W2xFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790031150; x=
	1790117550; bh=Sa+VTfakiBS7q6qMZomKrq7H7CDEK/w47z1sttVoPw0=; b=V
	HG8y7yZDuUobCq8CZ4BwMXOfCT3RozwzDoXyfVXrWqmWq8SvDHsQtixnndHVkQZj
	v3YM1AdEfktQQhj1efFB+YKtxvBMiYYGpqg3SqxsmYZvVWPkU1lA0Lw+7ASDyeQt
	VFIiWCtfUGMRXVDc4ZTyL5lZlOWv+ZDSa79KFV164B9ksviH0sXMXQ2/wJ9DICzW
	CbbL0sua/5Ac/iuZ0JVTU2Y7KHpY8+X122CkY1SM44MISoNDpAJTqVTc+U65ROGb
	2R/V+raxw9v4cCaldzqLjJACvk7UNklnrvMyfTAEj8o+w7DMvHAEvLoI6p4DzqKK
	997rD1r7WCSgh7WeODBDA==
X-ME-Sender: <xms:LbWxalBYeNl0uzbtaA0uDZCmRPp5VcMD7Uv-VGZSxcfrW9tgwg1nxQ>
    <xme:LbWxalx-I4CdyUplmJ342jprhjCEo8rxQ5cN2gA0CpJmix5ppKsr13PRGay8UrQLu
    OWE__3kPgUl95eyCD4jatGOZq0V0rXWdRQGaR-v6-u0BO81RiTN6A>
X-ME-Received: <xmr:LbWxai1Rt6L1xGEasvvMKgEgdUxsIwYe0d-jkPkFgXYwraIhahujqErn3mGi2FvG9CDEqufbBV1AdXMhwHfbYDpOxcD5nzg2hKTB>
X-ME-Proxy-Cause: dmFkZTEY6GhTmUWqK5mOgWfapsrlAFO/dedyissvW+pLhrVwohQfABdjKmQcaJUz/PDUHI
    pyRYZUA9odOksybbUX9cA4um+Kj5mBmnlLm4oiS814NJuz9r6vYksRHthyihN23Nbx9Ft1
    lLqKYFD1X1u7cf2/+DVJrNDIoarwbtqpUhANmqjlmxN4ETAitBZesB4CD+7HATPeJ9H48K
    2JMrRgCMcEY/0Hp5j1laHvKA4iPNJhkerJtAaWOJAUhSdcFxFIJ64nI92TrQ1Mu5hwvCPu
    Lagg0zwB9QM5n5YEHfaE6J8qKVbVpWd6Eicpf2v9KPR2N/szwZp4WMVoZHWhJdXuDl7Bmh
    RzzhOFDQl/Ply1ceBWJgh68fey+eYWV7fRJtwhOq5wVksDq77KQHmHo2+oThrZ1tGz/u+1
    QX7UrBtn0XspRhLU6p49UZ+6wuAoPfeuWoJbwA8dzB+cGxX5EdEzWVdLOpf5REsGWQLRNN
    iYmhVj4Z2zeVJZXHh82QM42gQsEq+5Zm8zjUvcDPWP/EOsTWnGuJ2DZWJ+DV7Dg8VxYs2F
    bQ5YSC7AHTXVO4XAtoWva3yzrVCoNX4a7Efkwi45Nl55qAZu5PzOVRY5jDIoTi7KSTrsDY
    CvhHf4r+0BOmFerW3jmJ9MzkzaX0rPjf89KnoBSxoJxz8dSeI5ijcSzJYChg
X-ME-Proxy: <xmx:LbWxalxsJ2X5WF4xRfyYezIuXF6vtdDxgriq9ICPeS4v624G-u3phA>
    <xmx:LbWxapGfqHGr-9sEArh0i7huILAwrbbzLa8zYEjY3-e_RqCKG7pJOg>
    <xmx:LbWxaoaWIQ42dy_f67taTW-yqyLGJ5dHsAOsbJ64BGRe8tNtMRoXuQ>
    <xmx:LbWxarDW65z9fAsfWgsyUZlTF9qsEQhsmAJwLKOeQHIbTHCzSPYH8Q>
    <xmx:LrWxajZD_lCFGV-Xui1JSiUySkT4dN1GoAE1GOYDg9hOIeP2KbmkCC2c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 18:52:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Daniel =?utf-8?Q?Mart=C3=AD?= <mvdan@mvdan.cc>
Cc: Daniel =?utf-8?Q?Mart=C3=AD?= via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>,  Mantas
 =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH] credential/libsecret: load secrets explicitly
In-Reply-To: <c3f51472-8dfa-42df-aa8b-b0f5bfd0aafe@mvdan.cc> ("Daniel
 =?utf-8?Q?Mart=C3=AD=22's?=
	message of "Mon, 21 Sep 2026 22:54:15 +0100")
References: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
	<331e94ec-c07a-4d56-938d-d12c9a0cc5c9@mvdan.cc>
	<xmqq33w8sjcg.fsf@gitster.g>
	<a60afe54-7059-4827-8c3b-dfe01a0cde9c@mvdan.cc>
	<c3f51472-8dfa-42df-aa8b-b0f5bfd0aafe@mvdan.cc>
Date: Mon, 21 Sep 2026 15:52:27 -0700
Message-ID: <xmqqv77yjjys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Daniel Martí <mvdan@mvdan.cc> writes:

> Friendly nudge :) Happy to look into any tweaks or questions.

We have had a review exchange.  A reviewer had to ask questions on
the points where the code and the proposed log message weren't
clear.  The ball is now in the author's court to improve the patch
to the point that the next reviewer who did not see the first
exchange would not have to ask the same questions.

Thanks for working on this topic.
