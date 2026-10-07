Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784838425A
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403730; cv=none; b=WHQXShXg0GeS6ts2F1nR7ODVtDWroYBSoay8oDzg/0x+pJm3S/o16UsIL27A4QkoziX70BUtASmoeh2iqzWW/r1Id9MBSfsD8jQNlXTZ87qifudvSqLefzVEQSxvymh/h3a5LoAJebTPmQiYjyCB1AkvJponXfe/AsYT7Zw7Yd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403730; c=relaxed/simple;
	bh=82t8zx4K/DTsSLb8bomI1BYWjuM/RSbLTEVjebh29GM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sh2yHP9fWyKK6MwkDk+SV5xEpDQghB/5q7tJZZT12IiKl8eGIw3e6xwp70xkwvPk4WAM1B2M6/HNE/fJnP01xwASDsoAuGKXYI/KMfMtjWv7uTy1RRE15R14+rfVErUpi3UrdHQqcnhF+7tOlALHFxmrnjnLz30hpF8j9+V27aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n0LdXdbi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iXelgihw; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n0LdXdbi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iXelgihw"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90BBA7A017D
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 16:08:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 07 Oct 2026 16:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791403728; x=1791490128; bh=8SzIdOTh7m
	YAFqlpP+1deskmK5JszqOCKz58Itk0rHo=; b=n0LdXdbiILjlyAuQ/LTPyXITKl
	5pGJV07OtKm5/63AA55F/6HbWTMv3xRtausvNeiO7sxH4Fue2IPrR3qaf3m0Y5V0
	Lqs/IXydSk/Hgjd6X0NGyLPMIF5DG7ezdCu4mUsf+onmP/V5ZrivnLfbD9hv0AoT
	rw7rWvgDWKEa5YU0J4z6ytMD84MiC6UwXf/AOzm4Bi0Bq1AyBQ8bJbCjChin3LgX
	9869L7Gxgq26IXJqJkAGSnFRLkklzv3rdy7HJA2uPlSiJmayS5iqcwdt84HswtM2
	ZiKesPCTviqXwpNATwotoQjwaLWx3QPwgjR/wSNeeyLDHehvwMI2zTGRF4xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791403728; x=1791490128; bh=8SzIdOTh7mYAFqlpP+1deskmK5JszqOCKz5
	8Itk0rHo=; b=iXelgihwz050OY7F1yofucEm+oWksv4D/7f7WokkYrmD0hfISJQ
	R1xXS6ZbMLX28oE3AeTqLTP7YrSfgvssXshLQCO0/LdHWbNJpulXcS3iTWq/fpMh
	tIzwdug5IYCALeyY8NRBK8yw/X7pvPD/rGPPipXjjvWrYDshemexUT5gNHSq8KvN
	o4z9zYPO7YjLvPxoRKTI9mO2GsDCzlYVw++KO1UZ1NawjInwgdtuPZnYlaHx06J0
	UrwmO3KVmnpVHyf2HT7TCSqA0lAX01xwADR0020c3sidPEyzKuIPoSyfpzP6roGi
	YIzj7sdM9HRrlcEEsPd1fcQO+ol/3ePPSKA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791403728; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Bzft+BE0NmsQVDon6F3WjTbxL3/DTMSshRfOJsFFTxuPoAh
	Yk3W1d7IYxKqtB/Dg3H34wHw3sOW5SsqIe9q8EeqAKE/xKQ1Zwdq+YXOoceQcqT/
	KOdVGHqKewAwOPSACe+yoqMsW/vH8uru6ziuY/t3xYUvPnsTJVRUCpX89/6eBnWX
	9eX6cCfXwRszIVi8smFRYQLS9otdJnS1+6ORmuFzYamVcXpjqA3d7Iv/XkU1DWza
	bDOp9AT4Dak66VX6gnyar2faSfSCBw/AVwRDazsCtCkLLcm6dZMt6b08CgTtwE8V
	d96BAi4u/mfrAuKpREazNqwmHjUroPXSn+5eEoQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:DZa6VJUDxROyeRpUbdbyTEGtvXKpj7DhlBC8goZIZIU=:82t8zx4K/DTsSLb8bomI1BYWjuM/RSbLTEVjebh29GM=;
X-ME-Sender: <xms:z6bGarK_dmgt0VsMN8QK5PbMvRIhtWUFD6KTARF3-c1qiqJib2kHgQ>
    <xme:z6bGai3MUjZyi9rsv23caIZUWX63gF8BxdNS-5sKWO08KLGyPgwr6NspvbW5Tcni6
    ghsuRZdexxUoOg3JpIEMI34Sr4lYiQFlozlp1ybk1oK8y0sEPBo-Q>
X-ME-Received: <xmr:z6bGati38AxjdHcAVNO0fRW6CHypgTsaMAHc8M_ARAoBA-YEWsVgxa1D_RBk8XO-pPBcqZ-qX72r-VY9a2nLS3RfAbu1PoqfNzPX>
X-ME-Proxy-Cause: dmFkZTGatMJCqV4PYHxtSfrOlPkQxc3ozoSWComjDVcOF1qxn5uVTyLM+N5mmbx/tEwlyb
    UGfh2yatMjmPka2tZK/mJWclsgCz41zuIsDKjVmVkRdE+w4R4p1S3rTfPDpeLHWoRsKQst
    NdnrIOpta/byCVFnA1jEMjzIQEGJxJA/SHxz4++O6UFDHZf5rW90SHV+sUcCeAaN1LvFN4
    rh2H+U3R8AehIE+7mB24YMpR69szmUx4D/idx9bTbfXXT33pEPUSknKKZsg1kKWfSxC42m
    DyonQ8M4PtGpr1fvLPdhHZsykqAUeLiyOxbEEDF2DMBJzt0Yf7i2hhD1Dbpl7P6X4GSgnm
    +RKluuPqdnGgAXn6qCqY86NiKK24Se1vJRFrCZeaJG23y/dn+82zF8Pv2Xh7qdWFPtqIYX
    +wz6P5ktbfwveV9mdlr+89iGkKOsoEQOR/IjqAN1jRhqb9Y4xB+83UXjWJCU7NMH50yZ8U
    69MJsVFvbJU8vtmblZpUCX63ZE2sbWA4avfQ4Up83/S10CllxFfAXAzzJdsKblNiUyUaWN
    Ze05lKhj/fDa/FcZQzDgqgY/FVDUX2h85Gm3WEIpwsZZMIYe5rUPL7Ckas/cNSVJkpdu7o
    gpXlV3jS8c9lrFE4BvPa7nN4wKN5/u8JyFI5W35vgLKf2niGQ1u8/EhaVTNg
X-ME-Proxy: <xmx:z6bGarXGt3apMYdx0CftxfdAoQF0EKiv4T0zvnwXFCWqjqCL16YZNQ>
    <xmx:z6bGakUIGDQAYyzSMNoCoZcJ3XzoVmACmnDxwymm4XzkQAEeW_MVsg>
    <xmx:z6bGajiidcotzMlp8ZPDJgQ5wHB3MhYTwTFTK_ZmAG8UROrk59WCfg>
    <xmx:z6bGanbYfA3ZIK626EO2zx5UftDpNnvf7TRDhae78mFizz84WfzDdQ>
    <xmx:0KbGaqvUv1aluvfBI348rbubeQgtu6mJv_061WfDMrjhIUsuwxg7oHvX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 16:08:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] doc: use `man git` to teach users how to navigate
 the docs
In-Reply-To: <3a665230-b221-410b-9a58-96c01210aea0@app.fastmail.com> (Julia
	Evans's message of "Wed, 07 Oct 2026 15:29:51 -0400")
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
	<pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
	<xmqqfqyh728j.fsf@gitster.g>
	<3a665230-b221-410b-9a58-96c01210aea0@app.fastmail.com>
Date: Wed, 07 Oct 2026 13:08:46 -0700
Message-ID: <xmqq4iex6zox.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> - Removed 'cli' because (from my perspective as a user) it seems like
>   something that's written for Git developers and not users, like
>   with "Commands that support the enhanced option parser",
>   how is a user supposed to know which commands support
>   the enhanced parser? I think it makes sense as a guide to
>   scripting Git but not for interactive use. Some of the bits on `diff`
>   feel like they might belong in the `git diff` man page, not sure.

Perhaps updating cli so that it does not give a false smell of
getting written for a wrong audiences is a more productive
direction, though?  I do not think there is any other document that
tells users the simple "options first and then revs and then paths"
rule, for example.

> - Removed "user-manual" because it's outdated. The chapter on
>   "Sharing development with others" explains how to use
>   `git format-patch` which is not how most people collaborate with
>   git.

Yes, the was written in a very early days, and by a person who
worked in the Linux kernel circle.  I do not know about "not how
most people" part, but I would agree that "many users do not use"
would be a fair description of the modern world order.

> - Once all the others were removed it seemed a bit out of place
>   to mention `gitdatamodel`.

Not limited to the issue of where `gitdatamodel` should fit, I think
we probably should explain the goal of these change at a bit higher
level.  The original intention to refer to these things very early
in the documentation was to direct those readers who are not ready
to go into the list of git subcommands to those "introductory" text
and concepts guides, and encourage them to come back once they are
equipped with basic concepts and workflows.  I do not know if that
design actually helped or was harmful for the real-world learners,
but if we are shuffling the material we present early by removing
some and introducing others, we should explain what our overall
design of the presentation order is, for example.

Thanks.
