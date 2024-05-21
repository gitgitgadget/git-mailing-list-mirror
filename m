Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B35579F
	for <git@vger.kernel.org>; Tue, 21 May 2024 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716332690; cv=none; b=BAvg+gLAiS9mpee+p+qAHk4FH2g9zVNyXTmSQ2XeCYUA10tzVfAZRfsGTGhXQaJ3zhViXKkH4xc+o01oJu066bAb3HM2DkTszboewajhy2Y+6vRGaTEANwo8cLzrwOUNbaIfHf0n3N3NG7PU5EBqIkqjb1UCqTRQopy7k95L2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716332690; c=relaxed/simple;
	bh=FYf+j0n2Jq3Gkh7oMcXW4/N67enhcMjLcG/UuGGfm9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PDjKbTFrTd0ARgENZiRrmJ2kqPa2CuDIyFSGfjBF83bYOoc414xxe1SjRqN/y3rmZcbzt3Un6leEy1YaPQe75sTRc+r9ICPI9vC+aZP1QFnfpnX0Tvlt7fggAvgbfRMTHck7dOZwX70fFlyC/mRXZjpYl9cdEO3vA+2AKNVlxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kH/7BFou; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kH/7BFou"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 815A1324B0;
	Tue, 21 May 2024 19:04:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FYf+j0n2Jq3Gkh7oMcXW4/N67enhcMjLcG/UuG
	Gfm9Q=; b=kH/7BFouU1fy6J+Q/A2mqBDgBHvDNgOaBu4O09OOIcUor5CwK3ftfQ
	IhBGk8TI+Td/BP5SdU2C+v/dA8nsex86RTxZnef9BfrqfGFCFbDnKUp2YEFPOOUn
	85ZIQcllvHpt3MzEWEgYz06ytomgp0sgTLsuWUqpg3sdzFVqqKwCQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 797EA324AF;
	Tue, 21 May 2024 19:04:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 45367324AE;
	Tue, 21 May 2024 19:04:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/6] Various fixes for v2.45.1 and friends
In-Reply-To: <Zk0hKCsbjFGkguFQ@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 21 May 2024 22:33:12 +0000")
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
	<Zk0hKCsbjFGkguFQ@tapette.crustytoothpaste.net>
Date: Tue, 21 May 2024 16:04:43 -0700
Message-ID: <xmqqv836ix6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 83BD804C-17C6-11EF-AB47-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I looked at this series and seems fine.  I tested it with the latest
> HEAD of Git LFS and it seems to function as expected.  I appreciate the
> prompt fixes.

I've merged the 11 patches (the 12-patch series without the last
step) https://lore.kernel.org/git/xmqqed9u95l0.fsf@gitster.g/ to
'seen'.  These 11 patches contains Dscho's 6 patches but also
contains backports Dscho had on his "tentative" topic branch, plus
two additional backports to help tests pass.  Additionally what is
in 'seen' obviously does not update GIT-VERSION-GEN or add new
release notes files.  Other than that, it is the same topic, only
done in a bit more open way to make it easier to apply further
polish.  Testing is appreciated.

Hopefully they can be merged down to 'next' and then 'master'
soonish, but will be updated if a new issue is discovered.  After
then, we'll do a release engineering to merge them to all the
maintenance tracks affected by the recent security updates and we
can go from there.  Hopefully, as not critical vulnerability fix but
a "layered defence" on top, we probably do not have to merge down
whatever additional follow-up changes beyond the latest maintenance
track (i.e. maint-2.45).

Thanks.
