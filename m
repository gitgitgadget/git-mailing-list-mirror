Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EA3B5846
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072251; cv=none; b=DfoU9Q5hDhtRGkt3q9u9iS0tclv4kJeAQX6gRLIF51UDwA6NofI6/G8d1/m+j2dYX+RCxpfmJpGeId42KVp/dswqEXRF8f1936H8CDEcCKPnqHKgwxeQl31WCSgA4BE37wCV9im6+fH5BhheTalS7Bxl3s9wYR6kYImHrU+kfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072251; c=relaxed/simple;
	bh=90GuY+6PWUTKeWqSZBG/5+c93ovDXhprzc5wUtMcuM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sd7wXDZVcRyyMRfdaQPxo2VEQgxvSfSrWJ5gJ1Vk3ds1t4Ov0ca+zo/WjWlsfp67Av665PfC7Jjm0NoyWXWMm3Huc09Q3SJgZlCZ+1FQVyI7p6B8OZP9ncBVozYkzp3WNf1d3Bjbg4m0FaPS4GC0saFlBYj0dhw7jgCfizuGmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuC0XUtv; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuC0XUtv"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d73ccee442so1836218a34.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773072248; x=1773677048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E43cYBwomQj5YnfkdzNlhm2RhX4PrNlWn+pa/XKNGII=;
        b=iuC0XUtv97wxfX0lpzcDUQUHSVtXF0rFR3Z3redkrAcUbNUyoNB1YzlRMwuZwOHvsI
         WbKXOUpfnKQBTPSISK1xPxh5i10BuhZ6VImJ5UGqf72e4vvYjew/OHVp3lw1+S7xuAvG
         DNYiLvuZbk0eM/ioAtG/2kXpKbcgb/vGfvjuBSIA1Yz5JIgJHlUihKqYtJh+Un1nmNZY
         izIoGA7dm907BX8wtosjX6LOrd5z65M3lVQuGe+OwCyOCCEFWTiQtqO9dFxjLTpsctPT
         jp6vhx5UlN8iH2c7Y7nHVuvhUzIeKhKFfW2V2vgz5/wILSC/BobWQdtESgqeU7NC6lrW
         7DSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773072248; x=1773677048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E43cYBwomQj5YnfkdzNlhm2RhX4PrNlWn+pa/XKNGII=;
        b=P6dqyXKd+FW1kehvGthVnlhAbei6T7jIRNl68COh15Nm2wtcVI1XDHVSguorsuz6zH
         U5mJ63hz6DUgIWRRSUS44+QeuN1V2Nr+sz/eH0+MSXP4oHL9yqskIGtgOF+ZxuYI0e6R
         ERIU+2gHou9Bzpk4Fwj949QUe38EzShvfdr5NbnXpCorV2Nwrk/6pDPIUl4d/m7Gd/GY
         OhNmiMu0QYJ40juFirbisR5mM66Ga8HrRYFhCHfXhYD8mF8Od3+3432zQkHCc9Jb/ygM
         G9LaFTcNnwMaPtGd+mRbqkPdjLb9gb7m34YSVxMDVL6IImGh83K9FvIBwWiGLKGVEH/l
         BxQQ==
X-Gm-Message-State: AOJu0YxOqMqMaaC78UuJstWnYIPiP6gpF6le8J2S19onhnY+hkqcPl5s
	nvtKlzsO17pdvvzzXDIV5kQy4q/CBGFAJRYGSnyfOXYz5MzIIG6DDWwZV2xQ0Q==
X-Gm-Gg: ATEYQzxUt7OyaaxWJPmG5sNN9vCgvOO5Sl87b2YGtefuoq3pWjg0ZJ+0U8NBuxlvmqQ
	rC1W/9dTib3bE89Jy7OTIVT8PSEcMUAbOIjyTgQzuiTNndRurrJRF3OOHvTKJD3mzRRqqzL+BT1
	jqLhiBKdHUP9zD3MeNvT4vXGON2vTQi2InE5W6l5q8i8SI+0sfOWyd+e2MmBmu8NLPnWHeZpeMu
	fVw+NI2o9URhrmGDUp/pnaX2q6IR/Eqv4TA/WxK5dhsaV5d494la/ZtCnmqUhzgDJDy30TC4xcf
	JtxPVjiFGBvJwQaN5SWWXvBybyNRV5h1YWU2zHtScyv20cNqKB2jvodX1U+12LuBj2dPJ+lRw5P
	Ikn9hF58JkstsKMA7Y5wo8ji2zn1ObtskXfqTTxwPQ9U9JIyl0FesnfxtFnlgyvnwLL6eJUD1q3
	pxTsMGsq69BvTc6PRJ
X-Received: by 2002:a05:6830:4112:b0:7d7:48c8:5ac4 with SMTP id 46e09a7af769-7d748c85dc6mr3083584a34.30.1773072247483;
        Mon, 09 Mar 2026 09:04:07 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d73b7b60aasm4498350a34.13.2026.03.09.09.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:04:07 -0700 (PDT)
Date: Mon, 9 Mar 2026 11:04:06 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] gitlab-ci: update to macOS 15 images
Message-ID: <aa7vS85brBpd9R1X@denethor>
References: <20260305-pks-gitlab-ci-macos-16-v1-0-ce8da0ff29c2@pks.im>
 <20260305-pks-gitlab-ci-macos-16-v1-3-ce8da0ff29c2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-pks-gitlab-ci-macos-16-v1-3-ce8da0ff29c2@pks.im>

On 26/03/05 12:20PM, Patrick Steinhardt wrote:
> The macos-14-xcode-15 images for GitLab's macOS runners have been
> deprecated. Update to macOS 15, which is our current stable version.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .gitlab-ci.yml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 71b8a6e642..83ec786c5a 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -101,13 +101,13 @@ test:osx:
>    parallel:
>      matrix:
>        - jobname: osx-clang
> -        image: macos-14-xcode-15
> +        image: macos-15-xcode-16
>          CC: clang
>        - jobname: osx-reftable
> -        image: macos-14-xcode-15
> +        image: macos-15-xcode-16
>          CC: clang
>        - jobname: osx-meson
> -        image: macos-14-xcode-15
> +        image: macos-15-xcode-16
>          CC: clang
>    artifacts:
>      paths:

This patch looks good.

-Justin
