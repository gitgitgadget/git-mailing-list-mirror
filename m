Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836072874F5
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661203; cv=none; b=JQVflrCWpBQ4dZEeGwcZ7LAHRjU0TD3ZMhpPCYkLJqB63HHzVrGC4BpJJjAWH+eIjgLU06U2ibA7BsZyqx4pmPdmls6JBFd9HhufKLal58qolqAlFimDM7Tnm7dzp1bOBtTb3yZpakCwL80ZbmyYshWuqEV8RgSyHSSEoLEok6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661203; c=relaxed/simple;
	bh=ykM58ccViYSmZZWsDODV4nkAbsBKfdLR8zp+X5LigEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld5lUhwG23NpQWaAO1xmboB2r7VF+b4HVQFSY+UQqU55cKjSFH2n9dJ1BfWbyMcZkdzIyWkw+vfFXewXTswnDHAlIGBUvYaJp2orpD6XzORl9rm+vDnxDIhOajs4RX6Eht19L0/L7bz8WvgZEN9K3KPle3kkjT0vVmH7G/2+Z7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHAYtkak; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHAYtkak"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45c8e85deffso1089251b6e.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 10:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770661202; x=1771266002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCFXMtM4NO5U9Z3DptgrCYebYam5qlTnPzKIKh9pyNM=;
        b=QHAYtkakgejMGIpoJIDtL35DZ0AlE8Wiwfn+6Ggxhy/I8raCALvxGpo1ug799b9dAy
         9ZGexB922VeNQT9xVDz9x/yTMAcySOi/oozFdoeyuczS7pyoqH1vYxIUtN5AsT6zSM1y
         Wst3IurCtNGHluGssV5PltMKTAi6EuB6IZYnq2RsppxPWMSmMXMvl7IMRuETQlaWWvrs
         AsGdC/Zbyvsef6iFyfx0ETlik0izniKITE2kDdkoGalsnbv//0EzOZkXXNfqWAOZZqKZ
         iPC1DO+SrPoOfjWjGQ822VVqFSADuObFHGInGrXtwigMaPG5GJpc9ey0Hhfw0XRvJO/x
         I0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770661202; x=1771266002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCFXMtM4NO5U9Z3DptgrCYebYam5qlTnPzKIKh9pyNM=;
        b=gGl0HEay4UQJK2+/RJaZXxbIiZOH7O+dqiZVKYf1bpP6GkdV6saYoy1TsdJ7XMKsv4
         qQkP5YMaIzwCoZgV/A/2zNyLQWZxkOL0hAyfTS9FmG5TbxnU1cQkUrnD3vTRkX5ItSMf
         GXl0SHxWevFVPS1Rxr9Nn7bmO83j6HHPL39/oHPpD1evDTXkfca8WhF6JcJK/1/4PqmU
         kZzdgrCgpkJFWIRf/UUv19VO/P69AVh6dOUQrG2n0kTt5pAhHYTGaj4skW9K1cSNAMvT
         /Avx+DcHmUNHlRY0X+Rqe16Uc+hV0NQbcXWhphF3Vi41P5pJln9t3fx9IG6U8fYpSz7c
         K5yw==
X-Gm-Message-State: AOJu0YxpAzBMSSly/dZ0xf8s2xttmtBABaiUKGD869RkR+bL8j1sDERy
	+T5S1bleALTHAP8NePe76rqy88EGaJhDXQ0IKvCHKXmAB9pwhMdmopiF
X-Gm-Gg: AZuq6aKZTdtt5XAJ77kcTH6odfk/WXs0A6zvTVxqvqDfIj/8XafTmdGo2hstYm/vyG8
	+Y8YmvHlSeq283NE9RZu3BfjGyUdggjxpBvj1rVrE2b78lqd0nY3AeQ3HLbKWNGAeTEB9k/4ibr
	c2whcCLWL0HNJGLt4nD72M7+miKlMB4vGra/zzAkCIeIYKzgOJbKpZqspaJ3rI/AbG0dIKM0410
	AnAlchsnWv7Iu0w0UyZBVZoHnCDrf7TAlHCdWc9Nr+EcHTRhOpds7BBQMwfgjIMPvOLwm6yM7qh
	aJE3PsINB0bAfUiUOoSwggnvVV23hA645iut9h0Pq5nt7NsLFZOKeg0HYPTLzvO+FrqBDCZx/GZ
	9FSBhkPM4WWhmd93Flt9u9a4ACwXJ1iFJ2xho6qhgGD/yhoyMssoUNYx5kkrmSru5/2UBDN/Aom
	krxHhK
X-Received: by 2002:a05:6808:13cb:b0:450:4782:2b0e with SMTP id 5614622812f47-462fca1bee4mr6605889b6e.15.1770661201988;
        Mon, 09 Feb 2026 10:20:01 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a989e22ccsm7960106fac.0.2026.02.09.10.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 10:20:00 -0800 (PST)
Date: Mon, 9 Feb 2026 12:19:57 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] ci: make test slicing consistent across Meson/Make
Message-ID: <aYojRnqBi8nzZhPD@denethor>
References: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
 <20260209-b4-pks-ci-meson-improvements-v1-3-38444dec4874@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-b4-pks-ci-meson-improvements-v1-3-38444dec4874@pks.im>

On 26/02/09 05:56PM, Patrick Steinhardt wrote:
> In the preceding commit we have adjusted test slicing to be one-based
> when using the "ci/run-test-slice.sh" script. But we also have an
> equivalent script for Meson that is still zero-based, which is of course
> inconsistent.
> 
> Adapt the script to be one-based, as well, and adapt the GitHub workflow
> accordingly. Note that GitLab doesn't yet use the script, so it does not
> need to be adapted. This will change in the next commit though.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .github/workflows/main.yml | 2 +-
>  ci/run-test-slice-meson.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 2b175dc5c6..1b7a16e1f1 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -298,7 +298,7 @@ jobs:
>          path: build
>      - name: Test
>        shell: pwsh
> -      run: ci/run-test-slice-meson.sh build ${{matrix.nr}} 10
> +      run: ci/run-test-slice-meson.sh build ${{matrix.nr + 1}} 10

Due to the changes in the prior patch, GitHub CI passing 0 as the slice
value would cause a failure correct? I wonder if we should combine this
change with the previous patch. Otherwise this patch looks good.

-Justin
