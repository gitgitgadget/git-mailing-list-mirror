Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6347CC77B61
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 07:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDPHJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 03:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPHJL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 03:09:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFED2707
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 00:09:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id jg21so55917457ejc.2
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 00:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681628948; x=1684220948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6RBSGJM+nEjCrMrqq6zcQOu21mpXMvEu0aQkxiiU7s=;
        b=Zs2JS3o3Fc9ytwP4BIyG3I6oqJ/NNKJvpxMoOkAWzpnoKgzxZEphiWRyOZn7AQJU4X
         nbKwIvDKyXu6jPHOiLNI6oLKxcuEx22YM2aELwcujQ3MwFCxtXCYArUVb0HqiF/t2KL+
         QZjKshZ9L+KfDVe3Ln1RcPp3YvYSa1PneDK13+1BbxSdElArw6TqelFaBtdx0l+3/tcc
         9aAAQA2wby3h9IxbLqHrLZ8i6d7ccyTy7YLWMcl1Mp9CBQT70zQaob7Rpd7z/QOR8Jrj
         5Ng4onsk0mE4UP6V63xE50iCcj8UnNAcNBJabHs1wn7LiHCgtBFKWAplM0gL5BVpOZHY
         P5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681628948; x=1684220948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6RBSGJM+nEjCrMrqq6zcQOu21mpXMvEu0aQkxiiU7s=;
        b=OyP1322mnev5cj2XO+JO6SmizO9aHvq+x1/wnNLu/RtFeSYMBtD5Kt7WkqeUBDxgbC
         +XCuxPH6LtYdos4wCJlj9DZDI82idt1MuWU7OBLnwKmJRnwmvOOkgqPI8aRfu1/7EKZB
         P1N9knTGCutf8R530JL0DmidOQOJh+FzCHsQMgYPUbIBFZSr8P5UfgIY0v3RkN/D1Da2
         6uh9gJfUR5zEnOP7oJG/YdgK6DHV9CwbibJr1uens6zwBZk9aWl+YXHEOHjfZJ81SCDs
         w3rnz6mUHrgR5uBw6eJKd9PNzFDjKWLP+tN+GnYszFDIA9fnZrAlY02aeyS/ol7WZJv5
         7mEg==
X-Gm-Message-State: AAQBX9efpP4UkBgsJmfUoVClZCwFkIHqWUwHnFADSxkp+GzKKIIYDZ/o
        rkyp9UuhMhFXddpOIrQKJS0=
X-Google-Smtp-Source: AKy350ZsEQb9wOqTB5ZwnjnVWRZ+cjO79leTCgjF2GB04G62lyZf49tG3iD7kkBLPLeJ+as/pj8Pqg==
X-Received: by 2002:a17:906:82c9:b0:933:1134:be1e with SMTP id a9-20020a17090682c900b009331134be1emr4045118ejy.53.1681628948324;
        Sun, 16 Apr 2023 00:09:08 -0700 (PDT)
Received: from localhost (92-249-246-116.pool.digikabel.hu. [92.249.246.116])
        by smtp.gmail.com with ESMTPSA id w18-20020a1709064a1200b0094e92b50076sm4704455eju.133.2023.04.16.00.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 00:09:07 -0700 (PDT)
Date:   Sun, 16 Apr 2023 09:09:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Rohit Ner <rohitner1@gmail.com>,
        Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: git log causing hang while browsing upstream linux
Message-ID: <20230416070906.GA3271@szeder.dev>
References: <CAKazavxTXwcZFtL2XyU3MpaUR=snWY8w8Lwpco+mkbqm2nWE=w@mail.gmail.com>
 <5b99135f-c1d4-434b-b508-35f5d66dd2bb@app.fastmail.com>
 <b5316855-971d-4b7b-89cd-e81ececc5124@app.fastmail.com>
 <CAKazavzS112w3wsxnA-2ibWH3xGrE_w7Av+VZg-DfgfH0aK72A@mail.gmail.com>
 <ZDSjBQhyDBGi9wBN@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDSjBQhyDBGi9wBN@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 08:00:05PM -0400, Taylor Blau wrote:
> On Mon, Apr 10, 2023 at 10:37:15PM +0530, Rohit Ner wrote:
> > I have not given the command more than 10 seconds, shouldn't the
> > intended behaviour be to render the visible subgraph first?
> 
> This is possible with Git's "commit-graph" feature, which you can read
> about starting here:
> 
> 		https://devblogs.microsoft.com/devops/supercharging-the-git-commit-graph/
> 
> TL;DR: if you run "git commit-graph write"

Please never recommend 'git commit-graph write' without '--reachable';
scanning all packed objects to find commits to include in the
commit-graph is just too inefficient for that.

> once before running "git log
> --oneline --graph", you'll get near-instantaneous results.

The commit-graph has been enabled by default in v2.24.0, released over
three years ago.  I wonder why Rohit's and/or Kristoffer's repos
didn't have it already?!

