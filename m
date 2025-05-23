Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F233429CB5C
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028726; cv=none; b=RpoCCAeZXvKT1e9d32+PR39icld0ZRQg258r9IfHxV4Y3G+KDrFZuD8JRq4ZhXzacytq5Li5UPNJlVRQ0v9rn8gJsI5NszyfwwZmohWs1bnjYB9sQMDdwWyl/O8cW6zn+1Em2uJOeEE2U9jzM5uQxmdQDgR0iaCth4Z6Foss3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028726; c=relaxed/simple;
	bh=Y/MLXhldS0AzWO3FyjVYZJ7TK027zrhF8jdikj9zQc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxhL4mVKZSF77txor0wwsq9BwblA+SnhUtZWq35lKRrMf7zBIF7+BE/FYt8vILvIr5yxVhZ0kV8VZg4f4NmpG7kFmgCxlOYtc8yQWb4JgT6/tFYHekzEUM2/x0w/GJ6W6LZToWBrEE68c2XzmvGl8USvizjamTT6h+Ui9S7BKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Z0c93obq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WB0bwvf6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Z0c93obq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WB0bwvf6"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E3B011400C7;
	Fri, 23 May 2025 15:32:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 23 May 2025 15:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748028724;
	 x=1748115124; bh=nHv+6J9Fo5s37OJLIBJXaMS0bXcF7A4npW99YAhrsKo=; b=
	Z0c93obqNL12ysem8eZqX2nA51gISFzLpiNb2KsLckvBxEdI9h0bjRrsfKrkZrEX
	HMOq7elTGN5uyFmS9D2XMd0ShHYnue85qM0C19UsRKLQ+VZzq/Vch24sxIxDcHfX
	9Rai2U06HhNwOOx2U9LZh9Na1DfOT+JDHI4Q54SFnk2D1VYTRnoXtfshL63rhMzm
	C4jUz89tyUdN4+PSCikGKrerJJXhtVj1FAJ3rQDq3WkSi5QBzGfZ8+7yUzUbNLPM
	OFXTQO+7pIKCJpYuLoDoC4M/oaxoSBIHVR5faak4S6A1JHZgpEF/zNNJ1JhBNadg
	iGzpbQ1tHDeC4fsiZ2pZwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748028724; x=
	1748115124; bh=nHv+6J9Fo5s37OJLIBJXaMS0bXcF7A4npW99YAhrsKo=; b=W
	B0bwvf6ivngE8NMcP0AcwjgUeQXnzMDi1dR5mcc5s44mmOwGWLPH2Stf912Rz6k7
	DwIqJdEkXjfPMhAimj2X50jC1ba9jlueN06DE4OC3rSJ1U3HtMJ/EXaIFvfe6O6Q
	hzIpUKa8MlwyQ6VtyN3bVGys/0vScmt1rpqeAmdBeleZvlbG1Tuzb94zk5G9Y4ue
	rWV3CuvqhsjPzCWyHCoRCGSvR0YM/K4nvNmpMKTrJPUuAGy7NLEw7WSoh9bugBVP
	9Rfqt+hDl6tDczr5TqWJscYinhxmi9vPrhv/YVsX+SY+QJDHFRDsOI52v2Td+Auw
	l+8dqOMRn7CDIflBw68hg==
X-ME-Sender: <xms:M80waA_WLLzyQZDw1mWUlohzNJzLU82NV8E603hrttC6rAnwFIowjvU>
    <xme:M80waIu6Mgdj99itM9WM6yXSMPhjmdaYFtOLO3mSxznra_hg0dxAgMa0tSIl3zM8w
    VHW1_AVvbiIcnlUDg>
X-ME-Received: <xmr:M80waGCnth3ZzS6X9QVUzCjhmMSy-70mgAJWkJasWnMqrMRqFRMmpAjxUtp8Vnp_LPt0BQXqENDigQJqO5X_xLx3R4hhonB2NsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeljedtucdltddurdegfedvrddttd
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
X-ME-Proxy: <xmx:M80waAfwiJLXmnGT_h8neoj2NiUh16VCS21JnoenDY4qoNozOe_t_w>
    <xmx:M80waFNBrACsy5-SIq3FsPfZkZBpzwIp7Qcn3KHdhodrCj1YnzYf-w>
    <xmx:M80waKn-cr8tY82jfUzfLS0EqQJz2qy3CX1S2xLdhO7ASn0CKLcHJw>
    <xmx:M80waHvVK5leVC_--Z_Cc1DZkKi3D8h3JQbcX5-2Lct1zr-pLFjNAg>
    <xmx:NM0waCYfxJFotk3oMaWuyS9YRnftIZ9KxsepmrtpoDSeT4tq0ENbgBIP>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 15:32:02 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 4/9] doc: notes: rework --[no-]stripspace
Date: Fri, 23 May 2025 21:29:50 +0200
Message-ID: <c68a91f81ba180acb1025b229dee3d1e61691e75.1748028010.git.code@khaugsbakk.name>
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

Document this option by copying the bullet list from git-stripspace(1).
A bullet list is cleaner when there are this many points to consider.
We also get a more standardized description of the multiple-blank-lines
behavior.  Compare the repeating (git-notes(1)):

    empty lines other than a single line between paragraphs

With (git-stripspace(1)):

    multiple consecutive empty lines

And:

    leading [...] whitespace

With:

    empty lines from the beginning

Leading whitespace in the form of spaces (indentation) are not removed.
However, empty lines at the start of the message are removed.

Note that we drop the mentions of comment line handling because they are
wrong; this option does not control how lines which can be recognized as
comment lines are handled.  Only interactivity controls that:

• Comment lines are stripped after editing interactively
• Lines which could be recognized as comment lines are left alone when
  the message is given non-interactively

So it is misleading to document the comment line behavior on
this option.

Further, the text is wrong:

    Lines starting with `#` will be stripped out in non-editor cases
    like `-m`, [...]

Comment lines are still indirectly discussed on other options.  We will
deal with them in the next commit.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • New
    • Together with one other other patch replaces v1 patch “doc: notes:
      mention comment character configuration”
    • I figured out that mentioning the comment character/comment lines
      doesn’t make sense here.  So all attempts to rephrase “comment
      character” or “lines that start with `#`” are gone

 Documentation/git-notes.adoc | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index 8706b33f2ee..d672794a942 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -184,11 +184,13 @@ OPTIONS
 
 `--stripspace`::
 `--no-stripspace`::
-	Strip leading and trailing whitespace from the note message.
-	Also strip out empty lines other than a single line between
-	paragraphs. Lines starting with `#` will be stripped out
-	in non-editor cases like `-m`, `-F` and `-C`, but not in
-	editor case like `git notes edit`, `-c`, etc.
+	Clean up whitespace. Specifically (see
+	linkgit:git-stripspace[1]):
++
+- remove trailing whitespace from all lines
+- collapse multiple consecutive empty lines into one empty line
+- remove empty lines from the beginning and end of the input
+- add a missing `\n` to the last line if necessary.
 
 `--ref <ref>`::
 	Manipulate the notes tree in _<ref>_.  This overrides
-- 
2.49.0.780.g892193c3f50

