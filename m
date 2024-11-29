Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155D38FAD
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922968; cv=none; b=uAnqmBqDEoGIi6MSPlWeBOiFZvfMNJ0QCGU5edKEz9GGggXILlq3rqTWOCa/AAnkVnvcxhMPKFJboxfUeALW5NHdmMd3zkySM0S5vHPJ6h/dkoVQN/OJWqnKPpQJHgkif9/J4UvX7+6ATLRZJC/n8lQddsUeKy3k7vyZBB1r64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922968; c=relaxed/simple;
	bh=ZB+CZ7Vkg/26fd6kxCetfcUz69OuJ5SKWavu8Ifvqvc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/QIPCY0KyV7HFVmOSLVU+x0EmOmqcrfm0Li/aGoQKcE/fTJsVbIBcc7QLKfZ+oEKRjv1+iy/JTBo7yHw8BUTm43mc86ksv94eAidAk55/QdDOYnHp2Y93i7/XKzbpr6FVlKLjL1JAC6CfizLQyRqP5BhBm8xe1u+XayTxJ5Ch4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GEyZpv5n; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GEyZpv5n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732922963; x=1733182163;
	bh=ZB+CZ7Vkg/26fd6kxCetfcUz69OuJ5SKWavu8Ifvqvc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=GEyZpv5n2M8137/XYSgrWNVEfY8N7ySK1ZhSeSDikj5YQsgNpqxTtbbQzc++orZ8y
	 JBAVM3cNS3sbUT8VTlrqSWrkAcUii7A3hLt3mMtmQnieYF0r18vXhgdWzOJeQuV2n8
	 hZZ0+Ff1V3VZH6Zcquwi384yrWXEBhf/99drETLdyezEFGefE4kRpKYZEo1sM38XsJ
	 TBaJ05XXwxyZOmZOv+ny9cJLuKgdk+WOXxy7/FpCiFQe02GzYd+zMAeWVKyyqcc6B9
	 79h11l6p5mQs+rR1VKmB2nsqLAxHsy2bwwbf3e9GV9XpIS58gww4H9ZuYDRm+xF2fF
	 hh1bbe37wGlJw==
Date: Fri, 29 Nov 2024 23:29:19 +0000
To: rsbecker@nexbridge.com, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: 'shejialuo' <shejialuo@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Message-ID: <D5Z1X36NVZ28.1FPA05CU9GFRL@pm.me>
In-Reply-To: <00c501db42b4$ea97e050$bfc7a0f0$@nexbridge.com>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me> <00c401db42b1$99c4d5a0$cd4e80e0$@nexbridge.com> <D5Z1L479JERN.80KZ7NA9BWNJ@pm.me> <00c501db42b4$ea97e050$bfc7a0f0$@nexbridge.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 5b058c6bc65bcd22a9f427d1837837dd99a9e6c7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 29, 2024 at 5:17 PM CST, rsbecker wrote:
> On November 29, 2024 6:14 PM, Caleb White writes:
>>On Fri Nov 29, 2024 at 4:54 PM CST, rsbecker wrote:
>>> General comment on this series: Is there a mechanism of preserving
>>> existing functionality for those of us who have existing scripts that
>>> depend on the existing branch and worktree naming?
>>
>>Existing worktrees will continue to work as they do now. The only change =
is the
>>worktree id for new worktrees. However, there's not an option to preserve=
 the
>>existing behavior for new worktrees (nor do I think there should be).
>
> I do not agree. Companies that have existing scripts should have some way=
 to
> preserve their investment. Just saying "No more worktrees for you" is not
> really considerate.

How exactly are your scripts depending on the worktree id? There are
very few reasons a script might need to know the worktree id, and
I suspect that there's some confusion here. The worktree name is still
used with the `git worktree` commands, so there no change on that front.

Best,

Caleb

