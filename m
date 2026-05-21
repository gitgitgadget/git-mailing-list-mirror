Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15EB33EF
	for <git@vger.kernel.org>; Thu, 21 May 2026 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380820; cv=none; b=AAL1yl/bsqTOBv3a8IYclfC+727Pjzjwsxk1wgpjvd5q8SUdVn7yU73aA5zeQRMZU0tesB4eBnq18Ini+ZO3nG7js4IAI7VemPVca+RgdcOmJ03aFnzxE5FagmPX6bZx/L+YyJMxe7DRm+fLlLl9tmHyqBsPvPW5zJo6DmuiYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380820; c=relaxed/simple;
	bh=7dRLpRumrqorUmnId4PF5//It3aJD/KiT+AtYnCJxrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m0HkQZ/0lWIJ6HecK9AvPLt+O4iE+0XTu9zejEiJCC0PvpslIuhP7SYpKDNJ36c11VNCdJJp+CkreB2U6KfLcrBPl3ny8GXqafrocLcdR/znj3MFSrTHiQBUqur1ccLrJa8TSH+HHJVfTgQ+1TIpLp4DO5JVHlcXg9e5267CXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RWilv6vR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pINqJNUh; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RWilv6vR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pINqJNUh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F38867A00E8;
	Thu, 21 May 2026 12:26:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 12:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1779380817; x=1779467217; bh=MF
	QnZL0OwA880xoI1vyfwMsamE9ERebknq1zsi7pXfg=; b=RWilv6vRzEfi4Z054u
	V7cFhhQMNWVSoBXL+iIrYKUQClCZduJSgRyLKE+oYbYT3xlc8DmtpQCr/iD3DFa/
	39cT/nkTqHYcYXOfYEf6TZ8VesI5h+2O0Exr5DkRpK1QNzXoDDz1NqNS1z6HNyZv
	XlPXYgPUHP0jnGqSiSqWNWSDiquE/XHCA3qiqIlnGrRwxJJbviYT9F3b+2wOyvS5
	WbEBsj4Dl7PhqDFdPnBhlqRa1OFw9c3obMP3xkWz+VGkpECF3Ns+J22tDRWjfv5n
	Myx3ElXo0sKNmbu1kjH3skFiMEF7/lqJjiRBUYctv1b15aXeu9N6Q/vWKdesaKvT
	+2Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1779380817; x=1779467217; bh=MFQnZL0OwA880xoI1vyfwMsamE9E
	Rebknq1zsi7pXfg=; b=pINqJNUhqUtcm7vLlkF30oN6pFjeTSktWwV4TUrVnl+O
	4WIWR0OzquDMBhCt2INctbXSoIDuRVwkxHXU9BWQoqhRszNumyjgzWw7jeNUfKJB
	jK3yPjyGvTqfoCQPUSv+0h7+b50VdUE8ehCitvASqBnkrqCgvNwYxhgBGVrOfNsO
	8MpTXP768Yy/IkdUtP/FSstiSfEzQuPOTQLI34B2gIft5S7zZ/Zwp4G/9UNT59FA
	QEra/G4iUx46m7EjwtwFZplWQxFSaj++23Mbh1EgVBplGPxwKLc2rbCvV4eW2P0F
	P/Y3afqq9LwYu/U0exZA1G81sMC2efA+sJZgjbaf/w==
X-ME-Sender: <xms:UTIPalMiPO2h1YYNcvEZ7_KjSSJbKFe9pNZGTHK3u5GA7mqvZBycRWM>
    <xme:UTIPau_vIwuQ3kSsed38pchIxcKlLW8DAeovo3vD2uyRGNk5ah0PEfjdTPj9VxpUx
    PNv-Zal5g3v0n12pjonXqn_b1aGXko-cRJg35VkWId3dLqhU-Q1>
X-ME-Received: <xmr:UTIPapTwG-jaYPc8jHcAK5w9n21oZdcA5_1UU_5FYFCeGSpVEpUSDbwuit5GybVfmJEDn8vb5UyQDXeeda_63MusF4yzd_JD_IrYVrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejff
    dufeefffegkeevgfevvdegffeujeejleegudfhtdffieekleefhffgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghp
    thhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtoheprggurhhirghnrd
    hrrghtihhusegtohhllhgrsghorhgrrdgtohhm
X-ME-Proxy: <xmx:UTIPagl1mudWEPqDJv2OxtMl9phwJDXApdMg7DZRWCzLHyzQG8Cy8w>
    <xmx:UTIPapQgd8HUIcTZL0nx2pYnrIU3n0OIJts3yTYuuLhic8KwZiFzUw>
    <xmx:UTIPauMkBBYmDYqurkUXoK0hsEYh83VrQdABdkYOQHPwBwlTzOQ35A>
    <xmx:UTIPaiW6FnyGXq1CssIccl7YayN1SyimJQmAoGAmJNNYD6n15i1jqQ>
    <xmx:UTIPalDxORZ41lWIYjH80GRA3QtT1HGZNGX22V3bn0wDEEB-aekop2ve>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 12:26:56 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	jn.avila@free.fr,
	adrian.ratiu@collabora.com
Subject: [PATCH 0/4] doc: hook: small improvements
Date: Thu, 21 May 2026 18:25:54 +0200
Message-ID: <CV_doc_hook.6f0@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/doc-hook

Topic summary: Small improvements to git-hook(1) and the associated config.

[1/4] doc: hook: remove stray backtick
[2/4] doc: hook: consistently capitalize Git
[3/4] doc: config: include existing git-hook(1) section
[4/4] doc: hook: don’t self-link via config include

 Documentation/config.adoc      |  2 ++
 Documentation/config/hook.adoc | 19 +++++++++++++------
 Documentation/git-hook.adoc    | 11 ++++++-----
 3 files changed, 21 insertions(+), 11 deletions(-)


base-commit: aec3f587505a472db67e9462d0702e7d463a449d
-- 
2.54.0.13.g9c7419e39f8

