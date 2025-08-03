Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A017BA1
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754233292; cv=pass; b=CSAuKdUU1kAEwk/UIEIEZYOs7dxMLfZklnpFv3lf3k8m5XQYci8ZxjN/pOsbK9g4R+XA1rdHYWTSvfBXiyafhmAHCws3TsIZtwKJ4zyP7iPbhj/4nroq0soRwbxYooy62AdsydLmaNIav80cOoBeQzvvLimB4KNAMIRPbQJKLdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754233292; c=relaxed/simple;
	bh=+Br0C12oPOJ1LmUXANidBtsKz8GpcqYJ52yApFCkQdc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DSq9nXhLrKy4rLL1p5Nv9U1d8WolnjsL1e3MJo5RT3HraKEjYFQq+1Sb7Bf5Advp0wkwRGzyciPpheWvM4gkM1Aid53Hpx+ffKT67/cPFV3diZ2NILGZTbf/eF2/r/MdRy+XMOBvlwyLnwNfFoHWe77y3iB3qjHAy6ahBe+VBac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=iWRfqhlo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="iWRfqhlo"
ARC-Seal: i=1; a=rsa-sha256; t=1754233269; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I/m3FArd65qb5e33dUmon755pfjbamxM3kiyStz8BFrRE2Tk/5YJgtlybgGfa2gDa7L7pPbYHc8S6i+9t0u0+wjgpWChw0Cve1J0WAps0NL+QKjakhL3bGgAjlX3RNdGkoL0PQzv/MUMv33j2gYE0KJyncHmDuVry7wYdh/09MU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754233269; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=/xKaNunwvHOFWB+NEQyMqeAD7xcxWmGaltLkPkfL/+A=; 
	b=ZWnqoDE+ldYqsQDIuJk02+H8ueb/1Bmrvv29HI5rRo7pnmihTpBpkh4om/tM4itUXZ4y/MGHI9rVFlwq9dwUVBl76fIVNvu5MI8A+QQFRtPIZYoxhepYd21UZQhByOpy5rKjGdid3Vq5p4vYorARTagCkSsnb4Fkgs5Ugb30bl0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754233269;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=/xKaNunwvHOFWB+NEQyMqeAD7xcxWmGaltLkPkfL/+A=;
	b=iWRfqhloVxPjDWd85xa9X0z7snXTpvl722O+nr/qZmGWv9uCtHiqtPs0iJNI/ALs
	pRpRLKlBtjcDxA9l+S4f6fC3Cdwx3XtKxQUjWgqvZ1SpQEAUg6X2FOkuRYPhixs8Osg
	H+S4hY4hIwzKCRVOMfpbAuPlGh097fS9Uebu1++g=
Received: by mx.zohomail.com with SMTPS id 1754233265577435.0953178657519;
	Sun, 3 Aug 2025 08:01:05 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v3 0/2] rebase: support --trailer
Date: Sun,  3 Aug 2025 23:00:55 +0800
Message-ID: <20250803150059.402017-1-me@linux.beauty>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

This two-patch series teaches git rebase a new
--trailer <text> option and, as a prerequisite, moves all trailer
handling out of the external interpret-trailers helper and into the
builtin code path, as suggested by Phillip Wood.

Patch 1 switches trailer.c to an in-memory implementation
(amend_strbuf_with_trailers()). It removes every fork/exec.

Patch 2 builds on that helper to implement
git rebase --trailer. When the option is given we:
force the merge backend (apply/am backend lacks a message filter),
automatically enable --force-rebase so that fast-forwarded
commits are rewritten, and append the requested trailer(s) to every
rewritten commit.
State is stored in $state_dir/trailer so an interrupted rebase can
resume safely. A dedicated test-suite (t3440) exercises plain,
conflict, --root, invalid-input scenarios and etc.

All t/*.sh testcases have run successfully.
Github CI tests have all been past: https://github.com/FirstLoveLife/git/actions/runs/16704004515

v3: merges the remaining trailer paths into one in-process helper, dropping the
    duplicate code, as pointed by Junio and Phillip [1]
v2: fix issues pointed by Phillip 
RFC link: https://lore.kernel.org/git/196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty/

Comments welcome!

[1]: https://lore.kernel.org/git/xmqq8qlzkukw.fsf@gitster.g/

Li Chen (2):
  trailer: append trailers in-process and drop the fork to
    `interpret-trailers`
  rebase: support --trailer

 Documentation/git-rebase.adoc |   7 ++
 builtin/interpret-trailers.c  | 117 ++++++++-----------------------
 builtin/rebase.c              |  98 ++++++++++++++++++++++++++
 sequencer.c                   |  13 ++++
 sequencer.h                   |   3 +
 t/meson.build                 |   1 +
 t/t3440-rebase-trailer.sh     |  95 ++++++++++++++++++++++++++
 trailer.c                     | 125 +++++++++++++++++++++++++++++++---
 trailer.h                     |  18 ++++-
 9 files changed, 375 insertions(+), 102 deletions(-)
 create mode 100755 t/t3440-rebase-trailer.sh

-- 
2.50.0

