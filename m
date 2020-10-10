Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1578C433E7
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5358C207CD
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 07:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdrDjo7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgJJH2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgJJHZv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 03:25:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D1FC0613CF
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 00:25:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e2so11866651wme.1
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 00:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Wu3YKHTfzS+H3/ASJX5RzVANnzAaW7gByJldZMQ2gV0=;
        b=jdrDjo7B/fDAQl1NV6+WQnzSELDeczVuIN/UFnsR+jYL4TaGru7cI3RIkq2EBSmftY
         6wGpy+1CQY8GI8sOrjZNBTCXlWhQnM9v0sxCeSJg+xCj9+jtwvJZrObBgZLqpqdWpfCC
         4Tw2uS2cu+HeymPKhFzLM1m0ZYWYkRRKuuICDNv/NtsJO3GVhYETSl6Zijt4+yN0+t/O
         VWRdtEYY2siPwcQmxKEOpOaUKJp+HuLpMyNFfsV34e/vPr4F+PrMIQTHNuWc6SQMqpme
         /bsoqC7X8wfwZcKWB86Y8iSdSMQC90sLB0JRMAa4imW4dNMwcJMVtXdZs2VhjharSJUw
         96gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Wu3YKHTfzS+H3/ASJX5RzVANnzAaW7gByJldZMQ2gV0=;
        b=VcWGq1nKhbKw2eJEtZnCyT2T/EpE15LwIm+zpUQa8sqSojVUzH0uRogjQPQ01WiWNu
         MaHCEbCGYz4RtdqS9Oi8YenKc8EboBJaPLm5HuM3ixJ0oJ17Vf/A+/+X0IVW6qcOcg9U
         AKKO9vvVeP3fcVsFdbhiTfPwZ0OJc2tbEvMIdmdqJjUIayNv4DDyZzRvgzr7uNU9i9wq
         fjLEfoqkySM3w0YMSn+XyGluO4HPzX+x8y8SF47NoHzZ/iQ4zRSE1OLmD0jV4PklK5v6
         Ql9fazwLt6aYlL+xz8NObjP1o4xP9hJxaD5ALT3Ta0GZUwwNFUEo1hs6znxE6AMxZb01
         Wd/Q==
X-Gm-Message-State: AOAM530q1xBXehIU+P+xEqPNGFvuDk9uK6p7lkFNxVFrxw6Cm+2qhOCH
        R68+bnhyF7tqEkR+1XkzpoY=
X-Google-Smtp-Source: ABdhPJxwc6+seFrqDHtFBYJfqHYf+C/6Wj9/fFjAhyWDjTLcZz+hMGmOk959IMvkqvscbOw8XNAuIw==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr1660619wmb.129.1602314710787;
        Sat, 10 Oct 2020 00:25:10 -0700 (PDT)
Received: from szeder.dev (92-249-246-51.pool.digikabel.hu. [92.249.246.51])
        by smtp.gmail.com with ESMTPSA id r68sm9487816wmr.37.2020.10.10.00.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Oct 2020 00:25:10 -0700 (PDT)
Date:   Sat, 10 Oct 2020 09:25:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ci: skip GitHub workflow runs for already-tested
 commits/trees
Message-ID: <20201010072508.GD24813@szeder.dev>
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com>
 <pull.619.v2.git.1602170976.gitgitgadget@gmail.com>
 <914868d558b1aa8ebec6e9196c5ae83a2bd566bf.1602170976.git.gitgitgadget@gmail.com>
 <20201009072922.GC24813@szeder.dev>
 <nycvar.QRO.7.76.6.2010091254180.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2010091254180.50@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 09, 2020 at 01:13:03PM +0200, Johannes Schindelin wrote:
> Hi Gábor,
> 
> On Fri, 9 Oct 2020, SZEDER Gábor wrote:
> 
> > On Thu, Oct 08, 2020 at 03:29:34PM +0000, Johannes Schindelin via GitGitGadget wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > When pushing a commit that has already passed a CI or PR build
> > > successfully, it makes sense to save some energy and time and skip the
> > > new build.
> > >
> > > Let's teach our GitHub workflow to do that.
> > >
> > > For good measure, we also compare the tree ID, which is what we actually
> > > test (the commit ID might have changed due to a reworded commit message,
> > > which should not affect the outcome of the run).
> >
> > We have been doing this on Travis CI for a few years now.  Does that
> > approach not work on GitHub actions?  Please explain in the commit
> > message why a different approach is taken here.
> 
> You're not being terribly clear about what exactly "We have been doing".
> 
> Are you referring to the `skip_good_tree()` function that stores
> information in a file in the `good_trees_file`?

Yes, in the commit message you pretty accurately described the exact
purpose of that function.

> If so, no, we cannot do that anywhere else than on Travis because that
> relies on a directory that is somehow shared between runs. And that is a
> feature that only Travis offers as far as I know (and it does not come
> without issues, e.g. when two concurrent runs try to write to the same
> file at the same time).

Every branchname-job combination has its own cache, and while the job
is running it writes to a local copy of its own cache, so concurrent
runs don't seem to be an issue.

> Since this strategy relies on a Travis-only feature that does not work on
> the three other CI services we use (Cirrus CI, Azure DevOps, GitHub
> Actions), I see little point mentioning it in this commit message...

This commit duplicates already existing functionality, so, yes, the
commit message should definitely have explained why that already
existing approach was not suitable for GitHub Actions.

