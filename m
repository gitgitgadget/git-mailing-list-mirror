Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B3BC433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1C460F9B
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347386AbhKOXGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241518AbhKOWcp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 17:32:45 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07305C0F26E2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 13:44:09 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k4so15549100plx.8
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YuvT1OTyYGMohcwQmPbmCsyuCQGZxoWCF95QVt+07mw=;
        b=M/oEnLYQFFgkYg56pLm13yyqqYy8IlSTrxMXhjh2GxPF1obHbncmkXf07mVbInAev9
         9WjQg61+bJB6/tquihDdTLuoIVw1PczY0Zjizx0p8vF1G2SuLd774zUe8PdqaEGBaxcH
         O+k7K2YFBa/yq6cLkjPWvSMq5b7tmogEdPQ/tJmf4GlFpWHK2Nt26Z6/pm+w/ksYMemI
         9VXvn4Acz4bX6W9YcN6d33FMgFcuPu2YUCu7cN9y4NBJQb7NV7sjjb6bQ+CSKG4dwkRb
         jvj5d+lGa9bSVvefQ69mE28+1H5C32LDtD71dw7ageFIEhRBHeEat8C6111xlT1el/Y7
         zNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YuvT1OTyYGMohcwQmPbmCsyuCQGZxoWCF95QVt+07mw=;
        b=dqOsEUoX7yjFAmWV8u3O8vNpdFExAKwAEoBTdS+vGjUHSk7Mfo5Vyq6FMS95U1K1IZ
         exOsI+moR38juX212kiYZK26p/RR3vq+hpiG0AY68QPzylZaXkqEN3QBLm/CWspNUuvN
         7GC0Rdl1TqP91WWBfnh3aFOdGgLWQeD4FNQyLVW6vP4/FJV4bzRiv/Nb+Ic5tIM95193
         J3DeKD9gLpGdYdohQ9ELpDN494e1+McVu63dv4X2L/CUzqJoOs1eUyLALqDNyzi6p/7O
         5/RUDVI5GD+21ctA/VXteCJlJj63XxysW1dijPCb2+RYqdeYPNfU4cmQxTi9FK1HLpUu
         zKLQ==
X-Gm-Message-State: AOAM5338mWGAEmRs0T96mU2dO6XDU8I6NNyZcRzsWGMDi84Lr5CJu70b
        IGEjnfpL0aaF4v6IVJrRjRG9Cw==
X-Google-Smtp-Source: ABdhPJwt2WiPWZ0NWCwqwmQsY1XdvLWSuzNKuz4xgyRXX28J1wz+7k75t5m+GbGe6FhFSPNwYCX6cg==
X-Received: by 2002:a17:90a:fe1:: with SMTP id 88mr69052927pjz.24.1637012648203;
        Mon, 15 Nov 2021 13:44:08 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:9bb:b2ac:3919:1528])
        by smtp.gmail.com with ESMTPSA id md6sm257226pjb.22.2021.11.15.13.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:44:07 -0800 (PST)
Date:   Mon, 15 Nov 2021 13:44:02 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] branch: add "inherit" option for
 branch.autoSetupMerge
Message-ID: <YZLUoi3aBxb9kFLz@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <kl6lwnmaz0gy.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl6lwnmaz0gy.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.10.18 10:50, Glen Choo wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > +static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
> > +{
> > +	struct strbuf key = STRBUF_INIT;
> > +	char *remote;
> > +	const char *bare_ref;
> > +
> > +	bare_ref = orig_ref;
> > +	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
> > +
> > +	strbuf_addf(&key, "branch.%s.remote", bare_ref);
> > +	if (git_config_get_string(key.buf, &remote)) {
> > +		warning("branch.autoSetupMerge=inherit, but could not find %s",
> > +			key.buf);
> > +		strbuf_release(&key);
> > +		return 1;
> > +	}
> > +	tracking->remote = remote;
> > +
> > +	strbuf_reset(&key);
> > +	strbuf_addf(&key, "branch.%s.merge", bare_ref);
> > +	if (git_config_get_string(key.buf, &tracking->src)) {
> > +		warning("branch.autoSetupMerge=inherit, but could not find %s",
> > +			key.buf);
> > +		strbuf_release(&key);
> > +		return 1;
> > +	}
> > +
> > +	tracking->matches = 1;
> > +	strbuf_release(&key);
> > +	return 0;
> > +}
> 
> I believe that we can get the branch remote via struct branch. Instead
> of reading the config, we could do something along the lines of:
> 
>    int *explicit;
>    struct branch *branch = branch_get();
>    char *remote = remote_for_branch(branch, explicit);
>    /* Optionally check explicit if we don't want to fall back to
>     * "origin" */
> 
> I'm not sure which is the idiomatic way to get the branch remote, feel
> free to correct me.

Will fix in V4, thanks.
