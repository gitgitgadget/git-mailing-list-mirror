Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3542F39C2
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790952453; cv=none; b=BivMd9T5FtwpwbtVAVX76ORhXgAwNV5Kfq5Y4oPxnF8kyoVGSVt3HFX1dZtSn6P5T9+Eszc3PouUE9czZiYKPNi2K8XZof3fgjiz9G85Q/I0E2wqIl3eg9JU2dIHSItDPYAHQC7qBIsL0pwBMa12r+K++DHIGJdRQevUjiCm/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790952453; c=relaxed/simple;
	bh=bGGMnUil7zlSmNEhN9c7DobMHJcgS8pngCen09PkZPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hhMDtqRazzGOw58b9MadekSkXOaHLJtNACpMPSS3/AHN8WwyLhSCSZ4K5xpsS61+ippfHIAQmH0KEeWfRaWYrP6amT4EMqV5V5m08pRsKxvAihwVzlbuTinzjl5cjCGElNhV7/2U6pRN3nHM/yMN02XXawPYo5XDMLAtLUHZ3WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UtZ6fuJI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V+rFmIDv; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UtZ6fuJI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V+rFmIDv"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DD1B61D0007C
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:47:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 02 Oct 2026 10:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790952443; x=1791038843; bh=QcnfzbnXYh
	RIm+wPphS87FosUCT+aGwmMbB8EtzhQJA=; b=UtZ6fuJIL8tFFcbkKRsiS2ScrV
	kNxvHkBwV0OdC2PgZDxufj6SbDNEdYhlwquce0CUi//ZhxaO9bOiYUPnt1xGNz8Q
	pZb/nhQyRMi1PkKqM/nmRv7n8qbcaAm6E8zfZf7iY2661+JE9ygkUPfzaXzhIbFw
	Y0TutKsaYHbpAstUbFd9fV4AGoATtDo8By57H+rknJg8PfSYm7p3rsvC1OwQcelt
	VEPkjt6mz9Q+/4qLN+tgGtU0Fxmuo7cY5WaGpjEXRsYveD48IbAgBGx4OZN/Ef+j
	jJt0xkfr0dGndPRyYrWTxFEqn4MVHaEDn0C9PKsGhDi3av8idGFQn4hjlsfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790952443; x=1791038843; bh=QcnfzbnXYhRIm+wPphS87FosUCT+aGwmMbB
	8EtzhQJA=; b=V+rFmIDvqYiD+W/VXak/eKvJd5jjLUaZKp+6n5eS8ghJzei6idw
	K+rHTCqoUK4aJpwYfOJVji0p8KOkMRqlwU3VVJCD/72IsXESAPJ9KMsrt6QwBvxN
	32rk/CQk4mUjnxPwffKA09/KOYGxsSaOo+jtm4vq8PjJTgplluWcmET8oCDFNTxP
	xrcgjhJ7bkwjwvxBR2yO2r9YVsh7NV0mTzBq+k6iYaQ9myYFy4lghvj0q00ohehQ
	ZJDFPkysGzo5e3coSlo5qywRIAI5DpMHP3LC8VH/32rC3YS3dooPI1HJSA2LpsUI
	qfCRfZ0gMEzYIPVjyLCPJ80Juj+4MWQvTMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790952443; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:mFCovdszb+crKvj+YuA1F65Oatu/k+cX9QtVvdRNCGmoIDg
	T39zPFKUiGUb3RaJCLsGiqQrZX4l43u6MlEz3rcCY2HP/QVbEjI31MMByBsqnbRQ
	4avZKzpvvgAcCwcarZw/fO/EvBxLuvcg8w7/TVPqP3wUoYkGXUQQ10P5pJm5kWLQ
	VgVg3QWjb0A9SZlJ1fmvXZGygyFoRRe9hj1HI4PAn9wZybcm1y/8ApfeRe6hkV+D
	S8H6/xe+0pjq/39PvMmAaK+SnNLEG8h8rCJ5Dr9jBunFZFQr3yl3pxHB06qN9DsP
	+45L95+9UJFyTzKVH8Hj7/U+NiVPXmNo1Ym4l2g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gwZ2eC92T6lXdnsAz+2LLQmp3gnLUA7oql36u8517H4=:bGGMnUil7zlSmNEhN9c7DobMHJcgS8pngCen09PkZPc=;
X-ME-Sender: <xms:-8O_atjCtYiu8kaiOS1vPKoAorc6iD90tA0QJwcj9fVx2HlBpTxxhw>
    <xme:-8O_altHA2npFYjNuWzl38HgZj58ckn-m5ybWMmKQvQHyigIAd0cGJr72AGytogPj
    Ka9d4DhNTW4s25T-zIUP7cJmVxF7BKO66b4UUDidNsgiCVDa9HbF7I>
X-ME-Received: <xmr:-8O_am5-KKP-YKh34nJNabqdeYl4wPmqzojYu8m2tz6gG_By-BXZqfWCm0wYwP09RlXYjb8bgOzpIt4bNCUwlY5vwYBzsF3M-Ejo>
X-ME-Proxy-Cause: dmFkZTGZfS7iDcj4DNCvH15tNgmtr7Qy4Qn8H72yQRzfLXIsDqEeBBjfhocgL32F/LrRfP
    ayn1tDzGlvoGiOyDOC22omadmZ5v/8TwzB5QyX3df+1CrCJLuJSlgz+bREgEXWiMX7Es3B
    2w+MtdkooHQMIQAqihmN51NlfYCOJzF3dKqXACUDAVMQCJ+sGI7iY+kC8YxH+HbFFaSTi5
    Tx1C7cyR/uiiIdi3W15SwMUUly5xC+I6CeMBuX9IQ66M1c2gpk1YOCBq111b99n3znKG4B
    A2IcadM/bxaPito5JpRcrPkWUyyMExzx0VYCiNmxcgbvu5QVBKY2c2cl2FnA/V7mXrNYFK
    LMx7K7MJSbm8B0isosYcQVduLAPTuwZtwIiohKUT5SzBeHL7x20qMK8/Sb+fm+9UnMxESa
    eC+vVOwj+sfBvprOHdjS0Vw+wb6v0MUujAlUYHyQHvEbg0q6BwYKL26q3UCVRcVKpx3UQh
    oapDkMU8sD4KexdhCxrLSL8ZvkUGCuyhbaNivxWla0vwjNX/GMEuCxTjo6Yz+Zs5drWvrX
    9Qs0ouG2SNsDCzDhnfFy1bD0HSsFVYDN7jT9jD4skWTbp55WODBVIr+306MwV5Hjz/eH7u
    nfBTaf1hQiiUxwE/fM3XtQb6P0fj467HbkSZ8jAX2WSlClDZyvme1WA/Jz6A
X-ME-Proxy: <xmx:-8O_apMYKq--Xw_Xej41I5iQ66Ef0_U2yIfAcqS-7MjXoN3pyDQ3Vw>
    <xmx:-8O_astX-u4v7-LErpw8zVESo9SdX-S6pnJMfc_3x72TA2Uy5S82lw>
    <xmx:-8O_akbiyzPQz3JZsf1BcjgXR_pgksip4Buv05T5av8dpVwbuJBMXw>
    <xmx:-8O_amyyqpWY6Q8eE_pQfW2mlpui7lGeCwCMc9BJawxt9Y8k8AK7qA>
    <xmx:-8O_alS-bDDRa1G9UtWlSWS_CkR-LKXwC43FN-9iWgKtGSPvy27VGSZw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 10:47:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Jeff King
 <peff@peff.net>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] object-name: accept @{p} as short for @{push}
In-Reply-To: <pull.2431.v2.git.git.1790927399813.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 02 Oct 2026
	07:49:59 +0000")
References: <pull.2431.git.git.1790797186658.gitgitgadget@gmail.com>
	<pull.2431.v2.git.git.1790927399813.gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 07:47:22 -0700
Message-ID: <xmqqse2o17np.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> "git log @{p}" fails with "unknown revision", even though "@{u}"
> works for "@{upstream}".
>
> The "@{upstream}" notation came with its "@{u}" short form from the
> very beginning in 28fb84382b (Introduce <branch>@{upstream} notation,
> 2009-09-10). When "@{push}" was added in adfe5d0434 (sha1_name:
> implement @{push} shorthand, 2015-05-21), "@{p}" was held back to
> avoid confusion with a proposed "@{publish}" and talk of an "@{pull}".
> Neither of those was ever added.
>
> Add the missing "@{p}" for symmetry with "@{u}".
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---

Very well written.  Thanks.  Let me mark it for 'next'.
