Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C42E3A1CF
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740531; cv=none; b=YJgzW7tgQk98f7vwA0VcPC1QuTeuOx+ii4JZ7VLs7xfrsjMcGCcKJbGT4l7qk8IYZoAvKllB+g+hAysR5/b3/yK65PjcwQ1PrSPZ2pefew6GTwVroXxZX5RZ346slCQaQMFnQqyIYOrFoCJTDNxROPTu7RMLffwg+Uo9cYSUDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740531; c=relaxed/simple;
	bh=YnSLHYLkcr12sjEMiq1fG0Nu0SHbhFRqRSLiAWkK1Rk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nknskaj7xinrfXLf0bcuR2ABTehrRapLlHVXIdxtfTTu2MKySoW6rOf37s2wh1Q+ueqdbQNrtsCnulJgpnL5FPRB2T2q8JhoY4h3xDJyajuW5GinWtLCb1hlkpz0swl/W7vINrNJxn/jKjX5mL/Enp+syb4LHBRrq0ILDG74+U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ClbnT3GO; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ClbnT3GO"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E1F3355D6;
	Wed, 31 Jan 2024 17:35:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YnSLHYLkcr12
	sjEMiq1fG0Nu0SHbhFRqRSLiAWkK1Rk=; b=ClbnT3GOQtmZ25WU+z0DwxU++3ib
	w8BDFGepxKuF9lIGO0FJSCWk5Kkl2nnTLqLGu7u4EZvEOBd5/AjD6jyxB4PBk3i/
	nN3Ahj0KcoKvuQobMcFuaJ6M/ntZqIHlzroSk/ZWlV+dzSoC3p4xB965TNMnp8z6
	glEOM/yLbc7948Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 468C0355D5;
	Wed, 31 Jan 2024 17:35:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F3EAE355D3;
	Wed, 31 Jan 2024 17:35:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] ci: update FreeBSD cirrus job
In-Reply-To: <20240131191325.33228-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 31 Jan 2024 11:13:25 -0800")
References: <20240131191325.33228-1-carenas@gmail.com>
Date: Wed, 31 Jan 2024 14:35:17 -0800
Message-ID: <xmqq4jet3zdm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 031A31A4-C089-11EE-A7A1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> FreeBSD 12 is EOL and no longer available, causing errors in this job.
>
> Upgrade to 13.2, which is the next oldest release with support and that
> should keep it for at least another 4 months.
>
> This will be upgraded again once 13.3 is released to avoid furtheer
> surprises.

Thanks.

> "Not enough compute credits to prioritize tasks!" seems to be just a
> reminder that the credit allocate for the Free Tier by Cirrus is all
> used up and which might result in additional delays getting a result.

This statement does not quite help future readers of "git log",
unless they still remember that it was how Dscho noticed the
problem.  Either moving it under "---" line (meaning: remove from
the proposed log message), or adding reference to the original
report, would be more appropriate.  For now, I'd amend the log
message to read:

  The original report [*] of this problem mentions an error message
  "Not enough compute credits to prioritize tasks!".  It seems to be
  just a reminder that the credit allocate for the Free Tier by
  Cirrus is all used up and which might result in additional delays
  getting a result.

  [*] https://lore.kernel.org/git/d2d7da84-e2a3-a7b2-3f95-c8d53ad4dd5f@gm=
x.de/

or something like that while queuing.

Thanks.

>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  .cirrus.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index b6280692d2..77346a4929 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -1,7 +1,7 @@
>  env:
>    CIRRUS_CLONE_DEPTH: 1
> =20
> -freebsd_12_task:
> +freebsd_task:
>    env:
>      GIT_PROVE_OPTS: "--timer --jobs 10"
>      GIT_TEST_OPTS: "--no-chain-lint --no-bin-wrappers"
> @@ -9,7 +9,7 @@ freebsd_12_task:
>      DEFAULT_TEST_TARGET: prove
>      DEVELOPER: 1
>    freebsd_instance:
> -    image_family: freebsd-12-3
> +    image_family: freebsd-13-2
>      memory: 2G
>    install_script:
>      pkg install -y gettext gmake perl5
