Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38303FE377
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535352; cv=none; b=Jo1XdiC+QBqRTkvcwNmFdbwtJjRWPLMTBYcHFgsd+l133+5QosvQGEQXVJmF28paD7fhluVOBLTl0cC9oazS//xgCJD87RfIIt4GQ8iJPYgBDdtNgYKAxw8Gn1IcaEUZGatf45FpTeDuz5Ij2wesFgzekBqaye67Z9kdr5VFHBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535352; c=relaxed/simple;
	bh=+yxXN4Anvai7Exrfdg5jaizKm0LdIfB/qUJDuFzk0zQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pjh6KWyiF3hyy8J1pBnGYwgbEh1u1Np0NrZ72/67kjS6dYIgCRH9E41ahTbsOZrzmC8t5HI+uQvS6KDHkZo7ICCW8Bx6nKG9P52o4zGb1Jf52WllUP25RwGquiDqwP/zKHeIsDrYUwV07WY9+43MuDBKSO/ZpA5zecUzsNrkmqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m1NRZlu7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BaefiTOg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m1NRZlu7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BaefiTOg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DADDAEC02CA;
	Mon, 15 Jun 2026 10:55:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 15 Jun 2026 10:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781535349; x=1781621749; bh=Dz0d85MvRN
	cnspMumI4tK9k+fH4Y4VkR0Q3r7NI27Lk=; b=m1NRZlu7mRfev5qorUFl7tU69j
	fqXkheyAep1R6bEX0u4s4B+lc5nWo4z+PtOPqq0Q45nBVjZVs7Mri3G6fG9wv3bj
	TLmPRAZkLObGIsQT8cM30Qmg3xeyXnzLB4gWZom18nCFASjffBUcWQFA7jq2p/Ou
	l3fdkJ3IHyiqqTjXEZHFNZYRXm2CRn7iiUSgIAZSnWH5uIU9rUbFXvLYlAfUpCF8
	XYNWwnfeCL7r70kRGfy4ni3EQ2gjIvg4027tKQDm+jBK1JQCtOtePYmkcGObMd9x
	b+iew/b6D0SHtYcLYHeiXdPAWZ1J8+DRQkT7WAYCD4RvgVAs97xOTpJXWsyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781535349; x=1781621749; bh=Dz0d85MvRNcnspMumI4tK9k+fH4Y4VkR0Q3
	r7NI27Lk=; b=BaefiTOgWTB+3dw56cFmZhB56dNOwd6/tJeJybHth39xmOJipJX
	xwnJDmrEB0absFBCW9DXotTQEwKdZqyuyXMMQCt9SETOetKV5RjZBhqPLDwO/KJ9
	fpST0qAiU2HmhcV+ISqCkDQ4DiLtmwJj5LncX/AuKcMlnVDsG9NSG2XugjWD9KD5
	i+yZDK7/xZxnggDUMJQAMplSALMb/DkkeKNKB0hnkNIbpXza37hZEyi0WMJY8Gxz
	rmt1i6DdiTBNZySK5pZWQ3gzQUlzTXzHLAdmDaSpDt4K5vQ7iOpxx1eLeQZXPkat
	ESRXIJ5uKvpgTOompdt8xJemH0LEWsNmiyw==
X-ME-Sender: <xms:dRIwanRZx2UGlMwsAEKz_8RD9Q1GEtZTMuqeLY_JD1wAsaK-vdZNSw>
    <xme:dRIwasePoHYStSgRdwlXH2mMIIAe6vf-El6yGkmXkaqvt8CcRIstufVa_kWpoFsuP
    01TXLsboN0kRUP4QycVHvZoULiYr_hhwGxxj43HF7xYtibwvPIa>
X-ME-Received: <xmr:dRIwampcwSlKBqw2WfgHg27jxGxSVhRLZ99moJbe5XoG9CT0TAiVLSO8GJBLrCIFuNTo16na5XKT-RfWzI2Sh4Lh1G-7W6anfu2u>
X-ME-Proxy-Cause: dmFkZTEfzHAuldSRXUB8P7Ll3pryio5Oo2r1UVBxxKvnl7OD791WNd1gTEPJBOebvqo8Qf
    ZBfRCYfAWZmbSmEbxXWqId+I6/Ru9M+gaKZGWKz6oUuB2bFjogMB5yF6F8yLL6D3F43q3O
    et1/ud9652v4Nr+no+Re0JI8vVjIG147w1sWGRxMvRSPCDm7NbqQEkReWdsRapcv/OCHTE
    jujA/b/ckTCJw7Jo1+0WeLu7wP+lIvZniI06SXjA+Hv1L4oEwPwuR+pWc12lbLMzFmlDbg
    RvqMmHIvXEVnToMTR1ebPNUBS41Va2YNHH9yY9W2E6TrM5tgGxsd/FtLkBI7euPpHmMpRu
    i0W5orSPDpd+juHsoV/x+9uLjw2r9DZOdsRoNU8dGCm8tJdKDMlBpFbJCOjXzmDtNxUBKI
    1BhXLOc7ioDC0MBV3MiY9f6J6gRSp11MBEJRqK+aqqrhVx4Z1CX92fcpBmf0XVWuFnprbl
    7n27j6Wr9LrLD4rEcm2KF555H8i7xNmazwlLwVMwcTJ2Ltzb0YX23rS5btSHPQDqzEID3p
    lSmHBuKUZxphFLqGMyYZ3/ig6SNO01BY4gDW4/eD4DY/6wUZ6yvYzBsyh71YzN/Y5ov6Mc
    nwXkLjeWVfxFrYvsIiYd3luXnwzgKKEA7lEcd4nk1O47kZz4iZ0fdeBvAAcA
X-ME-Proxy: <xmx:dRIwat8EAYKztXoowRJQAqgAradtOt_wlsABCw9KN47d4ykQ-VYomA>
    <xmx:dRIwaic82Yql3q_3eWlg0ife2fXZVhdoI5chJm4oEpp6Eqhd71Geog>
    <xmx:dRIwanLFrR_MskdUSNa4ThBUzhXNSQAlTJHDZaMo8G7L-CRanQSd_w>
    <xmx:dRIwaij0gYtMkm5HyTlxqZMKu8NlVIpBuit4xnspbzXOgXcUWD0VfQ>
    <xmx:dRIwakLG9azRyULlDPoXwSVMHxiaNgUWTWIYlSYLl7LhgrCmZNb3GBtS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 10:55:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>,  Patrick
 Steinhardt <ps@pks.im>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/7] More work supporting objects larger than 4GB on
 Windows
In-Reply-To: <pull.2137.v2.git.1781524349.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 15 Jun 2026 11:52:22
	+0000")
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
	<pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 07:55:48 -0700
Message-ID: <xmqqldcfdf9n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series tries to address the problems pointed out by the expensive
> tests that now run in CI: t5608 and t7508 verify various aspects about
> objects larger than 4GB, which Git does not currently handle correctly when
> run on a platform where size_t is 64-bit and unsigned long is 32-bit.
>
> Changes vs v1:
>
>  * Rebased onto master, which merged ps/odb-source-loose (with which these
>    patches previously conflicted rather badly).

Very much appreciated.  There was a rather old set of patches by
Philip Oakley you relayed earlier, which had the same issue, by the
way.  Will queue, and will try to take a look if I can find time
before -rc1 but no promises X-<.

