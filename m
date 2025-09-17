Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6833C76B
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117915; cv=none; b=C7xxWosHd03vYXPD16gH1fX3vYR3NQ4IC7ZCmK6rbz8MaN9QFDNEQ8T91fMMyuDkZAm0JOst6QzbuGCYqCLg0qq3X77KmbS7GbwaiHYA0am00LQiqGUL40ru6C+dAB0SzHIU79ERCvhWtcECloDP1MKuWzOXPUOMc4rkZbVvP3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117915; c=relaxed/simple;
	bh=pXBiTd3NFNr4mrkwOrHUw/i6q7Ww53UL4M50dxasDeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+rsoI3iv3hDSkb7ePzYTQjXIA9KyfU84D668UNnPoLENbexDAxKdcPDcSuVn4fXwojeIHuB2onv8WX/MxiHaO7RiWtCcMXK+OhzGPomEXvtJEMrBzNxIKLhmFi7DR3bs09h9ZNXV8pJzPER9ZR8L2oXFiAUL0EzHyohHHFsS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ATXTjmiT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+LQm8pX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ATXTjmiT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+LQm8pX"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 56699EC012A;
	Wed, 17 Sep 2025 10:05:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 17 Sep 2025 10:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758117912; x=1758204312; bh=xCyeTlKh5Q
	xTRYkEX3Lp1ZbwZPy6Iy/U6TA+/ALi6os=; b=ATXTjmiT9cHEyBqzTGVuu87P0J
	LME7V2B4jC3pEoILVHw8HnfDU2uHy0LBoz1Z637R7rN79axFLoWfyjZy5bGocVox
	T/uofs6TPHWv3+EB7pMup+F0EAt1pvBq3krG4wi1RFceyRXqLgOm1tyFKe24Uvfx
	BpymPDJWf7aA5qvgT5tejAB0uPt5dwHr9jk9jYGyKxic4BqYtJst01Fxpem0BQG3
	i697rJd4TBx1JaXMFtxBnvhloL8Jmujtak7uuvjoxl1o2fBvQRGS43WX2x4rcjYS
	ivQCbswmj+UtVohLfGZAblBrPQLbEo5H6HZtqvlAId6Xt+rlzabd/dgXb0yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758117912; x=1758204312; bh=xCyeTlKh5QxTRYkEX3Lp1ZbwZPy6Iy/U6TA
	+/ALi6os=; b=C+LQm8pX3njZQxEOpwhE/KcNj4Ht3x0JA3izT5h6A63PQxCLrtO
	Mlw7m17SDfNvfLjeQQRTK52mB3EiY0pdYU/RnF8FibFyjaMjuYCroBi3CEMH8c38
	6qeaU+EMXEI6NTOr/6slWy32equxBPP9vwgdJlfFBJfvGMqzJoX8myV5/O7n8rg4
	RsUHrMfskBpXc1XpoIns4P2Uj9g/mTbKpJFSDG15tt/GqfvtlahZvrNkVdlVlxSa
	joklislpqPqTo9/iUCB7ZRojhzDqAbRIoUzlFS000WnbczLog/6UrrDlYrtaum+e
	nz8boey9SlCLScqZ3AZzkMIJ78aB6tFsGGQ==
X-ME-Sender: <xms:GMDKaLJ_kd90GRAi_A7N3CUTXQSZ8Cv5RjhvzF4xedeSbL2qzwK4yA>
    <xme:GMDKaCZTQzKTNOxywGAeDYe0lEJ2Uk_4YBtG7QbhImxECMNwB5PBd-K59vS5iWpDC
    gAwUYITTPJTrJU0bQ>
X-ME-Received: <xmr:GMDKaNIOMWe2pGxwzS9LNyc4hHwgZ7ySk2XG3UeLYmPZBgXC1JxGtDS8BXjIS8jr8zE2bI_SAdfpvd5wHgHivU2kQHNGsx9YfqhsEhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfe
    ekveetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnvghilhgssehofihnmhgrihhlrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GMDKaAB3LTO8IF8cXZwGun41_91Piz5pquNCMs4i865DHiEKw98Z_Q>
    <xmx:GMDKaCos12GWtSPpTqQCAft_WEVXKnQ7gP_9zsVV0JBWEqpSvNK9SA>
    <xmx:GMDKaLiT1or8LuHFkGZDzbiBcNbmuw8YqdJ7CvzOaiXnWzYFbMG5Mw>
    <xmx:GMDKaPD14gasykpegeWRrqsOO2BMlw4ZuW9ctuKvb-t8-GF4-Qv0OQ>
    <xmx:GMDKaB-pfouc3NhxGB2Js5zT_bkNpM5n8s5LCcniyU0khQxJHYCdnniX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 10:05:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: NeilBrown <neilb@ownmail.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] send-email: don't duplicate Reply-to: in intro message
In-Reply-To: <175809074627.1696783.67425889158412786@noble.neil.brown.name>
	(NeilBrown's message of "Wed, 17 Sep 2025 16:32:26 +1000")
References: <175809074627.1696783.67425889158412786@noble.neil.brown.name>
Date: Wed, 17 Sep 2025 07:05:10 -0700
Message-ID: <xmqqfrcli38p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

NeilBrown <neilb@ownmail.net> writes:

> Add parsing to the loop in pre_process_file() to recognise a Reply-to
> header and to store the result in $reply_to.  This means that the
> intro message will not get a second header and also means that
> any changes made to the Reply-To header during editing will be
> incorporated in the $reply_to variable and so included in all the
> generated email messages.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  git-send-email.perl | 3 +++
>  1 file changed, 3 insertions(+)

Makes sense.

Just FYI for any future contributions, it is customary to mark the
second iteration as [PATCH v2] on the subject and to make the
message a direct reply (with "Reply-To") to the previous iteration,
to help people find how the patch evolved in the list archives like
https://lore.kernel.org/git/

Obviously no need to redo this patch only for that, but if you need
some other changes, sending v3 as a reply to the message I am
responding to would be a good thing to do.

Thanks.

>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 437f8ac46a85..e2248c223119 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1931,6 +1931,9 @@ sub pre_process_file {
>  					$in_reply_to = $1;
>  				}
>  			}
> +			elsif (/^Reply-To: (.*)/i) {
> +				$reply_to = $1;
> +			}
>  			elsif (/^References: (.*)/i) {
>  				if (!$initial_in_reply_to || $thread) {
>  					$references = $1;
