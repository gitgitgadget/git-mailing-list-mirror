Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D117B4F7
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497519; cv=none; b=q5fStf7GmT793rigVhnGCgpcFX5yhTjeJSbwqrQSSWpXcC/5xrnYWLarNud3rm99rYBNvxoG7uLzoQ9VPSCEot3k3578RW+p/AoEq+HXEso+SxAeyMooLxf6ZHSyCcNTAoJK1vZbl9edga/2FE1pyXF0vAh0d88i38pFKgnwSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497519; c=relaxed/simple;
	bh=rMXaNuSLfFWuVMBLs+8xyEoMUL6Jn8FKeXvSXSYej0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KitIE+Y+8e+u65SxPA3AytAAH8M8DG9gF/FG47GhH2sU3bHYpMXifk6BLKqJ+bvvdjn/5F8PFvIc+ALIm93Rnr/1yZG8UHDVi3Rk/VBb273fVMWBhthUCe9lvHpNsebHk/RWUllcl/h2iYae4rS/HNZkk5bTNnExFyQBBGUVJvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkZRKYG+; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkZRKYG+"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c730f599abso3493476b6e.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714497516; x=1715102316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LmMzsebqq3omaWATWOcwGAxT8x6eI9P0SI6pwCsnQM=;
        b=bkZRKYG+BTuRNH58zDA1P28+UNKPl1bS812v5EScfKT3xGUASEot9uPOT7TrC1kRWM
         DGtkKdz8WXX8xYwXSwhlP8bSUiuqA/Kl+EOeWP5RszRdE5gFCpzWXjRXsLRPlNGmoqRb
         YbKXARb5cCbNFp+obcO0v9tTsWWufb62PEydCezglpwW/Ad/t2pAi0bprviTsuvIFCLs
         uk6wx6e1k9fZ+vBqwwbY7eKKxiMfP/FUKflYKmY7ZUj4JEQG4OpTmfjIZ6W26PKjxA16
         F19KWTQW+5znv5Eb4zSnIFSFCMaEt7lzvFpk3glFWnK1mpR0dwWvxYiXV/AxeyXRejl+
         D31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714497516; x=1715102316;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LmMzsebqq3omaWATWOcwGAxT8x6eI9P0SI6pwCsnQM=;
        b=QueQxyDjGVXaulVKRrrRJpXD7NMmYXtapiyRRL8V2rOEjuEO5ilhQ4+4fURduAKBjo
         NYi7p5l5fYJLaIoDT+g1f+u6oWBctrzPh4zmp6wOiHjzpEOqMBvGCS+EPzA746eunBRi
         hfKW66bXW55SypSsyfCtNi0K4Ebaxo9UESmJT5siudFjQeyzK/R8g4d3NOqx5Bnx+wX7
         ROIxck56TbiAAVHVkHHvDzkLkYbGott9PVjikZ4/dHmI7uleY6xvOSY8VAkx41LTITZt
         GHEii0K78j8bOJW/yxcabFElAAPRwXDzNtVQfzu10RKjghv52YYICbDl0MOHcp4ZesF6
         0awg==
X-Gm-Message-State: AOJu0YxGa3Qy/c6AX/kmikOXD/6mWDyYd1mmh+2AMPtlZCgJHMq9rIep
	Ho4ojKtmdMnEXTfzBJk/1jFhzZ8MzqKjDeud9sTmNL/1aeiqKAzM5doaoDBQ
X-Google-Smtp-Source: AGHT+IGmw+wDeha3mlWGvauWP8tbwNEUuMvGFhQ14tgQozakU9rmKGC+mlMf/S+hziNETo1f9ht7yA==
X-Received: by 2002:a05:6808:10d4:b0:3c8:531f:ca40 with SMTP id s20-20020a05680810d400b003c8531fca40mr330309ois.35.1714497516614;
        Tue, 30 Apr 2024 10:18:36 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id by5-20020a056808340500b003c8532a443asm1492854oib.58.2024.04.30.10.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:18:36 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:17:21 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Karthik Nayak <karthik.188@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] Documentation/glossary: redefine pseudorefs as
 special refs
Message-ID: <m5vhgv53zuwi3wp3g4nvh4biq567piqvyyapbzc6bw5kmnqedb@f5z77afgnubi>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
 <2489bb558543d66592fb0f3eb4d4696ba8e31fea.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2489bb558543d66592fb0f3eb4d4696ba8e31fea.1714479928.git.ps@pks.im>

On 24/04/30 02:26PM, Patrick Steinhardt wrote:
> Nowadays, Git knows about three different kinds of refs. As defined in
> gitglossary(7):
> 
>   - Regular refs that start with "refs/", like "refs/heads/main".
> 
>   - Pseudorefs, which live in the root directory. These must have
>     all-caps names and must be a file that start with an object hash.
>     Consequently, symbolic refs are not pseudorefs because they do not
>     start with an object hash.
> 
>   - Special refs, of which we only have "FETCH_HEAD" and "MERGE_HEAD".
> 
> This state is extremely confusing, and I would claim that most folks
> don't fully understand what is what here. The current definitions also
> have several problems:
> 
>   - Where does "HEAD" fit in? It's not a pseudoref because it can be
>     a symbolic ref. It's not a regular ref because it does not start
>     with "refs/". And it's not a special ref, either.
> 
>   - There is a strong overlap between pseudorefs and special refs. The
>     pseudoref section for example mentions "MERGE_HEAD", even though it
>     is a special ref. Is it thus both a pseudoref and a special ref?
> 
>   - Why do we even need to distinguish refs that live in the root from
>     other refs when they behave just like a regular ref anyway?
> 
> In other words, the current state is quite a mess and leads to wild
> inconsistencies without much of a good reason.
> 
> The original reason why pseudorefs were introduced is that there are
> some refs that sometimes behave like a ref, even though they aren't a
> ref. And we really only have two of these nowadads, namely "MERGE_HEAD"

s/nowadads/nowadays/

-Justin
