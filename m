Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0501FC0B
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754840513; cv=none; b=eJUyBLyzoyv9r29W8Rck4FMHxXYuCTxj2Ss7dOLfCIh8vEOQ276J608pEoJYTrDrNXIOhvRyh7KexzdFmVzUeyb/VBjPAV37hbbiqEGCA36BUl1aF5emTLYY931Gw36YFIErSoTU39CjsziUAB2JtvBJWhVndwDtpQX7J3FfDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754840513; c=relaxed/simple;
	bh=ucWlF81iApapVpkMt+WRW39HLon2zziaKKEXoJzvQJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgG9WlcgmG8MGNZH8I2Yngok7ZeEqeO66rztzO+3pK33cZP+BfH7bxy3sQ4YQlUlA5HFuvpKxp1dzwUimvboyAChfkY2YfzyP1o32aePPE91e4zawnoisZfBcq0P9NmdN6JSWghExD2VTFwcJPYLXKp1c8r92YMYCle/+R357GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5VlQeBU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5VlQeBU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-458b49c98a7so22617145e9.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754840510; x=1755445310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/K+pmnJSmnop5aivNgRmOFSIUHHh5S96G4lD3OogH/M=;
        b=J5VlQeBU2xLKuf5FknElbrYXZnPtxXb+3zbFrOWz4PQCD7YXTNqYH/ie4DofLEnBXJ
         +BIn2Mkk4mno7AHyMxeoImPgJwQUj8tWpWB6QTGTJa1MFetM9w7d45kA7hRLdB/atfky
         rDDSW5ZVas/pNZ5zHF+grk+EOPm7b7NgvkTXhH8OpQExK725Yrr13xC3aQ776UVCiA51
         2/CNVqk35srofQVCwZWuGK73XgbPA1rbjTaz6sQbO/qToAZiMoUxda94MsX+k2S5468+
         ghm/dfs4It/qHNIjf7lTZ7c6M/NXS8GyNIqLQ5AS4MKRegjm1pB5PswJkt2hpuV/7nlo
         sNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754840510; x=1755445310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/K+pmnJSmnop5aivNgRmOFSIUHHh5S96G4lD3OogH/M=;
        b=Gc7qXKtBQIlFYytEHYsm/NoqZ/qqaXq3//afj9qXfmz/yeapCykMGQFkLMvfw23FLS
         vWb8sFrBplBrO88yzvBbR+7GTBjhU0j+S0BvoGu7bIQCbpHlzvROwEY0WyXZknIYPC2G
         HbJA9Yx0gk/vAiofV6HELCxPbjOXc39Gtn6nWJwefe7akjfrq15w6Fj/H2XqQZDhZdb4
         pT5HXJuF8Jj+4QkhU3wwkBomTU1J9HBU1dXxo0PDV9DfNun43jtol829CZLBM+1qye3n
         VCo881zjd9ULqqBJbukJvr0xnKxNxT9Hila83hlvKjXEA45BqpN60DLbfQQelrxo0w1L
         h9JA==
X-Forwarded-Encrypted: i=1; AJvYcCXlhHuKyUZcUhQB7US/jQmM2nhS7VEVEk0nUHUVSskld7evDVwarxyCRsi3rYdvmYs6B8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu0rxNeoEabKftXPabliSa+KC+WUOqyv1LyyI1nEhm9rdnQV8L
	fT/S/93fiGJ86QkqYgU+yhn/9fF7JsJ85xTnjxyXHySKOBHPWBOcLAjQuoglcQ==
X-Gm-Gg: ASbGnctTXX6P7JLu59goEb+j3MiJZbgm/WXceFgKk7UNbRPsc+pXtNj+sHR39k8joXu
	u3Zj6XQnQb2D9KRNNcctq6jHZVFhj+7hPxJ5hNAkim2d/O/H7nRANQl68jN2NxxFmIYmO7zNzep
	R5UDXFayB3WyOvHoFhHvrVcmq9jEMk7EX/+bHUvozfzrgVNKHywi46PRt3pw+BjpaaJzcpZUB43
	zUFk3wKLW/ScIhNrbmD7wf9z6F6xQvK/EEIKMZXmhYu20CPgV/1tRF+LsHBffNpihy/W/0QiTuI
	cDB4GaI4sbZf0drGni6mI6hjoKWPFpCzks3tNjgqDfOrdeNjKKBC7G0kpCRk7mLdZvrVcrtw3VH
	tNejVDAFPFrrmxbjFBtpDJsyLVUArHrXIyPRegVwwx2Ln4Ha9rTgW4/OfmLHV3BtvoVtcHWPC7c
	FAMOUkvupg+vM=
X-Google-Smtp-Source: AGHT+IFU6uQ5o2CRX2287LiWyHnzVpBROpVl7gSHfPzJUWZoONWHERrjau83VUbZRsCbG5EzXtZ2kg==
X-Received: by 2002:a05:600c:19ca:b0:456:285b:db24 with SMTP id 5b1f17b1804b1-459f4fa7bf9mr71722895e9.28.1754840509945;
        Sun, 10 Aug 2025 08:41:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc7e1ddesm302302305e9.27.2025.08.10.08.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 08:41:49 -0700 (PDT)
Message-ID: <38293aee-9055-4527-a511-1afa87289fb2@gmail.com>
Date: Sun, 10 Aug 2025 16:41:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/5] doc: git-rebase: start with an example
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
 <07a4bdb7ce5eb456bd81972c350d0c4f298ebd46.1754702057.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <07a4bdb7ce5eb456bd81972c350d0c4f298ebd46.1754702057.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Julia

On 09/08/2025 02:14, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
> 
> Start with an example that mirrors the example in the `git-merge` man
> page, to make it easier for folks to understand the difference between a
> rebase and a merge.

This is a very welcome improvement which makes it clear what rebasing a 
branch does. There are other important uses of rebase such as 
rearranging commits and squashing fixup commits that it would be nice to 
mention early on in the man page as well. Those do not necessarily 
change the base of the branch. I wonder if we could add a sentence about 
that which links to the INTERACTIVE MODE section.

Thanks

Phillip

> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>   Documentation/git-rebase.adoc | 49 ++++++++++++++++-------------------
>   1 file changed, 23 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 956d3048f5a6..449f01fba560 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -16,6 +16,29 @@ SYNOPSIS
>   
>   DESCRIPTION
>   -----------
> +Transplant a series of commits onto a different starting point.
> +
> +For example, imagine that you have been working on the `topic` branch in this
> +history, and you want to "catch up" to the work done on the `master` branch.
> +
> +------------
> +          A---B---C topic
> +         /
> +    D---E---F---G master
> +------------
> +
> +You want to transplant the commits you made on `topic` since it diverged from
> +`master` (i.e. A, B, and C), on top of the current `master`.  You can do this
> +by running `git rebase master` while the `topic` branch is checked out.  If you
> +want to rebase `topic` while on another branch, `git rebase master topic` is a
> +shortcut for `git checkout topic && git rebase master`.
> +
> +------------
> +                  A'--B'--C' topic
> +                 /
> +    D---E---F---G master
> +------------
> +
>   If `<branch>` is specified, `git rebase` will perform an automatic
>   `git switch <branch>` before doing anything else.  Otherwise
>   it remains on the current branch.
> @@ -58,32 +81,6 @@ that caused the merge failure with `git rebase --skip`.  To check out the
>   original `<branch>` and remove the `.git/rebase-apply` working files, use
>   the command `git rebase --abort` instead.
>   
> -Assume the following history exists and the current branch is "topic":
> -
> -------------
> -          A---B---C topic
> -         /
> -    D---E---F---G master
> -------------
> -
> -From this point, the result of either of the following commands:
> -
> -
> -    git rebase master
> -    git rebase master topic
> -
> -would be:
> -
> -------------
> -                  A'--B'--C' topic
> -                 /
> -    D---E---F---G master
> -------------
> -
> -*NOTE:* The latter form is just a short-hand of `git checkout topic`
> -followed by `git rebase master`. When rebase exits `topic` will
> -remain the checked-out branch.
> -
>   If the upstream branch already contains a change you have made (e.g.,
>   because you mailed a patch which was applied upstream), then that commit
>   will be skipped and warnings will be issued (if the 'merge' backend is

