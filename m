Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEFD18C03F
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487498; cv=none; b=SkqTevr0Vj/F3pon6TgoPllrOPlS0HJ7OOnviuwK9FbCZJN7sCmqNjiLUsZBTIWD/sWvA5g5EkOOZhfOHFejPzKIv2cmXBfSCiUyV2MNU7xwoEQc0uiO674+43gDZMPROoEpUVSCA8lIjly/JcaFwTSrIqHKlg/QLtIRhtWQ7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487498; c=relaxed/simple;
	bh=rVkpXtWrO4Ka48Tkv++NKV1ue6jRjs9jgXgeU5fFa7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SmEf1ZJnstE8XYhLGxqMjHcFOKV5GvE0qtyiPXsB2nNx1KrufMSv5Vn9KOfxnZRkyaYDhtlYyhahxaI/97MH8pml51Xc4+IdbYXX+qivAv7y+WslKJMq8G5603t6VFQjkDQQaqYkgDOjia6Mjl86SUbEzZEmzr9cx1Ge76Qoocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F6KHBOja; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=imJzHvQg; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F6KHBOja";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="imJzHvQg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 555BE7A0162;
	Fri, 29 Aug 2025 13:11:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 29 Aug 2025 13:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756487495; x=1756573895; bh=E1wNnKqJHr
	he8LTtE+ovvbvkl299YAVLhNiaqq0M+m0=; b=F6KHBOjakS7mSDspzXPHq4xRFw
	4PGOrQzQqO5oLYD7b73QHgZusNDxCPLKQ+S2FgGbST3gKCISzBth8bhnPoc5KP0O
	UKqC/hVdyHyJR7ay/ddcYeMYkxz0cupCtu0cgk8ol1efIEV8RIzGJ/O7vjDi1cBC
	WOWC6aaBLk0CrHKa1NLB25e5VvE2I4b7ml3x9hBhl9B9d7UOwJCIv8LaFmil4pug
	t4mkELodOx7xTpcGzoq3U7UCAhOH+eW3giVWJnmpl10IzIAmBe8nUtTmrXrcSwZZ
	/rwX/oYTmgiJ4Y34HsXlotmklTBhIA+7wdax/Y+1EtgucyiJMgJbdF1HK/og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756487495; x=1756573895; bh=E1wNnKqJHrhe8LTtE+ovvbvkl299YAVLhNi
	aqq0M+m0=; b=imJzHvQgT/JB+eo3P82Kn0RSZVmK62kPmvgWAAinUhuA0zGsZy8
	4z3pcHYBP25eyr4gSbvcE5epuDJj8doVVyAyBqvi0PEb2KtKMAxSQxq9xE09piOv
	KwlPiCYL8eyACi+Yrh+SlkIL5kBeWjf+7KKCQ5JvEwvpZMDRPBSZdYh5jY6Iwp/E
	OGBUgmrlR4bQChKYuZHcV0JslLkE2tda2Htx17oAjEpsMR2SV/SztcbKpPCOlfLO
	AnzTUJoX/zf33BCSv+WayylRH0n7cHLtkkVJIYuNCxVNnu2T8UxKoej48fDaBnrh
	F4+flyNzX9LTCsOtH0bjBn9EfM7H75ISG6w==
X-ME-Sender: <xms:Rt-xaG6-ZrBIeW0SHGgFndL8S70YkvQiEURmpd-YEZhNahFiyRfo_w>
    <xme:Rt-xaM2myu8H-CxGQKCumL_vGiNRQbrNw6Yq72rRMGPb8Y23NpV5BVRDq6S40tNMZ
    9Ip0GoEHdw1Fgq97g>
X-ME-Received: <xmr:Rt-xaBFRCitFE3iF0oVbbX_C5CBu_6E1BICZpjGRJWpesETv_PZGAjw2EfZLQHBdUEnYj1O5wPYmzvnzZZUOA_iy_GLPGBlS--qBuYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgv
    vgdrfhhrpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpd
    hrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Rt-xaLhYJDrzVnqeAGt7gHBHGgZpRXeE12vtka1ZB0kM-FLcUVw1UQ>
    <xmx:Rt-xaEAUh6P1Pyl1JhG3mE9b2G8UE_dx_T_U9wd6agJWwNtwOBARbw>
    <xmx:Rt-xaNRveKphq6z6VQUYPi00Pt0FLoISYqhmW9QimUXPwQLlzQyZfQ>
    <xmx:Rt-xaJX14-vt5BwhRAM2rC7MItMFbY8eeeZjIvCdWF-kpuU_hsN4IQ>
    <xmx:R9-xaCvvWE7HU7yVPIoCy3I3t0rEMFaJ4oXjuU_2Ag4S3NKRmA9ToXUM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 13:11:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,
  rsbecker@nexbridge.com,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 0/2] doc: git-add: clarify DESCRIPTION section
In-Reply-To: <pull.1952.v4.git.1756468502.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Fri, 29 Aug 2025 11:55:00 +0000")
References: <pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
	<pull.1952.v4.git.1756468502.gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 10:11:33 -0700
Message-ID: <xmqqv7m6m4sa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Slightly reword the first sentence ("you use" instead of "Git stores")

The update is appreciated, but the topic has already been in 'next'
for a few days since 2025-08-25 at 0c84501ed2, so we'd need to turn
this into a follow-up incremental fix.

Here is what I came up with and will queue for today's integration
cycle.

--- >8 ---
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 29 Aug 2025 10:07:42 -0700
Subject: [PATCH] doc: rephrase the purpose of the staging area

From: Julia Evans <julia@jvns.ca>

Git does not really "store the contents of the next commit"
anywhere; rather, you the user use the index to prepare it.

Signed-off-by: Julia Evans <julia@jvns.ca>
[jc; made the change relative to what is already in 'next']
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index bf793d2894..ad629c46c5 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -17,8 +17,8 @@ git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [-
 DESCRIPTION
 -----------
 Add contents of new or changed files to the index. The "index" (also
-known as "staging area") is where Git stores the contents of the next
-commit.
+known as the "staging area") is what you use to prepare the contents of
+the next commit.
 
 When you run `git commit` without any other arguments, it will only
 commit staged changes. For example, if you've edited `file.c` and want
-- 
2.51.0-267-g71e270be43



