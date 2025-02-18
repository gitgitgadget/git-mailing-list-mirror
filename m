Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55062862B7
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919143; cv=none; b=HRXSrTOMIcKPkWS46O8E8LE/16/MMYlQO/B++uqPnAfva42iNEIPewWtSFHzUhCd1cAF30kWkdRkAEnBLB97aj7+f3XaIDPdUogu+XbNthu9xLYH5NS46m5wFzn3A+22XNOuhDswroB4ctzbQ+lHWIYbFvCZuajaTvZ4+kTpcGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919143; c=relaxed/simple;
	bh=ftvulRgnQvTpQHoQxPLMevtHudJ9B1A6FS/xWxsqESk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uq0lEEa92PX1IjJij4gG425GYEs3ls/ef6rL1P3KY2aMFqxjHbfMcmX7y8ejBdtcGLepM7YfFaBuH/qV1qQByKDE4IYqL2V4aW5UP1HEER3mnhs7JmLe0ee9a6mVML9gVfwnkS0YIQwr6z09tQ+tvKwtY4RlsaLw0yYer4aOQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LCSG65P/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XyqkiwXT; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LCSG65P/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XyqkiwXT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CBDFE11401DA;
	Tue, 18 Feb 2025 17:52:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 18 Feb 2025 17:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739919139; x=1740005539; bh=bBOwJIrnfF
	3b7ci/KpPzE1p1UTJ5IEotxlxB1YO5K2A=; b=LCSG65P/9mK7dDTz+whXk5VexG
	QljDJTKrfs20Mm0l1nRa2DH/FGDAkP+RzTSGbGe92cKwshHAmwojVwuT++KS9jOk
	f/1nXV6uoM606fs+KgNZZROAkAj+913DNZC1Pu6AR1ZcxI2yQR6Uq6O+HBfoujRa
	TRGZdb4Pd2nA5zmMneFWrTDSSTBudzx2NOhyODbJACvn9ll45pHQfuKaTVZsL3i/
	RiL0VEvLbtoz8vHIp1CHt5elXulFfm8+1PYP1vJVF2ajva6IYUGLBZR5zggsuNSx
	TJs3NdM5sA+sY5I6t9aKx7JTMbcTQpDTSI+Hyy4KU78FOqNsevhTSPJaZBOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739919139; x=1740005539; bh=bBOwJIrnfF3b7ci/KpPzE1p1UTJ5IEotxlx
	B1YO5K2A=; b=XyqkiwXTqZEYA0kqNGCLLVzZkuJSeV5OaG8ovvfypTHetg3Hf80
	yOMT5Qsd/zSbt5k/adi5VtPHO3Yy2QDyQRDkZY9dm8ziRwvTQcOcgn5tAsWmQOju
	VRZhHNeBxhvm2UhVpW0vHUURWH77iD1bQtg54G/u3hlDErWuGmgFK5ziglqy6MrV
	umvLm5+dFrP6ziWLBbFnaW1UKft6VJqj0k+xKz1E4mXJ5gfrXbp0QgxdTyYaZQ5/
	c8glA9eP1VRDjvjVpsAhu++UD4oFpG4dOwJh0DVzJzRfu20tSenBuo0s+FnC/C8g
	sfOMbvcNuCOaIE6AczeO+nTL2/D4un46lFQ==
X-ME-Sender: <xms:Iw-1Z1IUhcWbhxbbWQGN4rky-NUuMJnkVnFh0V7xpQn-Va0zx2jWEw>
    <xme:Iw-1ZxJvecmDLOEVPwNxmaF9dxGnSy9tmLnpOh32aJDMqg0RJxEDW0cpa9WUWbgKC
    YDq1zqBzMgOMzlkXw>
X-ME-Received: <xmr:Iw-1Z9vOdtqm3tOHf4Gg9rA81Agk1KZenSRcy7_VSSGghgCVhgTJhSGHMEQqOzuLjcw8Y99hfeczY71Xa2R4sTBdahHjLUh8nsVdM84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeekkeehuedtvdelieehtdelteehleefueet
    veehvdffleefvefgkeehueeileeiheenucffohhmrghinhepghhithhhuhgsrdgtohhmpd
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    ehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgriihuhhhirhhordhkrghtoheshhhothhmrghilhdrtghordhj
    phdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Iw-1Z2ZBNqOoYCHle94gYkHFFlAonxNxZKzZEQXnXbnVN-mq-6Ba-Q>
    <xmx:Iw-1Z8ZAJzdewjq7XUWpvUpx8h4LwHSD6XM2wFdQVuZ53lcuAfFOFw>
    <xmx:Iw-1Z6AUV6t2Lrscpr6K1VTqimPLR2z4nS3LIjQW_WB5EZF9mGs6iA>
    <xmx:Iw-1Z6YZuWYp9hTDqXCkliJDfoG8kVnwHuBgcS4eyqpPis9zJziomw>
    <xmx:Iw-1Z7zVbOop8_QEE8M2pA6t3UZKg2EnFkDgB7IS8kLmvZ0O2SolbAgz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 17:52:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kazuhiro Kato via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>,
    Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/2] gitk: Fixing file name encoding issues.
In-Reply-To: <pull.1886.git.git.1739918546.gitgitgadget@gmail.com> (Kazuhiro
	Kato via GitGitGadget's message of "Tue, 18 Feb 2025 22:42:24 +0000")
References: <pull.1886.git.git.1739918546.gitgitgadget@gmail.com>
Date: Tue, 18 Feb 2025 14:52:17 -0800
Message-ID: <xmqq7c5mj272.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kazuhiro Kato via GitGitGadget" <gitgitgadget@gmail.com> writes:

> fix: file name encoding issues. fix: when resolving merge conflicts,
> japanese file names become garbled.
>
> Kazuhiro Kato (2):
>   Fixing file name encoding issues.
>   fix: when resolving merge conflicts, japanese file names become
>     garbled.
>
>  gitk-git/gitk | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Please

 - base your changes to j6t's gitk repository

   https://github.com/j6t/gitk

   where the file your patch would touch should appear at the top
   level of the working tree.  This "independent" history is then
   merged into my tree with "git pull -Xsubtree=gitk-git".

 - have the e-mail address of the gitk maintainer on the Cc: line,
   i.e. "Cc: Johannes Sixt <j6t@kdbg.org>".

Thanks.


cf.
 https://lore.kernel.org/git/b2038430-62dc-41fa-86c2-c0a14bd25e0f@kdbg.org/
 https://lore.kernel.org/git/7b826bba-11cf-4f45-8292-937522dbaf29@kdbg.org/
 https://lore.kernel.org/git/5ccc1943-c2a3-4896-a858-aa5fd6cdd426@kdbg.org/


>
>
> base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1886%2Fkkato233%2Ffix_filename_encoding-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1886/kkato233/fix_filename_encoding-v1
> Pull-Request: https://github.com/git/git/pull/1886
