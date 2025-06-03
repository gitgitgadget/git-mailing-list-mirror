Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D879423BD01
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963671; cv=none; b=Hzt2Esqym1qpx2Ii6727Fmr/2cHCMkf7KOAm+CCIupcOKvNrd8c9U3nvUR2RjcSpXaj7X21u3t6oKSL/qw/XAjTvvbuh2R2Rh613/BQvRNKNKKVodIfrl/r9Nq8SOHeKFYgi3mqp1hP+Ufn9HBt1DqYRpX+k9Mt/g2JjFYUGc1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963671; c=relaxed/simple;
	bh=cLzbFlXw5wHiZZ2ioBjuGWA2w1cJfuEwmWwsZh7MAwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fL3AOobq1e/Oov0NPi7p/obXkRG07cAX8WbAURpK5Vrh3t+YU+CoNKPTsXw/85HrD6ylJc5AjAEtS+YN6d5gHguRpqXQKkVhNmDyZJszTIG6vwq6hbOytqWhVZE5hvDrQxiOJW0iE4Fezc2SZ7u1zPLBdi28iYSzSWByh+rIjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T9C7sus8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UXkOpAXe; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T9C7sus8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UXkOpAXe"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id BED901140135;
	Tue,  3 Jun 2025 11:14:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 03 Jun 2025 11:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748963668;
	 x=1749050068; bh=Kik1VxTBHECx3YDCmAbMGjSmnbgGZo2RLt74Iym0G9U=; b=
	T9C7sus8MNz0Yv4Dn8HarP5UboslQ0G6O22mmepJsePEd3aPhO7DnucJlSLtsKYH
	UMhcvqIrhkI9uY7pC2dYE4ro/Q3fdCsiXiNKv+EGsaNsL8f8mZ/8UavhHRHgUDuk
	jPr+/LK4UE51PuhVo267FSLKsN/9FfFRkCNT3GLSluK4yJnu5X0nblnRqxIeg38H
	YzOSWCVtlxUtU6hQJDKjJVaWJoSMaUEkS6LsNhuKLxne1Y6xMQvU/Aakj4KS3AOy
	01roOtuYbc179lpULMkaf22m7NsPU+wStAhrko0djr2VIBuqIk6xwpl3igUhBDl1
	wEALVH6nkL+1M60MwGtipQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748963668; x=
	1749050068; bh=Kik1VxTBHECx3YDCmAbMGjSmnbgGZo2RLt74Iym0G9U=; b=U
	XkOpAXeOdt51M23tTTAFDqYfyYfPQbmvuaNGYws2XVfqJYFy7RE2KNA8PK99X3uA
	x5xyGy/CQXrmzfANeaspLTZ2XdhTW8Kesh+lLDlpOyJx73EGrkDZfKgBWkD15e4Z
	BxzP4MQfobOeSw3K4zBwbK4znTNXGztvto/1zTojFIybnVmtlp2tNFxE64PakDn/
	QyHGWkSy0tAKQRGg4UoMIC6QgoUXACLv5tOWitLooyGHOSdzyB+zIklvMGP7L7iw
	EkweuRLkgunUqe0xpS71qLI/U/ALVpR+nJUah1inw3UigeHpChOZUdiTiIJHNT3a
	g7MUdWBmvruXZoUSXsD7A==
X-ME-Sender: <xms:UxE_aMPBjbrJPiswTox9eIm-poW20MWP8_umj0aJAH6n-Z8_Nyy4Dw>
    <xme:UxE_aC_OKsxw1skHePvBLim7a_NyihI_q_1qp2FaYCJZKNoQvV0ye8Wk61x5xbZ3W
    oWQnowR3jK1YUjflg>
X-ME-Received: <xmr:UxE_aDRcLDAkB_IamLKrQ32L0YL_XuuMYixRJMbbfYjh6WNxnV-CxjZ7GKBSwyAshCS-BeDROxCuRtRoUyc05AVYn5U3yvxCED90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephedtvddtvdegfeeftd
    dtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:UxE_aEtmjbq3d6E0X3IEy4TmiYAhntOKDnTfbmsPAp7zLhDHXFdb1w>
    <xmx:UxE_aEe0gwvYMj2q_-P9JNFgJs4H6bhq4C96vcM_R68jXR8uI9jA8Q>
    <xmx:UxE_aI0oZn8-YfVeTUIg09HKGwjFPKFyYdhxDQJKNgjWKvMTP2etnw>
    <xmx:UxE_aI-DhyHTNtY9N3J4HYRZawfmajL3BduhGkGXZuc3MHHLdiZbPA>
    <xmx:VBE_aH8fw-Hls2gYuB2yp-VQZkbVCvvwrUScqDmrL11ITijTTwg0AE3W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 11:14:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: lidongyan <502024330056@smail.nju.edu.cn>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] pack-bitmap: remove checks before bitmap_free
In-Reply-To: <0BFD6581-2BB9-439B-9837-767FA98900C5@smail.nju.edu.cn>
	(lidongyan's message of "Tue, 3 Jun 2025 14:22:09 +0800")
References: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
	<pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
	<xmqq1ps1s698.fsf@gitster.g>
	<0BFD6581-2BB9-439B-9837-767FA98900C5@smail.nju.edu.cn>
Date: Tue, 03 Jun 2025 08:14:25 -0700
Message-ID: <xmqqwm9sq2lq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

lidongyan <502024330056@smail.nju.edu.cn> writes:

>> And if the test passed without exporting the variable, is it really
>> testing what we want to test?
>> 
>
> Sorry about that. I should put GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL
> In front of `git rev-list …` so that when traverse bitmap it
> enters `pack-bitmap:find_boundary_objects()`.

That would work well.  By narrowing where the environment variable is
applied, such an arrangement would also help readers.

It still is curious why this version did not fail for you, though.
If setting it without exporting it still made "rev-list" traverse
and expected result, wouldn't that mean we are not really testing
what we want to test?

>>> + test_commit A &&
>>> + git repack -adb &&
>>> + test_commit B &&
>>> +
>>> + echo '1' >expect &&
>>> + git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
>>> + test_cmp expect actual
>>> + )
>>> +'
>>> +
>>> test_done
>>> 
>>> base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
>> 
