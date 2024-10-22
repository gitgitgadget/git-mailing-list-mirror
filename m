Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26D12F5B3
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623853; cv=none; b=iAolflIhu1x4gtTptV0mrHXeaXzqOat9rtTgF3z9JLT63quIXcOHweb8y/1UX3u9Easy554mZVBNW2SjZAIJcn+OUa18emQOYEQMQJO+HMlkkgp3K7ZEf//1oDSKGM0NDRN86L6q2KpKo3dLYP52RHz9VIoPRwhyDgFcG9acelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623853; c=relaxed/simple;
	bh=6EhF+pC/5oiQgyrK5TyK8YqeJM/Fbn9UrL3YOdakgHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy4PCrw4KCPjK96fcK5CvsJfq5Pb3J2QUxqoHMiFDruGOCiX6M/tVt3wOUdxMINLVDgUYSO9z1aeLMV5vQJGMtORR8gDkPK+hxoJn5luT5v6OJUpUR3csMF9Yjhil4pEdl/aX3lK+1a7wK2CMRv4rtlomN/xnEUvfmuMBmtkFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kp8rA2BH; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kp8rA2BH"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e3d7e6f832so57917547b3.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729623850; x=1730228650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFX/1q6j/73WQzBNwI+489EFhZEz8pjrxfe4erCwUb4=;
        b=kp8rA2BHpha3aL/Yfm7vFGo+6sMcclkDD84gelfHy4q7j9w/TRp9WB2iXN7y8Wf9SM
         scpM+yVYMcHfYoFX3EEmb6WVjI3nvMsouOhQcxKHUUN73BtRG/azqr8BbQdWy/cah4pk
         BEAP6kJgGiAlpBOYPplpCLHduFqb6hukGp3jOQjjPZ26EM7o8zIhhQEZ0S9R9Y6ceyEV
         VLcLdoMOvaaG0iJniXojQBI2/R8KHmTIXJKZQ1VlokjO51N5YC1I3OwzMeHiaY+n+T36
         acaxxj8N/tATsLrN8IgOIz78+laJ+xpXSaNWCKEEzBHq6dM76cCXeksAZmmuDyZqbb2k
         5dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623850; x=1730228650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFX/1q6j/73WQzBNwI+489EFhZEz8pjrxfe4erCwUb4=;
        b=adq+wW+ZEzeI/hMfMjNkfvmkv3bI3wEwHpM5RnJ2eUmJW2VIVWh8qhEv60jaj/NvSE
         2hoAK4MXqDkZ//UKWJOd1zZnyLxzhKLmdzAGXPCzPPQ2UnxNTLb7F4sBch8fGJwhkb6B
         8Zk5o4lIK/gG3Szke0yOm5Lsj+d3DfqbKCsjvexZg+4aPZ0WJ092qSWXEQ1WDUJzy1e/
         4MrBtT0ULKUbTmTuZjjSrAblOd4oLUxNeejOqFf/lBIaer6zkJo2bvhgw4ZnhEHV6lPW
         xi0G2XUvJNSmzUsTkfjXrKBjrHKk3I6Qhx8LISUX2XGgRqy+Tzs2gKYpmLlos4yleEKR
         nSyQ==
X-Gm-Message-State: AOJu0Yzax3iLIUyo+QID986JhXFxS22RAfKCgi7yuermcte56LPC+e1X
	Td6fbU9Jkb/VIGkxtwiTUcm2xC+n7m7R9Blv7VcDOqRKR0HG5t6rHnTVkMP+4mVQQ1B1hBuLWxA
	umADcfw==
X-Google-Smtp-Source: AGHT+IG+8HZVWyRGlQUJwAgV89KPpFmyyQl525ysXZNmcSyXmJ3dZ1BOH0tSSlDjGdne+34aMqarMA==
X-Received: by 2002:a05:690c:660a:b0:6e5:e6e8:d535 with SMTP id 00721157ae682-6e7f0db8deamr337567b3.3.1729623850623;
        Tue, 22 Oct 2024 12:04:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb5cesm11994447b3.85.2024.10.22.12.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:04:10 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:04:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?RsWRdsOhcm9zaSBWw616bcWxdmVrIFpydC4=?= <noreply@vizmuvek.hu>
Subject: Re: [PATCH v10 0/8] set-head/fetch remote/HEAD updates
Message-ID: <Zxf3JBz0u+ZF90tb@nand.local>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
 <20241021134354.705636-1-bence@ferdinandy.com>
 <ZxfjWnZF4EbtVH12@nand.local>
 <D52JTXM32QOS.16IVFGPEJ4AKN@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D52JTXM32QOS.16IVFGPEJ4AKN@ferdinandy.com>

On Tue, Oct 22, 2024 at 08:33:28PM +0200, Bence Ferdinandy wrote:
>
> On Tue Oct 22, 2024 at 19:39, Taylor Blau <me@ttaylorr.com> wrote:
> > On Mon, Oct 21, 2024 at 03:36:57PM +0200, Bence Ferdinandy wrote:
> >> Bence Ferdinandy (8):
> >>   t/t5505-remote: set default branch to main
> >>   refs: atomically record overwritten ref in update_symref
> >>   remote set-head: refactor for readability
> >>   remote set-head: better output for --auto
> >>   refs: add TRANSACTION_CREATE_EXISTS error
> >>   refs: add create_only option to refs_update_symref_extended
> >>   fetch: set remote/HEAD if it does not exist
> >>   fetch set_head: handle mirrored bare repositories
> >
> > After applying this topic to 'seen', I noticed some new CI breakage that
> > appears to be caused by this topic:
> >
> >     https://github.com/git/git/actions/runs/11449483611/job/31855171514#step:4:2506
> >
> > After dropping the topic locally and building with 'make SANITIZE=leak'
> > and then running t0410-partial-clone.sh, I was able to resolve the
> > failures.
> >
> > Would you mind building with 'SANITIZE=leak' and running that script to
> > see if you can address the issue? Thanks.
>
> Thanks, I can reproduce the issue. I'm hoping there are no more tricks to
> testing things :D

Great, I'm glad that it was easily reproducible on your end. This one
should have minimal differences from the setup in CI, as I think
building with 'SANITIZE=leak' will suffice.

> Let's see how fast I can handle this ...

Thanks for looking.

Thanks,
Taylor
