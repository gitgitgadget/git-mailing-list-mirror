Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C5737B41F
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339960; cv=none; b=M34WXyWK0FVFEuY4GHsicwq9p4cepQIxO1Sl4Bs3tCLynisvlBsGyVwm3ZTls26ESU1UCS35oMW0hFBQSp+aBLxFaImTGXW8UZN8WfQDNrye/AZevFn3A9fR7rvxC6RB+gPAWAtw9FQrEEQNK9oaI4qypFv/WlniGMq2gNaw12c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339960; c=relaxed/simple;
	bh=WBOthYrI4ccKFyH6x4ayvX4z1QLnc1xDzRTOUvuIVao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=djtvNkyMphad7JWZhKXXpJ+uqWiqrVQ4T48IVFJYPaQu4GPu4qrUu1PfO6Q2EP32i+KSUjlpytsflnsTK9RT/AWr8kX/lNn7O+Lq2gmG2PHkQ94YOCQIM3XYn56YS9ESE81cAk1+FbJPMT231vyAPuHeEC/HZBJAOTGgoqzAZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DNHUzeAV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ThHx9yop; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DNHUzeAV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ThHx9yop"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 071451D000B5;
	Sun, 13 Sep 2026 18:52:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 13 Sep 2026 18:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789339956; x=1789426356; bh=JzdR/OMBnW
	Scapx9lWnWMowHMWlaOlMBayHjgJOCcIo=; b=DNHUzeAV2VuBkdBagrgRcLNUp5
	5Zz1qUtMICOducrm+9KhxHlS1bAEF0k2/yHBrfn4QJQwqNIK5FBkPZmOvWGhZpKb
	p2EThzfO3rHGybHNxBDyHvrd9pd03iJlrSyS8SyKch5XCKFsSRsc+waaH5SWr5Ok
	YCTuLZ27iFb07crg9fqU1HiYClWYZ5hT9hIm3bzZUnXP2I2H3tUOaKY49OMYA2oC
	oeZfPe0y2GmeBYnwFMomID4LJRYu+fbTcHk42sDSAtoTFizB+yeF9Spyyns7yA8j
	nEifZqFw+yzEb51pwSYfFcGQrwrfuqYI0U/wAJTyquXULM3L9dY/2MhpN03w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789339956; x=1789426356; bh=JzdR/OMBnWScapx9lWnWMowHMWlaOlMBayH
	jgJOCcIo=; b=ThHx9yopXj+USp44qRZdCZJ76VLxykHp//HoswCxaF+oTbuxxSA
	02gkaPWD9ig2ku4OgTGO1scBSfaj3voj3KYvQUy00Jqa38DKgXYR52E+LcJ3ths5
	tXisBrPWRDawOmIP4vVBN68l1ZMWAd+sDnGwQuZy0y88owUhwhFNYyDK9Ekz3AQn
	tpZKaLKW4/9+HeVLW6eflMNHy8J7ZzcxLkl2t+92b1gCkXpnR/xXG9SiSxCJHXtS
	X/5RlMlXUJuil7PjdqEpVoURrXMggW0wbeQS37K2DRbnOstYgPQveSMRJ5+cOT43
	VrYp2jBhMjZ0SOiBiSTGCMRk/dQwgHHf5Hw==
X-ME-Sender: <xms:NCmnavqbBOEjqdSMx3xk7ZpNxo3bI6EthaSps6cSrHTLa-H_4XQ_jg>
    <xme:NCmnatVGAoHhVcD7vFnGpDF_UFh7L2Sol47sA2tqFtsVbJsHC9KRZI2tqBIzXGU-6
    scrazRbD-IKUZw0Fw5irmP1kys9e9_XO17LeXr8uJmlKMsGodDLCvI>
X-ME-Received: <xmr:NCmnamDhukQdEiAMLWL8NzSLlR8CKh_ZyVVaUUL8FECCIRSqqH5CrdkCqfCRWhO01vSUSLrSlJ8e9qFUHv4dHdgvZ5r_LReCREWJ>
X-ME-Proxy-Cause: dmFkZTE0bYwa485hV/FeFKusu9EG7g36DATkH4ZD1TD0rxg140utEWZ7OnVF6TCeQb+Yzf
    k2AeWmR6+E288FYX5abIxN5fqKLjgaZXMrDz6U3WCNWrMS+NXOd1bnHarBmB/dVMV5FJTW
    z1VcIulZV+ikwJ9FnYNXATuzoIkq4r5cdvcmevTTF0v/cjNukgYu3WQrxrgt83pGpEYWQM
    xCgY5fbUbAcD5LIOV4P6IEjAnnJ7DnjOAWGjhO9twke5mS5TP/uPYxJIzSd+jn2H/uLFPX
    Yn+VIW7d5At4X2IDHlbYDQX60+zRZhhiAAytirUO50QSCPX9E7ZLWs2uCTeI6AOLKWZWh1
    4jPARPGuhL8qsRa9JM70+j59PT+TLwD9oEi8G385gmHUlDKZb96t0LeSooO4u+PkFlV/lB
    OJfE5W4UqOrFfDLdwo+HPD1EK5nFP4MwUdzIzfblR2iwqDELZyrtjTreEzpFF/+mblakix
    xOPRkyj47oItcePAsPAOob62bKWzc/0RyCIpTVAr8IABi5mM7bVbVNs7pMzkjktF6hSMwN
    o0lm+EdAuFSf6SC59n5isBmy3+EUwEJNY7gC9NidnzG3t3okKAUyGp3u8QCdhAAJ8H1pRa
    OEoUisgMc2J1NdoHliaukp7Xh8/rZUEuY2rB6fIMs5qELRfXHrxeVzt6W+bA
X-ME-Proxy: <xmx:NCmnap2lexKcIFczLcelsvc3u8iAdnNCVSiWg5H3HiGplFwbrTRtXg>
    <xmx:NCmnag1hoi6HpDK1EI5nGSUm9wYw5EfWlronr6us9qsh-SaEBWBgPA>
    <xmx:NCmnamAfgQtaPBDtrQ2y9zOKn0U-tHUD7KthCRUrj-bS8kiufOXhSQ>
    <xmx:NCmnan4SsyL-LD90afAfbnrjnIBfv7JZSE7rO0amLJziXA1nOIXmeQ>
    <xmx:NCmnamwYDHVNtpuyv6l0eyOkH_A1UrzllvHh5-_eSFm4UKYmlzWiarki>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Sep 2026 18:52:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  James Le Cuirot
 <chewi@gentoo.org>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/2] Use Rust in the Windows CI jobs
In-Reply-To: <pull.2213.v4.git.1789315032.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Sun, 13 Sep 2026 15:57:10
	+0000")
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
	<pull.2213.v4.git.1789315032.gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 15:52:34 -0700
Message-ID: <xmqq33vc932l.fsf@gitster.g>
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

> GitLab peeps, I still would love to ask for your help: I haven't been able
> to confirm that GitLab's Windows runners come with Rust preinstalled,
> https://docs.gitlab.com/ci/runners/hosted_runners/windows/#available-runtimes
> did not clarify that for me. Patrick (or anyone else with access to GitLab
> CI), could you see whether this patch series builds on
> saas-windows-medium-amd64 without need for further changes?
>
> Changes since v3:
>
>  * Now including the "Changes since v2"... (I thought I had edited the PR
>    comment, but either I forgot to press the "Update comment" button, or I
>    missed one of the many issues I had today with PR comments, caused by
>    many a 500).
>  * Removed the now-incorrect paragraph from the commit message that still
>    talks about --target.
>  * Sending my humblest apologies for such a quick succession (but I really
>    think that v3 is ready for next).

Yup, and this one also is.  

It is our practice to cook new patches that people involved in their
development agree to be good stil in 'next' for a week just in case,
but as I assume that Windows have unusually higher ratio of binary
users relative to those who build from the source, it would not
benefit as much as other platforms from such a practice, so let's
merge it in 'next' and fast track down to 'master' immediately.
