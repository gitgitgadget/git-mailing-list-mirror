Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B9EC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266C561039
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbhJGSez (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243688AbhJGSey (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 14:34:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B31C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 11:33:00 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s75so625037pgs.5
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=RL9L9geheTERM6eb4CB/SIH7JGJIqtLKNAvUxOLfrS0=;
        b=OVvTRUI6o/GTNhhEtusWWScrBgofUKyjJkr+YBX4cCL9WaqE1mgBcRC/t2h6Psi5Qv
         cRVEDij+dJ3I+jiJisJOIE19Q+oCkZiYCR8gq4qoyXaSD2ACMe7R/gMu8zcCh4+3oT5T
         dr8DhyJrpcGI8xBdz77zYaRA7tLmQzf5GhdUqfp0O18a3QrtvfxEhr28ui83WojNdUnp
         DcUtvXHzqHdZ97mN4UJNdIzTlyVWk+Gsky6ZeQI3xwVYYsJx/+8TL1j8sM+Oz0Jy3j/O
         2c/aTY2z+h98QJnuw5GI9Pd9oR3EP8uy17OAV2cT2B3ql6K5tYCkqYR02iXAnHal5eK/
         zRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=RL9L9geheTERM6eb4CB/SIH7JGJIqtLKNAvUxOLfrS0=;
        b=th9iFLQZU8PVkJ1Tn16BcDhb+ZfkHlGO1ifYnkV38UaniuXgkPRhX7JXSEDf7b0POQ
         uVMU1Ins4L2glc0U5vygN9r2c5aa0ltcbmvJ1RuA4+6uviSLkyXHtT6RBcZ45uYA3fjo
         2XWeSvIgBV6Yq5aWomFGEyTluGdGPoUdFWyR3jIxuwFIHJe34q6Hq5JbDhKVhEXoVScm
         VhEiXl0dP3Qaj95oK45sb2r+t7j2AjGyYn1eHoX1KpBGL3/egFvdiQ3+Q3kIJl9qYzsx
         CDhTY2b1Z/j/jwoL33a9iiktlL4jrxdJnL360fKLs8xPa8FlA8XtntYPBloK4AsCBkyD
         Wa+A==
X-Gm-Message-State: AOAM533rFmpC7GQ6YlMz1n6iTX0yOJ3vMz3uRkDf46wu2NcVxvSkIEzd
        lcNgI9ouNVZbDykq9Vmxqr0DJHfCMh0jaA==
X-Google-Smtp-Source: ABdhPJxHAKFZ3WN0yS6BGe6JXn7DcqT8n1zvDVE6TXVh4oIDZF0lRpjRtH8vJFcrEtnzLMpI/WUUZQ==
X-Received: by 2002:a63:530e:: with SMTP id h14mr938423pgb.279.1633631579613;
        Thu, 07 Oct 2021 11:32:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf7:7c1c:a2ca:e52a])
        by smtp.gmail.com with ESMTPSA id c9sm43649pgq.58.2021.10.07.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:32:58 -0700 (PDT)
Date:   Thu, 7 Oct 2021 11:32:52 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/7] No more adding submodule ODB as alternate
Message-ID: <YV89VKzIghVEPZ1K@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1632242495.git.jonathantanmy@google.com>
 <cover.1632956589.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1632956589.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2021.09.29 16:06, Jonathan Tan wrote:
> This is on a merge of jk/ref-paranoia and jt/add-submodule-odb-clean-up
> (same as v2).
> 
> Here's the same patch set except that the repo is plumbed into the ref
> stores. (Iterators currently do not have any reference to their ref
> stores, so some of them still need repo fields. But because the ref
> stores now know their repos, calling code does not need to pass a repo
> when these iterators are instantiated.)
> 
> As you can see from the shorter patch list, this eliminates the need for
> some patches.
> 
> Jonathan Tan (7):
>   refs: plumb repo into ref stores
>   refs: teach arbitrary repo support to iterators
>   refs: peeling non-the_repository iterators is BUG
>   merge-{ort,recursive}: remove add_submodule_odb()
>   object-file: only register submodule ODB if needed
>   submodule: pass repo to check_has_commit()
>   submodule: trace adding submodule ODB as alternate

This is a summary of discussion from our Review Club meeting today;
feedback comes from Jonathan Nieder, Emily Shaffer, Glen Choo, and
me.

(Side note for the list: we're trying to be more open with our Review
Club meetings. If you're interested in having video-chat discussions of
patch series with us every other week, please get in touch with me.)

Summary: this series looks good to me, with a few nits (replied to the
patches directly for these). So, once those are addressed, this series
has my
Reviewed-by: Josh Steadmon <steadmon@google.com>

Eliminating submodules as alternates has (at least) a couple of nice
benefits, namely:
* we don't have to scan through the alternates one by one looking
  for missing objects
* having submodule objects show up as alternates makes it tricky to
  support partial clones of submodules, since the partial clone
  machinery doesn't know to talk to the submodule remote to find its
  objects

This series builds on the approach in
jt/grep-wo-submodule-odb-as-alternate, which recently graduated to
master. Specifically, we plumb `struct repository` pointers to various
places that previously relied on `the_repository`, then we use
GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB to show that no code paths in the
test suite still rely on registering submodules as alternates.

Specifically to this series, we're adding struct repository pointers to
`struct ref_store` and various iterators. This seems reasonable as we
don't keep a lot of these structs around, so the additional memory usage
isn't much of a concern.

Thanks for this series, really glad to see the end of submodule
alternates!
