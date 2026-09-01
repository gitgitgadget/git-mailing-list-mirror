Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9FB4A207E
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301621; cv=none; b=KQ7OH7V1U8dRjQiSjMU42s6Wpq0ZXD9lHK8r3Bw1ljTtBu8rt6NEc+MNYwkbWoJTqzw0Id/dLKbJgAnP49Ie044830TlQl3Wfh1FYWXDF69GKS3ed5JSKqVqEkrBPdICbiefBAzI9R0eTd/uKyqWIGAGMQlkiWa116JSsDsDcDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301621; c=relaxed/simple;
	bh=XvHOhsgMUgvk3JLB36vHnijpkETzhggZ+dDH1TqQMkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G8ZQB2oYIeDQ49GrXrdp7WWAHNdCXjvwIEBxOCFXdRjfe5Pb2bd9zpuRaqhF3DAKsaloR+GvyFUpELu+pE+NQWgzaF9sawK+Z4EhwFtuSlfKqa/3tE3T+arpDJ0y+hJQ979c4tt8WQEZZmUmpbnT+EJ8md099zws2CMlCGPsbyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HcyEGdtM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NhatvwtL; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HcyEGdtM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NhatvwtL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 62D2B1D00054;
	Tue,  1 Sep 2026 18:26:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 01 Sep 2026 18:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788301608; x=1788388008; bh=lSjPmto2FO
	+UW8DFQfXBUhMh7THS4NC8m/rgAiKulKU=; b=HcyEGdtM/suBmnW11P05mK5Bn3
	A1FdB160Vtahj43DSMl4krCBE+QbfzUF1XdVLZAvyRwveRBzVkbC6L+K/MAaExza
	e7WxLc/Lpp/79PJyaB86LXTiA5spWSLzzp1gFd68fC+kZAaYJEYiHMVplJQh/k//
	rywd0b7UC2ZeKOGMVeib/sgSf4/jKs8GRvnAjFKRJ9ea2Y1e0XGV+RL9e2mYAIf+
	q8ri39vb3as49a7jlOaM8krr2q4EjzW9donowayGtWZycCnCpiKZlaHsl7aBUQt6
	cjRQmYiXMXlBN6EMG4CPVi0S22+94yqGQByOP5hoHQ0z+LT8B/dP9O2sHv1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788301608; x=1788388008; bh=lSjPmto2FO+UW8DFQfXBUhMh7THS4NC8m/r
	gAiKulKU=; b=NhatvwtLk2/HNDOAy/O+fKFdmuYRI0N9FUPX5b73//zbQ02Jd9g
	6rSANSrXT9CiOfT+1yXgHCuxYoE+Eeq/iRJNTWg7fFEyJ4Mqd6T5CDnaaCI0OLOj
	g1ACkJSMu93MObD6+fFuxrr3EjrBad8VKla33xEBYLZ0C096kXHF/1X6ijIeulv5
	VOPaEDx8Z98qiKYrWkpAJMI6TkKXWUlNXnqHyVVuPQ/F+HMjgdqHVqjbntPBGmD1
	G6K+Np7iz8v+qma5REoi1Td0N+md4Hbm9vIFyplRdgg7m+r0h4nV2M+nCKwHgOaQ
	dF6d7XfGEFN9UItmkUhClGSc7nxx8A6iXvw==
X-ME-Sender: <xms:KFGXanm-KwG94dlumrWCydT2t0DynVawiSo6ZQsU2XMwENs5c4xCgw>
    <xme:KFGXaiTHHgR4LDKMVaPZp4x92Bx_8t36HMVD4nwo6zCe3DkfQTcjVnlDjk-7t3f5q
    ItKQ_zPj9eDkz0ltpxYU4BivJLoIN3yqSVfH61JrR8QUmyUi9eTpyk>
X-ME-Received: <xmr:KFGXarAqs2li-aYdnr7ZarwQnQQUzuMGchIBTUDVcJgBdgvOxfTOnBBOYaQFH5uyNaMVBqtTNt7AotjvH0lvS1DWHFs-9UBqSw>
X-ME-Proxy-Cause: dmFkZTE7SXXivgGr3cKllNmyAecIQqcSFcksGJGosQHsyNi79kNMIhvrE9K0J+ZT6wHceQ
    L9my8sqjf14BTeGbE4gkmPcOw9hX/NIUuHCuxWpx85xmHx6lZ2WdcWVR16ymAO3fItZ12H
    xWXp/YzflK7W4e7wK1NzlzCTFyO6GJd+oqyZBxzRwlCsQTj7oJ9rzOQlng79EubPohH4jc
    X7GlowoMu/G+KDpUnG5/4IYAro5jns08i78guQ8jqMP644nIu6rUknYNAOvS/OtpEL+Rlm
    IO2xUEUI9n45EocMGrm48xuhfyi2TjezS2+wp1gXCbQX+wjApn1AY7I3AdmI4xaKNWKur/
    Io8z08id5w/VSx+HxcyI3/9/K6n1NSY0YFwvLZhNgq3ksLklbmgbx6JuAMxm3Zx3AWKTlP
    gF/A8/w4Yvhrnmq5W8SKwVlmAims65/oQl1dm2+NkhgSKfAOgeC6ZDKGp9UwwHTVt+wcLQ
    8jUuBbcDVWWOj777+bJloPw6chHmN4jPFxLuakTeLCsiGr0UMGkK0ei0iMeqsroYCjle+m
    jzqL2xOeZmFr7/H7eOqe8vrVFRw/DWkHQFRKoZzx0/lvxwHXZttQCTr0Og4/QindHV8yPz
    03uCsZPreJRLatxz9frEwQgfDE+qId7HPMmPCPbXf7cO59Q8ZPq8fS+net6g
X-ME-Proxy: <xmx:KFGXapTQrdzlWMUgd5wrDxj8BGiuxC-9gMLoTLfpijQTB1CNowT7sA>
    <xmx:KFGXappCOCqOABVOSDJkYp2hic2QDqkJh3reHNHsHUaiWacvdOdhbw>
    <xmx:KFGXarw4VILkAFkcklfvbbAwfHvqtoB78M-wNmnoRqboOXEMEJA30w>
    <xmx:KFGXauIZ-OvXhkfhg4n_yBUX95psRD3XaSr8fg5l6_wk1qyH90dcFw>
    <xmx:KFGXaiaXoONesjcWe6lWOYynD7xnTsHCAQyW9B4L_JdocVTMJ5u7KOrs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 18:26:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/12] odb: remove infrastructure to register submodule
 sources
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-6-97a312d5fa25@pks.im>
	(Patrick Steinhardt's message of "Tue, 01 Sep 2026 13:09:05 +0200")
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
	<20260901-pks-odb-registering-in-memory-sources-v1-6-97a312d5fa25@pks.im>
Date: Tue, 01 Sep 2026 15:26:46 -0700
Message-ID: <xmqqv78oliah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The preceding commits have removed the last two users of
> `odb_add_submodule_source_by_path()`. The mechanism was only ever
> meant as a transitional crutch while migrating submodule object
> access away from "add the submodule ODB as an alternate of
> the_repository" towards explicitly passing the submodule repository,
> see a35e03dee0 (submodule: lazily add submodule ODBs as alternates,
> 2021-08-16). Remove it.

Yay.  Very nice.
