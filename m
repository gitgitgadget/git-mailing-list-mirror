Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD59C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 18:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC2661937
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 18:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbhCXSrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 14:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbhCXSqy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 14:46:54 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEECC061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 11:46:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m7so15265991pgj.8
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 11:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MvLCl8ZvE1EV4GYUzeU0KTJKg4Zji0k7DQDyRIlFP0c=;
        b=L8adQmWK8RLu343zKKonTZYPUxcLCWrzKkxEDhRPiFSSC4XPblik5n0FnYeEIqWTmn
         Lt7FD8DI6xJQNiW4ZzKeMSkYhLdikbU57LUI//yminnsf8BwjeaVnChxPpC3vJ+kKmN3
         l5t919DDRz/1bFa1zntRSzGDzAKX5YI+y6jVezJmuuC/345l0itv7pQ0qt8LRKjL2I47
         jYSHiBni2vFwuqaCH5gmCtUpBLfWrNZ+hK8apHSBPhWARhsJtuqyRfuctyKF6FAs79Tj
         xxsyrXO7lse4g6PsLQMU2qonDlo6C7eHBRVoX0wCV0tfd3eIwG8uhUEQbtOZ5FY+M5KZ
         W/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MvLCl8ZvE1EV4GYUzeU0KTJKg4Zji0k7DQDyRIlFP0c=;
        b=cCJljE1My19mZnyOR3GW84dcUjjx7iDHsSDR7IzNrGN5qNlBeoqOrEigPmiTLBZ0L7
         lL1ssAi5nASUDMyKu2BlqlxqImEJmvD6OwBBV/XkYfQh+eQAAq9uWrXKE9+ANaWx6fG4
         Szj+zHICGZ6gtBZ1P76p7mhXshVDaa2EYTP1BlKWptdnfFadtyzTSfAqFQ/br0yuBjOj
         NJ+g9xioqGKN6ryOIKLCFp9PnZ2m3N3RoXGNo5F0PzGed9mOnrpSt48t5tc95ztoN3tA
         AU+171xFBBtBxUUc7qq0et/0t1IWa/CLsKVg8gPPTWGi/fSQkVe8NqgqDpVfe1dFXPf0
         qsEA==
X-Gm-Message-State: AOAM533bUvmYpPVvhJc+fFZ/aW0G9AbK1WXKNsaIxyNIOh8gHmZnZeb0
        4h3Uu0Vj+1Yq/Pn95SZc96Rid5d/Sy+SWA==
X-Google-Smtp-Source: ABdhPJyU97Y1/A24d7SOZZGrUCt4EyX5oFUBHTBQ9K1OPSRg/OHzrBbJwJxExRQE+kZPniqbVKOkXg==
X-Received: by 2002:a17:902:9b8b:b029:e6:b027:2f96 with SMTP id y11-20020a1709029b8bb02900e6b0272f96mr5061402plp.28.1616611613719;
        Wed, 24 Mar 2021 11:46:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:d027:9201:1f66:e720])
        by smtp.gmail.com with ESMTPSA id cv3sm3219192pjb.9.2021.03.24.11.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:46:52 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:46:48 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 05/37] hook: teach hook.runHookDir
Message-ID: <YFuJGG1MUokL4o4i@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-6-emilyshaffer@google.com>
 <87im5whitx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im5whitx.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 09:33:46AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Mar 11 2021, Emily Shaffer wrote:
> 
> > +	switch (should_run_hookdir) {
> > +		case HOOKDIR_NO:
> 
> Style: case shouldn't be indented

Done, thanks.

> 
> > +			strbuf_addstr(&hookdir_annotation, _(" (will not run)"));
> > +			break;
> > +		case HOOKDIR_ERROR:
> > +			strbuf_addstr(&hookdir_annotation, _(" (will error and not run)"));
> > +			break;
> > +		case HOOKDIR_INTERACTIVE:
> > +			strbuf_addstr(&hookdir_annotation, _(" (will prompt)"));
> > +			break;
> > +		case HOOKDIR_WARN:
> > +			strbuf_addstr(&hookdir_annotation, _(" (will warn but run)"));
> > +			break;
> > +		case HOOKDIR_YES:
> > +		/*
> > +		 * The default behavior should agree with
> > +		 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
> > +		 * do the default behavior.
> > +		 */
> > +		case HOOKDIR_UNKNOWN:
> > +		default:
> > +			break;
> 
> We should avoid this sort of translation lego.
> 
> > +	}
> > +
> >  	list_for_each(pos, head) {
> >  		struct hook *item = list_entry(pos, struct hook, list);
> >  		item = list_entry(pos, struct hook, list);
> >  		if (item) {
> >  			/* Don't translate 'hookdir' - it matches the config */
> > -			printf("%s: %s\n",
> > +			printf("%s: %s%s\n",
> 
> native speakers in some languages to read the sentance backwards.
> Because if you concatenate strings like this you force.
> 
> (We don't currently have a RTL language in po/, still, but let's not
> create churn for if/when we do if we can help it)>

Yeah, you are absolutely right. I'll take a look at your suggestion,
thanks.

> 
> 
> I have a patch on top to fix this, will send it as some general reply of
> proposed fixup.s

FWIW, I found this format of suggestions really hard to navigate. I had
to go find your fixup (and I think you sent two different ones) and then
had to scroll around and find what you're referring to from here. If I
were to apply the fixup directly, I'd have to split it up and find the
appropriate commits to associate each part of the diff with. I know
generating scissors patches for each review is a pain, but I'd even
prefer a prose "How about printing in each part of the case instead, so
each string can be translated in full" or a non-formatted example inline
to the catchall fixups patch you sent.

> 
> >  			       (item->from_hookdir
> > +	git hook list pre-commit >actual &&
> > +	# the hookdir annotation is translated
> > +	test_i18ncmp expected actual
> 
> This (and the rest of test_i18ncmp in this series) can and should just
> be "test_cmp" or "test_i18ncmp", the poison mode is dead. See my recent
> patches to search/replace test_i18ncmp.
> 
> The reason the function isn't gone entirely was to help a series like
> yours in "seen", but if we're re-rolling...

Oh cool, thanks, will do.
