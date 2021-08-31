Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDBBC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C322761053
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbhHaTq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhHaTq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 15:46:26 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3981C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 12:45:30 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id p4so560654qki.3
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zTHhlez5mdGkS+BMj7/2ZpRuBMoIhuGhwQ9ywq7YgA=;
        b=uLE/oQFyKEw0JtKObGYYBwrsi3zuUc7yp28Br68/eRqF/LmPNshcQlih1q2gO4Y8gH
         iDil/xKNKZNOY2NFNZNGgilCKXRxLhhqIu49G06bZnHYjw5YkZcKEwO5T1MV+iWf5qXK
         iX6RRGrMk8zIWuTArrnbW7eqEbviwxv+CbOMSgb921gY1O12gb9lb2WJ6G91R88ANLJt
         e03Q7SyG+pUeX/I/z7jjvE5hScQ7/qeMxAXchBDfdTeVGyZYb26WfvmnSvxckY+NDNhU
         tv4u3Nmdq7o280O+EIbBNhFtoUolbbTjcH1kIEzQ0VCJcTDsYJJvHG4yttt2eD+pcpU5
         Desg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zTHhlez5mdGkS+BMj7/2ZpRuBMoIhuGhwQ9ywq7YgA=;
        b=C3jd3yONRV2g9wTS+Q6KvohOFu/CKY0eQqYjrSgktQvzZ4q4Kh49qa+RVlc6WOr4sI
         ID51zRuAiBNkIR5AQDl3ZrTOpXBILpUXFkD1bShxjGbYTgR+0CUEka73pJ9Ljjp2lBs6
         ul4+KgUFpUktYXvyde7HPfBYA9oTuItZAg8TuX6Tl+wxUOvIh3q+swJ9tXnVhfb6gyfk
         crkfumsCuQk6BjheqnPw4ikeYCzj5I47rb73lcaJFN/HIsuOyren0Ypc9JnwZa4I8dw4
         sZip/cULWpVh93GTgTsdzYM+Q7/L8lg33R/6V/4KdjjehfuLh5DL40mnFXGW7yHjCgsl
         Epyw==
X-Gm-Message-State: AOAM5307HTfOI+YLlA3u/UI8TX9hs8o9vksT3JhOFjjGVgFxsddS7HTa
        5IWllUqCRN6hoHhMRl9/OoQmW7co4+HO2nDSZbgutaLj
X-Google-Smtp-Source: ABdhPJxeTzdnzrOI9XrAuwlF6IfrdVJxGivoulXDpY5d440H6WNj/t/rQOzD9onNhVCfTSUiWK8CijYwRxX4ZHzkfdk=
X-Received: by 2002:a37:9b92:: with SMTP id d140mr4786982qke.401.1630439130070;
 Tue, 31 Aug 2021 12:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHBARKezrkKAs0ACbJ_fnxR-qWacQ5KKuVLwn0WyT7aR+4++pQ@mail.gmail.com>
 <xmqq4kb5v6p1.fsf@gitster.g> <CAHBARKfLC0ie4p=xWk+xDbEH72fSF6qeWCf=9oOTH6M9V1Qh=A@mail.gmail.com>
 <CAHBARKcKL8h-zHcyCHRAMCj8=-PghopTPkH9o-_8UYRJYNZFmQ@mail.gmail.com> <xmqqczptto00.fsf@gitster.g>
In-Reply-To: <xmqqczptto00.fsf@gitster.g>
From:   Andrew Thorp <andrew.thorp.dev@gmail.com>
Date:   Tue, 31 Aug 2021 15:45:19 -0400
Message-ID: <CAHBARKcDBVbJ5fROe+CCrN5pDS057qJb91PMdN+28DUbPOSp0Q@mail.gmail.com>
Subject: Re: BUG: `git commit` adding unstaged chunks of files to commits on 2.33.0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, you're right. I have a pre-commit hook which does some formatting and
then re-adds the files. Doing so adds the unstaged chunks silently.

Thanks for taking a look Junio. I'll try to reproduce on a clean repo next time.

Cheers,

Andrew Thorp
