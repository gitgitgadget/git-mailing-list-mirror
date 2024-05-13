Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383E37153
	for <git@vger.kernel.org>; Mon, 13 May 2024 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626273; cv=none; b=ZrxQAyoJVCc2xv9gR/h/BFFoNAHFh2whUMN/Y/aTTrFx/NAP6+TSYJl7dj62XLH9uqUJxiHTbarIdnuhYMOET0quZdoxJke4F8MfCtzUlfed4oniirCExYXWpSt0tA/xws2aMWkZRvveOjGMmaxpiNeJEeDhMKCehD/fm6i/KBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626273; c=relaxed/simple;
	bh=iP9rmG7BYY2zyKTS0SVoa7nT/C1c9Cnuc/z8/b6vgKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=StzyGvB932+4Hr7SBKiq9g1jmXiLDutIm7PzrENIYU22mmWKPkncgYGt3YNVrQ0V1x6YHREATL+zgC0idBK98Q1TW+1Je0N/mk2cMVyPMcjKsI91z5QbprxWjSQJ7Q196N7eefSBqjWh2YNH3qNu5nFG1KCbfx0+DFcMqajnB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g5+deQeP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g5+deQeP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E31AA356E9;
	Mon, 13 May 2024 14:51:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iP9rmG7BYY2zyKTS0SVoa7nT/C1c9Cnuc/z8/b
	6vgKI=; b=g5+deQePNLGhU5d0Us+60Li+gSTS6QAxoygfhtyBTum62CbrNnh/Xu
	Jve36Gk4lMxdZ/bq45+jROB/gpchLVg68dsrUvJLvwqPyKIEethGmXa0Yv3jxrSQ
	HAFdIvMxCbO3y89Hh15NeikLtdvrIac0fNcx0ROPFqk6kbKGLl4cs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA003356E8;
	Mon, 13 May 2024 14:51:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 353B1356E7;
	Mon, 13 May 2024 14:51:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sean Allred <allred.sean@gmail.com>
Cc: <lbdyck@gmail.com>,  <git@vger.kernel.org>
Subject: Re: git client enhancement request
In-Reply-To: <m0pltptx3h.fsf@epic96565.epic.com> (Sean Allred's message of
	"Mon, 13 May 2024 12:56:02 -0500")
References: <02f201daa547$503df630$f0b9e290$@gmail.com>
	<m0pltptx3h.fsf@epic96565.epic.com>
Date: Mon, 13 May 2024 11:51:02 -0700
Message-ID: <xmqq8r0dfsvd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BFF9F09A-1159-11EF-AC8A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Sean Allred <allred.sean@gmail.com> writes:

> Is this even technically feasible? My understanding is that
> storage implementations of each forge vary *wildly*. I don't believe
> this would be under Git's ability to implement as a project.

Not just "storage implementation", but some things are totally kept
outside the control of Git proper, including user and repository
management.  Creating, deleting, and modifying authentication and
authorization details of these things are outside the scope of Git,
and forges build on their competing designs.


