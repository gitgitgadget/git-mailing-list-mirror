Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FCD5F541
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706973227; cv=none; b=hGUBLzMy8lwpjNuDOfYYQhwG/jr8YFfQdU6Cixr/kCWc4ssSq92HpgNX046eqcq+Sepu5doZtNhyfI1pEI9vLuj5B8FP5OVMMf2hs0GqAKNwNOE/sY32SQMAbqd6rw16EJFTAiSoJtCP9NqVLLL8JrLuzhVLWd3Iu2oy17gJE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706973227; c=relaxed/simple;
	bh=Kzb2SHT85obMAgxealmE7OSKWSqNA4ki+j16AUbGjgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jp+TqaT+OodZ9jywxdn1zpSNfjpwgmvfdWvguzNxYkffvIAAdkfQoHHh+toEkKARYr6rGl0B9tGBALD1LpF2qXiKXYdknXsRtF+xAEYDtKcL91Ug3/uE/jKhhITE++GZ7vLLckxeYKwUB8V3NCKGC/NlxdaewAIq6m7y4+yqnXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKISfa65; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKISfa65"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fc52c2ae4so15976235e9.3
        for <git@vger.kernel.org>; Sat, 03 Feb 2024 07:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706973223; x=1707578023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvxLzl/K8iWtvp/yrmTmhnGZdEfvRTADcdC0wuerV2U=;
        b=NKISfa65sA/vs9WDKHkyao1Ua/pR/9mjvMyxqc05oP7dhHxZujDkuv3NnvLQiRCZqH
         tRVSzDTzUS3U4o9tVSuW/p40ioTYT4C1UZ8YqGBRdridWR4B5KA1E7vKG94DDXeTPSSC
         JhaIU+KAGAQ7JL1CnYaDc6gOZ5NkfiqQkhYwYhGjw50i1OlZ5OVG2sqtQPa3xo62kKMY
         rR9jh0i/y64pvxY1/7G5hWUroGiVv7FD1o5Lj6rcH5EOdi8PxXM+SEjzDhN0cqXPr+sN
         +DJV6BmK8cComjKYbEa+26oL2vV7Zn6+2zI1SjuHW9va2IvKh+5pV9dbxzcB9/l0mKo+
         PZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706973223; x=1707578023;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvxLzl/K8iWtvp/yrmTmhnGZdEfvRTADcdC0wuerV2U=;
        b=cel8yhP52rXQijAjcyXjlxafOYnkY1OaXZOQKUiVvfJy/Nuk2UUaEhMVJlFIQm93wK
         kJW+1tE3CLzChxckIzknfyyWBsna5MYIKbvlyHCQjuiAgiIo4RXAcJF1vvGVnvmMh7hE
         bY7xLLzSyEIs+WGiuphtFKhsvY/uViljeADvZoFy5fmVMpGLWdmX+ueeLe1kwcXq/gFX
         Xdv2lJTzLPPVx9zURmPUlmqvgV3BIhaWRdYgqI2fRpKbWn07t/FwJLoF8Db9G3RgufBT
         HsIrh3DelZ4oZmu5j/CiaTjFKlvEIjzz31KIhkdtPUArTRN+zyuOlLOnI55LTaCDefay
         AJVQ==
X-Gm-Message-State: AOJu0YyJbFgVybcz+jfiWeyVfE2hSP4vw9a7YBBMlZ+B69QPfGFzI8A+
	AHVx8mNyseP6Mtxnk1xnSYTANVoGXYicbmxmSty0DGKlqIP0RHEImpwM9QQ5
X-Google-Smtp-Source: AGHT+IGqWLLQQycNZAa3odvdyE4CLnqo9m4Xmrj/e0/uaWEa8lwviQRtjTJc7fd3KJcA0dpt8ZTooA==
X-Received: by 2002:a7b:cd85:0:b0:40e:fa6b:f355 with SMTP id y5-20020a7bcd85000000b0040efa6bf355mr1206661wmj.41.1706973223380;
        Sat, 03 Feb 2024 07:13:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXS5U80vw0snrINp/fHoyx5YjxsDwVUmfA050bnS5JR4ACZW9DEXNFeya5j9CWxI1BOWeP2UqnQQnOuhjbkPFZ9bjBd
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b0040efb8f7158sm3166290wmo.15.2024.02.03.07.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 07:13:42 -0800 (PST)
Message-ID: <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
Date: Sat, 3 Feb 2024 16:13:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] completion: dir-type optargs for am, format-patch
Content-Language: en-US
To: Britton Leo Kerin <britton.kerin@gmail.com>, git@vger.kernel.org
References: <4714b88d-df5b-4e37-a5d7-af5033cfb861@smtp-relay.sendinblue.com>
 <20240109005303.444932-1-britton.kerin@gmail.com>
 <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08-ene-2024 15:53:03, Britton Leo Kerin wrote:
> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 37 ++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 185b47d802..2b2b6c9738 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1356,6 +1356,29 @@ __git_count_arguments ()
>  	printf "%d" $c
>  }
>  
> +# Complete actual dir (not pathspec), respecting any -C options.
> +#
> +# Usage: __git_complete_refs [<option>]...
> +# --cur=<word>: The current dir to be completed.  Defaults to the current word.
> +__git_complete_dir ()
> +{
> +	local cur_="$cur"
> +
> +	while test $# != 0; do
> +		case "$1" in
> +		--cur=*)	cur_="${1##--cur=}" ;;
> +		*)		return 1 ;;
> +		esac
> +		shift
> +	done
> +
> +        # This rev-parse invocation amounts to a pwd which respects -C options
> +	local context_dir=$(__git rev-parse --show-toplevel --show-prefix 2>/dev/null | paste -s -d '/' 2>/dev/null)
> +	[ -d "$context_dir" ] || return 1
> +
> +	COMPREPLY=$(cd "$context_dir" 2>/dev/null && compgen -d -- "$cur_")

This assignment is problematic.

First, COMPREPLY is expected to be an array.  Maybe a simple change can
do the trick:

-	COMPREPLY=$(cd "$context_dir" 2>/dev/null && compgen -d -- "$cur_")
+	COMPREPLY=( $(cd "$context_dir" 2>/dev/null && compgen -d -- "$cur_") )

But, what happens with directories that have SP's in its name?  We're
giving wrong options:

    $ mkdir one
    $ mkdir "one more dir"
    $ git am --directory=o<TAB><TAB>
    dir   more  one

Setting IFS can help us:

+       local IFS=$'\n'

Now we're returning correct options:

    $ mkdir one
    $ mkdir "one more dir"
    $ git am --directory=o<TAB><TAB>
    one       one more dir

Here, the user might be expecting directory names with a trailing '/',
as Bash do.  Again, a simple trick:

-	COMPREPLY=( $(cd "$context_dir" 2>/dev/null && compgen -d -- "$cur_") )
+	COMPREPLY=( $(cd "$context_dir" 2>/dev/null && compgen -d -S / -- "$cur_") )

Now looks better, IMO:

    $ git am --directory=o<TAB><TAB>
    one/      one more dir/

But, after all of this, we're going to provoke a problematic completion due
to the SP:

    $ mkdir "another one"
    $ git am --directory=anot<TAB><TAB>
    ...
    $ git am --directory=another one/

We should complete to:

    $ git am --directory=another\ one/

Here we need a less simple trick:

+       # use a hack to enable file mode in bash < 4
+       # compopt -o filenames +o nospace 2>/dev/null ||
+       compgen -f /non-existing-dir/ >/dev/null ||
+       true

Some commits you may find interesting:
fea16b47b6 (git-completion.bash: add support for path completion, 2013-01-11)
3ffa4df4b2 (completion: add hack to enable file mode in bash < 4, 2013-04-27)

Well, so far, so good?  I'm afraid, not:  What happens with other
special characters like quotes '"'?

I suggest you take a look at how we are already doing all of
considerations for other commands, like git-add.

> +}
> +
>  __git_whitespacelist="nowarn warn error error-all fix"
>  __git_patchformat="mbox stgit stgit-series hg mboxrd"
>  __git_showcurrentpatch="diff raw"
> @@ -1374,6 +1397,10 @@ _git_am ()
>  		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=}"
>  		return
>  		;;
> +	--directory=*)
> +		__git_complete_dir --cur="${cur##--directory=}"
> +		return
> +		;;
>  	--patch-format=*)
>  		__gitcomp "$__git_patchformat" "" "${cur##--patch-format=}"
>  		return
> @@ -1867,7 +1894,17 @@ __git_format_patch_extra_options="
>  
>  _git_format_patch ()
>  {
> +	case "$prev,$cur" in
> +	-o,*)
> +		__git_complete_dir
> +		return
> +		;;
> +	esac
>  	case "$cur" in
> +	--output-directory=*)
> +		__git_complete_dir --cur="${cur##--output-directory=}"
> +		return
> +		;;

Adding completion for these options, and possibly opening the way for
others, is a nice improvement.

Thank you for working on this.
