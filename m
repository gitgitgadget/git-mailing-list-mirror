Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31014364933
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269242; cv=none; b=b8fWIgD01AEpwhHNL27vl53r/8KBkITQD1BuW4+bM0qAqHh7880xwpIR5XG22RHmFelyLeSyyVP/vj60kBgLrg+7n/k1n4XqPC+mGgT3nYgTg+1ZG7DtCE9ylWInfj1Gas1hmEmHfXlAIdHcYN09JOfQ4aZUsoJukXzZiHUTRy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269242; c=relaxed/simple;
	bh=p3xIyaUKmO7Mo+bxwmlMUDRnhIYKbu1Idugbe8P7h3Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=kXwLsDsjz0V3ZlzI/ikoWkxbG4g5LiloPiHPwkzxsrQuxWp0R4zYSML7p2Ozp+kwKd9QUllnopk/VrWO7Qy67f3ZEXkS4o9OKnGsPktHu45mKSaSXoEfuzXAz4jH18rYQFoZzJnruArCs9CkUTqfIqkD92mU48wmyqXMpsij5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zUgrzVK/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovdGVx1L; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zUgrzVK/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovdGVx1L"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C843EC14CF;
	Mon, 27 Apr 2026 01:54:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Apr 2026 01:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777269240;
	 x=1777355640; bh=TbjdQcDNQchvOxlPpX/iBKlosHVBxsDhseYWjM/gUKA=; b=
	zUgrzVK/KtoVkcEgsHLwlJbhicAgeVNDwGcW3SkW6fxiJPTFdv1suocPtiLcRWRw
	yZVB7LL5jE/VtzvQ6/MLizJQdTHA7JCO5PvgouQVEtT8/V71YR16jz3ZDgarsFVp
	SutgJAH/OQn33BLfim60RTe+s0JPZi0dYcQ93GmL4koYVBnO3A9M3486DxBLq5pZ
	+p3B36fGnG3KlNP9eRwfR2ZH4AfaV9Zy3rsy4qiXGG9uUSaplYqqbPvcvNyMClEa
	5TOXo8jRBRkSXOqI1sBs0TBdYoDRkmPiqGEYBGIg3feudavYHCZRvWDsXjKYiWx/
	hDhCloCuTb6mPaVpMMXG7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777269240; x=
	1777355640; bh=TbjdQcDNQchvOxlPpX/iBKlosHVBxsDhseYWjM/gUKA=; b=o
	vdGVx1LwjR/yEZplJWRNjsNEadKyJNRTmGm0za9wDh+CLVnpQunM5S2gQ0lC+F5v
	LcCfnpM5FEqO9Y1bqWFbPMfH0ebQKaSHhIIW6KQllNT5ARZRYE34eFJ4T65fkDI4
	3K3r7aCpdpbMPugXU2ir0vOLYS5pYpj9OmQtxBW+N5ZHOEwvckGFhD0PVdXdoIFN
	3H44muXEgQUTdIk+RTN4/lzfVFSJfUfV9pm3nGFWp8dqVtTe207DnZ11J+qhVz1b
	UOGrrQxlw4JIoY1MQ44et7F32GnAmsuk0ozGbRbaDTb2qOMCm6+7j66E8BG7Nc/+
	c6mLsuFuqvhae7XlMtOnw==
X-ME-Sender: <xms:9_nuaXNzQ55dylIILafIsrpgnKWs3_ntmJVL5CVp4F6S4APmis_d7w>
    <xme:9_nuaY86pIc105g629Tjn1mGE5iatqtZnfWPVanGioQb7ImISEmKraXEMwHwPYteW
    pJf9y3jJ8zrCtuZNDjiOBucg6C2xCsC-96OyRr2I9rWOZZ3mSve>
X-ME-Received: <xmr:9_nuabR2R7k6mY2dMkNsr7UpvltoBV_d_YfIcvu-4CLASBYaTD9ESy7VUFoObfqjsgny7QLAcRulQAFRotOYz8WFAJ167zWI1XHSNDTaIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdffkeektdefleetveegueethedtfeeugeegvddvhfdvtdetieeiueekhefgfeehnecu
    ffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9_nuaalQI3dpblQEoFR0THcUpEJN93HKQg_T-UzPAFTEhET21AqJuA>
    <xmx:9_nuabRjjgsZ8fl26SafEX9WgNCC8UGxfjjRzGQogM_wI1rhhaf2TQ>
    <xmx:9_nuaYN5uimLZEUY8QJiPWznP5gyHL_ezk5Lc67sdPgMXfkJLs4yAQ>
    <xmx:9_nuaUWCQHRZD08UJsUNKUsNbOSp0xfwYQdbDVNkG3U0H7oKjjVLPg>
    <xmx:-Pnuafv4oNI4nL9-OjD3xIJUqEnnf7RKeIsVZd86tBqp1mEm3_tjVSzf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 01:53:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c26cc0b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Apr 2026 05:53:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/3] builtin/history: introduce "fixup" subcommand
Date: Mon, 27 Apr 2026 07:53:50 +0200
Message-Id: <20260427-b4-pks-history-fixup-v3-0-cb908f06264b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO757mkC/4XNQQ6CMBAF0KuYrh1TpiMQV97DuIB2lGoE0kKjI
 dzdFo1xY1z+zP9vJuHZWfZit5qE42C97doY1HoldFO1ZwZrYhYoMZeECDVBf/XQWD907gEnex9
 7qBkLlpoqqVjEae84Hhb2cHxlP9YX1kOyUuO9X/6GLPX+vAgZSKDSEJWEpAzvY2djbyL5Ab8F9
 UPAKJhiW2Q6Nyrn+iPM8/wE5VYHIAkBAAA=
X-Change-ID: 20260422-b4-pks-history-fixup-be27e0c4a03e
In-Reply-To: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Hi,

this short patch series introduces a new "fixup" subcommand. This
command is the first one that I felt is missing in my day to day work,
as I end up doing fixup commits quite often.

The flow is rather simple: the user stages some changes, and then they
execute `git history fixup <commit>` to amend those changes to the given
commit. As with the other subcommands, dependent branches will then be
rebased automatically.

This is the first command that may result in merge conflicts. For now we
simply abort in such cases, but there are plans to introduce first-class
conflicts into Git. So once we have them, we'll also be able to handle
such cases more gracefully. I still think that the command is useful
even without that conflict handling.

Changes in v3:
  - Some more polishing of the command's description.
  - Link to v2: https://patch.msgid.link/20260423-b4-pks-history-fixup-v2-0-d7571c6d36eb@pks.im

Changes in v2:
  - Introduce "--empty=(keep|drop|abort)" to specify what happens with
    empty commits.
  - Adapt documentation a bit to hopefully clarify how changes are
    backported.
  - Link to v1: https://patch.msgid.link/20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (3):
      replay: allow callers to control what happens with empty commits
      builtin/history: generalize function to commit trees
      builtin/history: introduce "fixup" subcommand

 Documentation/git-history.adoc |  78 ++++-
 builtin/history.c              | 291 ++++++++++++++++--
 replay.c                       |  29 +-
 replay.h                       |  19 ++
 t/meson.build                  |   1 +
 t/t3453-history-fixup.sh       | 680 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1068 insertions(+), 30 deletions(-)

Range-diff versus v2:

1:  8840b18095 = 1:  81240d1959 replay: allow callers to control what happens with empty commits
2:  b078354b5a = 2:  4f35bba868 builtin/history: generalize function to commit trees
3:  3d1fec55c7 ! 3:  ecaded9415 builtin/history: introduce "fixup" subcommand
    @@ Documentation/git-history.adoc: conflicts. This limitation is by design as histo
      The following commands are available to rewrite history in different ways:
      
     +`fixup <commit>`::
    -+	Apply the currently staged changes to the specified commit. This
    -+	is done by performing a three-way merge between the HEAD commit,
    -+	the target commit and the tree generated from staged changes.
    -+	This is using the same logic as linkgit:git-cherry-pick[1].
    ++	Apply the currently staged changes to the specified commit. This is
    ++	similar in nature to `git commit --fixup=<commit>` followed by `git
    ++	rebase --autosquash <commit>~`. Changes are applied to the target
    ++	commit by performing a three-way merge between the HEAD commit, the
    ++	target commit and the tree generated from staged changes.
     ++
     +The commit message and authorship of the target commit are preserved by
     +default, unless you specify `--reedit-message`.

---
base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
change-id: 20260422-b4-pks-history-fixup-be27e0c4a03e

