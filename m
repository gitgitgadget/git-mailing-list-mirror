Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE3134CCF
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791034738; cv=none; b=dO5xDnWld0oXLXPpb31dOiziLGQ5XgkQHLyQkhDeS2+jZ2fqU2Lyvzhj7uRKmQp0GZuLql+pRb3myvP7AVmsaRmWCCtJY7L2RvAAHVSnvxMCEdkcazh50zhFGlkpNFJr73MsowsFibI2gTkscL6pX1x86/O0nG3PztD56auRJlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791034738; c=relaxed/simple;
	bh=Av33r+ba3fY7J6RVztxLJhQTSgGM6V7MM31zHJTHRDY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WwvTset1m+1iB477kGFnoax4H4gGXsMZyqly/LoCW/vJRLX6M0zdW71QiGH+3JbnZxlfJDTRPOjF/loNQXGTDZfb/f25DeFF3wHtSZm9DcLUKiRzkWX6rJmQ6kmwXKXPziACx00DdJmIY3tdV4YH3/rVAH9xldKxYNrWVlK3lN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=KtBBNWuW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GW5ZeOp+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="KtBBNWuW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GW5ZeOp+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CEE2FEC03DD
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 09:38:55 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-06.internal (MEProxy); Sat, 03 Oct 2026 09:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791034735;
	 x=1791121135; bh=Av33r+ba3fY7J6RVztxLJhQTSgGM6V7MM31zHJTHRDY=; b=
	KtBBNWuW9IeqeqbPVGJDj2PNKC3C01s+fwO24s4U2lZXWAK+gli3Rx0I5sfC3RsA
	IY20SmVmpPzxuX14tLFMg7xM3tC7NS8bvfkjHZXfxijLcnO7Wel4ZHV/0IWwGCDD
	k2UPk9gTgU68vD3A1mbcnkLLr3+tWRn4zXE0BkudFGhy57IT0+cYRJ5m+jt2SiqG
	EZFh0oF5fCX5lQ7gLcLFCO3uGPuM48ZiJusR7KkU5dMsO8716ASVr4lLDuB9O/Nk
	x3nWkeYxt4xuTiKs6Qvd0PHyX3Odufm9qocAIiZl67u3fAP5PlL06WYrajUN0Zrj
	aWOPwfG3ufqgjqB68wcs2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791034735; x=
	1791121135; bh=Av33r+ba3fY7J6RVztxLJhQTSgGM6V7MM31zHJTHRDY=; b=G
	W5ZeOp+iLuUK5tjaSqXkv3wTcbpQkiS3sU5E0/w2AnqcFDbFj7pRMhXMRiWJWv7C
	9BpwvZAZHXzNvM3TPqjoJ3fGj4RO/fKVuF7ThvapoSuZTSk366o6JSKVFsHq2tnn
	jaQgBy0jSCuc5xIi+AeMBgqFGQdcgqvNEFxuHemhxsDNnikm/CtlXWhnIwzcEUhK
	bOTuo45xcjBQcSobB1m+Jsrj622sLohOqyqY07PN9ixKjhr7OTmnBkBqurBLT8gM
	D1KwDSFtJXvsew5kLbwWVuv4zYgunJHxiq6F7HhnvsN9iWsdLkV+ZOmozDukJ39T
	MplxCCqrsP5gXhwsf6nIg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=5ouma.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791034735; d=5ouma.me;
	mf=PGdpdEA1b3VtYS5tZT4=; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fLKeXOelPagAngu+zYMF4k6vsG3FxVX2HYmRzPtlla1acgZ
	9m8aNI2qmVNBuctbSsqgek1SzA1pLEKkDGkrOurRtIZhi9CR8rYn6SlG5CKbfY39
	nKfP+JX44V3Akngmy7q+2HJImUnTgF5JL1UvMUuR+S3BukyjxGYGY4Qa5Rn8f1Rn
	bni92FE4/qq9jxc6gybkv3hvJpKxebEKKs9xCoRyg5grmj6naLm21Fe3iVJU5Zfx
	IQNJhtjW+JDbkcE4g/odfOfd6WNvorfDYmHTWINDtfQPbCygKlP74gAvmiVKjKxV
	CmzG+KKcXHxkYmKwhb/Yur1R+UgzavQ8iPePsNA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3J7NIg2ESqBJ4j6zZ5IShsyP0X2hKgIns7dEaXHTPW4=:Av33r+ba3fY7J6RVztxLJhQTSgGM6V7MM31zHJTHRDY=;
X-ME-Sender: <xms:bwXBat_v_FsIEFgAoxBMG6pbFO4kz8WA0-lry661x44QFZ8ssgaPLw>
    <xme:bwXBashPV8myHL1RPVfRoaLBsq-osHZpnE9v6T9FXrEfp3KG2Fw6M3lOCjvdIswEi
    7fDkly9YcEHh_g4ljKaG4UbirVoYoNM2-266jpeB7EXwCF7W4zovGKb>
X-ME-Proxy-Cause: dmFkZTFxhFrV+AzWa2Pp2W38NqlE1HAQkoVH7Ts5iA+RZtlDVkYtGh2ElUIXsRwN3KJP/N
    JQ9kSjVeyD0/KP52mwhsXg2AuYD4ajFoPYJhnv4fX68PvirSxgrA9nPdx9qgKw/1U/6TwI
    5XhD1A6hI8w3MyLjyqCJ3wQHEmgPmzh78I7Wmx5ZIVLT+57hIjattIZFzi8Qu9ryQ58oqs
    +4u6CAPQJ7ELfSwt+yOs7nQkwCReq2NX89xIKD9C2ZBezQA5LTU7nTZdGfC1EGZZkYYj7l
    qojvD8+ULabbilM7CB1SyyszK4lJUdpgt4D6/rALfyiN1vbFu+mr97YHjxiRKdB2bzLaqT
    YfoG9janj1WJjtoDR2dqSpcBNf18OC5jSCDhACzMlhDgJMyrXmmL19hYP390icQsszdyL3
    +gkPtkiSrgCT53s2bH9qYcC0Qstfle+y6RvP9wpkkrTl4wPFp+HaDf1dYtWSIKTUuiXzjf
    FoKH4InC/1bO+khUuy18GdOrRepPX+8iM8l7bWiXrMD/f6O9dPUgY914Vc+/SyLOBMiG8k
    nzA3hX6QMrjLz3l41Kn6X/rP6QKa0RriaDAaih1g+/2nI8D2c5dp5uZFvJkdmqtTzZyr4H
    oOKhNARX0bOJziWll5AYH/gyftJ2fgEFF06m1sK5jTCJQUGdBZ04OoHJ/4cA
X-ME-Proxy: <xmx:bwXBav49a-5oOdbQTYy09WUmQh2hjohBVDoPpO7sjJ39Z6eAQ1VL7g>
    <xmx:bwXBasocTjDVzCNAWndW9erQeR80U7AC_z1XomXXO2515CudcZUF4w>
    <xmx:bwXBapg5ud8wkp4QXFoHXbeAMV3YSkkeYpDK1G8Jl9mTIvNNkEND7A>
    <xmx:bwXBauKWTZ6OqJ3xoVX7L83MUbGse66FFXIWY6FyS3Kvvh3X8Yx5jA>
    <xmx:bwXBajRmKyhFjcKk7XqRcV1VBBkYrngrs0ndMhlt554gUI_dXfdM5Xuz>
Feedback-ID: i4b264863:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A1781700065; Sat,  3 Oct 2026 09:38:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 03 Oct 2026 22:38:35 +0900
From: Souma <git@5ouma.me>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Message-Id: <2ddd0d1c-82e8-4793-b109-6c37a88bda23@app.fastmail.com>
In-Reply-To: <xmqq7bjzvhxq.fsf@gitster.g>
References: <20260703145037.69832-1-git@5ouma.me>
 <20261002132718.3830-1-git@5ouma.me> <xmqq7bjzvhxq.fsf@gitster.g>
Subject: Re: [PATCH v4 0/2] history: sign rewritten commits
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yes, this is expected. The output is an internal completion protocol wit=
h options before =C2=A0--=C2=A0 and generated negated options after it. =
Other similar commands, such as git rebase and git commit, use the same =
parse-options behavior and produce the same pattern.
