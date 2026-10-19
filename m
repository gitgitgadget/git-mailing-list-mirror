Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4FB3AA4E1
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389434; cv=none; b=bFgljiArzU2G3vzyrJCYE0Hvt9+/Wy/H6DcUFAKlTsf8Pn10ZNW4za4ncNtD6YT1aX2hIIw7xGDUN3Eh/T1cyO49MoSwW65SfvIIIYSQ4FbJmAy4hYrYoDUWD0VzytDlQyfWOR/lKeLOhR22VGcWUB5Ioyj/LlY940yQWgBwWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389434; c=relaxed/simple;
	bh=uzQbvAL1rfXDiHCRgz6KkB792E6c2bM4MdAfFchQGUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qHo25WyZSdSKXCmexwdV+BwvE2zeZ5eqHrCKYjypXGnhd5M7l2ewlyYvvsLqattA7mWDIJc4RS7yIuUnrrQpX8HnMxjEKGuUbDFX22MWW1ZW21NOuYKNPZu2g68cBrOxaHSXFDvDB0CUXj6QbhNsXZsj/nV2dFYbGeSaARSLJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RlmCH6jq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qBgU55IP; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RlmCH6jq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qBgU55IP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F06EB7A014C
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 01:57:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 19 Oct 2026 01:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792389431;
	 x=1792475831; bh=8U1LEMoSyJYHaXcl+klB7d9t8LtrE+8hORSDI6JVKjY=; b=
	RlmCH6jqdzXfrBnsiAr3Cx6ZJ2z2nUkCSAWFYhGqwN7Yl5gdYLLDVWlIGYvD7xyO
	tWwPUKuLNGVbzSubgtXWxj7OX9Y1XCgMmSLV9djDEIECjy1t14Ikllw39pCmz7w1
	+dKtU9i4tdmesaR3a5rWapvrP1g6woFpa+J5GpDeBPS3ikPmGEJAErk7/QV6Jp66
	zL0FDGDnLYOg+OgMlsLXFYddbZ/n0bmL3IYxD4CiDx2WCXXuNNfz3NeXKMmoXVq/
	wgcVtpqo3V0FYFFCjPvKjVorqKi6KD4AlPv5XY4SKGiWgTQuv3fpxd97Y8Gc0gXv
	OjcKSN7ecVHSBGLbpxziFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792389431; x=
	1792475831; bh=8U1LEMoSyJYHaXcl+klB7d9t8LtrE+8hORSDI6JVKjY=; b=q
	BgU55IPBilYRNImB0TnkxjcR5FP3g7YFL2wthYc2g0bqxDDhxOfwYvDomJUDXvFY
	xVyL1U36Ud0gaxcVazIgxC6cdcfTYkqACNoC+pUryCv/Lch9paAFX21lVzEzBReX
	fooiKI+xWzXyvD95XIqn7av4uy42nRjimaDzRC3ATVZKowpibaCI1XVhZjHB9RWc
	ZguNAUgHeGaEqm4qfwPfxtPO30yVheFJhSYQbuwxLsQXmH+P/EB+TZvXpgrMCBmP
	9RHk+LQh1BfY4zCOtMJ5eN9aEp7nTpLlKWM+RKljue51pBlsxdjFQKWi5WlT3N23
	jUq/jo0Mki7R5p3KXEbtg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792389431; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:SsSW+xjf0BMC6qtMMuJTbRpJiGaDP5ctdKjXSuNvSU7pu7T
	2VRnU0g6LGuLI+PAZ/r/2/BELkHZjeJgYO1rvw8hDyZjVWJmkuR0WhS3dJwMLhoh
	0HYT8/2UZL5N2jETWm7IBAYYorMULVe/smsLu3aOuz4TWCXAJy7tDOawL2ZeoTNU
	xJ9XOyoP3URyfNUcR6PdSBBhOGGdAvU7zMVbmpazrXEpCApMK7btHDqvyi4Ffrya
	qVoDajwG92HE4NIEmGpIY2idTkkAyaL0rJI9KKsuKOpGz7aYE/7PhEH7WON6uHCX
	3GJqAPifHLE5Q9wTXLKkYtIowAOpDlmDyegQxug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:K3/0U6I3AVDgaoBaEU8kdaUmYaXIK2PPqZS7BN8oA1o=:uzQbvAL1rfXDiHCRgz6KkB792E6c2bM4MdAfFchQGUw=;
X-ME-Sender: <xms:N7HVarFR9Mq-qJkQ-cMmNmNnbxKV4pYzeKxoXgm7CMzF-pP3RvJUVA>
    <xme:N7HVavO0xNPTqCKpu2sQ_l7UwYHhzXnb2-Ku8fhEEJsrYcb4lJX_-2pctpv3NJNGM
    ActsNEtda9ICq6Kr8D00PBxRjJ8j8GK0MjlUfG26anUtG0Y35wAKLA>
X-ME-Received: <xmr:N7HValfwaRI87JCIjb4ywEcTlvv18yBpxhqz97ugWGQoDZsGnvdRmPm3495o59pRKQnFcOuHv7Ks9FPGYI39jPUFc5FR-N_N0vZO>
X-ME-Proxy-Cause: dmFkZTFzPLcxw7Uqb3TVlWZP5AGFaWQ2X+3caPvAAdsB8uAlidlIMNC04lussUA4cP4RGL
    DiKe0QwCvoQUW0IS9/pkeqZ9RYpF4oe+W8PS80WuFqgNr1Qlwblyj7aku/+d0L6Gu9/fuT
    QeZai/xdo1lvhgGaHF9IEHAOwdLlDA+IGpDtfUO3AP4t8zK6UzLpAWLKY7+3IsGKBKumdB
    +YUgJTKlKZ8tqmyWYX6vcigUXvmswnUulnQqIONnNUb2LUMHWiKG1RAqxnM/1YVKvn9n78
    b0OvkFRmt6i6y0u6U0SwYVloESeYRpg0ixtTG0A8XpqMFvB+r4s9gZ8upZT8wRYgQSaanX
    hqUS4lnnmMOMJOv4zAPIiEKD3mOb/pVct6qZ9XBx/9mnHK5thu6zDhATaL9U8gou4FZWIP
    etSgwU73HRxbifhdE/0CG8e1PHPxFT5o/+UEwb4AWG7PfyBTN4F+YIGudThoKprnqyhiRA
    91teRwSoWTuCZKDHCUk2M3qNlzjKofrsHXQSsD+OaRlna8CGQSKdeDptVRw8ZDlO7K3oNS
    mvn21us55wwMvfdhkdufo53chnwhKlEESr1c/Su5/0Q8f8Eydqmh+8wLjarEp6M6m6416P
    fvz9J4O6nvkKAcuLGu8CiuxinpP6VL260h2gm1Mepcy9uG52wvWle3wZHVZA
X-ME-Proxy: <xmx:N7HVakup3oz82cr3NbDBPjwLnEiq-IUsmj7abKqdNGI0bnyyTBPUHw>
    <xmx:N7HVaukzIVcxC__NB7adc1cNW7-oVtEby4ZBK-uuM6piqUuDV_TFZA>
    <xmx:N7HVauzJjtpNa3hN9tYdMgyq0RqfHCmIAcm6N_4bqA8m3UxnvggPfA>
    <xmx:N7HVaoNJ_3tpZdsMQd-oP8HcwT-CDThZ5CyP4mPUaoe2YEHjM--uvQ>
    <xmx:N7HVahLTUBEbQJDm9L7tWWm53E-F5DebiZhtLspwRlmba4dhlac-wtt0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 01:57:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Curtis Allen Smith <curtis.allen.smith@gmail.com>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] read-cache: do not trust a size change when
 conversion is active
In-Reply-To: <20261018111851.GA27528@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Sun, 18 Oct 2026 13:18:51 +0200")
References: <20261013065915.879-1-curtis.allen.smith@gmail.com>
	<20261013180206.610-1-curtis.allen.smith@gmail.com>
	<xmqq1p9twdhh.fsf@gitster.g> <20261018111851.GA27528@tb-raspi4>
Date: Sun, 18 Oct 2026 22:57:09 -0700
Message-ID: <xmqqqzhm8c7e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> Looking at CE_MATCH_RACY_IS_DIRTY it seems as if the call
> to would_convert_to_git()may be better done in ie_match_stat() ?

It would be a better fit than the patch being discussed, even though
I do not know if that is the best spot.

> Beside that I was able to test it with a real live repo,
> where a clean filter replaces a TAB with 4 spaces: Now
> git status no longer claims the file to be modified
> (and refuses to stash or other operations))

The issue I was raising in the message you are responding to was not
about correctness but about avoiding unnecessary cycles.

If you rip out the lstat()-based optimization altogether and rewrite
the code to always compare the contents, status would not say the
file is modified in the same case, either.  "Now it behaves
differently" is not something we need to boast about.  Having the
code behave the way we want is a mere baseline requirement, and
by v5 we hopefully have passed that point long ago.
