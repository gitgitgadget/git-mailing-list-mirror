Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46BC12D219
	for <git@vger.kernel.org>; Fri, 10 May 2024 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355329; cv=none; b=eB0C5YRjV+TbLceh0H75n9AJd2TXktseS24XuJ+9T+N6Ms1P3Id8YvsJsGGcyqabWofFzAKQk/d6fROOFoI0cOMRltBN8Wl9RKvMpC7INgjoQx43KIbpqgAq0EzZ8etKUVBWPGSOINPfn3nGbFBR2gt5WsDYizsyXepwUfRqZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355329; c=relaxed/simple;
	bh=ckNQ3occNVmBwxeT/OZy+NajAYQIhrkgDvESrcDgnCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fhhXj1W9vGhFFwW3foH70cW36jxRghsOFh+z5bL63k2ToGI1V2zi7Oy6O9pEZP6srAPVqRVG4TnOnSKTZwQTW66bM7KPLCKpg9CRrrlsO/XPo0qZkFB/NRsgisIQOvPEdOLT1iXCW5pa0/ObfXQFuLUXVmpM21ANUnpWKFJmj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v+9WADTA; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v+9WADTA"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BCA1934C07;
	Fri, 10 May 2024 11:35:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ckNQ3occNVmBwxeT/OZy+NajAYQIhrkgDvESrc
	DgnCw=; b=v+9WADTAZWnwl2zq+ZtSrDAZ3Ep9OP1VJDqOiG9IT9eKsmjZLLpE63
	vWHpENBqNmVizLO4mrsP1HKrvLr3Y5MBQEpQVoGwOyN2nlofQ6649UEsCbTD3ED1
	huKmtyvlR5N5KtjvSu6C+h9jeHuNn5hgJelIqvVKxiMID+DUfXxBY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B547634C06;
	Fri, 10 May 2024 11:35:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 411D034C01;
	Fri, 10 May 2024 11:35:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #04; Thu, 9)
In-Reply-To: <Zj3SsbHLp-gH_Jey@tanuki> (Patrick Steinhardt's message of "Fri,
	10 May 2024 09:54:25 +0200")
References: <xmqqfruqsjb6.fsf@gitster.g> <Zj3SsbHLp-gH_Jey@tanuki>
Date: Fri, 10 May 2024 08:35:16 -0700
Message-ID: <xmqq5xvl7k97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E799D5B2-0EE2-11EF-A5D9-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Just in case you missed it, there was a review by Justin already [1].

"I read it and have no comments" is somewhere between "an invitation
to miss" and "it does not highlight anything, either positive or
negative.  Was the topic that uninteresting and uninspiring without
anything noteworthy?".

There were mentions of a new document for reviewers, similar to
SubmittingPatches is for contributors, and it would make a good
section to document recommended ways for reviewers to demonstrate
that they understand (1) the area, (2) the goal of the patches, and
(3) the implementation presented, better.
