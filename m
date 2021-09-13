Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F942C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 23:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3906760F51
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 23:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350245AbhIMXUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 19:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349899AbhIMXTm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 19:19:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92E5C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 16:15:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso701050pjj.0
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 16:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b0/tpqbpdZlnblxT14smsx+OWX7mk3d7sgv6QI4WO1g=;
        b=a1rCb76JotMzj4AtWJeaUOyl0mG0gQqUQ2+FwXet9ArqDAzbrcmTXj/72h+PNuThce
         eXLxOSLlhstJe6uq5XUJTtL9SD3xeDOe6U9m7P3vDR2RB0z/GPxhEL+yo0qdRDR8vie1
         1TK9E1ZUvRtkyH6yISjC3gdmjBX42uBCYLSBPPj3fxUtdQ4NDB3v+ozcwGyhQdeUuBPo
         VZQPtOVvO4R21FTqhEbvKlrhKrNszDbU6/t3dMf1j7z7UWxNI9iHMnAIiIY7qb5Z6CkG
         DtBb1BCwtgZpLFPWJQ90Iisn2Rk29vZcwuo3aEucv1Gr1j1wgNoGvL0p66R8P8S4refI
         Vpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b0/tpqbpdZlnblxT14smsx+OWX7mk3d7sgv6QI4WO1g=;
        b=vjwdPdOMrLOYBPg1k7Z4DjtoDf2KAd8urDqc8+NJ/JRqb4V4OQaTkuNzrHN5/J2s8C
         QVHRSDdtwG8smvCwtH1XGHbC8vGfJA9OA0KuqAC+c/PvX/gl/uZogCfOdnZWGGERAMtE
         JXHbS6AD8ntOR18PwxwKvEhlllvt+HcOpwa+uvUugW5hRx7mgFQrbilnbne+yogFINKJ
         betgmdMaxsbgpXuIZD7g77W27nyKAxsQ+MlxGwFbKVYOL1PySlWeL6VzsUm/2+Lz78QT
         xnFdpRkdkOlfBIbUkhJZoZdOtgUWXNZDvm14vpDi+jVffgqN/5hBvSWECOjB8dQGn7h8
         acUQ==
X-Gm-Message-State: AOAM530YXfLryOCQKuhY6rGyDR4aVFwoZhH1To4XjvgqvW92ZDj5Remy
        y/jAwdWWwofavd1kUdxcHdU5ry8rAyaL5w==
X-Google-Smtp-Source: ABdhPJxU3jjpmhHmwTHDElw/7TmIbgzmnQ2OPe6zBRqmyHyAhIpjIcaSjvifwgNBpP8ZBZxCpsSHnQ==
X-Received: by 2002:a17:902:bb17:b0:13b:963f:1461 with SMTP id im23-20020a170902bb1700b0013b963f1461mr6380472plb.1.1631574912992;
        Mon, 13 Sep 2021 16:15:12 -0700 (PDT)
Received: from chooglen-macbookpro.roam.corp.google.com ([2620:15c:2d1:206:e0f3:f273:4f88:dfe1])
        by smtp.gmail.com with ESMTPSA id v7sm7660870pjg.34.2021.09.13.16.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 16:15:12 -0700 (PDT)
From:   Glen Choo <chooglen@google.com>
X-Google-Original-From: Glen Choo <chooglen@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 13 Sep 2021 16:15:09 -0700
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH 1/3] fsck: verify commit graph when implicitly enabled
Message-ID: <YT/bfZu5mnMMqq0z@chooglen-macbookpro.roam.corp.google.com>
References: <20210913181221.42635-1-chooglen@google.com>
 <20210913181221.42635-2-chooglen@google.com>
 <YT+mlW851sRyt842@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT+mlW851sRyt842@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the thorough review! I really appreciate it :)

On Mon, Sep 13, 2021 at 03:29:25PM -0400, Taylor Blau wrote:
> Small nit; "the_repository->settings()" should be spelled as
> "the_repository->settings", since "settings" is not a function.

Oh that's a good catch. Thanks!

> It may be worth noting that this was totally fine before
> core.commitGraph's default changed to true. That happened in 31b1de6a09
> (commit-graph: turn on commit-graph by default, 2019-08-13), which is
> the first time this sort of regression would have appeared.

Sounds good, I'll note that down.

> Nit; I recommend replacing the `-c` style configuration with
> `test_config`, which modifies `$GIT_DIR/config` but only for the
> duration of the sub-shell.

Sounds good. This works great :)

> > +	cd "$TRASH_DIRECTORY/full" &&
> > +	git fsck &&
> > +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> > +		"incorrect checksum" &&
> > +        git config --unset core.commitGraph &&
> 
> But I'm not aware of a way to temporarily unset a configuration variable
> for the duration of a test, so here I would probably write:
> 
>     test_must_fail git -c core.commitGraph= fsck
> 
> which Git interprets as "pretend this variable is unset in-core".

From my testing, I suspect that git does not pretend the variable is
unset, but rather, it pretends that the variable is set to the empty
string. It seems that git behaves as if the variable is set to "false".
This is called out in Documentation/git.txt:

  Including the equals but with an empty value (like `git -c
  foo.bar= ...`) sets `foo.bar` to the empty string which `git config
  --type=bool` will convert to `false`.

If the variable really is set to false, how might we proceed here? Shall
we stick with test_when_finished?
