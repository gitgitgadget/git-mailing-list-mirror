Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7231E2F7F0B
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559202; cv=none; b=Hd8yU9abWKhiLxDnRI76yze3e086c/RjEf/bQR8EfKogYSnZElipdQdr78bBeMfO0ffwDA7bsUuQ7h3K3XVcnfUN6bASkHEDIFGVXIftm+1LXERNL69F8hJ76k4hoSr3NN8vekMZxBG4Ll2e5c0IJOSuj2cs6lxzFabT447JReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559202; c=relaxed/simple;
	bh=oGsCa8QyHjcX3T2Ea9Is7e8FzlW5Z+N42bZlK0dyyZo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=kWhKkUz+xhecUWRKRW7PPG0Zhik20xdCF7uYJw9ffcVVEcXosOLIprp5pGV66UvQJ87aiAlQFP3KE+T2uXQH3dbCFhs/9dfLuWoShOw0ZH8GMsDr0d6hBqBhAYeJ9izYcdqlJ9hn+Rbb25lAJnfIiq5EUFm6iUqnzXjCCddGdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kD+n72lR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNuJoKPN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kD+n72lR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNuJoKPN"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B6254140001F;
	Thu,  4 Jun 2026 03:46:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 04 Jun 2026 03:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780559200;
	 x=1780645600; bh=RxSHY3eYSgMmDKCKFLSNVgC1ibROAlEAcpLknb4DiYo=; b=
	kD+n72lRlgfDBL5zSv9YEHbzUejvEH1P65AGBThncdjgVaRferfas7uAkTCRUuoD
	74aC8DhDZyLqJKLY/mACDDXHp0ozANuhPzCk4nFCKRx5dsXvir3L2sfKQPAtDRRW
	twIagrqUXvRjFvY+9OEzevx9ggAHR8RT1XjX5jb07X2wmeEsdz4p40hmE6M5OFsz
	I0D9TbtuhnrT04z2H6qkS2m4xMqZXBhBpG8AFHb6/JJoM3fAClbGBE8K9+H+FQh8
	kc0YsDaY0CGpPwYHsyb7oQ0wEtBnWNCjQ3BoUsCOCc5BdtSq4RpwXp8DC/oEVrFc
	k1XUhp0jL2JPAUuyDjgX+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780559200; x=
	1780645600; bh=RxSHY3eYSgMmDKCKFLSNVgC1ibROAlEAcpLknb4DiYo=; b=j
	NuJoKPN+UBY+o4O1rb7s8oR2GS0MrItzW6Z7ItcOz2ozlyKNlhLZ6M8FQTcmLsUu
	JrkHeY2ko2EHuQr9W7afdEPLxJWNjrD0ISDoVuP9LWcS4tYzrzbiWjWIINvCstQG
	Zg4a2a0aYJOmj6l78iq66rPhKfNz/5MpcFj5v6zxfgxe6tB45mYoiRRod1gKIxp1
	ursfYX4Hk3Hrfe8Tu/W8F6JcuG/rztbhNnJbYZtYzXYAjDwjU6AdpZ16A964Z/F1
	6SehHy5MLsBRCQn4gNL3UKS/mm2lLAq+CfQsfYq4seiPrOGPSwbQsuc40NsmdwP8
	buT3qHAdG6qt8T7ijjs1A==
X-ME-Sender: <xms:YC0hahcdFyN71Ff6go5LJ8btaXpQ3ATvlxA_DbT5MHSJL6UytAkJsg>
    <xme:YC0hamPNXNtCKKImqVOqhH5Y8tEufPjIAaQIiHAWZ0c95m1oIchfgmTBsswHZezDO
    P5lSaZHoHGx3hVICBdsv0K0t7Q0YdnKRs3ts5_T_GcmzY3N60R4>
X-ME-Received: <xmr:YC0havhyOGaPz3V0UGF9zi42mqWKdzGxvBzoGboqwY29rREfaHeBkREQXsG5Saq9MDOK4Ct9k-KWMzAp0zT1VUpANGU_r5tu-I0FhKor69I>
X-ME-Proxy-Cause: dmFkZTE4xt9vb4re4a+xkAGnznvguWPjLUmUXRiS47Alw/1mxxu/fpQqh9Jx3GqXVqn41v
    m13V/tLObNEmsDx1cs3qRhCJL+xzHC4tfcC+tcMBSZNY4sQHJ8A62aSfoZnwjlYxiGI7hs
    WNThXsFv1G4mGTGMJXLeNdoe9uSX3ZXJSkpPPyasuR0ujfHtcsyM7IRjnXwWR4NrJkZVfk
    U+T7+WHkYb/RkdX/fqC3A7hO9wJEIjg2R3MunAoWbg24NVJpOu07Z/s4uazA3gDRQdFvKL
    GtRjWNLfbeSq+0eGNIbEtjYCFRt9+ABEs5jZwYzqDschRUIYxHC98XjTQanHscV7tduKRW
    jy9cgG8b8xEJo/cvh+ucAdQSpnMZyC/laLijfanY/J6m693RT7AKdA0aNWoY+gDphLa+G0
    J1dMG5Zbx+6BasURG2jSa2n3oRsiwg+JUQp8Akp+7zjGeDoo8MriwOIFVHkPLxJ7xD1MDM
    irFWnIuE4lkuWzlEpSIp8KlmQ3pmTXfd5kZJiJqpsZ+sFNk2WdxxcUg1OJQiBNMavqru3n
    4mxPZ7jdDl9d5WqWK+6d6AwYkpnGfZ81dcOYTviqx9NOL/WgD8kk3SbIx62tRb4pFGsHd9
    XFuT3fgfdegalkgjn+jyDmPeKeIUqvV472ugu+iCRw0zWtGzKKlU5LCd7RcQ
X-ME-Proxy: <xmx:YC0hap3REyPBVCT-Gk5r_UkaZSSFw_J3uMJtMvlhC_MdU5tQ4r9wUQ>
    <xmx:YC0hapiDwM39IW09a3jAVWqSBizciNtAmAH75zD8GdRqFzRnMr9jRg>
    <xmx:YC0hapfl6P_t6uhX90BZsiLt0KDBwQ39Jo6o42RMURQz6PyWblfMfQ>
    <xmx:YC0hasl-jlU-0u8mtvpZQkgwFKlbhzbrcBg8iwcOoD1T_JOmaANjNg>
    <xmx:YC0hajD_01K_dgC1A5BvUpMVzlpDetRvMnQhqEfDpePuILubUPjKQBa7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 03:46:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a166c34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 07:46:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/8] setup: centralize object database creation
Date: Thu, 04 Jun 2026 09:46:24 +0200
Message-Id: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFAtIWoC/42Oyw6CMBBFf8V07Zg+eLryP4yLtgxSH0Da0qiEf
 7egiS5ZnuTOOTMSh9agI/vNSCwG40zXRhDbDdGNbM8IpopMOOUZTVkJKoH+6sChH3rQ2Horb+a
 F0FUKtEXpowBEkpc6FbVirCJR1VuszWPJHE8fdoO6oPaze140xvnOPpc/Apt33yRn65KBAYWaC
 VpxmWMh8RBvduZO5l7g/8ZspZFHI69lqkSRaiZ+xmma3mx0nU45AQAA
X-Change-ID: 20260519-b4-pks-setup-centralize-odb-creation-3479c53fb11d
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this small patch series refactors the logic for how we discover and
configure repositories. Most importantly, this involves the following
two steps:

  1. We unify the logic to apply the repository format, which is
     currently open-coded across multiple sites. These sites have
     already diverged, where some repository extensions are not
     consistently applied.

  2. We then centralize creation of the object database to happen at the
     same time we apply the repository format.

The end result is that we apply the repository format exactly once, and
that's also the point in time where we can finalize the setup of the
repo's data structures as we know about all details of the repo at that
time. Ultimately, this makes it trivial to introduce the "objectStorage"
extension, even though that's not part of this patch series.

The series is built on top of aec3f58750 (Sync with 'maint', 2026-05-21)
with ps/setup-wo-the-repository at df69f40c34 (setup: stop using
`the_repository` in `init_db()`, 2026-05-19) merged into it.

Changes in v3:
  - Explain the move of `verify_repository_format()` better.
  - Document that `apply_repository_format()` also verifies the format.
  - Link to v2: https://patch.msgid.link/20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im

Changes in v2:
  - Commit message improvements.
  - Link to v1: https://patch.msgid.link/20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      t0001: plug test gaps for git-init(1) with GIT_OBJECT_DIRECTORY
      setup: drop `setup_git_env()`
      setup: deduplicate logic to apply repository format
      repository: stop initializing the object database in `repo_set_gitdir()`
      setup: stop creating the object database in `setup_git_env()`
      setup: stop initializing object database without repository
      repository: stop reading loose object map twice on repo init
      setup: construct object database in `apply_repository_format()`

 commit-graph.c  |   4 +-
 environment.h   |   8 +---
 refs.c          |   3 +-
 repository.c    |  40 +++++------------
 repository.h    |   3 --
 setup.c         | 130 +++++++++++++++++++++++++++++++-------------------------
 setup.h         |  20 +++++++++
 t/t0001-init.sh |  10 +++++
 8 files changed, 118 insertions(+), 100 deletions(-)

Range-diff versus v2:

1:  50224c1a12 = 1:  a6f452b947 t0001: plug test gaps for git-init(1) with GIT_OBJECT_DIRECTORY
2:  6d655e00e3 = 2:  905e618dc6 setup: drop `setup_git_env()`
3:  2e7e9bb052 ! 3:  e11f16333d setup: deduplicate logic to apply repository format
    @@ Commit message
     
         Introduce a new function `apply_repository_format()` that takes a repo
         and applies a given format to it and adapt all callsites to use it.
    -    While at it, rename `check_repository_format()` to clarify that it
    -    doesn't only _check_ the format, but that it also applies it.
    +    This function is also the new caller of `verify_repository_format()` so
    +    that we can ensure that we never apply an invalid repository format.
    +    The verification we have in `read_and_verify_repository_format()` is
    +    thus redundant now and dropped.
    +
    +    Rename `read_and_verify_repository_format()` accordingly. While at it,
    +    also rename `check_repository_format()` to clarify that it doesn't only
    +    _check_ the format, but that it also applies it.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ setup.h: void clear_repository_format(struct repository_format *format);
     +/*
     + * Apply the given repository format to the repo. This initializes extensions
     + * and basic data structures required for normal operation. Returns 0 on
    -+ * success, a negative error code otherwise.
    ++ * success, a negative error code when the format is not valid as determined by
    ++ * `verify_repository_format()`.
     + */
     +int apply_repository_format(struct repository *repo,
     +			    const struct repository_format *format,
4:  81b92bca7f = 4:  b0d7c11fe6 repository: stop initializing the object database in `repo_set_gitdir()`
5:  807fc56353 = 5:  d0af56fdae setup: stop creating the object database in `setup_git_env()`
6:  96563ff99f = 6:  3e75c5b0a6 setup: stop initializing object database without repository
7:  c14f45169c = 7:  50fa2fdb3c repository: stop reading loose object map twice on repo init
8:  e67c6e66d6 = 8:  4dff9d1794 setup: construct object database in `apply_repository_format()`

---
base-commit: 3398daa441965513c48744305d33bd36404547d6
change-id: 20260519-b4-pks-setup-centralize-odb-creation-3479c53fb11d

