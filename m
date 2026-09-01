Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29E47CC92
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260985; cv=none; b=Rif7sgofgboLXGWqoBiQcgOVUjLkeB3ExnfWufwLvHdSfxMyBTbrNG9Iwcb11D2JgotOwJOkbHU4ElGy15Nn/63IT+WX+SPxOFb697K9X1Je4yqOJvcihFj/iA2Zv1iuJdujVB3Ka20MxWOUAYakSeIfsm8zu2yHfWmmtN6KyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260985; c=relaxed/simple;
	bh=sD3hunL0YJwdQ999/P1HR9ZzsHQypHdBE6HliYPSzWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBsVM3wdtAY/QYh0WhVhQX6JQxgTI1tAPqkWVMJYSuui3CwDLJRr2ZURr1/qJ15NceFzE2E3v6MeFhkmyUOhDorjP5hJ5dFQuar9+LNtM8JqUWOWNqXlX8BP73EALlpPNlaruIoTCpz9kNPdvDyf/901MP1s1PJEVAt7fbR75lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LVhal9Pd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTLkOUcj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LVhal9Pd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTLkOUcj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADBC4140004E
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:09:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 01 Sep 2026 07:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788260983;
	 x=1788347383; bh=CagefgvaMetzmlSWYmb83Zfq+txGcKepj2XCUivxaz4=; b=
	LVhal9PdHGlxN4eBSjHWpCyYye+HooSkUgpH0yVH7PpZN+gNmII4jHXUvWBGyqtf
	QxfxZx587xxjpmnzE52eQPUzALwuccaH7wCdnuPq64EvHcNirsYK9m+ST7mTHMoA
	26RDO30YL7h+OMD9dPkpPp8L9wMkd3V/dgKDqZLMag4RQUOf8zO/4TLAO2Q/PJGR
	K96Tz3WYk8Ou/9uJhxms5ufDAjQvDU34bUsQzhMsqdhxtxvQ2XB4bCsztzt1Wg2u
	2ARVP6dxAGq3qTnEIMEGGGoPY3Z/3ziV9JVlb3bLNEi/PYWZdi1vLAQOfW+6+BcI
	A3PVeYg8rvJw/ovtHiPapg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788260983; x=
	1788347383; bh=CagefgvaMetzmlSWYmb83Zfq+txGcKepj2XCUivxaz4=; b=H
	TLkOUcjBWyErzYKJ6GbcACX3HQtZaxpeGaXm3/liOXVSi/q6a3nbKdvr2fpLD1zf
	vQo/u3zMHKtrmJ2D9VefsUBl8/gC04QE29mJXLt37B6zAsBqdczQ5D0bA4MehSTx
	9a7e2xsoqPpXztJJdF14Ogh3eMcltPrPYCTIADjCtH5Gkut3k1Ep29cTRFJwGvsh
	iJOKKtiXTnqC5LgCiTHlipBA7GNUgOdK1zgQB6DJYRWxn6YpXKHXTDbBgVKyJoHk
	s3kb3yXDOwQlDWe1Q2PtfDX1pIy7eLZtGjIIkOywyXod/Jkxad6xGnUZhIO+IYCC
	exufTdLO8XT0Tp0i43Hbw==
X-ME-Sender: <xms:d7KWaq3TLXWjfn2eIm_5j_coMnm82SyQ6jOHJDhQkDRPXkzj32d_uQ>
    <xme:d7KWakCjzOCn8ypRJGY3WLuMmdOYY94x9JFjZztft7r4sgCzQ-OH0XLSsHNpQEFZr
    25eiiDnSCMUfXzm4NgqTrCO8n0T1IGitLNyiZ1AXtsYRM1JQ-bkPA>
X-ME-Received: <xmr:d7KWaoht7wwWyDkciYpbR4IupoqG-2xtf3F98c7w_JYXBhrEzY3CBA>
X-ME-Proxy-Cause: dmFkZTEN9g1Fe0QNve9ECoP2TiUiX4EEH5POEiwmRiQIlHZ+xDbzHkU7NDd2M3NVK6/umO
    bXXkzUK3COWchLgt1/LK6gQ+MqeSaO5Oixh8RPOTrogDUVvdApPqyytnFYWyXEx31a/UW/
    VrRjQoyTePvVd8NFe+FYtwmzmG6MTjOdJtb92EaY7FcVv+MSIEhwv9SzJucvjBA0gTjUZ5
    irBlskFAJd/x0/Ql5UqM+PWol2xq0PhHqo6xS2QHAKohbPBqVxfe/t/HxXIdPstzFq1tQ2
    zZWYaDW+dfkh9KQoVCr2N9lwFiWtupwGIIOt/EhVGn/DGYrANZ/6T7aifXl4bC+/EDNaUV
    r0eAAbiaMv+t8q+b/Eoz2l52nOpcA8/bbaa7GU/kn26qTCBiqB9zm5OPmouj8hcy68E2Rf
    riIXmkKjIMUvAevn2Xej2wx7+OFDPDtyo2wakKSUJgg5F/7ZcE1ToLidy/y57dixS34QIR
    nRmg+UHJ3g/AFDZ1ytiNAfYAdD8Xkf5ACs6YnV7ThqsPEXl0pXeYcxThTErZBMK1hQD2B9
    xFYMcVnnJXk5mcxN9/Hp+NZSnzdokatt9QKmEyALbyXVBtVzftZA70PnMTDGxJ/oN2F8/G
    K5g5zy1Nvl/ws9w8savyyAKiFLI8G2qbGt5dl2PqsFh6WVK+oYKbJlxCWScg
X-ME-Proxy: <xmx:d7KWag9UL_AtiHiZypE_3qmTf2NdR04NheXDI6mozvdaz5E5wp9NQg>
    <xmx:d7KWas85peoFG73hQfoNfZsqT0jmZfHzVHJRvBuWcdVvAT3mYKM7QQ>
    <xmx:d7KWahCEyOhfR-Bu5BsNXEEVOZcx0zSuV-tNQwTqSPgz5F5e_JLf1w>
    <xmx:d7KWakykxfEct4eOdUeRT2amnQgIUt1-DmsEK5b9Y5sV10vry134VQ>
    <xmx:d7KWakHFbHMhrS1wllPDMxnKcnus-rO0cms24bohiGQpWnChJXQzVKJs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:09:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4cff18a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:09:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 13:09:03 +0200
Subject: [PATCH 04/12] submodule-config: stop registering submodule sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-4-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When reading the ".gitmodules" file from a blob in a repository other
than `the_repository`, we register the repository's object database as
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
2.55.0.979.g7e5102b832.dirty

