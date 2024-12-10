Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E81A0BCA
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832131; cv=none; b=LA0inoasc836YdGl98LHeWuvsbF461YlMLhWyTtfqK7rJaMXXdYRT9l5Stj+86RlW4Imifm3R1K8wilvxq15Z5bGQ4LnlQTxr3ke/YQOJ4AdF2OT17Nxuut/WCsPgmSzLisw2TU3lUBsW9ipfbY11mapN8LD3hJaT0E/dFdPKGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832131; c=relaxed/simple;
	bh=ph4Z6A+nJshjAG9peED2uEpsg6wWFkVjoGu6uXOSy1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dLF+abQj8kvPkPVr/uMT5DICe2JwXIZFB5SnsstSL9AWx4w3DvSjzbR4kpHhdvJ2g4zYAVesH2IzCKnkLdra4pM20ytoTOUAgl2JZdqx+PO2OnWAe2LhbyKMUMDuCxJSMB68gUrUqAytyt9hr+7qpbJaZvBQw7jBst/i1oue3Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ABAtdYfi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s6n0zu/j; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ABAtdYfi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s6n0zu/j"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E24D8254010F;
	Tue, 10 Dec 2024 07:02:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Dec 2024 07:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733832128;
	 x=1733918528; bh=TdeJ8xL0yQkaqaL6oXvUcPOYxve8Xrwv4Ison0hYpDk=; b=
	ABAtdYfipKBIq1xGZRjZ1ukMdFZRiJdGkqDEoM4M0fg3wI623R/Z5sDguRqyKhmL
	OApMAfjpJLjbeiH+kmwHFtdS4nStv0f8zoIOXPnZeSh6LmSrDI/0lHkPtoQzPTjn
	mlC5d41XeJ4GG5i5s3zKlvnbiEiWrogdLe1jrV/PQ/Hlttl1EJU/HLnza3L8qanx
	Gt4SnQ0h4buIYdXZh1JAixntDM+GS5gx4iRz5FOx1XZBekEXppjg7T6qDdCk8HjK
	ewvDhX85F4OAkTByx6KKvAQwXv2LFmuvofKRwggG6Lq1IF/GCZfL2bimxQYB5K/c
	wK34Er7iCYU6SwKKK6V/HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733832128; x=
	1733918528; bh=TdeJ8xL0yQkaqaL6oXvUcPOYxve8Xrwv4Ison0hYpDk=; b=s
	6n0zu/jnURerK7CRBBsa0GiM/UMjgbDcKdfaJ6hwpwQmAY5j0MX6kzvWEWyU452T
	CfCCb82sBeCmBBmiKS9+joi3W/TVXF/9EHhSgaFr0iYCPSCXuMbXegHTFgfXGcTs
	g8sk3YNZ5XcI0eyUuRKrgHtjANDMBX/pMri9u2kyJXusy5vUUko9hrfJ/U57nn0L
	8US7zvQEAz1wCVjNYq7Hbu3X7tSdJebDuWre+zypPIj6E0s30j/1oZ9vPmVeel8h
	8Xqh+6hUKvonJHPDfVJidHPdlV/d9olUzUciknjXnRmXdSVsIdMXTVKX+HuWoOcW
	fyQRj4xKa3wRi5ItRje3Q==
X-ME-Sender: <xms:wC1YZ5K_71MXQoEtFgJTNKdA4flrycWucLPB5hI8yRwo1byENdXWpw>
    <xme:wC1YZ1LZv6Hxoqt2L0Wys7V1SxTIKBX3flinr9OMi0v3TvT5qC3Z5NQ87-YxSvIJZ
    VTJoEZMLJDJUi6jkw>
X-ME-Received: <xmr:wC1YZxuM56YyNf_mSA5el4-x1m-nXkxmW01k5sKK-jK_aWQhIuaOQs2JydB9uJJpXyEQ3Kbqf8e48dLYefgjSQ8pgNqBLk5Q3KXFunnzguw3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wC1YZ6ZVPvDo384tAJjNoUuF2Y6khCRy94lDMKOMceiz-DIddNTnrg>
    <xmx:wC1YZwZgyXDRNl7vhPf17phYrSOdDyhU6U2Uow1OFC8HL-VtRfmGxQ>
    <xmx:wC1YZ-DicSwAUPUXjj0IeBY0TzLgsa2qn7vuesdxVPCG9mUM03aifQ>
    <xmx:wC1YZ-ZqcBep8NG82YjrqWI1RM66-5o1Ka8C6-KuOIPChYDZBzKfGA>
    <xmx:wC1YZ4HEn0aPcAL8wOE7h0FIWwBC4JGfMa8dXrTTknegJTir_jK9k7cI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 07:02:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d8d33dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Dec 2024 12:00:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Dec 2024 13:01:49 +0100
Subject: [PATCH v2 4/4] ci/lib: fix "CI setup" sections with GitLab CI
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-pks-ci-section-fixes-v2-4-e087cfd174f4@pks.im>
References: <20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im>
In-Reply-To: <20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 karthik nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Whenever we source "ci/lib.sh" we wrap the directives in a separate
group so that they can easily be collapsed in the web UI. And as we
source the script multiple times during a single CI run we thus end up
with the same section name reused multiple times, as well.

This is broken on GitLab CI though, where reusing the same group name is
not supported. The consequence is that only the last of these sections
can be collapsed.

Fix this issue by including the name of the sourcing script in the
group's name.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index f15f77f03a06120afbee438cee76ddc2683e1fa2..8ae8c0f77461d5bedc24e47be75711f2da2ade4f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -55,7 +55,7 @@ group () {
 	return $res
 }
 
-begin_group "CI setup"
+begin_group "CI setup via $(basename $0)"
 
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
@@ -393,5 +393,5 @@ esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
 
-end_group "CI setup"
+end_group "CI setup via $(basename $0)"
 set -x

-- 
2.47.1.447.ga7e8429e30.dirty

