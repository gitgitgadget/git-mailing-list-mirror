Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D122DC433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376450AbhLBRo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376448AbhLBRop (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:44:45 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277DC061758
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 09:41:23 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id z3-20020a170903018300b0014224dca4a1so181570plg.0
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UNp2tn2zr+SJN9MXygUSJKyz0MZ6EtTl3hzAnBFyuJY=;
        b=tNJp4o8oAGcZq7y6+xplifhxrBU4VuRUuZ5Gj4mdq+PvAOg4DL6aEOKjOdaKjzcbLI
         OBrlyHasRVlpK6fkbKPl0dzSLpKe1PByCbA/35i9rVzQr1Rd4m09VK1HcOBQR4Kt4mIW
         YDY0HJp7gEvUb4xByOLfm6fR1UddpdprZbqU4VwXnuc+w4LFRHSQXoBVVSllP7qfwqfR
         opXfV95qwvwdanOk1pZoh0hbdZNg03I74ZYQXAqHlsRRliqAPZjlkozEW6cRI1+8TPGX
         YvJyNCArBr3hZS3pMQmxVTARk9g8nx6FOv6ZEHkqRjNPozy43NCek30RBqIZ+zVmteix
         1U3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UNp2tn2zr+SJN9MXygUSJKyz0MZ6EtTl3hzAnBFyuJY=;
        b=MpuRAvPGCYMf1ZJ3kmyxaALs4p3OuftwfTzh36qpkh16YpiPJkvkhyBkK5OJue7Hl7
         I2hOHFGfN6Q/L1lczyGAlye3ALifbJ9IATIadPdILX/MPvntq9XniObB1SF7ZBHR333I
         QiDYrCZKXqzRfEyuc7J4AGT3qGg7h8G8tXL6fFfFW8ms3NbO8+13chX9g5VJzOM4tymN
         UO9M4hSTLB8b/fH21CKqNImBC8/OcyGJwCgTOG+6Jj6LHt1DBrOUjLUzEvCKYX1kr4sB
         jMLOi+1ZidXAM+DbOZ6BaN2FKMmE3d8yuYS75XPZWlARjyxozfxmJbjJoArlMtn4tv6U
         OicA==
X-Gm-Message-State: AOAM531jsD4xdfMuztHFneWjUNpi1X6Rx2kBDJ67CX06ldfKyEJyM0gC
        zpbHErpLcgXalYckiWy+wRA6VJV0XcA3edvh9Nc8
X-Google-Smtp-Source: ABdhPJwBKo6GA+zz8vpOrrK09JJWg8551qCBI2fpm4ynZr4o7JqASVHuISh356JvBBSBeFXkNi/TgzuRva1IkyxOEhR9
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:934a:b0:142:6ed6:5327 with
 SMTP id g10-20020a170902934a00b001426ed65327mr16780111plp.85.1638466882330;
 Thu, 02 Dec 2021 09:41:22 -0800 (PST)
Date:   Thu,  2 Dec 2021 09:41:18 -0800
In-Reply-To: <xmqqpmqfwl32.fsf@gitster.g>
Message-Id: <20211202174119.1376799-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqpmqfwl32.fsf@gitster.g>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: Re: [PATCH v4 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, chooglen@google.com,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> > @@ -335,9 +412,29 @@ static int git_config_include(const char *var, const char *value, void *data)
> >  		ret = handle_path_include(value, inc);
> >  
> >  	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
> > -	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
> > -	    !strcmp(key, "path"))
> > -		ret = handle_path_include(value, inc);
> > +	    cond && !strcmp(key, "path")) {
> > +		const char *url;
> > +		size_t url_len;
> > +
> > +		if (skip_prefix_mem(cond, cond_len, "hasremoteurl:", &url,
> > +				    &url_len)) {
> > +			if (inc->opts->unconditional_remote_url) {
> > +				config_fn_t old_fn = inc->fn;
> > +
> > +				inc->fn = forbid_remote_url;
> > +				ret = handle_path_include(value, inc);
> > +				inc->fn = old_fn;
> > +			} else {
> > +				if (!inc->remote_urls)
> > +					populate_remote_urls(inc);
> > +				if (at_least_one_url_matches_glob(
> > +						url, url_len, inc->remote_urls))
> > +					ret = handle_path_include(value, inc);
> > +			}
> > +		} else if (include_condition_is_true(inc->opts, cond, cond_len)) {
> > +			ret = handle_path_include(value, inc);
> > +		}
> 
> This looks iffy, especialy in a patch that is not marked as [RFC].
> 
> I can see that include_condition_is_true() only passes inc->opts and
> you need some other parts of inc for your purpose, and it may be the
> primary reason why you munge this caller instead of adding function
> include_by_remoteurl() and making include_condition_is_true() call
> it.  But wouldn't it be sufficient to pass inc (not inc->opts) to
> include_condition_is_true(), and have it dereference inc->opts when
> calling include_by_gitdir() and friends that want opts, while
> passing inc to include_by_remoteurl()?

Thanks for taking a look. I think the primary reason why I wrote it like
this was because originally (in v1) I included at the end, not inline,
but of course that is no longer the case so I should revisit it. I'll
have to pay attention to how inc->fn is swapped for forbid_remote_url
(to prevent remote URLs from being configured in included files), but
perhaps handle_path_include() can do that. I'll take a look.
