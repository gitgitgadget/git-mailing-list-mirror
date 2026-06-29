Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12F64218B2
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744555; cv=none; b=PbyPIH6AF2ttHXoyyU95kMvstbJnHZYgdqpcJyzsTw+YJLRzvQrh0U6Ngtlu/6gefDhlWBYxbt6r8TQvpilFZAPGnDqYgZyhIe8wramm640Dg+yqQ5+xWOEoDi2xAqWhcZP8dK2Pw/rOGPVfd62ps+Q76wsQLaank0GGzfSfehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744555; c=relaxed/simple;
	bh=Fh+o3LA4WceJcEo1akVAn2Vjqt8QOlzkXnlaLyHPYHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cfwQ48akw8FwgEmgPsxEMtpyYc6toQu6P9aFJz9TqtAG2EisiDpN9uoWupn3MQmdUu5BdBkBi0c05P1p+KFDZwO/0YlFPdDqq1FuqZiKTPV+75jJfmBXj/MJ735Tbh0UAdzUTdcbYZmmnbrv720Zvr/2qNqNUF+H6+zUbP5+eCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pAfjmlxS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k1zAw53a; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pAfjmlxS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k1zAw53a"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C78F1D000D8;
	Mon, 29 Jun 2026 10:49:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 10:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782744553; x=1782830953; bh=JgjDDBrZOi
	P7yi3gbz6YWLqc5D8IRI/gXHLd2DDyAXg=; b=pAfjmlxSd68wVPJHprm7xDfEGT
	JJ8KLOpRwjofKCsHTt9q/0ra9Q+yASeUUiFdGgddtsd4dlgauI2dT7EplR/yjxjt
	hEupGPDhTLdNnc6Fy0nLmztgusIy+arxYHuVhT5f2HJfLfEQvivnu37s3sk/6y6s
	y4DnwCFGfWu3xcxmi76xgQ9YYBp5i/qSPR5JQsvxe6Rj9iMPGGtAnJdAkGVpdiFa
	zd5Rx9R1fwSBc2bfKNyPpKY6Crk6CnfZ2xJTW5OpORMDfRoGJVFx4TAqPretWhUv
	O8w7Oa6SOv9Fhk4p6OufaL5wYNyygu4YOU8JH/aN47OoXUFuNeg9OnZ6rwvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782744553; x=1782830953; bh=JgjDDBrZOiP7yi3gbz6YWLqc5D8IRI/gXHL
	d2DDyAXg=; b=k1zAw53an7hWYnLUIsSrNeV2UY63esUWgDShO6XXR5wSr/3M/Am
	FV/6FvxOM6e81Z29QLsC7oLHraSpNKhFPxkHY77kOAracT82zjaWeLdXZn8+T/c9
	4XTVXfE+fI6B/h08IY9Wo1Ji1xqLoH5SVyd3AfD+DkwutYz2II9Nw3al6yzGGdrF
	2yjXknoOxu9/ZxKAJVooljU0R+GPfeHu8yJO5PweT/LjwYQHrFydAJP0nVjCPbbL
	ml2pYzIFGs6T/hNyeg7m+0KflY/+4BGj8Ph4sxJ8sGhvzvDCfEgAaLC2lLoceeL6
	ENS4u8J3WqR+AgDLuL8Rxe+JORohGmBHBAg==
X-ME-Sender: <xms:6YVCaujNy5BV5NadKwrk_wKKJty-ZWumLrgyVR50idMeqEEdSZsj0g>
    <xme:6YVCamDc0ybLG0aEJBEZ-INiGN8NdTvtdMdrHG2W4db0PIL8uc7_uRiL00vkRVjWX
    KL0Qd_6t6FOAHDv74-Katbc_APwhrnKXysihmuDaq39MNOit4Cyhw>
X-ME-Received: <xmr:6YVCarEinbam9sFavCpyxgpb8zsi-4pnYj6GcsWD9XlvypLm8qiZ5ZeOqvM58HhNo7NASR2LRoXCFF7guOTAdyi-3Gjds7bkhC74mpw>
X-ME-Proxy-Cause: dmFkZTFV2oUqqrtwgvKj+3ZdF4aqm+T24UfIFXQOc2xG+szpxCyRkJ99P4sDn8p+DrrB9Z
    jwn+F6FwdHXdnm2XcDyAhZjPKOK2zvixOdUkCkyqxGNT9NNveUjOdTZ4NPJXJNIWKe3KEh
    w0suh8ySqAz5kjo55j4TQVQhgnEv6UKxHB4rncENQZd7ZJqhNF9q/02Vq2cGgN+D1q49J4
    BxHFV0LR246HAH39fQnJUOx1w0rkwR1E1juxvn2KbfW0R9VNU33oTWucQGBSTtBno/FijI
    3l9hHbbIXbCwNMyIsh/IZjNJNPsKieQXxpe3kU8M1TSRDGR8Yyb6z9HzAkqrib2o/oDDgj
    rAIwUisOYQgcnF1OF8BnMxAS41EY0+cT4rYV9rScQPuFDJeLmjMOxiWG+nJG6bEZN2F+Q/
    h9hxrMgprdKX13i8FmrUttPRpXqFdvUIM4pjIv4rQjBSqeGbP/foH2sE20XCR2cvpHcQl/
    2kAhPkrNvO+CiBbBs6Q1qJ1yw/iQCp8r5eF6qGPA2UxLtBtYm1HFamQNmMvSmi3P5bem38
    WAILPJrM39SWa0SzBpjN/qSjus1BRXRalF0BYClZEhi0Hl7nUsdmVm4GUaNhBB1/4rGRTz
    tbqdWt4GkvronhFxrdHCONaIrnJagj4CU+KKotZUTO3spRjVWYPfLZ+YX0aQ
X-ME-Proxy: <xmx:6YVCamLZXkCcSBVkFQgNSQ4cc5UcbChvxO6OIMX8395F-JiLbPQTWA>
    <xmx:6YVCannQSa-2A2EQ3nB7k6XSHTpJwxOZNR1XXYgMNScEheHgr_IViA>
    <xmx:6YVCamTH3F-JCf2qBWwrT3h9-WR_KyC1SidDGmJ4sj_2Rv3wJ4tmZg>
    <xmx:6YVCahLRPzzyb9q9hFopqJumROv8GaJ1ZRg01seJ1Hel3FNkBQJTMg>
    <xmx:6YVCaikws_j6_MRluyFjzVOM7AmVaZz8Rz1CICnUvb8qlOwAzQhCzIJO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 10:49:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v6 4/4] history: re-edit a squash with every message
In-Reply-To: <CAHwyqnXXFz4z_ULUq7Oqu0ykwpLJyEyW-uoF2bKfoYZQAjrNdQ@mail.gmail.com>
	(Harald Nordgren's message of "Mon, 29 Jun 2026 15:49:16 +0200")
References: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
	<4edf012b77fd2f2fb2a51eb10863bbf852fffa40.1782635349.git.gitgitgadget@gmail.com>
	<xmqqwlvhzyhz.fsf@gitster.g>
	<CAHwyqnXXFz4z_ULUq7Oqu0ykwpLJyEyW-uoF2bKfoYZQAjrNdQ@mail.gmail.com>
Date: Mon, 29 Jun 2026 07:49:12 -0700
Message-ID: <xmqq7bnhz9jr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> I doubt it would make practical difference, but one thing I notice
>> is that unlike "git rebase -i", this one does not intersperse
>> markers like "# This is the 1st commit message" in between the
>> messages taken from the squashed commits, so it is not exactly
>> "mirroring".
>
> I wouldn't mind extracting that logic from 'rebase -i' to show it
> here. It would be nice to have.

If we can share more code (not necessarily the exact existing
code---after cleaning it up if needed is perfectly fine and may even
be better) across codebaes that would be excellent.  Thanks.
