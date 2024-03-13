Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DAF5F460
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370046; cv=none; b=XyiWYvUwuwYHPJYn7ViPl5iUxWRihRt138a0v5xgRKxutxGrFTkU1M/tUVINoZufoTzyhn6R9ROg7/KVdadS+fQ2NGAM8lQ2uMv1EAsRGeWW0eWvdoSKVGwU+vWHyNKA7fRjZH6om1/jty1aihv2dBfsXkw7rwzelOQbl8IoFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370046; c=relaxed/simple;
	bh=M3xL7Rn1fQgtQD2ZN8sCfDwDAQQ7AxhRDx/xt9D7TmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XGMJaKRkJwTEgOVL1YkbMO5+oNExtdqmUEPl/BMLiDN06juM5ehS4WiIVGXhlzZ4V5YdWqFiTKzuhjrZaCKksVDq/CxN4iWXFSF58MjXgcrPlRPgVacx2jj0XEzJDCU2006UESeRawDIrTh/huv0t1xTHwFse9Cjh/nQjzkWOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=It+FhhnG; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="It+FhhnG"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7153D22A6B;
	Wed, 13 Mar 2024 18:47:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=M3xL7Rn1fQgtQD2ZN8sCfDwDAQQ7AxhRDx/xt9
	D7TmA=; b=It+FhhnGFJAid0KiH0sVJj1534EePRXd0Hm8TubB3YO2S6qjJD5ZbP
	A3JxEWxvpLpht8Zj4viOQieVNGzSnmVHevX6/MkbdDjzDtLtqmvWyU9A7Gn8imf7
	ZZGP9A8gEet2dbxA0irx1u6hSTX17y20zPzqPfI8dxqAH8ujuFU5w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 69C6422A6A;
	Wed, 13 Mar 2024 18:47:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 43E3B22A66;
	Wed, 13 Mar 2024 18:47:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "James Liu" <james@jamesliu.io>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] log: make the --oneline option work with -L
In-Reply-To: <CZSZ38DTWF14.3BNXFKTGVPLZQ@jamesliu.io> (James Liu's message of
	"Thu, 14 Mar 2024 09:24:22 +1100")
References: <20240313090841.36717-1-james@jamesliu.io>
	<xmqqr0geca36.fsf@gitster.g> <CZSZ38DTWF14.3BNXFKTGVPLZQ@jamesliu.io>
Date: Wed, 13 Mar 2024 15:47:17 -0700
Message-ID: <xmqqfrwt696y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A5C530FC-E18B-11EE-8B48-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"James Liu" <james@jamesliu.io> writes:

> I suppose it isn't intuitive to me which options affect how the commits
> are presented, and which affect the diffs. The help entry for -L states
> that it will "Trace the evolution of the line range", which doesn't
> immediately suggest that it tweaks how the log message is shown.

Sorry, but you lost me.  I do not understand this remark.

The documentation for "-L" does not talk about tweaking how the
message is shown at all, because "-L" does not have a say in how the
log message gets shown at all.  And the documentation for
"--oneline", "--format", "--pretty" all should talk about how the
log message gets shown.

Anyway, if you are happy with "--no-patch", that's good.
