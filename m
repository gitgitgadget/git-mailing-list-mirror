Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B401640F
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x/aiWDDf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C74F21F20;
	Fri, 12 Jan 2024 16:37:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Whlzg7QQJeMwHMhy2c7KoXeEVBgupwhYv/eAXG
	KXfAU=; b=x/aiWDDfg9GFFP+KpJMO9QWqwAFRXv1VxNIeO+9OqgVJfuVFQjt4oS
	WdpEWIs5OtU5FAEb47Nn5Y7+cQebqVDFdF6ADOG4kYbKqeMe0jUbJILUNjTyUWQe
	Is9zBern15NWpF5cm23US2Ojir8ZvDFiGHqNGJPS4PayLVYfAEefo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 94CB021F1F;
	Fri, 12 Jan 2024 16:37:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DFE3F21F1E;
	Fri, 12 Jan 2024 16:37:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Raul Rangel <rrangel@google.com>
Cc: git@vger.kernel.org
Subject: Re: Make git ls-files omit deleted files
In-Reply-To: <CAHQZ30Ad6+YM9qnCOeNNy8e2k-AbYR_bBXTups-7z6=ioyqS5Q@mail.gmail.com>
	(Raul Rangel's message of "Fri, 12 Jan 2024 14:19:34 -0700")
References: <CAHQZ30Ad6+YM9qnCOeNNy8e2k-AbYR_bBXTups-7z6=ioyqS5Q@mail.gmail.com>
Date: Fri, 12 Jan 2024 13:37:28 -0800
Message-ID: <xmqqply68c87.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C984DBC4-B192-11EE-92D2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Raul Rangel <rrangel@google.com> writes:

> I'm trying to copy my current git worktree to a new directory, while
> including all modified and untracked files, but excluding any ignored
> files.

Curiously missing from the above is "unmodified".  You only talked
about modified, untracked, and ignored, but what do you want to do
with them?

As you are grabbing the files from the working tree, I suspect that
you do not want to base your decision on what is in the index, which
means that ls-files might be a wrong tool for the job.
