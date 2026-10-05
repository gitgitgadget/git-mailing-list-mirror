Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD343802B
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205652; cv=none; b=QxeHJjeE+9Mhkpd6TlA37Qlmhfb2DLAynt8n7q57vgF2d+lyX1aSuKAtv2cw/Dr1yTAYOXzg/prrUvhINGx0PMRdwycnp6Tj89T1mTS41MtorPXa9QZhCA8ZXQYgcWACUwM8AIvQdzbgW50YUGY4WdSuapQF998IhRk316TUUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205652; c=relaxed/simple;
	bh=fcfzXt07ZrlykIMUZGny7PJWajdic4HIeU1UTzfrbWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bZpEMy8RtNYmEwK+nb1/XYcGJ/NHu306JYODh9mRwjWhHLiunmbjprM6w8BlXBRYXqL1dmZ5SEhyzGvWVT9BKFbq/WhI0ovmZ7CEE8u2SsEMaU2RKfi1hyMFqx8WUtSo00kjV0MLyzFIPNdZ3p41KJug5URNqJUr/S+AoYVr+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cdT8Z1nQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UT/0Wt/J; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cdT8Z1nQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UT/0Wt/J"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 876CDEC08CF
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 09:07:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 05 Oct 2026 09:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791205649; x=1791292049; bh=Pvj8qgZywM
	ISxRE2kOuSJ47RUF5t7CtiMhJIrKAq8Xc=; b=cdT8Z1nQY5YyzlYFS4zNt9g36k
	pfGvYBkct+/SD8SCz6ZlOwc1OtpuGT3T0tU5Ik74vnA2okyPAMXImgTYjuH4KAPa
	EwPJ5Q/mHoSiJphEZRxWrPii2kF1ChufnIhTAHRSl+xqH/fzuyFf53gbCW0s4pSm
	7WJZFX7y2so+/vGLM3FHGWcvj6+Bhqo4cFTX2FolKfWzeCL7lFxqdozgUNXHdiQi
	wWlOeWBcmSJfDYh86vvvL6qJPWvQ8LKDMGQsC4tkYRi3PEUnvFfnMXtdrEp+o6QL
	jvh1LBZXXSis15eRw3gKpTYWqG4gQH9VI5Zc8iy4eA6HJAxWIPqwj9Dyglrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791205649; x=1791292049; bh=Pvj8qgZywMISxRE2kOuSJ47RUF5t7CtiMhJ
	IrKAq8Xc=; b=UT/0Wt/J+qlu1RD7Wp7CJC3+3P3X0g6/a88ezwoZXeOxkdZpVHx
	tpVuXnN5AAOC7yLOUzXbeGrKAKdZxpCBEQ8QvVsN1Y6M+pcgCAYH3K+pEFHhzC7c
	HO1LjAMT4PSeyhbKEn18zOL6ttqF2nmXJe01o3RtmeVyPyknFGvApENZkzibEWPw
	RJA430HpJXHlP0ssemf3LZBxmEHcPiX2yVSPvmrG8cWdP6WT1eobk+ljS4PJ8tLe
	FzGqFwhdm7lFb/sUVHBFspW7atgLoC1j0TejF8mUYnrcs6z17DQfsPyEqnAPVdtt
	sL3uRuj0ANDVG92O49rmGWfv4YnMIQzkKgw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791205649; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:XZI7MY2TEdyOo46ICe54eAw/oi8KuGdttYdwPs61bGsnsaL
	CXliOk1VymzgxNzVbvdmgdp144rEgzx+XClhJygoFxGoDFCuMtzixo7r92llLB3k
	CMTTz5uknsDu5l+03u1tsHXXDWJA4Y9ngJZUhnF/1LwSILvXUMll8NOtPBvK1iz5
	EPI2sMULKxp6WdZ97LklHgR8gGXi5zPRTbwdEkhLPXtEun3e1hgljHCw/N+UOc5y
	6SgK/6cpT9NyDZTTZhwAmYIOKrOB4sjCCCE1wixA0kgcQtGEKy4zJoU4tG4tboJ6
	6Y8MvG9JbnjR8xa0ZOIwA9WzeBFpu/nQE6Gzv8g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Cg3bEcpi59um8HzX2mP8XJkx2QsHpJj2fQqmpvdyJDw=:fcfzXt07ZrlykIMUZGny7PJWajdic4HIeU1UTzfrbWM=;
X-ME-Sender: <xms:EaHDaistoh9OPV2A4_H20eLgqpKyvjvlaCYgC5dordRcNuL5cJucJQ>
    <xme:EaHDaueddH0IcAxt5L9y-keqB7_GyZgKp_cyCT2nd6Kou_LLxWIGLeDhgEfNpgcze
    5BH2TtK0dgjl4M36JCxOL6XgEWPiKYLjZ1BUDJBoq8Q2H5d0oQNCVqa>
X-ME-Received: <xmr:EaHDaizTYoH5N-ZyF1lZgT5JgRnPHjPpKfSzcvie5GzoVoxNLR2mCNEWpBU5B6671Y4uC0r8UvtYHtsl6K85b2LU6Xmbjo_HXRVq>
X-ME-Proxy-Cause: dmFkZTFigF8eVFkZbmDfo27SxM0z4eBCxdGhdNeJM3N3CAsdX5dEFNGowaYeUnsD6wNGc4
    x6Akqw1rayUHVo2tAZvX2SZvJ3k1YacX/tPKcuHqJtfvwZ057nd0Td0gX/pkAi+LPX4qI1
    bwTJn0JTVNduFOtpUdG/q/XHd91aHY9gDOCCM/mXhg6sPHyfNzTGmEs8XgI7k+tAznVtoi
    7tqpkXv25dvrbaeUeJY7oR07INo1JcuqiYAl0CWzssUqDJuoKQRQrfIlbn7cBFauiaq12i
    NOQPn1eh+rl9cbFncp/8juiQ81l/2BvTtgifOabfbor8xVg/VKPxTJMPZsHR89PQpI/LSN
    +pv8awWJwN0RFewvIqQ2dnn8WV+IZ5lC6IYjHnYTWA6Ng6jnsnE9/ZjC80+SGrdhRwvJx5
    PIeHfSouf1qQ2wkSVdcsLH9nGOTRZo6c0uo4XWCAxv8yQudaNIalu5XrrH0eOnBiMCO19R
    JRg4sQemzAhqhdzftqIiZvU/IGrXNPeljhb0LIzyjRozCYLgQoYzSmLC/IJGU/m7gxbrXe
    GI+86pNyT/nUGhZBhnFSdj2mNdLEkuR1zyEic83v8Wu/JHzhzXqq/4WIfMD8LPOyyhDFkw
    EPLWM6VoyhKn0iuLnqYcvqEeFM9syQlWmR+up7BrQj2irVrER6FFSl1RMGVQ
X-ME-Proxy: <xmx:EaHDasF_fY6BpgAqEfiKK4UssVOHSemsv2fncV2ukUBhej9UzIYKyw>
    <xmx:EaHDauwAZD1YNqaljBb7xwjypHOFQBNro0j_v5_Gs92SOd8GEGyoFA>
    <xmx:EaHDalu6jszjowDh6P_ecxxIEF8D-2o2mKakClzVr1XKU0cilMDyyg>
    <xmx:EaHDaj0uApInwWwsGAj8w7-R_XUHDIGlywYG0hL5mOstigtRKN9E_Q>
    <xmx:EaHDagjxCwKN2asRN3RAFFcIP0Zzh1_fS1ln3b-UW8yoxpK5VV_rbB9m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 09:07:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Hinton <colinlewishinton@gmail.com>
Cc: git@vger.kernel.org,  m@lfurio.us
Subject: Re: [PATCH v5] fetch.c: defer fetch.followRemoteHEAD validation
In-Reply-To: <20261004201428.5210-1-colinlewishinton@gmail.com> (Colin
	Hinton's message of "Sun, 4 Oct 2026 13:14:27 -0700")
References: <20261003231422.6004-1-colinlewishinton@gmail.com>
	<20261004201428.5210-1-colinlewishinton@gmail.com>
Date: Mon, 05 Oct 2026 06:07:27 -0700
Message-ID: <xmqqqzi4nvn4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Hinton <colinlewishinton@gmail.com> writes:

I see there are only two minor things remaining in this iteration.

> fetch. Leave NEEDSWORK comments at both the now unresolved call site
> in do_fetch() and at the actual defect in handle_config(), so the
> remaining scope is easy to find for a follow-up patch.

Here is one of the two.  There is only one NEEDSWORK, not "at both".

	Leave a NEEDSWORK comment at remote.c:handle_config() that
	has a defect similar to what is fixed by this patch, so ...

should be sufficient.

Another is that 

        int cmd_fetch(int argc,
                      const char **argv,
                      const char *prefix,
                      struct repository *repo UNUSED)
        {
                struct fetch_config config = {
                        .display_format = DISPLAY_FORMAT_FULL,
                        .follow_remote_head_raw = NULL,
                        .follow_remote_head_seen = 0,
                        .prune = -1,
                        .prune_tags = -1,
                        .show_forced_updates = 1,
                        .recurse_submodules = RECURSE_SUBMODULES_DEFAULT,
                        .parallel = 1,
                        .submodule_fetch_jobs = -1,
                };

will hold onto a copy of config.follow_remote_head_seen that was
read from the configuration and never frees it, so when cmd_fetch()
leaves, it technically leaks a string.

Other than these two points, this round looks very good.

Thanks.
