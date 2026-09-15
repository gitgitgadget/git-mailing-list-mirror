Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659BA3B71B0
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477842; cv=none; b=TW8MNWp07Zh4QIJ4TcP7oe4eFLH/WGjjBjxZqRrroCwEOjSCXVIb2u9LQ4/0OaYXz3B17tHsMFUl8bW5M7/7cY/rKGeWHxuaB5ynMCX+FcofJd+3UAyOt1gQkYEf9x5vs5uzZLcph+5e3RMZIlzTDTdo/WDhnEJy+maH4trZeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477842; c=relaxed/simple;
	bh=TXFLzCxUXcjQGgNQTvJLcqQUu9265P9FACUMgki5f4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioeuKAU4Fd3RMRttXtmTKL/cwV4iSP0l0b8MRxpvBVnuC6rNwWrtezl+iMrDpcBN60rUVkbPsbNaSoh3Z5aE1FUUd9DFqAyHyA+h6bL4OJh260QzOIc7lQpfTijVj9h7PogR2lJjhcRDFFiBDRmj1L9smHC2Xlvffc7RyB+MIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qL9UyvrB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D51G2Q8D; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qL9UyvrB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D51G2Q8D"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C570EC05BF;
	Tue, 15 Sep 2026 09:10:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 15 Sep 2026 09:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1789477839; x=
	1789564239; bh=ziCJ31CV86ROHBJSbrC/nPjW2wlZL3P0PukJdaFDgJM=; b=q
	L9UyvrBOlnJxghWuPEY2gv82VglluQhT3hGX2wB2lg9FFjhRKiYEfQXTla3WjIRV
	XI2Wse+251CrI3U0SLBlD7/MvOSjfQdb7mGcezChV6bJ09VmEPjWQjr+wwCnJ0DZ
	7lBR1S7oVjOzIF2DDiZW8TYpzqPRPfCp4UJ7OteXIqsWhppS9R0z4fe8w3JRk+/e
	mxz2F223e6npAS6O9b5150nZ7jO1wm8dYXRJMeT/mjNACOSNEmIBgibRivTz7uWG
	Q+gy6FmQT5VCkCibXFXEKIEutM2mE8LCnorM7owfspt+WI8QYGa/doGzYbO7c/GK
	eVyLBBayq9E2MatDSK/Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789477839; x=1789564239; bh=z
	iCJ31CV86ROHBJSbrC/nPjW2wlZL3P0PukJdaFDgJM=; b=D51G2Q8D6DW4KoVVN
	aZMZQbehXtAQWKOcjIF+utOSHVDhNMu4/jcmzBnGL5hhP3Nv+/yntciiENQXNT8k
	glHzMFsEGOdVWu048BPPvJBCkZQOAeK/uwAVySScPv6KqQYfbllSRJ/bZqnHFwk/
	PYmva7r9q1LK2xsEnzTB5cz9DcPi+YYpLs/oH6waH0QM4LgRfgGErHo4NZqfpRHk
	W1a2sNSVT9BGMMLTvebsxYNTiC7NSaT+eC5zT4ZwgSH0NgsKmcQaGyqy4LZapfVw
	6jab3HBHpDUfTAvOO3/QwtPknGpBCrzVdl75mxBgVF1X4/ffLNAodMfpER7d1Cdz
	+vf3w==
X-ME-Sender: <xms:z0Opaq-drutFsRA1k3VpUV3ty6-cIGK6nY3xznxzDHe0gXnKYeWXZQ>
    <xme:z0OpaiJVKgzkmVgrcOnc_lEf365AWDMxawLo5IoneRmhsI9ckGwg5vCjVIaknM4Et
    0SZmUve0ub9EmnNSJYQu_stVnWPUnLjdBK_Y2I1CafNfKmaYO4ysbM>
X-ME-Received: <xmr:z0OpatbTWGJLyEJuJxC1jvqcfypyQyabxdlO9rkkfN32qDFjWBicG_vzJRnNZLaa97ym_Vm2VFh4r-_zTf_TtcBkq5NaMI6b0Ngm060Nb0L1-eopa67SwzuQndM5LSaYg1QGDykzZ2Wf7cDo>
X-ME-Proxy-Cause: dmFkZTEwwEEEdH4NwxA8tplWb51+UrmNrL20tNDN0JsQM5quZ6BzQOE/CZ/COcFHl3u4Xo
    hKkZ4qVLpIGHib+rUNU5am3DRnYev5yMh0qF2Q3Sfyz9qLRUWicva0BNdzJVsSiNTimRKN
    oEOiX/GAftM116Sw6Wr9T59hw9pr9/VNZb1b8L60bwh47aUf/NMdcs5m2RQISR/EC1ikPQ
    xJa+8Jy4jSRYQVfMOIrVq+0JjPMrtC2YqgYkwXHmVkIKn7dgAxK3r+VIU5/v6/3IZhLpA5
    uAq/+ZRW/b/I+u26GkVJridMRDnxSBIGKnBwz7cbwFlOQX/O13wbpG1AahPTyJzfc24gq0
    WGuDrPMlaFTriohOyhuyJ2UeTwtyjDGk+QHd4fw54vmWZabCyUrNwe5KF5Y3+Hc0GYaPj6
    5c5OHpG0EUz4tJTy7Hw9o3fGiRGbHAPzFVgVprO3AUQ2duCB9JDZSO0V2vxSSpxG9jWQMm
    kK8KEywvPOab9PR2DU8e28OFBfq0shhL5VMJraoLo5Kq2D2Xk7umX2F7DffptAcrUSZ0+v
    4GrQqXKtS8LCFMx4kYLlKmKqs0/hCe2Wv6Q7+AkhMHxeqBPjzYn7Ikl8B3baX8AzzvdTSo
    ud1xioPeaP7IEXFTzj03BuRqb7mQvozvsLyLdRW2EyhmZZviozybmdVubtKA
X-ME-Proxy: <xmx:z0OpasL5NnRUktUjcRAj3SnB1HNPC9Ix_NLfVgMmWfzMfnWG-n4r1w>
    <xmx:z0OpajAfBsV_BIyxHg9S7bV-RPxjJuyWjPUs33gJveOwEhWeKgpzDw>
    <xmx:z0Opaprocc4FwL_Bp2WzBycHlenXtHAXTEAO1axxcw8ObLP1qp7rSg>
    <xmx:z0OpamhvRaWv_0MjX2Sr9099US9esPRZEDdWc8kgAmmdZzU4X-vQ_g>
    <xmx:z0Opalw6edK6L4sq_DCr2nakSIojAs8fxH8qSEo_d668XE_eXhUHrYNS>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 09:10:39 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: [PATCH v2 0/2] doc lint fixes for pack-refs and refs
Date: Tue, 15 Sep 2026 09:10:30 -0400
Message-ID: <20260915131036.393249-1-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0.rc0
In-Reply-To: <20260912191509.844954-1-tmz@pobox.com>
References: <20260912191509.844954-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was reading git-refs(1) after noticing it learned some new tricks
in the 2.56.0 release notes.  The formatting stood out because the
first two commands, migrate and verify are bold (in the man pages)
but subsequent commands are not.  The HTML is similarly affected,
with those commands colored differently than the rest in our online
documentation:

    https://git-scm.com/docs/git-refs

This is due to inconsistent backtick-quotes.

As git-refs.adoc includes pack-refs-options.adoc, I updated it to
consistently use backtick quoting and converted the only other file
which includes it, git-pack-refs.adoc.

Changes since v2:

    * improve wording of pack-refs commit message and change
      "configuration key" to "options".

Changes since v1:

    * Drop Documentation/lint-documentation-style.perl change.  It
      is likely to cause more false positives than we want.

Todd Zullinger (2):
  doc/pack-refs: convert synopsis and options to new style
  doc/refs: backtick-quote commands and options consistently

 Documentation/git-pack-refs.adoc     |  8 ++++----
 Documentation/git-refs.adoc          | 14 +++++++-------
 Documentation/pack-refs-options.adoc | 10 +++++-----
 3 files changed, 16 insertions(+), 16 deletions(-)

Range-diff against v2:
1:  03c1e8c073 < -:  ---------- doc lint: match commands as well as options for synopsis style check
2:  eb3b95c7a7 ! 1:  280a322df0 doc/pack-refs: convert synopsis and options to new style
    @@ Commit message
         Replace [verse] with [synopsis] in the SYNOPSIS block and remove
         single-quote formatting from the command name.
     
    -    Backtick-quote all option terms in the OPTIONS section and convert
    -    the standalone placeholder _<branch>_ in prose.
    -
    -    Update the included pack-refs-options.adoc to backtick-quote all
    -    configuration key terms.
    +    Backtick-quote all option terms in the OPTIONS section via the included
    +    pack-refs-options.adoc and convert the standalone placeholder _<branch>_
    +    in prose.
     
         Signed-off-by: Todd Zullinger <tmz@pobox.com>
     
3:  7af3718a71 = 2:  9475c1c1bc doc/refs: backtick-quote commands and options consistently
-- 
2.56.0.rc0

