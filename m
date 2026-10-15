Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935F531607
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083902; cv=none; b=NxrW5vpTNjgWBcAx2srUI01YvYSQir72p/06Ut/s46W/smIOqbbqTA3Ii9VnxtyqB560NUULLqHBQKRiCgXS6TJpjhZp08DpzFS9pL7MG++SntYkgBY+LXTTuf3LQlVlarUORWuW9hgzC94ZFqqR6yCKNrzGSKbtt04ZUzuQH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083902; c=relaxed/simple;
	bh=4wFK5FmJOJhqgfCuDlJURvJwnL1C3Jh9ELtQRlHXPa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImYIf9HRxfrFOdsuIxpUoJT2oq5XeZuHTAh4tgVR5aPQPObH9Hh5jTc9wWdmW3sH2Ayxn376/tYzgqRpCphJOavACx5v3Fjk7Ooy4B+jhEH5n0paTYguxivoe6rEGaUMIhGWV4p88mXgIbYQ3sMfjMuD/n6rZoia4Kd4DCqa0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cMJ4RvOX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WSlKFndQ; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cMJ4RvOX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WSlKFndQ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 78AD81380067
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:04:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 15 Oct 2026 13:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1792083884; x=
	1792087484; bh=BkRjzu+bos/I3PFGM9TLtQHtPT6OmO9LZt+9Xo2Yq6w=; b=c
	MJ4RvOX3YsJlCydht/373UqXyLaqZiKIm3+SFFajoKnHMVhsN/uhnATfyFVdSfp1
	PkkiwQqWKLP6wWX4qjy1cM4qAXrt3G7dzTYYTOuPP8LPMlANSJ7RMlLRf8jcZbdD
	B6uzeAWjqIkWwFDhs0ZYaX5mV8NgqiwSsXZ0dPuRAvJqfKNYjspaNNWQ9htthxzf
	RcnFjg7Bb8z3E4EQZpLxsS3ZWkYAk9M1U/E/9LD56/CFLKZT+uoGopN4Hw03L/Kz
	i1ICA6nM3rS26BNzdxJlRnyxpPxS41mX+sykXt26Mldr25kCPG7F30bkIUjrIjyG
	1zwJnwEWWWFftcufLVhQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792083884; x=1792087484; bh=B
	kRjzu+bos/I3PFGM9TLtQHtPT6OmO9LZt+9Xo2Yq6w=; b=WSlKFndQ+RcJy56Kb
	Oh9ICYHruMD60u7QuZxkolWk6S6jpt57jmZ3bYekSyvgO9C+dPKy6NriIr53rzVE
	u8W302Pj6t9yqrzyjhXxYLl9WH/KfqW0fZZqYtDC/y0V5tVHBG/Hvzmaus/ozsOA
	tQ5Qg2tlXyCdJGgz5TRw/I+Dnw87W6TdXkQCK4/U59eY8QUXopEbl3w/p6RVIEDS
	jtsOGVaVWB0YJMRoGe1/gNfZTzw5IDt5Wjh1iUDkgzjnQptb/yY5E9wEQMV26BpS
	B0LWNUaRIOFx/64lBKEm/9bW0MjYljGDG1UO0mzKRjg7k6mTRN3RGBpXsdvR9aaO
	CEblQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792083884; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bXmrHPxn7PDFP6GcRjKqopN79PyQJ4pLN7dWQjJrsJ/5mN/
	B1t+BApRFlm8qD5Q2kAihmV92r7/ziS45ouP2lInB3T9ndVG3V5LIms/Zu+pcDyp
	7x3Hlgz/fp6vYRn7L2EsjBNDgLz21Pyg1VjPCVEmJTSudEPNvMBBOwoiX7WUsRqV
	aYwNtERlobTon/967y6gIrRaGY636WDlsnJeHtIakTomh5c6ePtfydAgu76E1E4X
	JcJrW2KAYBU3XMp+symYbh/xltVGF3WG2M0PtGN29UJcZ8AQLJqvJz9/L2Z8EzD8
	k+oQu92/qBKmDsO+X13s42JZzqvTy+6MZ86fD1w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yyvWsIfakHW/v4HJFzKdkMV+dJn/wXwAU/oOrg/RWy4=:4wFK5FmJOJhqgfCuDlJURvJwnL1C3Jh9ELtQRlHXPa8=;
X-ME-Sender: <xms:rAfRaivUUamiVb3lnmRXdSzEcAE_fDT-6RHFQhuiujKpGxwpmeqJ5g>
    <xme:rAfRaue4SOF93gK1YfseQ9gUAY_z_vgRyeeodI1_JisIiAKBVbSqIr3KYmLN-Ix_v
    KC5kdvSr9oYbXa2GgxpOrwnpXgTpxkWjgIJT47ZxF9hD4LQq4mH1_0>
X-ME-Received: <xmr:rAfRaixS9HZcC-h7vKsKwzYMKc4I1qxSDx5dCdsb34LBqrcA_jZX-v6nf0lTOP3efbk8eSDfiiTVLVH43IZf__4OJhZS6pm8YWpr1o9b199YRw>
X-ME-Proxy-Cause: dmFkZTGiTgd5O7w1XEhQ8+Vh9fhzBjNrPwn6e1wBLGxamiEwbIfaCA/TEN2QKGFZLfkR4u
    CpcGzAkpfYQsGUQjgyCKkZDDtAnurzRnJfT0PNuoOOd2Dj8r4F0UzWVJnCPjlBdew9riDC
    y3283335LZngGITeEOuR29b7KlO5WiuCqtTyoENbpJlp/n5+z8robxAFIJtWy3eKDxEp2f
    vDwDHAEHum4fg6KHRRkZNybILXjr58HBD6ptxSZ4Sd94AhUauaOjGLU16DlM5m7kM6Hjer
    3wmMp+182rtWVU9Hvcqi0fr5ZRjiQCYQLDDOZ0NlLiGEm2kCVXo8/jPCG+L9f2A5tOiRdf
    L8bEacRO01qRrcrs4rMSqlfbqkJwivEmcw3Q3o1Oh5Xrffsc893hftD9qNtep4s4pxqwcm
    8ZY/hbyyN2Wt6t2tuyt3Rzi04I5dHerWQI8Aewjqk4ZyM5fD7fyv1SJugeg6XvFaoQCH5a
    E6OHNTFPmr1O1HENhXG30052iTY1GBAfzc4f3NcyBqmKlIehiyWijPVy0aKSqp8C5IW4aK
    Xd/f+95OdLlL/JQojpXjvGYDx37YInlHzlAqjkLtaS7isqFQmo9udButO+7uT7tso3utw8
    QdSbNOaanbKtTKr6vH7uFO00xJUigZ1nlOHce0m461q0NBZF2S3N5QwpXEwA
X-ME-Proxy: <xmx:rAfRasGSiumlzh6GE7XonH4OHkoETwzq-wZ1o5ilBb2JYZJ_GVONNg>
    <xmx:rAfRauwXB0XWC9XuWKp1dgmxiEWTSZGuA7rEudcGwToFYfQ_fCJ1RA>
    <xmx:rAfRaluFqcesewFJjnFw_MAN8byJ1q4x-l7PuXYCoQCg5SWu8mYy6w>
    <xmx:rAfRaj2dzLJLFSwip-5EHLQks3wvcu3FRtw3DHBOghQStpiO01fQQQ>
    <xmx:rAfRag2OYHPGtzQRSwIDJ8KAh5aqJyLOMqJ6ySU9AIocnTR_LtdJU5Gw>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:04:43 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v7 0/1] repo: add revision filtering options to "repo structure"
Date: Thu, 15 Oct 2026 13:03:41 -0400
Message-ID: <20261015170342.39967-1-markchucarroll@fastmail.com>
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

