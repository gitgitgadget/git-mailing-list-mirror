Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE3435F163
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747022; cv=none; b=Hu9SNdaEJQzep8gCRIGizrsw9kEmQsYBXXOv2QqefEix5oV2u8iwh945LyQsO3GMO5FNRRP+rObc8jLUff2/vUmdmBvE8UeeeLIghRK7zc2fbK38F18waQuSYlEgprTQrlakAcVVhFSFtWIJbbaFSESHQNSPo4PXMfaWZw/YL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747022; c=relaxed/simple;
	bh=Ud+NflpmvM/s6O7DwUwu+YEK+h67luGGtX+x/sfIYcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8kNr14Q2vfA3jCL2Ycv+5tuZ+gsXyJ7Xp5zF8Io+IrbmBXNkW1drKDQ67ilM+jw16Q9ekP5QGXa1KPIaXnGSog4dnaMoxX1fVjif/UvFGcqjNhVO4QviocLibVLJwaDESkeEp/Mo9izXkSNh+BPRnxbk6Z7OKMXMgk0VOILJGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeXTe/y7; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeXTe/y7"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-463a0e14b4cso3622523b6e.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 13:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772747020; x=1773351820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxTvS4X9TIuBPz5M6fIrNyj/JPeaKLE1fp81oWNInW0=;
        b=UeXTe/y7rGMDePEUbh7w9YLNTjvT6weNSCiLjscAV2A1iXz6jTg4YsD8p02h2EspPm
         JqY9LcNMFDeWsRhlKUb3Kv9RUCHqvbOX4m18lUIHzZS7fUJvpviIfQoo9BB1QQFnnpeA
         oufeA+gbxNqLlbS+HQZAWL+6Wb6bEvDH48IILde6itHs7zJj7NZuEF8fKafn6pecryQA
         a4t0gLp2e2B2jEPgpS1ni86LgYUIAqrmNc+ZBLxF6tDkIgwIuEAQE3qTJVsABShlWRgp
         Xm3wlqMZ5C4BNhSYFbty1hjn6YZ6Vl66XOacpryYE+f4IUR5ZEWw5y0K+IhxDAqBv3u3
         wfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747020; x=1773351820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxTvS4X9TIuBPz5M6fIrNyj/JPeaKLE1fp81oWNInW0=;
        b=aYnfYbX3Et22SelT5tlNANlUl9b9w6MI+f+o3b1j/IDoha5qNs2Av6t2FWs2Webo3L
         lfwDM/WY8EwyqrmrpmFQFVMOz+dwHXSz/j8rspdpRPfiim0s1PHUmj/Nn0k4+L9OUopg
         LmaSbimv6Z/IHGXJIc9Lu59av4szug4qLhF2IrDlGpgXtPM5NFzKm6laS7//khFpisv1
         UVi6FGXiZfP0vYMemSar4iEFwime1jcjb/BBEEppgVK8L074pFakXwFsWNvNhGJlbi5k
         e6mS42Li/vktttgY2PiQkbn6r1tqqS/lDuUz/OKxT+4Osl265HTfxQzuUM3XIb9F/jXH
         aVEA==
X-Gm-Message-State: AOJu0YxTN5My5IFEhzJOPqXpLdEJIgjQLpKbalT+QHO3KMHz4TyUm5X8
	MEQMgN+szsbVO/gqwPHWQBTgK0RMXqX2seLRsg4K9qSAwUiXD3Se0RHitf+CfA==
X-Gm-Gg: ATEYQzxvxOkPiroIuwcjTfuXDIvZ2Tw8cj7cSAFw69aH42ttlwmq7rFUzSWe/mIaGJG
	eMk9q+Anru7e/F/oQmkCjyLqOlgvJp5uWozW2fiaWfh3XYQEPhuYXa2BccvQZCd0aMXh3/9IziL
	LktQKcZDN1SWkfOXWPZdu2BOIUPWrBMtLolhy3E3TZ6Ppq7UYVfy9RtTjP8BjnN1tlAMApKepHr
	T1VWFzmBOys51zzHsOEFUyT+Ihe4oAf4c1ZFF/HYlrl2qA18D22QEvvwyQDN73GiStOd/44c8B4
	TKrV4BeD+Efsl+bKRi6oTwxiipt7OZhN9S1v2qloKB+qCwT/q0L5+pc8VUCZxuh/t0HM7uqsjrZ
	7GD+u4+J7pNQC94RLH+sGDe/cYL01LDmLxNUdL4Hsb5y091uhMBBSGQBJYvuFrsHrXC91ximNkU
	BgVtG4vYBMayEj/4BJ
X-Received: by 2002:a05:6808:118d:b0:45e:8554:1f14 with SMTP id 5614622812f47-466d8792d43mr652402b6e.59.1772747019741;
        Thu, 05 Mar 2026 13:43:39 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3ab494sm13767730b6e.8.2026.03.05.13.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:43:39 -0800 (PST)
Date: Thu, 5 Mar 2026 15:43:38 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] Documentation: extend guidance for submitting patches
Message-ID: <aan4xVGaehnXB1Hd@denethor>
References: <20260305193836.973122-1-jltobler@gmail.com>
 <xmqqikba2evz.fsf@gitster.g>
 <aan0FUBE1LwrFc4y@denethor>
 <xmqqzf4m0xju.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf4m0xju.fsf@gitster.g>

On 26/03/05 01:35PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Ah yes apologies. The first addition to start with a line prefixed with
> > '+' intead of a blank line. I do believe it does already end with a
> > blank line though. I'll correct in the next version.
> 
> I have the following queued on top.  If there is nothing else, I
> can just squash it in.

Perfect. Thanks for fixing. :)

-Justin
