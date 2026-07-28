Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52CE474262
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275543; cv=none; b=W6Isa7NgLK0y6hOSPnq7WWPblh8AeDEAMELhOMji+TdMkWShWmoD0dGKCg468xBSA+LMdRVrb6VcA7dogTridT8RURhSC71ks4szhqMuKSqsNh50o3va6uH+yFnFxVHYFAcaKZRGrIRy8DKqThegPraWF8KIxPzwNUwpyrsDEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275543; c=relaxed/simple;
	bh=7C4Ov0x7+MN5XOVVVmqzrP2t1yRxO55ucCCA6jgfltY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lDBiBVwa7HaNlg7N7A7Iw2dc8+edsg89BDTUN0mYakw0tg3QbgZYpowK49GGF43GGrx8j6kTS3ZwFvb/nRWlC7nZvKiG1Z/LZvpIXcgh9KggAskuO/pwZs9Pg0OWZt514T+sA6Mw4Y4KAcoxJb0zXpcfoGPFBbyGOKI2r7A2mJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=enw2D18M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qwVOxssF; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="enw2D18M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qwVOxssF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2168E7A02A6;
	Tue, 28 Jul 2026 17:52:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 28 Jul 2026 17:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1785275540; x=1785361940; bh=+8OoQ3bd7bofivZL3Cn7r
	FDkYaX969QN1k87uRyzbi8=; b=enw2D18M2ffwXb1Z4f89NdipOpOrwF7Fysiak
	GEpWBNPPryFTD6fkYRF/nO/qHyTKhRn7xSzoBg5hbsc0j+ff5jrV4rSgCJRnYqOX
	INkokojg4Exjh2g56P8QGMwTK9vlHUk5BzIQEPmaNzk/iCQa4n5IrlXDWlhR6LB9
	NEOqArvi7bg//krWj3bzycyW8KNrzUyRC0Uk+nWvfWeGECvEoGPohWXf3OTZaxHY
	IgfTK2BrU+Pjxy3WM8R/i+Ogs4LbheIyc7Z+is+1HX0b/ekTTfmJKzrEVcBlQoxu
	dw0ECM8kzlrGC+zHhuUuI4iMLdgq8jr4iNXzRLb0mR9QAxIdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785275540; x=1785361940; bh=+8OoQ3bd7bofivZL3Cn7rFDkYaX969QN1k8
	7uRyzbi8=; b=qwVOxssFVBhlzXnMi6mgvsJBvNsE/SuM59gjH1lDtvu6NLznaxs
	s8TRbw8rE6OdF0L9mtYDuMbFODP1J/jA6NSvvcg3ms+dhRRdZA8+uVQI6y77JZ/m
	gBEPLrEuIOMwVIGheblRbibq8kHOPuiRCsFncM91UjuoyiRRORjUezYZ8IvEh8jd
	lwRT9BY/p9+dVbY0HPMgWr4yr5h5yKnvS9ah8iWhh1QH7MgUp/H6uF3ZvSWL6y9c
	o1J3Kq+LkhgD5oUy2vtlmkPbHlNq7XGOGDiRZGXpczRpf/rFP4e/YX0jgF/cTnch
	33TwMFKUZVKRrk6vMacJoTdBs29hcDR+34w==
X-ME-Sender: <xms:lCRpapFjwOR5Pw2P8BUTd4VEhIozCGOefh8Ujf9T8ieW82BFAXxNoA>
    <xme:lCRpakVKnp9mTi2BCH1b5pfrDJGtd9tAM3tiBwzdKcmwMcg5opn79na871HZiaedx
    hZGbl2YmLS6Nwn1DSMfwYep5gA1wG77VtnmFtfZZcxiFxGWCCHH6w>
X-ME-Received: <xmr:lCRpaoyTBK-H41jjuBzyUX3KaIPKuUHqAi0r58qKelXGpwuGiCgXYPDUwk9cio3Z-AYEtrGNKtFZjJwW-mBrQmEdCMwxX894kg>
X-ME-Proxy-Cause: dmFkZTEKkmEwveJWbpy9js/1g0fuePXP09ocmNMUyfK33KVZZ35JRVl4xssrzPipc00/n2
    53qgCR+bR98IfLzxR4WTHv42PhKao0NFHzOdhXETWO4HtuyFT6wK0jT90/HpKDVpobC4nX
    5PZsKGONCUH02UMyNTVn7MFkS4V3kAGHEnr/Ts+r0xYX1MmDNJkEbEWGWtFGy9QBuOJoQ9
    K4MxK1Bl8nXK2qH5nYY9rXSJKlomDyIDsCh7oTRe35Kks4dXU6X98zi8X97PJPc5mNaGRF
    RGi0JnfYDB1nXT0IdXkGMq+Uj41jOqOOGoEfAQ6wyO7CIX+7i3eGrVk5OKMFKvAYnBr7HD
    O43G+eRZOgY4u9rj+zL9tmTur6ay9NlmEv+iZTICHc1wwl0Dw67sSQ197NXQRM4UGzVhgZ
    awS4C3Bokrehb13krbTFomFxPKF9FSAXzzWsN1IHtBiykufwowiYKbQotBSz516XqZfXil
    UfRhlEDy/35A6Dv0MGr3V0IGF+9SU90PHJ+ntX78yyhqu30dK3h68i4eYlHhZKM5LeVksq
    8luA/txWSuIrZ6HWbyjOblrFlP38dtZjQi0YstoMC6L8yN2PJ7VLtaCVoweJApHkMvMRz3
    rqD7z1uichO+47KiblDgoZjPLfh6i2C3YH6F3WcN0M2iVqX4pV8PUhPV3mfw
X-ME-Proxy: <xmx:lCRpaqPjbDbZL2JDAdVB5GhnPo9EvTHyXITdQg-9rBPCZU2qFGPn2g>
    <xmx:lCRpah7c6x5XZ-p14zEjHpu6U4-ksuQsGdD4dOVRRLj4CcJkhBqHfw>
    <xmx:lCRpajOYb5_8bEN97XtlO2OqjKyNrugdyBbS1m1oZ64DUiUTf1JTEQ>
    <xmx:lCRpanlS2okyHW6_LqIEkz5SZofQEen0OP5xw6j40HWtGQhjynBYPA>
    <xmx:lCRpakeOS4oq0-pIhdRJIKjGCAvyOduqsXD9_Kz6pB5WyHw77U1aTI37>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 17:52:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/4] git add --resolved
Date: Tue, 28 Jul 2026 14:52:15 -0700
Message-ID: <20260728215219.753678-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-594-g42d2bf033e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When you are the maintainer of a project and make many merges day
in, day out, a lot of your time is spent resolving conflicts and
adding the results to the index.  It is not unusual to have local
changes in your working tree that are unrelated to any particular
merge [*].  In such cases, 'git add -u', which adds all changes in
the working tree to the index, does not help much.

Here is a new option for 'git add' that lets you add paths with
resolved conflicts to the index, while keeping unrelated local
changes out.

The first two patches perform preliminary refactorings.

 - [1/4] consolidates a helper function to determine whether a line
   is a conflict marker (replacing two slightly different
   definitions).

 - [2/4] introduces a helper that makes registering path removals
   from the index as easy as adding them, complete with automatic
   '--dry-run' and '--verbose' support.

The third patch implements the new feature.

The fourth patch is a totally unrelated code cleanup that almost
disappears when viewed with 'git show -w'.

 1/4: merge-ll: consolidate conflict marker scanning logic
 2/4: read-cache: add remove_file_from_index_with_flags()
 3/4: add: introduce '--resolved' option
 4/4: read-cache: reindent

[Footnote]

 * This is not limited to my own workflow. An earlier message on
   this topic worth mentioning is:

   https://lore.kernel.org/git/CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com/


 Documentation/git-add.adoc |  10 +++-
 builtin/add.c              |  92 ++++++++++++++++++++++++++++---
 diff.c                     |  25 +--------
 merge-ll.c                 |  53 ++++++++++++++++++
 merge-ll.h                 |   2 +
 read-cache-ll.h            |   3 ++
 read-cache.c               |  89 +++++++++++++++++-------------
 rerere.c                   |  38 +++----------
 t/t2207-add-resolved.sh    | 108 +++++++++++++++++++++++++++++++++++++
 9 files changed, 319 insertions(+), 101 deletions(-)
 create mode 100755 t/t2207-add-resolved.sh

-- 
2.55.0-594-g42d2bf033e

