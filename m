Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2533305057
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087057; cv=none; b=tg1x1wqWWV4FtsyxQBH3jPUKvqU9p+7vD9B7EIYyNfe+ACGTEYP2BOzWUY8C7tdeB2s5FyAD8cKh8gCzQxzP2g86pvvFh2V0Lxp2VBNF5Xtb//qI263nTzK1XjWX53aw7JCfsYNQwmiGG4aYvrZgjSrOKdL9Wk0ZEZdom3cWTTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087057; c=relaxed/simple;
	bh=wamw69lAQQKxxlEL5MLjzEEgudji/fLnzzUPbToLRaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qzj+I0Mr44FjYq6zzvzBp6LJrNAMTwp12ew5V3/MpTWlwvmw6nPcKgeNN7NGWaQJX6ZxI50hEX5TwyMpzZ4ysvSuKqxQo6tRJGe085aGX4Sa1kVVSHjSy7K2oMIaj9EIVN2lfFDEdiOli+QG8doOcyNouSd+C678BVSyv7C6uM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VwdQDZP2; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VwdQDZP2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1786087050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lZfCSMxOnrVcQiUCtKdD4x7TgswfRrpT4LV3bBv8yZU=;
	b=VwdQDZP2hcE18mCWkeB8CbMD7hHs0Nw2kOElcfyyJQ/klbOaVQr0uXThD1ZZ5IRovcFE9a
	8sM8Gh2XYPLBF0VKU2mzFQDhLZEpqdyL/Iqnb5h2ATobk4SlpovYC4sWHkMeQwLO6SJBjD
	kwwwqAc2I8rKgtQKiCrw4V3NoMiz+zk=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v5 0/6] odb: make creation of object database pluggable
In-Reply-To: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
Date: Fri, 07 Aug 2026 09:17:25 +0200
Message-ID: <87jyq24cxm.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> when creating a new repository we create a couple of on-disk data
> structures for the object database. This includes the "objects/"
> directory hierarchy with "objects/info" and "objects/pack", which are
> specific to the backend.
>
> This patch series makes the creation of the on-disk data structures
> pluggable. While we continue to always create "objects/" regardless of
> the backend (it's required for a repository to be recognized as such),
> the other subdirectories are now created by the backend. This will allow
> other backends to plug in their own logic.
>
> The series starts with a small detour into the loose-object map. This
> detour is required so that we can defer initialization of the object
> database itself to a later point in time.
>
> The series is based on 9a0c4701dc (The 7th batch, 2026-07-22).
>
> Changes in v5:
>   - Remove a leftover formatting change.
>   - Fix a stale comment.
>   - Link to v4: https://patch.msgid.link/20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im

I'm completely happy with this version, thanks for bearing with me.

-- 
Cheers,
Toon
