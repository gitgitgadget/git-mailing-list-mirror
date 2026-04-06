Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0A4A3E
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775435035; cv=none; b=IiWI3aa8rO70t55WMa3QtfUZPIimzFrjjjQvbYiRMxuDrUZK8zTlyXQHclU8aNAAwOYTaR28Auj4QJAEXlx/Y8Cye8jNV+Ky1O82zOkyjqQz/pR6Gst0uRh4INPoxB3oKd0iWd/wcW2WsPoSqubHwmfUh/h+H9Ml8iQT366v+7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775435035; c=relaxed/simple;
	bh=HUFu7ztwTKqPv+pfaYjDspKHQUdhF0jb37Gg4GS/bLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmrBz/mcdF/zUtb+uGjEi82PMvUO/n61Yg8gxMC+Vb7gmVAo2/7fTOktlAKQTpltw+gejChbMwc/u0xwg0LiG6mwYD3oWvs2kZ5TUMbJXxXQs44ZxBT/fzKaMhspp4FiAy+bBtpPv8A+Q0WBHrPmzu8jAAPSotgGLGUrBmIGcmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rqK2c3e0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqK2c3e0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4889e045bc6so19448015e9.2
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 17:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775435032; x=1776039832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4FB1Vg3hVOacK2MyZ8A0pFHIiueE10HgBLxqRXNRQQ=;
        b=rqK2c3e0iWrPShVeFvIEbd90Q8/Tne4xrFeNSxh4fGVRKKwPktlUzPYFcSemNus6qM
         QRwi9imKxD6bgoTqbnOH/C+Cxogj+9i8JP1ZosznJGuLQZBZYctv4qgWehTN+0sdQZna
         5pIkWAiY5YxYr6rn9oetExz01OYyoc+dCCbx7MCtjmv+BbV91Ke4gJ2SZtHyGerGW6SV
         gFyShtGIdSCuymwQHveVit8KzB2lSbC0PN9qKlolTY0nClW8ooTublZ85XvRcJov/oSs
         dfMgU+vRlhb29aBDiqnJrPPiKKncyXNZNWB5zef9/lQfG88g1IWlm3Y19/R95LAbSCd3
         /mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775435032; x=1776039832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4FB1Vg3hVOacK2MyZ8A0pFHIiueE10HgBLxqRXNRQQ=;
        b=SIXzdYPDzy2xBRk2qTp/5KXy7qsyOzPVbC/d+qSpxTDNzHivlVDyBKpBipSZgde6XB
         T7Ebbg0EMZitCvorkHWwWZqlN5uLCgPn09wkrgRo98TdLRMo4ixKr4tUIJUzwS64dehK
         Tx6cqS27t+jf+E7X8ZfMTYX+6herfiP5yZmAuMHRsjgQRoPB8hZ8SB5nAOotLaLtLPfs
         TeEszOGb2C8/XqTuWVWOVlBsyuP5InFOA4I2RjKhiUhFphR68oafy9Fr0XQM2+e7D6Xj
         7ZX9Vz8rMRYlqy8t0OjsBIfJJSGWlpJmKEHTpB0xkG/mkSpmFnPssEcvyRO67VyRlxZj
         kXWw==
X-Gm-Message-State: AOJu0YytFde86ErlOsSTxMlp65NHJ/qGvy6XBxbP9n7og5aTags+QbB7
	GSbJIX0CSGwmWkLmkaZ/Z/YE9M5QG3CaPgv7YkDQHDi0gfZplqb9NucnChfDU0PjHD4=
X-Gm-Gg: AeBDiet5ong/BpSEPmbHAaBQ4vh+zoQ3dpCYlDmZwxxWDVghNGsqYbaca3LuZeUuJmq
	6o6h/n2gFPtjC7l1NuA303Mr7pP/XuontdvV0BmsyvVhVYv3USSE/9uh81d5w1xl7S+PrZavkts
	Vu74AkUyoKPrDim5na5TmF1CtFVl7Ffa+tUIJsWyGIya4V+RPyaB92oeLj9SiD/bCbZLZjK77CU
	EFDM7QlWxaOO/ycJ9e3qDcFv1WKCV1in+cNjKHLcldHmFNYLD7H2pK/rekPtLHlE7UlOtCuro5I
	42/FSkRzEFaaOTV12xZzpiWXVP9ncv4Rt5GxG2Wmt5mcHM0FjUyoFJSyu4hZFAtcTChNY74b8RU
	18s3zsef+v6DAdVg5U3Bwi2moF7UxTpxoGTxIw+wVhjbDQ2SqKrlAyjM1VvgQgW7A6V0rwB0TVT
	G1QGC58E7NSe8Jx1sMqYoBG/hDmQSeWy+m
X-Received: by 2002:a05:600c:8b33:b0:485:3fa9:358c with SMTP id 5b1f17b1804b1-488997b2291mr176755485e9.17.1775435031733;
        Sun, 05 Apr 2026 17:23:51 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d2738sm36712037f8f.24.2026.04.05.17.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 17:23:51 -0700 (PDT)
Date: Mon, 6 Apr 2026 02:23:48 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC PATCH v3 0/5] preserve promisor files content after repack
Message-ID: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>

The goal of this patch is to solve the NEEDSWORK comment added by
5374a290 (fetch-pack: write fetched refs to .promisor, 14/10/2019). This
is done by adding a helper function that takes the content of all
.promisor files in the `repository`, and copies it inside the first
.promisor file created by the repack.

Also, I added a comment explaining what is the purpose of the content of
the .promisor files, since this wasn't explained anywhere (I found
information regarding this only in the message of the previously cited
commit).

Finally, I added some tests to "t7700-repack.sh" and
"t7703-repack-geometric.sh" that check if the content of .promisor files
are correctly copied into the .promisor files created by a repack.

This version is significantly different from the previous one. Maybe I
should have created a completely different patch series. Let me know for
the future.


IMPORTANT:
The "CodingGuidelines" explicitly state that:
 "A C file must directly include the header files that declare the
  functions and the types it uses, except for the functions and types
  that are made available to it by including one of the header files
  it must include by the previous rule"
where "the previous rule" is (if I understand correctly), the one related
to "<git-compat-util.h>". From what I understand then, I should have
added an include for "strmap.h" (which is needed for `strset`), correct?
And if I am correct, shouldn't "strbuf.h", "hash.h", "odb.h",
"string-list.h" and "strvec.h" also be included?


V3 DIFF:
 * Made the helper function "copy_promisor_content()" a static function,
   because, in my opinion, it is too specific to be used anywhere else
   (at least in the near future).
 * Modified the helper function to add a <time> piece of information when
   coping the content of repacked ".promisor" files, as suggested by
   Junio Hamano. This is done to give an additional piece of information
   so that, after a repack, it is still possible to know when the ref
   <ref> was observed to be pointing at object <oid>.
 * Modified the helper function so that it copies each line only if the
   <oid> appears in the pack associated with the newly created
   ".promisor" file. This is done so that it is possible correctly copy
   each line in the correct newly created ".promisor" file, instead of
   simply appending everything inside the first created ".promisor" file.
   I have done some tests with a git repo that contains around 1M objects
   and with ".promisor" files that contain in total around 100k lines,
   and this operation doesn't seem to meaningfully increase the execution
   time of the repack (it seems to add around 0.5% of execution time on 
   average).
 * Modified the helper function to implement a "promisor ignorelist", so
   that we can explicitly tell to ignore certain packs that we know that
   we excluded (for example during a geometric repack).
 * Implemented better tests.


LorenzoPegorari (5):
  pack-write: add explanation to promisor file content
  pack-write: add helper to fill promisor file after repack
  repack-promisor: preserve content of promisor files after repack
  t7700: test for promisor file content after repack
  t7703: test for promisor file content after geometric repack

 Documentation/git-repack.adoc |   4 +-
 pack-write.c                  |   9 ++
 repack-promisor.c             | 149 +++++++++++++++++++++++++++++++---
 t/t7700-repack.sh             |  63 ++++++++++++++
 t/t7703-repack-geometric.sh   |  42 ++++++++++
 5 files changed, 252 insertions(+), 15 deletions(-)

-- 
2.53.0.585.g1533fa96a8

