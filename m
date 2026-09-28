Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4711472540
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589112; cv=none; b=UIW1JGd7apkMsJz6WL3aetwAbn2QlL0K0oD8Dpgo03lFlbivONGSqjB5w8nQZcpNp/ysNR9IGLKgGovgRGM1w1GsAfAV+4S3R04XbF8O7isPK8KSmCm2Q6NQdmiVSyQQEFDp/Sq7OgpclcZSWmvt7A3NWTDeuCy6uZ1X+8oLEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589112; c=relaxed/simple;
	bh=b2BrhUBGAKzvYNIp1KXF4zeA1QYgDXLsUhW0nEAcV3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=UDo3xU+KGUnE9M6pgu6ugboZrhKsXC346I9FQDH+Cirk2oiXvAfeNIZHSZSdb182jJNFHDs7NOPsT685n9+Oc4VTqarJe/xi1aTs+A0mqC/P3Miy6eVu9vuBSNpyjCwpfA7EvMGx8dYRyPtFf5hk2wW/zN4K4/H0KHAWomzgofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oo1W/ZVf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uo8tMZoH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oo1W/ZVf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uo8tMZoH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87A7B140002F;
	Mon, 28 Sep 2026 05:51:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 05:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790589109;
	 x=1790675509; bh=Ic4zdvMx+9N91a6eZpbigIoZWQf9p/q58HfjvQjEC5k=; b=
	Oo1W/ZVfI73/2KKYBxcxxvhG989LPBFP9cTmL/xxw913mnEl/P4Ry6sVd8uzcxmz
	5P5gDpPT+Rpb+Js2t6jJQ2yUqMRjs+oIIuQzalHBtsCcL9WRhumRwHq78gG2C+TR
	RE0SLMerUxKZGIA1uhNDmmDwCaO4zsRjfN32pVF8rSE8zsS4IPFPaNbT52DKV7bc
	6gnwzWef3DRneipSeXpChpJKlzYcIW0ISuoEvVocg5z+4gWcW/nCfF9Knz23zDGS
	c3os8VMUn1JC+vafEzn7/mpYPlZZhPcNDaAbTxXOUDWIIQrxeh0SFb7CVrdXMRc1
	6IqGmJXKvD7BnOpVWPJ+cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790589109; x=
	1790675509; bh=Ic4zdvMx+9N91a6eZpbigIoZWQf9p/q58HfjvQjEC5k=; b=u
	o8tMZoHLQgLj0MlwpNfMkGIj18GLzoXsP62w3rwLE2/QTeAqqa2o85WS4bpf9wJl
	9PxainptTkCvl69RDp38S5EO/YNgDW07SeNXJO+meH+8yi8l+NKIzaiDJGZCJIpk
	EMaasqSbTE0e9fokTTuPP4jqUI//WyhbePh2Vai63zSyIDZlYOZIipjTk/9Di6Rh
	QT7i+d3cLVjbbZGwOjA2W8fxWwfiqIhvcRRN0mMknkUSlVG23mJPRca6288QKUPU
	1exw4DXtV6M2/vpiHkMCWsYK9slmfKnz5uECdeN4fm3u3uoaczesHo25x2pAnHNb
	ShSBqKmEUt4f1zCV+XuHw==
X-ME-Sender: <xms:tTi6aiKEHpnlRsicJ-pOdw3804T8v09A0m2Hg4HWDwe6ZWZtHExVOw>
    <xme:tTi6ahnG3pkMd9co2nUjystxBIT7dW3l9mgBLqhHEqF-0wuyqIyIOlaTHopa7mIyk
    0HOjltaXM4MwcNmcZWxWdlyWXnKq7hgGnxMXIVsDl_2jVxF8_azQtM>
X-ME-Received: <xmr:tTi6agHXXitJ0rJd1dEV74G9kd5jAByx25qAtCnMv8v3IkwKDxFmGw>
X-ME-Proxy-Cause: dmFkZTF/gmpwG0yL35l/AjgTR8F2OvA59A4pdBJ5zaqZ00Kfe87OlFg51lM8dPL6Nkhdcb
    IL/N/X92IUvGBkJojcXkOa1dLeX+yd7GXEnhCAUrTK87/Jf4MPZrBNNb8/k4I5OzeAfb5h
    2iJHSEHn7aVJnNGw0nX3vcgygwDlU2cpk1Ub/BCJcPcOa0iqCfQWnCoLhp5k1lBglhEKXm
    i3NEVLX61Y9EJiACySTQVp70CJlClP5r29cLBibY/xW0iruPGxNDvJWEVa3iCVQy8vbVwZ
    83x3UXMqd8K5rEs5rvqyHsgS35gmg8xFuEGF/pRB/odbbkYoSM4SNjWKjpJucmmOovkeh2
    QoO9SbsBx+WW6Q2K5mjYGY9dVaYxcnva8RORCP0uNI1EhwpVuHWuvuxDIIg/nDXrW1TVjR
    eM2a5GzIyCkewzPZwdmt94wrfGXEAnKur1l/Bo48yGCiVwgnUhGkQjaTyHOWeuYsMc7G+K
    nmtu5HCwPrDFwG2vRBgwj51OhtF0YeLj5V82GA4l2JtaHbVRucftFKnijPUekvXh4GOmRo
    8vzcgKGBsTuQKSyHnutrR0/uwo6gLYAfuPSwyWjBc0S8p8w4aSn9ENa0v86y7RD/YEvYvS
    GxiL7OmZfRyoR/RJTTTM+KcnD4heTZgKpfYLDS6mB8QI84T5s9dajUxElpuA
X-ME-Proxy: <xmx:tTi6ahH1QqglD35cJurubXha5VXKE7cGFliDsvTntgCVAswXYIOuig>
    <xmx:tTi6atMZveDVnpEEGw8Wzw2ijTMVxaLg5oVq61As5XZIKjuqZSOJ6w>
    <xmx:tTi6agESzWhcZBdSuUVLtLhFZjk2FRKkkI_wqso6n6Qshx1J-6vnHg>
    <xmx:tTi6akOaPMIh1h-N8YhEer1mbzxfiTj1Y1wZwXvt6xtl-npWwENQEg>
    <xmx:tTi6avCXOzAhwX_9ICMM4VPIXGLGcgPJztnbgWLwpYd8OWzxal6R_3Qd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:51:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 07c09f0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 09:51:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/7] setup: enforce repo passed to `create_repository()`
 has no state
Date: Mon, 28 Sep 2026 11:51:01 +0200
Message-Id: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOSw7CMAxEr1JljVGSfiCsuAfqIgSXGuhHcahAV
 e9OUtizfNbMG8+C0ROyOGSz8DgR09BH0JtMuNb2VwS6RBZa6koaVcF4Z3AebUDwOA5MYfBv4BA
 PD2SGRjorc+dstTciWkaPDb3WhVP9ZX6eb+hC0qZES5wc6wuTSrnfmi7+rk0KJChVGFOWO9fk6
 hgbW+pEvSzLBz4FzIXdAAAA
X-Change-ID: 20260916-pks-create-repository-stateless-f0ca03cca689
In-Reply-To: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
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

Changes in v2:
  - Adapt documentation of `safe_create_leading_directories()`.
  - Better explain change to fully clear repos.
  - Link to v1: https://patch.msgid.link/20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im

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
 path.h                 | 14 ++++++--------
 repository.c           | 37 ++++++++++++++++++-------------------
 repository.h           |  2 +-
 setup.c                |  6 ++++++
 t/t1301-shared-repo.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 83 insertions(+), 50 deletions(-)

Range-diff versus v1:

1:  6ec41760de = 1:  0f9513d5c6 path: drop useless `safe_create_leading_directories_1()`
2:  85ac056b80 ! 2:  3294cdb6b6 path: introduce `safe_create_leading_directories_no_share_const()`
    @@ path.c: enum scld_error safe_create_leading_directories_no_share(char *path)
      {
     
      ## path.h ##
    +@@ path.h: int safe_create_dir_in_gitdir(struct repository *repo, const char *path);
    +  * race, callers might want to try invoking the function again when it
    +  * returns SCLD_VANISHED.
    +  *
    +- * safe_create_leading_directories() temporarily changes path while it
    +- * is working but restores it before returning.
    +- * safe_create_leading_directories_const() doesn't modify path, even
    +- * temporarily. Both these variants adjust the permissions of the
    +- * created directories to honor core.sharedRepository, so they are best
    +- * suited for files inside the git dir. For working tree files, use
    +- * safe_create_leading_directories_no_share() instead, as it ignores
    +- * the core.sharedRepository setting.
    ++ * The default variants honor "core.sharedRepository" and temporarily modify
    ++ * `path`. Note that this configuration should be honored for all files in the
    ++ * git directory. The `no_share()` variants ignore "core.sharedRepository",
    ++ * and should be used for working tree files. The `const()` variants do not
    ++ * modify `path`.
    +  */
    + enum scld_error {
    + 	SCLD_OK = 0,
     @@ path.h: enum scld_error safe_create_leading_directories(struct repository *repo, char *p
      enum scld_error safe_create_leading_directories_const(struct repository *repo,
      						      const char *path);
3:  3a7c197f1b = 3:  8dd89f144a builtin/init: refactor messy creation of leading directories
4:  c3ced666bd = 4:  f37db1b17d builtin/init: move handling of "core.sharedRepository" into "setup.c"
5:  25918a4ff6 = 5:  db76d32f2c builtin/clone: don't apply "core.sharedRepository" to leading dirs
6:  a742852675 ! 6:  19388a188c repository: adapt `repo_clear()` to fully reset the repository
    @@ Commit message
         some state because we don't make sure to clear the whole structure.
     
         Refactor the function to set the whole repository to all-zeroes to avoid
    -    any kind of leaking state. While at it, make it a bit more robust when
    -    called on an already-blank repository.
    +    any kind of leaking state. Replace calls of `FREE_AND_NULL()` to instead
    +    use free(3p) to avoid zeroing out the data twice.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
7:  760058e9c5 = 7:  0d4819f005 setup: enforce that passed-in repo does not carry relevant state

---
base-commit: 6b6fe25b12e5324f2fdaf8c73816b9d2207e9404
change-id: 20260916-pks-create-repository-stateless-f0ca03cca689

