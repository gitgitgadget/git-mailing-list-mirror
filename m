Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC54C64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 19:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBWTzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBWTzT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 14:55:19 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A71859E4D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:55:18 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id n2so11897349lfb.12
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SSPhkHSe/5NNh7/+tkS2eyy2GZSu2bbJyg/q6ifzVu0=;
        b=idga/qcnH4zaqufP8sTzQhiREwKOiaU2tU4Ruwi+2LQ9WK8EARXMJBjzkSvotpULPY
         JuFxjfchNiQIVefVLhBaBssLrmA2pWniBmx7EirXHmRo4Ln8z/6IXadwaFeXwe6WcY4F
         /FJ+jpDfeistCB2b9WKkq726+e8ya1UAX2IBxDY93qwZJJ6N9yRaZc/sv73KqRn0AYpO
         pOqqxl/yt7PuEZ/wxU2P6TYVs5TKVqAFr3iDUCznsUq+d3sTgqW33kclsFg9YSHDsrhE
         ZT5Ma/l7kYNfgOMKSDMSrZjRrYjdWTJD2ydzQxyhv6ZSmbGCOXr7KFPJkKJzIzR7Wydv
         MyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSPhkHSe/5NNh7/+tkS2eyy2GZSu2bbJyg/q6ifzVu0=;
        b=GyFHddKZ/MXCSdSkVy0tx1E6DQKRJDJshBdeH64Vk105ll5APThycVvhrMOjzNyKUR
         vBBfp+eYQZlKUffHCInPLtQuy43NdJ7qeTVmQ9Yl3QuLszK/3ST+RBGg+wSbZqgdpWSE
         YZpWGQNTE78GmqdAilSwFwxnE4oVsPaHzjUCXZa3zpob/ARaWY1PTlbM3kMAgq5yRC44
         LVNiONDXbW0FLnH73NZAM/h8Y7j0iUtXWHKKEzoC5/4dBM95BHWthIIFHHYSK1bcC761
         lOFiEiGSm8Pc9qPlJ1kOGoRStLPr+CGvefMjf4qyVpklLrAHAkn1eU+1Mn328eakBWRj
         ANKw==
X-Gm-Message-State: AO0yUKXb8r02z0LZGaVQDfCkZTXw7pL3et5RmAEDCtgP6nJIBtA82igp
        JzkJRHKu7jtu2OsI/bbRjSLxbVH0Dm0ldY6jEGg=
X-Google-Smtp-Source: AK7set/MmxsvrnqKXw27HO1KgFB6g9SQs9djiLRkR577E1en5rEP/4lC+d259QarYhKw7oUTrbaPy4zFdf1q55dHW2o=
X-Received: by 2002:a05:6512:39c4:b0:4db:1e7d:5d42 with SMTP id
 k4-20020a05651239c400b004db1e7d5d42mr5320067lfu.0.1677182116221; Thu, 23 Feb
 2023 11:55:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <1357f18db5601cf4fc68a56a2e846d2aed6ad6b6.1677139522.git.gitgitgadget@gmail.com>
 <e2948915-8505-2657-7283-e845804dde0d@github.com>
In-Reply-To: <e2948915-8505-2657-7283-e845804dde0d@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Feb 2023 11:55:03 -0800
Message-ID: <CABPp-BER8T-vyMK8Wnt0f85GguvRfLv1K6drmWS=e-ikfzmOag@mail.gmail.com>
Subject: Re: [PATCH 10/16] object.h: stop depending on cache.h; make cache.h
 depend on object.h
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 6:17 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Things should be able to depend on object.h without pulling in all of
> > cache.h.  Move an enum to allow this.
> >
> > Note that a couple files previously depended on things brought in
> > through cache.h indirectly (revision.h -> commit.h -> object.h ->
> > cache.h).  As such, this change requires making existing dependencies
> > more explicit in two files.
>
> > diff --git a/diff.h b/diff.h
> > index 41eb2c3d428..b90036f5294 100644
> > --- a/diff.h
> > +++ b/diff.h
> > @@ -8,6 +8,7 @@
> >  #include "pathspec.h"
> >  #include "object.h"
> >  #include "oidset.h"
> > +#include "strbuf.h"
> >
> >  /**
> >   * The diff API is for programs that compare two sets of files (e.g. two trees,
> > @@ -71,7 +72,6 @@ struct oid_array;
> >  struct option;
> >  struct repository;
> >  struct rev_info;
> > -struct strbuf;
> >  struct userdiff_driver;
>
> This inclusion of strbuf.h in diff.h seems like a step in the
> opposite direction. What caused you to need to do this?
>
> Looking ahead at the patch titles, I see you will revisit diff.h
> in the final patch, so I'll try to see if there are effects there.

Later in diff.h there is a struct defined which includes a direct
'struct strbuf'.  As such, a forward declaration is incorrect, and the
code only worked previously because diff.h included strbuf.h
indirectly (through object.h -> cache.h -> strbuf.h).  Now that
object.h no longer includes cache.h, we have to correct this error.

> > diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> > index 1fe393f4473..ef03b45132e 100644
> > --- a/list-objects-filter-options.h
> > +++ b/list-objects-filter-options.h
> > @@ -1,9 +1,10 @@
> >  #ifndef LIST_OBJECTS_FILTER_OPTIONS_H
> >  #define LIST_OBJECTS_FILTER_OPTIONS_H
> >
> > -#include "cache.h"
> > +#include "object.h"
> >  #include "parse-options.h"
> >  #include "string-list.h"
> > +#include "strbuf.h"
>
> Here's another case of including strbuf.h instead of declaring
> 'struct strbuf'. However, it makes a bit more sense because you
> are deleting the cache.h include in this change. It would still
> be nice if we didn't need to do it.

Same issue; struct list_objects_filter_options includes an embedded
struct strbuf, so the strbuf header needs to be included.


I'll call these out specifically in the commit message.
