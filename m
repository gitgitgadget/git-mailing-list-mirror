Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF9645A2B9
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389996; cv=none; b=CfOvNOe8ot97M1PV1233fpctLGI8nULga7J3zraTbZyP73j8RetTXAoBY9oKWYZkT7g3yZRMUYATD5s+KB0L0pBV+lXvRO8d4WHeZGtpjCqFwxWUL8ifvwHBFueeX646yo7zifjOZt8A1LCXgEksk71LPzcAFvZmIjjbX00Wsn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389996; c=relaxed/simple;
	bh=p6WB0N0cg7215ykPlek5e4AW/njuYC2t4zcfuJyexPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeVQUKIx5dxd8Zb5x4nGSEO8bK6QgjJX1CjepoI06sWC5LVmUZT2j0HoqCh28hNcJc7/MIrmZMCrn4zKpKaGZTSVZwGILP2qg9VM7YhlwkOgsV4jl2NDNbDbfF7Gq/WZs74ypGkEPm4Fyurn51FgvUTRR3hKaBySJyXpDqjGvmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OJ9rEPhy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FKJGQ3Oz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OJ9rEPhy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FKJGQ3Oz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DD4DE1D000BC;
	Mon, 14 Sep 2026 08:46:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 14 Sep 2026 08:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1789389993; x=
	1789476393; bh=aV/sizMZHpvM+tID80ZQr+UgEkC8+hiPrxelSUbeYMs=; b=O
	J9rEPhyyXo2xbDI7DZ6Nz8uYNmAIa9PgXijO2aDTMkSpJBAxJNHajKdc1+phIrmg
	iS6Jr9f/Ty5mbKd2PRV92QsyVtFof3zJBw0xN5bSCctXxF5Ybmv/7fuQ4LPWrl0D
	DeoswVlN00GJZ7CBwHqf2cBiFeFcpX8NdY02sRinnU6BCaMFczTjtMO29I4RTCSx
	UcOnW1e8yiGOvFHNImsCGH9au0Rjga4SKob8ERL9q4NsN/dI9adycda+Qvl7b8xK
	88ONLtmTsTGKcos7gXbfR0STpU7ks42qZsOqQfMQ+sof8Q/58TYeiPIovr9s4rpJ
	n/3ynAEY6zs3IDIoW09wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789389993; x=1789476393; bh=a
	V/sizMZHpvM+tID80ZQr+UgEkC8+hiPrxelSUbeYMs=; b=FKJGQ3OzczNFEQZVJ
	65oJJrP68r0Q14ODLkOEwV5u4cZ0Un8DXE8MGURamS3EKOT+YwvNPUZM9Jda+Ph5
	FE4utXZvsjm3uaMQs9fr6PcfnwZwcnvLtjObOnO3KhuoiPk0q/3xWMq9zsgD0hhN
	VXkGX332REmxxuagccKcWEgv1GUOGvxw5H+bMwz6kOYEd3G5kWJEdIxXtWyoDUTu
	etkkaYMguNQwK5OpzSWJxmkxfyVTwlIgbf8K92p3HJooM6zSBzvp14Clf/1buMzm
	2/aF+lazEhAF/KNB9qivrpZZMsT3Qz9SDjg6h9qqafmZ3TiEPlf8safjNAMSdZVk
	A7c9Q==
X-ME-Sender: <xms:qeynamG_U-Edg83RKgj_r2nbK7TyarZWBk30XKhY7xTOuBSIszijYQ>
    <xme:qeynatVBmZLufWQAICkhtPMuvB-lnkVkzCiNCN66XOMUjY0K8lOJea53UzLlrncEC
    EFi1TtIw2KZCBm3qSZwi_koU0jniymHt17_GknWIDMPU-RJEa3onE8>
X-ME-Received: <xmr:qeynatxbC7d-CwN4GxQ85ft04iZSuhbgGoCOCir3-VbSNFy_gFOXjZS_fXtZjukS-Nd97zqXFrlNErM5v-DDhdoaD06g1IHIS8sieCc41vNJANXzARk3PNZiKGbe30iOFUA8NkkM5qQHBsfa>
X-ME-Proxy-Cause: dmFkZTGnfaKz5Osj/WJico4NA/8vK1J6z2u0njVxAJAzdkhMABBszXaNWDb3sBkER8h8RR
    rOzD2c7Q0Lhk7EvlBQXJyw738iJpOKQI09lZgz5i/zFosHV35wiV49b2jq2GhMlRm+TFb1
    a5NkQ//IVSpOmY75uQcPzTzdP0KWMo6cZZcFCJq631Kq5VtChCFQwJ4EUzdn2Iz1A1pT1G
    Jatp6WQlSkKWfsEMY/LLl/GtB0ioaQg06esp+iH2Y0LPAT4LEmN5jxGm5hLJJ814Je0WkU
    cd1hk0iIFWs+sHByZkVRN6XUzOb1SIofcbuQBrciZ3vqmbvTReLOiL54k1Mj1u17Jg8/nd
    GhRYS7G8KnILPyVJoW2cEtudh9+4mZlS9XbDooq5akZ9gkM2Zs6iTIB5L/e3nc3NBbV17F
    3WNFdcG0/GfjkVb8yIAlF52aMg+ySeQgMhoIJtvjpdTS3AFl6AGJ6B8IdbEqY+r7tD6A7E
    LC/73mnDsZ6KqACxi8tgc7oo5doxj6W1TVHuRPEFxCNrz9nhOL7k8droFcwZrU9V92oJ2j
    o0UVm1ulkvxhSz0L1ENAyZPkeb9eoNdyhmsuTh6xNFafy3xsTu0Q1DrvwthRZ1IhG8ECRA
    Sd6IaTMIve2P7K0SiK/YTk5dgSupqGB/Kogb5a93UFYGiNk0x8Jf7tj5u8Mg
X-ME-Proxy: <xmx:qeynarMNCMNrbTXfZLddlMFtgQgcEhsR9OwdaJv1k1JZR_YnuR69Pg>
    <xmx:qeynau4khwsYP2xKu-nNJa5nmZEqCVLomXkwr1xto-CvFnw_Gu3qrA>
    <xmx:qeynasN4uGCHNeMzsXy05gDJNLyPN8tvMKVdqZKQCAwo8Dkjd8OqBA>
    <xmx:qeynaslPYzSNkbj7tzI2DypQbAbcDvNh-HyLBQmz4ZcqJZeGgmO4pA>
    <xmx:qeynahcSSXOl2jooFW_3VcLenZB-EnYseroC2t36NtMsfBQKCel4PKzd>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 08:46:33 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: [PATCH v2 0/2] doc lint fixes for pack-refs and refs
Date: Mon, 14 Sep 2026 08:46:26 -0400
Message-ID: <20260914124630.154107-1-tmz@pobox.com>
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

Range-diff against v1:
1:  03c1e8c073 < -:  ---------- doc lint: match commands as well as options for synopsis style check
2:  eb3b95c7a7 = 1:  3de9d9a6bf doc/pack-refs: convert synopsis and options to new style
3:  7af3718a71 = 2:  b3789f7591 doc/refs: backtick-quote commands and options consistently

-- 
2.56.0.rc0

