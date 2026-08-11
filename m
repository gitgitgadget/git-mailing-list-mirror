Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E830DD22
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469715; cv=none; b=rHI2RRz6NDZN5rQ8dW9lnthDRAcKkwWXcVIjt5hQN8iSUqVnP3hBGyGiay3Fhi+S4su7SXElv2jn2ogshEbLcQbmWCKfZo4F2LI+n6NogbplzZXN8LOpymTOgCVd/nvoNBvUIGXAj2Yebenu/N/HIC7Ks2p0yWwnujlzws9TIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469715; c=relaxed/simple;
	bh=pmuA8f8Fp90wWD3YWKQn1fqZCYCYbbLEj9ZWEdx9qC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D45x2FvoKFKA9pGj/wxzmGk7oAgWZIeR9+5ExkIQMd4bQztmFDdx/OxOJU+DGsaMCGK+NcAqaFD5rvhlCRt75as6yDuf+LPPsbMizPQ/6F588jsyiZSTose0vIIYJ7qmu+jDGL2+IC1CRW//UFBQQXlf/CD63BV2ZwhJT34/bGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NFP9/iOM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K1feXb4j; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NFP9/iOM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K1feXb4j"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 33E1CEC0243;
	Tue, 11 Aug 2026 13:35:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 13:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786469713; x=1786556113; bh=pmuA8f8Fp9
	0wWD3YWKQn1fqZCYCYbbLEj9ZWEdx9qC8=; b=NFP9/iOMzu8ocJrxEaJxrvqcTH
	WFe+FiVIzz1J1Edf3rz3wP7dCAO7ho1Hx0lGX96NzbcpkR4ZhJT7QgMpL41ubTSs
	gAGbKQY/uJH+nbEmVcGuCKSoJFMP5X00n1Y+5qzzWD71RojN0y7V/nf4YcTLg34F
	nFnfTXfzM7xN30ZXpjdaOmbsUGtVWBb2dteXleriTUslLZE3mizZ7q9TTN7Ia+38
	t3QOCDYmjqQSvSWIoLOCsXzpy03zv1GwUDBZ3bF7wmVN1WRei0o4m3yAdaAOIx1Z
	VKevJ2c9+4jX63LhZnTKXzLiI+F8N2jwlseEYosVZNxlDNNbfUUwS49bMxtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786469713; x=1786556113; bh=pmuA8f8Fp90wWD3YWKQn1fqZCYCYbbLEj9Z
	WEdx9qC8=; b=K1feXb4jlwptZKYBPyT4cmHbRa0bmaXrZwJi1mSkH243NYNULYH
	+b2aUlgVRYfUnVM5JR24ZF2aRYd16TsZ2gfH3GBuA9O0XD4MQHwvCsfq2IkAB045
	3hCW+OP6A59EzToSHBCBX6eK0Xxo5vXS9JyCKNbpWOHzFrIqTxQu9Dv9Fe733GF4
	XEV7qS5UPUbEqxc7Ee5po3fS9MV++2VYzm7+xDjQltm5uDCazpDqGLxcJdHRmtRQ
	Gy44iAKDigmfe4rmH09jEZB6g5sDAi7beRGwEreKuQ54vlMNmIZGwHRW966yxahj
	NwjFT0IJOT4pR9uGCuSO0tckGtAbSubOpaQ==
X-ME-Sender: <xms:UV17anL1VBxH04qbMgMXQKugKgfX1LBlbxGLGabcfM16KAF66TkkHQ>
    <xme:UV17anvUlP3Ze120l3sMUzdDhrdXNwGIenTtx8vaHEjdPgAFqiPsrCI82eZZTpJCp
    XlMNk2Xoa02bq8hjMxn2C0njPD1MFHTApSjAskT0GQoJAJ4cZq3iQ>
X-ME-Received: <xmr:UV17akIzT65crQKlMmGxbtklInN8D-ebV4JsSu2gSVwfeIgFwL-8ItvHyEAUUBDASRnPFMAEr_ThtcHWPxqUzXLmYlZ0HrTufQ>
X-ME-Proxy-Cause: dmFkZTE1pwjUKkkhYXwL6r97UouFBdyqkh+OgSRbxtpMW9xFJ54TfVwNSn9/EwijeZg10s
    xOt/Fwaxt/VIb158tN/l8GPeIygG/FxIeMZXA5wh8r5e6S610Oj8bFfgfhI7k8rytaaS6s
    OhuK5A9iMOa4Yeh16YP3aobkTKCbcV/h7w1jIvZwKa/9KnMuKxZjLrrjUmHAuIxpTN9poc
    DzjXec5scnATrsVD543neXA+PdOPhNJWJub7lVYGA2RxpWypCH18Xu5XJnAWBXcBBSkLvf
    QrH/v5UU6a5VxYlwi8ML3tp2NkG+nAqqLu4h4Z+0Vn/LLoLLH5OYPSgqLU9XXJeGjfWMfq
    1w1edtVZU+FTjfAZY4EdMJ7/EN/kBcFcMzOu7+1eFXkaGVTfczkkV06RzxzLkODIhOz5Sa
    huFocPQ8rzwoPbmGCSebPithdz8lgrKYWoh7GYtyLTuqdT8ai5YQScolvuyoMQmhwtjxBl
    SuhHx8pRG6MNGnNkBEiob923l7+7L1R68F+LwHUS8LcDogkV4Elv2K55/nB6xqBvrM90me
    0rlubQnXSNwI8/pYRE5Ue/j3n86d4ek2jjXRdxQqJ7RxIoyLRnlsLxK1oPMGnOHpGMFat9
    WOejf1uNCMGQQWGWK0J7tXDIyRLFvC5gYEed99OqNY6V26p5Tey9vOtg8b/g
X-ME-Proxy: <xmx:UV17anMgEw1OwJP25PrpZl4i8NApTiTZ5iWuwYVhvp6d-wgH9-PGSg>
    <xmx:UV17avX6bcBQF1zqla7BSHypnoLdWPcse6KKZ5l0WdPPjWVsfnX3ew>
    <xmx:UV17atlvKme_FuiKhKWodI5Vu2eigWziMDd9M-97WONXkJquJSZN8w>
    <xmx:UV17amP-WutakTGxSgeRC94zs8OfbxOu6eR0PuWpPuPoioavxBqxjg>
    <xmx:UV17aroeUlOfad_kLaLRW6z9JgZhX4iE4-6E7ATStDilXUEdkgtAkrcz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 13:35:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tamir Duberstein <tamird@gmail.com>,  git@vger.kernel.org,  Jeff
 Hostetler <jeffhost@microsoft.com>,  Paul Tarjan <github@paulisageek.com>,
  Jeff King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Koji Nakamaru
 <koji.nakamaru@gree.net>
Subject: Re: [PATCH] fsmonitor: flush pending FSEvents before cookie wait
In-Reply-To: <antMfAYVSPX9QAk1@pks.im> (Patrick Steinhardt's message of "Tue,
	11 Aug 2026 18:23:24 +0200")
References: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>
	<anLtSOKqgcCrrNHo@pks.im>
	<CAJ-ks9=+4rxxx8+7fOF1aLFW67=hdxjhQsHqse1GGBLwZUh2BQ@mail.gmail.com>
	<antMfAYVSPX9QAk1@pks.im>
Date: Tue, 11 Aug 2026 10:35:11 -0700
Message-ID: <xmqqh5l036i8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Aug 11, 2026 at 11:22:01AM -0400, Tamir Duberstein wrote:
>...
>> Hope that's helpful.
>
> Sorry, but that's not quite helpful. The questions I'm asking are to

Thanks for pushing back.
