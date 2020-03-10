Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACCDC10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 16:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA28721D56
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 16:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4MAb/WG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCJQAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:00:40 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:36946 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgCJQAk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 12:00:40 -0400
Received: by mail-yw1-f74.google.com with SMTP id 84so14087592ywr.4
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UHnIx15sRtNUeWqpxRuxmL4FOigFd6oHXx6MjxIUDEA=;
        b=o4MAb/WGeRohieVeyUo+AIClBVqPXYIAIaS8kFa/gXfroAqE0RGv7LBNpP8qfe/t1u
         daAQixowPr3p9MogSWz4hTsVXm7aH3FdMaMzNR+WCdH6hEPH1dv+IKe/zsnLIRkhb5r5
         HzxLK5ZV5APIiRVMg3UYIq38Cqzp7UohM3nqwwrpyyAQyNPGm1KfEtSZwAa2ne197L2V
         x5UjJpJWx1m2stSx5JV5JfVG4zj32y5LKtRpEydn1nHYkuJuKdEK76TIOhB3W1Iff0iO
         Kwmk1EDlIB+FV2fr2eOqW6Ks03xw0ev5bdXx8PzbPO8J9bEfOhyninHri3sKfGYqfMuJ
         3/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UHnIx15sRtNUeWqpxRuxmL4FOigFd6oHXx6MjxIUDEA=;
        b=QdlNLdztLZwLuYvGYs5LOR/Yc+rDSeTCqtuwj0TCWKDVkni75SiAGUJ5tq05gNkpt2
         bvcxdwi6AgHrW8wtpxp0ys+WAuqeMu2R63QhSsD/cOMTkXvlu380EWAQ+0P+w06hUh41
         t+k10loy74E2Z2gJSwSJGS2VtvV5vi9w/MnXTFYGjmxiZFrJh5iqFHK/jrTiqg0Z388M
         WEQryeL7zKyGmbTYVEiAIoTdZzdiNKEgkI9v84KF/uCmVs3o6OwEpGZ5fRoVLiWAft+C
         q6Y4m8n+tsghvxX5OE6HM8yLLvrp8idpuN95ftWppQmnAysDPLZamom/wVfXKwDqcUV4
         B1QA==
X-Gm-Message-State: ANhLgQ06r5eBOYf7EdUDX33VCe003dE6hngPM+RhYRIscgaMEpgMe7jj
        PmFGd3hgynrRQ3kgpE/fqqxDWe5TePDUWrhsYnKb
X-Google-Smtp-Source: ADFU+vu+qfCXt0MasI82fS5zunrdRUvf7yrvsdzQXYzX3KRi0bsmYNOsQgccz6iSgeiNGECpUYFadWGVqpcXLeP1unSk
X-Received: by 2002:a81:7a4c:: with SMTP id v73mr4388637ywc.300.1583856038752;
 Tue, 10 Mar 2020 09:00:38 -0700 (PDT)
Date:   Tue, 10 Mar 2020 09:00:35 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2003101315100.46@tvgsbejvaqbjf.bet>
Message-Id: <20200310160035.20252-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <nycvar.QRO.7.76.6.2003101315100.46@tvgsbejvaqbjf.bet>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: Re: [PATCH] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Johannes.Schindelin@gmx.de
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I wonder whether we can make this a bit more user-friendly by defaulting
> to `--right-only` if there are no promised objects in the symmetric range,
> and if there _are_ promised objects, to skip `--right-only`, possibly with
> an advice that we did that and how to force it to download the promised
> objects?

Thanks for your suggestion. I'm inclined to think that in a partial
clone, whether an object is missing or not should not affect the
behavior of a Git command (except for lazy fetching and performance),
but I can see how this is useful, at least for the purposes of
discoverability and ease of use (good diagnostics for the
non-partial-clone case, and better performance for the partial clone
case).

But in any case, I think that this can be built later on top of my
patch. Even if we have automatic detection of missing objects and
automatic selection of functionality, we will still need the CLI
arguments for manual override, so the CLI flags and functionality in
this patch are still useful.
