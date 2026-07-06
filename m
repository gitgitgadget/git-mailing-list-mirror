Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581B38F659
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783375334; cv=none; b=RnzFskdZlZQmsJ2ouJhhYj56SjLKm8ua2LiU81zYTPlLYa6I0Tf0dLWGauE6B14W8VdqqugLhb8lySF3AKzcFg0QXaTQTRAXPivg2u2WMbDj0ABpcfofjLTuVG10gIb9qvAfwK2zmqeGePJ1tRS7wd+C4syBE8szqPj5fBfFbF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783375334; c=relaxed/simple;
	bh=bfcyjjR0PHWXLLRZ2ibr1t9lSLn3hhXxITG6oB3WYMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaW+G2yNNGOEuN4fCw2GMbKtK5Gyoql27GDfhabgY6NVq8sAbCIVRg4lKO91ve/8m2evVjCVurQa1emTXZllRSyvNfNzZxwnOaYNh4tex35zVpcB/VSh7R1a+fdKTY7ppZUT2dD5GoceHUTNmx+i24cMT/fx7vZosOl7biQKOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlJOdiOx; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlJOdiOx"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso2630078a34.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783375332; x=1783980132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOQr6CJ3hNkrgPpBmDdQTlUGyVobf7PcO0cPw39f2fI=;
        b=HlJOdiOxgCI0KnHEHYwTQUZT6z8ZTaxSgwNpoWv1tWKe9HaqTSU045KNbOwYDOC+vP
         G6wDQ1ZusErauGpCtCDbCuxHPTtTxCk+YtjIuiJt7TePAyAURALPEGSP6jtc5jCbhCmm
         nVGzqjtWLC9iyf/Qy+GyN81RDwAWc8iwQ2rOn2HCpDVYF5CCv95StYAMrzfCeDU3yHDx
         xK9rrzrA+wTzUnE5FXUqcKG31bYjhkPijKyMk6933KtoV4KnF0A/ChzZvp38HnXtOn3x
         3PNDtBuN/8jIK/FIGTuFsOEgQ0nrQM8QM0cEI4WGnPF0sneHX0KHfD8ZBfzcOykO/laF
         nGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375332; x=1783980132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOQr6CJ3hNkrgPpBmDdQTlUGyVobf7PcO0cPw39f2fI=;
        b=YVLPqY1BV4JQ3+c+bmJMFvuyxiAuARlGSWExwMRjia0I6qfjlCf0sBBhwpPArcviC4
         09qCQvli0lyZbzaG9N1KWICywNRnAoVKaFQAW0sszmXOKnsYeQ2Qm2ycgbghb7Rny00M
         E7M39bl+zdxwbBbIT6XEIiCVqpFvDraoXbPu+jbaO3Rbw5k4uj2vl4isTjT3Ys+JbjQF
         7yFGXTLcuD9DMGPMq9R5sZUT9f3a1uYD1YfC5BR/H+x/JiEE40vNunP1AJeuGPrBzmw+
         vNvT0lOAms/b6vGOOvlns/i+j6twLJoPUybb4lAn0F9lamgnCpMjfuZtsBgrMHqm/soP
         O7ig==
X-Gm-Message-State: AOJu0YygLv5HYEW4VVNIayg6IPuBy9CTECaOqrACDwurk5ZhbmCUrpPF
	nUuKlSYpZ6dDpDK4iZZVg7N2R21hX5i5hVYIxGi9zmBe8ZMvO3IC6hQhCB9F6w==
X-Gm-Gg: AfdE7clnIqkDnTuW70HRWXGiodMIAFjaulxP2Qz/e0nveekrg/w6GVlZyzUe/czUK1A
	3QXZyLycCeBmgL/w0qMXeL6pdwaBNCzNbLpSMSepClx9D8XP9QyE8+aqVdeCHGMa7i/6m/cSCmY
	smlizka0YS8U/qdVb5n3zroYbwV5RVY2idcD2iTMEsrs7m9hANm0eszZxCoI2vcmoipKYUCDfW+
	dUe55I7xle8WAg5Y0jQMYLdz7BGPNnu3sFBy8nqIh7CWVIiGxzCn2j+3vb+oELJq/5aZHA6Abmp
	WgrEdpXiHvb44ucCP0xIL5OszRgA4JlvGIG6wb8Lggu1Jp7CBk25dRrCzY3p7MCVEyBGkjxBpH1
	DGF3rsKwRzleAO4MRiaVkd7mRltSzmACG5MQ8L45uUf+P87HYwDHo9BUiUel0saAvRAkrsi5Uxs
	nilpL/wQ==
X-Received: by 2002:a05:6808:1202:b0:487:6930:d50 with SMTP id 5614622812f47-49fde3e3947mr1828067b6e.35.1783375331664;
        Mon, 06 Jul 2026 15:02:11 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-497d1af4af7sm10887675b6e.9.2026.07.06.15.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:02:11 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:02:08 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/13] setup: unify setup of shallow file
Message-ID: <akwkS45ZknejwhuO@denethor>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
 <20260630-pks-setup-split-discovery-and-setup-v1-3-13864eb5a032@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-3-13864eb5a032@pks.im>

On 26/06/30 01:47PM, Patrick Steinhardt wrote:
> It is possible to configure an arbitrary "shallow" file via two
> mechanisms, and the respective logic to handle these is split across two
> locations:
> 
>   - Via the "GIT_SHALLOW_FILE" environment variable, which is handled in
>     `setup_git_env_internal()`.
> 
>   - Via the global "--shallow-file=" command line option, which is
>     handled in `handle_options()`.

Ok.

> We can rather easily unify this logic by not configuring the shallow
> file in `handle_options()`, but instead overwriting the environment
> variable. The environment variable itself is then handled inside of
> `apply_repository_format()`, which is responsible for configuring a
> discovered Git directory.

What is supposed to be the correct order for processing shallow file
configuration here? Does this mean that the `--shallow-file` option now
overwrites the environment variable? Was this how it already was?

> This new logic is similar in nature to how we handle the other global
> options already, all of which end up setting an environment variable.
> So for one this gives us more consistency. But more importantly, this
> change means that `the_repository` will not contain any relevant state
> anymore before we hit `apply_repository_format()` once we're at the end
> of this patch series. Consequently, it will become possible for us to
> completely discard `the_repository` and populate it anew.

I can't say that I'm a fan of using environment variables to store
global state in this manner, but I guess if there is precdent and this
is making us more consistent, it is probably fine. I guess the other
option would be to store the read configuration is some intermediate
structure to be applied later, but that may not be worth it here.

-Justin
