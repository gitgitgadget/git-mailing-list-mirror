Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B72037CD31
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408237; cv=none; b=TNVsWMK94fO2oeqqICQRy1Td6lYSQ2WrAMwvWBnEw83BpzT5IR8inO0JjKR+hsHxmlmm0784MCb+y8l6BBlfS7BEYeTvQgiwnSvfRMooquguXuBe60734cIKzwGBbltFGJ9jolXzuK12ssuvur4/cpZVyBarx1bjBzAo2tc0qNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408237; c=relaxed/simple;
	bh=D5utKB87pJZt8Y4WfeOyKO3/0dcr/Xdk/41d3KhcFoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cSPicuLcENFxoxZC7DueMSqRMx1D8MwZiRDykmxzuY2lhgeOYzdK62dVRqkzuFxQtmOOUxtAUa81lENEMEhYxiw0ihDBbGnKDO6WpxU1Y1OovAzgjKrwZZRwjxyBRvPijm4lIm+qSNwB9BxEsyK2TtiF5bfR1nEgKQqTtBwcsQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kyn8drVs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ix/ekgRO; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kyn8drVs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ix/ekgRO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 83D7A1D00139;
	Thu, 25 Jun 2026 13:23:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 25 Jun 2026 13:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782408234; x=1782494634; bh=wscGU0pLlT
	ToflyZW13JhD5W8Kbf3FkeOti39jrcY6Y=; b=kyn8drVseCJ2VYZzPKJE5THAfP
	kwkvzlg8VRs0eds5l5M1zzet2nlavBatu9dMX4wd020/T8vo89Y/HJPB8DN/zbFy
	mWe0a3a2fyaBUe8r96d8klLCGYMZP0JrtksaezmX7ASYcvdZXMvVJ1WD8F/SB5Ij
	aRqi3lPmJup9e21fWWlfUrH3WGjfqg+Zn47HqBmTxjjjI8HheTQ1ZbVuxPUOXtt2
	IZjVxbXoqwDIXXSBYmmTnXNAwhiszdgYPRNOkwvm05mmjrRoMlFwZggP255C6oYF
	wKtlleeIRQpY6g0RjZ+u3WGpp+ww7L8H1XYgAVVTPxsnZ0FnogNavQPL83dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782408234; x=1782494634; bh=wscGU0pLlTToflyZW13JhD5W8Kbf3FkeOti
	39jrcY6Y=; b=Ix/ekgROgeFgxtZGyJsuaWtpBv6WiYubk5GMC5W7hFQE0/j8Wck
	5sFZDVnhbQAQtmMRrOWt684jSa6ySz7IVjAV2kUV7hrEKJRxlF1IGVDVUR7Ys0cS
	wUFo63erSUSALTZQCD8rrRGPnUx/7VeatDv1gJ0iGiamVN8bGUUvdAgFnnRovzGJ
	as/XIcW83zIYUFazZ4/mELJHDxB/kEHCPpmFxJdKipbECogon4i8gsE1uZ0gCBQX
	DJlDFBj3CGKmnGJZL129siEsJkdklXjm5dIlyfJf/MMphMykQ9CgXzXrueev8fhF
	ZSwF6+D0mvmpE56XdMcRqTIDuOXOBHYrf+w==
X-ME-Sender: <xms:KmQ9am2JCZihpz1aU47qMrxoTxoFb5EjZIMI-huIxMUVBrs9d-0ULA>
    <xme:KmQ9av9XMJ-J025LwRqGO7p-GO8qBVzk-6i_fZyf1pI-b9lgVj8YdMn944dau6D51
    cO1t_qrNEoaav_jmYywK5510MNGnLWZKbuBCYDSvKbHsg5LMpKSTA>
X-ME-Received: <xmr:KmQ9anMkyxqfQMA95fK58TV4TZ2skhVEQiFWFAhki_48d6aHHsarc5rqbQNG_wePzzajup4k4S65wurLcjGaoIo5ob93gpee102IOKA>
X-ME-Proxy-Cause: dmFkZTGT5sYV+1JyDQWPM5HZ9bAuMD6PNrFlgaoc0jupkhquUv0/ZE0WBk1EeIFJg1rpf+
    t37eRTAKD+lgy1rMskrGXofYHgJBgEimZystJZ7+xCGmBLayN4dz4tE7uftJmjJ0LYSXFn
    x+hTBqNfTE+tUqDhXCp1AQfo7BzrMrxtfXhF6Ju/QPosIrzSEEj+sBQGl5m2iX7gWmNJzU
    CQ8yXcgIM3FhscO0c4sS24UxZgQ0fAraf+XKIs7WVrTk/+ynFMBAciIFg7n31HI00ygz1e
    H53HMxEBq3r9M/H9Mspr66BWU4a4EwFlIATFOKYl9XnouHphjj+IfD8n+HWZQIDR1RDbiQ
    Q2XPOBxztAdWykIoDQg0U9Ppw9sDt8EpWGZD/MnRWe0m7pIkTTlmct1rv785/M0l9Uuxuc
    rn0mKl7GZghvzgNxj4eD3sRwQBHiD6K9cGc9li5xrkdpG+K29XC2bc9Mip2llU8GBMazSZ
    /H2IQlsYg3eN50Tm7cFHc1+tvY2yuPqL8kyqC07LYRcmp0DdG9nWwPHHH9D9xyLGxGyxXx
    SsA/NCfld9sT9V/OifqwV0pHqRsbT0jmZ8By6zHFZaaSSHv78Eg2YCUqQurGtRmv4AxT24
    KkD90dcu2onTLjx9PibwPan9s2H0no/xUYcsZUF1mSNzrWrU9FlYlc06LoSg
X-ME-Proxy: <xmx:KmQ9ajcB48RSA_Em9tSWPL8LOxiT7ar96AgRiKzkbXZqXP1iWzvMnw>
    <xmx:KmQ9amWriM0XbMFTgylO6xRYVcXX0QN8QaxFWQySZdRCCaJjPwAU9g>
    <xmx:KmQ9argRRujeJGSqlXmSCuFpJZeVQR3QMeQjSCk4uyPmxQyxYfwg7w>
    <xmx:KmQ9al8jmhXIIjT67XUHFVjIXY-8YQYGC-9a-ARSBknbDacC3iin1A>
    <xmx:KmQ9ajF5FNIks4P5h55J_y-OwvHcqDNoZx4Y8GHXR4z9KJnjl4A4OAQw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 13:23:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Miklos Vajna
 <vmiklos@collabora.com>
Subject: Re: [PATCH v4] doc: clarify --follow and log.follow for git log
In-Reply-To: <20260625-document-log-no-follow-v4-1-9bb233248b8f@gmail.com>
	(Tamir Duberstein's message of "Thu, 25 Jun 2026 12:01:18 -0400")
References: <20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com>
	<20260625-document-log-no-follow-v4-1-9bb233248b8f@gmail.com>
Date: Thu, 25 Jun 2026 10:23:52 -0700
Message-ID: <xmqqpl1efs9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> aebbcf5797 (diff: accept --no-follow option, 2012-09-21) added the
> --no-follow option, but git-log(1) only documents --follow.
>
> Document --no-follow alongside --follow, and note that it overrides
> the log.follow configuration.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Changes in v4:
> - Limit the patch to `--no-follow` and its `log.follow` override; leave
>   the existing `--follow` limitations unchanged.
> - Link to v3: https://patch.msgid.link/20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com

OK.

> Changes in v3:
> - List `--no-follow` before `--follow`.

Ah, I think I misread the patch and its preimage while reviewing v2
and I didn't notice my mistake when you sent v3.  Sorry.

I somehow thought that the original before the patch was

    --follow::
	... description of follow here ...
    --no-follow::
	... description of no-follow here ..

and I thought the patch was doing

    --follow::
    --no-follow::
	... combined description ...

and commented that it was a good change.  I didn't mean to comment
which between --no-foo and --foo should come first (looking at the
output of "git grep -C1 -E -e '^`?--no-'", I think --foo should come
before --no-foo, especially when --foo does not take any value, but
it seems there are many instances that list the negated form first).

As the existing text has mixture of --foo before and after --no-foo
let's not worry about which one should come first, but if we have a
chance to redo this patch, I would actually prefer to see --follow
comes before --no-follow.

> diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
> index f20cc25cd7..58147dff9b 100644
> --- a/Documentation/config/log.adoc
> +++ b/Documentation/config/log.adoc
> @@ -54,7 +54,7 @@ This is the same as the `--decorate` option of the `git log`.
>  	If `true`, `git log` will act as if the `--follow` option was used when
>  	a single <path> is given.  This has the same limitations as `--follow`,
>  	i.e. it cannot be used to follow multiple files and does not work well
> -	on non-linear history.
> +	on non-linear history.  This can be overridden by `--no-follow`.

OK.  This is the usual "command line options override configured
default" in play.

> diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
> index fb3ac11283..64fbec0f57 100644
> --- a/Documentation/git-log.adoc
> +++ b/Documentation/git-log.adoc
> @@ -27,9 +27,12 @@ each commit introduces are shown.
>  OPTIONS
>  -------
>  
> +`--no-follow`::
>  `--follow`::
>  	Continue listing the history of a file beyond renames
> -	(works only for a single file).
> +	(works only for a single file).  `--no-follow` disables this
> +	behavior, including when it was enabled by the
> +	`log.follow` configuration variable.

Ditto, but I am not sure if we want to sprinkle the "command line
overrides configured defaults" all over the place.  The description
of --[no-]decorate below says

	default to configuration value of `log.decorate` if
	configured, otherwise `auto`.

which silently assumes that the readers _know_ that command line
--no-decorate overrides that default.  And I think it is a sensible
assumption to make.

So, while the patch may have meant well, I think this part should
actually become a single liner that adds `--no-follow`:: and nothing
else.  The changes to config/log.adoc should probably be kept.

Thanks.
