Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E212BB13
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263142; cv=none; b=C0Wcf7QBFK84WCDalXIF0bRG2oYgs9RWm3Gs7km4N6nj7OyLeBUCeXZynDbeQ1MSwmrL4b3q6HEA7Ca4jjkOF5bRcPG5fxWF2lyGfimsEQdl9XSIANbyeu6uNhR4G6BggdOmp5lndwT/TplXS+Oq01DIyV6T4BJ/Ugto+Ju9y9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263142; c=relaxed/simple;
	bh=mtxV5dWic5FRZYIIQLhi74UWrRJmzHil4sgHIjW337A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UK41PkwHpqU0PMYz1mPYhNnwH86hHp553A8HnQbE9X2KSc1Xl7MKvl7PVSFAdV975+TLZoDKyeGkTf0h7H5YMAfAoHXwb4hMpDd8pyIfSZ/5W5bB9Rfdw9EvSKR6ar86/gQYinv5qFg1jm6BndPt6nYFs3ZdeI2K2mOcmOdoTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jhm/3Zsh; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jhm/3Zsh"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 478AB2AB6C;
	Fri, 13 Sep 2024 17:32:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mtxV5dWic5FRZYIIQLhi74UWrRJmzHil4sgHIj
	W337A=; b=jhm/3ZshJ+EZDKAbOKCugMArqwLJM/ywhEcsrkYzssdVDs6sgcIJZo
	5Y+MgzzKLRKDQxym/BAjCzD0mLnOZPC7lnyj/wD5MEBO09MQM9rHCTXABVUk/9Sk
	MlZAHBvY5mXbUjGkwu6Dy4cVCE+E+xSUrbxTW6S1DGm3Mudpejaak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EEDA2AB6B;
	Fri, 13 Sep 2024 17:32:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A83A2AB6A;
	Fri, 13 Sep 2024 17:32:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 2/4] builtin: remove USE_THE_REPOSITORY_VARIABLE from
 builtin.h
In-Reply-To: <7becd3751fc73a51a1791427b2232fc94f1c9ae9.1726262178.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Fri, 13 Sep 2024 21:16:15
	+0000")
References: <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
	<pull.1778.v3.git.git.1726262177.gitgitgadget@gmail.com>
	<7becd3751fc73a51a1791427b2232fc94f1c9ae9.1726262178.git.gitgitgadget@gmail.com>
Date: Fri, 13 Sep 2024 14:32:17 -0700
Message-ID: <xmqqcyl7w87y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A730204C-7217-11EF-BC7E-9B0F950A682E-77302942!pb-smtp2.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Instead of including USE_THE_REPOSITORY_VARIABLE by default on every
> builtin, remove it from builtin.h and add it to all the builtins that
> reference the_repository.

I'll do
    "reference the_repository" -> "include builtin.h"
while queuing.

The next step removes #define from the ones that do not reference
the_repository, and because it is not empty, by definition, this
step cannot be adding #define only to those that reference
the_repository.

> Also, remove the include statement for repository.h since it gets
> brought in through builtin.h.
>
> The next step will be to migrate each builtin
> from having to use the_repository.

Thanks.
