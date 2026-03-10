Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1BD2D8DD6
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167015; cv=none; b=oqqH2s+eXP/wQebl2m8WpAMvl5Fh90yfNGcI1/AKPXAqMJ0gVjrIj87ENZF8NKf1h7t3sUsxxdT86dtFH2x3YlZjLvjto1mCCFuiYY2Bz/QJQitQSnf/SxbShDF0+omsNKxGIPz97QTtDQ3g/r/1z5hhsiiA/gDTSP4KiCKtMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167015; c=relaxed/simple;
	bh=XqJzwq6PK8wUcZxSXbF7Bd/DEnf7zaGfD4I29e2QQD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EzsHxWHDJpPHMUtduQMXolcHyQRUmwgQIgxkw2koz9xNjXtmvIFcyEl3u5xcBzAHpXN/RdHJaVULsoKkhDT049eOSH+3T8QSH/l92DyJfizQRGrJ9R4Un2h8LipPnM8BEZo9WDgCPHDsVU9QVX5KFt4rPsC4e/FnahFXuOblcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VF+aGJVi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lnyLUR0j; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VF+aGJVi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lnyLUR0j"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id EE223EC118F;
	Tue, 10 Mar 2026 14:23:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 10 Mar 2026 14:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773167013; x=1773253413; bh=FXV+2EkNcL
	91Jbca1/rmHA8Y7vzbk1AWk+Jsp8bSVTQ=; b=VF+aGJViM6nj+u7W3+xcTOl4xd
	Z0Z/GBMuDgz1AtZU81/88m9Ls/eHpSoQFIejgDo07gvmdTEswynVDZFCwZiqsCUm
	uc9IhSDpjJmWfkGUSGEybHh6p5D6PO4vxfEscFxAsgK5fyNCKqfEt1qboqgCPwz6
	1TcnT278/TnMGbgCLrz6UJqkME8YTlD9CdhrzAzWm8eKPvNqJpeFMKFQqD6SYFhw
	JXNXlKXblNh6BhsOB5uhWW7nTBm6EpJG2CF/NvAATYawF/aSitb2pF3Aavz3cVaM
	t9zhAdiffM4RPhyUYEvoBvhBrBSwlaaLXlKaV1QKBYYyWFDWien9iBHXB/fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773167013; x=1773253413; bh=FXV+2EkNcL91Jbca1/rmHA8Y7vzbk1AWk+J
	sp8bSVTQ=; b=lnyLUR0jmdbrLlY+9EMoTlPjMqQb7L7cPydUXCsfeL14aoduooS
	EKVORZWLFi+Pj5HJe4pEK8CyMZNJx+CRUN5OvXyS7fhdBW4owyM0fMZwcuYUtaE/
	EEHqeeIbVD640ir5Fc0BoZZ8xmYkSWMsshInZyPACUMbCguqiV3JORloCPzPy0cH
	23ZXUr3STEDaMS7q5h3/YSFBw76ayp7/e7OT4XPnNlU0jh90/JWFCMFW0vVHuWZp
	4ZJQdvCg0E//NLK/RvqLbLIe7Cgg7GoshP843ZqtKYLQSooJTm2A4kPykF/1jWlE
	Jvh20yVlvvtRKlkbAIfCRwRV2geFEeevKJw==
X-ME-Sender: <xms:pWGwaeGHgt_JYbymC185j7uuuP_kSCuK6Qu6QBWv5fY0N3a3dN56Kw>
    <xme:pWGwaWz45YOq6VH8ae4MnlpRxDGB5ZFK9S_wFCNWYT_cAWP9eqF1yxdTW_wCuFgaL
    xBlx-QwZxFL96TITTTTH-ltvJGQ9dB3sA-rW3q5QDKrnA4EYxjzTg>
X-ME-Received: <xmr:pWGwaVjWKaYnh7uCUsWNN8-GG-xbkkjVw-pf4ZlpCLo_I8gxTuPyeSlUPyDn4l6CEt3t4DlMJ3IGRPxRtMkCxZ2g2heqRJWnUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedujeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepledvffeugfdtvddviefhheffleetheeifeevieehteeivdfhgeeijefgheej
    feeunecuffhomhgrihhnpehmrghkrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pWGwaRzXTShfcSCVc5s5boBu5oo8Vg-HmGgQGRhDNNjhy13Cax9N5A>
    <xmx:pWGwaYI6mRi75STBvKQPnZenJKpPKTMbikoGw7yzBza7KMeJFpxZ4w>
    <xmx:pWGwaYQ2ONpp0DUfX-JDpgbCYLC2TdJn33zvY3R5UyJbgtgoiFD89Q>
    <xmx:pWGwaQrYbJKA-32qTUdn_XFfC0GkGGdi1PrTtiX8RRHJ5JHV0FCzOw>
    <xmx:pWGwaW4MgkbXtAC7A22vq8_bkSYUfdpG4s-F1EG6vIeKQihnKMcxWpav>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 14:23:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] Some build system improvements
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
	(Patrick Steinhardt's message of "Tue, 10 Mar 2026 18:52:33 +0100")
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
Date: Tue, 10 Mar 2026 11:23:32 -0700
Message-ID: <xmqqwlzjtufv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Patrick Steinhardt (8):
>       Introduce new "tools/" directory
>       contrib: move "coccinelle/" directory into "tools/"

Even though "make coccicheck" may not care where the coccinelle
stuff lives, if this step changes the location of the resulting
coccinelle-generated patch in the tree, it will have fallouts to
developer workflows.  The blast radius may be limited, as those
other than Git developers will be hurt, though.

I mention this to forewarn others early, but I do not have a strong
objection against this step; at least not yet, even though I may
change my mind if the fallout turns out to be greater than I
anticipated.



>       contrib: move "coverage-diff.sh" script into "tools/"
>       contrib: move "update-unicode.sh" script into "tools/"
>       builds: move build scripts into "tools/"
>       git-compat-util.h: move warning infra to prepare for PCHs
>       meson: compile compatibility sources separately
>       meson: precompile "git-compat-util.h"
>
>  Makefile                                           | 76 ++++++++---------
>  ci/run-static-analysis.sh                          |  2 +-
>  config.mak.dev                                     |  2 +-
>  contrib/buildsystems/CMakeLists.txt                | 18 ++--
>  contrib/meson.build                                |  1 -
>  contrib/subtree/meson.build                        |  2 +-
>  git-compat-util.h                                  |  8 +-
>  meson.build                                        | 96 +++++++++++++---------
>  tools/README.md                                    |  7 ++
>  check-builtins.sh => tools/check-builtins.sh       |  0
>  {contrib => tools}/coccinelle/.gitignore           |  0
>  {contrib => tools}/coccinelle/README               |  2 +-
>  {contrib => tools}/coccinelle/array.cocci          |  0
>  {contrib => tools}/coccinelle/commit.cocci         |  0
>  .../coccinelle/config_fn_ctx.pending.cocci         |  0
>  {contrib => tools}/coccinelle/equals-null.cocci    |  0
>  {contrib => tools}/coccinelle/flex_alloc.cocci     |  0
>  {contrib => tools}/coccinelle/free.cocci           |  0
>  .../coccinelle/git_config_number.cocci             |  0
>  {contrib => tools}/coccinelle/hashmap.cocci        |  0
>  .../coccinelle/index-compatibility.cocci           |  0
>  {contrib => tools}/coccinelle/meson.build          |  0
>  {contrib => tools}/coccinelle/object_id.cocci      |  0
>  {contrib => tools}/coccinelle/preincr.cocci        |  0
>  {contrib => tools}/coccinelle/qsort.cocci          |  0
>  {contrib => tools}/coccinelle/refs.cocci           |  0
>  {contrib => tools}/coccinelle/spatchcache          |  6 +-
>  {contrib => tools}/coccinelle/strbuf.cocci         |  0
>  {contrib => tools}/coccinelle/swap.cocci           |  0
>  {contrib => tools}/coccinelle/tests/free.c         |  0
>  {contrib => tools}/coccinelle/tests/free.res       |  0
>  {contrib => tools}/coccinelle/the_repository.cocci |  0
>  {contrib => tools}/coccinelle/xcalloc.cocci        |  0
>  {contrib => tools}/coccinelle/xopen.cocci          |  0
>  .../coccinelle/xstrdup_or_null.cocci               |  0
>  {contrib => tools}/coccinelle/xstrncmpz.cocci      |  0
>  {contrib => tools}/coverage-diff.sh                |  0
>  detect-compiler => tools/detect-compiler           |  0
>  generate-cmdlist.sh => tools/generate-cmdlist.sh   |  0
>  .../generate-configlist.sh                         |  0
>  generate-hooklist.sh => tools/generate-hooklist.sh |  0
>  generate-perl.sh => tools/generate-perl.sh         |  0
>  generate-python.sh => tools/generate-python.sh     |  0
>  generate-script.sh => tools/generate-script.sh     |  0
>  tools/meson.build                                  |  1 +
>  tools/precompiled.h                                |  1 +
>  {contrib => tools}/update-unicode/.gitignore       |  0
>  {contrib => tools}/update-unicode/README           |  0
>  .../update-unicode/update_unicode.sh               |  0
>  49 files changed, 123 insertions(+), 99 deletions(-)
>
>
> ---
> base-commit: af2c8a61818d773325ef2324dd135786a03ebca0
> change-id: 20260304-b4-pks-build-infra-improvements-cc4012c5364e
