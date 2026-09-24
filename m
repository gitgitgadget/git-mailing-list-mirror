Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6A6401A01
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241581; cv=none; b=D0aVSZ2hR/3F6/1nHdFOLtSI/BJTmjHPFVq/CfksFmhw9V0dcU8W1hwo2+aoJglrmT+RW42n48WKYSIY85uvTAEmJssfpnEK5X0ZrvgGt4pSM25EVlN0lguDT4GIh5n4kluTrmZ36UTcz1kUBxSKbqlYmilVBZ+nPtqNG7zQrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241581; c=relaxed/simple;
	bh=S2yqFPH5aY+T5YrmJhpAssH/v8QsF9lO4iZtMFdLHjU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GcCS9bwfM/8JFt0F9f5/X2mg/h6CrQeY7oeBpGxGIgGe6E1sHTImfTLNzjFwCn5PIIUgRMRgUjfHjuQWj82Dz9WJ6H1gITND9egtymRpyNXAAPZ2uxuxucE8KIQPMJUMDv4ErroDEFc2ddnhdVziTy2q++CwV0LZhQsJvLZLt8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pee5sOtO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hlAoyMsU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pee5sOtO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hlAoyMsU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3288C1400074
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 24 Sep 2026 05:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1790241577; x=1790327977; bh=bk3vEMCJNI
	QvBM8t7Tvn9FU6S0Cpk2ExHxb2H7UpqdI=; b=pee5sOtOaU1u0ztl9bjGKoJL2n
	oPfHc1pfT3ljnl2POxFfjTerU76jbN8wP5aiIzcgbFiNVrcTJlvUIT39/aWMJeR/
	v1USjuXbkwlO0Di/dZ/ZQByF5bWCU3rY6phhhpUGFma044qv/s1FveS54bJXXv1F
	TIUAwLH8GMOQ6SSrHqWq0jBOo6r6nOftz15jamS8W3lUELMVfD/DFwxojnBaTCVP
	WIg1vph4obVn0ocT/6Xr/RmDKOzHm/eijF73LC0o8kVO5VRxu+jTKr/0Ou0IRuH+
	GdIHRADwVVr+u6TbQaevfOBXeEd6pXYXR3L71+4T05oso/77Odfdj3FmezBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790241577; x=1790327977; bh=bk3vEMCJNIQvBM8t7Tvn9FU6S0Cp
	k2ExHxb2H7UpqdI=; b=hlAoyMsUGUuVROOpqObWrIMM2ije4RML1bV6WKRY7qdi
	qX73wrDpiZtEIlzd32SvLkmGAFUUwLD3DuokaoSQUik3GCW4ynf2z5e9KzSU2R86
	a8Cu+JGPRRxCDoQecr7kT6cvS67U7NmtIxTeQS4hp0binOodjFi/WIytjjOuebXe
	WzOd+8RLtrJsVN+AIHnvyw1Ty+SVHKI9y5JAttPSE7heA+v5NPfQdMrQAS4q+UFL
	ZnTGGxvxM+wjgZ5gkOB/tZkHqa5bxD8qS5QDyA0WsWDM+T8HmFvkGTGuXuYY58/B
	hVFDS0eQW7I3zU/g6/H/edykFlZHOlSjcGZNqA1sqA==
X-ME-Sender: <xms:Keu0agB8sD3trco_psb6zQxSxlVXjZqvPVYhW3hezY7trxaYux5SnA>
    <xme:Keu0apfgLMrS5RZgoTiMxO4iGjmEzMJ33Ev8mT0_kwcfA9L8rh31FdJdqsBxlTiMy
    vtesj2hOang3qlNaI6NGzOgUN-lODJgdvkloB1kdQamx1T2KmfCKg>
X-ME-Received: <xmr:Keu0apO1OeB-WkLHrvoxesjOmj0Sx2oYEoLiTtWLJFcpLYlVWARRI0DEoiR_RGlep7mwBP4>
X-ME-Proxy-Cause: dmFkZTEfWtjPgYAUh4t9pV41C1cZaMFo0eI9PLaBQJHOm0/A7dEjcN01vNZWsMNb2YiF63
    LEdPYtgnFX9kceLnvlBtlGWyeeD9IqTTDLMpkBK2f5XBmzPWRJNYW36XZiTVxcXZ5jcLXl
    F2hUzzUfrsgLtK85FQ+lcFfshoHW2p0p897H3PtW8XL9NJafY6ABEE9xk1C+GU5pvFxeCh
    Bw55DhvIYFJNW9WpsdfsqwSIvjrOlXeOuiVihVdl4/VnLrL6HiZNzyhlmF0F0JqoEfDQBs
    ZeWPW78tlwVNR8s2q4FJ3S+B6+bdOp263bbmE0K9h9c/tydibLtCmNHeA07qD79DoWTCTF
    Bt47uLAUExXc3tnx4LScdVXbJsJx5a6XumI2b8aobYaO7BSHBrJgVwJVrD4xyHiRysE1Mn
    Cz/2bhHrZizCRU8XTGArP2/ua93S9aMviU0Roq47NsyEDhbRERjUt0xyYi0+/dWjgOI53F
    RcAcnW6CpSSL82SFFoYzWdiq1UVwKcJXBfmfrvw5IpfHV+PdLX310e0NypBt8LX6Ioo+e1
    DTuMaiFvsmAKZdn74mvNGoJ9InzHEegWH6Yi2ZjIBE5/Zne6Jj3WGolnJ+xQt9OELmnvGf
    +NdEI41yWRXXgMh1U+Mz4cOMQTFfcVqJIj4QaEaEk+mcg7KhsE3EVlnSLctg
X-ME-Proxy: <xmx:Keu0ar7irZco0-c5JHDihyS_bFgPVrxOOaE01r35urKV3sXdmAzC9g>
    <xmx:Keu0alI0DTs92-xSD5qFE8Zuy_GUXF4Xvb6edo_gnCF0QIdP1GCPPg>
    <xmx:Keu0atff4xqd__2uEJPnFyF4ZClw8M7Yzxa9tReoHNLvu-b1dKfx5A>
    <xmx:Keu0ageCVAnSN8W8E1_4oVQOjB_roS5KFj-jTVAPqymBwEG_XgXbyQ>
    <xmx:Keu0arBd-D7l2scN-UKKpQVTJZkhtrqEgdnyn1WQ5zsMH06StwNVRpil>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7756239d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 24 Sep 2026 09:19:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] setup: enforce repo passed to `create_repository()`
 has no state
Date: Thu, 24 Sep 2026 11:19:18 +0200
Message-Id: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQrCQAyE4VcpORvYVlisryIe1jjVqHRLshWl9
 N1d9fjN4Z+FHKZw2jcLGZ7qmseKdtOQXNN4Aeu5mrrQxdC3kae7sxhSARum7FqyvdlLHR5w5yF
 ICluRFHc91cpkGPT1ezgc//b5dIOUb5bW9QMzPRJBgwAAAA==
X-Change-ID: 20260916-pks-create-repository-stateless-f0ca03cca689
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

when creating a new repository via `create_repository()` we pass in a
repository. This repository is acting as an in/out parameter: the caller
expects that it will be fully configured after the call, but the
function itself also uses some information from the passed-in repository
to figure out how exactly we want to create it.

This interface is quite confusing, as it's not obvious at all what
configuration of the repository is relevant. We have thus over a couple
of patch series reduced the use of the parameter as in/out parameter. So
now, the only piece of info that is still being propagated via the repo
is "core.sharedRepository".

This patch series cleans up that last remaining part so that the repo
becomes purely an out-parameter. To ensure that this is the case we also
start to `repo_clear()` it as a first step.

Besides simplifying the interface, the intent is also to go further into
the direction of unifying repository initialization in a follow-up patch
series.

The series is built on top of 0f8e75abeb (Revert "Merge branch
'en/no-amend-during-conflicts'", 2026-09-23) with
ps/odb-alternates-at-creation at d1019ac894 (odb/source: remove the
ability to write alternates, 2026-09-10) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (7):
      path: drop useless `safe_create_leading_directories_1()`
      path: introduce `safe_create_leading_directories_no_share_const()`
      builtin/init: refactor messy creation of leading directories
      builtin/init: move handling of "core.sharedRepository" into "setup.c"
      builtin/clone: don't apply "core.sharedRepository" to leading dirs
      repository: adapt `repo_clear()` to fully reset the repository
      setup: enforce that passed-in repo does not carry relevant state

 builtin/clone.c        |  4 ++--
 builtin/init-db.c      | 15 ++-------------
 path.c                 | 13 ++++++-------
 path.h                 |  1 +
 repository.c           | 37 ++++++++++++++++++-------------------
 repository.h           |  2 +-
 setup.c                |  6 ++++++
 t/t1301-shared-repo.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 78 insertions(+), 42 deletions(-)


---
base-commit: 6b6fe25b12e5324f2fdaf8c73816b9d2207e9404
change-id: 20260916-pks-create-repository-stateless-f0ca03cca689

