Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDF33E7
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750337; cv=none; b=sZNUC2H1A3pRh0xVbU2waa42+NVYVzbsUTwXmhowkBMVQwjJ3iCyB/7wai8bY5KjsFxgnMkIfo8Y9yckTHOihkxUW/6DMVcPhiIKKUkCUjjwnFhaBr4nSaPJxHhoSkO41NFGbE/MnM7LfT/jPlt+s8yKEmw5e4WfOy3XkBAUTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750337; c=relaxed/simple;
	bh=q85j81c4+0dgfL6E4azREMYZ1L3pqoiutzTknqCQFIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cyCLYzu7X0b7dzZvKvUCF94WnJRhQaEv0znbDAeR2uGSIRlz6H+/PHltXRlrPaT4eDmIsS/T2xZEoA46U81zj5zBSrH6GftSwh/1ZTAysCYBo92lRoVPPqLe2H6gsxn1mFfzgs/2Dr0lOjgX+7UpNKdg7guyMKBF7SOaEVYq+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dmx5DAzk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1qIl2Pq9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dmx5DAzk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1qIl2Pq9"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CC951382786;
	Fri, 28 Feb 2025 08:45:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 28 Feb 2025 08:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740750334; x=1740836734; bh=osVI+BOxxJ
	9g9Y9i1EDG7gxYue/JS7N/h/6qhgla1gs=; b=Dmx5DAzkUpp12PhJJLWWInBmuZ
	Gq0IfdyuLXfgiV6QySmv7dJ9xv8bJCfJgND//aJAo9xaW++qmyEcCM+/sSYO9hD8
	SXr6c9TrAEJe8oKbI9xUxNp2sXkRe/IbbhTj727uUdo7kX/ubcvrkx07/Hhg2Nhj
	FsY3xWSfe8qW8zZEsvsDI+lM0090/VxAmfQrTh9Aimm7hrRz50Ej9sh8j9DYo72k
	kMfB/jWHEqgrwJSBJWcAuD1CpV2lsTOQVmCsdu7EMIX740CY+4RJH6vOLq/bQADN
	ac5qdLt10BMb2yFgp9drjF6p4X1lM+QrhXdr4O5bAMR2xHcBYVgAeFcRfCsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740750334; x=1740836734; bh=osVI+BOxxJ9g9Y9i1EDG7gxYue/JS7N/h/6
	qhgla1gs=; b=1qIl2Pq9KWSniopT9genYTft4fbGDkCITeoCvrxJi/ZOUTUpTWX
	cDZm86ZrhyY5xgvMM6cuTR0/jAGLuwDsIIkU82QhP6kwkAEXDVGiSpuNp9CJVn5/
	zwzY3SmKWAN2K4Isr0UBcaAs6a0vAeKWDAgVJNPm//JtpOGZWjq4UFX6gsXn/ZPa
	SboCAyScrbqsH/+JMm0+Zv2pPNJqOOkNIgCHYEJYHH3/zg7qZryK9iEGcaRspTdo
	6Y1MEHSrBbFRlfgTRb9EJumvw1WpdK7NyoLVrEnDEfScf91aNx1dETQ1iO4m5XUx
	K5sFcjrwMkD472PE2iCKZ0R+qirTZZgTL3Q==
X-ME-Sender: <xms:_b3BZ79sRYtGQHujtOwsOqt8J5peeo37e9bLLgAQr8To-CX1EnesKg>
    <xme:_b3BZ3sDTda8cstpaGsMvodOy3Ws54h9GaMqGd0xUDOI12W6foTuEsgI2hoa6ewxl
    AQinaJRNH4JOTqsXQ>
X-ME-Received: <xmr:_b3BZ5BVr0aNoO5pet0aHHXqRpDcBS2kbxEzXfo0Ku-8wUkwAlmIk3FOJMkohlsjXoY6IWE2gM7p-50mR0iL1Xp4SyRppJDdMGti>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtmhiisehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsth
    ihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:_b3BZ3c6KqWIuCUjAXiSXzm7vJ9uh4wXGisnvEccJh-EzJDUBSqpog>
    <xmx:_b3BZwOTeZeXwEu-xO0TxR_bRPt2izwVLimS0xkF7_8qC2y_lAwfYQ>
    <xmx:_b3BZ5nmglrdAr3rfYlT_aviPPInjDZoV3L0YF5XdLoCMjOE7yn99A>
    <xmx:_b3BZ6s2k9rFAz-2DkPQRPxzURQ34r53r24jWYIDWOl6fw35fjhHig>
    <xmx:_r3BZ_1RNbiFRBDs9DA0zrp0ElJuEvP-zBbXEaHvRpajRuQymz1f6lGP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 08:45:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/3] doc: txt -> adoc fixes
In-Reply-To: <20250228034713.203461-1-tmz@pobox.com> (Todd Zullinger's message
	of "Thu, 27 Feb 2025 22:47:03 -0500")
References: <20250228034713.203461-1-tmz@pobox.com>
Date: Fri, 28 Feb 2025 05:45:31 -0800
Message-ID: <xmqq4j0e5gjo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> I noticed broken links in the howto-index.html output of v2.49.0-rc0.
> This is due to the recent txt -> adoc renaming.  I chose to replace the
> numerous occurences of "txt" with "adoc" in howto-index.sh for consistency
> within the script.  It could be argued that only the few instances which
> glob '*.txt' should be changed, of course.

Thanks for noticing and sending a fix.

> I also renamed the git-*.txt files in contrib/contacts and contrib/subtree
> while I was here.  The only other file in contrib which might warrant that
> treatment is contrib/mw-to-git/git-remote-mediawiki.txt.  I skipped it as
> I am not sure whether it is actively maintained anymore.  If we want to
> rename it to be consistent, that's easy enough.
>
> Todd Zullinger (3):
>   doc: update howto-index.sh for .adoc extensions
>   contrib/contacts: rename .txt to .adoc
>   contrib/subtree: rename .txt to .adoc
>
>  Documentation/howto/howto-index.sh                 | 14 +++++++-------
>  contrib/contacts/Makefile                          |  2 +-
>  .../{git-contacts.txt => git-contacts.adoc}        |  0
>  contrib/subtree/Makefile                           |  2 +-
>  .../subtree/{git-subtree.txt => git-subtree.adoc}  |  0
>  5 files changed, 9 insertions(+), 9 deletions(-)
>  rename contrib/contacts/{git-contacts.txt => git-contacts.adoc} (100%)
>  rename contrib/subtree/{git-subtree.txt => git-subtree.adoc} (100%)
