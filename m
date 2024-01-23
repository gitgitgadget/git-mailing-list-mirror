Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554464A87
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027244; cv=none; b=p2Hho/AiC8I2QVlQFiobbw/fp7kaHENXVEPPQtjGQp94MnEWFyiXSIINUs6Vp4y78wIYBdMovaAwvg+yKfT4ofzn2nIJ9tR0bJwD/dhxEYGiEFUHGfZgvWUXeMwNlTx2hvUuOZ5Ok19ZUE2XOXhLGG1SUKj8J8fB1fhARUIUfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027244; c=relaxed/simple;
	bh=8ZstObQMqUzIQl9VMRhFzQkT3cC5thVrRVIznaV3YXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bfpAnZUoLmi1DyzK7/v6AwmYZDBg+SJilpjEFydswe0ZenzqQEdNjW+KQvTZAmh7fHzUs2SHMWVrb40TK46k+nlE0DOpRtetszv9qsgP1KsYaPRrA25ZMEMfS0IIxjPUktlC20YT4S2b378Y8rEAufWZye8pho5ctSTKfq6mGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfhedNhj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfhedNhj"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e490c2115so34199395e9.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706027241; x=1706632041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cDFq7sc4f9j2MH1VbnZgs77NOXB0/KASQMpf0pOUtl8=;
        b=UfhedNhjAZ6Jrp8ZZm1Y4FhIhS6AU6Qcw7eiA9lhQqvZEsTIczEPWaWyvxXJJQULRm
         mJSdwcs/9oZayO4X2nnr+lC5frCkKEQBZC2JmNkC8vPJ5tOWeuVmT4sBmWc+hym9OCHo
         nYNcbqzBvdAN4XIStO9aCoZOIfZGda4/W6wqlsWC1Nc0b2nuTtKZEFX7HtX//ZNjpLLL
         xGWV6jwHdXQydsTq3g7q+pGNiPA8mrZ+tf1vhHPaQv5LbFT71knvmUuJ4+RwnoISh9aB
         7Ccxvo+kScu71QjrNmTQVRF6JUMdQMywEMjUvrcY3UCkkwG3MosZxcJ+0ZoCgZYhjEnJ
         2rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706027241; x=1706632041;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDFq7sc4f9j2MH1VbnZgs77NOXB0/KASQMpf0pOUtl8=;
        b=aNqqgoxbmBBEcfeqOvtCF9gttstfSMpFSZvLAi2Ic9r5DqWS7eCI3IHPezOJHfSBE/
         j+FxDa9mICU5aCsuI/htKIdU1UMUnaDM+f35Sx2kr1iQenxqHcpot3FbZuCPscOJzsai
         m5NzbSA7Zm6EwSh/+eklQNXgJhhSe7QFxFNdJzMmhHw78JXmB9HD1VyVL10YMsJwxBI/
         ANpKZYmNKILqYwuuZkCcajfSH/O7Zc719xSwoLqMZe0NLU4ZXbu01VXpiXlcW4TDB5+m
         hVu/OC7cFQbFFCU3/lj8nEGYTNqsdDgTKtmzM5tEL9FOrTDh8Y+5g+8v6/o9JQ4jXO62
         AEgA==
X-Gm-Message-State: AOJu0YzLEjY7hYRdsO5/iv7kj+emt1thUzpyUumMqPBKapROZIhdU0Eh
	Qe0i07qHIetbvRpdpYHzJ+UEFqwIT367DNfKIinXusKZW2TppX2z/zmnKsAi
X-Google-Smtp-Source: AGHT+IFNFZeJo/rJObIcVW6wvQf8kTJPmw04fpzxjxfD354fVvUS0wn+D8qi+vURZNuBieAOGu668g==
X-Received: by 2002:a05:600c:2d03:b0:40e:b93f:c4e9 with SMTP id x3-20020a05600c2d0300b0040eb93fc4e9mr318076wmf.76.1706027240701;
        Tue, 23 Jan 2024 08:27:20 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b0040eaebc4e8fsm6658884wms.1.2024.01.23.08.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 08:27:20 -0800 (PST)
Message-ID: <4f60dd83-913d-4c66-989d-282ec1845f4b@gmail.com>
Date: Tue, 23 Jan 2024 16:27:20 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/7] Documentation: add "special refs" to the glossary
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1705659748.git.ps@pks.im>
 <2a0943a78d0db0f489962520536594845970e0b0.1705659748.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <2a0943a78d0db0f489962520536594845970e0b0.1705659748.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 19/01/2024 10:40, Patrick Steinhardt wrote:
> Add the "special refs" term to our glossary.

Related to this the glossary entry for pseudorefs says

         Pseudorefs are a class of files under `$GIT_DIR` which behave
         like refs for the purposes of rev-parse, but which are treated
         specially by git.  Pseudorefs both have names that are all-caps,
         and always start with a line consisting of a
         <<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
         pseudoref, because it is sometimes a symbolic ref.  They might
         optionally contain some additional data.  `MERGE_HEAD` and
         `CHERRY_PICK_HEAD` are examples.  Unlike
         <<def_per_worktree_ref,per-worktree refs>>, these files cannot
         be symbolic refs, and never have reflogs.  They also cannot be
         updated through the normal ref update machinery.  Instead,
         they are updated by directly writing to the files.  However,
         they can be read as if they were refs, so `git rev-parse
         MERGE_HEAD` will work.

which is very file-centric. We should probably update that as we're 
moving away from filesystem access except for special refs.

Best Wishes

Phillip

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   Documentation/glossary-content.txt | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index f7d98c11e3..d71b199955 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -638,6 +638,20 @@ The most notable example is `HEAD`.
>   	An <<def_object,object>> used to temporarily store the contents of a
>   	<<def_dirty,dirty>> working directory and the index for future reuse.
>   
> +[[def_special_ref]]special ref::
> +	A ref that has different semantics than normal refs. These refs can be
> +	accessed via normal Git commands but may not behave the same as a
> +	normal ref in some cases.
> ++
> +The following special refs are known to Git:
> +
> + - "`FETCH_HEAD`" is written by linkgit:git-fetch[1] or linkgit:git-pull[1]. It
> +   may refer to multiple object IDs. Each object ID is annotated with metadata
> +   indicating where it was fetched from and its fetch status.
> +
> + - "`MERGE_HEAD`" is written by linkgit:git-merge[1] when resolving merge
> +   conflicts. It contains all commit IDs which are being merged.
> +
>   [[def_submodule]]submodule::
>   	A <<def_repository,repository>> that holds the history of a
>   	separate project inside another repository (the latter of
