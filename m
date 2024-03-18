Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB881367
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779471; cv=none; b=YWy140UnuXWxm6r3vpiXmtZ0sEQolTBWSrVMyX5zLbEjoAbWUEjk9KFIw2R6UAxcP8LWsqn2WNW2a83VEZ+U9TdWbCbZ+bg4Ow4o+QqktSSTEMx7sZiYyrF+t43LmhlS7TTppw4hCbzPsiVxgUhotZsdAUUogSpDp+SwaddF+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779471; c=relaxed/simple;
	bh=HYWxsFyO+bHuGu19BwWO64/Xy0HCe6lPxt1Njs6W7P4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g8n9Rcos4NGSwz64VTGhyJE40RPSHZOFcQKjjB0VzNYv9vd0KRMy3ozK7bHCNq5AIVVhr9G2pCcml8GUa36LU7RIjvhk+jl9+ZUrqP0r5/Mj7HsDZmkiaMIxX3IsY2CaUrmY4rT74aswib6Wpdl4tXksdNzDsgV0ACdB43ooDqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bhEQNpEA; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bhEQNpEA"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CFA52E266;
	Mon, 18 Mar 2024 12:31:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HYWxsFyO+bHu
	Gu19BwWO64/Xy0HCe6lPxt1Njs6W7P4=; b=bhEQNpEAyVzcXUvrOnfGj8fxZ2LP
	OB0p7ya2aN18DtwriJkOhFIdaFtXZYdFtTdaTNInonlxzbKqG9QHlOVK61Uo1hVl
	e60Cz7+1hxS6tP9sMumc8XBbxuDSvnG0NA+DKOwMwJociDMyd7rMpo2dCE7aR2US
	npQOPJNucDAke6c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 641382E265;
	Mon, 18 Mar 2024 12:31:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B0772E264;
	Mon, 18 Mar 2024 12:31:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  ZheNing Hu <adlternative@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 0/2] Allow disabling advice shown after merge conflicts
In-Reply-To: <pull.1682.v3.git.1710623790.gitgitgadget@gmail.com> (Philippe
	Blain via GitGitGadget's message of "Sat, 16 Mar 2024 21:16:28 +0000")
References: <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
	<pull.1682.v3.git.1710623790.gitgitgadget@gmail.com>
Date: Mon, 18 Mar 2024 09:31:04 -0700
Message-ID: <xmqq5xxjjyd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 EB247B00-E544-11EE-8C97-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series introduces a new config 'advice.mergeConflict' and uses it =
to
> allow disabling the advice shown when 'git rebase', 'git cherry-pick', =
'git
> revert', 'git rebase --apply' and 'git am' stop because of conflicts.
>
> Thanks everyone for the reviews!
>
> Changes since v2:
>
>  * expanded the commit messages to explain why the tests for 'git rebas=
e' do
>    not need to be adjusted
>  * adjusted the wording of the new 'advice.mergeConflict' in the doc, a=
s
>    suggested by Kristoffer for uniformity with his series which is alre=
ady
>    merged to 'master' (b09a8839a4 (Merge branch
>    'kh/branch-ref-syntax-advice', 2024-03-15)).
>  * checked all new output manually and consequently adjusted the code i=
n 1/2
>    to avoid a lonely 'hint: ' line.
>  * adjusted the addition in advice.h in 1/2 to put the new enum
>    alphabetically, as noticed by Rub=C3=A9n.
>  * added misssing newlines in 2/2 as noticed by Phillip and tweaked by
>    Junio.
>  * rebased on master (2953d95d40 (The eighth batch, 2024-03-15)), to av=
oid
>    conflicts in 'Documentation/config/advice.txt' due to Kristoffer's m=
erged
>    series

Looking good; will queue.  Thanks.
