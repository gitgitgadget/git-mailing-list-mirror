Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2263C20133
	for <e@80x24.org>; Mon,  6 Mar 2017 19:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbdCFT7w (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 14:59:52 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35134 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753624AbdCFT7u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 14:59:50 -0500
Received: by mail-pf0-f172.google.com with SMTP id j5so64652092pfb.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xzNoX+7EWGs/nvsNyCfdxUFcpQgw9hE3VBk0AkroNfc=;
        b=lNdAIgtMSmcABaHY1JvcGVigMT3YCHxnB46qiV2icObC/RJzG/fQzpdok+WBDsrtzi
         Qn3eFXmwkEMxhfbOiqXsuZaZUs5nHs8uAMewxQ3fvE1oD6tOj+RQLu7VW3opgqrUQxFQ
         XRYylMWdZ+Ivd9RsmofkX5JYLnFi0YEFFtITL6SjCu/j/hepeqlStWl5cvwZmUbMdGJ6
         FsgsBoWBUtw0vA/Bhg+sNCTKqmIMJ8D0To2ox16xSj8yycQ1V8c0impOIfp1BFmF9yAo
         sUQQZHERYTxSWSxhvgDYHO4HyHOezUtfawASjLdETszv7yX6pkxhSOIXy2eo4tgm04II
         eohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xzNoX+7EWGs/nvsNyCfdxUFcpQgw9hE3VBk0AkroNfc=;
        b=Es61bcq4jBh03tJFBP3vGaee+qccxs7RZcOh/UhQfK+JQwI2ugCx+mjXvukZmdBgCH
         ItN+Yt2abLs3z8SD2GkgX8lLQ9x8H9AbSgWYEfcsaodghFbfF8vg59uKfvZZQ0/BXC5u
         YLG8CFywGPwWjOmUjS8nn0n2WC9NAVNxNLvO/FRoLHaiW7j8Q6LShydS7Um3z9Hr5gxO
         xYfGpQP71/TeP2img8ey/iOKHvA3qskHaJS57vZNODLU9yN8+/e3If4zZmVFGQS6+rZ9
         kLtdIWG2UE97PdQ5twTvIto/ttJSnuLPKsNcJcuBMrlO92sZ8TGJMOD6rcImAS4Kzzq8
         E6Mw==
X-Gm-Message-State: AMke39nUn98eDWV6BF7YjtdLweaRTN9frqUcLFWeyyTxoFOqcjPyAt8+5E7s60S4wi+u+w+kgzm2PbLfTCCdzT5S
X-Received: by 10.99.247.83 with SMTP id f19mr22445337pgk.158.1488830364571;
 Mon, 06 Mar 2017 11:59:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 6 Mar 2017 11:59:24 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Mar 2017 11:59:24 -0800
Message-ID: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
Subject: [Request for Documentation] Differentiate signed (commits/tags/pushes)
To:     tom@oxix.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When discussing migrating to a new hashing function, I tried to learn
about the subtleties of the different things that can be gpg-signed in
Git.

What is the difference between signed commits and tags?
(Not from a technical perspective, but for the end user)

Both of them certify that a given tree is the desired
content for your repository, but git-tag seems to be designed for
conveying a trusted state to collaborators, whereas git-commit
is primarily designed to just record a state.

So in which case would I want to use a signed commit?
(which then overlaps with signed pushes)

A signed push can certify that a given payload (consisting
of multiple commits on possibly multiple branches) was transmitted
to a remote, which can be recorded by the remote as e.g. a proof
of work.

The man page of git-commit doesn't discuss gpg signing at all,
git-tag has some discussion on how to properly use tags. Maybe
there we could have a discussion on when not to use tags, but
rather signed commits?

Off list I was told gpg-signed commits are a "checkbox feature",
i.e. no real world workflow would actually use it. (That's a bold
statement, someone has to use it as there was enough interest
to implement it, no?)

Thanks,
Stefan
