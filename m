Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C436816D4EF
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375164; cv=none; b=IPIpuB+NPwUjdo+rKNK74S3gncrp71CSBy5UIp2f/IiJuqcSa/K00BBIQByu0vc6XJyCahcPsc+HUL2usC1dl9ReNfdPOTkLiHhGW7PCNPDrBpV82jPV2r0ley8rOfpJiSFhGg7KXiAxcPCAW0mryXIDX+NGjY5Sv7qBCgqJc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375164; c=relaxed/simple;
	bh=N3smNhZadYih1w1qOR8d4UrcS6r6RVojrcCvi80ztuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Py4j+FSVR775sV6wD248Fkl/i4i1ichklibCuG32ssBQMqPuQQybIwG2u9P97T2GsyDT7r2IvW1znZ7MSaxzNhl5uyb2PVeOFzevUytvKuUVOfPoQ1yRvJ5w/ClN0wS3OdHhbdhWEuDYk1I/u262JM1MlDqqWz9rHEDpKPIdepg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r+Skpnbn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TVPQeZO/; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r+Skpnbn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TVPQeZO/"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D70111D0013C;
	Thu, 24 Jul 2025 12:39:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 24 Jul 2025 12:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753375161; x=1753461561; bh=/4lS9ZVhwe
	u8lVHL4owCYzb1gSQcmBaAM1/APmBW3YY=; b=r+Skpnbn988PTQ5EOgOhNC7ep+
	ei2yUQvBI0rdTHXMdLf1Z/tXYwm0rq6GM+8rM/oCDUB/LEGzrfELOMglQXdBWV0T
	UnUWqFWTfPORqzF2Wsu4opbezNSqxQuuAWlZWC2JDHrB6PyNfikRPPE+ub7pnh8d
	aghLHx4BCKmXNsMewLaLz/t/Br6bdRg0cnLrIFg7Xt63kGAEFnE9B9VnDM8cc/yW
	jw8M8IiwF/nR0mC1s8XApJiZNFiRGmRvX1niJZ+0TfueFV2bs2YAkHg2+liYfbWJ
	Q3TjoNrzj5usI9t7vEj8NTHt0jlhHY7SHCcLcDT925XTsByaNopFgjmMUzWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753375161; x=1753461561; bh=/4lS9ZVhweu8lVHL4owCYzb1gSQcmBaAM1/
	APmBW3YY=; b=TVPQeZO/TGtocdDT1ek+A1sU6SqjvImdCvKeUK77jcWywOqZzLu
	Hvx2F/1qQJzJmjOZcQiCg80VL7YbR3Wkjwq945Cp7FZI+LreeNHVsRuZH4Nxp05P
	5x3dAnXOtJFqChCFgYXzs7vgI0UXcR++CUeYQonhcWjIRquoA1I6cxtA3fWB0cLI
	2/cJ07EjSTe2u+6djt5nzWa8V4PEQmCP+856ivTjXCDw7nQvQpkl+uTXb+NKMhIS
	IxqB00tYA5cA3HXp2BXaZsBHYIAt87voChd8lSBvvSg0so2gCN9dFd5WM1QX+GWs
	4lWXjSfVkyC5AxH5v8xCPS5eslKFLUcj39g==
X-ME-Sender: <xms:uWGCaFtgrb1BMzOsD1i1T__H_kGAPSCvawO-KXl_S9gPIMqEpaFIiA>
    <xme:uWGCaJDWMbOnCD3GPptbbLbZ_90ppydC7EIzMSNjgu1-guHB9qP9gcdqVbDwbxd2-
    lON-xhmwAZLOS2h3g>
X-ME-Received: <xmr:uWGCaFXJ3ZgKY6iZl6dU2eGetinq6Lqvs03GvORXpQXL7cZh3csKGIBM_d4M5ltSDFjcvdGLxGY_qQjo7Nbzk6iJVvFqaJFuAHIM2wk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:uWGCaPBM7lZhCiOdev-_70ier-u7P-NJWAwGw7Am2UHlsv6W-WCmJQ>
    <xmx:uWGCaA-wbHgjGE_tZHXLh3bbfkRA9NOKmbTWHDadwLqxbJzEBd4Znw>
    <xmx:uWGCaOGDM8RF4EBZB8oP6eFA1qnGvkxkY8kOe_vzDVS2bC5bq45oWQ>
    <xmx:uWGCaGMzBJ9XjNpI94A2jQRB5qaTNWqf0kUrdgdaqGcETUQzc37NEA>
    <xmx:uWGCaF8TUXb0rIUBSzWjQjDnCTKI-T-gs3W72hyVDSreAXCRoLgDNo-n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 12:39:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: document test balloons in flight
In-Reply-To: <aIHY-PXYYzE8JULj@pks.im> (Patrick Steinhardt's message of "Thu,
	24 Jul 2025 08:55:52 +0200")
References: <xmqqldoen5v3.fsf@gitster.g> <xmqqecu6n1pt.fsf@gitster.g>
	<aIHY-PXYYzE8JULj@pks.im>
Date: Thu, 24 Jul 2025 09:39:19 -0700
Message-ID: <xmqqms8tilvs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jul 23, 2025 at 12:31:26PM -0700, Junio C Hamano wrote:
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> index c1046abfb7..0776d15a95 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -298,6 +298,14 @@ For C programs:
>>     . since late 2021 with 44ba10d6, we have had variables declared in
>>       the for loop "for (int i = 0; i < 10; i++)".
>>  
>> +   C99 features we have test balloons for:
>> +
>> +   . since late 2024 with v2.48.0-rc0~20, we have test balloons for
>> +     compound literal syntax, e.g., (struct foo){ .member = value };
>> +     our hope is that no platforms we care about have trouble using
>> +     them, and officially adopt its wider use in mid 2026.  Do not add
>> +     more use of the syntax until that happens.
>
> Nice. I like that we now have an explicit deadline for people to
> complain about this feature not being supported on their platform.

I do not think the firm deadline has much practical effect.  Test
balloons are designed to be placed in a stable and non-optional part
of the codebase that is exercised by everybody, so even if your
update cycle from your upstream is once a year, you'd have four or
five major releases to try building and noticing that your platform
is unhappy about them.

So the only effect it would have is to smoke out truly slow platform
maintainers; if their users are happy enough with such slow upgrade,
they have lived and they can live with versions of Git that are
years stale that we no longer care about.


