Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5AF4195A3
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188406; cv=none; b=goMeFLFKwdzDGODqv0ZV5m9KAqsoJ8BH3D8hsBuWGKgRemtUcVivxHw9E+nDKTBSQY0cozCnSKvLH9hLn1NuLqYWGbucPXj3OfR/d8vIHmg+O9VzafHsxizMMAF6HyDH1vc1xASiEDzYzVG3WLKYovQvY5xOO/ubNBO19RB1OwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188406; c=relaxed/simple;
	bh=w91s2MHJr77LqxqVKvJyQcVmVFQi+brusGqXjsZI2g0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FP+0JMsgaT4uQzxJXBfLiiw84mfDQ8CUG1bv2EGRuL0wn5gVvdkIh1SzZX0JgYfslFnCdYPjSdcKRtwW6HmD43ZM42RPkrdZttpOQ8MofGVzsreQFNhXO2gb4JbBOIJU6KtK4nkqchT5M4xmJmRCKlARBA/2CGakiTAao/J2LnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VpvTsR4t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WOWKGw7Y; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VpvTsR4t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WOWKGw7Y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FECDEC01BC;
	Wed, 23 Sep 2026 14:33:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 23 Sep 2026 14:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790188402; x=1790274802; bh=q9yjMoxV0O
	wMGhMI3+yrErDcpkG2xXTckmmgB+KHC0s=; b=VpvTsR4tEXaDBjRmIuw9Sgi8mK
	DFMtHXw7V7wzcfc7bOezsldrSTTdG1aL466nwPHk+cUzAQmLGFPkxBCZuS3HMUtc
	Fco/FzSzg5KnGd29JVbbw7MK00SoqZN7XlA6/piy5rrFucudywrjZ/xF8L0bvjQe
	cCTngwWKPmrO74J50QL/d7dcL6d9vMl6J9/rYO+FL2SFpXyNjdLC4haKhCmEpkNE
	8Mj+1bYh/IeRv5CwHCfnkejreaDfjaRYAQ/cTVNaet6wFo80HtoaLRYM90ds1zJZ
	iFdH6bMqC9Q0FSjs0gkvIeiLfPIemooXZnFkop6qz5C10PReGSy4tAJv7n8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790188402; x=1790274802; bh=q9yjMoxV0OwMGhMI3+yrErDcpkG2xXTckmm
	gB+KHC0s=; b=WOWKGw7Y1WZBBWYmx02A9xq7x82hNKvhYGEaVI/HepQmgLxI6nv
	45hD9Ls37BdSKB5wBRrKnpgKl29wyNy6AbbMqAfHPMrXJpb/cb1lTOkP2vUBJ5x4
	ynvXxTpthklXJcjXw7QMwHW3LeewbyDiBHPTvsFeBskXAvNwhEHyRcyTWsospC0K
	IXbKd/Jn2+ph7Az+moNWx2e2awRDKAb4ts8zXm5cG+pfwJ/0kgKTi5Kg5liyu33i
	iRhscvJPZlamAn/4qcS3whE1cdTlHHQKiO59HCOsi8JFTJBKl+itQyKFzH2dT3+N
	zaiDfxYZcoz2gMIuqdx/tDZM65G5To6Jt9A==
X-ME-Sender: <xms:chu0aj_qQGd02aa1AWrhHRIGRTYWxkxNpaV54q9y6WmOQMLhHhv4vw>
    <xme:chu0amsXW0A7VIh6lgaRMLPmsr5FSuI5H1-onYZN77QlTRDaA22gtKVZdXXep06xh
    WUfjIJ9b2WDw58DSFGjQ36yJ65wbLpHleF4sCKso046MUQtZ71oVg8>
X-ME-Received: <xmr:chu0amAoYQw3-x9TESofji2_qT6mp9A8dXE0KO4PM4Ace3Os7aooGD3D-lzUsh7lnD2ORgF65uQpZwixYZ11F_KyjB7QLf8gJPk5>
X-ME-Proxy-Cause: dmFkZTEUgqHFrwTyUseKL38AbVUszLxusyD/13PB4+6a83EM05DGf3Q99PcZtR57rteOnK
    HSt/LVnOdtp2YbTQ3UGxEMrQ+VpG1NhPleqvSvX+PiuFDf6zOmKGi2X2lAmixhoaFqvs4b
    rqpF2Im2BW+0kjgSkxZd1lBo+e4aGMyUNBGm+sNf4pdTGEEeMYoeeHKUvSxeRke4varqJj
    I3tbxeRLORbXn8oZUk78rTj7/+jDcOrhe6cpEZFedl1dzZWSpZUt1yQsMqq8Waf/WleCUk
    etnXfdQSTfNLT+NcgJkH3WXveDCpU7LhLzTSkatT4aB6W4kvYGIDJnTjAADWaqD+264IFs
    7CA+QvMnRzT1sii9hN3B64RR8JosANkwQByMBSp3DZOz+UKKuL1LfSV10iBt6H0Fd7oZZC
    FSAAxc0/g5NdPh3DvOt3me+5Z07mOX4lmAJU6t7jVI1DwLZzTVKWpUgjE7i808YpfSmgPY
    cYbiwOOL3ZYH5/emPsb2rKPx1d50eNrv0RCWR83ph3TK/zeriMFYi0eU2TdXajk3T/tEkO
    yWdiMvR6zv3yv8iajLEZKhqpkkRxpybyo6E1oJVyryaGXm0NPMkQ2jA+H4YKD19V/qZ5an
    FTT+lIFjQauR2VShC29eLLBJB4XVOh9ICR4sb4xCXYUoaUcj3wZ4ZJWby6ww
X-ME-Proxy: <xmx:chu0auV-ROGjQtN_AW4IiwAYQc3x_9kp6yTo0r5hpn7obuu2CfwZBQ>
    <xmx:chu0akD7iLINQVsv2dFankbn7V5g9mo47WiA8Zx6pH4Sm7xABas6qA>
    <xmx:chu0ah_IpIOO9fdZQmWJ5ilCyEUXiNfD-DlooVzaLdTCE4Orn70cxg>
    <xmx:chu0arEidP80nieRoGDWQUH-e8WXDbmlHM16HKSc9LvuN5vUYym6RA>
    <xmx:chu0apiGhhiwgGQqriqMMrAYmM4SnvJEbug2T07-ayloYWBw0VS-sVb8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 14:33:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH REGRESSION] builtin/rebase: allow user to amend
 committed conflicts again
In-Reply-To: <arQZDXxf0139omx5@pks.im> (Patrick Steinhardt's message of "Wed,
	23 Sep 2026 20:23:09 +0200")
References: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
	<CABPp-BFadjqtOB_9cYkrs9UBgTp0hQxu4oiV_yqzYOuiu6g45w@mail.gmail.com>
	<arQZDXxf0139omx5@pks.im>
Date: Wed, 23 Sep 2026 11:33:20 -0700
Message-ID: <xmqqzex7akcv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I think reverting is probably the safest change for now, and we can then
> discuss how to properly handle this. I'm not a fan myself of refusing
> the commit outright as that would break my own workflow. And I'd assume
> that I'm probably not the only person using that workflow, also because
> it does let you inspect the result before you move on.

Yup, splitting a commit into multiple pieces and other manipulation
is easier to do if we are allowed to "git commit" in the middle of a
"rebase -i" session, and if "git commit" is to be allowed, "git
commit --amend" needs to be allowed immediately following that "git
commit", if only to reword a misspelt log message.

> It makes me wonder whether we can instead fix git-commit(1) itself to
> maybe not reset authorship information. But that's probably a much
> harder change to do, and probably it would make the mess that we have
> with the ".git/rebase-merge" state directory even bigger.

I do not think I understand what you mean by "fix git-commit".  Make
it pay attention to some file in .git/ directory and override the
authorship information over what it usually uses, and make sure it
removes that file after it consumed it, or something like that?

