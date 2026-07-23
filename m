Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629D32931F3
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767974; cv=none; b=IaQOhVJCZrh0q7gg8iujERTG5+nx6X3UoRXx1GgZbIVmNqQl9oy4yla0b7YW0zYd78fv08GdGaVHEasU1A/fCKzptqxHhNNAUjNcMAoTsGYP6Q8sVGRiN+mO5J2Ym8uqEhA+2ycl2wcdit0EpkBEiehQycxD9beoJiPHLAImVuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767974; c=relaxed/simple;
	bh=UBjx3bMiybpuBdxDZEfHd8RMA+sxA5b2ZvuO6Ag00LI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H5B2T1urBZHniQ4qT+qGGe0vL4aDfPASd2R7HERuVfZEqL2TSAiSiUNulI8+NH5Dy4ly3ouvQUVR8MIqQ0+xgD43Y/bmRJCmpkJ66/rl/4sMSp5v6Ihb1C2q72I0O95UXQFpTsukRyomcy1Q1ZN9az+cbeKJ8QhvVLHBr7Xa7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yy6WadzE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hO/x97QR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yy6WadzE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hO/x97QR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7826CEC00EA;
	Wed, 22 Jul 2026 20:52:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 22 Jul 2026 20:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784767972; x=1784854372; bh=JivHQeijRS
	U/dv7aLmoLge2oHWqeNfl7oM6a9KK08QY=; b=Yy6WadzEdP8RKPKG93kSWmTgM4
	BI5gQZ/1G2FVdpXf62apUv/t+mwNeRDEzhnUucmgmBSkAq3baVBfq7DA1YlExkf/
	Lq8S9Ay3xmxGdg0RzJNRLqHgbirvXR9gkibGeN7kdw4zczrLfYypucTPBE80Sg39
	aWG69GOd3R63p1kS3PI99wiHmdlKoae6bGswg6+6CYFgBeblEFodhrRc+sOAfZ2m
	NS4I6z2Hp2YSoINQ6Ax/W5yrqJl3YB3Y2jkHHeTh6pwxmWzWXpwBkEIoVhM65z61
	NGhsUAcaZ0to3BT++leVCV2/klMmUptHXqU8pcJBG9mSnxVqy4bAGWBNW8Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784767972; x=1784854372; bh=JivHQeijRSU/dv7aLmoLge2oHWqeNfl7oM6
	a9KK08QY=; b=hO/x97QR2ZETRBC2rYacP9S6FpPVvzSJGAat41FPMtrS03Synuw
	m8fjf0UBdzfKIJzTznSUoNsCHwkHf0Mv/5fe1Yy12wWmNxg9NTr6IgmtwvfyCx0W
	6eRt125eAFEHNa401r0mtUJ4UP+sFOUUMr8Kt8MUJb5LjEF8W4Tn00vUYwoYrlTQ
	N4Vy1VRn70ueO0al29JclkRETyLdqOZ4ZmrYVtvvp8GG9asaAoP39YOi1eRl0J+F
	tU3mfX2k/3CAQRrnio0lfgcGkx06hC+HUMp8zh9qg2QRwEjoDSutJ9VAlXiEJpxV
	2Grl+1onNOWbva3bX1MWoPwRZk3H4fQ6/ag==
X-ME-Sender: <xms:5GVhahj6Q2gBkB7FDS6LFCiSSBYQdhx-9bdMG01LiTFvQ8EvzDrY7Q>
    <xme:5GVhas7y7_BoNWcZOlocP7YZmrSTbwq8WNUzxcg-B_-D3Cf-ccqhBK-Owc1XBR1Xs
    JrtLXyb5I_QF6YfGdU-sKCJa99FlkwNA_lPraGWizRbmS-icS_OEA>
X-ME-Received: <xmr:5GVhapYISkdmg6aBjukPDmKpxr4RPU1AVyN6a1cDvb4HLxYqw2QbGTpKkktbnyRxlvJmDefBomaG1Ab8lA3ZU22iQXZxcBChgw>
X-ME-Proxy-Cause: dmFkZTFpZ44HvKDoZuDoXLGJCrKleEyBwQQdh1rwX+eyKBZUKQ9ibUUBgqf1z3rZm/Syj4
    Fz5sbre9BiNa1A0d98DCHIonDBDz/mzwNoQCdtSs1u+Csrc3SmrKaA1y895F+jc+nPGGPC
    sK0DtDK+fRpXbDhmCH7Lf+6qpg85yNIYWSEifx+1/tsGnrekymeS3R1zATjKYiOX3gYWN5
    +OpPMheB4mwcPJq8xuzDxX2sytKJ3IIWEZ+1imAw03HuL7RVFMhDJ4/wcBuJLpP3P/DeHj
    inR5W23H3bCH0VLgQ1btxj9qbtSqJpmAnqwkYcxUr6dqsppGT0QKOeDeZNqbI73JebWDT4
    ejky9JTR8Cy4MpbjvVSAiRf4d9a50A1kpXL/WB8MJ2cjfQvG9ozfi8pSXm7gvM0UBUBKN/
    8dq4snpyzQhowWf4oN/OvyMV1I/0HWAR7z5mtFckB4qNly/0XbmCYL7OYF9SMzkgun9/uw
    1hOGUn+zZau/qrQ+iX0zydEDQSACeH8CLiTFLgVXIXG/5XD+ntRG7+itCt6c19JsqSHxgz
    rThNf3U2XGrIBccIY5vfSmU0V0bTam/g0GJl8fwyiH+4JvqrCSg0bisVZHNXbloVQ7zbfK
    VfYZhGl/IIo1tB8e7HqCbxjRCfrbQPaVBBozfG8KLoV89ryf5XsOUmFTXW5w
X-ME-Proxy: <xmx:5GVhah6WJWKlg6Ue-WJHwPHMsdDhu2H2FUW_RAKv_lbp4Es9eQxd5g>
    <xmx:5GVhasCbnSsUmxO7sYvLkLkNG6XonZnx0RQFe57_sNrrPRLQFoOirw>
    <xmx:5GVhancqBkXgZBWif9sSmmGIcKas_Fv7XFUeL4WEqx0zq039LmfnUA>
    <xmx:5GVharJGtJv3Ep7wlCifmk5kDvfbsz50Ki9cRGClxiAqqPFglKy79A>
    <xmx:5GVhatKJ80Z_4FD5uPLpq7aIs4gQ-Pd2JdOpS2DC5JBlYvWwPvvVFejk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 20:52:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 0/2] remote: url-based pushRemote with renamed remotes
In-Reply-To: <pull.2358.v4.git.git.1784743738.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Wed, 22 Jul 2026 18:08:56
	+0000")
References: <pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
	<pull.2358.v4.git.git.1784743738.gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 17:52:50 -0700
Message-ID: <xmqqjyqmmsrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Fix git status not showing the push branch after remotes are renamed, when
> branch.<name>.pushRemote is a URL matching exactly one configured remote.
>
> Changes in v4:
>
>  * Match configured remotes by effective push URL, preferring pushurl over
>    url.
>  * Update the documentation and rationale to describe where the remote would
>    push.

My cursory review did not spot anything obviously wrong anymore.

As it somehow seems to be a slow week, I do not expect to see many
eyeballs from others helping to review the topics in flight as
quickly as we would have liked to move them forward, though.

Thanks.
