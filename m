Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455129293F
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558926; cv=pass; b=SS542YeB+FATFuGhhREFSaOTdiHfK1kxOw/VTqTJlFYiK8YixQntpTEG81YAPcL8hdwj60AUdV2aUBg5zCWyZOUg9bSgEgHbesKFg3cwJhvWk1Fc1iFovvTUzHV1B7XWMmFxLBCaKABX1TpsLHoj2MqrNu+Kkq5Q4PggTPJorTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558926; c=relaxed/simple;
	bh=vOEGAEqgqSw/YgqDHBgGNrnSA+53HpahMgPLYTZzalw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WjUsexsCLZOOeztie8uDMDIuNcGudqKm9mPwihItUlkkchak+66KgKFcBsznEAE2v+t/cKkoABSFxWzaOsJABXyM/bu17xldFFcXvr+9NHC1Z1Ju01OA+lRgj+8eSURrntDTuDrNQl7xSlYSkV3272y3vrnjM+uq08mTEvZexW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=NZwL5WGg; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="NZwL5WGg"
ARC-Seal: i=1; a=rsa-sha256; t=1749558906; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iOrJ5am6JdJ7NoO41nCwvZCmbXSMYNmQbFfVAjSoHiaHlNLQ59ky3peBhhdx3fZhdG5pVYfKj6q6oTJTcjTSukhCHN0P+atJIpwO7Gey06pIdmGXvlfj2F0Evmztjwu9gKpRgDQA0hP/ABFqS4kYQNZHoML5eiqpvXr1rZcj7os=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749558906; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=pFSDreg0SwIUszzwaRT+1B2lRsWVtmCYXrtjG0pEKpk=; 
	b=E8hNQyXqOR3j38FRd6Ki8FRoCGA7u07ixn9xjhtzPwZyF/3Iq0QQbr0RzYVyl8IpPt3tM9Wlq+e/fUINumP0UwtPBqHsmVZKJTnfo6fk5bkQXIB31mSO9tz+tMAa4FnlZ8GzRR/+jDhByJdyujZibvQtOkJBSXtFJo8z7ESyY3s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749558906;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=pFSDreg0SwIUszzwaRT+1B2lRsWVtmCYXrtjG0pEKpk=;
	b=NZwL5WGgkN6M7KC7TpqsBwEPjwzMI30vC9UKuYSiqkBJAkEHFzuGvHpFUOWXshiA
	GNjpxgbPP5ll9tCwuvp/lWo2COJdI7I5nNSxCvOQYTLoaZfTguCfMWxZeAHL0XAYShd
	JULXN2qzIINWTImXvcUInoZ2KpvG8MebAsH+r3pI=
Received: by mx.zohomail.com with SMTPS id 1749558904404151.64417314353966;
	Tue, 10 Jun 2025 05:35:04 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v2 0/2] rebase: support --trailer
Date: Tue, 10 Jun 2025 20:34:57 +0800
Message-ID: <20250610123459.278582-1-me@linux.beauty>
X-Mailer: git-send-email 2.49.0
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
Github CI tests have all been past: https://github.com/FirstLoveLife/git/actions/runs/15558597606/job/43805117563
(except for debian built test because of network issue)

RFC link: https://lore.kernel.org/git/196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty/

The review comments from Phillip in the RFC series have been fixed. 
Thanks a lot for Phillip's great review!

Comments welcome!

Li Chen (2):
  trailer: append trailers in-process and drop the fork to
    `interpret-trailers`
  rebase: support --trailer

 Documentation/git-rebase.adoc |   7 ++
 builtin/rebase.c              |  98 +++++++++++++++++++++++
 sequencer.c                   |  13 +++
 sequencer.h                   |   3 +
 t/meson.build                 |   1 +
 t/t3440-rebase-trailer.sh     |  95 ++++++++++++++++++++++
 trailer.c                     | 147 +++++++++++++++++++++++++++++++---
 trailer.h                     |  17 ++++
 8 files changed, 372 insertions(+), 9 deletions(-)
 create mode 100755 t/t3440-rebase-trailer.sh

-- 
2.49.0

