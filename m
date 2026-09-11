Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9D3E4C7A
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105928; cv=none; b=nRzM2qoFJBJyXwZax7nStNPorF2cqIgdNOqc5CSxm3vZsustfIVIXdRDYGUnd1XS64Gbh/9CPoXVe0uTmKtA1TmxxDZymiHPXKBoib7271jHpsF3cTjofMf3cnlniCi3zwQ/emOWzuNXWbHQEtDoZjqAxK+wpihb3cK89qMidNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105928; c=relaxed/simple;
	bh=9zgb5ek3KzfAIalFli2GulYq4AY9WfyISgWdfx0To8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vF/CRiqRRkCfUTev9fYD5cllIF0+vsJC2stturvYIrvZtau/JK1kywcC0lBlJKNZWKZuY7JYZfeR0yFHlZ1LaHIstVCdOOwaNGsw+6HvLc69XHHafI+rozpnMCc6t+WOzkT6/rR4s5A+2SjhNAeXf5bM8QEHnpAmBM/Jsta1ZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ioct4boD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F2Xka7QT; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ioct4boD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F2Xka7QT"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 9061DEC06D8;
	Fri, 11 Sep 2026 01:52:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 11 Sep 2026 01:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105922;
	 x=1789192322; bh=83eZF/cpFqvS5C/eIp91Vlgg0B9+5jCswcHZHPqcKEM=; b=
	Ioct4boDdVamzu5k+4umNN5Ksvu7q2/D7/zw7N/r8Qy8mBdLeKT7Q4UJhvESJEmj
	fM7arzt4m4qUELqMe9KD7gW4iFJ/r5RKZTcpgyLaPAJ8/4rOa3ODxXthzqlTYa9D
	XT4cd1W322j6KoKipAWbcbALwa5HT0uXxCwHaXRR2GMhU+OUeAXu3eiIXqdKlpyk
	ZheFfyH4fc3haGP3CFosg7GGnnVTIwxaFSSb9nKS2UwTtsZPLGwwUaJljXrRUETI
	BsHil1kALuqJrFkz1nD1wUXtS/zIQg6RVI/KcPSMK79298Hu+CWMpLh2eds9oEUm
	XfebLHJ5YvdSJTIrEMxWVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105922; x=
	1789192322; bh=83eZF/cpFqvS5C/eIp91Vlgg0B9+5jCswcHZHPqcKEM=; b=F
	2Xka7QTLyOjFYCnPtdL0S24Wt8KXOzjR+0RG7nuERtRN2VbqoDmUN6sXH7bKSl0A
	MH8F8zswJTIOa/0fk67paFqHbyiixeN5HRnuGp2l8d6L9h5xEoWWbxxgaQfjIiuO
	tx0aQqbIutdXKbYezbON8d2mlFi4hNGI5h9LidGLXPKscpm0rC4sgH/ArEUf9jU/
	UtnLqkHr83FKhGrZYIm0mKNn8eJCOaC14ZlEm0wjCT6k84uN1sZK41QTrJkHT1M0
	WmUDJkEHfXBiZv54wvzSOdvtZSR4joHwSJaNNm4gLu2dKgcCITDQ/oYtBqvDCqfw
	teYlsdz8mPWuz+XPo8uAA==
X-ME-Sender: <xms:ApejapyY6AtcIf8YcIMbOnCCSoHcxN4IMwf-cVGKjrcxAapABPw8Iw>
    <xme:Apejagsax7R7ikkcCEPH_A02nz8KMCEHoTv41stHTIQmLDiq58MJiUXIW0TOZ1-Wf
    vGjQB-iVMOcJIqjDX4VO9Uf1HuUqubOzbmbKB-fkYGoU67Cd8qY3Iw>
X-ME-Received: <xmr:ApejagsBzppWw19Q2E4t0Q5pmB7vFcIGucO9gXwyie3Sg1K-10Z50mu2biVgbaVwyGcrKQ>
X-ME-Proxy-Cause: dmFkZTGqDaxbQw0b1XGVch0RkJ4AYeStw4PVBa3bcgIhUpfXL1D6qKF9ClM/osX1kPXWWN
    hZ0NT40O+O16tVxkmUBWLrsXM7cDu3P8G5BMeU4gYimHiWjnabaEVtKRxcG1l+2SA3fruH
    qRnh0hjRkfKPwown19wLAyxIYGG+i0Wl5FE/Rbkq7YeNsUHxZujxfc278JFrX8fxdGcQMU
    Zqn/M9ArmY/+TRmYrIr63NgZ71so+SD7J52GrLBaP6PmZ+zA3ndtkL/5Qn8hU7ZeHPpzWW
    4ssHe4DDpJmHyk40v0a080QSCBc1X3HpUYZkVeLrhRzkJxHahEsdvtwfsiDQ/CzxZ/A8sA
    EkmF3Sc2pAH7DkQimQvbNY1pPNKYn01/QQN7wHWnJVh6UXv+i4ablIWirfhXKLF7VKHbcD
    Kv+jHJKTqlPOY1M5luyoXmB/699oMYFi3vXxp5xANgP/BMGVrtJAZhvEZpsh2XWCY8XBfw
    7EHvgiG57OKdLIL1JS1R3/AGOkrvibZnPSt43JqRLIiHEwkNi+XLGdPs3M3zlTzCeQaAK1
    WqadUM1+qUE0IpuSm9QiqHBHdYRwc9g6EL2GbZNZZObfk+d+k3iX/K5tCg+GqcWLoeTG3w
    5ypfzMOpXW7Ca/IQlSM1mf5YMVfHH7lRvka0QoR+K/XhU1+zRsv/bplo1uJQ
X-ME-Proxy: <xmx:ApejalPXlGeaOx0Gzk__gnr3xnJIXOw_Jm9ix2WnKg3tBfsZNoMG5A>
    <xmx:Apejau27ubgkYsJfLl0iSw8lnVlEKJBhp2dDG-g6zoUFtDKb_W1Bqg>
    <xmx:ApejahNz-VSo5P2daP110zWxIM3TLlyRntcmafBbyUBUGyeSpxx5YQ>
    <xmx:Apejau0a8EjDVxglY_gXwG3GPqGTD_v1cSvxr_n0XI3dcRkC-YnpHA>
    <xmx:ApejagugKgZH1NoyeiHbVSaELu2AAaxGqYtNyDGJcMi4M6aZ9-qkhdfb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:52:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12865e16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:52:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 07:51:48 +0200
Subject: [PATCH v3 05/13] submodule-config: stop registering submodule
 sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-5-447e6882ed14@pks.im>
References: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
In-Reply-To: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When reading the ".gitmodules" file from a blob in a repository other
than `the_repository`, we register that repository's object database as
an in-memory source of `the_repository`'s object database. This call has
its origins in d9b8b8f896 (submodule-config.c: use repo_get_oid for
reading .gitmodules, 2019-04-16): back then, `config_with_options()` was
not able to read a blob from an arbitrary repository, but would always
read it via `the_repository`. So even though the blob could be resolved
in the submodule repository via `repo_get_oid()`, the submodule's object
database had to be registered as an in-memory source of `the_repository`
so that the subsequent object read was able to find the blob at all.

That need went away with e3e8bf046e (submodule-config: pass repo
upon blob config read, 2021-08-16), which taught the config machinery
to read the blob from the repository we pass to it. The same series
converted the eager submodule source registration into a lazy mechanism
that only registers submodule sources with the object database when an
object lookup failed. The intent though was that we don't ever have to
fall back to this mechanism in the first place, and to verify that this
is the case we introduced GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB. If set,
then any such lazy registration would cause us to BUG.

At the beginning of this series, we still triggered this bug in t1092.
But now that we have converted the "cache-tree" subsystem to not depend
on `the_repository` anymore it also knows to properly access objects via
the submodule. With that change, GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
does not cause any failures anymore.

Remove the call to `odb_add_submodule_source_by_path()`. This removes
the last user of `the_repository`, so at the same time we can also get
rid of `USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule-config.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 7c73fa108b..37c3be377b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -803,9 +802,6 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		} else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0 ||
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
 			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
-			if (repo != the_repository)
-				odb_add_submodule_source_by_path(the_repository->objects,
-								 repo->objects->sources->path);
 		} else {
 			goto out;
 		}

-- 
2.55.0.1074.ge7621b4bad.dirty

