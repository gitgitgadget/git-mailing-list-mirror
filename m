Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5C3FFACC
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820154; cv=none; b=M/Ubg5lVsSixsSvNqtWavdhhwXE9BmF//gv8RfRPPxd+shXAGDvB/IPhNz6qzYv6Er5oJUZ5rWiMFWxvOF4CNEeiZlL6TGdwJ1g+Us0k1M8oUuv3q7i6EQMgF4lfwLw4qTTN+7eBKZ+E8SfZNZb0tKR0c0i/LBui2S/pE1fXn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820154; c=relaxed/simple;
	bh=nlpPsb1crT+fbMQDT5uXd+83JoE48jp0D8FAZhiQr0g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=JRYnLSTkU/EYBQVHOUuXIAqu0y7ZON1jCyfZRZLScHu6i3l7kJPycKbE8MOaWiAIeHATe/TPsG5I57WpR78VmrrxDK6L4ua3vT4o0zZFk/206VQRDipZK5/ibCal7ArSKdqPzV+AcRCrv7qvL2eg+5Zi7jPyxcfGqY6HL3SUa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OxS2VvRf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C3yGaN+v; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OxS2VvRf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C3yGaN+v"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B9F231D0012C;
	Tue, 30 Jun 2026 07:49:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 30 Jun 2026 07:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820152;
	 x=1782906552; bh=kABpGnIIvBHaML7OC2kSsNJrMy1VV/GWSoc+Akr10q8=; b=
	OxS2VvRf+Vk3si87Ro+G+iNXVvXHhh2salegBdMNPSSQfBhf3sKs5AN1dpLzj6tB
	FqWiNcZVqtE1z+AT5Iuw3SMxBrdtDOrSi4gG3ErPoKzUIhdE8TqJgV651BDcipX5
	+OsnvQUWLkzO2xjwIWmvvC82XaqjDOyx3At8Y0jesUZkixXNrV27BrtyjSAiYIcV
	i+ucw3z3AfJLa7jnivp1DMUe4M91uX37MAmKXXrb90sIZ1QuIeResi4WVUTRdMcR
	Z7f4/zyZmDJM06cgS1RNjahECN6tO95fhIPwRoHF54UmKEIOy57RpaP7lenY/jI1
	+CgcGoBCApIaXnEbcr3QTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820152; x=
	1782906552; bh=kABpGnIIvBHaML7OC2kSsNJrMy1VV/GWSoc+Akr10q8=; b=C
	3yGaN+vMYAX3WYvxeDCRiRHtdW3YE1ZRpr83brHCkwzHowQI6NwW6bFRHTDxJHqY
	s/KTDvuM8KFwBHxkR9tTKwJvNzbcUkcJMwYGRNkWWT++cQqAQ7a75xXSm/BrM1BW
	pJ9fhREKRb5n2TdwU6AHUBcVY3J3Oec/bzkbqBH1Ub2svzKq2RnVbkqDPw1qBm4t
	049KgESrgSO4pl9tzKo1wTQD5d5ej1szvqOZdkppWoYSSifq3dvwAxGEiU0CiXJe
	Og3+08dm086Q7uDn1VM/uXwLWhe2adrVd0cEaTKN7w2bIzIRdH0Abuc/VbLN/KoY
	9Tz9fe2id8Q4tXg/pOOEQ==
X-ME-Sender: <xms:OK1DatM6_dIpBLSmHz_yVZHJ0pOyJG1QmUpdxhR9Vgh-3owi9FsxMw>
    <xme:OK1Dal89w2UWA6G52Z_wz3sSEwynygBu60OLf5iThuRtRRRmEp1jEQpon7LckyQne
    NxzGLmTsU72Ar49_yMZp2q2TXZJLs4QfYnkTs1RkYjhA1ZzZZXsHA>
X-ME-Received: <xmr:OK1Dap5xIeeOfpjyIfaMZxLux1y-933oSjhQRc01mkIZXNwYvTJwv-5mcNJU749PICbx6DbbxChgYHmO8lIbRmcOmXI6mpmRng3b4J_HgpAAKg>
X-ME-Proxy-Cause: dmFkZTE8Z6WLsAtSHRt3RRVy0rKcc9Ilf5EMksQ7TSnIjM/Y4ODTTk+j71rWj79ggO594c
    xvtOkli+L/zSOoiHgdz1sOGsv6iPv8PhkD7egy2xk+MWaGU5LrWJqsWf+lUNBjhTS9s12q
    YA8tkgXmlNGIC/5vEa9J1mXqbwT9OsmoDASuHesPCvHlHEcXG5fGiy8ZHOwEje0yWAJ7Uh
    4dWz/n6HGGx14fVsqrtEsewZqWCYF25bJJ/WXq5kAI1+3V0QajDyn+2zSBBKiPlwKYutvZ
    VYdYGcdCXRzvfrG2sGj3b5lxNwhQerCE8OZkbzFe0h8JTlhsPNOGI/VsP7LzDPtYhv+ChE
    KT+D0y5st6cAch1TTlieqvKSAQ1xShFjjrk02fap+d+yT1IjeE/p3QFvGvZDKmEESnqm20
    x/V0mI86Qv7EEFSR29wqfm0bw2sDC9wJeB/qw0c/YFZtAHl6eNhZP558gQfsdH+Uhg2blZ
    YYcwTkYh8H/WsYsf9h8O4xJTNeKpUsq9hf4fXPq3TFTGS0RHkK5tjfxSfEwhQHoyhsUr/S
    /3RgpjLpEu99RptYRK+qhV2sb7ICfTOxYuv/PElEV0zP94HCWUwMoICqJxjwfV1d1LrUOL
    PugYmvK5Fkag6WH4yw0ikkV/sC6GOdeJ6pnvnWkk3X/8I8Yx9EeCLSLtkH4w
X-ME-Proxy: <xmx:OK1Dak2d014-R6EzlbykW1i4gwgm5mXUvFtCwEbJ0EvLl90YH8pFUA>
    <xmx:OK1DaoClLzJsecsbr-1u7SroRPCKOdwZN321IsoP3xgJMlP4E3oN5A>
    <xmx:OK1Dau1iklxJPoNPohnzaQy_zoORkNAkf3k7jp6NGjRUEgFTknkMvQ>
    <xmx:OK1Daqu_RYMHWIfUx0lqp_Rd3YLwVoaOc8zd244qeNPT2Ik-9jpISg>
    <xmx:OK1Daoku37PfV-ogA6mjKRbEBSKwRRu2HXlOayiQ402rBT7eXDE-EzVN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 07:49:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e572342 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 11:49:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/5] builtin/refs: add ability to write references
Date: Tue, 30 Jun 2026 13:49:03 +0200
Message-Id: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADCtQ2oC/43NTQ7CIBhF0a0YxmL4SUEcuQ/jAAq0n6a0gVo1T
 fcu1MQ40+FLbs6bUXIRXEKHzYyimyBBH/Lg2w2qWx0ah8HmjRhhgggq8HBNODqf8D3CCKHB6Wb
 qvut0sAlLLaVxlbFaGZSJIZfwWPnT+b1zfnH1WMxStJDGPj7X/4mW7s+riWKCla8YVUZQouwx5
 zvoUPmZ2Lckf0gsS0R6bumec+HVR1qW5QWnE5MNIQEAAA==
X-Change-ID: 20260616-pks-refs-writing-subcommands-7a77be5bda9b
In-Reply-To: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

Reference-related functionality in Git is currently spread across many
different commands: git-update-ref(1), git-for-each-ref(1),
git-show-ref(1), git-pack-refs(1) and git-symbolic-ref(1). This makes it
hard for users to discover what functionality we have available to work
with references.

We have thus started to consolidate this functionality into git-refs(1),
which is a toolbox of everything related to references. Until now, the
command doesn't handle functionality of git-update-ref(1).

This patch series backfills most of the functionality by introducing
three new commands:

  - `git refs delete` to delete references. This is the equivalent of
    `git update-ref -d`.

  - `git refs update` to update references. This is the equivalent of
    `git update-ref <refname> <oldvalue> <newvalue>`.

  - `git refs rename` to rename a reference, including its reflog. This
    does not have an equivalent in git-update-ref(1), but is inspired by
    and supersedes [1].

Changes in v3:
  - Fix confused error message.
  - Link to v2: https://patch.msgid.link/20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im

Changes in v2:
  - Add a new "create" subcommand.
  - Consistently quote in error messages.
  - Consistently use `<old-value>` in the synopsis.
  - Don't return negative exit codes.
  - Improve documentation of "update" subcommand to mention that you can
    create and delete branches.
  - Add tests to verify that we can use "update" to do this, both in
    racy and raceless ways.
  - Add missing calls to `repo_config()`.
  - Drop useless `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME` variable.
  - Link to v1: https://patch.msgid.link/20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im

Thanks!

Patrick

[1]: <xmqqv7brz9ba.fsf@gitster.g>

---
Patrick Steinhardt (5):
      builtin/refs: drop `the_repository`
      builtin/refs: add "delete" subcommand
      builtin/refs: add "update" subcommand
      builtin/refs: add "create" subcommand
      builtin/refs: add "rename" subcommand

 Documentation/git-refs.adoc |  40 +++++++
 builtin/refs.c              | 222 ++++++++++++++++++++++++++++++++++--
 t/meson.build               |   4 +
 t/t1464-refs-delete.sh      | 130 +++++++++++++++++++++
 t/t1465-refs-update.sh      | 268 ++++++++++++++++++++++++++++++++++++++++++++
 t/t1466-refs-create.sh      | 151 +++++++++++++++++++++++++
 t/t1467-refs-rename.sh      | 131 ++++++++++++++++++++++
 7 files changed, 938 insertions(+), 8 deletions(-)

Range-diff versus v2:

1:  2341316537 = 1:  9dd7b70df4 builtin/refs: drop `the_repository`
2:  40efa6887b = 2:  72341f895e builtin/refs: add "delete" subcommand
3:  2f86fb281d = 3:  bcca5fe8ee builtin/refs: add "update" subcommand
4:  fb75fb72cf ! 4:  6fa75a36bd builtin/refs: add "create" subcommand
    @@ builtin/refs.c: static int cmd_refs_optimize(int argc, const char **argv, const
     +	if (repo_get_oid_with_flags(repo, argv[1], &newoid, GET_OID_SKIP_AMBIGUITY_CHECK))
     +		die(_("invalid object ID: '%s'"), argv[1]);
     +	if (is_null_oid(&newoid))
    -+		die(_("cannot create reference with null old object ID"));
    ++		die(_("cannot create reference with null new object ID"));
     +
     +	ret = refs_update_ref(get_main_ref_store(repo), message, refname,
     +			      &newoid, null_oid(repo->hash_algo), flags,
    @@ t/t1466-refs-create.sh (new)
     +	(
     +		cd repo &&
     +		test_must_fail git refs create refs/heads/foo $ZERO_OID 2>err &&
    -+		test_grep "null old object ID" err &&
    ++		test_grep "null new object ID" err &&
     +		test_must_fail git refs exists refs/heads/foo
     +	)
     +'
5:  134b161ec7 = 5:  8e12fe028e builtin/refs: add "rename" subcommand

---
base-commit: 700432b2ba22603a0bcb71475c9c333d17c9b0d1
change-id: 20260616-pks-refs-writing-subcommands-7a77be5bda9b

