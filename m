Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCED3A6EF7
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415785; cv=none; b=Pa+Kw9G2T0lmXxrOGR3pFwl7xVBu3qzBMv67RlXZGB/pD3ffQ2ZUfVua2CpHUq1yutLnlB4+pQ6Y3HsO+SQ6+ZS6lcPb4Idy+hemxnGemzZxtljkkWw8mMhn6c5Cip7RfFV+kGKc2/etALShY1dbfK/DyOEto4lu0iO7+FWihW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415785; c=relaxed/simple;
	bh=hTaX/Zm1R1qxo6k40gZxLey10PyGaiQTj1CFR0hZf1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bx0IG849lcVjYLXIG/EYMA1rryQZzqmy88r+Jr8FfSztF+ht1IAN2zj1o2gL+mUqytELPkkXE6rsKzfEsS5EQDQpEFndfzknlomgPw/qTLAuCBC4Sh/9UlEufw3bA3aMW0iJDNzuLusjKreUa8MvopQrM1bYLxl7JHwpI46vTyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ldR/OIw/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F2hbuvFx; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ldR/OIw/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F2hbuvFx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FC44EC0AEF;
	Fri, 13 Mar 2026 11:29:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 13 Mar 2026 11:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773415783; x=1773502183; bh=nsgVvkPtFo
	C3a4ZWwBP9MK9UohZepK/XaCBBzGfzfec=; b=ldR/OIw/WuGCMLulf7E3aWX5g9
	/Cl+keHCmKdvbulzj5Zcb6ftxskplSNP9JVcbbHDvROcLSvl7PJus0m8L9Szr99O
	qZix9qIuVDjmlkYQu4vHT7BR6xQvTPniFEKN5rT+yQ3tpDtpXPINU7DezDHVTfXz
	/Kv4SjsEPnNNBUYQ7ICfi1Ms6X2JOixG17ygy9bc5YwcA9hN91xtO05H2IyVd21e
	IRuqM+NC8Zt1izP2MyDcDM8aJKzX/QoiSsxuPSshEnHjISUkuOYNpeGpq3s9dExs
	nvtAvRKpr3NXTamsyvMyLA1D8cvnb4jbR1BGTCNNKchxrR/OCM4XRRsVFAyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773415783; x=1773502183; bh=nsgVvkPtFoC3a4ZWwBP9MK9UohZepK/XaCB
	BzGfzfec=; b=F2hbuvFx0di6ySnpBw7uEqMIzMdfCsX7p7Q9/GVbqgCCkdQ/ZfN
	g9fBdgwz60HQ/Iu5pVmzsPyf0ADH5yDx9+0g2iiPluGuUBdGy8qvbbAGNqRqjSb9
	6MHWdWQ+nyoUAQ2w6lR5uu+tZ4yUcrZBXDet8xbbytYEFRpoSlDCcJeP25x4Owga
	fonmhrlUslpNdjiIJl6Z/mLEEqibEaFQEO4MqKe9A8e/KMtL1BQjWYI7W1NmvUxu
	WPXxGzgxvpiH0WyvN1YBQGJeOYsWPq/ChZlLl+UQ4LnvbVEluQWG3gvqMbGINi4B
	ma9FsDbVetUD8JJ/Rr8VI0IvqkVvSTxdAzw==
X-ME-Sender: <xms:Zi20adMh7A4-iKmOvzwzrtrJDYE4Dl20DfOKBRQkuNlSCrBTX3Y2Iw>
    <xme:Zi20afDz2jfxDqYXw4IlJumvvB9yCqaZcSh4yebgZFtAG_66IMuUZzdO7Jo6TwQlE
    RTon7pC07v13ughz8My7w1lHgN-gMaNT9x1dzsHelzl_ueRZIekuw>
X-ME-Received: <xmr:Zi20aSc7MBRQ3IDx1JOQB-uxLaV6CJ3q8RcpTmMEgBmTfpMM18TkN-atDb0jpW8hOEFd6HhcPkPJunXcArRMb_ceqAC2ZQzq5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledttddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhi
    mhgrlhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepphhushhhkhgrrhhkuhhmrghrshhinhhghhduleejtdesghhmrg
    hilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Zi20aWNXi7w4ssctlqIi8q3xrMyoybthSLMFtUnP6r7j1x36hEjxog>
    <xmx:Zi20aaK1WQlF83UVtGO4j4ZQCImelYvK5BwZrsay2hF2Q1Kayec1-Q>
    <xmx:Zi20aeLfcWIcbESMMq0QJa87w-52-Rl0qMl7z4o90Ay9LlLqK9BbAA>
    <xmx:Zi20ac6vvBxlxeAjjVpF89MXGy2ck5VZO1FvCEXV6kdaxG7t47F_KQ>
    <xmx:Zy20acSb-Q39DECYQOf1lN5H36omlId7fJVLBkmrBbEYdr7r9zfzQwp8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 11:29:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>,
  git@vger.kernel.org,  sunshine@sunshineco.com,
  pushkarkumarsingh1970@gmail.com,  christian.couder@gmail.com,
  karthik.188@gmail.com
Subject: Re: [PATCH v2] t0410: modernize delete_object helper
In-Reply-To: <20260313045825.GC3753825@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 13 Mar 2026 00:58:25 -0400")
References: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
	<20260313025852.30010-1-r.siddharth.shrimali@gmail.com>
	<20260313045825.GC3753825@coredump.intra.peff.net>
Date: Fri, 13 Mar 2026 08:29:41 -0700
Message-ID: <xmqq3423928q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> This will be caught by "make test", which runs our
> check-non-portable-shell script. But that's not run if you're just doing
> a one-shot ./0410 invocation.

I am tempted to add this to SubmittingPatches::[test]; the first
line of the new paragraph appears several lines before the pre-
context but without "`make test` from the top-level".

 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index e270ccbe85..eef07d6670 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -204,6 +204,10 @@ fixed by accident to avoid regression.  Also, try merging your work to
 that are still in flight may have unexpected interactions with what
 you are trying to do in your topic.
 
+After any code change, make sure that the entire test suite passes,
+with `make test` from the top-level.  We say this twice here because
+it is important.
+
 Pushing to a fork of https://github.com/git/git will use their CI
 integration to test your changes on Linux, Mac and Windows. See the
 <<GHCI,GitHub CI>> section for details.
