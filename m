Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C83213E6A
	for <git@vger.kernel.org>; Tue, 27 May 2025 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380821; cv=none; b=L8eiWlhKO74c8Lvo9L8z6SQMfRcrpJgwaGd7bFWApCmaJVb3Gx74OTgcmJKnFFOtv/c5gJK6oA5slpfNUa2dJsHvYcU75iTrSTtpxrJdDxpSeD0nDeshKkpsQX9VwGOjonVfeIyTDM6lessEhFq8uSzUD9c9NI4LEOgdolkoekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380821; c=relaxed/simple;
	bh=xFt3nGyVvLDNv5hYtxeULEgklp0yXxY4tA3DkvJnB2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdNu4YVzOlIv1RT/nyVnXViFKA8HGgB/05xyAUjzLlFodlJe8rkopw166KSqxlqdOfNk6MY/27tolGhGi9cQRp75b4hO1G0He9Z2STGw95GDgH8rru/vLHj+CT/3TztF9V9L/NLevs83Pn+cCthbfLg8YTCL5o0TPnmSWmq+GTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gNL3ZgaQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eU1Jc91+; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gNL3ZgaQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eU1Jc91+"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E53E1140112;
	Tue, 27 May 2025 17:20:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 May 2025 17:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748380818;
	 x=1748467218; bh=Q4ywIed5yAI3RpltCmE5g8samNJzqvNj6CrbF3NEXL8=; b=
	gNL3ZgaQFYkORenVQNJD/H++Q3raWcsRb5SH5ltbzaYhwYWwKfAcriYdfZaY6fZ1
	mcuFbLzV/vEg3pG7f7J8z8WbwpN8BUepVwzCkTRKQ0Jq1IMRjzIrqQ6BrRUT6C3W
	yfLQ2Y0EtEheruhb0qWD9O2qMdjhOABIB66Vf810kVtAJIUp9QKsAWdIg9ih3XnG
	MC4K5wgV+bXf0Dv3MwIXiXA9cqbhRV8S9MM/wn/yBaBZCqkCXilZncyIOTEhGEBA
	Mk3R8RuSHWpxaCoTqXxx4rrGyP3KAQGftXV7oa8Q3YOTqAqS8lbLzt6k3ezc1WHH
	FEN94OBzbq2fBHulvKF/xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748380818; x=
	1748467218; bh=Q4ywIed5yAI3RpltCmE5g8samNJzqvNj6CrbF3NEXL8=; b=e
	U1Jc91+B2LTYySBl9uJW4sU8il7TEy7x7PCksDlFqOcJvlajinudmRkivQS/uLsg
	uEErKM4j4l5lt4ORyMx5cximv6pf+t6VOQ5+GprnwDu9sxgDGDX5fIePZXQPSQX2
	+WYJg1D+E5NYC+uQnpjGtbT/2aTLnEZIBmqZPTakFJVUmdBzavFajR8bRz7aZdsB
	I60UPJ6MdypRxCxLQ1W2/AZRkoiiVCMcebAG+5XApcWcRV83UBmqt/6iClEwiLG2
	N3iovZf4k6c9Hj4ZwZozJyciB4mNORojAvQJk44KO+rvgMha5yzxnVip3LUVoHVO
	miF8pRUGrP+BrY8CrFlmw==
X-ME-Sender: <xms:kiw2aC7XzR61SwrHwTHr8h1KDRpPO5k6s_xrdS91sytKyTQO2u-GyHM>
    <xme:kiw2aL4OVpdpSy0vU1MET8HCYtbsiqCinaTt8PaPa014xFGC4yVT1xlHWKPwgzgEC
    WYv-CIgWx0oJilCSw>
X-ME-Received: <xmr:kiw2aBdTaxMNevfcmeTYKxDXiAjr4x2W7fhPSRuVXGJaOa9KfiFwPZ23dYZukrWmYi2QweaOkiq4vL2AtFgBsSsFckzus7o0ryyBEPttP0_Tybp0H-xE7EFoyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudeggeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeu
    teekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepugihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kiw2aPJ2cIGuFBCWUh3Q6gsqIM-FvYxnyKHzIv6aSSjm9-AHmYQXSg>
    <xmx:kiw2aGLVG-cgfci9b1pRnRz_urQARsbW5WKzDw8jS82d1KHujWkG2Q>
    <xmx:kiw2aAyDzpsUIByOL5oZr95rS8S6yaW4W1tl_1lUqSbC6BvgGesNzQ>
    <xmx:kiw2aKIlWIqVaIORrMpy9qwfBx3Bi-kJeGLiAptt5m2O1DS5EOWZlg>
    <xmx:kiw2aMuuBYOuQPoOnTX2PWx9AXf6CiOQe9EOKxJoO7v1xQgAsCOkg6Ek>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 17:20:16 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/9] doc: notes: clearly state that --stripspace is the default
Date: Tue, 27 May 2025 23:19:35 +0200
Message-ID: <184cf032abf477eae06cd1b9f44da0ddab27b44e.1748380390.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748380390.git.code@khaugsbakk.name>
References: <cover.1748028010.git.code@khaugsbakk.name> <cover.1748380390.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Clearly state when which of the regular and negated form of the
option take effect.[1]

Also mention the subtle behavior that occurs when you mix options like
`-m` and `-C`, including a note that it might be fixed in the future.
The topic was brought up on v8 of the `--separator` series.[2][3]

[1]: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/
[2]: https://lore.kernel.org/git/xmqq4jp326oj.fsf@gitster.g/
† 3: v11 was the version that landed

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Mention that it is a bug (“known limitation”) which might be fixed.
    
      Link: https://lore.kernel.org/git/xmqqiklrvwl4.fsf@gitster.g/
    • Message: discuss this new “subtle behavior” part
    v2:
    • New
    • The `--` are to prevent the new paragraph from becoming a continuation
      of the last bullet point
    • Junio pointed out that I didn’t go over the part about checking
      which variant (regular or negation) are the default.  See the link:
    
      https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/
    
      I decided to do this on this series.
    
      Link: https://lore.kernel.org/git/xmqqfrgzhzbp.fsf@gitster.g/
    • The last part of the paragraph is based on the commit message of
      c4e2aa7d45f (notes.c: introduce "--[no-]stripspace" option,
      2023-05-27).
    
      See the review on the patch:
    
         https://lore.kernel.org/git/xmqq4jp326oj.fsf@gitster.g/
    
      There was concern about the order of options:
    
          >     ... One more thing need to note is "the order of
          >     the options matter", [...]
    
          This sounds more like a design/implementation mistake that we may
          want to fix.
    
      This new part is supposed to address that.

 Documentation/git-notes.adoc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index 383e8bca685..ef5a939516e 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -179,10 +179,19 @@ OPTIONS
 	Clean up whitespace. Specifically (see
 	linkgit:git-stripspace[1]):
 +
+--
 - remove trailing whitespace from all lines
 - collapse multiple consecutive empty lines into one empty line
 - remove empty lines from the beginning and end of the input
 - add a missing `\n` to the last line if necessary.
+--
++
+`--stripspace` is the default except for
+`-C`/`--reuse-message`. However, keep in mind that this depends on the
+order of similar options. For example, for `-C <object> -m<message>`,
+`--stripspace` will be used because the default for `-m` overrides the
+previous `-C`. This is a known limitation that may be fixed in the
+future.
 
 `--ref <ref>`::
 	Manipulate the notes tree in _<ref>_.  This overrides
-- 
2.49.0.780.g892193c3f50

