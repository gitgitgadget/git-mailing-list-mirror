Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95E115573F
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767143; cv=none; b=CdELfb3KJknI6xeKly6Ix1hssq/nsxnk3EiuKZHJJKRbtGbKzVnV/gru0XT6Tu0yauu0Ui34Lt/0EVoe5pPB/oa1iuXf2VAW+1+T82e6icDuhP5h3tl9XF08QAZCOAD5Vn3rBdawyv0B2awDA2MBK7/tik/EhNlyduQnBWFo4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767143; c=relaxed/simple;
	bh=NANu4Sk/a2hBWLQMZrg8slNTz0b0SG2JOS2VVAZO15M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T7y6WehWRELXhu8d1YtYdoff2yZxq/2HlGMuh41nMXZCPMw3c2fXJG2acinE8ow0xlldAl3BLsjKi554rtBYdgh/LydRkNpcuf/k2MXrkf7TcywjHoD6/IHQprv4gMMOdzkzfDukft8GAyLzff6Q3IFvMnvKADa8RQGG8ToIt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rWAMDIOQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aon3awvn; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rWAMDIOQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aon3awvn"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE9B625401F6;
	Thu, 12 Jun 2025 18:25:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 12 Jun 2025 18:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1749767139; x=1749853539; bh=+BS1OKP5G6b5+f/F/oN5s
	WdAX5VXhd8GpHO+uOWMB/Y=; b=rWAMDIOQVsPJ/NtiWyP+UiveSOe5z9CDpK//3
	S96nIOISahRKCM+Sdc+znzCMJ8wmDyXKyErih8tg5TOf/TiOwUEkk9wwxpi7vfNq
	0dopc2mC36yw9EXVo6GDRbvBoAR1rEHNUrL3nmca5NIRlLaALDJ7wxwM9PY3WPvZ
	ne2f8ipgZU8fxL/xxfxlOLus+bTV5AI7aGpbFGR5V+q5fm8JhuMooI+4CElQoph1
	nQ5b2aFNbbwewC/rsWaVNCvSNuY6F1MZ9ErH6jZj2ajXMsNUqyfetWpZMT/U4wwp
	nXV1eZHH/0VKBQhN/Mel6bn8XdN3P4dNmXeUDqFKawWLwJOsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749767139; x=1749853539; bh=+BS1OKP5G6b5+f/F/oN5sWdAX5VXhd8GpHO
	+uOWMB/Y=; b=Aon3awvnNMFX0XfpR+TC1FMuPne66wruHvvSmYYpc4r9ljN3TFk
	MygDwFKMGq2NGAaer5DSNegb09M1XoXjR+2h845TuaLf/zH4e65pk/LxEgIkar3y
	d3781RdD2PiKBPIxNvJKS9Zm3Yn7qXht39gbthJ4tLYoqmchWrEzg5eM7luEwdMY
	M/iQDCSnupgiRQfnGs3O9R8rV5mgaUVnn+RpNqJ60eHZbW5rr6aGMU9LmbgUw+xn
	zY/4IFZ30ktiMnMQUXseAe2mZ3Odsjo/Cb/3PnBYYH6dJ5uJ3biNAOUkWqND1nOv
	KNxfcKn/8zG7xrA2a27rGjiypYwpQr1kpFQ==
X-ME-Sender: <xms:41NLaPRNCUiNl0ntxQtNN3Okj_QUsVecKBxThA-XzhqZpsMX7Uv1sg>
    <xme:41NLaAyF5cR-cD8JE1wSBASqyMTiiEfkTg_MihrXmkAMEY43XspIVPeVbFYVQbdy1
    bFZ4K28xoEgwD0hmA>
X-ME-Received: <xmr:41NLaE3GshHO4kh6DGVN8noRYWEg0pmDEO81XMK_uKYdcaOCZkHm2GOFhpWcLT2w5-q0LNtzA7HzmssVf6Hzfi_iiXTEOKi7VUqa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduiedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcu
    oehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeludfgfe
    dvjedthedtudejkeejvdeivefgheetuefgtdfhvdelgeethfdugeejkeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthht
    ohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:41NLaPAIJwHg1u-3s9k_E0laCm3E-nrYMrP1YZ3KYSJyAlef_Mvyrw>
    <xmx:41NLaIgyKin5DJYZmXjmEQYNUKkU9W-_dl1klMt19RZc7S3g0w8KoA>
    <xmx:41NLaDpQpHYXcB_n8gkyGYKH1zHkKxLx-iX4rXcccOzXC-Ju4L5W_w>
    <xmx:41NLaDjWH9guNN8hIGgaPHgbuPfS8ZK_LCQs30hjo3SeJSA303ERbA>
    <xmx:41NLaDRyoEXVIs6GGnSuakqgVxS2Am11w9Uwk8QAzzgVpjkU5tr9cpTH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 18:25:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 0/2] git pull/merge --compact-summary
Date: Thu, 12 Jun 2025 15:25:35 -0700
Message-ID: <20250612222537.2426059-1-gitster@pobox.com>
X-Mailer: git-send-email 2.50.0-rc2-255-gd84100c98d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, "git merge" and "git pull" shows "git diff --stat @{1}"
to show the extent of the changes.  While it gives a good overview,
one thing that is missing in this output is which paths are created
and/or deleted.

With these two patches, these commands learn "--compact-summary"
command line option and a new value "compact" for the existing
merge.stat configuration variable, to change that final output to
use "git diff --compact-summary @{1}" instead.

I sent this out with random fix-ups in separate threads but never
made a formal patch series.  Here are the earlier messages:

 https://lore.kernel.org/git/xmqq5xh6xlpm.fsf@gitster.g/
 https://lore.kernel.org/git/xmqqfrg6i57t.fsf@gitster.g/

Junio C Hamano (2):
  merge/pull: --compact-summary
  merge/pull: extend merge.stat configuration variable to cover
    --compact-summary

 Documentation/config/merge.adoc  | 12 ++++++--
 Documentation/git-merge.adoc     |  2 +-
 Documentation/merge-options.adoc |  3 ++
 builtin/merge.c                  | 53 +++++++++++++++++++++++++++++---
 builtin/pull.c                   |  3 ++
 t/t7600-merge.sh                 | 43 +++++++++++++++++++++++++-
 6 files changed, 108 insertions(+), 8 deletions(-)

-- 
2.50.0-rc2-255-gd84100c98d

