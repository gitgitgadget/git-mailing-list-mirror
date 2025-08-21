Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A332267729
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788818; cv=none; b=gq+7gpdl797O0b8YJ1iBxIlXKpR+Ii3/OU60z8KvcY2wVSJMjRIE0KNgQVsaMqWkHd0yx9QPCjBJbrR7fMrVYsziRBiXbl0QXMVH/iVUH4EHLjnu+GEwQwSA+R0pUIwczvIl/KKZ4ZDH8IQBtIH09z15KwaTCecb9oG4vkWahGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788818; c=relaxed/simple;
	bh=9m+AsLwo3beQgZpKxBpguzTWmbg7n5rkN20QJjFQDik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cSvAi4qP25QxzAbPXPIMMh9Z5vjvo0WnP61XV6VQD+9lDO5/ptK5nq4P4MzAAmrgYI9axuVJ7WKHDt0yxIxxiJistFLExVOItPIvFk+3vAnHN4lm/9Q/7wlSdJuKPs6gkpoAsNbZa4ax/HegDGKBtwhyUiv+W0gyGifBYhqwcyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KUSgK6e9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NvhQJLTM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KUSgK6e9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NvhQJLTM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E5511D0006E;
	Thu, 21 Aug 2025 11:06:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 21 Aug 2025 11:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1755788814; x=1755875214; bh=uYvQK+QT4JkIuuEbrh+u99EMJh+cQKEr
	WupGWC23rIc=; b=KUSgK6e95k+jNe43rJsgucHDrSl7hRxYS0t6iUbvafstU2KF
	8zwT2mVsO3LVdJkrP6mjRQbIFbxFpoQYSLZrwA5UW4xTAikfQBp8m1oVpG/LnKbP
	luF760ml9wYD3MIrrZk+3y0/7BRNKX85fi88TNQjlLZOb2/QaYJeMiVVT5HpBqj2
	XGwfl00HBelIQyvCuOW7Xx4bkqkHT5qd8o5UlklqQQ3llxusvnIFXJLC+HPq2Jt2
	x6wRYH5uzZDTUTnjeOZNgOiVVSfDTB6wfUuluEDk9b1RA10PnmBZahNHDfJAEYCr
	s8y8V38MOo1eYcRDRP0NRE/i8UdlZ94rfPX1Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755788814; x=
	1755875214; bh=uYvQK+QT4JkIuuEbrh+u99EMJh+cQKErWupGWC23rIc=; b=N
	vhQJLTM4ZBcghNtDkhw0xHk7TwI7lZATEpzBTKu+kghRfHo/33+nqKgJ9X2CtYqg
	/X0dHbXG8jaXwsNvqLvbpqKNrCDPpxiY3f1KJ0aj7GUkQKVBx6ttPTataD4Lm32P
	oepyFKqdUFFVpsO3yfrNKjRRERsWMwsvZYzssIJoyYFSCU3b1wA5y5Oi9eJZDwXa
	jVCKkq092AZY4grxGnh5PIzxFwum7618ykC4O/3cy+j2/dKGmoWYq2CYOYWIVmJF
	5bnClo4D63X0I2GLgcQzpnGPrNyh2HtXVkbWxcMsyfnkpy6fZtROdK2RnQW2hL2r
	r94JC9jVNQqsG6Bu1jadw==
X-ME-Sender: <xms:DjanaNAANn7VlKXiZOj40C1I9wA85RQ2_5UrAiIBRS5LYUS0OiBdAw>
    <xme:DjanaOxA95W7QNQ5nDhcVTml8_pkOY212XVDn8sd_1wY8SeicXyYo0EuC9mgS9FfP
    KAjGgyOkWOzZ_vG2A>
X-ME-Received: <xmr:DjanaCAw9WjzirfsnzgqF8T5SNhW2d_QpFhOK-d9AivhzO9SukDcY0lcuwAqhaHdKN9aTcZcxrvj4cc04QoimI1dYUmPcAiboMAJ3h0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieduheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejhffgfedvkeeftdfhjeegffeiveeiie
    efgeeuiefhjeelueefffejteekffffjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DjanaDa5g4HCPRynHXslMoGutE8XmT5Sqxmtf9x8HWha_Zx0-gTg6A>
    <xmx:DjanaCjh1Rkh4PrYEEiWw0c64OSQPBJQTnCgeka3A9Y-IoOyrGrTYg>
    <xmx:DjanaN7XDdfjQc55qs5DJcBMr6KI777qAKt8fYi7LSngsPUmbEOTiA>
    <xmx:DjanaB4erej2vVgJZcliShuoZ1vrEUQ-2YBTxDG7yM9XvYQ_uKhcWA>
    <xmx:DjanaIFgBVgcgbYbcN4OcnHrCvfHtQ4yUJlU6BUxsP7bvFtfmNshxfy4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 11:06:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] config: document includeIf conditions consistently
Date: Thu, 21 Aug 2025 08:06:52 -0700
Message-ID: <xmqqldnc4stv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When 399b1984 (config: include file if remote URL matches a glob,
2022-01-18) added the 'hasconfig:remote.*.url:<URL>' condition to be
used in the "includeIf.<condition>.path" configuration, the keyword
was added with an extra colon in the documentation.

The section that documents these condition begins with this preamble:

    The condition starts with a keyword followed by a colon and some data
    whose format and meaning depends on the keyword. Supported keywords
    are:

which makes it clear that the colon that comes between the condition
keyword (e.g. "gitdir") and the parameter (aka "some data") is not
a part of the keyword.

Lose the extra colon.  Also rewrite description of all keywords to
clarify that "some data" does not directly follow "keyword", and the
colon is not a part of keyword.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.adoc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git c/Documentation/config.adoc w/Documentation/config.adoc
index cc769251be..05f1ca7293 100644
--- c/Documentation/config.adoc
+++ w/Documentation/config.adoc
@@ -114,8 +114,7 @@ whose format and meaning depends on the keyword. Supported keywords
 are:
 
 `gitdir`::
-
-	The data that follows the keyword `gitdir:` is used as a glob
+	The data that follows the keyword `gitdir` and a colon is used as a glob
 	pattern. If the location of the .git directory matches the
 	pattern, the include condition is met.
 +
@@ -148,7 +147,7 @@ refer to linkgit:gitignore[5] for details. For convenience:
 	case-insensitively (e.g. on case-insensitive file systems)
 
 `onbranch`::
-	The data that follows the keyword `onbranch:` is taken to be a
+	The data that follows the keyword `onbranch` and a colon is taken to be a
 	pattern with standard globbing wildcards and two additional
 	ones, `**/` and `/**`, that can match multiple path components.
 	If we are in a worktree where the name of the branch that is
@@ -161,8 +160,8 @@ all branches that begin with `foo/`. This is useful if your branches are
 organized hierarchically and you would like to apply a configuration to
 all the branches in that hierarchy.
 
-`hasconfig:remote.*.url:`::
-	The data that follows this keyword is taken to
+`hasconfig:remote.*.url`::
+	The data that follows this keyword and a colon is taken to
 	be a pattern with standard globbing wildcards and two
 	additional ones, `**/` and `/**`, that can match multiple
 	components. The first time this keyword is seen, the rest of
