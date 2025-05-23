Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457622BCF45
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028730; cv=none; b=oeiLKG9dollRgGHWFEmsiMD3WYz3bSjRNBfqihoTB2SJyDag/nCkYUwxOe89OuoIAA0WdwMNo9X/wM0kTtrBfKwc0CJ9g9+t5A/NN2V/9CxGBO9Fy4vS85+0J5nPl6O7t3txK6yXJeMe4Lpe248xHU1a4/nSLj7kZItCfbvKLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028730; c=relaxed/simple;
	bh=Jn0bW95eb7+3q8YMPtjsseqDLNI9VM4/4QemWNOY1Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtbmM/oIeSF7lZtlLBZcyZyBYruDEf0PFqqK54VIsxOsqgkafrw7iyuBJQZ4fKfsh3cy85F9YhTwJe2PSmi9KOdp0xkSGMm9sQiZjxvopyj0NemdTn0RUuYK3XUmO2r/X2kGe0udvBlR+G0lbGkz/o4IKjfnrfQIV03YF9PaUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=3GlPTNHI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZlWYpego; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="3GlPTNHI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZlWYpego"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F9181380289;
	Fri, 23 May 2025 15:32:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 23 May 2025 15:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748028727;
	 x=1748115127; bh=DU7EUSySFXsAUUUtVDKwmhibkeRWcVlerdLH2FUS5ds=; b=
	3GlPTNHISNAdq5gS+j8pnOF7VGcrU0UHlb2OjQa7w30KvEKwZ0N8o81nFqJhzOFo
	BMYwfA0Uv5vaizJhNZ+mQBSiMxK8hriO4/10sHzApmVALW7mYSKNBXQhioRpLZBN
	zFOB6o3xWb2KV8yNCawer7GQP+F0rCRyRx1I9nQ7BM2DcMzzvvzKzqxFSpCxWO4B
	incgl+Pan0k0SA0+f2zPv/gVeVdBXhyzKIvQJ5AS1iU2XLJkdYRn4u/jOuYWn/nT
	mOYhFGKs7Z3ufkFgp8S0e2bfuz2KgMxouxMPQrEB/cPJ3zEIADEO/ObvMb72v6Q2
	unPrwxuoZQPmY5vWPIp3wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748028727; x=
	1748115127; bh=DU7EUSySFXsAUUUtVDKwmhibkeRWcVlerdLH2FUS5ds=; b=Z
	lWYpegox1l1bO1gggHcPhVCbBAYJ7wptCDTst1Nq+qoy4q/e/4sQ+GJP0gNJQgHS
	OHVC+IGgEt0jhM66lToO8zd6f4D6zB1rYsqIhnEJ1oKph9BJ7YOxEPv0051G+v6o
	h0+KrHO6RMrdzkQViml/oMFLcxwc8/pvWUEa1g+OpytWkB7PGyV+zs8/crMc9a3X
	AkQrR/ZHbCV6hfDQ6XgO64IuyK+Rgi/Ojnv3cmWQiCT642taeVQReP0aZDtMhVFJ
	aygaT+Ptd2XfOBvUQ3w+v8jGS7MWZ/pYxmNLZj7odHf7bes6ys/baqgJkF6avSgY
	2/5sC0IS+syFC0PNX3jSg==
X-ME-Sender: <xms:Ns0waM3lDMDvrCOpaMaV6vsjrb8q-wX1iekLf-EnGfhYqnSDSiV-tos>
    <xme:Ns0waHEi5kJi1FdLxSDDSubGnW2QkMjlC5M6yZDQIGWFhNolDJsjcUIywhxfRJWzD
    mmmdGteyBrcJ5uFuA>
X-ME-Received: <xmr:Ns0waE6IevR7z8QfHzSiEg4zH32ZH82terhnOuN7ZwTg23-9ffiftj5yXM26m3P21daqiFgl55RGVa1ZjgPEetkyg_7ohfRqP5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelieelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeek
    gfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepugihrhhonhgvthgvnhhgsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:N80waF2Jbb8VFbS0ZwrKCO9-6x5hbpI5gduZxjTn-fUh0piXCxlYrA>
    <xmx:N80waPHODG8Hlb_3Jvl7MopkxJJsOsvImOL21oe40pLicU2j7q-AXw>
    <xmx:N80waO8-cw__EROpGKTQCNNpORpnw5hbxh-hk09ZliuYkIZzSKb55A>
    <xmx:N80waEkXjtdxu3AufS0SNb3veL2d9RnE0RnmE8DFYujEa5J15F9K6w>
    <xmx:N80waPrr3y-OkDkwqs10Ef1UZ9ZlxLoOUnbTYmBc1UAQ4yMREJbHNyNk>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 15:32:05 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 5/9] doc: notes: remove stripspace discussion from other options
Date: Fri, 23 May 2025 21:29:51 +0200
Message-ID: <f4755040f38170b508e9cba03a7226b5b4d5cd9c.1748028010.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748028010.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name> <cover.1748028010.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Cleaning up whitespace in metadata is typical porcelain behavior and
this default does not need to be pointed out.[1]  Only speak up when
the default `--stripspace` is not used.

Also remove all misleading mentions of comment lines in the process;
see the previous commit.

Also remove the period that trails the parenthetical here.

† 1: See `-F` in git-commit(1) which has nothing to say about whitespace
    cleanup.  The cleanup discussion is on `--cleanup`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • New
    • Together with one other patch replaces v1 patch “doc: notes:
      mention comment character configuration”
    • I figured out that mentioning the comment character/comment lines
      doesn’t make sense here.  So all attempts to rephrase “comment
      character” or “lines that start with `#`” are gone

 Documentation/git-notes.adoc | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index d672794a942..383e8bca685 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -144,26 +144,18 @@ OPTIONS
 	Use the given note message (instead of prompting).
 	If multiple `-m` options are given, their values
 	are concatenated as separate paragraphs.
-	Lines starting with `#` and empty lines other than a
-	single line between paragraphs will be stripped out.
-	If you wish to keep them verbatim, use `--no-stripspace`.
 
 `-F <file>`::
 `--file=<file>`::
 	Take the note message from the given file.  Use `-` to
 	read the note message from the standard input.
-	Lines starting with `#` and empty lines other than a
-	single line between paragraphs will be stripped out.
-	If you wish to keep them verbatim, use `--no-stripspace`.
 
 `-C <object>`::
 `--reuse-message=<object>`::
 	Take the given blob object (for example, another note) as the
 	note message. (Use `git notes copy <object>` instead to
-	copy notes between objects.).  By default, message will be
-	copied verbatim, but if you wish to strip out the lines
-	starting with `#` and empty lines other than a single line
-	between paragraphs, use with `--stripspace` option.
+	copy notes between objects.)  Implies `--no-stripspace` since
+	the default behavior is to copy the message verbatim.
 
 `-c <object>`::
 `--reedit-message=<object>`::
-- 
2.49.0.780.g892193c3f50

