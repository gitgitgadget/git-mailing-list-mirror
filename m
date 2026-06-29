Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61232363C74
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782770325; cv=none; b=BBo8lrm8fLvhIaYrLOVZLuYIX7RNMd3+LIJ8og1enSg77x9C56Y9deinEI5uluDWlsT6IN3MA0fzkVRNh0coajIdAWFJ+252HIGADcsiGViLiWa/MNp0GeLdDyBQvz2rOph765fwrNNsydF9stiD/tWHnbB7SBfMhhiMaK90baA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782770325; c=relaxed/simple;
	bh=xuqnkm5ML7M5t7AzpS3/xqPwJNZC6vKa+zsKrenxN1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cgXG8SSFxhgwnPLusJfB/B50d4BQRqwaPOJJcPp9SuVFBEkhKqpeL4f1AxWjgOsUMNBH3+41sw0UHAHPzG8vBWF6u1anHZN9/Tcp5xKOUnWtx0ur6K82lZMdk6wiuMJ4bygN6sf/tNhE1sQV5nfHZ8EXiyT9SSm58dfRejxsGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mLLsFKP+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VEdtmTYo; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mLLsFKP+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VEdtmTYo"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B84CA1D00014;
	Mon, 29 Jun 2026 17:58:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 29 Jun 2026 17:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782770323; x=1782856723; bh=tZH8V+tyDu
	QkyCNQ3n2Mys7aHFYNgUrlh8UBXHsq/JI=; b=mLLsFKP+WcORQKFRgEu+r2eFo2
	1Xi6Srvf1euEVeGbkYZIAM5uiyerOh8C7yZbCLFfQBF2/qiEa7Up5nNlxT0i/OuB
	qKKUpJM6xo0K0m6xgogacAnVO99BHQGrZNfm2rdKYpagOUrxYm4zhEVYESpplRSU
	QMjvRWlzbwU6H2FCNkJ1CMJolGeob6+qvca4yePo3f2mNctFdN1OfUhFJL2q1sdu
	DnUNqleTiVeXYaDtQIlyDq4zzj9iszy0vHpqrbY++rivdeipnibb/LkeUJG/SMrR
	3CDDTHv9VxZZA0gAuzwj9g16LN+Kv15ZcvcyDrbJ0MAOkgX5ls3wjeNY9LKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782770323; x=1782856723; bh=tZH8V+tyDuQkyCNQ3n2Mys7aHFYNgUrlh8U
	BXHsq/JI=; b=VEdtmTYojlUaVKCHufwYU+ThkvXhvVqaZ//1lRiUD0zT5WXmKpe
	c/ilsOEpV4uAZNeXpiHRqwKR3uh9QL7G9mG68dTDNNaZq12g4fZluEIBffv0ZFOq
	C6N1UNpIdPzIccD2bICKQCLrPHHRbVukKyOPPAG9h2pj8CKPcnSc7ukYDISvL3ie
	0cy2+q456DX9gTbHmGUbpL6aZ4OYffoyLCak4GpqjiMpbFuYsmVY/9pTr07IK0mJ
	Ea2AJyRBuQIok16hrr2qzTpTjdk9HGOEfFvfBJ/XnDJ5V7j5kYhSDUgsyf+BD67U
	8k7BJiTYm6Ix1iyb+Kc9yppqz1Wfb92J9Ag==
X-ME-Sender: <xms:kupCau8Yneij5Of3djIU0vWY_h1zrYPI0_f63Z-Gd6fj1VcP9gjxQg>
    <xme:kupCalsYzdCMqQOYTrTZlQ1nGXAbN9ewamlO_fGYG0gDyn_BG1BoZignlpOLyOWDG
    FZmISnLAIkKgCoyCB94ZBxYjEzTPE0-pmOehVAJ45BhvVPy7Mqqyw>
X-ME-Received: <xmr:kupCapAuA_c8Q7xR_aKUHRxyh6FbZyWrVTIrvTI8bNqvZtw7BYjcUnsirgD60xUEjFDEVMNVS7esWKe792GYt2G9-gyWtzbBB1gGDjk>
X-ME-Proxy-Cause: dmFkZTFzHaKSiuAwj6Gt6EbP1RfvIbK381rxl7KboxQGyHzefgn9NQp61sXY9qNcXiNTxM
    Yit4z7v/Wk2JP/Q/NpCEUJ8QMBXx2iSPPnqLMI8BxTsauVL0bAYbgBBp7aQvPw8khAfAUg
    vFjZa5oR4riqTuy8Dou/Bb0IAqKm0Qce4utKy4nyPiW4KQ50fJTrvvxZg2AMlRdE6wuAek
    n5z8fC2ERhOeSidAvrlF/BnAqa+42siMTzWNIPNY1XrkuiEzDo5hWaH6704TKLt+cYx0MT
    4BkUvWhVZiie/1BgHw1AYJM228pTJT++irBJlgvniqF1+3reyTdLALrwBUmnlMz5YjsTXd
    dhEuKhTcw4Q581u5RxTaMTE34mTtEqlPeoFiBKSDTwm688ILZLj4e2lFsHdr6VHNrucFe4
    DceyqsB8nyDcGkuWOe8dG17ptNtClR+bow5Z7VxR0t9N7SJPU8XlkXptAdDoVM1KTC7VXf
    SI05C5YsTHaa1Fpibz8QEJO3En5z/nIoOkyXBIDi2ihkG77RPdwcm+0C2SVBhcJbNI9gCq
    KdmdIJbdmvp/b9UHWjge0qn/MrOatv3kERFvemy67P+7WTmUWXatGU4Nk7IsW0jbUOFUhv
    b7qKanDWCmuMtFWXyuM153OpF5Nelgf+nYyIkhlZxhpm4ep154TcWjOHqCWg
X-ME-Proxy: <xmx:kupCalVBEK7cbDfY_f5MeDVA4ifLPcqO8Y-TpneM4zzp-8tv9BtHPw>
    <xmx:kupCavBkO1UdgABHV71547SxoYxFhv1rSEtFxDLVDM3R6gnPs99t2Q>
    <xmx:kupCag_ozyLJgS-qu6gvxOH5XhGJSJSFkcMFUW-ceTM0liB45Eg0Hg>
    <xmx:kupCauFbwhSjnOYR9kZGEis6js2tjaV-LfBsbQWMvMtRP3VQzOybaA>
    <xmx:k-pCat8bUT4XJFEmNgkv6-EQNRtun259mmABAgiLi_ii88Mrt35qHzO1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 17:58:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] odb: introduce `odb_prepare()`
In-Reply-To: <akIN0CxVxhaHnvJ0@pks.im> (Patrick Steinhardt's message of "Mon,
	29 Jun 2026 08:16:48 +0200")
References: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
	<20260622-b4-pks-odb-generalize-prepare-v1-2-d2a5c5d13144@pks.im>
	<87o6gx4i5w.fsf@emacs.iotcl.com> <akIN0CxVxhaHnvJ0@pks.im>
Date: Mon, 29 Jun 2026 14:58:41 -0700
Message-ID: <xmqqa4sdt3e6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> According to my grep results are there 17 callsites for odb_reprepare(),
>> then I agree it makes sense to create this wrapper.
>
> Yeah, I was a bit torn myself whether or not to keep the wrapper. I
> eventually decided to just keep it because it reduces churn, and it's a
> trivial wrapper anyway.

That sounds OK.  Are we all happy with the current shape of the
topic?  I myself did not find anything iffy in these two patches.

Thanks.
