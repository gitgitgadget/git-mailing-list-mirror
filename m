Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F871531C5
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985253; cv=none; b=PyOd1tT7aGnqFg4lJ5tPWpHQ4qPdpmur5hLyRdgW2RfWpGS3DJlqeBiQvah4cQXY4BZ5Eabn9hmd8T+WnJnGZmjjJgnD8ZYocw91msGD5Ase644fbO9g6AXvwTLrI/L5/RKItRCSDIaI8I4NS9OnGwFfwkQRZibXbVBZWVcpkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985253; c=relaxed/simple;
	bh=jltsxyQ4JV0DnRPrmIHyJ2WzfAp6KiN6qJjqq32fdZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JPQbs+8X2R2qHHMZVaFtPOrTrI8+c0oF2r49m66ApSu2kW9QPc8FTA+NcNtzLSUyiIw8Py/h6gKxC74j+l2mYajJPc/vuF/EuUu1txQke/cA0aTHrSdJZDxPURxoWzKg8/OIee2Py1LROjugcMPDFgxnLwjWHbXy8KH/33lMu2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s4dN2nSb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8e5ZIuW; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s4dN2nSb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8e5ZIuW"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 708C01140120;
	Wed, 26 Mar 2025 06:34:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Wed, 26 Mar 2025 06:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742985250; x=1743071650; bh=nUxJqhWspg
	TzYSfR2oS0k2TfZDi4t+m6NgdfPVSoiwQ=; b=s4dN2nSbn+ywb+kXJme1UUfWrL
	VIj6ZE+MtyV0tYneFTlkKspE0DV8NSKJXYIh3hHmlPMJFJ0aGWCVcOpI8S5gWZCm
	N7zqRMR9qpgRNkRK0vO7ZHNy92g2y7s1OzfnFsg5cdO3UrFS0tyNJOBqMwbte5yJ
	xsrasCpiDYdwCMGiWhgcki3dmlSc5Q71Wr6S0Thw5J1jPHCFAPRbCTUlhIfWzDvh
	H5G23vQ+FgUXsjzLvNnysu0qef7RFD938wGZRNrJTKXkvoJ+TO6E8ruITZ6rFqGR
	TGmQ/TYUIrXqcl9rD15k5/mA04tZx1EAOfab8nNLv0yJ4zhh6I2ZTzenctUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742985250; x=1743071650; bh=nUxJqhWspgTzYSfR2oS0k2TfZDi4t+m6Ngd
	fPVSoiwQ=; b=F8e5ZIuWgyU73xY69fa5Sj4dGS6FLvXEsjj5wsVIuJqQcf7S6qt
	/Ifghn3dzSgkZhVJ5K56QVqZyhcCvn36OCZxKjXCczJxRGaBFb+3wXqaVIzIllqS
	kVM9Kn4QgfJIkEHgI7gz9vtFV+N3CJtb5oO+smEdJdWq8SNWi7esVGLBwp8fcZ3J
	Osuxwz1nhtyxNIFb1FM0hGzd9QT3sH8tNoNOxce8SAaXUBLkilzwuA7i4n7/IZOH
	Hsi1aHuB5WmTqp47z9q75qhmK1CyCUrt8cRDqCm6fUpDX0JDLchdsH51pkNpcXsU
	h6ANxhZPe62yleuzXghG1xfb0oYFyTFE41w==
X-ME-Sender: <xms:IdjjZ_EtvZmYfB6yyWUXyi4Gj3iXgvilDCX7SiGJ661b4154iwZxnQ>
    <xme:IdjjZ8Ux9QzjuNIUn4SPF4atgDu1nKx6IbrYyFgky_MdYtQEAfzF-pHksk9-3kv0B
    UeJ0L-yOK6DBYOTRQ>
X-ME-Received: <xmr:IdjjZxKHGX5SkQduRu0YbItx8E23Pnw8YVU-AL75gOroL_JhDrQ11jrVlaxJybPCg4gnYebsBrj5OQWK1wN7Mv7HGyksQM9YtYhGzpk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhhihhlihhpohgrkhhlvgihsehivggvrdgvmhgrihhl
    pdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IdjjZ9EatAUcI8UsYEV1nponj1vY3VkTvPY8nvXl2nkBUZdzKx9Tqg>
    <xmx:IdjjZ1X1tnC1QpEjRu7NOnJ_LMzLyWXf7gepMEiiEakoR0kuGcNnDQ>
    <xmx:IdjjZ4Nvk7_9aJcIlzPaEpZJQl3-GcLBS0IHU-nnaWQowU1ptMkySg>
    <xmx:IdjjZ02-V-EByBt2OK_O9OKxbyBZCaa9y7dLjDCLdWeM4wtFu6qbGg>
    <xmx:ItjjZ9SRuX7G6wWijM9A-eOkoQn7vqFibc_pPmIUfuLMlyWzKTPd_pNx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 06:34:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Philip Oakley <philipoakley@iee.email>,  Patrick
 Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>,  Jeff King
 <peff@peff.net>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 07/10] wildmatch: explicitly mark intentional use of
 the comma operator
In-Reply-To: <a7506e7b-f86f-426c-b816-540be282518b@gmail.com> (Phillip Wood's
	message of "Wed, 26 Mar 2025 10:14:32 +0000")
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
	<pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<9a6de12b8076266fb0c88f6b658c20d37409ce13.1742945534.git.gitgitgadget@gmail.com>
	<a7506e7b-f86f-426c-b816-540be282518b@gmail.com>
Date: Wed, 26 Mar 2025 03:34:08 -0700
Message-ID: <xmqqtt7ghyhr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think that would be clearer, something like the diff below
>
> Best Wishes
>
> Phillip
>
> ---- >8 ----
>
> diff --git a/wildmatch.c b/wildmatch.c
> index 8ea29141bd7..7230544c356 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -223,7 +223,7 @@
>  						p_ch = '[';
>  						if (t_ch == p_ch)
>  							matched = 1;
> -						continue;
> +						goto next;
>  					}
>  					if (CC_EQ(s,i, "alnum")) {
>  						if (ISALNUM(t_ch))
> @@ -268,7 +268,10 @@
>  					p_ch = 0; /* This makes "prev_ch" get set to 0. */
>  				} else if (t_ch == p_ch)
>  					matched = 1;
> -			} while (prev_ch = p_ch, (p_ch = *++p) != ']');
> +			next:
> +				prev_ch = p_ch;
> +				p_ch = *++p;
> +			} while (p_ch != ']');
>  			if (matched == negated ||
>  			    ((flags & WM_PATHNAME) && t_ch == '/'))
>  				return WM_NOMATCH;
>

Ah, I missed that "continue"; with the "next:" label, it looks quite
clear what is going on.

I like it.  Thanks.
