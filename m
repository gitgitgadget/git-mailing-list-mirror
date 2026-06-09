Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012CF367F3C
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006669; cv=none; b=hdHpbow27DDWadzXX7vprm0BpssbIHhvPkoVGrYd+vcxe9JSnbmHVbCp2Ub4bmjbMopVZcs7ogbMdGKFZsj7qsBTXS0sJ1e3aTv7H0fwForORwRZMhA61hDRFA5coO2gs+SqM7ofLl2ezOtLaSGpL3HYATJcDzyNdt2x0XpBw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006669; c=relaxed/simple;
	bh=NJaufhYErnjzDhyPs/5hXNbMJOhWshHIntT7929LN2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rTl6TPi7E71l+KwxbxqgG9eIxpQi9TpoqsQdHp5XHaiNPMmKIv/KYwweKJENVy5jX4MFnjQolnz4BzpHY2iZ/HPSuyRs1JfXKHZW5QfX0Ggel/XnPUOY/WOzWLWDrRXtWrIMSpblF0ijwz3JTw4gBy7l38sWGVBbMFC43Dpes6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=mUNMs1ZO; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="mUNMs1ZO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781006661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X4XTr+MFljDxt+5c5ORPMHjORpwuzt74jxOLklHZxro=;
	b=mUNMs1ZOyU3eP4Xk+GkWjFukhUbzZHng9XKZf4E0I887GYXcfbVP4jChbDYiqTDOQpZUss
	ECByfu8LVwuw8b7O+zsK2J3HgO1gzsQllbAo1L6NoTkQ8WqJ7uw9ee/aoaTz/WwDkrz4Dc
	K5/OUlKnQpw6nPiujScVMa5WxF40LwE=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, Weijie
 Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, SZEDER
 =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/3] Documentation: recommend the use of b4
In-Reply-To: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
Date: Tue, 09 Jun 2026 14:04:15 +0200
Message-ID: <87a4t32a4g.fsf@emacs.iotcl.com>
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
> this small patch series wires up b4 in Git and recommends the use
> thereof via "MyFirstContribution", as discussed in [1].
>
> Changes in v3:
>   - I wasn't really able to judge consensus one way or the other
>     regarding the deep vs shallow nesting of cover letters, so I still
>     have the change to shallow nesting of cover letters part of this
>     series. If we continue to be split on this one (or if we favor the
>     current status quo) I'm happy to drop the first patch and adapt the
>     last patch to use deep nesting of cover letters instead.

Personally I don't care too much. I'm used to the shallow threading, so
I'm fine with that.

Now on the other hand, looking at a few examples I see GitGitGadget does
deep nesting. Wouldn't it make sense to be consistent?

Anyhow, I don't think it's worth it to keep bike shedding about this. In
all methods we recommend to Cc people, I think that's more important
then caring about how messages are threaded (for example, I've noticed
LKML doesn't thread at all, i.e. `b4.send-same-thread=no` which is the
default).

Bottom line, for me this series is good to go in.

-- 
Cheers,
Toon
