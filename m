Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D3292918
	for <git@vger.kernel.org>; Mon, 11 May 2026 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514370; cv=none; b=fcPFxA81eGTRaS1iDX0HR4DVZpfRrJbnfTLsvny/O8v2qCLX6C2clQf8zagQ6sOCQUNI9qVRyRBMtsN6aTIg4LfLjRlKbjEdZeraJxC5dnHF5FujKkck7RhCoR7KwX5DR2dbAnHbwTL40gJhAiKFxWv56ag99W0ODp69aWCy4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514370; c=relaxed/simple;
	bh=L43bjFfgihKy+4vf8oM1Usx0+DUY68PolM4IN2cmVzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZU8ZUuKUVZL6rQofWPRi/n0g4NtsxAbOkYO8Jy7VlUZfLiEPT6K85YKqSra/yct4varIZ+greD8aWW4kIAifEiHpnDzQLdD7TtCYyDLufRbvgBDrsu/dOY5SJQBjlvcRqYQS1IjI6Y8Ssboy0mX4tNEnOSUq5a7TQBqkNkiwXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=R1345jFl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SW2lo2UN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="R1345jFl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SW2lo2UN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E311EEC00CC;
	Mon, 11 May 2026 11:46:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 11 May 2026 11:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778514367;
	 x=1778600767; bh=j1ouqsI/sPgERVBxqh6kHDguGj7WluhFQ43gCUs48Yo=; b=
	R1345jFljzYty3osW6kakMxJNUNZ2Dib55QRusP0YEyExUTZV9syUMSXYZQVz7gT
	STuAhkkHpzqFavcIPycsj+0ByFFf2Z1lrsRy/wUD8FCGkAgB26+u67BnHRcmBybI
	Q+c1avuujFCsDxVxAXrgIxSFR+2guucFNXIUpJkBJjdnQH78cilM9F2rGvJd+dw0
	8UqgxBgqr2md8LQl3+wB5W6qHDW1DDiLLRSm1V1SG9/zEGB3Itif8PpNdyUsioDV
	mTpMb3jqJ86gO5gDp4tK36LE/DRJ2ifFJAvVL9icj7wwbvQynPws3AB4SrQyd3Ky
	Ci/8o9jX0N4qY/7etDNlgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778514367; x=
	1778600767; bh=j1ouqsI/sPgERVBxqh6kHDguGj7WluhFQ43gCUs48Yo=; b=S
	W2lo2UN99EW+/0At4f6hYEHCAi6UuyrtNc0a6ksT8U+sec3yA8A2Vb1FozLd7Pxj
	qiLgP9PoKT+g3Ix7C3d7nkGoYKDOgETgIzBn7Ly8dKD4dzL2hplYBUpDrX5IwxiF
	Vg/zA06hV27lqAUQsyYLh9vFSYbxRCe2wJ2OqO+/pEdJpDQEZnO8uUvE/GJchQVe
	/gcGvVZu4cQTFYc7Jcnk8ffGWNoFqLEIRrpJP55i5vkp115HYbQeni8Ao0y7QXzx
	olz3CeFn0jTsZVOHfg8b60tneqnpTsZoaBZt9tAi6HNNhZ/yon6KDjBG+IMU4F0c
	BW9HAzivnGptQo8hpxl+Q==
X-ME-Sender: <xms:v_kBavq1V0e3guLTBCLn_zVALXSRVgaabAU_y8PAwTZAl55c685q2Ew>
    <xme:v_kBakk2f0u1vLevlR6Ld_4SxkStuK4jjgiySAN0JjBf17htCUige1MlJwLtslRH9
    YB-Z-blpfBzyos_0Wgt-QRv6GYBGpb6C8iyRFcI-WINMh59Ac9o6Q>
X-ME-Received: <xmr:v_kBarMpRNcJZ7KAl_p3FswqKiDJDTPGSGyWFIuXf3cOReOzAT9kMUHBST8iGsONRxTqw0kj7BUcK4Qa2WIgpVQehE5WIvOUesXh4a8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeuteekleeifeegudefheetkefh
    jeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpth
    htohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheprhgrmhhsrgihsehr
    rghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:v_kBaoOXTo_vwAkANAfzjlZthR78ZEgb3M0xPjoj0lGHcvWIUJ7e-Q>
    <xmx:v_kBasgQntJPZ9UI88DqmdUpf1TiAlgqng-8w_I_CpbPIb1y1TZF9w>
    <xmx:v_kBaltDcCdYpAdEfJTfGA-sfg5GFJSMSsB-05YLP6pJ8W3a4f874A>
    <xmx:v_kBaiRE6fBkLPPZSa4UgCnqz8-HlgdzlJdVyp7RBDJ3BHqbzHyMLw>
    <xmx:v_kBajAwPjpoBgGT2PspHVrsVz-DV0l1cD7tRHpW7sFOraJtiwA55jlD>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 11:46:05 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	ben.knoble@gmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 0/5] format-rev: introduce builtin for on-demand pretty formatting
Date: Mon, 11 May 2026 17:45:44 +0200
Message-ID: <V5_CV_format-rev.6c9@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V4_CV_format-rev.6aa@msgid.xyz>
References: <V4_CV_format-rev.6aa@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

(Subject from v2: name-rev: learn --format=<pretty>)

Topic name (applied): kh/name-rev-custom-format

Topic summary: Introduce a new builtin for pretty formatting either (1) one
revision expression per line or (2) commit object names found in running
text.

See the last patch for the motivation. In short there isn’t anything that I
have found that lets you format however many commits you want through one
process (so looping over `git show` is excepted).

The other patches prepare for this change.

§ Changes in v5

Notes from patch 5/5, all doc changes:

    • Fix definition list mistake
      • No blank line between the two modes
      • Also replace `::` delimiters with `;;`. This is not strictly
        needed since the definition list is inside an open block. But
        it is consistent with all other definition list in definition
        lists I’ve seen. (The command option section is a long
        definition list.)
    • Rewrite part that I was unhappy about regarding
      `--stdin-mode=text` and `-z`:

        https://lore.kernel.org/git/c04d9cf9-e6a9-4e12-8025-9baededfdafc@app.fastmail.com/
    • Replace `abcdef012...` with just “some object name”. The object
      name is arbitrary and my AsciiDoc output seems to do some weird
      things for `...` inside backticks for HTML.
    • Replace “this problem is just another” with “this problem
      *is solved* with...”

§ Link to v4

https://lore.kernel.org/git/V4_CV_format-rev.6aa@msgid.xyz/

[1/5] name-rev: wrap both blocks in braces
[2/5] name-rev: run clang-format before factoring code
[3/5] name-rev: factor code for sharing with a new command
[4/5] name-rev: make dedicated --annotate-stdin --name-only test
[5/5] format-rev: introduce builtin for on-demand pretty formatting

 .gitignore                        |   1 +
 Documentation/git-format-rev.adoc | 215 +++++++++++++++++++++
 Documentation/meson.build         |   1 +
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/name-rev.c                | 300 +++++++++++++++++++++++++++---
 command-list.txt                  |   1 +
 git.c                             |   1 +
 t/t1517-outside-repo.sh           |   3 +-
 t/t6120-describe.sh               | 208 +++++++++++++++++++++
 10 files changed, 706 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/git-format-rev.adoc

Interdiff against v4:
diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index 436980012bc..c40d52e9f6d 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -25,13 +25,14 @@ OPTIONS
 	How to interpret standard input data:
 +
 --
-`revs`:: Each line or record (see the <<io,INPUT AND OUTPUT FORMATS>>
+`revs`;; Each line or record (see the <<io,INPUT AND OUTPUT FORMATS>>
 	section) is interpreted as a commit. Any kind of revision
 	expression can be used (see linkgit:gitrevisions[7]). Annotated
 	tags are peeled (see linkgit:gitglossary[7]).
 +
 The argument `rev` is also accepted.
-`text`:: Formats all commit object names found in freeform text. These
+
+`text`;; Formats all commit object names found in freeform text. These
 	must the full object names, i.e. abbreviated hexidecimal object
 	names will not be interpreted.
 +
@@ -53,8 +54,12 @@ commit object name is left alone (echoed).
 	of newline. This option cannot be negated.
 +
 This is useful if both the input and output could contain newlines or if
-the input could contain _NUL_ characters; see the <<io,INPUT AND OUTPUT
-FORMATS>> section.
+the input to this command also uses _NUL_ character termination; see the
+<<io,INPUT AND OUTPUT FORMATS>> section below.
++
+The mode `--stdin-mode=text` can have use for this option when it needs
+to process input like for example `git last-modified -z`; see the
+<<examples,EXAMPLES>> section below.
 
 `--null-output`::
 `--no-null-output`::
@@ -70,8 +75,6 @@ This is useful if the output could contain newlines, for example if the
 	default is `--no-null-input`.
 +
 This is useful if the input revision expressions could contain newlines.
-It is also useful if the input could contain _NUL_ characters; see the
-<<io,INPUT AND OUTPUT FORMATS>> section.
 
 [[io]]
 INPUT AND OUTPUT FORMAT
@@ -90,16 +93,13 @@ acts as a _terminator_, not a _separator_. In other words, the final
 line or record is also terminated by the terminator character.
 
 The mode `--stdin-mode=text` replaces each object name with the
-formatted commit, i.e. the format `%s` would transform the object name
-`abcdef012...` to `<subject>` without any termination. Like this:
+formatted commit, i.e. the format `%s` would transform some commit
+object name to `<subject>` without any termination. Like this:
 
 ----
 Did we not fix this in "<subject>"?
 ----
 
-Regarding input in this mode: using `-z` or `--null-input` makes sure
-that _NUL_ characters in the input are passed through correctly.
-
 It is safe to interactively read and write from this command since each
 record is immediately flushed.
 
@@ -202,8 +202,8 @@ not a good fit for the above use case.
 
 In short, it is straightforward to use these two commands if you use one
 process per line. It is much more work if you just want to use one
-process, but still doable. In contrast, this problem is just another
-shell pipeline with this command.
+process, but still doable. In contrast, this problem is solved with just
+another shell pipeline with this command.
 
 SEE ALSO
 --------
Range-diff against v4:
1:  9cb5cfd1ec3 = 1:  9cb5cfd1ec3 name-rev: wrap both blocks in braces
2:  14900271321 = 2:  14900271321 name-rev: run clang-format before factoring code
3:  724ec022894 = 3:  724ec022894 name-rev: factor code for sharing with a new command
4:  382efc3ddb8 = 4:  382efc3ddb8 name-rev: make dedicated --annotate-stdin --name-only test
5:  049a45e32bc ! 5:  425eb16728c format-rev: introduce builtin for on-demand pretty formatting
    @@ Documentation/git-format-rev.adoc (new)
     +	How to interpret standard input data:
     ++
     +--
    -+`revs`:: Each line or record (see the <<io,INPUT AND OUTPUT FORMATS>>
    ++`revs`;; Each line or record (see the <<io,INPUT AND OUTPUT FORMATS>>
     +	section) is interpreted as a commit. Any kind of revision
     +	expression can be used (see linkgit:gitrevisions[7]). Annotated
     +	tags are peeled (see linkgit:gitglossary[7]).
     ++
     +The argument `rev` is also accepted.
    -+`text`:: Formats all commit object names found in freeform text. These
    ++
    ++`text`;; Formats all commit object names found in freeform text. These
     +	must the full object names, i.e. abbreviated hexidecimal object
     +	names will not be interpreted.
     ++
    @@ Documentation/git-format-rev.adoc (new)
     +	of newline. This option cannot be negated.
     ++
     +This is useful if both the input and output could contain newlines or if
    -+the input could contain _NUL_ characters; see the <<io,INPUT AND OUTPUT
    -+FORMATS>> section.
    ++the input to this command also uses _NUL_ character termination; see the
    ++<<io,INPUT AND OUTPUT FORMATS>> section below.
    +++
    ++The mode `--stdin-mode=text` can have use for this option when it needs
    ++to process input like for example `git last-modified -z`; see the
    ++<<examples,EXAMPLES>> section below.
     +
     +`--null-output`::
     +`--no-null-output`::
    @@ Documentation/git-format-rev.adoc (new)
     +	default is `--no-null-input`.
     ++
     +This is useful if the input revision expressions could contain newlines.
    -+It is also useful if the input could contain _NUL_ characters; see the
    -+<<io,INPUT AND OUTPUT FORMATS>> section.
     +
     +[[io]]
     +INPUT AND OUTPUT FORMAT
    @@ Documentation/git-format-rev.adoc (new)
     +line or record is also terminated by the terminator character.
     +
     +The mode `--stdin-mode=text` replaces each object name with the
    -+formatted commit, i.e. the format `%s` would transform the object name
    -+`abcdef012...` to `<subject>` without any termination. Like this:
    ++formatted commit, i.e. the format `%s` would transform some commit
    ++object name to `<subject>` without any termination. Like this:
     +
     +----
     +Did we not fix this in "<subject>"?
     +----
     +
    -+Regarding input in this mode: using `-z` or `--null-input` makes sure
    -+that _NUL_ characters in the input are passed through correctly.
    -+
     +It is safe to interactively read and write from this command since each
     +record is immediately flushed.
     +
    @@ Documentation/git-format-rev.adoc (new)
     +
     +In short, it is straightforward to use these two commands if you use one
     +process per line. It is much more work if you just want to use one
    -+process, but still doable. In contrast, this problem is just another
    -+shell pipeline with this command.
    ++process, but still doable. In contrast, this problem is solved with just
    ++another shell pipeline with this command.
     +
     +SEE ALSO
     +--------

base-commit: 67006b9db8b772423ad0706029286096307d2567
-- 
2.54.0.13.g9c7419e39f8

