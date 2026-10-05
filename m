Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061936B931
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232648; cv=none; b=UU1r8+WZfH64f1xwXKhH8428ms9pruCjLd+XiU6lbJJCqomLbPDH0ldxql0W/cQ4f2HIq5S3xOihlc7onRS56EiGHyNKyRc2lB9V1YInV17YzYqY2KOmUYfFMvpM8LkgVYsC3HSNpTDEelL3KnQ/DBP4Zs+0lz6Adb8jqmSgwO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232648; c=relaxed/simple;
	bh=AUaP4rzsKKB/AvfY3qPyNYFrk/pbYq142cB1uRmg5sM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C7fne+3XC6k8vCXO4Ej4jQqK2I4YQoQDix2ZSuyEIuj/K+oW1MR16cJT7pptA+EkIgjUj53FkHemlMsdOOjdGB9FTzeKt09akRh7o1+mZRkfFai/JS0HPZp35O1IF/B15Nr2g58xXPJ2gVXYPMo9gV/X/829SW2aKhhMRN9eTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VWZYQlja; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q96ofDDX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VWZYQlja";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q96ofDDX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A5CB67A00EE
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:37:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 05 Oct 2026 16:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791232645; x=1791319045; bh=Ouzz04Qtwt
	wF05VFI9nlZWdVRCm1T/T8FtBpzjyTTYc=; b=VWZYQljajo68xgH184IZ9o1Wqd
	As0aeIfzoVrjoNgimyQcNtw8JAyXzOXkE6ji2Jua5lhnulIO2qTvc05X5G006ryz
	PTGjTpw6LRGJ5/NbCh1wmjKCF/BFLRhU76n8oA4vQMfT6F9eYD6w9nmsOldAj2Jk
	jn4h0Y5piv4zfLdWwnyQ+a2lRdyTM8NNXssv4mHwH75z2t6cVkeAXGXd/K4hNK8Y
	QSK3PcApBta0jSeM9VsDEMw7N6GDQVmwZHrqADYfPP7RKK+Tt7jsJxhmoN+P+f7w
	oVRYa5Bkl4nSfjEVjK+HbC+NJ4zgaC3CU/qbAbkHR70V+HwXTKRLHm2fsvYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791232645; x=1791319045; bh=Ouzz04QtwtwF05VFI9nlZWdVRCm1T/T8FtB
	pzjyTTYc=; b=q96ofDDX6Yee9GH5CfPw+qjXZTVFYu03NiwsABT5Bc33Rar6V/7
	U3YKDXCjF18fC/zdA+qqqIbC+T6Or9PuebvLz8JuTi6ur4x33d/KCva/UpQzuzFf
	ZVoSdt+1xA3XnS0CZzXUc/Gf64Y+KLxWlJu0s2bvmfVHk8FOWhsQgZc9iraWo/g7
	BmfBLJLeKyt6Vofl/gIzg7yJHXM9B+jVBbR0BzoIeIRPDH7YAJf8XMO4negJ6GXA
	+/vZcG/sKEWwGoGSxBOj5g7CXIk7bCs4cqfENV2P5PG+St8VWq9Yjp5npqXIXM9h
	wmx0UVhKVfN1p+a/H5SOLi4p9/Ewi8gegJw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791232645; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LozA0oqSnC6vvRpWwHu6DyuWkG+PAutwOrtPRbLb1JZXulz
	krzNfrWs4NSU6OA2Cy3vzDyoSGIcwVOIes0iLM+EpmxROfAA3vEOAI8IkXw5RbFp
	V78Z/+p+teci5ORHvhfUiyQ7qqt35H5dx5Ql5tZCv6Czd8SqSXs+XAzCyhMuqslU
	EqOhC+fcBVZJ/jXvMVs/ST6vmD0TieIHbjhwChPt9g8sG+YwAwwFrKR2RfeuGDmw
	B8L9+EUrYyg3krAEJ32q/5W9QiOpFQzqCZuTw8dWFWmMuSyBcKdijbtv/MZ81/De
	tqu32wBwWIms8XZinRz/2oaysN4kWb09vO3FTZw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:y+rydi2NK7HB6Q/WxgOdfp2c/wx8JusT8sxFfmTEZLE=:AUaP4rzsKKB/AvfY3qPyNYFrk/pbYq142cB1uRmg5sM=;
X-ME-Sender: <xms:hArEaiQW0IYpbnUU0sBuWRlda1W92WyKUlLZbjGkjnfdKpERRZciAQ>
    <xme:hArEagMgcUQOQJeJvEbXWNxVohyNb-ZEJl1ggmBhS7ud6kA3niXP5-AmvCMMZumco
    6OdqLMWjvoH6hpAqq1CUOw8YjrCMz8DSM50fGSrELubMLCZzXpollQ>
X-ME-Received: <xmr:hArEagTDnsdNkYKR7p-61nTdgerdowRP0a4GoHTuXe4DC_yNr6PotxLq2xNpNEHXz6WmqaBGmGj0wtPm2MMTFJMyg6vsTyIdENiH>
X-ME-Proxy-Cause: dmFkZTEsQdg47aRk2ovpcuJ4PyxQghy0jN2vx2sE4/HZleWbnnvNmTF/LVeQyXZcb7NrrZ
    r4Bo8b8CkD4BZCM1jd8CG7yfYzsuavMsLHjn5jeaY4SQtYwl5u+6JJsQKIZMGmthymd6nI
    ol/4F/z59jT/7ppLnQYy/5vvXvi3ZCWhkyA9YYknbZhjTuwx3rpfxuQWZmjUX72uhEalxa
    GnG1OfBkMIcCeMO/iOLMNWtnVgc3J5lfepBpFd7M6YpIkUWu5T/UI5fT/se8T0vSl9+y9g
    4UuAmXRN8VUMmFKGn8iSePAS3aVVLnFFb7HAznr0e2fQ6r5GS55eiiNLrhFzHx3aJRj7XY
    0QX3XdhcvLMGAplAt23R/EzaLFimG/siFbVMJ5j9NuHTKxE52yCWWH9p4MHLM62RnsVl+3
    I94w24nk2xo3tFkqlMsiHD8/sbrh+ws9YiiMbvm4U2i5p+PZ15VBUbx7ZLuxXb+r6uNRrY
    NqFA0WzqPpOUJFAXMD2zQVcNVUqQ4Ls4SD/DrBxltni3ibAeoTUra5kAQhbPS7WeTEb0At
    Pf+McjmoVXGUicqW0RWHf6KWaywIz7Oo1+k0HmDL8y4a3or9H70ZhsVAc2Dr4moj9ZRHaq
    +VCffjiMIyugI2cB/T5ZvTTwXCLWzDwlPrB01LJioUBKiwI3dsQ4K8cZW4IQ
X-ME-Proxy: <xmx:hQrEauhv9Ef9Red3FBRtNuJrE33jDbcH5cunIF4U6lKmShVPF4IDzA>
    <xmx:hQrEap80rihu-DEEIYm_63GDkYvxSCjoOBTrZQajyyDCbKwQ35opIw>
    <xmx:hQrEalG4D0hZ9MksUfapOSnx6v8ZIjSOB_qFW0uNYRoj8AuN9b0hAA>
    <xmx:hQrEaslExPW0M5mEdMs8qjYvN8-CTUzCl760BBbQhXeY3ijBExSv3g>
    <xmx:hQrEasbc85rELT7ueu5SSzOOebHEfh-dcCDdi2p_FQAf0ac9BmMgTNT->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 16:37:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Tuomas Ahola <taahol@utu.fi>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
In-Reply-To: <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Mon, 05 Oct 2026 20:20:08 +0000")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
Date: Mon, 05 Oct 2026 13:37:22 -0700
Message-ID: <xmqqa4orkhod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series removes gittutorial-2 and all references to it, leaving a
> stub behind to help out any users who might be looking for this
> documentation.
>
> The goal is to remove obsolete documentation and make it easier to improve
> our tutorial material in the future.
>
> I tested that the docs are staying internally consistent by running git grep
> tutorial-2 and making sure that the only remaining references are in the
> Makefiles, the document itself, and some example output in user-manual.adoc
> which isn't relevant to the actual manual.
>
> Changes in v2:
>
>  * Remove changes to .po files (thanks to Junio)
>  * Reword commit messages to doc: ... (thanks to Tuomas)
>
> To deal with the conflict with 4ce144a1 (which requires that all guides be
> listed in command-list.txt) I think we need to add another exception to
> lint-manpages.sh (like Tuomas said).
>
> Julia Evans (2):
>   doc: remove gittutorial-2
>   doc: remove references to gittutorial-2

The titles of this round looks much better ;-).

Will replace.  Let me mark the topic for 'next'.

Thanks.
