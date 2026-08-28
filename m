Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40036E468
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787938899; cv=none; b=Vjnnp+5aJodbS07NzFW8keXdB73nIhVMVJFNeYX35tlPrmmKmUafmgSqOMDjWJSI5Bl5UfUxGqhYjEVBmOriXAp4aIMNrL3VcXlz5IYl4TckSrVrIrXM/5JfWtxPY1PFOImilcH7WpmQlYwLJkKKRafobBQfhL09msRqws5vxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787938899; c=relaxed/simple;
	bh=7lwdUSB9t6pEQQna9NyekPc0r99+ZhMc4KH/pPlzIUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=afgprRaLAehIGheF9AfZ95uKNAc7z2CxezSy6jN5Gzttra2VtJZr1GU3ePaw4yoqzbc2EDjmc34sN8Vr0zkIqOZWJbk1Rab66JInQpAlHVJWkN2UX8hlwhjCTo0qbohHYCpDNdP+3qj/6pJPLkgCslYswUPXLgoUCMHXHrDPvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T/kfVaUa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RVcuV0OX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T/kfVaUa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RVcuV0OX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02BD27A0017;
	Fri, 28 Aug 2026 13:41:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 28 Aug 2026 13:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787938896; x=1788025296; bh=5Wgrc4Vfzc
	o2C+7hjVBPPpgbcouTkNRzkmcA+W9HDk0=; b=T/kfVaUat5SDbUhgGs70XIY31x
	3/I/rvXhEkJEIf0qa4nHoY9L9kyK3N07zrQdCM0bz5IdoBIdy42xOn1s+NIuC1oD
	7t3zKNmGmXggSksJ2wyib/1oH40F1JZ5i4AqoCWgoG5EBsKD/xY0KDjtvsFMwAWz
	9KswTcEYZz28bcpP0i8UjjYbO0cLOfLhikgZRmuLnm0ouOd2SxJCiERbNvFWPQe4
	yY+xdSNXwRSoze+VfJgGEgHrWC4hGLYDG+pO+GM+ciZOGPL+eJ6J0rRG14SlxW2A
	nkJB2+nf8TotKkpFqyP1Pf1m37gXTgHWYL6eHzzyDGI+DDT9fSCMDAq7jqAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787938896; x=1788025296; bh=5Wgrc4Vfzco2C+7hjVBPPpgbcouTkNRzkmc
	A+W9HDk0=; b=RVcuV0OXR280xJYHMoUiarRmEyNEpiFN5FpRw/YDVl5klHe86iJ
	kILSCLqUxNH6hAB+z8CZGodIRNgydAAJfDB/mc7nhxHGFCI8dQVsJl1pRKZ4oBBm
	h721pAwFsvTxrBL2R1FHZzFJ2rODpESl7V3/HL1L/XZBdWTtcvNbCtXXxVQijjwy
	o7PMJp9W9q0ta0Nv5NSUP1YISwSNS54Vb1w2TKOaeR2iO3ax7YCJ2oMHLsv/O0eR
	H6k9TqZCvn0eYLI3p+jrlcHfgO2fOBj+8oNMnPLfJXbLc9sJ7My2pq9+m8g6DFR5
	37tSFrCYS/niQEVA2fHUvVUUWolxgS+xmhQ==
X-ME-Sender: <xms:UMiRaoO-1zC9625Aq5-ILi41u9BB808suiKEvpFlQcHSG9sGAgUeEw>
    <xme:UMiRal-Q-D6h__Wj-tbehhpJk64FgwhTzF-ELxab7kjr5T2zTZM9QB1bqk9KFSm9A
    t2CPrxqdGgYxt8Se7NLmcT8_izV91yuJdY4-0vVWQkfd6S0IUo9nw>
X-ME-Received: <xmr:UMiRakTgCAkOv84ugh1t4tTymHMK9B95MRGbKB1gkmJFRBjxEQgbnw4Q4ARUFZvv7PSNPxXQLkr3lKVdzeMJUrIKlcowX0ZgQA>
X-ME-Proxy-Cause: dmFkZTEyrfsW8GPJkSiojK3Q0GZn+V45YDW1tk/8zBupfg7BY7Rk0WFBuQPOHyVeoKnYXw
    o/EefIWk8qyuIdbOF8wdvxqcx5ZvRlLEbQsBOsCWetLtErNzMmDAZpoimJUCWm4t5efk6O
    MYYpZQkRto5vvw8k3+ivkDlupmdXLo4fuPSqqvqDJXFxU5w02Prly+EzLokj/2ZkNU0cVf
    9jcUyUyi94/vgtgeoKaUi0VwC7Pgm6RNJObtVEktdKJ3zJIyD9xs8kF0/AHaZ38tglPzoy
    KwCjF3apvErNFHh7f2UzoG+p4oYW3It7C2Z5f9JDZAyEIc7eynI/olqlT4JRl54sTKm+bE
    TaqPM/37HpfV7wDd4lTfWW1afN01LOoxChdFeI/PCSgjt3q8oFRCmc+dTiOsEU+BvfDGjh
    /Khk6zZBL78W1XVi6W3n6gFTneHTxURg2BqklJgUsJh4xFmm2URND/edBs/IyS+GB0yx3O
    myFqMgevoBT/zXoKQP3J0vHgYm5JDfvczDCh6QateS3h1tFK13tYch8kkt19skQojaxYmj
    3B7GzTK8etQS+InHXFPv6TUOnrne9tzW3pwh1siZ6EtjlFhymbojapL66cE5j4emdXcO3v
    7rwGEQ8vXwAo760rF/yRp4s6OuG57lvBJ6fJeUDbS0qZvzpvsW9DUA0fJHLw
X-ME-Proxy: <xmx:UMiRavmiFGIk6-K-Vs6EPvG2BPrwha1DZe4ZR2hTjwNnNRUMbVTQtg>
    <xmx:UMiRasRPAiZ_2mk3iKrgGGyQmru-qeWzuFiZCXl2DfZ0fo_DSwSt4Q>
    <xmx:UMiRalNc7BFuR8l3txtqzd3FqsSTk5_BDmTYsQgymxP56VRXlqj9iw>
    <xmx:UMiRatX0BJsH0OJbdl7UO8YvBN4tuibRrB3V1esxK9E90ldIDZyBRg>
    <xmx:UMiRanyDqaBx-oSOn5xp_zZXeXrQewogrZgoxO19Us8WLGrEkaV7KRS4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 13:41:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yoichi Nakayama <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v4] worktree repair: detect relative path in .git file
 correctly
In-Reply-To: <pull.2205.v4.git.1787930386252.gitgitgadget@gmail.com> (Yoichi
	NAKAYAMA via GitGitGadget's message of "Fri, 28 Aug 2026 15:19:46
	+0000")
References: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
	<pull.2205.v4.git.1787930386252.gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 10:41:34 -0700
Message-ID: <xmqqh5ke3zxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> Given a state in which the cross-references between the worktree and
> the repository (specifically worktree/id/gitdir in the main repository
> and the .git file in the worktree) are recorded using absolute paths,
> setting 'worktree.useRelativePaths=true' and running 'git worktree
> repair' within the main worktree converts them to relative paths.
> ...

This iteration looks very good to me.  Will mark for 'next' unless
there are comments that say otherwise in the next few days.

Thanks.
