Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A343CCFB8
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853747; cv=none; b=g6GCjAQ0eN/x1UZieelSe3VkK3/TSwQh1wr2EokWhFHChwljldKV6c5EtzrcWWchxrpaxS4YELAkYFCdj+IbncYqHYnKRZmCRk43tIT3oBqbjf5efKWeGE6croNpcrHf72ntt3I08vZAkOBKQ4LjA+jlXlEyjVgL01vmdZWdvLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853747; c=relaxed/simple;
	bh=Xckz+2zz6jnuyo3s3PGziAeZa/fZUqQ+8S+wIPdxxgM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kOGfthIicrzlQ8HXC5OBAm7b9k4rhK24tOBISBgFVMMcYkeifvC7YoyG9qyHZCM4EO+H6W/2QDpGMQEJa0adlK5zzJSohK8Z0+Xh1v3jEZAevhCwWn96MbNNaqlG/HO9aLLuRV9j/+kkZoL90H14vLG6NTWVu83MAaDs1G1dL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AAHLYNbT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hM+dqmM4; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AAHLYNbT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hM+dqmM4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6BEF11D0020A;
	Wed, 22 Apr 2026 06:29:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 22 Apr 2026 06:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1776853744; x=1776940144; bh=f1kUS1f16A
	uc2NV30GYOoOUVizAS+RQlHIcU6+mrfMM=; b=AAHLYNbTkEzvDcCQMmLhLTQ3NE
	QXFfINsy3kZCwVKu9NTwzGCHm0urRfrQ0Ef+yD9K97du0HEShDCVWzqTt9+1kr4x
	LIvTZsMJoyJMwbfy98Va3TewDm2Rd9Geo1cMvVXA5mpL87WLfhrh67os2fVuwk91
	PceliW2N7VeFEQdClVtbBngDIf0Tl1I7JpPhL9dSNIirYPJLx0uyeP11fpc4hXi4
	pMXbSRWz3nFew3GKPJILWFEU9Y4nacn+y3MeYRbZ0ZtSZqQt+g6vmLwI0bai/tgz
	pZ+jS8euekxTTAoLvzIIgAIiWZDVfb06E9ZJY+V+Ap/5IU4S2TzLCCXozZag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776853744; x=1776940144; bh=f1kUS1f16Auc2NV30GYOoOUVizAS
	+RQlHIcU6+mrfMM=; b=hM+dqmM4rnYEj7JEi0G7bVMKrpmEhEamg6NQ41wmF/dQ
	ksRy1SBD1o6UqSvI6fUHRZjCtmY+poBv61D4RiocW5y+VOfn6ttbhG7FksXDnC1B
	ye2/H+m30/K+jkFSynMdfWb7Qh1CRXjNG7Xrs40ZrJtdT2OyTRSQrvc/kIaQ93aQ
	H09FbXXmE2t7kHReJinPgZnDR/bAmLy/BQCxsvvOGdwt3Ig1mhYxrqmYrRfIH5Cz
	mDj3R/ndYWf514TPwyg3rWvw0uWm/Zw2PT4PyscKPhoNPzLvhR7azJUXdYUoNwmr
	LJzJ/Itm5e5JYiTVlhuznDgwUMNO2rj9NZglZ5t3kA==
X-ME-Sender: <xms:8KLoadDpy3hXokH71WlNro6hB_4HWJOYFAeo4v6ikEZjj0DRBYuMww>
    <xme:8KLoaRgNN2dyieE6OHsRbizVBN9P6-TzALgHQ5x3B9IdrTXVe-KHDTEywKvfW7X8p
    Iq5kFueXnPFIqcsrh4CDqjJDGp8CloJM4wuf9PmD9L54swFtWD5>
X-ME-Received: <xmr:8KLoaWMZnX64E4oUKorIexHJXmhmf4BxbL4mJjbywnTolx0i2Gn6lFLt9_32qYHPtsK89L91L4ex0DEshgIV7tfMWQ_MzdYS06IPTqVidZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    eugeektdetieegjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8KLoaS4K0XaxqQOAeS0O8JoTKkBryyQcDJcEBwSG0F58tn3MRp3VhA>
    <xmx:8KLoaU0nVZY3ycYNS9G7Fo8PDeIyvbmVDHqVpFIygQSXqmw-HCkwaA>
    <xmx:8KLoaTbVJCKI5IfJRvtchTwNZvYnI-SVRGR6nVRjUPePgs0iMVQTQQ>
    <xmx:8KLoacD-md63ghQ1ANwqjlv9yxhcSD7ITAPhKMbYQTbVA-YiI3O8qg>
    <xmx:8KLoacwBgV8q7--r-FeFGdrrvYFiPUcwSJ_P_4o_peebxHcpZ3E8e2kk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 06:29:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab48b5f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 10:29:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] builtin/history: introduce "fixup" subcommand
Date: Wed, 22 Apr 2026 12:28:57 +0200
Message-Id: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOmi6GkC/yXM0QqCQBCF4VeRuW5gmxaFXiW6cNeTjoEuOxqF+
 O5udflxOP9GhqwwulYbZbzUdJ4KzqeK4tBOPVi7YhIntfMiHDynp/Ggtsz5ww99r4kDpIGLvnU
 XULmmjDL8srf737aGEXH5tmjfDxq9j3F4AAAA
X-Change-ID: 20260422-b4-pks-history-fixup-be27e0c4a03e
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this short patch series introduces a new "fixup" subcommand. This
command is the first one that I felt is missing in my day to day work,
as I end up doing fixup commits quite often.

The flow is rather simple: the user stages some changes, and then they
execute `git history fixup <commit>` to amend those changes to the given
commit. As with the other subcommands, dependent branches will then be
rebased automatically.

This is the first command that may result in merge conflicts. For now we
simply abort in such cases, but there are plans to introduce first-class
conflicts into Git. So once we have them, we'll also be able to handle
such cases more gracefully. I still think that the command is useful
even without that conflict handling.

Thanks!

Patrick

---
Patrick Steinhardt (2):
      builtin/history: generalize function to commit trees
      builtin/history: introduce "fixup" subcommand

 Documentation/git-history.adoc |  52 ++++-
 builtin/history.c              | 198 ++++++++++++++--
 t/meson.build                  |   1 +
 t/t3453-history-fixup.sh       | 500 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 730 insertions(+), 21 deletions(-)


---
base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
change-id: 20260422-b4-pks-history-fixup-be27e0c4a03e

