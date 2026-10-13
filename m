Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA58282F14
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899709; cv=none; b=QuOmKnfsi/Ev02SRkshGAOU/AT6HotVFu2mYs74nROyu5j7/yT0Ib+0/wDtWoowsNvVpVCEKzKVuMe5/aRBm5KdHG8brGc2KmxC9hLICO/QJeo5sReUa8V89USt0c7dOD1dntHdp8OI8LY1/XTvupwfC82o+tKuUomB8b0exxgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899709; c=relaxed/simple;
	bh=fGM4Fz3CQcHSUWnhh3fRGsaSGy7CRJgVeTqitVZOTJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=huNl6hTFm3Lx2AEqriX4hXxKmQvSA5T/2J4fQqJpn7gr2rrqG8NnT0sT6RnjpXfCiKuYwRf4U4w0MrYn1Ch8JxMIy7scD5z1LkGCTPUG6Zcgq2gydP1iQWn/7jhBxUs5/lrawwSMU27vUaDlxekiMd+ZDSt4cPU1uwacLUl26O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bVCy+Jb4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=owkJR0If; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bVCy+Jb4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="owkJR0If"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BF0921D00178
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 09:55:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 09:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1791899706; x=1791986106; bh=jmNPzf5vh/F9K/YBluFsANqr1v5X0ejp
	CPaGGljp4OQ=; b=bVCy+Jb4qnXkPHLvQiHhEq9XAnNC8lPXgD7qU7V6SFcbWzLb
	7SfJqwRSqhR06zdCwwtNPMtgvO11Ii3eHuwnLHdskJs8OA7Mdd1a+/RekqcmV7lJ
	N9a4W9EJZofHhq0r33HejSsC+KF2iZ22I+Elo92C4KeB1g5obmdopbYDpmSAPyd1
	k3YWLMXROeMzB7ZCjYWYGCXCdsdxlTTnQZq+2WPxuLYzSYGrVdWHFCN76B8csUJ7
	/O7Pce95oAYu6CtHqzYvKH9n9WPtHgPMyTf6xFk9fcA8JCl0MoLSLj10eoqoSL1r
	t1v39kzNF/5/BIzRFNtsZflEIqR6IqCPgp3tgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791899706; x=
	1791986106; bh=jmNPzf5vh/F9K/YBluFsANqr1v5X0ejpCPaGGljp4OQ=; b=o
	wkJR0IfPry0dmmSVUq3mFE8LJMtqQNANiLvotjiv0bDCuuIw+qLkMNZM9xSTZ0+Z
	Ct7uLN6z/dPLymvtlV2PhjO9JkDmyfIYEwTggj04Wa4C8hW3L1URy/xJPOL/n8pr
	/AroYdeR1ITSR3cACeLzL7tRaQHrvn+ZxLm1dFP+cyU7Q9jnFLwVaLmMPnEGZDqz
	q+nbLDx9SxiNpwgznZ8irkPl2FLVzcWjNeTMcXDNl7HRApA/J4fBZOu0Jp9XqNL/
	8dHc3M4JUbFOV77jyi4K+8TBuu6hsKakvq1TWlKMrUsy4bgCoMlxIEObYu/xDW5O
	9kFsQOO+fsJVZaWRPwm5w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791899706; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:uft5PayfGaq53kN1kuCHpYKzsAIUpwCBsXAt0tfniwzrs8k
	f79AfP/0O0lsd4udwHxjEYqY6zmhXTawff+ZzK+fCpIjUhT+pLKmP26+z2aymtUW
	tkeLSoxbID71IGUMcC/3W1DFVKEzyhnAdLMf/xoDoKTTvJ7WqkaAxoqcS9NFnUo4
	8kejW0Jah5Cc6Kj7RmGUWJk4/9WzeTrL8PPPDtV0e0NRrHJALfAppLP+3+6v9+gL
	kRBkJ22bXHaMazEyycvMEfc7WjU2tFxlCFhQAS9/pd3mKW9xTMcq4+i6IaoT4Os9
	gTpUe6J9uSbUN00kApNVewdyHbgT/uMQOQ8l+LA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:gkGtOLQZGYPCVWHFxLuujWk9Pz+z95urlttdbeYQbdE=:fGM4Fz3CQcHSUWnhh3fRGsaSGy7CRJgVeTqitVZOTJM=;
X-ME-Sender: <xms:OjjOakHfyIGmJDMkyK752K8fmXZ28ShZqphY4LqCJXA_1n7h6cugqg>
    <xme:OjjOajUUm8F-ivQVEF4OlejhPdz7ziTC1tpbPD6hq8Cc0yQYVaQpIZANurPAfhHTz
    kU5E_63hh-R7NiyLUKU85AxJrLr3qHW-uDVOBWsJi7pMmb9kQFiurw>
X-ME-Received: <xmr:OjjOarwuVI5IsLBMVke_neRy-CJtTVm3Vebm7QIqksiwBTMWpnVBoQ>
X-ME-Proxy-Cause: dmFkZTF9bk9pbrbn16xBLv9TZyJFzPoSCplDNrFowlf0eNudWo1/u7/ZU0w8FY9nO2QAZO
    wnmDeP1NEm36JFW180hB+qmzzURfUPduk0Uw64JpcBHvnkoSxoMa1U+YF+qeRMRnMjjsrU
    ejnR6YVgwbPXMNSSHKeOZaArPv3inZf5gPd7pic4Hk2DPKS+sk3imU9a3+gzfq09/u1cWz
    O5e/ipIvRKxnU4JF0N95/0qdSEtLgTkrxi/CT/TA7iTiPwKcbO+fDMlUXjZvbXfcHatWOc
    i99CrniwcmDh7fcAyZ881rxVMB2oJww0ZSNQu6rmMaodAdsNfi4qxXe7haBizOHYGc1PgS
    erzq3fePs74s5AqOpVVN9O/zhUN8uemurSpDCWVzhNrEmSflvdJHwIwohAkEW4NulqatWR
    LGouOOIk1qoJp1Y8xn1cj3c3T91OA23D6TDDjtWBOJCJy/2qzyE5g6g280j82qtYNc4VqK
    MW6EU9YehtSQNW3BzA0avPk5Qb9IDwFfLEbHIDaT7dGocnpOxVclmkOrzjlIYvDv077EY4
    Q2MwOMwj/tatEFUr52NRQO7N+pPLYp9JFMru4jXZc1c9xlWeejKbeoZFn1NlrgKvwAhHBu
    XFpEGERRXHKk8PRMR/yddd9wIKaxlLxSqvQfxaukl3p/2VoV+Mel5hZeBzDw
X-ME-Proxy: <xmx:OjjOahMX_4BWOacH9iDJmNeHMql9J2iF5XSJWcZ6p5CTQX-U_iPWEQ>
    <xmx:OjjOas5iosRgv25xod8mSf-4YDsLYyyFHo3XyrI2ny-vburcotVZFg>
    <xmx:OjjOaiMRafWeS4L4ChaXQpxGqaTtyylcf-lk-pIV87bNLaxvvOrpjw>
    <xmx:OjjOaqlw-uQKSpqVqjT9Dep-PSdoxAHGxmufdkwz0GxPP4lExfP6Ng>
    <xmx:OjjOakZmcrsY4F8ooXxkYcdT1Cd6tBMfclGpSMOFamtm-Q32wc9nadeb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 09:55:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1ebdf66b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 13:55:04 +0000 (UTC)
Date: Tue, 13 Oct 2026 15:55:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Miklos Vajna <vmiklos@collabora.com>
Subject: Performance regression in `git log --follow`
Message-ID: <as44NVKZA9C9S5ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

a user on IRC reported a performance regression in linux.git:

    $ git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    $ git -C linux log --stat --follow -- include/linux/rsc_table.h

I was able to reproduce the performance regression: while this command
takes roughly 33 seconds with Git 2.55, it takes almost 8 minutes with
Git 2.56.

I've bisected the regression to 304812ed33 (log: improve --follow
following renames for non-linear history, 2026-06-22). I don't have time
right now to debug any further, so I decided to just forward the report
to the mailing list. I've also Cc'd the original author of the above
commit.

Thanks!

Patrick
