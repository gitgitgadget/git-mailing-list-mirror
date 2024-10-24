Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B21F4724
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788894; cv=none; b=DSpX44VINj5cLl/U3uqvGrIJuwo7Q0KLUicVrv/fAIUa9dLXk8dxKbavPnDNvOQKQYk0Rxr3uvO3THchs5HlIaWHCnsfKme6zW85/A6pwHgVOWAA5+ElhPNXgA4XYBJsJPoTbn3PVlGmlq+w9gcQJqp2+HIZ885P7sLU/PyXmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788894; c=relaxed/simple;
	bh=wyX83y0H4FN0YtL4mDzHnxOJNfTcwpagQL84z6rpZX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7plMdOYJp3A7jXP3luNFu25GU7KKRhu2abOh0ABnrC22J6YPruwPMH0fkPTDvTaCFgfxqvkgkjBkga81GNNhOln3QGDE5HpunnlR5Zsn0AhK+esuzuzd6fhqmvPvRIOoayIe7Yv3b1iC11PQ0TA+oEv0fTRd1o/WUsk2XieJDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iBPPEkxC; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iBPPEkxC"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e3d97b8274so11220237b3.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729788891; x=1730393691; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wyX83y0H4FN0YtL4mDzHnxOJNfTcwpagQL84z6rpZX4=;
        b=iBPPEkxCXcZUe5wJiDVy6yRu+f/FZx7qACVSnNBN4rc1HcLqYXi9VTBZt01MjKZQ3/
         nEj0zwxUCOoma6q9MtkZXRzGZEwCtF3KtsLGMUSiiA+j1B3TCYYI6SeLu4tdzpJbejZC
         I8stqVJmivHBMKOLnO00cX7IKos0UjBLlrVsxW/sUhUQn8nkFjgyahuu0BAG0ZQSDysX
         3VMBhd6deeMJsmXIkyu5RtWl2w9lmKtmx5z5uho4vGGQZhEX8oL83/h1/0xAZSQpFYrL
         eGkYC0XoJn2UuYq7iFz2qsbs/5z/i8HtMcxCDDlUEMdS0RGcH4O0NG4aUxwnz8fykQYp
         GcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788891; x=1730393691;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyX83y0H4FN0YtL4mDzHnxOJNfTcwpagQL84z6rpZX4=;
        b=tVQaPMefqkSylGHJt+1ar7EfW+YU+OhV9uUj4ObhVvOxsxpGLLdWQkeCV/iZSB+4G5
         sB3wHohvBHzsi/NFmIyV1V1fRrLXbw4oRttmuVNtvXBq8NlGkEDZnfdEclf0O85R6pqq
         2y1NVJfKBjHwKXcNyZK0/bFJeDkI2LWBF1EzgN1h/QpDYCngBoy4gNK8AUPv/uS7i0G6
         j7NQ3yC81296tixCWu7pkhGAukdLHTWFHP3CBRrs/iSUMjb8piX0BxWwR6iozn2QMyLH
         W1spLrEtN8gE4mTJ0eRmLY1j/Tx+G5dLslpoREUB3Ern80pDpKdGzJBBBsfHiVEHKSnC
         UALw==
X-Gm-Message-State: AOJu0YxuMg00OERTunFkdT0DXhHwqWjI2jldpt7EQ1Jq6KBhmJNw2raZ
	BEbjMW1NqADa0LbxgSf/azljv8L6Pj/V7x/n0UjKP/Ry/wTAm4Mr9WZlA9pSy+M=
X-Google-Smtp-Source: AGHT+IG1aha4F+McdDfKmidc2++l3vFdgLJ0ZIO0qIrGQVFMkLXK5VJ0OZs/RxPPazvcuPzaCNf2Gg==
X-Received: by 2002:a05:690c:4509:b0:6e5:bb93:4326 with SMTP id 00721157ae682-6e7f0fdb1f8mr80365237b3.39.1729788890921;
        Thu, 24 Oct 2024 09:54:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a40551sm20482097b3.30.2024.10.24.09.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:54:50 -0700 (PDT)
Date: Thu, 24 Oct 2024 12:54:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [QUESTION] Can I merge --continue with --no-verify
Message-ID: <Zxp72aZ5U67pB4V7@nand.local>
References: <7038bb3a-2aad-4bde-bd46-f2bd2ef659d1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7038bb3a-2aad-4bde-bd46-f2bd2ef659d1@gmail.com>

On Thu, Oct 24, 2024 at 01:29:21PM +0530, Abhijeet Sonar wrote:
> I recently found myself wanting to continue a merge after resolving
> conflicts without having the pre-commit hook run:
>
> git merge --continue --no-verify
>
> this fails and prints usage.
>
> Digging the source, I can see that in builtin/merge.c:1378 we do:
>
>     if (continue_current_merge) {
>         [...]
>
>         if (orig_argc != 2)
>             usage_msg_opt(_("--continue expects no arguments"),   
>                   builtin_merge_usage, builtin_merge_options);
>
> I see why we would want this - the --continue flag makes the merge command
> perform an operation that is very different than what merge normally does
> without this option and therefore the usual options do not apply.

Yeah, this looks like a bug to me. I wondered if '--no-verify --continue'
would resolve the issue, but it won't, because we are comparing against
orig_argc, which will be 2 in either case.

I suspect that this dates back to bc40ce4de6 (merge: --no-verify to
bypass pre-merge-commit hook, 2019-08-07), likely as a result of
042e290da6 (merge: ensure '--abort' option takes no arguments,
2016-12-14), which came before it.

Probably we should update the logic here to work around the issue.

> However, I think it does make sense to allow --no-verify - it feels
> very intuitive to use it when bypassing the pre-commit hook is desired
> while continuing a merge.

Agreed.

Thanks,
Taylor
