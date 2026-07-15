Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00244C65F
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118511; cv=none; b=dbb+x7nGk9E53UYL0hjUZ5cnhKoyKNGhLnt4omgoFHiIpDoDKa0wUn8qvj1uTQ18woja+tMfIgtLNYIrZoHxGZVXYjLsviiTLm1N/WmnO9mRGCyJuV7NOcldnuvY/Fs/AflJGugw6IlKx26Qad4S/6+BxGKOtnKuL9KXraccppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118511; c=relaxed/simple;
	bh=pgmJwkcHP444Drtwf4d0HIvsuUJPsPTRCkLib6gVtlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uIAoOP+3sVQ8zxq/7GVntZPPJnZO1RPRuxc8mjRjZBLNmWWWqiCaI77YI/HNahZvnSOXYR1mPeuZ8tOVEVlKLeMGbZ1jPbrOFUOmd8aXiy27K1l3xyJsx/KDPq4lA9XZ8CUeWBZY35rpJsV8rWUZzSXiVIHilDP86wEW3qczn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=H4ZEfal4; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="H4ZEfal4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784118505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TjJDUrGuVS2Yt5lu+Akk8zoapmj+J5WT1x6aFQ3u4T0=;
	b=H4ZEfal4uM71wsJ6g+eTiMgLktqeR3hrhGB9j08W2Sfvsmu2pf290sfn/xqhgCW8uQiFw2
	x9jvpezaKDMNod0pPgTm2THrxHebwITzQtQSLBl4KCrNnLY12vKC2LHp79lGbu0pe1F7z1
	e9gCGaNGUm4ADIO93+/S0KVik/LmLOU=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/7] refs/packed: drop `USE_THE_REPOSITORY_VARIABLE`
In-Reply-To: <20260715-pks-refs-wo-the-repository-v2-2-d00d364f5a3e@pks.im>
References: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
 <20260715-pks-refs-wo-the-repository-v2-2-d00d364f5a3e@pks.im>
Date: Wed, 15 Jul 2026 14:28:20 +0200
Message-ID: <871pd4h1y3.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> There's a single user of `the_repository` in the "packed" reference
> backend. Convert it to instead use the backend's repository and drop
> `USE_THE_REPOSITORY_VARIABLE`.

Well, this was removed in the previous patch. I'm fine keeping this as a
separate commmit, but the messaging is a bit confusing.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/packed-backend.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 14b27d24ec..c5d96793fa 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "../git-compat-util.h"
>
> -- 
> 2.55.0.313.g8d093f411d.dirty
>
>

-- 
Cheers,
Toon
