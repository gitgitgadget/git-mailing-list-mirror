Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7BEC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 22:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355285AbiCXWRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 18:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiCXWRB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 18:17:01 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7734AA6E14
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 15:15:24 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a185-20020a621ac2000000b004fa80e5e1a5so3198131pfa.5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 15:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=lEwfKdhM4uQloZy1matIboMtyD8WyCBPv/OE3vS2HtY=;
        b=SIp2UH4GCoMpl/1JDOhz9aI5lRYOZ7QqP8vnXF8Tc7rC8OwPmsX/hcgxp6t53hkWZ6
         q8NNvzS0rQvUu6lF96MmTB8Jqo/ve9HlBNFqJrconitG3QyvvFxEyvqZqvE8pvBEye04
         glyuHMxrXsuLsPgxP98HjAdzH5Lu6hrNed2/+Avgmuo4DL+zHQGHQEjbxJFjk9MrPLdB
         Dq3dlyeWiU36VhbBsqJxPjjkbOPmcO+OWJGinGA8wUhqWF96Zqc8CDOHdnnosbFSrUME
         VAh5aCJqPkWoiVClfv8GAtpeQh7LRLkJm/C1C7zbitQpQoGcaXMow2nloCZFAyizWmIB
         OPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=lEwfKdhM4uQloZy1matIboMtyD8WyCBPv/OE3vS2HtY=;
        b=v9288+wkL1qADC3s2Uitc8DdguekOB+mt6VxmqCuBv1AUdmHh6r17BM4xUTJl6zpsc
         RkWl1U2ZCAASX0ybR9rIaucVWJDQQ9EttiCv0U4OtgrjPDSivn7UmHnRCu3AUCdLZNSI
         7ZLs2XROetCPDdGX71MHxolmXh99H5GcgQbNYqXSE+rOYFTVzVFa5CGUKFt1FXpEZe1x
         V+ZgiHa5DueQCjTTlBBkZL5ZOKzfMxfiXW/rv9vdeuJxJQDEF9p3apziJBn0uosCBoXa
         eiEkurS76kfT88dKRiWhp0ebx36rmRyXu2cYb13DrMl5t3W1S1f6TMyUvL17DDiByyX6
         L8nw==
X-Gm-Message-State: AOAM530o7cPulWWS80NqKwyM6fN7IKhJGQRFW5LJ2srTEpGn/kL+H07b
        a8+1/1VuuKFNacOJs+X9BoockHSrlYAoX1tMG/rr
X-Google-Smtp-Source: ABdhPJwwF5iw2db24dFKNGvTzotii4PUn1MuYlkka96H1638Jfas7nBxpygvW52MXKGLrounmkoqGRGMzRI1WNlAUQMa
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:f64e:b0:14d:20db:8478 with
 SMTP id m14-20020a170902f64e00b0014d20db8478mr8417677plg.158.1648160123946;
 Thu, 24 Mar 2022 15:15:23 -0700 (PDT)
Date:   Thu, 24 Mar 2022 15:15:19 -0700
In-Reply-To: <34da1688-7d94-d54c-6b3a-3106d0f15380@github.com>
Message-Id: <20220324221519.1324898-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: Re: [PATCH] commit-reach: do not parse and iterate minima
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:
> On 3/23/2022 7:30 PM, Junio C Hamano wrote:
> > This sounds quite tricky.  In this case we may know which commit we
> > need to avoid (re)parsing to avoid the bug, but would it always be
> > the case?  It feels almost like we want to unparse the commit
> > objects when we clear the grafts information in the previous patch,
> > doesn't it?
>  
> I agree that the adjustment to paint_down_to_common() is a bit too
> coupled to this scenario, when we should just trust our commits to
> be valid if they have been parsed. We should always be able to
> parse our parents.

Thanks for the comments from both of you. I think Stolee's comment
squarely hits the relevant points: it is precisely this scenario
(revision walk to remove unreachable shallow commits) that must be
careful of what it parses, and we *must not* parse the shallow boundary
commit's parents.

I think that there are 2 questions. First, whether we should parse the
shallow boundary commit's parents, and second, whether we should parse
the shallow boundary commit itself. In the commit message, I only
discussed the second (because that implies the first), but perhaps I
should have discussed both. Anyway, the discussion:

(a) Should we parse the shallow boundary commit's parents? I think the
    obvious answer is no, because the remote probably wouldn't have sent
    them. But the code currently does: in paint_down_to_common(), they
    are parsed before being added to the priority queue (and parsing is
    necessary because the priority queue requires their date).
    Incidentally, this results in an error message from
    repo_parse_commit_internal() being printed, but
    repo_in_merge_bases_many() swallows the error by not checking the
    return value (it only checks whether a certain commit has a certain
    flag, which is true by the time the failing parent parse occurs). So
    we should have some sort of one_is_at_min_generation anyway, at
    least so that we can prevent its parents from being parsed.

(b) Should we parse the shallow boundary commit itself? If we don't
    care, then we should unparse commits when grafts are cleared.

    In this case, though, I think that it is the responsibility of the
    shallow code to be careful with what it does with the commits. It is
    performing operations on commits that it alone knows shallow
    information about (because the shallow information is still being
    checked and thus not yet written to the repo). As I wrote in the
    commit message (which is admittedly long and perhaps hard to
    understand), I think that in the typical case, we only have a commit
    when its graft information is already present, so we don't need to
    worry about graft information changing from under it.

> Finding this bug is interesting, but I agree with Junio that a
> better fix would be to "unparse" a commit when modifying its graft
> in any way. That will universally fix it for any potential future
> commit walks that might be hit due to future code changes.

Unparsing also means that code can't rely on commits being already
parsed, even if they would expect it to be true (for example, a commit
in a priority queue would be expected to be parsed, since we would have
needed the date for it to enter the queue in the first place), but maybe
this is not a big problem in practice.
