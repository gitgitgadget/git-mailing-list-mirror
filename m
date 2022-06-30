Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675DEC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 11:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiF3LN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiF3LN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 07:13:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F99929CA0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 04:13:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id o25so5862360ejm.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nqymfZeZHpaDOaezi8Cvfv7uOPdRDTg8Nlkc8Flk0cs=;
        b=lEpKdQ1E6pjIZWV+0bEGB8czQCaBVH80/1rUXdeGsXZrbO7gRcwJioPjbzEnhVDlXs
         dY7X4TA0omTGB1zwdHVKAuLm7Ne4Ff6mSPAvP7VGpqJbKsWCIaGODVPvUV+e5ZN+AS1x
         EEj1ThC4+Y1ZJ+1dJb7eN0qOxWY3ETbsskbIo3nsmE+KBAXOchUF/ObQeLkBhAkg9nf/
         OT3bD0WTWqRnXJvOynxkICSDkoknRWLigGvEcq/12TIfgFhsbBfrZTlzPUcMGARN4GSE
         dCaoP8rXOtZQ4F9D63at4J/+qo1YTvQqZq4eA1IhuvA2Pelru9u8nOawqn2WqvLRG+DZ
         MK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nqymfZeZHpaDOaezi8Cvfv7uOPdRDTg8Nlkc8Flk0cs=;
        b=7vARLnN8MJtdQIY7ESFcntWddHdgaWnLjghtVJEof+EA7f0tIF1vJj53TpBrdp4XRB
         JQK4F31M8Xd5lJMTzb+xCHzici60xyVHDZPcjhm6X6nPjyJRW265K+Dk3B38olA8Oarv
         I70He6sAnS8/JiPMyGxOoYH7JgIY+occVDE+eykahCxiTfl77bQs+uDqvTmFoTDfTGwP
         h8W6LKJq8T5VivAm5vciTBPGfQlLMPxaHi1Nn5hG+GZd7ruJM4Di+Gauo087gIzjSjDm
         p+gLhVcwYcPwrvoO6Vy0mOEkbb/u5UoGvu4ltHnwVsjTfjV8GsBEx+p0Q2v2emZVQ5jW
         K32A==
X-Gm-Message-State: AJIora8AMVTFT6uf2hewZ0dYLWfqGsb/BugYQBHcYP9tLpWPSHjM1qPO
        /9jHeQhKyMlz76+DXQecxSfjc735bqwMVw==
X-Google-Smtp-Source: AGRyM1usAZZAWiVc7teDhDcCJ4Gsn+rEWPLzK2xhSWUP2BoGUkBzhaJsJ7jnnufL+fAGTap1/u75xw==
X-Received: by 2002:a17:906:cc48:b0:72a:5f44:149e with SMTP id mm8-20020a170906cc4800b0072a5f44149emr2975816ejb.36.1656587636782;
        Thu, 30 Jun 2022 04:13:56 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id lo17-20020a170906fa1100b0072696b3a327sm6181703ejb.187.2022.06.30.04.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 04:13:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6s7P-002Gac-4J;
        Thu, 30 Jun 2022 13:13:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] xdiff: introduce XDL_ALLOC_GROW()
Date:   Thu, 30 Jun 2022 12:54:23 +0200
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <da996677f0730ec7a50d399524fb58c44dad468a.1656516334.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <da996677f0730ec7a50d399524fb58c44dad468a.1656516334.git.gitgitgadget@gmail.com>
Message-ID: <220630.86czeqe74c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 29 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Add a helper to grow an array. This is analogous to ALLOC_GROW() in
> the rest of the codebase but returns =E2=88=921 on allocation failure to
> accommodate other users of libxdiff such as libgit2.

Urm, does it? I just skimmed this, so maybe I missed something, but I
don't see where you changed the definition of xdl_malloc(),
xdl_realloc() etc.

And those are defined as:

	#define xdl_malloc(x) xmalloc(x)
	#define xdl_free(ptr) free(ptr)
	#define xdl_realloc(ptr,x) xrealloc(ptr,x)

And for e.g. xmalloc() we do:

        return do_xmalloc(size, 0);

Where that 0=3Dgently, i.e. we'll die() instead of error(), the xrealloc()
then has no "gently" option.

Is the (pretty glaring, if that's the case) unstated assumption here
that this doesn't in fact return -1 on allocation failure, but you're
expected to replace the underlying xmalloc() with an implementation that
does?

If so I'm doubly confused by this, since you're providing alternatives
to e.g.:

	#define ALLOC_ARRAY(x, alloc) (x) =3D xmalloc(st_mult(sizeof(*(x)), (alloc=
)))

So if that's the plan why would we need an XDL_ALLOC_ARRAY(), can't you
just check that it returns non-NULL?

That's not possible with our current xmalloc(), but ditto for this
series, and apparently the compiler isn't smart enough to yell at you
about that...

I wondered if we were just missing the returns_nonnull attribute, but
playing around with it I couldn't get GCC at least to warn about
checking xmalloc()'s return value for non-NULL.
