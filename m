Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128514A82
	for <git@vger.kernel.org>; Thu, 23 May 2024 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496927; cv=none; b=BG/y2rNU9un/pbxp+ln6Vff8wFz+5YrzOwlSeHHA0Y0vhYI8UxxyBhpe8ubb9+j/zSaKXcG37bSpvby3zXL1qnEGDjnrtvLi3CrpFm4e7QD862VX5WH0Jw0ljQU3xPpSMaOSxB46/EJUR+AFWlnORqiKM5vCK/7NmRn/B1DLJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496927; c=relaxed/simple;
	bh=NLzU40pYANf/hJ3xrrbeiZ/fbUywzjwLwWEmBZjrL7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp9RLPdyzltfGSwvaoYlQKbkSAdesSgm+HamxUZyDuoNrgss1odO3sE1rd2Q9OqLIerxnL++Ny8lIDZ0Fuj+GjmPvJqRef2IrirMWQ5KZa1OL4W1LbeAp734YPkK4Zk3qT8WiRLYvmh9nxqBXqtKhmAkRdB805Yf2AoApFUnPz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Xq1CEHoN; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Xq1CEHoN"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7948b50225bso215807585a.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716496925; x=1717101725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7dImJFRQvHVNPYOyZkbAJpx6oB/5jhJniRcq1Opx3DY=;
        b=Xq1CEHoNUZ1Qy2wsnwYX/7Aknz2LcGOVYVlK9R9S99AMRA3jGxJL2VGibyl1imvwBw
         s3i/BNu2F00rVwIq9B8HmQfOdXDGnM5AVqi8cnT3ZgQJ9w7hl3qeg1WMN/6ts6+hzarH
         uVZ0H36jF7OeUXnmZFCHCokLoMOO2VBZAcvDYxdc82CCaQIo50kBVzKnoeeN67e/HYbB
         +LHYnZFt7D8gGtIrT1A4VCGv6O3nPUWLt0474JIOKcgxsDD3eZnoD75RV7ySIBB0YKlZ
         pVxxyeR1DLjroViqpXL3dSLBfZ9sFC9KW5WdFAks65B2z1WfK+LWjWC6r2M2gAUhTF2F
         51Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716496925; x=1717101725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dImJFRQvHVNPYOyZkbAJpx6oB/5jhJniRcq1Opx3DY=;
        b=UBK5bkSHQy27odjeh9ueQG9YotX9NwEDUjHFNjBt/0maMaVehmyhYXWoifoJttQ9J4
         yR+Jfxwu9a8BDOaZo2RHZmFjlevbQEg/I69swiRhKO1rFBptHYFdel2ch2G30wvm4dyx
         VXL3IDPt6nT3f2VB6o3lSobD3Hww8wMUFSAg9IJiL4qsVlJqAXoVAmiAXDo6vcpb+ptA
         BhZrLOkdTnJJI5sLvI7L42FM/bn95crRBQDonG++vmNhi284foTB820UaNQWb72o0JVL
         DI4VCgzYiwZ0TJ7j7Mkau6iD5RkTtPbDXO/Yz591xNnLWhaA+sXLMIe1V6Nj0mNohN1H
         2y9g==
X-Gm-Message-State: AOJu0YxvwgY5a17tsqR5lrWvr9A20Bzcn0iOVWFr6s6LknTdzN8xVmqz
	Gkax+kRHaUrIOrGPnSabxEi0QerhafKvSffgCM0QZlDPu2dLmuhDRqaa9rN98fg=
X-Google-Smtp-Source: AGHT+IH4BxLtYYU27CluCu09pXBoyO+om07EOuI6ysi4cey2DJzp9ZUsC54r2LXTmcCZrzYdnS0oHQ==
X-Received: by 2002:a05:620a:47e0:b0:794:9ab7:7ef9 with SMTP id af79cd13be357-794ab080695mr32059685a.20.1716496925098;
        Thu, 23 May 2024 13:42:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca7f99sm214785a.9.2024.05.23.13.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 13:42:04 -0700 (PDT)
Date: Thu, 23 May 2024 16:42:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/30] pack-bitmap: pseudo-merge reachability bitmaps
Message-ID: <Zk+qG4INyrqPL5SN@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <20240523110532.GA1326297@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523110532.GA1326297@coredump.intra.peff.net>

On Thu, May 23, 2024 at 07:05:32AM -0400, Jeff King wrote:
> On Tue, May 21, 2024 at 03:01:38PM -0400, Taylor Blau wrote:
>
> > Here is another reroll my topic to introduce pseudo-merge bitmaps.
>
> OK, I got through the whole thing. I left a few small comments, but
> mostly just observations. Overall, the shape of it looks pretty good.
> The much bigger question to me is: does it work?

Thanks for working through this series, I appreciate you taking a close
look, especially since it's on the longer end.

> The perf results you showed at the end are underwhelming, but I think
> that's mostly because it's not an interesting repository. I think it
> would be nice to see at least some point-in-time benchmarks on a
> single repository.

I'd say it's mostly because I misspelt "pseudo" as "psuedo", but either
way ;-).

> I know you don't have those answers yet, and I know there's some
> chicken-and-egg with getting this integrated so that you can start to
> explore that. So I mostly reviewed this with an eye towards:
>
>   - does the idea make sense (I think it does, but I'm kind of biased)
>
>   - are the patches going to hurt anybody who isn't using the new
>     feature (I think the answer is no)
>
>   - does the on-disk representation seem right, since that is hard to
>     change later (I didn't see any issues)
>
>   - does the implementation look clean and plausibly correct (yes, but
>     what I'm getting at is that I didn't pore over all of the new code
>     with a microscope. Mostly I think the proof is in the pudding that
>     it provides the same correct answers more quickly).
>
> So to my eyes it looks good to move forward and let people start playing
> with it. The big "experimental" warning in the config is good. Maybe
> we'd want want in gitpacking(7), too?

I think adding a matching warning in gitpacking(7) is a good idea. Your
feeling matches my own here that the burden of this series on those not
using pseudo-merge bitmaps is negligible, and that this unblocks those
who want to move forward with testing this out in the wild on doing so.

I'll send a v4 shortly with the minor changes that I picked up from your
last read-through, and then I think we are good to go here.

Thanks,
Taylor
