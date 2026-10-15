Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ACF3EB0FF
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083947; cv=none; b=bMjf8MVWAnIVGsX3/0f4uXl3LWso6/jsfwu5hhZvhVQLavuPHLALhyinfWB1SvaErCwh9PxLHOih320VS9B4lb43ar+Xi5rHOqPbJQJF5NlLNcUh67fklYgBUCCXQNxfVM8ordh/NWr10wdyvJiO1PuwbZo/nTHMqasfghfSk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083947; c=relaxed/simple;
	bh=4wFK5FmJOJhqgfCuDlJURvJwnL1C3Jh9ELtQRlHXPa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7Dqu6U2Ed6DXyDeEjzl7ALULsltz8u+A5rACHHZKWRyRPO1svtpTkX/c9m9/J7n2tGKshrgiMpPJ0k7At4zESujrOgKOOx1Hxef1hQd8JHNNabkXjxsF49O+JNKhstuDvUQQKCBjR2981z5+nEV708diID24Oh6OIFfEhs+tiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fshTNlXN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nMYnfg4a; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fshTNlXN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nMYnfg4a"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id F041113800D9
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:05:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 15 Oct 2026 13:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1792083930; x=
	1792087530; bh=BkRjzu+bos/I3PFGM9TLtQHtPT6OmO9LZt+9Xo2Yq6w=; b=f
	shTNlXNA/LahUePwE4mkG54zhaQmzrIT2C6pkNqaO2aaRluegbx7eVl3Q06u/kri
	AzwXAr6akqRHMnMNTDfcs7nEk2akjqZcU3wlKuFyhPq/1CFyhli9CR3sA/5rMupx
	GpuQPgkpsC8OYhR4UtSPnEAvthq4D5QTG57q0d6hHBRtFhiWD/FVpdm571domD8f
	XVYISfJpobDoPKS7I4dPxPvmkRd4i7FZGl9IhMsBwhFjLOnw6TXR7CX+jCBlrSnL
	SQDGYU5x/UTL6NbpSp5rn3G9Bm046A21BcpzbOx5Uz5Q/q4di+xNTQld7Fbu64af
	TwkUG6OrayKbTwr1+SV5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792083930; x=1792087530; bh=B
	kRjzu+bos/I3PFGM9TLtQHtPT6OmO9LZt+9Xo2Yq6w=; b=nMYnfg4aQmC2B3/8m
	JlTyTwryIDJGdy9w1CAnZ0mS83arZulS25Tcr+IHVyTfs4cL3Si2ScILmx48FCPG
	Nq+fJIt1L7QH5Om95WKRQfwpLQPz8iVO/llu5VE1gHVYEwY8Capd+TSz9gbeoDhg
	NvkbvYYW4Scmr6wPpThVv49QtvSJN7j/ff5iIgPzGNpp26nDpNf5OOxb4q8pojWQ
	NSUTa5RVS5gX3+5UgxPwgktBMU7kleN7g/GeZWovSnnhR61cGbxlK4uFiHkADQAG
	cpNxZZH+g/w0mai1+C8ywmCqKQJrrUL/dOyR1ESqWtL33E+1SSLnQH43dRolmQh6
	jxA+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792083930; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JtHg0D1F7rdLiY/U4Ifhr9Dc1y5f5hy7ne/Z5tbn9ZRKjq1
	YIVaFTbrSOFgz0QGJii/nQ/oRr6LNm9J0XZ3tPYupCBnFiYPMQCDbQpd++unNksO
	ec9VzUcBmDCXXVSjZwNm0wqKh+D73XCGWpM5CTrMyJmf2QlWNU7L/qpKt75MfuUn
	VXDcAqco1P+J9WEiNJP+40lvSehUaYYuyRnFTBev4L+iqjUcNlyZIWw00CBJ0YUu
	NZEfxBdBWc/LUo5P9szQznMhsYvWS7DKVyeWLNQwwx8GZUe5dk2IFRlBlQOGCWiN
	SqJjOVqyEV4DV6X6cjpZkK4ObhbK8bh2ngLEC9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4kZ4Oy5L3hi3ICRyiHb98SnU8TKuynre+dYVtFHAVqI=:4wFK5FmJOJhqgfCuDlJURvJwnL1C3Jh9ELtQRlHXPa8=;
X-ME-Sender: <xms:2gfRaqNRC8sz_obGNiknZQWxdNkaogEV9hoF9HjVh4Fpb-59yMdCcg>
    <xme:2gfRav_0nJ7QgBDGyagBbaofDQHqPKBZavK8ID4Dohlx6a5Mk0wKimn9iEuCyDKZb
    W_LdiVnM-KGsWVqmNmqj6vPyBlU8ZooyiJxt157SUupf50goLwfW-c>
X-ME-Received: <xmr:2gfRamR47_fQIFd7kv6RMDBQU3QnzJ315aNzdaW_6_RWqNMDW0uUsoWtAkaBihPIdFzlb3HioXGkg3YmNqMBDgSqdBZCAUJOOIWAdyiqZArdRg>
X-ME-Proxy-Cause: dmFkZTEtYMB1OcofFJrVInDqbRPuIfpyHXgLzMmRCE7glDupcXCSEirG+XGlE3eHNhY9Zs
    uqnnAnU6DT3+jSkom/pjCP/H02BE942mlfjHWMkzDQNFB+jYfi2kwpSQ09X4UYM93t5DDl
    Nh5xKhmkJPf6ol736Qi5lsMthsVeZP/poVvopzMmmq+/WAGpUjuhWmON5jE0LcFbWGYYhM
    SDY/FFrEKBUdCO7A41hfOwyg01lnL8fSwuSI9Hk6K7vD/ZrG3cR/gB4ASAimA8+WpV5rFJ
    vvCwhjaRerCrsAzj/RLFiUxx1sCcWTjzeNreleNZjQuPj49YDiTvHfl4jzpr5Ks6C2MMDg
    m5MUVAH06Cpdc5jKKEDwgBr1yaVE/VnX0/ILmkE41b50qAXHoYF7GkqRjUoXlI/af2QLlu
    5rXKUMrRWMENvDkmmfBkP7+UZF1Tel+QICDdIhnQjSEvK3IkppBDybvNnFOpg2UcGcPoF1
    GARJBZZeDPXPtqXgtYeKugjpQ+K1u1ARq6Ov2zit1w9xUlEdUWhGGL5DLG4pDvS15cWnBP
    npt9pueFGl1CLLi9WdllNT5PmjpfkJv2Z3DswDZmEid4nWTae8gOu6U8dpJs28jz4rlrA4
    Isi6YEC7QVxtGtKTxO+ySKkm+4VHSLAJyHsRDT44m0KnMOt2nPZPOYnzqejw
X-ME-Proxy: <xmx:2gfRapkocEQgVXPCSJEHg6Gi-KOR6lfnbrSowUn6c7kVKf1OOzH9uA>
    <xmx:2gfRauT0h7CuYMccNPtZ5foaWS1URYy3iikeQtha4xnNbLpEdCf3vA>
    <xmx:2gfRavNqrhg5X2gVrWUCXLvqIGbX3nRL8OtSaeQKzqtEQGYC3ZVv7Q>
    <xmx:2gfRavXuSBCpOdnoEcv3Cqn90HSDxvDPdksDBh8_RuhhldReiGHxGg>
    <xmx:2gfRaiXYt5LOCTeYcPGQbUJGoom6w_FJ24PC9qOMSnnLkUe6Kv3k5VDu>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:05:30 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v7 0/1] repo: add revision filtering options to "repo structure"
Date: Thu, 15 Oct 2026 13:05:18 -0400
Message-ID: <20261015170518.48395-2-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015144559.3652143-3-markchucarroll@fastmail.com>
References: <20261015144559.3652143-3-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git repo structure" provides a collection of useful information
about the information stored in a repo. In particular, it's
valuable for diagnosing performance issues caused by large objects
stored in a repo.

The current implementation of "git repo stucture" provides summary
information about everything in the repository - all of the
branches, remotes, tags, stashes, and notes. But sometimes
to properly diagnose a problem, it's useful to be able to get
information about the specific part of the repo that's exhibiting
a problem.

Add the option to specify a set of revs. If revs are included,
then the set of objects processed will be limited based on the
rev specification; otherwise, all objects will be processed.

Differences from v6:
- Fix word duplication in commit message.


Mark C. Chu-Carroll (1):
  repo: add filtering options to "repo structure"

 Documentation/git-repo.adoc |  31 +++++-
 builtin/repo.c              |  32 ++++--
 t/t1901-repo-structure.sh   | 197 ++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+), 13 deletions(-)

-- 
2.53.0

