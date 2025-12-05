Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0025E469
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922822; cv=none; b=KecjLRPST596HcGz7JQf5Gyu9Ybu7qXqCwbRufBJwNfEPa84TAZzu3LVJnvi7r11ZE5YhyduZvMS3luxZVdeCghLmIBF7i969ubpWQmRSvpBgxFOzIvszeHiuPUs5cZCli5jt1Hpmn3/R5mG9Fmh+438KfRHCcZWO7gBW0hY/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922822; c=relaxed/simple;
	bh=EWI+AzPYPrlesK3LDE5CBpvZPzFq2WCSzKsHjoYU+Yc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JmZRQ/N1pY9SvNUYaMaqYXeH2XomK5VRW+6vH98L56cX6jCnSZ8uddIYUd7y/C7A+VCra4rkpDTNbl75uQYlgXoQLtPDeMdYjevYDVCr/RYaZ9yzNKxHhniY/26SNFGLN5oLD4seVuB4dwszlCGtZW8ZX+iV0crftYwB2+OWnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mCo1yeG3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C82dxxG9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mCo1yeG3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C82dxxG9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 79F987A029C
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 03:20:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 05 Dec 2025 03:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1764922812; x=1765009212; bh=XayjTUxqG8
	94TS0of3DNkUYLvtEE9DBQsI1ztdbTFBw=; b=mCo1yeG3CLOlXqHpwHR+FaehE5
	ExwKUQMFk/iwed4O/gGL8vMSeDDrprzq1GlPs1FB/HTFJD32+nmOmqGTZx6YnR+F
	EbJpymGxHYOwc5WjuAA44qsNYqdozTb2yLMezdm5sT5LTlDyviiLQzM1hiEKg2n6
	UTn7XK+6FlriI3r1U7QFli256uJNeA1u3jHhpxYd3qPqwdC4dROMntQNaimXorRG
	EUNuOhdKghWv/irJQ639i1diFpm0AHZ9hsJc1YePbwVnbwjEVHHVXClXtu2wcf4o
	vEolk3ocQKd2O2fOs6cJmmyp1FPdbmKxeuVq+dIdG1U8pt71SbJ2EcF8Qnpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1764922812; x=1765009212; bh=XayjTUxqG894TS0of3DNkUYLvtEE
	9DBQsI1ztdbTFBw=; b=C82dxxG9JHcJlHxaxBsch3sm1EXOZfV4+ej2M3IgkcP3
	KB77O/KZK3UXtZKdiE4kC4ZieRAkA3UAk/hX60hkpDHFKXxlIkar2XMEUH+cvSQS
	MYwvKvhZlx1crTKElYYmVHr1uKnS7rF7QpCJHlDlELMWlp1tlFmUKuY/d8wNPUID
	OJ3XF/dK8iNasrF5BKmgMNgV0nXnsj6VPOGocIu7yo71+GndVOM/8zFLaA3A6Rzp
	4oxMtR3vBYgo1iV5DpM9ToAZQgDcV5apJWDO+T8FXx1k6fz32f9Acni4G+y69zxp
	npKAYmJe774bOUUtxTLlfRHZuh4f3fzRTMnVZtSHMQ==
X-ME-Sender: <xms:u5UyafpTzoC55UvduzGt7MCsgG3JnvZ_wi2zuEHtFt7oL3lP2uC0lw>
    <xme:u5UyaQlyZBTqruluZAkobavaJHnNZH83umeyqLqy4UDG7kZidm6h14UEe-Z9-1FMP
    0JEJGWyDlxBWkqbA3ShY20dn6SSF6wZgB9g5CZvjzrJnSAa1HIx>
X-ME-Received: <xmr:u5UyaR0Pp1efFI1N7PjEp0ttNJMgTSUe2ddJ4nPGXqcOzMIV3X1XQOk6HD1nug5JvdUSj6WLwPe1HXr-5cRGtwKMrgdjyVljQMlINArT-54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtredtje
    enucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhi
    mheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevheeuhe
    fgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:u5UyaYD-5ubBvyYUcJ0sgHkSDkrEsjSCfT2sYMyqybDBw6lQXJBDYQ>
    <xmx:u5UyaexRJhh4nzU3g5Yc6j6JT3qkvjYEJg-uRDV2xpyzXVFlzYMu-Q>
    <xmx:u5UyaWnWJaUbGqm8QdjMjbOUXIH11iD_WNVMKTa9VKbw9xcenNtRWg>
    <xmx:u5UyaTGqiRVsSoswgOO8L4Yek1OXMK-1cMOdQp7ORqZbBglD6M7Mhw>
    <xmx:vJUyafLtlyIePUPc-0ap41gPDUGzigZuFNC_7OfD3vAep_X3-cgCVU3B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 5 Dec 2025 03:20:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e51eb28f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 5 Dec 2025 08:20:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] Some random object database related fixes
Date: Fri, 05 Dec 2025 09:19:57 +0100
Message-Id: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK6VMmkC/x3LWwqAIBBG4a3EPDdglnTZSvRg+VsDUaERQbT3p
 MePw3koIggiddlDAZdE2beEIs9oWuw2g8Ulk1baFFoZ3t3IAas94djLjcjGV41VbVvC15S+I+A
 PaeuH9/0AbLmZ1mMAAAA=
X-Change-ID: 20251205-odb-related-fixes-5f48a0993ef7
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

this patch series fixes some small issues I've discovered while working
on some other patch series. I've decided to split it out of these
because I'm hitting the same issues in multiple series, and I don't want
those to become dependent on one another.

The patch series is built on top of f0ef5b6d9b with
ps/object-source-management at ac65c70663 (odb: handle recreation of
quarantine directories, 2025-11-19) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (3):
      builtin/repack: fix geometric repacks with promisor remotes
      builtin/gc: fix condition for whether to write commit graphs
      odb: properly close sources before freeing them

 builtin/gc.c                |  8 +++++---
 builtin/repack.c            |  5 +++--
 odb.c                       |  2 +-
 t/t7703-repack-geometric.sh | 26 ++++++++++++++++++++++++++
 t/t7900-maintenance.sh      | 26 ++++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 6 deletions(-)


---
base-commit: 2797238193944b52d12624a04a962f40b9bcad69
change-id: 20251205-odb-related-fixes-5f48a0993ef7

