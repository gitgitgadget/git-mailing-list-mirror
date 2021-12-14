Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B317DC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 20:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbhLNUh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 15:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbhLNUhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 15:37:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E67C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 12:37:25 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v16so2184400pjn.1
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 12:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9o6G0NZHMwz7wp+yWEDk4hCPgtPjC0i5S651ngcT1c=;
        b=l0K7W7ViZlvBI4chaP2Ylm6hI2dUMdcufK6eb+u+obkCDW0gqAWx9TEAVgqrB1UWjl
         GZmznGEIEiJ7sTqHul7wN4uhHF0c1lNymRIadTwnAzI0PVVDjbkmNgwgtvvsY5beCx5U
         wRowiMz13qKrvOoRTpDAQHMxHwZBSpq6Wz7rjjERLYduXniKyG4lCBamJ73MiNpZGnNF
         z8670CfeymYXoMZvJTIkcF13mA8h3fslECp1dabfouFtG7J7Cz/Nu0quqyGp9RpWGQ/A
         XhEVDvAgxNqJtnCdapas3UInPSbkwIcFOqNCBnweOpiPlxcKQNHItm3VkV4koiQMXusu
         t4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Q9o6G0NZHMwz7wp+yWEDk4hCPgtPjC0i5S651ngcT1c=;
        b=n/a8JznYZhK1ufDm4XFsLH6SCGIc74f6bXvdRMYReSID+VAM1kPSipb1Hs4zxW8k1F
         qhUx+OzPE5bgm8XLSykuaA9vLsvuFW0J0CS4wdZSOSbboWXc05knBOdn0kVBtcX4qnUS
         Xg0EdF6tUCZCAn8VCZQqyzu8dp1813hE/ecORA+yQvb9ZBBD9ZlAsmQMNSWu1T1RatT2
         0p1ui5miLjPYqR1qvLKMaeovA1oigxTGESPwBz1Ks5+y6MjZbTSIiuXdGKZvcuGdekyC
         AIshDOc6rxNKhSP21EDjyIUyG3akU4NPwzMzVTQD2ZGIqmzcCUvE98ocAar8ZiwqMKCn
         NDqw==
X-Gm-Message-State: AOAM533u8GEBiZaSg5Hr98XM6Xl9/BVSTzBUTBVJy/gFX+LebgzRqCLl
        Y7Xh2dAyy8N7ewxY8Bdl/GXFZg==
X-Google-Smtp-Source: ABdhPJzuL1jsQ4zskQQrOKKozSNIFC9m27OVOxpmMpq/Dd03OzHHa/N/N9fdMkAJHjMqntR6dcqnqQ==
X-Received: by 2002:a17:90a:9291:: with SMTP id n17mr8187230pjo.219.1639514244576;
        Tue, 14 Dec 2021 12:37:24 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:b37:fbed:ef52:5dca])
        by smtp.gmail.com with ESMTPSA id k70sm534619pgd.19.2021.12.14.12.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 12:37:24 -0800 (PST)
Date:   Tue, 14 Dec 2021 12:37:18 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, chooglen@google.com, emilyshaffer@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v5 2/2] branch: add flags and config to inherit tracking
Message-ID: <YbkAfk1r/ONeYyIN@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chooglen@google.com, emilyshaffer@google.com, avarab@gmail.com
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <c7e4af9a365cc61e682c3c73045fb1ee4b79cfbf.1638859949.git.steadmon@google.com>
 <xmqq7dcg6w43.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7dcg6w43.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.07 11:41, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> >  --no-track::
> >  	Do not set up "upstream" configuration, even if the
> > -	branch.autoSetupMerge configuration variable is true.
> > +	branch.autoSetupMerge configuration variable is set.
> 
> I guess "inherit" is different from "true".
> Nice to see an attention to the details.  
> 
> > diff --git a/branch.h b/branch.h
> > index df0be61506..6484bda8a2 100644
> > --- a/branch.h
> > +++ b/branch.h
> > @@ -10,7 +10,8 @@ enum branch_track {
> >  	BRANCH_TRACK_REMOTE,
> >  	BRANCH_TRACK_ALWAYS,
> >  	BRANCH_TRACK_EXPLICIT,
> > -	BRANCH_TRACK_OVERRIDE
> > +	BRANCH_TRACK_OVERRIDE,
> > +	BRANCH_TRACK_INHERIT
> >  };
> 
> Unless INHERIT must stay to be at the end of the enumeration even
> when we add more of these, let's leave a common at the end to help
> future developers.

Fixed in V6.


> > -		if (value && !strcasecmp(value, "always")) {
> > +		if (value && !strcmp(value, "always")) {
> 
> This is belatedly correcting the mistake we made 5 years ago, which
> can break existing users who used "[branch]autosetupmerge=Always" in
> their configuration files.
> 
> I'm OK to fix it to accept only lowercase as written here, see if
> anybody screams, and tell them that the all-lowercase is the only
> documented way to spell this word.
> 
> >  			git_branch_track = BRANCH_TRACK_ALWAYS;
> >  			return 0;
> > +		} else if (value && !strcmp(value, "inherit")) {
> > +			git_branch_track = BRANCH_TRACK_INHERIT;
> > +			return 0;
> >  		}
> >  		git_branch_track = git_config_bool(var, value);
> >  		return 0;
> 
> Thanks.
