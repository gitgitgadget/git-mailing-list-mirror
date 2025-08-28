Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9235F26D4CD
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756421086; cv=none; b=OWGkbkdzw/ZRpd+vYL9Ku0yhBB1xK/wacMcTrtS7TJ3XatiHDX9xth/HGLJqQP1xmlbUu/0jcdFokMiSjtd+eoyl0EAteGLklzgmS89mQr63pHyLRPcvGw3c5x9IEf3K3nQayI/PCZtVXY+TU6wh2j9wiJZKAr8LkiJW4BYdbtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756421086; c=relaxed/simple;
	bh=fRqTrTNsb4bn5yKlxGuZiAfS9ycRpWGFtZQgeIixfXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ubFbVncD00ZEH8XXjVPbqEUHtj7oSkSAMkUs9k4aPqpbllJh9X0uYrMAPU3yYNBB6sCnjq4Om+ZBAQM9OLGL3osF3+QjBGnwACAhLDQPUZ+z9ZPua0K+HUI3CRQbd+0BFeZ2SxJwoJ0aSvHaf2CxROq9BlUC6IAFkQPZmGwfOpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ljM3MXa4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I/2rrTmO; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ljM3MXa4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I/2rrTmO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 901CB1D001DF;
	Thu, 28 Aug 2025 18:44:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 28 Aug 2025 18:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756421083; x=1756507483; bh=3OCY5+5727
	bo4wNxSPnxJcEYV70zMFwvxgZu3f8A4sU=; b=ljM3MXa4PxH7DXAU6pxYa+IpZm
	fEq+3Q+mx72RiUNdIrWhkCaa36zPPsQAmdCpToo8i3hZEmW2AYsxLR8Ve8gRGnba
	I7iqZZzfXmPFvkkK+f4PsHx7oHHouQeNl4Jas0SP54nO9o+TZxGYrllc8PiMJDKx
	Km5IUGeCGUJVhbXBjFUXfHAVWqMe4lzYDHrmZFeiKxLUp8/HnwOi0S/qk9mwqQPi
	5twt6u9Q1cpm2A8GHlj15R8G1/fCBNrpbPSXteIFQ/cf7dMLETUx7rXE0hru/cBj
	ge+Hcs4fDoOuSxeynO8f5Fmv03KHJB6dcOTfzuvg4+08EISfrnPIQQSiP1Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756421083; x=1756507483; bh=3OCY5+5727bo4wNxSPnxJcEYV70zMFwvxgZ
	u3f8A4sU=; b=I/2rrTmOT6D2U+J5JMIDSYG80G3If7pJldP3ThXTAfQYguUtgVb
	xfFoRgfOLWAukrt8bnBUsao37XuaUhQgiOVdcQQ406lfnryMObHoQ975B6Fz3R87
	ibjgdDdkfh6cyYQzmb99xqQwOrbL2lpb3LVCHIJYs+wlarI5ukGvEGJfwcNW//zr
	2XC04qvuAmoJvn7D4rOjEjcQp9iMP5xDf9MooZkBDXwZluNvlhfnDrtvQcZxC2hl
	OdwWIDfwkc8v2HViFRh+yYZxBbbRccpdLfzinRJJuN1fUYdRWlPRDFt34WdIOnNP
	9CS255guC+9y/8Chc46fLTYWmzyz+XPsKPA==
X-ME-Sender: <xms:29uwaLgCFPAjAq5mq_Wkm2cyjrQfU_y6zHVkn0Ge3eR_08QX5QnzqQ>
    <xme:29uwaCmGgLKETBnf45q6-UtXJdFwHBrGHV99UCnAOTkAVOtn7TQB7Y4MhQkvHq1kP
    U8YyEAI5r_Q2_TYUQ>
X-ME-Received: <xmr:29uwaHoDLo7iGJnAFfAKfREtAZvweo3d_5kqwUVzLd2w7gzvTseKeV8piNA3sZeOP4mXWEQXNaflqu1Rqfr-eHvH6F6i90U_QhlNTu8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:29uwaLFMcI7XRQuD38FqhGx5yXHWDJtcSddNZgKFiVTPgPwoFUYNAA>
    <xmx:29uwaDz7eQo8AMyA8g9iMWdfXsFiGKGXBRKqZmIP1F4Vd5BInDRoEA>
    <xmx:29uwaAr04jg4AIVIZGxBCOFd8tDRBUzihyGwMTl2m1db6nTWPOQ2Eg>
    <xmx:29uwaNjKR-CegpRiAPv9ReQh8TjToA2y8PYsA1rtZ7TV4eEClCqIhA>
    <xmx:29uwaAMWi7XULFQWloEfyNUZpd1NjASlVwBIhcJAm0zJaMmEOdHT1nGR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 18:44:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
  git@vger.kernel.org
Subject: Re: [PATCH v7 0/3] Introduce git-last-modified(1) command
In-Reply-To: <xmqqectowjdb.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	06 Aug 2025 08:38:24 -0700")
References: <20250730175510.987383-1-toon@iotcl.com>
	<xmqqjz3h20cs.fsf@gitster.g> <87tt2lu2rx.fsf@iotcl.com>
	<1929210.tdWV9SEqCh@cayenne> <xmqqwm7hxx0a.fsf@gitster.g>
	<87qzxou0an.fsf@iotcl.com> <xmqqectowjdb.fsf@gitster.g>
Date: Thu, 28 Aug 2025 15:44:41 -0700
Message-ID: <xmqq5xe7t6au.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> Looks good to me. Do you want me to reroll, or will you `--autosquash`
>> yourself? 
>
> I can do the latter, unless there are other reasons that make it
> necessary to update the patches.  We'll see.

Sorry, but it seems that I dropped the ball after this exchange.

The topic still has the fixup! sitting at the top.  If there are no
further changes needed, let me squash it into the base commit and
then mark the topic for 'next'.

 Documentation/git-last-modified.adoc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
index 35bd4a1dd0..602843e095 100644
--- a/Documentation/git-last-modified.adoc
+++ b/Documentation/git-last-modified.adoc
@@ -22,24 +22,24 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 OPTIONS
 -------
 
--r::
---recursive::
+`-r`::
+`--recursive`::
 	Instead of showing tree entries, step into subtrees and show all entries
 	inside them recursively.
 
--t::
---show-trees::
+`-t`::
+`--show-trees`::
 	Show tree entries even when recursing into them. It has no effect
 	without `--recursive`.
 
-<revision-range>::
+`<revision-range>`::
 	Only traverse commits in the specified revision range. When no
 	`<revision-range>` is specified, it defaults to `HEAD` (i.e. the whole
 	history leading to the current commit). For a complete list of ways to
 	spell `<revision-range>`, see the 'Specifying Ranges' section of
 	linkgit:gitrevisions[7].
 
-[--] <path>...::
+`[--] <path>...`::
 	For each _<path>_ given, the commit which last modified it is returned.
 	Without an optional path parameter, all files and subdirectories
 	in path traversal the are included in the output.
-- 
2.51.0-262-gbae8ff527a


