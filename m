Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A33117BB26
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954116; cv=none; b=TtpIgwj+5QESX8rlzc0kXD6xMxgidJtgKBjCbt6XmD8Kt9eEkXY3b0pPQPWjAQo5Tfo0LduV/fAARDTcOUjcgOJk4b0e/S+eXK8UPmaAKVUJ4eBkPJjw6QVdGJARcPcXtH2WedGwNlVUbQJ26Mi/NS0rXHxJUfDg82DuSp9WC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954116; c=relaxed/simple;
	bh=db7fQi6CafbPIkShzm40qB23iePDAWYgm6k4kOZmKuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHdu/xeSEoPoijqTSIZn+5Y2Kz+t9tEajL8Qa4cWze9fHOQs3MU6rqSoT4her5g9g3LU5oYKIHd89ku+Doj2P86RRIJ0BxyNM2hTut/2rdBiN5cDQGrtLzr8v8pfEgW4gzE21DjdvKa4bj/i+/3tB0feYkEr1rnSv0cBxND5mXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm7xtS3N; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm7xtS3N"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-206b9455460so42923535ad.0
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 00:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725954115; x=1726558915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6J9I7EU6uTebmcS0qEW2q9SR2ju732izs+Lt5NwBJ+A=;
        b=Fm7xtS3NMBYhZxxtz7JjVGn/kpMtr/YmmFAPcD/eAe5c/VEc8n9rfWIHWQPRcmycTy
         nLA5gmaoIWAYmZTv67iNUqcUwIQLnSRztLsZ3xMSQ5gMh4N+9iUCiczNE0Tk3a+8zu8C
         Ng5tCxPlh0p/x23kYEvbDRfNbo0g0hIcTz9IhGA8gtiz+xn88UlZb52nMEoncqOTmajY
         7DC9pmxtHRHwYnUX/sy5xznHuTYFAtRGjI0LJdVHtESp5FH67CFRn9klS7dwKhzMMw9m
         sw3U0qx9CYA09oAIdd+KGx3MRmdWMyE0FMeU+oX2h1YLFkvy/jXtLl+Rhg7gfXPSTUQV
         jeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954115; x=1726558915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J9I7EU6uTebmcS0qEW2q9SR2ju732izs+Lt5NwBJ+A=;
        b=up5qJPntrPnjoQ83M5EFyEWHxgHeDhis4Bsxq4AyobXU1kKvoa5PpK3NnkIXCbDsqw
         B8o8HjSB40RyTx1DQTz4AxLUZdfA/6CNUcAm2s9k0VZbHymcaGxFw1Isb00OTpQOeNb1
         e0B2j5F12DIWQ/vN4aZp8g2eQlUy+KgXFVevEWKSkeFbjlBZAK7gPfhrWVeLcCo2PP8L
         YFlwZFuwEIJRqk550UGrhCNK1hSVlvsR3qpOrIslTQUxwSvn2PGQTNg5dUh9dQeOC2Vz
         sivxPASGpvvVY8ZPzsfjJ7HgiFjg/BHikHzjZh5tDM0j/xFiM0ch8L0wbJ40qCX6smRX
         Tktw==
X-Gm-Message-State: AOJu0YytRk4+M8iZZDqT/CAp5offlFdQL/3dLQj4N47j6TJUYTRnlom9
	2VfAfI+Avu/lNHloBDNnoKJ9cOvBfuuswVWudH6aeBvnTJN1o4QG
X-Google-Smtp-Source: AGHT+IEWjEsF9URZdblincRGA6EkvA94OobYHUVZk/bYZ7SgjsGNtu/o0q7MtrmsGp/MtjIgDVVV+w==
X-Received: by 2002:a17:903:2411:b0:1fc:4acb:3670 with SMTP id d9443c01a7336-20743a211c2mr36288325ad.12.1725954114366;
        Tue, 10 Sep 2024 00:41:54 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e12d73sm43308855ad.27.2024.09.10.00.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:41:53 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:42:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] ref: add regular ref content check for files
 backend
Message-ID: <Zt_4ghf3YfumEG-j@ArchLinux>
References: <Ztb-mgl50cwGVO8A@ArchLinux>
 <Ztb_HqLg-WvwA2I0@ArchLinux>
 <Zt8OZywRAxYaWqpo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt8OZywRAxYaWqpo@pks.im>

On Mon, Sep 09, 2024 at 05:04:07PM +0200, Patrick Steinhardt wrote:
> > This is because if the caller set the "strict" field in "fsck_options",
> > fsck warns will be automatically upgraded to errors. We should not allow
> > user to specify the "--strict" flag to upgrade the fsck warnings to
> > errors at current.
> 
> This is formulated a bit curiously: it reads as if we wanted to limit
> what the user can do, but what we really want to ensure is that the
> `--strict` flag doesn't convert it into an error. So maybe something
> like this instead of the second sentence:
> 
>     We don't (yet) want the "--strict" flag that controls this bit to
>     end up generating errors for such weirdly-formatted reference
>     contents, as we first want to assess whether this retroactive
>     tightening will cause issues for any tools out there.
> 

Thanks, I will improve this in the next version.

> > the legacy repository. So we add the following two fsck infos to
> 
> I wouldn't call it "legacy" just yet, as we didn't yet decide whether
> we're going to make this formatting invalid in the first place. It's
> rather a test balloon.
> 

I agree, we should drop "legacy" here.

> > In current "git-fsck(1)", it will report an error when the ref content
> > is bad, so we should following this to report an error to the user when
> > "parse_loose_ref_contents" fails. And we add a new fsck error message
> > called "badRefContent(ERROR)" to represent that a ref has a bad content.
> 
> Okay, so this is basically porting over behaviour that git-fsck(1)
> already has to `git refs verify` and should thus not cause new issues
> anywhere. I think it would have made sense to do so in a first step and
> then introduce the tightened rules in a separate commit.
> 

By reading the whole comments, we'd better create a commit which ports
the existing checks to "git refs verify" both for regular refs and
symrefs.

So, I will add more commits in the next version with the following
sequences:

1. Set up the infrastructure to check the contents for refs.
2. Port existing checks in "git-fsck(1)" to "git refs verify".
3. Introduce the tightened rules.

> Will we eventually remove those checks from git-fsck(1) when we adapt it
> to call `git refs verify`? If so, we should likely note that in the
> commit message.

We should do this, as we have discussed before, "git-fsck(1)" implicitly
checks some refs which makes the code hard to understand.

> Coming back to my comment further up, I guess this whole block here
> could be introduced in a separate commit. So the first commit introduces
> the infra to check loose ref contents as an obvious step because we
> simply port over rules that already exist in git-fsck(1). And the second
> step could then do this retroactive tightening with the justification
> you have spelt out in the commit message.

Yes, it will be much more clear. So, I should not simply classify the
situations by the type of refs.

Thanks,
Jialuo
