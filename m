Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A1501F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbfHVQZj (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:25:39 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34647 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbfHVQZj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 12:25:39 -0400
Received: by mail-pf1-f201.google.com with SMTP id i2so4390632pfe.1
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ImGu+3HRwxw26INoG2rJF7A3DHPaUWGe/WElk2lDQCY=;
        b=aastEBMHiQ14sXhUFtRduepHxSoit6q/m2/Fzl+6XhocIZPwsUDOyj4HWRFngS3/7T
         5eyzp6ewPpxBmSl92iRPVxGYY0HnrPbi4DlbdArtRqfM1y4Ebpz9ALYTiwJTdVCu1Tjg
         hdH85qliqp6ZCTGsfbG7zuJbntvkgx1xufL9uCwEgT+Ivow+GNBcIhdVQxbIv2fN0K8i
         5mE5VTl7wIfx0hXeJ95FCxnbjT634TGmLs6ce2iIOHGrK0XBG5rCSSYVCFqBXZ8T33cp
         q1yC58ybXXgIqkkdgazwwxSiajGWrZiDNIUGI6UDNKrh0gWxPMA8z5L8Rl8P+hZddxTo
         Ch+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ImGu+3HRwxw26INoG2rJF7A3DHPaUWGe/WElk2lDQCY=;
        b=SccDJkddtOq3n/pRATkhVpU5equTEDdQo7krxasxxvrVRhKLq6cbvC3628eoZv35NO
         AW9j/zR3DaKaJPBOGnrU88HUGGHGA59VGZl4Z7X8BBNXj1drwA2BsC1ypTxrEp59DelA
         42PJ2wBUEvX342pD4T6GvTVi1/8KGLwWeQ51BnT/SfaFdXUTkQw8OZXsYYSai7kSra48
         rFy3pdKzlswKSIhjL1dtbZXBjgHhDVOzwbiqWlz8JM+tLXZ9KlaH6smuCQ3NTdbZn/cL
         oCCDbPtFDm5Arlnk7ng0wDUlVd9GM7zC3zm3tOt8K6JRSzhCG2zkNVjsVBAF16icyfbg
         pG+w==
X-Gm-Message-State: APjAAAWApvSanitSkMkCjsH9TkQGJGeBFDWjhRCuwHgZdJtsv0KsiGZF
        1MMtxBobXrzB3gVxt2ZAInTCjnTMoN0gTWptY+sl
X-Google-Smtp-Source: APXvYqxvrg/KM8U+krJLdK2XT09iubB2Rg7V30nyVoOai5kGIL7ns8Q71+TQcV0vjri3jbOdPvYfwU5mAaVoRwK1jkwJ
X-Received: by 2002:a63:7a01:: with SMTP id v1mr107018pgc.310.1566491137842;
 Thu, 22 Aug 2019 09:25:37 -0700 (PDT)
Date:   Thu, 22 Aug 2019 09:25:34 -0700
In-Reply-To: <20190822041529.GA4347@sigill.intra.peff.net>
Message-Id: <20190822162534.17365-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190822041529.GA4347@sigill.intra.peff.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: Re: [PATCH] diff: skip GITLINK when lazy fetching missing objs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I wondered what would happen when it does not succeed. It looks like the
> whole diff process just dies.
> 
> The batch fetch is purely an optimization, because we'd eventually fetch
> the individual objects on demand. If the batch one fails, should we
> continue with the operation? That leaves any error-handling for the
> overall operation to the "real" code. And it would also mean that this
> bug became an annoying error message,

On the one hand, if the batch fetch fails, then the individual
prefetching would likely fail as well. But on the other hand, as you
said below, we sometimes extraneously fetch objects, so making the batch
fetch non-fatal might be a good idea too.

> But certainly your fix is the right thing to do regardless.
> 
> Tangential to your fix, but I also noticed while poking at this that
> we're pretty aggressive about fetching objects, even if they won't be
> needed. I know we touched on this briefly when discussing the original
> patch, and the logic can get pretty complicated, so we punted. But there
> are a few cases that I think might have a good cost/benefit ratio:
> 
>   1. a --raw diff without renames doesn't need the blobs (and even with
>      renames, it only needs added/deleted entries). I imagine that being
>      able to "git log --raw" on a full history without pulling in a
>      bunch of blobs might be worthwhile (and a fairly common operation).
> 
>   2. Files that exceed bigFileThreshold or are marked as binary via
>      gitattributes will generally be skipped during the file-level diff,
>      without even loading them. These are the minority of files, but
>      they also have an outsized cost to fetching them (and in fact may
>      be the very thing people are trying to avoid with a blob filter).
> 
> Again, not anything to hold up your patch, but just cataloging some
> future work for this area.

Good points. Thanks.
