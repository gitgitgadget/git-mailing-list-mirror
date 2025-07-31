Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB001E567
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753943995; cv=none; b=jiXvWWH/my0nltNehNPEltxc1VIF4SDe4vyMyMV0GeS2b49U88W1UfZ6QiqPg0+oXNMtXD253DsjNglJIUsZaCDK7gtcIAdTlcVOpW1YsdZV8xpO6U+PCnsILBUJSRJObD16FDPIr4/HjJCdGzxDnvEB3Uu9J5cOg4qJRd7M+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753943995; c=relaxed/simple;
	bh=2pJSJHG3BHUcRbW/FheH42b8iZVA8WyHcQJAlIAZKc8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ipd7+5IYq8fJtq5v0uyQcdtaxpA3PyTUCgE4+xhsq7Gq2l/Dx3kRjXZEL33Nuj1Dpdcgg+eopkSX0xxqiONxKzHRoSXXgZIATaGihESVrx/PJvY+WjbglFWJ/Cv7WWmElOJt6yLYdNHeWuTpX4xDGZexDyamEIThp15YmfTH0HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l2TvJ8p7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=joFG57TV; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l2TvJ8p7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="joFG57TV"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CF0A47A097E;
	Thu, 31 Jul 2025 02:39:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 02:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1753943991; x=1754030391; bh=AuJpzep4Uno90LOhPnATb
	lN/uLIfkqY17X3QQ/ZATAY=; b=l2TvJ8p73/D6c8ivqeyrXTp4/8u81JwI6/d+a
	DU4wIp/6ZMMbiae4HTcGcLTxkiCGuCl2giKP2k5txzujlsGO4YteMDAhPic5wjuU
	0RzGlZnu5mw7zm3rfxf3CGpq1Rp5GHmzUQZ815IIdAVgzxYlEk0da/WFkEb5Vanc
	MKDjVyyOED3EQX7fC0eSfXt//A9mqDmZnE5sDjitfedjtLsY1OnBkvqnPDHIKcQz
	K9qNHQSfa/rfqgkUi2pMl0beBeaACgLzF7Ju9CbLClUHITedP9kVaMz+YCkrtB9+
	9kVOs/l1nFKtqaoZtZHUPo4TYosPEA2uMC7EnG8uyLecejIVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753943991; x=1754030391; bh=AuJpzep4Uno90LOhPnATblN/uLIfkqY17X3
	QQ/ZATAY=; b=joFG57TV3eZy4nHq189qyFEhzvHg4moje0whYEJ4byOu4KHS7Gg
	c3Gbdc6MErPGBerkrHXo+WU6IG2z528HDecKI+o3wyAC5MoW6A32LOauIIHqqbB5
	oS7bpjyetbdJexrzSpfWvq+Tb1+silmg6aFXoIKdPbZ5BQf5j4Vi9AHxHBXS3R2I
	VDKleWqn7y/93Gl02RUOVN/hjXJre/4oNTd9AeCQf/AB9MR/Jbwix6WsdDCkVsss
	DYQbRgUh0sD9hk2HDcilADAiZxY5idjs/PQTCjqPZr7VuqGMJMFIhMjfEidUG4EW
	Mo6fKazS7Ju3x3Qrm9lx7ESTX3vC6ZrCtgw==
X-ME-Sender: <xms:tw-LaO692vWxhHmmcwgPNp_kZ4AZZ1SafSje4eZOnXTdKnsXG1ombg>
    <xme:tw-LaIGod-TdCQhLNMAZG84QmGgkl52dLdQHJZ_ZwCMUCwtfSfelT7LY3a7z2fmBw
    YDbuHPEKtuVbBOV8w>
X-ME-Received: <xmr:tw-LaPTtHCXzois5UvVDxMZiBuZSUYr9do7vKLgfuBX1E2a2JH50mZEY_Uk484oO3MAl2NbQmqRdLQkwFxn69Ugz6ZAuKC5mlKLC-Fs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepfeelveduffeltdejgfdvueevgefgveelud
    ehtddujeetgeffieeljeeuieethffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:tw-LaJsG0akK5MUjUapblYZhPE6CGKfL9-VGBEsyItXgRe3jNe-WJA>
    <xmx:tw-LaGz9ajiTvm5iW_NGpGOxJcdhhsQvg0dA8qN9Qz4M5xqTBs2cQQ>
    <xmx:tw-LaL6hYUhCCzKXEj6QsbPBD-1myDD6m8x4IU5fbVi_6prX5udwmQ>
    <xmx:tw-LaIWJ3Bm2A48-WBtdHYlLqKCpUcO8967p-cLXdnxKypWftNYx0g>
    <xmx:tw-LaJdIF6nxoJD9Mxa8sDxjzJ0-qHYKvGWPaUCY6Zovl4oJqp0XiZtA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 02:39:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/5] string_list_split*() updates
Date: Wed, 30 Jul 2025 23:39:44 -0700
Message-ID: <20250731063949.1601669-1-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-612-g4756c59422
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two related string-list API functions, string_list_split() and
string_list_split_in_place(), more or less duplicates their
implementations.  They both take a single string, and split the
string at the delimiter and stuff the result into a string list.

However, there is one subtle and unnecessary difference.  The non
"in-place" variant only allows a single byte value as delimiter,
while the "in-place" variant can take multiple delimiters (e.g.,
"split at either a comma or a space").

This series first updates the string_list_split() to allow multiple
delimiters like string_list_split_in_place() does, unifies their
implementations into one.  This refactoring allows us to give new
feature to these two functions with a single chnage.

Then these functions learn to optionally trim the split string
pieces before placing them in the resulting string list.

An existing caller of string_list_split() in diff.c trims the
elements in the resulting string list before it uses them, which is
simplified by taking advantage of this new feature.

Junio C Hamano (5):
  string-list: report programming error with BUG
  string-list: align string_list_split() with its _in_place()
    counterpart
  string-list: unify string_list_split* functions
  string-list: optionally trim string pieces split by
    string_list_split()
  diff: simplify parsing of diff.colormovedws

 builtin/blame.c              |   2 +-
 builtin/merge.c              |   2 +-
 builtin/var.c                |   2 +-
 connect.c                    |   2 +-
 diff.c                       |  20 +++----
 fetch-pack.c                 |   2 +-
 notes.c                      |   2 +-
 parse-options.c              |   2 +-
 pathspec.c                   |   2 +-
 protocol.c                   |   2 +-
 ref-filter.c                 |   4 +-
 setup.c                      |   3 +-
 string-list.c                | 113 +++++++++++++++++++++++------------
 string-list.h                |  26 +++++---
 t/helper/test-path-utils.c   |   3 +-
 t/helper/test-ref-store.c    |   2 +-
 t/unit-tests/u-string-list.c |  80 ++++++++++++++++++++++---
 transport.c                  |   2 +-
 upload-pack.c                |   2 +-
 19 files changed, 190 insertions(+), 83 deletions(-)

-- 
2.50.1-612-g4756c59422

