Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA131DE2B2
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196591; cv=none; b=ujS0LtKeaVA0Fb1z0yX3RCk/iAZBxpcX/XCC1OR/7MEa8KRwDT10gE6lVdZZmgHa4OdC/tvZTsZvtrIWJ/+Q7U+faT2/hviBHLa88zJV5oY90R8dksqvjvQCzqfACle0FBCeek1KsmzXmRDUg9esTOtdeb9T4laPCz3SnRcl+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196591; c=relaxed/simple;
	bh=0/PII1vphUFISRMP8UZTKllxpdftJ6OdC3J/zSvCaxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhY624H2yLem4+AHTJWk/XdoWjePlUeIrsrtzsBeIqdy2FYI1hrqGUjnG/+E6VZIoPUOxSHeqQ+cGNGA+EfRtJ81MvkQUTzBkhtUlkfrPOIjTB34evTCmn6/4zjFXDYW+zERgxAFXN89GNmlAVdYsqbbJ/iCbtBJWBtsKyO8o0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IBWLOJeb; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IBWLOJeb"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e291cbbf05bso1468279276.2
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729196588; x=1729801388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvW6bbji7dhtBvLOr8jaRxH6rzNucA98qPN+LeMUKos=;
        b=IBWLOJebBHOIS6jTk/byXSqwqoUhnk8bz32+8siRPS/uVQP02k8wlQJrEi83cb6AFx
         DkA6CTr+WrDlEX+VwMZN2chHxiwgDV5gAqWn5dpBAZuWG7oKBTC0jsPSZP/NPs9Bef37
         AAVxfg8TVSymZemYZpaVJScqlI8FDe+mi6RBdH2ZiyKSEyWwDSod/ZEvMhLqaistJoOs
         FZiML5YOkoIytHOAhmh3sJYSAP8+dODkc2a9cycaJkdohj3N6JH2tEoy0q/cIIvZMCaK
         o3TKNYZlOBx777CcnDbHmNJ6fk8UJr++fRvx/ZwetMovC+Ryb7sS8dGKnFyta8YYgnua
         7eEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729196588; x=1729801388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvW6bbji7dhtBvLOr8jaRxH6rzNucA98qPN+LeMUKos=;
        b=nztjgtUvR0XL0z1xG5/VrqmwbM879QRVt/RQZH/gABleCFFg6wShUxoyyK14TyOvDz
         EAPqys/ycuxYbrkhwLFdS3EQralCyAls49khWUzvhSeQSpqdMaURUpt30nPI3jHoCqVW
         iyH3IUgDU/VE7c3BJCnd5/cnL2Bj9KSwPZXlSgInsC1vb76Oa0F/RtHiC0nR0h3DF4Vt
         D+y4PkPji2ps5FfBqwnV9V+yE4cybNcpvUiinhw3zVQJbAOLcNDEvBxyTHXZHji00fkh
         EzuFg+RS5f/Y3H2EhteqB91PmZOQ9znQ+sYnktRG+o7toqx4FJKcbz6NihWI/cftVUJw
         7VnQ==
X-Gm-Message-State: AOJu0YwFtjw08eMum6nShAF/IrsCZFWwVtf8D2UgPq3aDaunvx4yNmyH
	xZlsPVbGyYOafzFmt14PG+fPr8rqlzbbn1kVx+9DxSE/4i4MeMKItyk8dw6ybSQ=
X-Google-Smtp-Source: AGHT+IErZ/IZO2jSIGIEzJNHWFdhgH5cumVQjX9FPhG3j5kaeeZKHatbut7CQY5ookKbeAkVxPAobg==
X-Received: by 2002:a05:690c:288:b0:6e2:ad08:490e with SMTP id 00721157ae682-6e5bf73c781mr2009047b3.5.1729196588400;
        Thu, 17 Oct 2024 13:23:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c02c5032sm189957b3.135.2024.10.17.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 13:23:08 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:23:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t: fix typos
Message-ID: <ZxFyKXDCJkRZYYQY@nand.local>
References: <20241017112835.10100-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017112835.10100-1-algonell@gmail.com>

On Thu, Oct 17, 2024 at 02:28:35PM +0300, Andrew Kreimer wrote:
> Fix typos in documentation, comments, etc.
>
> Via codespell.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
> Synced with:
>   - Merge branch 'la/trailer-info' into seen.

Please do not base new topics on 'seen', as it is likely to change
day-to-day.

> @@ -117,7 +117,7 @@ do
>  		git config extensions.objectformat $hash &&
>  		git config extensions.compatobjectformat $(compat_hash $hash) &&
>  		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
> -		echo "Hellow World!" > hello &&
> +		echo "Hello World!" > hello &&

Not the fault of this patch, but there is a style issue here that there
should not be a space between '>' and 'hello' (i.e. it should read
'>hello', not '> hello').

Likewise with the 'git config' use above should be test_config, etc. But
this patch does not need to care about that, since it did not introduce
those issues in the first place.

The rest looks good, thanks.

Thanks,
Taylor
