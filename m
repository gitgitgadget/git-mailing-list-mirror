Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6312080E8
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430379; cv=none; b=S9i6GZj6bGYQOD6WyTOzlr2ciTbaDFOFIURLGAhOQnM3Cdnr0KL1CWua20GIwbtsnxVfDf8Ff/Lfb6ZUrBch18XyFVCGeaUe3EsnrkSg1+xCBkD56NBOeXYMNeepsCic7507UR/+ZrJnsMW4GnEXYvNVR3rfEavPg3LqBnJcv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430379; c=relaxed/simple;
	bh=ZONprYstB2J0QCEwicu5nHB9x0lqh35+pakYQrw4uZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PR8GKE77hQs57Cf2nVKK5I3XRXTWFfIDTepgB+/CbpRtPNzb93CggA/nkxKP7hbLlfTr7ka+HjRv0ItVKPfvfmw5Jh1waoMVHSUxDVxdhXF/+vvgg/Ooo4Eul/gVJTqukdLJAQwhzrnWOBpHcb7Ei6kXRtmAQ7U63GBx//6gi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hssvtiWd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DVXwH5Ab; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hssvtiWd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DVXwH5Ab"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D20D3140016A;
	Tue,  5 Aug 2025 17:46:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 05 Aug 2025 17:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754430375;
	 x=1754516775; bh=wunn6E2h3fh+f0e29qdUj3ojo+2YTbDHMTs9bfwn4jc=; b=
	hssvtiWdYNhyK2LFHOqxkKqM2PQOydV4fF6keNYD+JJxU09tNHLYCMHKb3Z84iy0
	UaBk8IVQt/DOVBWHNFI2YCguYrqV1bD7XAs7ywGD0gGjGzU+REevJIjVNNoS4RXt
	h1eWPeF+BEjn/SPYa3xDogRAktXQxvpFqmols3X8I7upmLA/d1srTp+VQMQFpxat
	4Z+3TsJJFKvLUiwcjnbHYLYYoq9zlff7n2md2cqEOVleXrBDkYiOyGKm5tbVrWqW
	CXuxWZ5MykJPtIzDwsUHD+KSiQ6U/kJxPjU7jzyB15+N3OZ/QrCUtViEgoguNFZ0
	tibs88xQNJzEnAz3yIReCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754430375; x=
	1754516775; bh=wunn6E2h3fh+f0e29qdUj3ojo+2YTbDHMTs9bfwn4jc=; b=D
	VXwH5AbSnDBweSz6IpShhCAgeDjaKswq/IOwE6pt7sI5BgbtrrpHGpvMZDXRojrl
	xJp4j7IWBoYqzxy9GoNBrc4j79r3PDHa8ZFG/bUU4J4THhMJOhHEHdUd99G5I5vw
	MfjeMxfzSai9m3IvAGcph03FLiHCcEeknsDtwrIEj736US1FmUnmNXly4elhTR+H
	2bG5l3jkfqQOtMtSMMAvtmDM/6+mS6iHGz8RMQnvZaAGZ08c6NNvZe2nfBYFbg6V
	+DYfTKMpFTqjZtIepHiM7LDNaxgfdvO68wmXq3wNl5vGCtgbHVDVqaWbCjc0EQfl
	xAAtm8qPkOhPA8bP4f6xQ==
X-ME-Sender: <xms:p3uSaNqAnvMmtS7WYUxW7ez-BG3QtYBaKvg_2949MOzTB9Pe6nehkA>
    <xme:p3uSaKPGImUHol0SZY9IvAhsTf0rotj_2UVD1NToylMrlM7MT3izYpxPrMXOaqxon
    Z7bQGjJ1ERDZ-yG2A>
X-ME-Received: <xmr:p3uSaGwTqZ92hZE0V7ZnXorDUlfh8n57tAiBg5924NGUtrq9MYMV8vmPevpUvd_aYjm9NB0jJBmauXxB5JdhMTdQQs995uCtsfoBqWY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeivdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:p3uSaLuCQR9rwQa4v4y9cleH-toulkOGi6xmc3ooERdsqY3URzE6_w>
    <xmx:p3uSaH75UifG58vVkiI-tf9z3vICZHtNvWnW4GNaguQzce38umW7zw>
    <xmx:p3uSaCSCjhYmEjxPdla2RhnKc2fbUKepnOBCdw0uXW6keqYlndFu0A>
    <xmx:p3uSaOqn9u-m5YEepEp8CeQVFOTa6rF6UlvCzD-Hzd6ysObzQcyEmg>
    <xmx:p3uSaOFmk3Z534IxHvBs7fknXJNtS5Bp66ZKnSgzuOYvK09vXNDbEKKJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 17:46:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
  git@vger.kernel.org
Subject: Re: [PATCH v7 0/3] Introduce git-last-modified(1) command
In-Reply-To: <1929210.tdWV9SEqCh@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Tue, 05 Aug 2025 19:20:05 +0200")
References: <20250730175510.987383-1-toon@iotcl.com>
	<xmqqjz3h20cs.fsf@gitster.g> <87tt2lu2rx.fsf@iotcl.com>
	<1929210.tdWV9SEqCh@cayenne>
Date: Tue, 05 Aug 2025 14:46:13 -0700
Message-ID: <xmqqwm7hxx0a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

>> > I am not sure about the last two, i.e. things that are not dash+option
>> > appearing as enumeration labels, though (and Cc'ing Jean-Noël to ask
>> > for help).
>>  ...
> Well, the check fails to catch all the missing cases: The last two terms 
> should also be formatted. For the <revision-range>, you can either enclose it 
> with underscores (as a placeholder) or with backticks (which the formatter 
> formats like a placeholder). For the last one, backticks are definitely needed 
> to differentiate the formatting between the placeholder and the syntax marks.
>
> As for my patch series, this can definitely be checked. will reroll.

This is what I queued on top of your topic to prepare the
integration today.

--- >8 ---
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 5 Aug 2025 14:37:25 -0700
Subject: [PATCH] fixup! last-modified: new subcommand to show when files were last modified

---
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
2.51.0-rc0-162-g220549999b

