Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD90C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EABB601FD
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhFJR2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 13:28:49 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:61063 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhFJR2s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 13:28:48 -0400
Received: by mail-pj1-f74.google.com with SMTP id t8-20020a17090aba88b029016baed73c00so4207654pjr.5
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wT1tEYJXmWIv0hZS6o2O95OdaV/CYS3JMKsvb3cClVU=;
        b=FrMPI3Lwt2Gv+9UbuGWq4PtokJMQmYYyDXANm7L2+TsgJHXBsmZ/xmdCUUWMLPuie7
         lQEKVHRfXmsarRrcOl07vBpsjRd3vbq+CxqQ/IKsFoo3kZgDB9tFoF7mPz5eWkp+OeRS
         diRquorE9ls5kRfA5FSn/dScF7j+/19LuJALhvm7n6nguJmuaOkk8NTBINEgdAiBYU5q
         99J+k7R198P+0z8NtHPK11CS3sWT17vmEmYQiHTo8MM8cxGKolwtlzpBVxv9vK/VCNaq
         511h7X+2ZoCx1lEAsB+keF9nC6m7TPSAUO2S/4AKRvk6rB05QopWEszs9GPruhFn2Qap
         aLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wT1tEYJXmWIv0hZS6o2O95OdaV/CYS3JMKsvb3cClVU=;
        b=baG/gKmHUkDNv7WEQqV58dMSoq+Krd1ugMQ/Jml8yVMNsb/pgUvkZdRDgN95EG2dVw
         BH9xlHZT51nx1FH1mNISPZ7QZFLN5v0qJeJMkByBVE7jY4/cN+d279ahPn4lGuXdsKxf
         1GIXvoMMpnmK/x6xI9uTRUbAQAmBryzYxFdRjoyjdpUL+zBKc2oey1IU5ysNoK8Ic2bC
         VjhZv7DV9nalXvZUZ9nHQoOsUJx4UZcQJv89JJ82baZ18L+JtBLOguGa2J4BeA8IIu8D
         FVlsE0nuuqzKd9F9WSIZBfFAsR6KLnRcjeViHwSiIoTvaRjiNQsiEvgDPkJ1UvTYna2Y
         lYmA==
X-Gm-Message-State: AOAM530/anyk11w/a2hRWv+RCpdPbmDnsffof8sQ3TAL1O0nDyDp6PiH
        WcBOWBHcLeq+jipxI5r/cL0gguBvq1Czso/5tU5l
X-Google-Smtp-Source: ABdhPJzNyFSE6BPS/7l/4Yjha/4+/nmP8vrjW0g7MW+RTgZeOqFXV0PfX6lupu2o+Meo+JjZfqZsKp8r7f7NQ+TWTsTW
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:1545:0:b029:2ea:a1f:992d with
 SMTP id 66-20020a6215450000b02902ea0a1f992dmr4077261pfv.63.1623345951942;
 Thu, 10 Jun 2021 10:25:51 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:25:48 -0700
In-Reply-To: <CABPp-BHt3db__cMpTY1a7y4u064NdVZGNCmnoR25aqhrWMfJcg@mail.gmail.com>
Message-Id: <20210610172548.356847-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BHt3db__cMpTY1a7y4u064NdVZGNCmnoR25aqhrWMfJcg@mail.gmail.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: Re: [PATCH v2 1/4] promisor-remote: read partialClone config here
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, me@ttaylorr.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Hmm...is your concern about the case in which
> > repository_format_partial_clone is uninitialized, or about ignoring a
> > potential NULL value? If the former, I don't see how your suggestion
> > fixes things, since extensions.partialclone may never have been in the
> > config in the first place (and would thus leave
> > repository_format_partial_clone uninitialized, if it weren't for the
> > fact that it is in static storage and thus initialized to 0). If the
> > latter, I guess I should be more detailed about how it's being handled
> > in setup.c (or maybe just leave out the comment altogether - the code
> > here can handle a NULL repository_format_partial_clone for some reason).
> 
> My comment was about the latter; I was trying to understand what the
> comment meant relative to that case, and how and where that case would
> be handled in the code.  With that frame of reference, the comment
> seemed misleading to me...though perhaps the comment was intended to
> answer some other question entirely.

Junio suggested [1] that repository_format_partial_clone be handled when
the repo format is validated, so this part of the code can just make use
of the repository_format_partial_clone value in struct repository and
not read the config itself. So I believe that this part is now
obsolete (but you can take a look at patches 1 and 2 to verify, if you
want).

[1] https://lore.kernel.org/git/xmqqeedbidvy.fsf@gitster.g/
