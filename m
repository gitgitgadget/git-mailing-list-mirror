Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E232AAA8
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938015; cv=none; b=G1A6mNqF0kFqf2fYYI+NHYQFOvMzVj1jMbpiOZZBHOo8b/lqTjCG/MyyjI6Y5uGCrCWKUZHqtISzp85IQNafCsiC49IEYiTITZ2TU7xZWyeTV2P4L8E9EBoMJi6pt/mum6Wfyx7G9QY2Ta7jwXzqDMrkSdbJr55Fstpp9SmD5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938015; c=relaxed/simple;
	bh=5MCvsh2byYETUSSl7WXZ/HhRxV0vuTvrOavKOXtczBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hgWY87bMiZMNzwhD/5xTGu0B8ognBwrw5OjpUCbquD/rnc7yKqCLFKM9C7yGEQMKGwVDYp7DU6hEdAeLLWPu6EDJfI1Z3Hxodt7EppqExyAE5jTKEEhYXhhrJlrh4BUA11SZYgRsNFvmIZPTAaUdyK0Kq9rmWz/6a0Tt9SEShcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KDu1HBw3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FinjOyCF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KDu1HBw3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FinjOyCF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2EB61400108;
	Mon,  8 Jun 2026 13:00:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 08 Jun 2026 13:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780938012; x=1781024412; bh=zZJiH85oA0
	FZC1O1T0PX+QDCdtX44rb6B9KHqAyMsCw=; b=KDu1HBw3dLaaAhPP5k39bAdPVk
	z8bamYvk5GlWRQFq7YHVKakz7/wwdDArwMckWfGKh4RltiuPTnb82zqvMS6VuDYu
	XAzvbR3ezS2xAoXyJUvXNPuntMdf4/8lQdN9gUc2tg3rWFKhd4d9P+nvDp2eeKeZ
	0xYRzc28hmlsBY50Ylcm2bKDfxgRmn1xT50aBwVsfJ47qK6wJiBLYMj/MPZiq0MC
	xVyibjpEKbpuA4Vl7pDzkxmViI/30qRtM0whvPF9477JCtEfxhrXtdGVnxRpM8zI
	Z0IC3d12H95zhvDnha9x2OpGASCIxecle+XmzTIQ9qv6yvx4CCIEELA+137A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780938012; x=1781024412; bh=zZJiH85oA0FZC1O1T0PX+QDCdtX44rb6B9K
	HqAyMsCw=; b=FinjOyCF5xdm912hf2Xt/gqZ+TgDEdmuyrNNPoMQ5xkuJQlWKBQ
	mK9Bp5FX1uqbfQ1CXVL4Ed8+cLO2puUw8GtccpKUQ8BWxhr5e+SdUwF1iaQw5CZ5
	L+UozCUquzFxwTwt/vYLdO2CCvYAfCormqb/bs847l1SNL4/Xd1TBXx3iL1gdMQ5
	KtnJwRXtKG5paKv6SGTALq6F+TORo3M4Mm9Xx48LGq3m7GV86r0jLlgqSexouHQk
	kvdnAAL1Z8XNEWpSwIhGTLbSOWlCQZrLpNOe1wBPsOOXmXC9PDqgF56JV92JIPA8
	tf4GfqlNjvsDZ1nUXm3Dkv5S2B1iwiwE4eg==
X-ME-Sender: <xms:G_Umaq9pCouevcRnuJ35CGGQXeaVO53tXZ3YYwpqyGXlmK6aBDWFYQ>
    <xme:G_UmajKUeQZt-I_9GSUhh9_o2AYGghS6Min9549sBPc0pKcyXLL9Uh6ftFJoMFr-U
    DFTh1N-sfjar-L9I-kkr2pTdaIGISh3w7I2fneYIxKaCkBvYmtJ>
X-ME-Received: <xmr:G_Umagd17toCvqnrPcDt3XefDxkYCQXam2cKBAevo1DUTc150CX-LNYGDYjQuSqIimuqTOhZGFGNytvYE0QnuUxafdk3fHYyqzhb>
X-ME-Proxy-Cause: dmFkZTG1tYeBvRq4DHsCqir+xJE8wE2KZ2EClMchBklfO3RfaNqSe/KhW6bzjmG8lIhhuv
    z+tT+lUxFo122cLgpSdppjzyYzNDkalnSIEfTLTp5tABKjLT8rhMCKtFekoEzqCrLvlAJC
    gc06Z7D+6PWD2rGm+J/ZD/B+LvSD+Me/UUH+UnyMCSvN8OHRnFXUivNzpZJcOG4D35L8yB
    wkgfUgmKLj3HPKpvEjNR3j+Z9RHemRvH3/Gz1UELAKHdRglCU49rScdg3z2C/Iw9vB6vje
    07iE9P085ia3KxjSSKOrUhCZzBuyBdY+2svjqCrXhYhrwYQK4mZFnnLg/Ti1zo4IL/Nssb
    Rvd45ecUCmGSSJu0BkI2Qs8poy9mr1kkBHhLFvY6kjL8ZGtGkv7sXmaK/2tkM2GzCf3Ntp
    xCTU4NBJmRArJakRyDZ/9wlSP8VPYZh2lLLobLJz0KEQBfTxui0acxXOKXve7MmJJT6Kr8
    v2JAeh8sXcmu762gQdHfWAyMP1yjxuK5hDLBWRF1I8VaHzWiPEzi+M7dXXOfpITnTHYS5X
    T+AtIN1hcSBsUT6sahBEZ7GOzEl0Cwu2y+u6JPcpJK5AJbpYXTlZF+o7ZmbG8MGHP8St5v
    jz3XvKkAfLne/0suQw8qUVVl9Tlea4u/EkdJVAccqsGHfiW06UAuXNLBFJeg
X-ME-Proxy: <xmx:G_Umai_tlc8eMOJRFvlMgNJwIS_fisiSxwbNZMmZBTI8F17CipN2Dw>
    <xmx:G_UmatpVcg5P9Ph3W1LoPkpB-BNDXFW9317mfSOIM9XD50r1Zl8hJg>
    <xmx:G_UmanDg0B5IlLMdyREtRgR69-Yw4w6EYZ-Cm4fV_VaWiPGjW0G5Gw>
    <xmx:G_Umavwzos4rV_QGR39yul3k5PQ2x17Gd27w-No6qrEg5t7iuyb4jQ>
    <xmx:HPUmasdHueZhU4KGHOVpRJOWcSbITyOkf35Jt76ZQAcIYvRKaJjtaNix>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 13:00:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  toon@iotcl.com,
  jn.avila@free.fr
Subject: Re: [PATCH 2/2] builtin/add: use die_for_required_opt() helper
In-Reply-To: <20260603111044.39116-3-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Wed, 3 Jun 2026 16:40:44 +0530")
References: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com>
	<20260603111044.39116-3-r.siddharth.shrimali@gmail.com>
Date: Mon, 08 Jun 2026 10:00:09 -0700
Message-ID: <xmqqecihvug6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> -	if (!show_only && ignore_missing)
> -		die(_("the option '%s' requires '%s'"), "--ignore-missing", "--dry-run");
> +	die_for_required_opt(ignore_missing, "--ignore-missing", show_only, "--dry-run");

As builtin_add_options[] knows that ignore_missing (variable) comes
from the use of "--ignore-missing" (option), and similarly the value
of show_only (variable) is tightly linked to "--dry-run" (option),
it feels quite wasteful having to pass both.

I wonder if we can do this more declaratively, perhaps by
introducing extra types of elements in struct option[] that tells
"--ignore-missing" requires "--dry-run", so that the client code
does not have to do anything more than calling parse_options() to
implement this?

A possible counter-argument may be that the value of, say,
ignore_missing may be different at this point in the code from what
was set by parse_options() when the command line was processed, but
then it means that the message (with or without your patch) is
misleading, so I am not sure if that counter-argument is valid.

>  	if (chmod_arg && ((chmod_arg[0] != '-' && chmod_arg[0] != '+') ||
>  			  chmod_arg[1] != 'x' || chmod_arg[2]))
> @@ -462,6 +461,8 @@ int cmd_add(int argc,
>  		       PATHSPEC_SYMLINK_LEADING_PATH,
>  		       prefix, argv);
>  
> +	die_for_required_opt(pathspec_file_nul, "--pathspec-file-nul",
> +				!!pathspec_from_file, "--pathspec-from-file");
>  	if (pathspec_from_file) {
>  		if (pathspec.nr)
>  			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
> @@ -470,8 +471,6 @@ int cmd_add(int argc,
>  				    PATHSPEC_PREFER_FULL |
>  				    PATHSPEC_SYMLINK_LEADING_PATH,
>  				    prefix, pathspec_from_file, pathspec_file_nul);
> -	} else if (pathspec_file_nul) {
> -		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
>  	}
>  
>  	if (require_pathspec && pathspec.nr == 0) {
