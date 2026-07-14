Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002141A90F
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054519; cv=none; b=NbGEM/nGgtP49hjDgRVPMjRmnJcUJ5nhgwD5BcMlL7l5Gcd8pY7KQip2uMgCXgpc78K2rki00vufxK6uiwUJQ9+T38IDDYCnVnb2kRb3u5haIa2xHx3pQleAHTP0ydd9IXuvhOyHTCqWejfZbPDu9NTcOKJARhjD7FebNG9pzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054519; c=relaxed/simple;
	bh=y7VI9khSL3SKcXCQ66B/jyJc4VtDRJTw+mS4oe0Dvnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ry7hn24+/SD7La0kwAvN7trXFVnknazvUg90GjBqkylnx8BrG8zxdKIVJIi1qajW9JKFThPK87alrU1/c5xHZdQoSmmrj770ID+vbB83w9xuf0bShIdpeVGW8gmwIuMoBumO6gkEMT5uJbsMm5Y4sVCsWMJ88KIKEmFhyZwOuLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PldIAlVF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XIDOM/Df; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PldIAlVF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XIDOM/Df"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 701001400122;
	Tue, 14 Jul 2026 14:41:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 14:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784054514;
	 x=1784140914; bh=oYCyU4ClwdnZVGY35lCuOAkblNRWrzIwjNnsYWPy5Bc=; b=
	PldIAlVFF4TC47O9hveEb98H/ZDJ2twESAxPZpmz0xOsYgLqseyJJ7ESjQ5Q8dC2
	1Lw6EjaKqA0JqUfHRFM+3AD1koei2Ncz2Agv+9o2+/ezjRIrp0EgSF1RfTHH+pMF
	NPi/MXcrcdLlBMe7sGDgpQltfmnGZo5F8bn163HcyEB8WHruXpHUnJ/L4lBFSRF+
	BFAllBNbLOlomCxdLlWGrPZVSIOQWO1PX6PsUpUoj2uJzJuj7Be2jMuyef0kKHO7
	/hMLAFGMgeMliKHdzE5HCSRHWGiBngZgSV9095CXYnHCdb3oZTGabUqxqx0FP6oM
	Rz8ix+JWrdMARRLeWhQbfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784054514; x=
	1784140914; bh=oYCyU4ClwdnZVGY35lCuOAkblNRWrzIwjNnsYWPy5Bc=; b=X
	IDOM/Df+vn98a+uuHAfz/kyT7YCKZfFvovEiXcC/efOWMrldvVaD/4iRGaBI45oo
	/PAiKgZC/CFdmpUXRlbMoRJNV2X0f2wpuhGJL8X+CNMTT2BKOJ9G91K6EKw5TbSw
	8WTKG7WYG7eLvTOQc7BkqsQMQ/MmDZcfAfNb7LoS8SJZNvbzDMBKo5Nrzxymy6gA
	jg7tnhd+MOxp5ORw2gbN1KprgW8mr8MNQGTqBT7PFxfAQHp4l4C6v16JLDa8qNKo
	kE8/jVHiDVuUYOrrdsaL8GAfDti6AvMl/RUu27F5LWafXjzv0QFNlfhBaYopJ/sM
	cBgOFE+O8GrBUDrgApfrA==
X-ME-Sender: <xms:8oJWaoDiiDbnnBjvXruz-d_DuMrOL3t3zmzkqT4df-1x8xqKGTuncQ>
    <xme:8oJWaplrMJCNr2GjJdb_ZYG2Mk1-KcmRurPFkmauxM2pvjZJj8TCcqqWbWyjPWkF0
    IBUFZedkV9z67qOoABugJgl2wsc94MtsFOyf0IbqyH8wqBskmcEnQ>
X-ME-Received: <xmr:8oJWahwE4ldMCcLe5Ci6zWay6cUm_6eU8mCwxWrrkD6c0b_oOuKTm_oGd_-HZsdCAXizofXAZritue3_xg_knscu0jPVZ_2aT0s9htg>
X-ME-Proxy-Cause: dmFkZTEcfEyQ7h5T87vN7V1kzQewqZ+LbMVAFmW7utA7JN8vxRioBikuaHWlyyPzysxSv8
    NPyoRIs6QYrh+2IJjh2kqPvB3FyN+TTZety9x/xnoH37kWPzGH5UBmz1KoNOT3gdRNqv2/
    Ha+V0hNLtAIeR6MTBMccsE9URt7645aJLSbHlawAwHIfyApSPkII26dKmaAdgSP8M3WpVn
    yJpv+needRj147rtaRtDz5JCkK84uyPqbl1a/wX1anEpPLpnVdMd6RWT7LlP1mjg0AXWPN
    hfuyzoxEWRQDqG5hd5VxHE5ECc3VIf6spxgjBUKBls3cpryhbVoW0VrGpvqwrsPS+EG2oO
    XtHg5nVRmDuGnOVmVUttY/L7FRbAS95acTE1t9h5QQhF7NmTIh7k951LLc9ilZHGIw0brI
    CAJp/ZquxiPiWU1QApWmKxqw0xk7nSteFGKE/WLhNMqCNqMg2psAuiUaH5vQkyWxUFneVd
    t8v74tht0zHEYwvQrlnbOD8mkr0gOxeVklEbcbhq8K+KPV6KKgSVesefjDGRz7lAcCMy7g
    kg6xrs5zo2FiKSz304mhhJ8DSeCuAjcxQuTqF/7rhzSxGqo3SuNhJOlMsDs0kfohw4tsg1
    iEoYtYYfObDBATld7ReqQG1FxDBtIoApvMpHNAI7g8zKmGwit2/okN2n9Ouw
X-ME-Proxy: <xmx:8oJWarQFpgEuGw0reYi_4nFOp79ROexoZZLOLQG08bzrjwnxzEtAjg>
    <xmx:8oJWah-0_l47_QYBVUimYqzvgegMujKJrUxvNpTF0r0K0dNfTewnUw>
    <xmx:8oJWahuJkhdUHh1iXJTvaA_kL6jOT8jeqI3c87VVmlZ1WkES9q95dw>
    <xmx:8oJWahPzOQJ07NaavZctsIVkSrgtYKNEF6wWvhmzhBVsW6RIS9InWA>
    <xmx:8oJWaltMZSg7A_Tgs_82EaSJkdv53xggpK6AhLJrk9-gXev2rlAuSJdQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 14:41:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Matt Hunter <m@lfurio.us>,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v8 0/5] history: add squash subcommand to fold a range
In-Reply-To: <0ECE2A94-0537-42E0-A525-FA16184D7735@gmail.com> (Ben Knoble's
	message of "Tue, 14 Jul 2026 08:36:07 -0400")
References: <DJY0QSJYNG0J.210HZQH198Y1N@lfurio.us>
	<0ECE2A94-0537-42E0-A525-FA16184D7735@gmail.com>
Date: Tue, 14 Jul 2026 11:41:52 -0700
Message-ID: <xmqqzezts9an.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Thanks for the work on this topic!
>
> Ditto! I suspect that using a combination of « git history squash
> » and « git replay » to emulate « git rebase » in non-interactive
> autosquash mode will be much faster, too, due to the differences
> in implementation. If that proves to be the case and we can safely
> do so with feature compatibility, I wonder if it will be worth
> making the non-interactive autosquash rebase actually delegate
> through a history squash + replay.

Yes, that would be an ideal future, and these efforts move us in
that direction.

> I’m sure there’s a few instances that couldn’t be done (for
> example when the special! commits cross the current range and
> upstream; that is, a fixup! for an upstream commit or some such
> oddity;; there are also conflicts to consider), but in the cases
> it can be it ought to be a performance win.

Since you assume "we can safely do so with feature compatibility"
above, once we are finished, there will, by definition, be no
such "special" commits that the combination cannot handle.  By
the time that happens, we will have replaced the internals of
"rebase [-i]" with a new implementation that does not need to
touch the working tree.

That would indeed be an exciting future.
