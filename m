Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E122421D
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361634; cv=none; b=Xwx03G6bjVu7SSPSPfEUw1O6j4WmQr4w78+LLOs6Q8S4MIdT707rPrT4iyfZXakQq947qmz6M95jH0Q4Y9KVIwmADyK8bSef6kFEa6yxbYv4GZEaL6ee+ivnjoi4Z7R4LPw3rF9pVENkw0ziPnpQjq0ekCUUAzBw+K0LFtRcyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361634; c=relaxed/simple;
	bh=bsxoJJlS3LROY+ZtfoX3UrpgdH/kyRS/P0ha9TsUfn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjB4lT46CPh0Mn1Dq8raXb+NO9RhZWCtvt3s8/Rciuan/sC+h4rpYWuzoLP79ZeVwQFmwDjLeHEUzPdS5XWFqHAIz7SmrfVTUIMtyu6Iv2Bloi4ZHxbOrtseS5MQNQozFZ7oXnpSzgUKk2u0ObcyD/a4tKvuBVo3nJKqh4vnDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEau0YLv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEau0YLv"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40ed3101ce3so26114055e9.2
        for <git@vger.kernel.org>; Sat, 27 Jan 2024 05:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706361630; x=1706966430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lPdARefScNGPvGJFSvNl4hO/i8Nx6mp37TB/3jNBZI=;
        b=QEau0YLvSwHpNCY2aWo8Q2MH5eT0Ol6NeJTQ74cE7aHU4CVVAd72C2YxwLkpSui9oi
         PVa7eajBo4aCq15/CJQv54oO6y60EjYh3pO5BeLUc4CibgETn2A/60VAvzeLhwyQpTq3
         KfnhWvzhdH2SX+nzmVyRV0YU8O2JWxhQEvljYN06f2SVgU0R+kgs7pc3TL18DdVTkJ7F
         mkjuGfnFAM1c/XHv4HRDi7NZoDz27aPI1t+2LjYQZaN2twimGAIrJrAADx2t1TAfd224
         Ub7/WH/XoNC7P0J0vLCQ0Sx6xuZlZyLqC35yv1Pq8XkEQJz7SHWJXeuRzbjMVTMNaeCb
         almg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706361630; x=1706966430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lPdARefScNGPvGJFSvNl4hO/i8Nx6mp37TB/3jNBZI=;
        b=DVWzdAfnv+RX5Ei9zJhPNoestfqUhvbIPyq94tUQwneMzR487FFwMtKZtkB2ToUCCh
         yoxrF2N6u2z+qxrCwOBE37ctuOXZ8Q/20gn68yXXaIZFaGpcuH8KBtmo/cutRZnukHBR
         LDlfd7fFPvuYSvobuNbhzj0C6ufnSuA1yWLsVn3tkpq8CDoAnRMII8WZsqx/9BJdIyr5
         pNQnaUFkU14FgtSsNHsowUvlilWwRkfYIb4fU0aAroD9S6X37ZaR4QrUIuXgrTX002rW
         cFrq9nPh8BMdkUSfh83/zL3OPJXf3i4LT9iGbUMK0X737yamfswwfe8+G7E09hzCLGcm
         V1zQ==
X-Gm-Message-State: AOJu0Yz1f4nbUfj4skyhBbDNzYOzJZTRkXYVj9dem3r4pg2QuG9+qv58
	Ng0f28V8L+1sdsw5obW0VaW8yvP69CnBDyin18omJJSYadc6g420jKZBJxRL
X-Google-Smtp-Source: AGHT+IE5TCxW/JDqgCxMoxlD/4NlX2eCn7GuItx9qnZJ5NV4FFjRbgvO2i69NXtDfTJBkpcY/SYOLQ==
X-Received: by 2002:a05:600c:1c23:b0:40d:6293:fc69 with SMTP id j35-20020a05600c1c2300b0040d6293fc69mr1046556wms.28.1706361630441;
        Sat, 27 Jan 2024 05:20:30 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id bd25-20020a05600c1f1900b0040ee0abd8f1sm4020800wmb.21.2024.01.27.05.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 05:20:29 -0800 (PST)
Message-ID: <c49d1df1-13ca-449e-a826-94be84953ece@gmail.com>
Date: Sat, 27 Jan 2024 14:20:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] completion: introduce __git_find_subcommand
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
 <221f88b9-fc91-479f-8d08-f530796e2d13@gmail.com> <xmqqh6j0ngsb.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqh6j0ngsb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26-ene-2024 09:30:44, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > Let's have a function to get the current subcommand when completing
> > commands that follow the syntax:
> >
> >     git <command> <subcommand>
> >
> > As a convenience, let's allow an optional "default subcommand" to be
> > returned if none is found.
> >
> > Signed-off-by: Rubén Justo <rjusto@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 916e137021..5f2e904b56 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -575,6 +575,26 @@ __gitcomp_subcommand ()
> >  	fi
> >  }
> >  
> > +# Find the current subcommand for commands that follow the syntax:
> > +#
> > +#    git <command> <subcommand>
> > +#
> > +# 1: List of possible subcommands.
> > +# 2: Optional subcommand to return when none is found.
> > +__git_find_subcommand ()
> > +{
> > +	local subcommand subcommands="$1" default_subcommand="$2"
> 
> Are the callers expected to form "$1" by concatenating known tokens
> with a space?
> 
> I am just wondering if we can avoid looping, e.g.
> 
> 	local nextword=${words[__git_cmd_idx+1]}
> 	case " $subcommands " in
> 	*" $nextword "*)
> 		echo "$nextword"
> 		return
> 		;;
> 	esac
> 

I like the idea; and it works:

     $ words=("a" "b"); __git_cmd_idx=0; __git_find_subcommand "a b" "test"
     b

     $ : simulate that the user moves the cursor backwards
     $ words=("a" "" "b"); __git_cmd_idx=0; __git_find_subcommand "a b" "test"
     test

     $ : simulate that the user moves the cursor backwards
     $ words=("a" " " "b"); __git_cmd_idx=0; __git_find_subcommand "a b" "test"
     test

But functions like __git_find_on_cmdline or __git-find_last_on_cmdline
are already iterating.  I feel we should keep the loop.

Thank you.
