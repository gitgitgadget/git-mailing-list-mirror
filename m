Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0805FDDCD
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577570; cv=none; b=MTUUSrNXwBbh6d+jGVrfmoSkuVut1LFa1vLHSZAM/9EIaiM2hvftwYuWV+tWQOVc1wrjaQDeQ2qBF6zln70sS07/fvT4+RuFHZLTng2GZd7voqcFUBIt0MLDK0YIOeBH2L6o1SsSBgHX6BONKpsPV27DA/noB8C9aIk+Tp8yzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577570; c=relaxed/simple;
	bh=J65JjbMC0rMcXcYENOt7QLs/MKuh3WQNl8fJ/E4cZm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i/je+KiypfN0bduWe124J/+UFVw9b8hl4E9bdtSq9EiIH9B6HaL6a+iPeJYuppfjgmyfkdVRPDLYZhaiENYHloQCie+diigc+M+S3qUlYworJYDrfqcxgqpXKSpvhtu/MEB+fAHVX2NX1oPNbAUuMlDgbOgG9azfZSJmrmuIxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JKUZwtKR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wvx068p1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JKUZwtKR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wvx068p1"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3B6511401A8;
	Wed, 26 Feb 2025 08:46:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 26 Feb 2025 08:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740577566; x=1740663966; bh=ZVcgQgyuQ+
	4Ks2jcIl66aJ2URn1FOxW/PftF+0WzpTg=; b=JKUZwtKRGNQwWqo+/D7aFIFXe8
	hsDYshIDixDbeZdooN4t0oYrM/UL2jhObdISmFysAui4855+degxdINdXZhRiJwS
	VKZ8AvQe+/hJ/wWA2aZBj0c2cMeTqQS701VepZQZ3SIzIVJj3DQejaGro9idqw+P
	uIUz5NzgLxFrCDXokPCzNziYoGQjh+mb1RSfwqH+Zr78EOXJ2bV7+X9QfdWEQKwR
	UGjn/uKNnsAJXSIA8KJPBRYwf3EBUtExPeTcrftWG3Apk6TZWSJT3l1pRmuI6B/P
	RTHBfgNmkaCpVHPmN0j/eF9VRdJs1tvYfrW2LDK8NGH7dyo3+i+VV6UK0hOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740577566; x=1740663966; bh=ZVcgQgyuQ+4Ks2jcIl66aJ2URn1FOxW/Pft
	F+0WzpTg=; b=Wvx068p1hmzgG52YIyv5BM+ad5cauFiFVnG4OyBJNd5znMyPV9+
	dEccdhKzqoKkbmgwrB8c55fFv797j7FvpcV+LJmu67/d/XumW4arJOmSRvaxV7xP
	VGVhy8+yJp/3Q2OTRESTbaS1qYuaf+hFHOZG7i4Abazlzie/QMp7PY1sll5IvefP
	dmtaR93wW1GPyH4CG02w6suF3KItL0141USy22h8dBgDDtECm2Yd+jZwZvNFeprN
	MRufdJ/IYm8vfnf6EzvZdlTfx1cOjd2h7maWWdFZ0DwIffO1Cfj9Nyj/XshoLDM1
	jW4gmo6cw3X3ZqYBaxMpvPDS6f6cms6OawA==
X-ME-Sender: <xms:Hhu_Z_aXGRPO7PVg05kZvRg0qB5jsMa26T6eK26PSyHwhfx0Y3WsFA>
    <xme:Hhu_Z-bTKtPcJSCUdzdjxEk2smQJgZlAA-l0Zr6fQoR3gcAheFVSFfQYqawNH5Ait
    PuaUh5-2qfzwRJ9RA>
X-ME-Received: <xmr:Hhu_Zx81BSdy3P3Msf_ryBHOz8wLTPM6wj_658aDJKSfQC2_OPLnsMv6RyfKYAmybpA3kVsPgosnjZsF7JgYEqMw0oqIkZvlKwPl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Hhu_Z1rkaGojaNFc9i-hFsv6gw2VfV6ip6BCqc7HUnsjOBvVYi6wtg>
    <xmx:Hhu_Z6raDVcJcrlT1abYWB3ISgfy2SaVGuQApQNGkdO5NthMZdjGwA>
    <xmx:Hhu_Z7Ry-QSHcub0EFqHNGJAlZ0XGEcH_wiVNgplXQYA-xueRxH8hg>
    <xmx:Hhu_Zyog0YNX3Gd6X-it5hk4Gh_CcEzdPBLEMSBNpSIr84rWSMbKag>
    <xmx:Hhu_ZznK8vG1qwP1fBCKHlCSrgnI_BIZqw3NZyzwqyUJf0-MAWSOR9zD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 08:46:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 09/10] unpack_loose_rest(): simplify error handling
In-Reply-To: <20250225063351.GI1293961@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 25 Feb 2025 01:33:51 -0500")
References: <20250225062518.GA1293854@coredump.intra.peff.net>
	<20250225063351.GI1293961@coredump.intra.peff.net>
Date: Wed, 26 Feb 2025 05:46:04 -0800
Message-ID: <xmqqldtsg6oz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Inflating a loose object is considered successful only if we got
> Z_STREAM_END and there were no more bytes. We check both of those
> conditions and return success, but then have to check them a second time
> to decide which error message to produce.
>
> I.e., we do something like this:
>
>   if (!error_1 && !error_2)
>           ...return success...
>
>   if (error_1)
>           ...handle error1...
>   else if (error_2)
>           ...handle error2...
>   ...common error handling...
>
> This repetition was the source of a small bug fixed in an earlier commit
> (our Z_STREAM_END check was not the same in the two conditionals).
>
> Instead we can chain them all into a single if/else cascade, which
> avoids repeating ourselves:
>
>   if (error_1)
>           ...handle error1...
>   else if (error_2)
>           ...handle error2....
>   else
>           ...return success...
>   ...common error handling...
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  object-file.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Of course the resulting code is so much cleaner and more obvious.
Thanks for cleaning it up.


> diff --git a/object-file.c b/object-file.c
> index 8cf87caef5..b7928fb74e 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1436,15 +1436,15 @@ static void *unpack_loose_rest(git_zstream *stream,
>  			obj_read_lock();
>  		}
>  	}
> -	if (status == Z_STREAM_END && !stream->avail_in) {
> -		return buf;
> -	}
>  
>  	if (status != Z_STREAM_END)
>  		error(_("corrupt loose object '%s'"), oid_to_hex(oid));
>  	else if (stream->avail_in)
>  		error(_("garbage at end of loose object '%s'"),
>  		      oid_to_hex(oid));
> +	else
> +		return buf;
> +
>  	free(buf);
>  	return NULL;
>  }
