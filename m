Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD813D1CA5
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958975; cv=none; b=OGIEv0+rTvpfhT3HeWL6t9GWRDUfvkvVSYzXOdSbVTqo1/aSw51RXQ5QHb+Jt5Cfb+O0q4RoDLGNmsw+iH3Mz1dZiy30qjgrvwYWaoXFE6BdPtnzOMTL8Kqiw8XMTz+eQMT18efMe92S8tSQBDWBbfp2S/myIWmhapFaK646MY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958975; c=relaxed/simple;
	bh=CaBftkwo0SzCWIM0r4FhUzkTnQpnOg6wpq2zpAxn1Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NW696lV3QG/6eNocIM4oG4GvOP6Vewi9zsTA89m/cZOYMaMgUQD2VKQ+GtnZdUzxs7EFOYpCqXckNuDisRKR1RCdd1ZVJBfr8W5YGOlViXUG0AkL+cOAvZtjBMEI99LPj8HoHxKTFZuRbaiC8woHtyv7nw247poudbHs1AnoMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qnXwQtM3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kop3H8ua; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qnXwQtM3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kop3H8ua"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03E047A0090;
	Wed,  5 Aug 2026 15:42:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 05 Aug 2026 15:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785958972; x=
	1786045372; bh=MD9bJr7uSseLJaoNC6v4eoih71Mmd/Jn8e1R5VxjggQ=; b=q
	nXwQtM3F2pgkA9G+Hks5hqP0mRHzpRgo8MYAcRyoqvxE7qt2ckLanXoETEpO0IR9
	YnZjMJqvcDsLZTFNk406zDkgBsnBCINOBGa1Hh81vJgFSsOF4QxZK+/efxszT3hM
	OvF02oRNltytwQylHYt7cABCU/PhsJ+vt2ih6COyKpF3LMJ4w5v7koEw/cF4g0xO
	bCVmbVn2MG2/DAvwpsjROTbkx6DxuCtxWvYSUN1oOHnkn71CVDswRR/cg/eqz6nM
	/G3f/v/dG109gUv1M6Lcnlc0vSrLDq+kqkYnp16EV5Gop1Qvu03D0Nov5bpcnAjU
	vGTdNEwELfjeUJg6EC3fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785958972; x=1786045372; bh=M
	D9bJr7uSseLJaoNC6v4eoih71Mmd/Jn8e1R5VxjggQ=; b=kop3H8ualLgY2S7IS
	zfZ/4xOO10+EcwsFSh44Hap6eX9PVPVGoy67D1Qw5arSjJ6xNXxz2S8kdYAvwyn6
	rqcn4DZ6Md3HB8Y+cJKHItrK3YXO54SOPBFufUdEugS7O+MrofKvMVLyu8YfANlb
	OaSydjE+iesZPw+piOptO0qV2w1qal4H9oCls/zMsDx5WKrizus1cnI719WCGo/z
	lI7X5BmcR9omU5yR24zKAW042MTmsRytM6Ky3BHCg95U5VqSgpX0DjVSpfZuJxiO
	oZOCoTJOi3y1+BguUz5U8jLf2cZqcPXtm9CXYp5l75HjK4I6jHsFZMZACaUXN2rs
	/zzLQ==
X-ME-Sender: <xms:PJJzappYZcbziUrebdJzgFRuwpncPO5nOtXPBliMbPWEW8E9-qXsIw>
    <xme:PJJzaqsQIk_bTIdIE5iLmC41HfqS5ZO5MOuQc9Oi-gJQAGH7qHgaV0B4n8LPVpL5O
    UPNcI936Yw8RGQ4CcHWWauAmujuY1UKi5n2Ojyck9qTWsjwlQiHDg>
X-ME-Received: <xmr:PJJzasZ4q4dHmAtBlV8H5hxD8Bq8oCtEdbXy3w1JrUMfCPvWnvJSF3KmdBbrEySuQ7wp236JDELlBQiwQOV3gv3g1V0O6aPjJw>
X-ME-Proxy-Cause: dmFkZTEnTKk4KYDyqnRoRBJmy2/UMGDifkBmrQI2+K4xM8TZ6536BfGReSZnfUjppMlF82
    e4lazL5A04wOv48DeqzJLY8S54PVLBg3cBd4wWQKdvSf+6nP0xj90+r674LdRRxjw3j51R
    A73abH8QeRk4lpQNWE3Su2N6jkl3zpln+TIPTW9Yy9NwE39pLpijInOAQQnzDuuoG9T1Zh
    JWDkXTjOgq1uANBb46PCQ5HYSltdHrCMT2coJTLMKYov4FP1AYbC+Ia9tIha+w0wb2igjO
    YimTywUMAt/aUUbStjxGCQ71L580CrJPk4J/F/sukELklkb9oRhcr3ie1jmSxT3Z3FNFmg
    l3YsT/r7f2R8hGHRYujCAqW1oaZ/QsoGGd38fK71g3sL5pYXEx4UZ8EPKVm+TAMTMBwZRE
    Uqg1eQpi43eqTL60Lff13KezsO1zOB9gBVrDg+rgFAwCyEbu1OJdPKQKtM9S09pVEdvgWA
    Utz3qYJhBhzTfvaWyqrTjaR+u+zd06hm62ai8AQsxOK04oBlV1NTDQd2WPp6dseni01sVn
    cQfWcwE7yGLf7P8TyFY041joidWd2Ln94/mMZmaVMdWVfcRftytSMVzbpFUJNEyjxmahoM
    uzd3YJJgHHAyUyNk5Cbmxqq6z2Z0/f833dyCgt9E87LVh8Iz9ufAgKogDbqA
X-ME-Proxy: <xmx:PJJzahZu9VFy00Z382J1t-N_1oU4iVxIRVfF1uuN3QMZpEFdsubMfg>
    <xmx:PJJzatkx7h7MnihQYzlaAp3gikqHmRhhKJI2U72TTmYSYXL_iqelAg>
    <xmx:PJJzak0t-C6luDtMIvsJdQ1TiyvreLhvQLnyc89fs4Uq-9Dsa8B79Q>
    <xmx:PJJzal3IHQR5ITDIlIqI9ORoi_xW1ml7RdoD0460EjH9Ci7_0A3IaA>
    <xmx:PJJzahrlQynSawnV9tm7LuDBf6rnJkvyyXFUEaAFdnxwqvFsk2evVps2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 15:42:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 0/3] completion of 'git [-C <dir>] diff'
Date: Wed,  5 Aug 2026 12:42:47 -0700
Message-ID: <20260805194250.3316220-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-653-g9745b9777e
In-Reply-To: <xmqqcxw010me.fsf@gitster.g>
References: <xmqqcxw010me.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is another reroll.

The primary motivation for this topic is that the command-line
completion of 'git diff' does not handle paths (unlike 'git status'
and 'git add') and instead relies on the default behavior of Bash
command-line completion, which completes files in $PWD; this does
not work at all with the '-C <directory>' option.

Previous iterations of the patch taught the completion script to
offer tracked paths that match the prefix before <TAB> to improve
the situation.

This time, we also complete untracked paths ourselves, so that even
the following commands, which compare files like 'file[12]' that are
not under the control of Git in a different directory, are
completed:

        $ git -C not-a-git-dir diff fil<TAB>
        $ git -C not-a-git-dir diff --no-index fil<TAB>

 1/3: completion: no-op refactoring of diff completion
 2/3: completion: complete tracked paths for 'git diff'
 3/3: completion: 'git diff' completes untracked paths as a last resort

 contrib/completion/git-completion.bash | 69 +++++++++++++++-----------
 t/t9902-completion.sh                  | 59 ++++++++++++++++++++++
 2 files changed, 100 insertions(+), 28 deletions(-)
