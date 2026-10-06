Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA43B3C12
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302299; cv=none; b=jK90PQyInlEx6NTUBsKchmfrY/XxGZewHJZStrMVbePfmxObDe/EQ5mLx9wLwpsNxVUxXXueG+UxtJIc/e4aDMvz98u0aU9GpmDySs+DcyQfA1+tyueCL+rBSWO/QvE+gSfM4DESe3DzDQYiXmorCb4xatto09BpQEat+XjHrrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302299; c=relaxed/simple;
	bh=39Fbnl1WXdqI9USyFms1how0PKR9Wqz7koryqJSCZlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PME0ocNY4W6bOX2egenfcpdtvFoGoTSp/Rj4bwSScO9qtxPKO9mOWXpKXGpbpoezg5Co1JOG9k1FrCpURDxryY+IKMT9Or2W20Bzj9bmWOFvAUGcFm2JQPDucB7X7xYWGj6YAZoTBRF7ai5GSV69eok+Rrc3SITr+eVg+O5oINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FSej/OND; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UW9gLCIu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FSej/OND";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UW9gLCIu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BEFC814000A9
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 11:58:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 06 Oct 2026 11:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791302296;
	 x=1791388696; bh=9F6fmY8zEXjdczfHD88Rnfmmu/cLsdWoOrB31S3wQZw=; b=
	FSej/ONDHKn3JiyId1ymEaik+n9VA8LFgQ8ihjT10gG10l/LY5k7oHgLBajsg6aM
	uDzIxOwhfyxqylvVQPaEgkUzkSme/K979DFF71heyr7sjGYexNCYeIx/N6wDSF+g
	hqdz5Z2MJ1I1h5PDfUqeQ7ddMJDBsXBI/Ew1M13GqnWHxuusLfIv0p/nZXFlXWoh
	Iv3VNDc/55n37IjiXGFTDbm59inM0gzbCErTdOeW9wqkIESEZuC/r9sxWGmdGsZc
	9v4JwiHi4bOuu1i81RH3m3q4mFuf5kUsQwi3J9o532NGKRox0SO1Y12Sb5m6ML2Z
	JyWmzc1USCKjoXGzMgPUCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791302296; x=
	1791388696; bh=9F6fmY8zEXjdczfHD88Rnfmmu/cLsdWoOrB31S3wQZw=; b=U
	W9gLCIuZNptHv4mZbDc6CrmkgacjbjyB2Yz8sJgradIWHK05EBqNmzqG5HIMWLjC
	ccdAPGVxtUxj9pMfg/O710jl83SXJj+2C8WJwnT58e0bno873OSElpurJW3rajBD
	injLWGDuMurxIscPeL8rO3Xe77S7YeXMz9hTOXmn+868Cl3F/ifVao/QZaEDmXN2
	UTpPd022yoxbYqZROWWaOknCdR257ZFMGC5Nkoj60FXJLa7T1hc4mL0loaEzAjYq
	6mR0Fp5mURl51eAYmnUrBNdbrzL38ohAO7tU4m9BoTCpeW98oxYv3pZx3tLzfUum
	Mlv9X6qdhuq5oQ1I/57KA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791302296; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TthFoChgIDWq2vI69XSaqtpmi5KZHJ5y/jO7myKln/nuo4q
	w+ekpvDXyORwnL8AWQKBOgoVGyt4dA3DeQoVwfoOK8si9KWSYxXnNO/h7ESSQCLA
	HsRlbqJd9h3Yu2dcox+YaDBZUs0bogexC/j9vKBLK1dPS+r/1PAX5nqLTWVL0r1R
	bY88Ws2bpQ231wlrY1vhBlHoAxK4Ho1BQRQ8xBDU9Q6OeX1fGwPf729mYyrB1lsY
	4rPOvtwant6vD1rJSqKRNp4UfqpplGWzoLV65fs1mijFlEAPURpuSnct4On780tp
	9Exm+X2/2bZNlbALtNU6Zr1S0xwx/OQm/kLi52Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:BeSDWeivzbfo4+Jjczhg2tLl/Gfv+hkwD4xo3SISeJU=:39Fbnl1WXdqI9USyFms1how0PKR9Wqz7koryqJSCZlo=;
X-ME-Sender: <xms:mBrFagxUYsTaE0i5Ylu6u1smxyufVDCYQu9YpYL1bPvijRQXYcvmyA>
    <xme:mBrFarRRnzs_zAYEQ7go7Z4pF-CMIVVWP_HUdsZyqb_32GA2Jo0NfRNi8LfG_RFUs
    tehhyoKPRkc9B6GN5Zm9mXh16C7c8f-Zd4zV9gaI7ECRqvJKxpLz3Ye>
X-ME-Received: <xmr:mBrFanWPF16WH3r8-qcYY7oXMnyegNIuTZEOG8qvLrTWzNL40k-Tf-kXhia4V_tElMOuZ5oaZr9mTURqYt3Fqdl8AEH7wTA7hZ0c>
X-ME-Proxy-Cause: dmFkZTEH4v0KrLjhYjFTItwT1jhalj+dDT0IUDy2hkZ65XDnXhLuLlArIJzN6QAfmqdNNQ
    yoJpyHJG1AGh9iUmTv/okwhYr6rJ4LkzB8iVYL1x/j/hb7SH1SYeme7GpnBW9oZMcHK7dZ
    Jk+QCKawZ06I8uxnx8pzZ+a21oTwgluJ0zQOlQg7fHJvd3mwpl6eZnQLDONqbbXE4y8RTT
    jHRfvtyP6YJA5JNi2Wn3vIYcbNG6c1z2F0p3IcmvH+QwstnZXHwIX8FlqZKzEnTdLL8Vs9
    K9P4DoCkDSQN+MCKkduaYYGTKMShFFZkPfoz/8SUs8FNDrOrPF6Y5Z61ykXmGnQ3UlxeWo
    rj/ooEteStDj8FFBTnLlVE8eD1GRN7TnmdPary0jmEXPrEPlPSF0gMgiMQbGXjwkvPVyEu
    kdzBHCSXci0z3bFgA0BC8J7XUffyph9XNbJHZ+b/GZVzCC2REOEDyj/8QArghjyK5W9UrB
    XcQtBIRVw7GNO3QyRBHtSK7wmsqc0JO12GUx2mgbRs0AO6h/VoQo+/HpxLK4iVeDUD4F0d
    ICVI8V3H6zWodflXP7GXj7uMuofTVNyG2dQljLVEhy0seNPEuPjlv1Y5KQ6K+h+g/oms6i
    XYQTKUaE04wpLfH5GBbCpsAZCtHQa4j0suyZEDmDwxa4hC2vWIj+BWXrE4/g
X-ME-Proxy: <xmx:mBrFatZA58lwH2Ouu5K6tVpSUZi9Ln8QiYvbvsdEqhRaTq0TmSMu8w>
    <xmx:mBrFat0UQMLd2UDujfu6JB_qDpLQwgtwGkFQRw6kLG8ewjh3AT0ItA>
    <xmx:mBrFavi9WXhFKSOcrAWw3ZMCnzPxcl6ddkK6u0wOxTxJD42z9ED6ew>
    <xmx:mBrFahbGbZdlKBp-E69a8SJBEnGjtn8SiMlJhHV8JnUataVSiNl4iw>
    <xmx:mBrFal_iQgCezmwhzFMGxbjDc9jb_G6Jf2YJF1aHpd6utXdcW19OXDTV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 11:58:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Souma <git@5ouma.me>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 0/2] history: sign rewritten commits
In-Reply-To: <f86f6cfc-56b4-4358-a9b5-95630c6504ed@app.fastmail.com> (Souma's
	message of "Mon, 05 Oct 2026 15:59:20 +0900")
References: <20260703145037.69832-1-git@5ouma.me>
	<20261003134058.23494-1-git@5ouma.me> <xmqq5wzhv9c8.fsf@gitster.g>
	<f86f6cfc-56b4-4358-a9b5-95630c6504ed@app.fastmail.com>
Date: Tue, 06 Oct 2026 08:58:14 -0700
Message-ID: <xmqq7bjug6sp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Souma <git@5ouma.me> writes:

> It’s a deliberate literal placeholder, not a real option. It
> indicates that more  --no-*  options are available; typing
>  --no- expands them like --no-dry-run.


Ah, yes, indeed.  It is normal to see us show, without expanding to
it on the command line, "--no-..." in response to a <TAB>.

    $ git commit --n<TAB>TAB>

is an easy example.

Thanks.

