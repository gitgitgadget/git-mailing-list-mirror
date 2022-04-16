Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744F9C433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 02:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiDPCv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiDPCv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 22:51:28 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CF510E7
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:48:57 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id ay36-20020a05622a22a400b002f1d1702432so6063597qtb.14
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fjJLjnueo71jaPKVwb+Si5R+XwooGSjNLuYVVy4lLqY=;
        b=pQNhr2ogZAc7Xo9FISQPk5SNnyues9hPhWP+Yz/ysL5XUr7sCWkkr5qcZ5LPSOY+pt
         iKKpjvxq9CVqqVqiO0VFz+5VRjH7L3HPlthxo48vjSP0wa1XMhWfVa0m60fFQGwlKgdl
         +oIjo68THVSXZmtB9awnV3VVqWOXC0dEJ3jdcn9urgF1kKhiPGMHTiCQgxefpsMR+ph4
         QlbrfAOdusPHj0FSTX7H5dibBxhVED+L6MFqAk0PfKa1w2uj4nmajeMn+qPSs/cVCn+s
         1l5ix74b3liOdqz74u2GznJuJ6PEhYsqoUX/3tnLHDvG+fPtm/uR4Klcyx7M9+bLMYpe
         WkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fjJLjnueo71jaPKVwb+Si5R+XwooGSjNLuYVVy4lLqY=;
        b=3yAP+l9uIb9l7nt8TGMasaQrf/N4rWQFLQSzyP7JgVfCR48ULvAQxERk/usuAQf7ij
         ZLIuGbCXj3fRXat2zZVlEa1FIgkXhnaEbyzxnuKzMqwSKc8eut/h/3DB1sgvv8aqxnwt
         FrZB98c1B/v8uz8lw1nxcPCVMkQsnp5RyfC9Rh8lFV9XlWaQ8v/ZGCpq4M2CHDFiGKxg
         xUnmfK3nuR7r2U2gcfzSW9Ky6ZXr17IoPVoe13fdpqSAGRH2mWvGenxp5pfv6hbeGPEx
         j5+LC+UqUTdYG+S5WE76Edy5fbzMxh8Yxio1/OC6KEPmEaaFr4uuMm7lJ6B6+9Vfi5Me
         EkFA==
X-Gm-Message-State: AOAM530FioAm5OYEzq7f3iMCBt35ReZMTovq/EBsaKi6D+uOhKcvSfCA
        jG5PTvSPpMBTPTDq0LcDUry8U6Z7IJl71AZ19kTQs5BB0WpyJUB/12I1b5lKDxodjEJlHcFq2wn
        QvKXwi+VMXECbiekdK097Crub/pjPoLNVTaYLw+DNf95ygjclmYrlQ05SJzjRIU8=
X-Google-Smtp-Source: ABdhPJyQQV/C5dWlukF2xLLvdYwCACmChT8F5V9s0LE+38ize9shyJdI5M2gQPZIDDavzS6StCgZHvMN2M7vww==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d50c:b0:158:7b0e:8103 with SMTP
 id b12-20020a170902d50c00b001587b0e8103mr1398811plg.100.1650069262518; Fri,
 15 Apr 2022 17:34:22 -0700 (PDT)
Date:   Fri, 15 Apr 2022 17:34:20 -0700
In-Reply-To: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lzgkl7to3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: Bare repositories in the working tree are a security risk
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, justin@justinsteven.com,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi all! Thanks for chiming in.

I'm sorry I wasn't able to participate in a timely manner, and unfortunately
(once again..), I will be out of the office (returning 27 Apr, PDT) and my
colleagues will be keeping tabs on the discussion in my stead (once again..).

Nevertheless, I think the conversation has been pretty fruitful, so I'm
optimistic about next steps. Here's my understanding of the conversation thus
far - do chime in if you feel I'm off base or if I've missed something:

* We all agree that something needs to be done about embedded bare repos. This
  is a pretty good starting point IMO, because we agree that 'do nothing' isn't
  a good response.

* There are use cases for embedded bare repos that don't have great alternatives
  (e.g. libgit2 uses bare repos in its tests). Even if this workflow is frowned
  upon (I personally don't think we should support it), I don't think we're
  ready to categorically declare that Git should ban embedded bare repos
  altogether (e.g. the way we ban .GiT).

* We want additional protection on the client besides `git fsck`; there are 
  a few ways to do this:

  1. Prevent checking out an embedded bare repo.
  2. Detect if the bare repo is embedded and refuse to work with it.
  3. Detect if the bare repo is embedded and do not read its config/hooks, but
     everything else still 'works'.
  4. Don't detect bare repos.
  5. Only detect bare repos that are named `.git` [1].

  (I've responded with my thoughts on each of these approaches in-thread).

With that in mind, here's what I propose we do next:

* Merge the `git fsck` patch [2] if we think that it is useful despite the
  potentially huge number of false positives. That patch needs some fixing; I'll
  make the changes when I'm back.

* I'll experiment with (5), and if it seems promising, I'll propose this as an
  opt-in feature, with the intent of making it opt-out in the future. We'll
  opt-into this at Google to help figure out if this is a good default or not.

* If that direction turns out not to be promising, I'll pursue (1), since that
  is the only option that can be configured per-repo, which should hopefully
  minimize the fallout.

Given that this embedded bare repo problem has been known for a long time, I
don't think we need to rush out a fix, but (especially since I'll be OOO) I'm
more than happy for someone to take my ideas (or any ideas) and run with them.

[1] https://lore.kernel.org/git/kl6l5yn99ahv.fsf@chooglen-macbookpro.roam.corp.google.com/
[2] https://lore.kernel.org/git/20220406232231.47714-1-chooglen@google.com
