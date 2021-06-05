Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A465AC4743C
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C64460FDB
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFEBkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 21:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFEBkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 21:40:31 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4291BC061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 18:38:32 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id hf1-20020a17090aff81b02901630f822d2aso8729355pjb.6
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 18:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZybTr5vcD6L3Fsc42yfLlu9NBMoZRbZ4HINCDL3p4gI=;
        b=HYBVUPPV0X49+rlWbjZy7jsIB8l8oC4aU0CfIYTEWoNfwG+pg0D7iI0JYFAyLFgNIL
         QXEkSeOybWfG8HtC5oZki9i2lFJS61T/CL8QoswbNgEj6LHIq3D0h6b+ucp4+4Hg+kOf
         XWJy0I/3dCuliSKiBB65Yp1kyTfH0yTTiEpYvyZkn86dTjlNmHgQBO4eU8jARei+7N2/
         BWUEY3EF8vnkQFGoPdFya1w6Lqzf4zpnrRgNZ5ngMIlqxmId3j5mIffSdEDtNsIOQmc3
         0ce9BGweH+g9wf40sDsTgT6Ib6unnibEs0FENCKizukEHPFKNhyAGMlDUNcZHWHHhv7U
         La4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZybTr5vcD6L3Fsc42yfLlu9NBMoZRbZ4HINCDL3p4gI=;
        b=j82QQcu7kJ2B5L4NbrpJPeYOW8+zrUNyahSb9hH+4xGbh3Z+ebxDO5abeTuOs3zNEa
         qo3/ccSZeNCcgPC40ENZ70X3lFhxT/8zb2L8KtBs9J3rZxp9i49yOR7ODZ/7/5UyV0RP
         zW/OIUYK2L5ejPWWYaLPGedUeMP74wSsqeu7ymiyBx6TzCUHx5QLm8iX2cF/lUHXYcGR
         CJsrqKI0Yec2D1Y/ClDLT02e79Sn8c5mSzKyT6M4JEXAZbGXDbw7GuyVB30hGmCsBc/6
         BWkKGt8apOs63xKAArv0RZxVIRT68b9lVhywxX5PfnGwudadG530UeqdUy34Qv8PFwzb
         rv0w==
X-Gm-Message-State: AOAM531G6rzMoLWFGRUBOr1rnhgVuD/I1XQVC09nVXn6xZP2E/zJ7dW+
        iRs1zDXfcgHBqazbzb5/QrhZBitzd3wVe85r07bo
X-Google-Smtp-Source: ABdhPJxU8Z+JAJvNEYCFdJLeFR13ORzpVI/4rX3vz9UmLf5Rqv8cBx30T1bLQRPcNF/eItkFy5su6VKXz2YseN5ljC5F
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:8491:0:b029:2e9:c618:fa32 with
 SMTP id k139-20020a6284910000b02902e9c618fa32mr7262953pfd.15.1622857111681;
 Fri, 04 Jun 2021 18:38:31 -0700 (PDT)
Date:   Fri,  4 Jun 2021 18:38:28 -0700
In-Reply-To: <YLqFgjEV8JoLzZSL@nand.local>
Message-Id: <20210605013828.603432-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YLqFgjEV8JoLzZSL@nand.local>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH 1/4] promisor-remote: read partialClone config here
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Jun 01, 2021 at 02:34:16PM -0700, Jonathan Tan wrote:
> > @@ -99,6 +94,11 @@ static int promisor_remote_config(const char *var, const char *value, void *data
> >  	size_t namelen;
> >  	const char *subkey;
> >
> > +	if (!strcmp(var, "extensions.partialclone")) {
> > +		repository_format_partial_clone = xstrdup(value);
> 
> Can value ever be NULL here? I think the answer is "no, because we check
> earlier in setup.c:handle_extension_v0()", but there is an implicit
> conversion from xstrdup_or_null() to just xstrdup(), which would fault
> if value were to be NULL.

Ah, good catch. I think you're right, but it's better to be defensive
here. I'll add that check and also say that this will be caught by
setup.c.

> Looking deeper, this path is a little confusing to me, since (in the
> pre-image), handle_extension_v0() makes a copy of value and binds it to
> data->partial_clone. But then check_repository_format_gently() makes
> another copy of canidate->partial_clone (which is the same location as
> data->partial_clone).
> 
> So, the extra copy is a little strange to me, because even though the
> copy in handle_extension_v0() is definitely necessary, I'm not certain
> that the one in set_repository_format_partial_clone() is. And this patch
> removes the latter one, which I think is good. But we never free
> repository_format_partial_clone.

Yes, it's also a simplification that we go straight from config to
variable here, instead of going through the candidate struct. As for
freeing repository_format_partial_clone, this is run once and never
again (guarded by "initialized" check) so there is no prior value to
free, and I don't think this variable needs to be freed.

> Maybe that is added in a later patch, let's see...

So I think things are fine here, but in a later patch,
repository_format_partial_clone is moved to the struct repository, which
can be cleared with repo_clear(). I'll need to add a free there :-)

> Thanks,
> Taylor

Thanks for looking at the patch set too.
