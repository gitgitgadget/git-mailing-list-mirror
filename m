Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E148A1E4BE
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578964; cv=none; b=r4EdVw/txCJagQMaZ8ZJa9SKOWW/Mcg1qv5NcMn9aKRf5CiVsvyxoNhljS8KHcUSOLSw6wfqco15zZxVl5I+FsnnW4dfrE1QXsccx6U6MQ7rxdfME7VnAd+lmuZinaHm0yj6vO/SpW5HpIl7TGvEIDxrXEE5PYpMquG+ZsAPrS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578964; c=relaxed/simple;
	bh=GWvEkYM2KqSq4cARruy3TdVJo+sOMZLoVASnaRzqe1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IJaOR8twxKvwIJzqmqVE0IJy1cSXppx492y2W4Vq/DXqfdxa91QhkGS6tbNV9FCNITbH9DJD1nxg9+eyNe9ESNf/47cqEW+QplDlAMdULBkhE6oifN2eIMzj3R9dfXC2754tUQ/hTmjuWi+cYfUDbmC+h1GESQm7F0i/TEzeBHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VxsIzUqt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bq3fg7L7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VxsIzUqt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bq3fg7L7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E661C1D000A1;
	Thu,  7 Aug 2025 11:02:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 07 Aug 2025 11:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754578960; x=1754665360; bh=IZfSt/lMIl
	mVRwpPiybfObbwksjaefgtP0BfFjMCgO4=; b=VxsIzUqtngXMg2NDpqz8GtWN+2
	qR2l6T4IbWnge86nBOaNIL39aftQisPoaYcmlwdLeMB1wI1nCqSG5W1Di4/AoJL6
	QKSzXA7yN6WN2P999xPr2oag3jh/WpRWy1GUn1jIkD05fnt9HvYga6fQgf5glj4u
	Fh8sEi1OneuhN9qPqEA5LHfo0SLtbGMpBrQy+44YLYJvbsW9/mFI7WBp3Ll8ttyD
	Ho7hOxNmQu9c8NDq6uPxsVkdAZDQkpzkDylmEmdVpz+8Ja69NIZk3eKQJ5oqLPRb
	r96i/NvAZnyHeXn1L7qsHkK919mFJLL+eoInKx81xX2cdVNInYuu9g+EASBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754578960; x=1754665360; bh=IZfSt/lMIlmVRwpPiybfObbwksjaefgtP0B
	fFjMCgO4=; b=bq3fg7L7K0VC4xk2P/O1RFymgR+LoE+56zERBULHacOlYxqEnKA
	OVCiPa5U+2gp51lFUPU3sXPyyecjTXh+WPVyNKUPHdiSn0CqkMUcLuXoCbFamM4f
	eEjrK2iFtlQmZAMec8rfLV/ZCGc9KJbBSvq3GDyYYSdbygjapCnYZZ0JyLOs7tRy
	Snainlkryk7c8nb76VPPpnDMVUOtiyKWN15YrUp7ocnl6OwYOchAGZNsxjpNCBVV
	zh6oN+rqfWFzy+jG/k0bCINoMnfHJQGvkhptuWXCj2YXi78T0VOK5hcVkZNRJzUH
	Ee/gSdF8Cx70DyHxlugltRsB1s7KAmpBLmA==
X-ME-Sender: <xms:EMCUaKHVmwfaEzVdfjUzqf6zCUXGYqQBNCnsbF-OjNb44aweasj0rA>
    <xme:EMCUaF6pnjsuO0VBfQ6LTA2D19L_b18GiSywlTQMsjerpMIPXKcMgQPEPyTbm_SHw
    1vVeTzDp2gf3rdSng>
X-ME-Received: <xmr:EMCUaAufgG7m5ecbH0TxW1jMvBMDu8QTv0LFPAd4rEBAlZXq3c703JupqARS2emM_L2FOuTjEGeUijMEoNdA0dd-fGOW1F4YW56DzPY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdduvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhiuhdruggvnhhtohhnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EMCUaG7PDHFr7uqkj-BQep1ZBIdnPSMSVmzWAcmToqhgSOrGxC_nsw>
    <xmx:EMCUaLVzz5ADuHnaoyNLzJaVajg6scgsz7VMWUhGvantJPH0_-fKGg>
    <xmx:EMCUaI_1DzPq8dNyorU55xEfd_Qc5zTgvxCrGxZIHUJhTib_ByMcLw>
    <xmx:EMCUaHnuapHCAWSbIfQ5z65kdrNKxapZb4Jvqn5sNt-8Qz9w6Cw75A>
    <xmx:EMCUaETrWoc87rvMpbwcTheg26udCUQNnqic0dhRoGmvVcpH9OcwST7H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 11:02:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Denton Liu <liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] remote.c: convert if-else tower to switch
In-Reply-To: <5866818859be97c091c40602974629eb7e463623.1754540903.git.liu.denton@gmail.com>
	(Denton Liu's message of "Wed, 6 Aug 2025 21:30:20 -0700")
References: <xmqqv7n0wkbv.fsf@gitster.g>
	<5866818859be97c091c40602974629eb7e463623.1754540903.git.liu.denton@gmail.com>
Date: Thu, 07 Aug 2025 08:02:38 -0700
Message-ID: <xmqqsei3rx81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Denton Liu <liu.denton@gmail.com> writes:

> For better readability, convert the if-else tower into a switch
> statement.

The reference to "tower" is something new to me.  A quick search
seems to tell me that "if-else cascade", which is what I've been
using around here, is not popular, either.  "if-else ladder" is the
term more often used, it seems.


> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> Thanks for the suggestion, both. Please queue this patch wherever it
> makes the most sense to do so (either with the existing series or on its
> own separate branch).
>
>  remote.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

OK.  Sitting down and thinking about it, the reason is obvious, but
TIL that switch/case is slightly more verbose ;-).

> +	case OBJ_BLOB:
>  		advise(_("The <src> part of the refspec is a blob object.\n"
>  			 "Did you mean to tag a new blob by pushing to\n"
>  			 "'%s:refs/tags/%s'?"),
>  		       matched_src_name, dst_value);
> -	} else {
> +		break;
> +	default:
>  		advise(_("The <src> part of the refspec ('%s') is an object ID that doesn't exist.\n"),

This line alone is overly long; it is not part of _this_ patch but
is showing the state after that BUG()->advise() fix, so it should be
fixed there, I think?

>  		       matched_src_name);
> +		break;
>  	}
>  }
