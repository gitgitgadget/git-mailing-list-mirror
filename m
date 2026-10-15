Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2EA3D47A5
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075586; cv=none; b=OdJoqEo5GQmh0yJh3cvBUfZuAnn9P2zBGd1CHFISBvGz1FmqFfwflLTs0QROutlv7em8ctgP2tzac7qFTQqdko+CUyY/7e+lI6O7O3vb2GqQtPM10ZlSDDaE73iP3BWu62lsBr3+bFs+agzcGiJFRs2lqAxGRy/8U9xBMn8Op3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075586; c=relaxed/simple;
	bh=otVIKo0sm/amq5MlmDLLDs6Fta/dnsAHcV0bPV1cm+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSYhAWHLvXX0MbnJmx5wiay1MByiIai5d/e97/e1nBKn45m5Gdg/guXThkHQV5tRiYzBPrcbuzgKZ/qNfZ+fOgK7aywP1gxSZB1Q8RdlE3fYzhHmxwpRX+CLSzO8W6we1f/A+uGPGlST++pRbFen7pA+LlNOalODjhfk0Ltbx44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=orijbccG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CC2ZsFS9; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="orijbccG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CC2ZsFS9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 51FAA13802DC
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 10:46:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 10:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1792075584; x=
	1792079184; bh=Yb6chX9UTaDvgjEb0QMJqDqX8C2gR6EREdd2vqpE5CE=; b=o
	rijbccGX/LhLctJsA8CL7RkWljqP3AifjptB1t3hyVGL7VgFmkqESJbwSwy5s2AJ
	bYgx7OvW3LwJVfAg/uhvKYDw3VHqXmE1KdvPfjRwkTUyzmXeW5idVoWuR5jGjXKW
	3ESyejA4HTto9+V2OvvI7CuAYcOATK6SoHcLNq4anWu8HOO3kOxkVlBV33Y+4QpG
	E3UY6kcJspDn32obdlIuXABJEau0+sWCOJ2o/a3gOWm6amKM5XJy0TIKyMzjSzB/
	c9H1aJm72QSw6sVNGRDhefqYJN8zisFRgyRnpIYgWFgQ5kK1WolJ2jyQQjQt/Rnj
	KcId0Pqbkmf939mYsW4Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792075584; x=1792079184; bh=Y
	b6chX9UTaDvgjEb0QMJqDqX8C2gR6EREdd2vqpE5CE=; b=CC2ZsFS985GrxZK+a
	316/QyDMbpoCSQv73OA8WcijW1dVV9LPZBijGHCXVXDYk7sYYAbH1sHcG3sOQwp+
	3uckBiQkO8AP7wrjqn4GSTlmKfY/90H5e4TfJYZ3E80DR+OeGbebI/dBaRUf70LO
	NUi4WEZCbPd6kwnt/wXJzNrzCscn1anwy05vzhWJWuS6hQLoOQdsQB0dlyAJz8Ts
	UvHpgrNVLI1pVQU1tRWv2NUm2IeB/JGx9BKgC5trXuYfJHMZCqVNBrsYZ5klmtvd
	7iytdZcqQJ6rj/tfU/wW7egesGDB+RNX7njDDff5LppIjCQOU/wKLbvrUqgIpILe
	AWrnA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792075584; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:anaHoVd+wn0AM5EVPn0Axkmp0mG1WhvBeJVwgaDf3j7HkmV
	gVRfg4bvShAsATczhXVTZvUf5JMH0VUI+1hz8PEigkPpjzZ4lcqhDNWWIT49HdNd
	02prmSIqfDlrvEhXMM6jp0MlYQ2+h6xxrUmfCwSrmVvgNCHCHntTXwPuaYQB/ur8
	TrXrw5HADgphR+FiWsovAH72F7aRwbK7QvkF/PEKEKDqMj6JnBdJii/ztfjF3+XA
	Mz6K+jPjPednwQxHdsp+GB2CEMNWwMMGuJh7oeBp5sSBllfPdd7DyYHueuqtid0e
	WmxH73AN9uqsE9TQ60wNDosFEKlvK7zifd83C/Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:K1CYdLLtw1ViSbZMaehZxKdv6wT239Ttvgrc0VPvOdk=:otVIKo0sm/amq5MlmDLLDs6Fta/dnsAHcV0bPV1cm+U=;
X-ME-Sender: <xms:P-fQarlj9-RiTfkk3hWv4CiJ5x2h6Sspa5ZzD_WtV4W3RP4cdgVxkA>
    <xme:P-fQal1sqIBOyt2HqzFlNgU9dtL5sajh_QI-pjHq6No78xwietMZXJQA5a0dIA2Bm
    ZQL8e_rjE8wH6MVWvcRCbtsDnLJ240xgbAiCL0xO50sN5T_MJK0awhv>
X-ME-Received: <xmr:P-fQamq_txI7wfF-rQCv22PBkkrjT3pWj8KZfdOufBXI9aLY046AX2enCSTF80zdvbrpO3ZEf4ArvOY3k12qdBURsNbz7jQXGlegwn9gi_NU-Q>
X-ME-Proxy-Cause: dmFkZTE07EJT4HD2ZBOnvKBXGjh1w35aRpSzGK8FaAi5D+lZIu/BtvRHOYIstvx62kW0qp
    518wAL+b7uNv3Qc6UI7C7QtyXz9NvR7GWk94SC9LM1ld8gf9l2u2zuNQrAaZ4N8MMbOPi6
    gVC5OGEqEm8Cf1hBr1cwCFYRBSZNzKCSwt48zXvSJf7HGb5h9D8YKplnNq9Bba4naVszBz
    vzaPtOGwv0FP6UDCDgSHJpZTHcpaUdXDeKeeVMztwoP7KbBKNUl37jtuR5EMX22EUCqlOw
    Vgi0o7b+g2kVdIA/ijfcUs6RYMyGZXYlDvDK+r112/JBFDuUq5dmh2umntP84eXSjmz5X+
    Lb5loBgZXiBuyJi7axu10PfdINtGj8FT9JFXsMUBppYcGqpbomJvsvr8GB4tZNAVu3SC7b
    I3iU1DCQBAkzV45pXYLB9ZUaQ7yx67j8azdZP+czyuKSPCm1OdBzeWp7MmxZXBuR6LkvdJ
    PPFAyn115EMGy8Qp7llRHEUxtiPYtmclc4mGmT4n4cgUw/QHtjQovKFnQArgtcGe+NQNb+
    hsTYsZER0IJ+DUgRNUyh2ZjLM8BEuHfyu8V4veOOYExVM0/2DZs4REGBqOpGjV6YBoiN+I
    ONjUsrl/7XD/3FE5Yrejfl8uPf/4iYWD2PchyElejWvd97sfgNlHO6IgLcRg
X-ME-Proxy: <xmx:P-fQaifKDUkMg8PK_bTiuN9cVLfj0QeDGnTRo_lm2uhlojjbwcHcPQ>
    <xmx:P-fQalpSs1mqIdvAeEQROXbdihVKv_4FVByqQ1ldQnS3RadYk_VNug>
    <xmx:P-fQajE65ZKKXh1kwtUjDi_6EZhu-sfExhriLmEcJoMlxt03Xb4TrA>
    <xmx:P-fQalvg-Cj8oV3acf_w1qlaBcJ7_aGGAjwt7V7O4r9nXhNOYRElnw>
    <xmx:QOfQagPx4BparOCDy7R674iKJjp2etGLhOV_XkmP-o7C6SgREHHFFJii>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 10:46:23 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v6 0/1] repo: add revision filtering options to "repo structure"
Date: Thu, 15 Oct 2026 10:46:00 -0400
Message-ID: <20261015144559.3652143-3-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013172849.1109478-2-markchucarroll@fastmail.com>
References: <20261013172849.1109478-2-markchucarroll@fastmail.com>
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

Differences from v5:
- Address minor review issues.

Mark C. Chu-Carroll (1):
  repo: add filtering options to "repo structure"

 Documentation/git-repo.adoc |  31 +++++-
 builtin/repo.c              |  32 ++++--
 t/t1901-repo-structure.sh   | 197 ++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+), 13 deletions(-)

-- 
2.53.0

