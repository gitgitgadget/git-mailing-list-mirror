Return-Path: <git+bounces-2-git=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4B2CDB47E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 20:31:32 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B52C1C21101
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B03D96E;
	Thu, 12 Oct 2023 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NSaIUtk4"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4303D96D
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 20:31:28 +0000 (UTC)
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176E9BE
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 13:31:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 978251C042D;
	Thu, 12 Oct 2023 16:31:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UbWZ7mMhbtlT
	df6cAI6w1uy2GKDkMDwzHqVnZF4YlmM=; b=NSaIUtk4PGB+1/8Dfdfhu1F1f6nz
	CSUMu4MZEeRbhXtkIHt0TslBOXWdowSp1+LaqtR4DjUq0pylgVH4XnQf5hJW7isx
	jscjl0k9SaDhP6yNdiqFX8y0BaTl1t7tv02Cc0e0bkLiHL/yam0KKR0OyUjn5JXq
	jkDe5aK/Xjd3nDI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 846DE1C042C;
	Thu, 12 Oct 2023 16:31:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0AD421C042B;
	Thu, 12 Oct 2023 16:31:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Ben Dooks" <ben.dooks@codethink.co.uk>,  git@vger.kernel.org
Subject: Re: [PATCH] send-email: add --compose-cover option
In-Reply-To: <277a80c5-40c9-4f1e-a68f-96673380012b@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 12 Oct 2023 22:03:23 +0200")
References: <20231012112743.2756259-1-ben.dooks@codethink.co.uk>
	<277a80c5-40c9-4f1e-a68f-96673380012b@app.fastmail.com>
Date: Thu, 12 Oct 2023 13:31:22 -0700
Message-ID: <xmqqlec7mvl1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4FAC777C-693E-11EE-A747-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> 2. This would be really useful in `format-patch`. One could write the
>    cover letter immediately instead of either (1) editing the generated
>    one (placeholders) or (2) providing a file.
>    - Personally I don't use `send-email` immediately=E2=80=94I use `for=
mat-patch`
>      to generate everything so that I can review it before any
>      sending. But there are many different workflows.

Hmph, I am not sure why a format-patch user would bother with the
"--compose-cover" option for the cover letter, to be honest.  I am a
format-patch user and never drive it from send-email, just like the
workflow you use, and the norm to me is to review everything, not
just the cover letter but also the patches, in my editor session.
You apparently do not need "--edit-patches" option to review and
adjust as needed before sending, even though that is what you do
already.  Why do you need a "--compose-cover" option?


