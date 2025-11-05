Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9FE32C953
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353012; cv=pass; b=LAqVZj2a5tJ5GJdo+NTDoBXM6bubUngvqbVcLDjCBrSRECgHA9F9xCN4SQQNcvx6isgp5kNqtSxe7oJkT4xgASokd70TlfuHAsRmUpa+7zmooEG4+zd1QSFzSpo9+mBSPrTIMaB0OqGxasyd/9DotZwyvKL5k7urp2jGF+uPBXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353012; c=relaxed/simple;
	bh=8oAYgeOIeXG/DVfwscdnmm2OKyUJUN0ZpwgTza9pCwk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=haIBk1Ke/sWUe0l0uFuqa1nKgfaq82htuCr5VJX2rU4fA9n4k8cCCx9IoIKMMcMIuH/wNgRQDAvU+yjG6EHP4tuwvc05+SzYpy67vM1pW6uMI7EjL2hR3SUBKKkEVvLomgRtXzCqGaqzRaSVT9lOb4FM3FKUlmaEW4EJPrsl+iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=RnpdHfGm; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="RnpdHfGm"
ARC-Seal: i=1; a=rsa-sha256; t=1762352994; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M474RNm9GkqQqtnWe8DtUkgxhiz+sLzApChn+S/3kt/WLYfIR1b9BS8k+kpgPk32GAwOZpAWEDk3OfMZo/mHrTyYL5peXNYfE6/CAsrlSsjzE04DO+on59TG8JOdMVQYwMRfqW3lWUYtOmbabjV+uUpUQdtaBCc1/1zDrahLa3I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762352994; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=0R9u0PT2oB+/pAnNbsa0B9DKEPWYhsUeWmYMeHm+XtY=; 
	b=Zo+2b81b7UhGOeFzhWL0s9ArcOYteHeQltvwhZOvi6gITtj1u8JEVTMBmlFa8FxXOhwGS/zFkq3/etSrTqVbwgKXp53sGh3vQkbC1EMWNbJ72WAXOCGsLlsfNwblr3HtJtC/OJILu+3IVfX3YYOxQV/A2JEA4DNm4s00rt9O+5M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762352994;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=0R9u0PT2oB+/pAnNbsa0B9DKEPWYhsUeWmYMeHm+XtY=;
	b=RnpdHfGmKWaNnDQ5q1m1ia67a4GwM5UCoR9Kqw2YQ9EDwRFYX2cs+BtMeGqlViT7
	io5E6eEQWLg6ANE3c1SGxwK3Qyq4aHEreah1Vkp6oGHg6dZztPdQeH2ZJxeuatOSALR
	5WKBl5UAndE/39vgMRex3ZaVd2walw1yOLFJPq50=
Received: by mx.zohomail.com with SMTPS id 1762352991447469.4348294426162;
	Wed, 5 Nov 2025 06:29:51 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v6 0/4] rebase: support --trailer
Date: Wed,  5 Nov 2025 22:29:40 +0800
Message-ID: <20251105142944.73061-1-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
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

This series routes all trailer insertion through an in-process path, removing
the fork/exec to builtin/interpret-trailers and tempfile juggling. The first
three commits centralize logic to reduce overhead and simplify error handling.
The final commit adds git rebase --trailer, currently supported with the merge
backend only (rejecting apply-only scenarios and validating input early).

all t/*.sh testcases have run successfully.

v6: squash all fix commits and split refactor step from the original patch based on Phillip's suggestion and codes [4].
v5: fix all Kristoffer's review comments form v4[3] in place and without new patches.
v4: fix all reviewer comments in v3. [2], and add patch 1~8 & 10~29 to fix review comments.
v3: merges the remaining trailer paths into one in-process helper, dropping the
duplicate code, as pointed by Junio and Phillip [1]
v2: fix issues pointed by Phillip
RFC link: https://lore.kernel.org/git/196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty/

Comments very very welcome!

[1]: https://lore.kernel.org/git/xmqq8qlzkukw.fsf@gitster.g/
[2]: https://lore.kernel.org/git/20250803150059.402017-1-me@linux.beauty/
[3]: https://lore.kernel.org/git/20251014122452.1851103-1-me@linux.beauty/
[4]: https://lore.kernel.org/git/7d12b046-365f-441c-af8e-8a39d61efbbd@gmail.com/

Li Chen (4):
  interpret-trailers: factor out buffer-based processing to
    process_trailers()
  trailer: move process_trailers to trailer.h
  trailer: append trailers in-process and drop the fork to
    `interpret-trailers`
  rebase: support --trailer

 Documentation/git-rebase.adoc |   9 ++-
 builtin/commit.c              |   2 +-
 builtin/interpret-trailers.c  |  81 ++------------------
 builtin/rebase.c              |  50 +++++++++++++
 builtin/tag.c                 |   3 +-
 sequencer.c                   |  34 +++++++++
 sequencer.h                   |   4 +-
 t/meson.build                 |   1 +
 t/t3440-rebase-trailer.sh     | 134 ++++++++++++++++++++++++++++++++++
 trailer.c                     | 129 +++++++++++++++++++++++++++++---
 trailer.h                     |  13 +++-
 wrapper.c                     |  16 ++++
 wrapper.h                     |   6 ++
 13 files changed, 392 insertions(+), 90 deletions(-)
 create mode 100755 t/t3440-rebase-trailer.sh

-- 
2.51.0

