Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3C3A6EEC
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028288; cv=none; b=WoKpjOOa2ogFWRk4zB8YozcYMoVuqOtw41FNw/Lzkbkq/nUZ3mMjWMlaQOUK89evSelSVrdYbzHLesKv3aa5DrC61KiJULDZRjrmkcKj1Yl8jNc63RxQew64KJyWZTfgl5SOE8DOuQmYxcCkzl8FVDEERnMBJBc9OoYY/l+OEdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028288; c=relaxed/simple;
	bh=WK9wrBCAvWcNL3xMUwgYu8z4b/JddwLvUtVYSVC0WR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqImDuCJgJZ7aQGtCBLFSNHFp+HSVIP1mSM5SaB3hoZrDjJzEaFADARpp7freAJv9XQNCOkVnTfc83uhXIfUg7p5Wvl2oIvyX8RI/V9kPQNuLXgVGBI9mmkCzPibKqlRl3WQVZwF8XWO4IPJIsZTt7jblVV9SQxES5Z406IK8UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wWkQSJEX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BakxwjEr; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wWkQSJEX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BakxwjEr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7191C1D0011E;
	Thu, 10 Sep 2026 04:18:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 10 Sep 2026 04:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789028285; x=1789114685; bh=IrhIjkq2n9
	BeX6KsvyC5seIEAgsaAG7R8Ibnyt4als8=; b=wWkQSJEXE88stqEkKcXV39lOkB
	JuyS3OllK/67x8oqnFQe1nZMq/s+DpxmjGwtmzfks8Wt9E9jgC7DdNMBUxY6nqCQ
	QYc6EE+Bbij0nHgF2bdfKVoLr/vyO3k+Lov6SgyF6XD+0uo98PFv9KhdSRgAO7qt
	9F+VrF20tpkLhbHWrWiFNySISJGiIMTIfKabFQHxHNbF2oihOyt8wpirsWqgvk8e
	AFok0lGsWbQ+cMbqjDh5Yp9G9+/+cz1BXNInhJWXqL2OxT/Y0uZ0yyibB0RzBmFs
	MLZ+eT4Fxp+qBW6/jZuVjYV4soJYvu5zeC/dXg0iE5z0saDbgxduU2RvwN7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789028285; x=1789114685; bh=IrhIjkq2n9BeX6KsvyC5seIEAgsaAG7R8Ib
	nyt4als8=; b=BakxwjErNm45o5+uNiG+mHwODTRTQ54F18GLMIAAIehznpQS8iu
	3M0vR8gIj8vDdqO9mM1s5nx7/e5sSvU6rOIyR8anG0OFZCijXFZzv7pIl76BKSWJ
	Em5OSTJDB1hjI1HzHd2ClggpCDNG2lirEJ5XGZjUnjry0EA+1cjlPeG/Xl6aAFok
	PCexKL/t2fFuhyWNWyVdJNOxpDFoH9sGv1aV44ZVk18exyL6PCsEUHZCvTZGx76t
	FvjuU6eRztrZNEZ7O1tqvMCH0iVJlUKT1/2uzMtvjuDId3H8J9pwvj00ag82rbnh
	O7+zFA6mm5ExgPMshkFeHk2vPklwJczh1yw==
X-ME-Sender: <xms:vWeialcmxtCctw9FkB--D4rOcCFvv_GNkQN1ohzSsHOegY_xXP_KXg>
    <xme:vWeiaqFjMdBFRYmL1w1wtn2p2-iikAm5FJHikKS9agBuFsotISI7SIByZPidTi_kM
    Ffc6XiHvyQsRvVaiKrMSncjUgyIIwnhXuG-gEm0S8TAdJTGPNGJRwk>
X-ME-Received: <xmr:vWeiam2kCB7qnPG09zcl5aeAh4Un8n9ro3W6psnon87k2bF2TNW7tA>
X-ME-Proxy-Cause: dmFkZTE4RxuyZpgams3QxL/rmoIyD5iaoYjJAm3J9H/C8Qq7Kowt9gjq89C/x1Un96oc65
    f6DpI0xYGwhI1mz1UQTW8azq+X9gKyeB8YWkJdUC/M83PQX5n1BT+NPJCJnvalPNNY+xik
    n3FRid26JbE76+T3iZNUThwvqfAKGHrbAjAFjAekUggvfMFZ0vmtNXFZYdptvggR4p951L
    IPKoB49uxJulL7JbQcmvuMPqpLRpQU0GBGHXv1ZmCVK/WmVvlnEdxI439pCkX1J1qpTTIT
    VA9697V3Vey31OXmNiB8SDluUBaQkFhLEpd++he1YZghJ/sZBhgrrwRqzMuUrgPiQ+0XmX
    P6jEnbKDQCphJ6xqQS9sGJULNAWGnb4j41whswMbE5ycSltroeUG8nBPp/koHQhHrDeGob
    jCZdP3l/kSiJGOA+KtrYJOrN3nK0xRCP1Wnx/VkQi1uKAT0ieyZ0c42x17YkVld9h2ULuC
    Tjr5yw5zrYIa6MbX6FUcjSUsYMhFNcWEZ8JE6dMuyanUqSKTIXHJhGAyBtDHn96ma6Xqhq
    pUGU/0qR4wxvsVRSRux45hGw3OnIPJuNKJ8AetWrohp7hSMWyNWVBGWbnRn7Sg6Cj/bB8T
    0kTvfq4JD0w4TYWILd6pdsLDnOVrDm17od+Q6nsIuo2vTYxJ9GJDdGd/dxJQ
X-ME-Proxy: <xmx:vWeiaqkahS1U7PKQcjK6XJ3vDSMOXJJNtJ9eA131cZIcBnQZ68CXmw>
    <xmx:vWeiau_sgU4TgVsmc9qC65D68bRzu9Rz_o00BcprH254LYQ1AGrRsw>
    <xmx:vWeianr1gNq9oBrwQwYdg5Mi6YUGRVWm7pm-iNmeYasIKDx1zCLT8A>
    <xmx:vWeiavloJVQljPRe89N-UTjanBnQ1s2ysgPz8ewSVrlk2JwTp0ygxg>
    <xmx:vWeianoU4ybC6JgSzLIS9Njc74eBIlRqY1Te9UcW1VMbhuE9NLCTP3Vj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 04:18:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ddc2124 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 08:18:02 +0000 (UTC)
Date: Thu, 10 Sep 2026 10:17:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] doc: fix conjoined maintenance strategies in
 git-config(1)
Message-ID: <aqJntwrjC4ImuSyW@pks.im>
References: <20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.com>
 <20260910-maintenance-doc-bullet-fix-v2-1-3ed1c75e24b2@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-maintenance-doc-bullet-fix-v2-1-3ed1c75e24b2@brighamcampbell.com>

On Thu, Sep 10, 2026 at 12:52:31AM -0600, Brigham Campbell wrote:
> Fix conjoined bullet items for the maintenance strategies in
> git-config(1). Reportedly, asciidoctor renders this document correctly
> both before and after this patch. asciidoc renders it correctly only
> _after_ this patch.
> 
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
> I wouldn't normally spin a v2 this quickly, but Jun specifically asked
> for v2 on a thread on the "what's cooking" news.

The pacing is totally fine, it's been multiple days since your v1.

> Patrick, Kristoffer, if this revision is to your liking, I'd appreciate
> an Acked-by from either of you. If not, please let me know what to
> change for v3.

This version looks good to me, thanks!

Patrick
