Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89B38B7CD
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791101248; cv=none; b=fSesQkpDdCuG5SVeWIW/epoX4FNgw4b9nDVD+srp7gHiv8rNorcrsqTndN5uVFHwFvoAKslrs1wM1QabJ6KbYgb8c/EMVJvQfYMnxb5oIsXnFGF+FBVUgPR3kit1CczVhx+gMsWVea/nAJofWJPEYn9EO3BXiUVnstg8Kkb9cd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791101248; c=relaxed/simple;
	bh=qP2X2rpUSOr9n8uZiEyJ1XSnMe4mYf2nSZVZAIK+T6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZqrdjL+rQCU0LzqJViFTAP2cqyUIHPw7ejb8QvmjEmyHBLor03eTwcbgTQASUYiHXYnudk+ijY8M7R5E5t+VqQu7hqoqEk4ARMd/6ybMoZjkdzDtYMKPGWf6cn0+A9A7pGyUmPY3bCQRWqCw4A9lp9IurNGQdGuFyCPKZM0pqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gm0HnMUG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gm0HnMUG"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2e43f3d1fdso117336466b.3
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 01:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791101245; x=1791706045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FPA/cvqFdziGec6xcpKI8miCWTzOIuIGTeGSQw2+DBE=;
        b=gm0HnMUG7rsvxg+iIHwutxOvmCrPK8Qhey2HKlBKNVVNFXo351VftinUvQXdeFkhdp
         bg5e9yed5PeswArOCyF6WiptC/ZDR69cTCkv4B2n4hfOZHYe8poVgGMtFciBW/O5Lzie
         Knwa6lyyJNlsaldL6kTtZaAa6mS3E63mTKBGs4+JGsR0j9zaR3hJw2vXYsH/Q0M1kEj+
         C+OuVrgmoFWI8iA1jFCDXJ7wl4foQWycuYijr1b78HJDPfPdGrmbGiwLXJq3PDDvqygK
         +tDtWpQ6A6NKp/DFXEky+vRPde4m8vVXrgWN5E5pbmTuCzwS+tRw+mISpA7xkYW65NTd
         tmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791101245; x=1791706045;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPA/cvqFdziGec6xcpKI8miCWTzOIuIGTeGSQw2+DBE=;
        b=X4rp2kfcb9k4/JFEm1PkNYLXKQJ9ak/6cjK8urUZmygbBrL81Cq90UJEBio0oNyhW/
         gy22uUeqrvHlFhEftmA4+12SO9H5z1IeIwTBzEPpU2o/Ao+Rrt2tGFQC3RXVHceIsk3a
         1Myv7F4Y0Xv8fbnTn1WoAi6r7tN5QHdyLXHGEtGUpbeHIyTPM56UujhQYMNJjpaB0GOW
         cwei8Z9yVC+ESg5w2GrDYsobhp5jImmAe22lRMuU0ab0InY4iu0xdLtHS0Hw//QwFDK8
         +M+D2VSJj3AGiO6yLJL9/BodONl2ijeAuozvqzEMbggrLjqjoUy8sPeC1P0iOLgTsYWS
         UxXQ==
X-Gm-Message-State: AFuF++kbKwoI6HeyY87VmAJdCT9brjQ7SgbFJWUttlvIl+p2TliSb4aH
	Dlce4xPx0RU4Afe8+EZ+U0LONxA66CwG7X7ADZHOiPw8Tb3yZDfdKhGB
X-Gm-Gg: AYBFou3o+jlkJBDNcSnpYg1wmuoW+N7vV2lH0KtBGiT/ZQf8qnAmb1tHJgsTISWE7A5
	hp3sNPtIV9ByQusRWK8lV53Nw6e29JgVqDBa80NTep/sLKd5ou1njZDGtZlaXxG42S+DzbVB91b
	j6jRcef31LoN1HykExUHbbB6ctwn7NGsNI+HoGdylmnDxPf5VeqgvVbM/2nDVVW76jyhMlUDffR
	rPFjWwPW8/VMGgZ7mCogJrFCYkjo0v4vWXFo2/XaEtpXVmNCUvtsKf3/Sp1LP6t61OwiTq50SHm
	njcKPw6bAElckKtiWJGmeFiMSvkNsvwAZW563hp5SMHGGEFf2iaHkZxLNDhNK8tOfwhHsm9/hs8
	kTkGyDg9tVzcDXDmYTDOyPqhPfytdH/qAfqh52XHq/x/w5Q0lM1LTLCaMOsTi0KXD6UFvGE7ZRw
	bPmZGT28NJRvJ7ktqL95rK3WjkvNTgNNjZ1hJ6TrVAiMAp3TfB1hD2IX63UCvGo8uIShZ5p9+Ie
	GdvvBRtE9FnRfXfY1v8tbg=
X-Received: by 2002:a17:907:96aa:b0:c2e:32d3:1b5 with SMTP id a640c23a62f3a-c2e6ee214dbmr319209566b.32.1791101245280;
        Sun, 04 Oct 2026 01:07:25 -0700 (PDT)
Received: from localhost (94-21-29-91.pool.digikabel.hu. [94.21.29.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf86029sm284510066b.60.2026.10.04.01.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 01:07:24 -0700 (PDT)
Date: Sun, 4 Oct 2026 10:07:23 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Fionn via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Fionn <git@fionn.email>
Subject: Re: [PATCH] completion: exclude previous file arguments in Zsh
Message-ID: <asIJO3CZ/P/2L4qi@szeder.dev>
References: <pull.2216.git.git.1791026527023.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2216.git.git.1791026527023.gitgitgadget@gmail.com>

On Sat, Oct 03, 2026 at 11:22:06AM +0000, Fionn via GitGitGadget wrote:
> We can get this with minor changes, however. Here we introduce an array
> __git_file_exclude which we populate with existing arguments and then

"existing arguments" of what?

> tell compadd to exclude them, which closely matches the Zsh _git
> completion behaviour (as well as common programs such as rm).


> @@ -284,6 +284,8 @@ __git_zsh_main ()
>  
>  		(( $+opt_args[--help] )) && command='help'
>  
> +		__git_file_exclude=(${words[2,-1]:#${words[CURRENT]}})

I don't do Zsh, but that 2 as index looks suspicious.

What will be excluded in the following command line:

  git -C dir -C subdir -c foo.bar=baz add file1 file2 <TAB>

I think we should exclude only those arguments that come after the git
command, in this case after "add", i.e. "file1" and "file2", but I
suspect that everything starting with "dir" will get excluded.

> +
>  		words=( ${orig_words[@]} )
>  
>  		__git_zsh_bash_func $command
