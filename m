Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138C206E96
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087696; cv=none; b=cxbF3SSCpMIT7ro7DwF05r2GGtu8uyrLkNjlCH1gMm0iX+oMnWI2agwgU9g0hoha0le0de4oPl5acMHRu0w2cWeFP4fLD/XrTiumsLf/hoPL3xuOYdqf8gQsbcoTs0oArB9qE2saREEqFkHFV4JqZPeF8uMgY6W0BymTUCZMORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087696; c=relaxed/simple;
	bh=WX0DmK3+KjsspRWSNkjimxL0s3jAVTj+DXq+LOTuXgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8XdNJXRHzYh8o5FYyDZPTCWKQBC9AW5tvMmdp3fQ8E87hlcLONIF3vITC77Kv+1lKa/FcYQXmsPFnCWwQ0WIbr9tYI9WPOpVZR7rLOOFk0KdU059BQA3/OjTxBbNlexxrPL00AP6yciY9w+FFzm7stuyUKm9H8HBIwoqw98B5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvtn5xqV; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvtn5xqV"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71807ad76a8so1503343a34.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 09:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731087693; x=1731692493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ji00uEg95SBjx+cFJKTwj4m8osI3t6a2oobcWMBsxZc=;
        b=Qvtn5xqVxC3dUu70FmLpzenULQK8T+xM9X9t80aEq+f4NxdpzjnE08aaJdZ5aBfTsJ
         pgEa/StceNVNd1YAE0oFCsY46lQCAi9DsB33Zupk4S9EO//w/YSKQyNzxX8Pcy0rHBOe
         SFAPlXOgcmV8L0nUW5MZ5eCM7u02+T8OPLpSIN8cMhtG+p99jEoqFkGrwGkiTvt0woyq
         6fvgu/JodY++93gl7FS/r6JBXgtrmPoGtHnSXocIZzmpQBM91pgtZAj1M4fIFKQEBtp7
         sEfYQ8SVuvuXeIAMzPPOi7u5+G2cUe9VdXX1bAMShBqbvB75ZOERJofOAvGIuterui1T
         ClJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087693; x=1731692493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji00uEg95SBjx+cFJKTwj4m8osI3t6a2oobcWMBsxZc=;
        b=CTMrLd/kTeC6m64N30Cg55bef/OZXfiyxvFraPH/6xRNNe5n1EkfkbEigeUI9jMpVT
         i60SZevCDN0/rTrRjzOGgmUbg6S+sB8DJIj5NbA1nCCZsHWdSkQ05dMeJEOhdszQ2a/A
         CIULtijP7wYvxdZfChm25pCbivlLNlH8c8XQ2zieRCFyfg+eWHWYbQ3xjAO68OUiuNOO
         TBCVPfd55gvEtfafBrazqqAOoJqWxTLo+Y/s8Cw3SCHrUjdKR2SAQ45rO2jDDxHSiIBD
         MBVMoEmyMQr0e/QBWCmgDV19tXo/PScdbPR0dAkMYmIB36+sj1BadBplYhGzuvE+79Pc
         fpPw==
X-Gm-Message-State: AOJu0YzGe5CDGxr7qJk7jjPlNxzqzw/WXx33FEN25cSwAQuoEJQTOxmi
	arY2fxPv8eQTtoI1bZn77W1KRdmqAVrNX7AM6Dh4Wi1LjnbdmMkU
X-Google-Smtp-Source: AGHT+IEFZqlkPYrCjVKEWFAxdHxUzVEJQ/vYsKRpUicF9okUiuLMUIDCMi18EMrjs8Of62Nj+UNPAw==
X-Received: by 2002:a05:6830:4907:b0:718:4198:f7ea with SMTP id 46e09a7af769-71a1c267370mr4676933a34.23.1731087692930;
        Fri, 08 Nov 2024 09:41:32 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a10838115sm825990a34.38.2024.11.08.09.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:41:32 -0800 (PST)
Date: Fri, 8 Nov 2024 11:39:50 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] reftable: stop using Git subsystems
Message-ID: <23i62zyglnqknm4qf2lxmdcthrhhg5vsptfqohtmp327mrwsji@h2tutjzrl6jh>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731047193.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731047193.git.ps@pks.im>

On 24/11/08 09:17AM, Patrick Steinhardt wrote:
> Hi,
> 
> this is the second version of my patch series that continues to detangle
> the reftable library from the Git codebase.
> 
> Changes compared to v1:
> 
>   - Fix a commit message typo.
> 
>   - Document the values of the newly introduced reftable format IDs.
> 
>   - Include "reftable-basics.h" instead of "basics.h".
> 
>   - Adapt `stack_fsync()` to take write options as input instead of the
>     whole stack.
> 
> Thanks!
> 
> Patrick

I've reviewed the range-diff and this version looks good to me. :)

-Justin
