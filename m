Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E221F76B6
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239857; cv=none; b=K9RKyJ3osLa0LcEbdBrqawoVoDEDyLdGeXsqGRomZ5eyZGjQMY1J1nSVpFFdpSonBGzplYUzseSY0dRxXAM6sr9U4Yq38BDw42DY+9CGNftIAmr28RLQbbr1Vx+54kNGQivM7zNEEpcd4rAYPqnNcSQJFazyhJwbJ4JQOvZHiJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239857; c=relaxed/simple;
	bh=RBxWz5b+X6YX+y5MnXrmknXZCjsXmbCkUmLTtsNoqeQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dk+ityhFh0Mx8+hVt0v0pvbdrScSWvZQHP/5ZW9Yl7P5JkcAl+c1V7EIa8F6tkphYdcXYfo8/hvEq+/+TU6j4wxGkEgkSUamwd+514wa4jQQnVFeOAUs3wWfCUNrhIE/lm/6ufDojqFZ/Huxi2dPbx12cwxDlY7ziaIG0AbUgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=sgsnDCs8; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="sgsnDCs8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1733239849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m0oYdg1ueg/GbNL0Ub6sJi8mJ8vRNV13hOo2tYW12k8=;
	b=sgsnDCs8wa4tCUDDddonZuUiiIZ0XMHTCu0GIwDeagYvVN1AHFv1tGnDtpkJqXmmSrsSlO
	1AScxId2KEEi+GkF6plYuP9xLymQPQJnJF0JUp5DmUsoJhrF6DJn+f7qUwIiJtbA0J/Epk
	CDD7PkIvg7rb/I2I6/z2I5tcKQP7isY=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2024, #01; Tue, 3)
In-Reply-To: <xmqqed2pcled.fsf@gitster.g>
References: <xmqqed2pcled.fsf@gitster.g>
Date: Tue, 03 Dec 2024 16:30:35 +0100
Message-ID: <87a5dckcmc.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> * kn/the-repository (2024-11-27) 10 commits
>  - packfile.c: remove unnecessary prepare_packed_git() call
>  - midx: add repository to `multi_pack_index` struct
>  - config: make `packed_git_(limit|window_size)` non-global variables
>  - config: make `delta_base_cache_limit` a non-global variable
>  - packfile: pass down repository to `for_each_packed_object`
>  - packfile: pass down repository to `has_object[_kept]_pack`
>  - packfile: pass down repository to `odb_pack_name`
>  - packfile: pass `repository` to static function in the file
>  - packfile: use `repository` from `packed_git` directly
>  - packfile: add repository to struct `packed_git`
>  (this branch is used by kn/midx-wo-the-repository.)
>
>  Various implicit uses of 'the_repoository' in the packfile code
>  have been eliminated.
>
>  Will merge to 'next'?
>  source: <cover.1732618495.git.karthik.188@gmail.com>

I did a thorough review of v7 and did another pass on the patches of v9.
I don't have any more comments. The only thing left is whether the
comments [1] & [2] from Kristoffer require a reroll. I'm fine either
way.

-- 
Toon

[1]: https://lore.kernel.org/git/9ca6bb8a-6597-400f-860f-3546296c441d@app.fastmail.com
[2]: https://lore.kernel.org/git/69d332a6-fee3-4801-b920-e16da730c1c7@app.fastmail.com
