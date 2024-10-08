Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F91DE4CC
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393585; cv=none; b=pcmokVFS1c7ce57/XR7QOnQvr+oH2hl0hJM8gsFeUIqKydRFir4rzrvbz7OPLL/hZ4gyMzYAp0dTBLyh0d4Yr79LUK8dX5Ukt+FcVbF21SAYsCnMWZO7S3RQhifSRID/7+lx8nu9QuKx+qxUMnB4sziEG7flfxHfBdSPsCuWl4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393585; c=relaxed/simple;
	bh=uvWR4ClEJ9Qa76YreNsVPuDqYCNZTEIjtEcxeSsHqdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr1u/3HfB5aNb9uyptbdEzZBLYCqvsuAxVyDjPFI/4axEJEk+1V44EDznyDfOgwvy7gm8lqIVpGm5EzXjXn9M21quWNKEpE2TwFRipYkHM6DSiERrN15M4w9tRp1gWlFTUei5NjS1m7Fv9ud96Y3QrFw69W4Q6OCRkZsL17qle0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5KW50JH; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5KW50JH"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea07610762so1546005a12.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728393583; x=1728998383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xn+/eO1kvaruu5MhxgW6XbEAnr/yFswRCrLq2Et1EgY=;
        b=J5KW50JHZjytfYO+YEDYVjkFoAYWO7NHCkUQFzY/HbXNzqMw5bYSOEqAr7Alvj1rPH
         YSKhUSYkyp/GGydD+TeQOpmAOyE54bI1y+YMainOvQoMTVh88ljFw3zkTcFK84rXLRd7
         6LBkh5QVFnImMVipRtN75rRsnc1DxljbhhxbqdyWlxobfllzXlJpl6cSc9qP1JHinuPx
         SPO9to0+0TTtWU+XpjfE22d9xi9kWQvnpYhhO+/Fjz/5P65/zafeUy5SR0yOFxSAsuCX
         5OW5tWQjOlBXopMcnxqUpfdjigtqJc44vXkHwvMNSOtMmbwKzyEDBecMerdAl893LIka
         UjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393583; x=1728998383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xn+/eO1kvaruu5MhxgW6XbEAnr/yFswRCrLq2Et1EgY=;
        b=sDUgh0PLIUJso6XrF4kQc42opvYTsXlAr3/HyNhqVvwi1zfxV16elhqmvi5r08+ZG8
         OndUssJjuzoTNYJJumN8sJoJ3hujiPV7N1XseKe/Ug08BfgzbHOZpLcacKrvW0VArNEC
         jQ5Bc+7UMumWH/FiIa+zlDTEgFG8I3eSdyPo9HNICGf0aufTkCiHeDttimW7iRL3retY
         tf32RAzXGj3PGuxg9U7Xh37CZU6j+wm1nxCv0azx3LlmyGE0p1z2vB4D9j7IVXh9R94Y
         dBrAPYDdq10FVyXive9ZI2fNNLDyy/T/NGmklm4dWwdofK9x6TKJESEQHd29VLoI9uER
         IH9A==
X-Gm-Message-State: AOJu0Yy1SD0RpCXtgAD9DLVlB74N4LoEecAHvWsHNsVoGxnmN6NpvjqW
	+yLFIfYBCT0Snok75p82FZvSpmQ7ysT6MWzXTS+Za/AQf5E+/F+aQw/bDQ==
X-Google-Smtp-Source: AGHT+IHJwLB6S0OPgXi5EbHuDILcqPtI+F7h90frZwyp4C+J/4A0IeoF8zv1YLmFfBO6yRCyP6DMfQ==
X-Received: by 2002:a05:6a20:d80d:b0:1d6:d2cb:1998 with SMTP id adf61e73a8af0-1d6dfa3fc6dmr21913578637.22.1728393582749;
        Tue, 08 Oct 2024 06:19:42 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccf01dsm6112019b3a.70.2024.10.08.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:19:42 -0700 (PDT)
Date: Tue, 8 Oct 2024 21:19:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, peff@peff.net, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] object-name: don't allow @ as a branch name
Message-ID: <ZwUxdz_HobRGF9yq@ArchLinux>
References: <cover.1728331771.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1728331771.git.code@khaugsbakk.name>

On Mon, Oct 07, 2024 at 10:15:16PM +0200, Kristoffer Haugsbakk wrote:

[snip]

>   §2 Disallow `HEAD` as a branch name
> 
> This was done later in 2017:
> 
> https://lore.kernel.org/git/20171114114259.8937-1-kaartic.sivaraam@gmail.com/
> 
>   §2 `refs/heads/@` is apparently disallowed by git-refs(1)
> 
> See `t/t1508-at-combinations.sh`:
> 
> ```
> error: refs/heads/@: badRefName: invalid refname format
> ```
> 

It's true that using "git refs verify" will report "refs/heads/@" is a
bad refname.

From the man page of the "git-check-ref-format(1)", it is clear that

    9. They cannot be the single character @.

Because I am interesting in this patch which is highly relevant with my
recent work, so I try somethings here and find some interesting results
as below shows.

    $ git check-ref-format refs/heads/@
    $ echo $? # will be 0
    # git check-ref-format --allow-onelevel @
    # echo $? # will be 1

The reason why "git refs verify" will report this error is that in the
code implementation, I have to iterate every file in the filesystem. So
it's convenient for me to do the following:

    if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
        ret = fsck_report(...);
    }

Because I specify "REFNAME_ALLOW_ONELEVEL" here, so it will follow the
"git check-ref-format --allow-onelevel" command thus reporting an error
to the user.

I am curious why "git check-ref-format refs/heads/@" will succeed, so I
try to use "git symbolic-ref" and "git update-ref" to verify to test the
behavior.

    $ git symbolic-ref refs/heads/@ refs/heads/master
    error: cannot lock ref 'refs/heads/@': unable to resolve reference 'refs/heads/@': reference broken
    $ git update-ref refs/heads/@ refs/heads/master
    fatal: update_ref failed for ref 'refs/heads/@': cannot lock ref 'refs/heads/@': unable to resolve reference 'refs/heads/@': reference broken

So, we are not consistent here. I guess the reason why "git
check-ref-format refs/heads/@" will succeed is that we allow user create
this kind of branch.

If we decide to not allow user to create such refs. We should also
change the behavior of the "check_refname_format" function. (I am not
familiar with the internal implementation, this is my guess)

Thanks,
Jialuo
