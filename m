Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270AC27EFF7
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417867; cv=none; b=SiSPhICKzzEzpM9/oNn+yYqFVeB7B+Mj15/yvmjl6lxHh4Wb65eQQYEvb2Xw2ZyfPThMHe86PcrnWIE+4yRj3bkPen57p+n1xwGY+DIeBJvWvK3QpFPNRtiX8rAACO44tucrFpTCVIkeZDV7FKbsTXu2TdIz/w8CZtSiQUFv1iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417867; c=relaxed/simple;
	bh=7a6AfuMUu+NtH5xh5xDkSlMVkBJmMK7bnGdrKJ/QIkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wn3EXe9l80JL8gOItK2TOd80gomMe1cG8i2Ce3IH9Qvbt2Reifgw3jirqWRZ0PhDQtUKQ1UalUC7SCtGXTePdGU4fDdTg93FnpXoghFIbsQxtTIuBdKAUwcTb3lnspciITW5ywGRoJB2lXUbv9qjVTua3ydREd5PFq2qgkiQWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ejEa3EPN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q/EMuatj; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ejEa3EPN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q/EMuatj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B5641D001A4;
	Fri, 13 Mar 2026 12:04:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 13 Mar 2026 12:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1773417865; x=1773504265; bh=2/
	iZIQ4xtJFz0af4xR3kK/TTAbCedWE8sykL2BMgr/I=; b=ejEa3EPN4KlxCUZ6uj
	p7EuyaPW+Bp5h8xz4NpbEvzgXNQAoGL4Quojb1jR6yOcUEtUKo4FuaWGKeMlntp0
	8J8yyIG7G+brCHt/eHmF+oBHtFdObn1dpKY52YEldr+MFAsl6Hli9+KH4LZyyrbD
	WlJt0REkdjvPwQnf9rS8K5kTitwTJaCdj1SKnDC1VeEhJ5i86UHuc1UCHpTeSKrX
	0HYjecS+1SzQp6GQlQWUZfiYzbq/nHnU/qWsBbbZ8tYhfbisJBcyfkkquBKJxbTi
	w8BoT1v6SyumOsa0Sk9V1q/m4AxMorgQ1xm8CgsQWBbJvrMVA9/q6iEhrsT7X7ha
	Dcwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773417865; x=1773504265; bh=2/iZIQ4xtJFz0af4xR3kK/TTAbCe
	dWE8sykL2BMgr/I=; b=q/EMuatjxJo6dotjdkAyB7lD8A+pSz0Ho0ineA4hAF/0
	IcpiDwwsf8Aa+v2VxpBjd054AWa1fFGZvY1nhegn1kR2trulanpDSDFDe/sdFU26
	uiX6kk5SRhYhCpiRznyVLUcbU85P7WDe97frt9913rSSDlAv3J/Bt4wYbOIE6cL+
	GoPmQ036fkrh+vbGp0GtkBndWvdR52sQfRTQtwvL6X0Sb+3BLpwKQD6teJbS913F
	qiCvMg8+KyOrvPZCLZP8TyVc5MdyvIDxDQSZZOXNe6uQJCKtef8gETUmcRo4Xp2/
	Av2UEYyeWMeC+QbORjb3zi+2U/WNj1Yy92q//e4irQ==
X-ME-Sender: <xms:iTW0aWFRWZfiMjMGK3lABiTaNg0O2u9yCJUWaZEkG4bquRwF_k0IK0Q>
    <xme:iTW0adVrJKwYjhYyCWbwA89KyhC4XyeMecXi_FR4nMapkpUcwFUCuk4FVX67ES4_D
    kjpi1ubBsCPXuRY0nj4jgVpH2K4xUQ_TVnII7HJYyMQfgbGudWKxS4>
X-ME-Received: <xmr:iTW0adw9CFfKBRMjgelc4c1jE1vK6bocfjFB1XNYb5fAuXfKFFudaPZpHXYa70Gg7LBD5orCRxkq6_O-g3Z1bQSR7ie8e1GzcM5dKhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledttdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejff
    dufeefffegkeevgfevvdegffeujeejleegudfhtdffieekleefhffgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:iTW0abNHwGxMiXNWJnY9ME0XnhgqrMJs3VZLycm3cHqqFjjmyLHsPw>
    <xmx:iTW0ae7WE0sh7owH29ooNzvcrvvkhAxFjxvRtNYCfd7J4mSA7v09PA>
    <xmx:iTW0acNCjO9WWZz2E8E1ceypccHrt-xY9WW0uGfe_LZcB1nmsrxG0Q>
    <xmx:iTW0aclRDIQ7oP0WQTVvA5YYNTooi0UKGk1XRCQVjMvDLB_6yXKXuQ>
    <xmx:iTW0aRekf8WdGYus6bCntYmNoKRcjRbkNshO645zP2F9RoFuJHA2xdvk>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 12:04:24 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 0/2] name-rev: learn --format=<pretty>
Date: Fri, 13 Mar 2026 17:03:36 +0100
Message-ID: <CV_name-rev_--format.4ad@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/name-rev-pretty-format

Topic summary: Teach git-name-rev(1) a mode to pretty format revisions
instead of outputting symbolic names.

(See the second patch for details.)

The first patch is just for `CodingGuidelines`. Unrelated.

I have gone through three approaches: pretty print, `log-tree:
log_tree_commit`, and pretty print again. At first I was confused
when using `pretty_print_commit` because I couldn’t seem to get the same
output as git-log(1):

    # for git-log(1)
    git log --format=<pretty>
    # for git-name-rev(1)
    git rev-list HEAD |
        git name-rev --format=<pretty> --annotate-stdin

Because there were some minor differences for a few things I tried:

• fuller: log has the `commit <commit>` header; pretty does not
• oneline: log has the oid; pretty does not

Then I tried `log_tree_commit`. But then I got some things that I didn’t
want. This function also didn’t fit in with the git-name-rev(1) processing
since it just dumps straight to standard out instead of allowing you to
accumulate things in a scratch buffer (strbuf). So then I went back to the
`pretty_print_commit` approach.

Notes are handled by reading the display refs. I can imagine that it would
be better for this command to use `--[no-]notes` arguments like the ones
that git-log(1) has for explicit control (without using env. variables).

[1/2] name-rev: wrap both blocks in braces
[2/2] name-rev: learn --format=<pretty>

 Documentation/git-name-rev.adoc |  9 +++-
 builtin/name-rev.c              | 85 ++++++++++++++++++++++++++++-----
 t/t6120-describe.sh             | 58 ++++++++++++++++++++++
 3 files changed, 139 insertions(+), 13 deletions(-)


base-commit: 67006b9db8b772423ad0706029286096307d2567
-- 
2.53.0.32.gf6228eaf9cc

