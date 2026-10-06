Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B354433D51A
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326324; cv=none; b=NqiRP2nAlx0kkKi9tKzPy/z1411qnBLGEEb67TYFa9hmFg3rvpoWUrcO5bEeADn9MuhpCEncLLmatDBum9kUAIH5ObU95PNJeB1bOYshsnWVs8HZXiGTLD1lW/wdI0IV/LKbzXHnZflsXMLEw9sO3YklMel4jMattLCqL509N8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326324; c=relaxed/simple;
	bh=4tGGJWamDBX9QtSUIvwOwhXrrogTErq2DYHv2h+wluA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oRpZ34/G7N9HbfTGH35RYdYhr5C7XXN57c1iq5naPsBDO4zrTjHm0nvR0Eu2NJWCGA++wFEca2e3VcxhgpORV607JT86kuafL5yIcBBB19YCohnUk3NbV2rT9KI68fY92JjF383tQAYmOhZZe/f20d8tVq2/pko8XqK2QmN5uOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o7jCCMNT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QG3COTpF; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o7jCCMNT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QG3COTpF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 099A41D00231
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 18:38:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 06 Oct 2026 18:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791326321; x=1791412721; bh=qS7wBVf4y1
	OR/mPfrUZmVp7MKxV7b/nWGsNx4+W7GLI=; b=o7jCCMNTHzIeiBmV5A7FR1YrcG
	9zr55RSPH9GKt+pWEaUzmLzZ33hlJm6KvK4+tQ2sldV0fgPbV1cdO3ZSN/FA4aYC
	yFpOWmic4ctxX/mdXUYddlZKO0k26AABJnd7FApL7z2BSmepT2Rg/RLFaxpCYAZ2
	POIONfwv7E8dlTmSR2k/q61TV7WLLeCeBrtJm53S+NzeScDvmAxWBiIRHkZcnTVO
	S6BS3bZE4EmaLQ64dNnuInrgvDaLAI1zJ6CdaJC4gQlio47qV7+xkZvSdO58Yhc8
	IrzxfztqfgBMeJnIOdBWnlwhBZzeT6tAGAxZMy7YZantUrKKaY63TjcaSVNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791326321; x=1791412721; bh=qS7wBVf4y1OR/mPfrUZmVp7MKxV7b/nWGsN
	x4+W7GLI=; b=QG3COTpFVU0BWhSqS0UjOTUHqA9JbLQ9Em+gFCACVQTo8sZvmha
	OqmSw8MqkW43nWaC3+InFcoduLgd8ROEt+PeXGmq5OxxTci22v9f5HESfFjyPTqx
	jkM2RdARPcRy15fTLv/RMtpPkqIBmQ6C/fMDquvd7SBWAgpJSHK1y2XCRbiJi8WF
	kpIX8gUJ7Lta4IuZ5+PsqD3d1H5n4aYy6xMbDYSImpxaNhJEQg2308Fm0X14EsaJ
	OyAVGy4LYOtQ+pVMAB7TlDK8fHNYOcELC7xeSg48V1qzSXTeEG9nRAp/H617oIkK
	n6+RzHHqmWYYMWVd6Rggt9vM6pqGkNmnw+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791326321; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:o8fAaO/C2cD45R/VAD0Te+FijtwhF4FsagYJ6NvgfUGSOXI
	eEPYRikQ4KgWlsHNwhA0/aVPFflhkavd2o8LBZjGx+L2112cWnI+ysbWZjUNP5bV
	hRXkyMIdJMtAmpwwnrtCEv3Xqcbpy5H2T0s6phfe5Mp1uOnbDTKdlnjgCkCSU1GX
	w0KL0CiuUEkkMfYf4s7gHOGnKvgj6CUI/BcqNmMuSYGKMQunqaX10sIDyOorqhfj
	4N4t4yh2Zik7FvOxFUs7Z/3fdWhDw+kz+C9FV4dVs6TZpE17jgAG6tNbWGOLxMat
	Rb4v+CHVNFzeWxTmHlpS54q8N3kZmJyBE659JnQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:b58jymQx/RF1m+EZ0z24cZwLeargf5PxtG2uRS6cJe4=:4tGGJWamDBX9QtSUIvwOwhXrrogTErq2DYHv2h+wluA=;
X-ME-Sender: <xms:cXjFapOe2hDs-wOh9d4_EGdFk5WAgnqt_YNN5mh9AvoHpi1gZMoCdw>
    <xme:cXjFauOa3z92yB4xq7DVIiphdAkt7DNL7aSgbjLP9zWh0h520dNmLfxWz_7f9cLWD
    1S34mHlH96GzJ8Mr8eGne5DPDa09NUzqa6wIflwm1p4fxJvVP6yGQk>
X-ME-Received: <xmr:cXjFaqjA5KVgDVE0LPRby3I3M3UpekGHBeIF3twOf0zHbDAUBg5lmknOvwQZODzfI7gpTDj0USoRtt6V0kIyEThiCNHHYzkn3cgF>
X-ME-Proxy-Cause: dmFkZTEQZBre29IZBXg2FR0FrVZXeESpGuHHIE/7KDpFy5i/VPQSPT7XQXAOomE6I/5FhO
    cr1S5ilGrGwtCoNxim2cMXZmorUHZvdKBfcppcDqu/dkulTMS7pY8yNpYqb0w1mnt41jAg
    0bqyVLBWFqMzhQOY2erpdFtVFPDrvDkbEjWRqP33JFxSafp8ojPI6JijIeycNbyAYZ0/bX
    Sr2fFm+6A7xRJ1Dnizgw1hfdCSqJ7J9yuOqGAMM1aufDyCIlG85g8RIejoakyx9xTN4uLt
    mKxcCGWpX+XdkU+ehQ/j5cS4T292OiL73Eq8iXy8fsrne0ZROadE5FYZ7AFVmRjy4rT0co
    zyIxM/4BEr9F6st8ekupAzMs2hvtGSRNyQAUT8N9tlt42FKPdnty/Y140YQ3quYsGU3ezg
    cFOEWsVbZ3X3maoXGtunVHDKzXP9DqBA9ci+XwkJu8sK2CWyQsMdsNgCwsb7wFgQ1v5ss2
    +xUcL24rqmZw/bugyBFI052ml7Hrzm6qQdU7HjyknGTrmdDpwnB0U7ARoOYYdL6Ys6c0S3
    E6OMri+f0gcydwwWGzeVZbjMIEcL4nMkHxuzf+f9CIQDi7fvcMeOYzS2AyK1QMP7Tj4f2O
    brnOSK1gKi7E+itR9BWKl8FEWKk4ezZ/Cn4VDGIMZqfKPE87MfwKaBkxKx4w
X-ME-Proxy: <xmx:cXjFartlDAHMS_vAhB7rnXCbHFoLfKQdXO2Qe35w7ribT3CvjyJwIQ>
    <xmx:cXjFagQnxs_ruGeYIfPYtTLB0XkwG_d3-10Q_ps1Mch-feD826WCOw>
    <xmx:cXjFan2UaUAnjrZmfRPZRAk5lp3Q4E4OKc2oHs3GXlKakZP-BFGP7Q>
    <xmx:cXjFatvicgXF4LQcyO8YBU1lbtLjC0qmJY5zb385YsrIzS0nANusjg>
    <xmx:cXjFavbZagYpfbd_06hhIOYVvHZdlkGRkGKnXwYpn304q-XBREKofzk6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 18:38:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Scott Chacon <scott@gitbutler.net>,
  git@vger.kernel.org,  Scott Chacon <schacon@gmail.com>
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits
 and tags
In-Reply-To: <asVuadq79SNc-1y1@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Tue, 6 Oct 2026 21:55:54 +0000")
References: <20261002081846.25144-1-scott@gitbutler.net>
	<asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
	<CAP2yMaKF4CRvtfTQDVe51SqEm_DnoVOmED5kcUSg7UvLkBp4Xg@mail.gmail.com>
	<asOa6dgpj0qV5QAU@pks.im>
	<d59dfe7e-5958-4a72-92d7-788521f3e55f@app.fastmail.com>
	<asVuadq79SNc-1y1@fruit.crustytoothpaste.net>
Date: Tue, 06 Oct 2026 15:38:37 -0700
Message-ID: <xmqqzewqbgk2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The reason more of the interoperability work has not gone upstream is
> because the pluggable ODB work has really ended up breaking a lot of
> things[0], so sending almost anything requires a bunch of rebasing and
> fixing, and I'm presently very burnt out, so I'm doing very little
> coding in my free time and doing more cycling, reading, and Factorio:
> Space Age.

If your time were corporate-funded, and if I declared that we would
accept no changes other than the SHA-256 interoperability work and
perhaps other low-impact changes, and that we would give anyone
helping with the SHA-256 interoperability work the power to veto any
topics that may interfere with quick integration of their work for N
months, would it have worked better, I wonder?

Such an arrangement certainly requires buy-in from other
stakeholders.  Employers who fund scalability work would not only
have to wait their turn, but might also need to be convinced to
divert their resources to help this effort, so that the magic
number N becomes smaller and they get their turn sooner, for
example.

