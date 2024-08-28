Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8349644
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855458; cv=none; b=Wa5ZNGbRID6OMCvAFwPN28Dot2GJ7Xbr1CoKe2YMhPxuniNJGPxG7ESz3tPoaREFIdleQgvJI7rB4V96/bn1oaI2L1aNoZ8fRUP/xKoA/mjb5kpiSQGOE7OOU1KZhVNEUGEcjSjfPuZGhI56iwg4CbX+aJaQtU1Y97NMzo1Uzm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855458; c=relaxed/simple;
	bh=oUs2srJBm04XxhA+sJ1z0gVGyvMpN8SYoFDaSElD35o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3hETkrnQRBwe4XWjhQaCEb/yAREn/hS8LrFqoC5taLFyJk6j0ukf+dTsFZOSJR92Pt1qVrrVWwicGrY4R0U8YXFkSqOIcdpQev4hbJoEF3WX3btEPnbXjbxlvbNgwjmgtmgZ1F8sh/z/og5Ft+57ep52AYumuPzJzdEZSJO+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIT8sDMX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIT8sDMX"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-714114be925so5723475b3a.2
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724855457; x=1725460257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=48cEA4P9eAn7WsO8vY8CGg7/15qe2ZsgxdRDVJIntcQ=;
        b=HIT8sDMXgJ4RGl0RIBULevsEF0z+QpzPJbeWR+hWSP0MaqQHqFl80+T5XgbNFytZky
         rS68vy9yBUbHFwW0+kMDQUt5Ae8uf+NYQXQG5LGj/bLU6Lwx9T3KxIhfCI8ZnNBuu3se
         r6P49IbOFFI9gPP3vwSb/dzlh8YQpmGSHDrhqvGNLJqWFE6ynG50uDAKXNo1eOjyoz88
         GUIQ3o0/f1Ju9Ap1OpwmWSvm3zdHj9JlTsGtrLsdLfSah4ub0TF+RcLUHXRXFDLRjvwy
         tKNQORNkRXS3Fyd2Fvnmy7Dv3H+422nlWkLN1SdhkayL5LEd5YDDk+b158oBlVNKZmNc
         gFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724855457; x=1725460257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48cEA4P9eAn7WsO8vY8CGg7/15qe2ZsgxdRDVJIntcQ=;
        b=jK9T4vcr7v3UCuMXkUSe8heH2bfnY1zDPNgSvWTBG5uOKpbBMdIXFvB+xm0w4kzBdO
         GIWdVWzWy2HTBCmBeVLqaDURVv6a+6Lmf93iayHuPV/aszlTTj6/XAXv7Cp48onJ+XhG
         rbftg0S2hINiBPCtiiDyTRW/RKw7RA89jG1NS93P3tLPfiCHktjNj5c0wsL/G6iA2c9f
         +7V060nKkzR0/1bJ49wf1eE50itVrroOc4/7xJo6A0ShjUiR62+aF0hLR+e6GNHF5VqU
         8IFcP6FwxTeYKLmWagdh/IvN7/xcZr4V4fD1z/7MUfQ0IiSI/3zZqfypzfz+7D1ZH9Wb
         qUjQ==
X-Gm-Message-State: AOJu0Yy6VX7CgQQtfgxwOYqWMOoJFjoQ1MYp0RtYWqn+IC7EFg22k2TV
	5PmgrPLu3GiVok0K9vux/W+XTT1yYaadkJZmXBZiOGGBtiiX/Ohf
X-Google-Smtp-Source: AGHT+IHOC5iVmgX7yqlUmQDG2KyPE4hZ0a3lIOUmpimLvZRIj0etlffJ/Sa8sAir5Ag6gB8UYABd9g==
X-Received: by 2002:a05:6a00:cd0:b0:714:1ca1:7134 with SMTP id d2e1a72fcca58-715d10e61cemr2498370b3a.18.1724855456420;
        Wed, 28 Aug 2024 07:30:56 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e09c3sm10157127b3a.122.2024.08.28.07.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:30:55 -0700 (PDT)
Date: Wed, 28 Aug 2024 22:31:48 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/4] ref: add regular ref content check for files
 backend
Message-ID: <Zs801HqHg45v_q6X@ArchLinux>
References: <Zs348uXMBdCuwF-2@ArchLinux>
 <Zs353oLDaw2SbNQs@ArchLinux>
 <xmqqjzg1aksx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzg1aksx.fsf@gitster.g>

On Tue, Aug 27, 2024 at 11:21:34AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > We implicitly rely on "git-fsck(1)" to check the consistency of regular
> > refs. However, when parsing the regular refs for files backend by using
> > "files-backend.c::parse_loose_ref_contents", we allow the ref content to
> > be end with no newline or contain some garbages.
> 
> "to be end with" -> "to end with".
> "or contain" -> "or to contain" (optional, I think).
> 
> Or "... the ref content without terminating newline, or with extra
> bytes after the terminating newline."
> 

Thanks, I will fix this in the next version.

> > It may seem that we should report an error or warn fsck message to the
> > user about above situations. However, there may be some third-party
> > tools customizing the content of refs. We should not report an error
> > fsck message.
> 
> Even though we never created such loose refs ourselves, we have
> accepted such loose refs forever, so it is entirely possible
> that third-party tools may rely on such loose refs being valid.
> Let's notice such a "curiously formatted" loose ref files and
> tell the users our findings, so that we can assess the possible
> extent of damage if/when we retroactively tightened the parsing
> rules in the future.
> 

I think I could organize the above to the commit message to better show
the motivation why we should not report an error fsck message.

> > We should not allow the user to upgrade the fsck warnings to errors. It
> > might cause compatibility issue which will break the legacy repository.
> 
> I am not sure this is a right thing to say.  If the user wants to
> ensure that the tool they use in their repository, which may include
> some third-party reimplementation of Git, would never create such a
> (semi-)malformed loose ref files, it is within their right, and it
> is the most reasonable way, to promote these "curiously formatted
> loose ref" fsck warnings to errors.
> 
> Is your "We should not allow" above backed by code that prevents
> them from promoting the warnings to errors, or is it merely a
> declaration of your intention?
> 

I have introduced some misunderstanding here. In the previous paragraph,
I have mentioned that if the caller set the "strict" field in
"fsck_options", the fsck warns would be automatically converted to fsck
errors which may cause some trouble.

So I think here we should move this paragraph just after the previous
paragraph to indicate why we do want to make a info fsck message here.
Actually, the user could still explicitly use the following command

  git -c fsck.refMissingNewline=error refs verify

to upgrade the fsck info to fsck error. But if the user use "--strict"
like the following:

  git refs verify --strict

The fsck warns would be automatically converted to fsck errors. But
actually at current, we do not want to the user implicitly upgrade fsck
warns to fsck errors by using "--strict" flag. That's why we need to
introduce the "FSCK_INO" here.

Actually, I was inspired by the Jeff King's commit:

  4dd3b045f5 (fsck: downgrade tree badFilemode to "info", 2022-08-10)

In this commit, Jeff downgrades badFilemode to "info" to avoid above
situation. I will improve the commit message to make things clearer.

However, from my perspective, the semantic of "FSCK_INFO" is a little
unsuitable here. The comment says:

  /* infos (reported as warnings, but ignored by default) */

The "ignored by default" here is very confusing. Actually, we make the
"info" lower than the "warn" to avoid automatically converting the "warn"
to "error" by setting "strict" field in "fsck_options".

But "ignored by default" will make the user think "oh, it's info, but we
report it as warnings". We cannot know the real intention of the
"FSCK_INFO" unless we have above context.

But I guess this is too far from the intention of this patch. We may
improve this later.

> > @@ -170,6 +173,12 @@
> >  `nullSha1`::
> >  	(WARN) Tree contains entries pointing to a null sha1.
> >  
> > +`refMissingNewline`::
> > +	(INFO) A valid ref does not end with newline.
> > +
> > +`trailingRefContent`::
> > +	(INFO) A ref has trailing contents.
> > +
> >  `treeNotSorted`::
> >  	(ERROR) A tree is not properly sorted.
> 
> There is no mention of "you shouldn't promote these to error" here,
> which is good.  But wouldn't we want to tell users to report such
> curiously formatted loose refs, after figuring out who created them,
> to help us to eventually make the check stricter in the future?
> 

From the review from the Patrick, I will add another patch in the
"Documentation/BreakingChanges.txt" later.

> Git 3.0 boundary might be a good time to tighten interoperability
> rules such that we won't accept anything we wouldn't have written
> ourselves (not limited to loose ref format, but this applies to
> anything on-disk or on-wire), but we'd need enough preparation if we
> want to be able to do so in the future.
> 
> Thanks.
> 

Thanks,
Jialuo
