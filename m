Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E31591E3
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573453; cv=none; b=ksGOEnaPl61Xl5Yi7p4l/KK92ZO8k2lKX7Y/0Pr15wKPmNup27z/rO2s2kjF2K7xs7vG/cJN8bKqInwsp45mCxUVXwoh0BSjDjlJDKXuO+SpN4vWMNn5C1zIfVBnBlmaW4UwNTh+Xxs3MlLQ1+aHERg4mghot4+E4b3dTllncnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573453; c=relaxed/simple;
	bh=d8qZ8pqz5aNzRursTicjdQb1uu8H+JbE6TfYM1FYn3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rFoRfwqYfj2mxQ/2qJZEgTp6vT0f1OKogIjuScawbIzk80+8OyF5zwoCGN9GYJ8lchsEN8d7mvD5kCWwikoIlrQfUjbesZXwBUdFBGiJjcsjtZmFJhrdvPqCgY4125YhorDH7KYkRMbYdECv1efBDyU/8NnqCKIqdhml3IMFZ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o0JlE/eq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YfST0O/+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o0JlE/eq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YfST0O/+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 035A1114019B;
	Fri, 14 Feb 2025 17:50:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 14 Feb 2025 17:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739573449; x=1739659849; bh=3oY/zlMRyo
	N6OLGImJO52Uk3zSOf+0LjYoTjWuR543s=; b=o0JlE/eqkRICfagtWFd5ersj+0
	Pij0PRluTxzB1MSo8NMA/mARIbSUcDuw2ViuB/BDW2LKs24nd6GKcceLlvNnvqI3
	X1Ot3SkKIEUtSF9kG8Je+IGj71PbwlhvKEVbHLBMMIeR10LO6tLmGC6d96blZukM
	6h5QXUI0TAmu5u7nDjTb2iP8PbnVUpA68rd+pXDGL3gQxP6zR6hTiD1PJ6OagLe1
	DBC3vNqfYzlIJNGRehEx72OF0NV0qzRqfMRr8Rch7QjFRZBnNyOEQoEKSzhBZAM3
	bFMRydCK8ibYu5XdgaXo6+DOD9IqrDc/QQxG8uOgXnRQ6YgJnZRQkgJRaVcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739573449; x=1739659849; bh=3oY/zlMRyoN6OLGImJO52Uk3zSOf+0LjYoT
	jWuR543s=; b=YfST0O/+1OqQQBN4MkvDk/UaRVWoV09YfHqf1TGp3UEWLNPSSPU
	yFLOG1CAJ3ONX8StEqm3/1468DGcZnND29jr+1SWAgt50TCD0ArFHOOejSIYT21s
	BQe+QSJe67VdzGe0y0lqgrHE9Cnp0oCMo+VgfzHnsuW2qwSN+Ho/63rhWIPSVDu6
	eqI6+E9ecl1pTrJZ/wLF2U164412hYBcmB5aHX/r4y+otjps6mE7VOwRxIsZBioN
	KSUzOTkKQ4d80Gz/+R2vKvrstRDsl18zXEKeirzlcxBWVG7wOGyj1FGs8qzmWO8u
	vvRAph45cQ3Ec9eo3F9VHof0nldEZUOMENQ==
X-ME-Sender: <xms:ycivZ9KY8fPwNzXpqKaHo17RFvOZQgPeJNlWF-KpMXUY0HKjjwB8nw>
    <xme:ycivZ5LZuDLmrLugsOZ1RUUfR3o_ag25DGrhZloLjdr4Kc-fCUCc17r1agZMdE-xb
    89gUD6pDK9DUBN5ZQ>
X-ME-Received: <xmr:ycivZ1snJtLQoUDpakDJcdOLljMSSG22brC6gdrp9blVPjgaxe_uNJ7y8w_lRdYhpLj14xPeF2VciDDlR2jmX8ZPXMBHs6RmX-EJIiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegruggrmhesughinh
    ifohhoughivgdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ycivZ-bvYTjFmk3x2tZNMbNe4-Y8YrrH4t0TYtAeCEBLG9b0uC6qYg>
    <xmx:ycivZ0aNh9cwIa_nHfTE7GCKGWuLm5mAEz_8n7aftniAPx8RuyskYA>
    <xmx:ycivZyCnEv8b0zPyTUaAUMIyqrX6XSfHPnhOVqy6RDJTI8afsOANIw>
    <xmx:ycivZyZ6NaEGWDupS_y8HmC592TOjOxvTBEJMkv6A4o1wvs7auExaQ>
    <xmx:ycivZzw8kSFhu53QyTcEquGeCIAIF3c9zLwD4B6OIJLcJ0NgMIWSf2iE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 17:50:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adam Dinwoodie <adam@dinwoodie.org>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] Makefile: correct default docs build target
In-Reply-To: <xmqq34gg172x.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	14 Feb 2025 14:42:46 -0800")
References: <20250214215717.2854453-1-adam@dinwoodie.org>
	<xmqq34gg172x.fsf@gitster.g>
Date: Fri, 14 Feb 2025 14:50:48 -0800
Message-ID: <xmqqy0y8ywc7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Adam Dinwoodie <adam@dinwoodie.org> writes:
>
>> Put the "all" target definition near the top of Documentation/Makefile,
>> so that attempts to run make in the documentation directory actually
>> build the documentation.
>
> Good eyes.  To make the intent even more clear, please adopt the
> trick (or "convention") used by t/Makefile and our main Makefile to
> have an empty "all::" at the very beginning of the file, instead of
> moving things around, to avoid this kind of mistake to ever enter
> the repository again.
>
> Thanks.
>
>
> [Footnote]
>
> * If existing "all" targets are single-colon rules by mistake, they
>   need to be corrected.  There is no reason why these phony targets
>   should be anything but double-colon rules).

Yikes, it turns out this is needed, but because there is only one
place right now, fixing it is easy.  Something like this, perhaps.



diff --git c/Documentation/Makefile w/Documentation/Makefile
index aedfe99d1d..ddf3aa8fac 100644
--- c/Documentation/Makefile
+++ w/Documentation/Makefile
@@ -1,3 +1,6 @@
+# The default target of this Makefile is...
+all::
+
 # Import tree-wide shared Makefile behavior and libraries
 include ../shared.mak
 
@@ -238,7 +241,7 @@ DEFAULT_EDITOR_SQ = $(subst ','\'',$(DEFAULT_EDITOR))
 ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
 endif
 
-all: html man
+all:: html man
 
 html: $(DOC_HTML)
 
