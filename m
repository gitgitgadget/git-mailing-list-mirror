Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD37AC4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 20:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKTUqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 15:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKTUqu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 15:46:50 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165192872C
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 12:46:49 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vv4so15185532ejc.2
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 12:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4sWEbdFpoNIb7USq/q2QiNWeaytZw4tJgoSeKFh8E4k=;
        b=CHdunFfXYTk2VZ8nyPJ7PjYhMozfdPyJTKY3hFAAyn1zrBL4CNQLCk6CXoSFRrhiXt
         EZwIuSyh254TWf8ARHd4b5tqzPyIL68MZO2hlY/mTfT1MctkdDupj12aAmFdikBcbjQo
         Uo8/x4KMQIfJK3VJRZRR8ULrDCniinxJNWS9UXJS50325wiXoGNv93ZTLNGvDgr02gOS
         Cg3jF4FtO5LPdoFT9DiK3AXDKJTpgpGtdGNNa/CELsEAfXhgVp2wVF2nSru4Xk4Nb2ns
         GFiW64SMw8TpKVp72VEyyo1OFfWktsPwhMtlr2HmqFgilossCt2qFbUObk5awSZJXjc+
         Wyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sWEbdFpoNIb7USq/q2QiNWeaytZw4tJgoSeKFh8E4k=;
        b=kEQPPR6VxW3/bVbOppxEE56gOkZDQKfCeudz8z80bWByqRw88GbZAVx6lS/51eQcLr
         lz0KTHvAYwRSkrpD2ogPecOjZhTE6rRfOHNCpyqpz4s8PO/7zSh9FWIXgVSBlsrOLsev
         B02pKgWLZDWdVApmA/CmVaWRhf4tIWlW/eEjkvOhsTddzQjTC7DukE+wVL8tlcdQP0Bp
         TF9Ge7kRvQpMBPG7hKJM0B8v7j6AMzk6RL4a9akZP21qvqQIn7/wzXTqJkmmSisVOkBl
         fQO7Su5tAgnjxcL5G58x576bMVY2eDlftkvys2GCOHNSGI4vl6p4k4BqFJdYi81lhddb
         ewtQ==
X-Gm-Message-State: ANoB5pk1xIHIEacm8fnKxkGMtweAXV/pzl/7dB+2r1BMjGLk1RSpmY7w
        OtUTqYQU6F+05bHQi1dS/Mw=
X-Google-Smtp-Source: AA0mqf72J9HHYxh5bH143mXKqxGXNzaDDSPbRBh8BL3PBz45E7N+a26855QU7bVGG0bERXGJyjMfeA==
X-Received: by 2002:a17:906:b14b:b0:78d:cede:91f4 with SMTP id bt11-20020a170906b14b00b0078dcede91f4mr13027742ejb.764.1668977207597;
        Sun, 20 Nov 2022 12:46:47 -0800 (PST)
Received: from localhost (94-21-23-70.pool.digikabel.hu. [94.21.23.70])
        by smtp.gmail.com with ESMTPSA id mb22-20020a170906eb1600b0077f20a722dfsm4229443ejb.165.2022.11.20.12.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 12:46:47 -0800 (PST)
Date:   Sun, 20 Nov 2022 21:46:46 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Alison Winters via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alison Winters <alisonatwork@outlook.com>
Subject: Re: [PATCH 2/2] completion: add case-insensitive match of pseudorefs
Message-ID: <20221120204646.GD4039@szeder.dev>
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
 <c455e855395dcc9215ea4ce3181eb3cbaff4000b.1667669315.git.gitgitgadget@gmail.com>
 <20221120204232.GC4039@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221120204232.GC4039@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 20, 2022 at 09:42:32PM +0100, SZEDER Gábor wrote:
> On Sat, Nov 05, 2022 at 05:28:35PM +0000, Alison Winters via GitGitGadget wrote:
> > From: Alison Winters <alisonatwork@outlook.com>
> > 
> > When GIT_COMPLETION_IGNORE_CASE=1, also allow lowercase completion text
> > like "head" to match HEAD and other pseudorefs.
> > 
> > Signed-off-by: Alison Winters <alisonatwork@outlook.com>
> > ---
> >  contrib/completion/git-completion.bash | 10 +++++++---
> >  t/t9902-completion.sh                  | 16 ++++++++++++++++
> >  2 files changed, 23 insertions(+), 3 deletions(-)
> > 
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 8ed96a5b8b6..161327057da 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -745,6 +745,7 @@ __git_refs ()
> >  	local format refs
> >  	local pfx="${3-}" cur_="${4-$cur}" sfx="${5-}"
> >  	local match="${4-}"
> > +	local umatch="${4-}"
> 
> Why 'umatch' and not 'imatch'?

Gah, because it's all _u_pper case, as can be seen in the next hunk,
that's why.

> >  	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
> >  	local ignore_case=""
> >  
> > @@ -772,6 +773,8 @@ __git_refs ()
> >  	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
> >  	then
> >  		ignore_case="--ignore-case"
> > +		# use tr instead of ${match,^^} to preserve bash 3.2 compatibility
> 
> Thank you for keeping compatibility with old versions in mind!
> 
> > +		umatch=$(echo "$match" | tr a-z A-Z 2> /dev/null || echo "$match")
> 
