Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5C2C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE61B64EE2
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbhBDTYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbhBDTXp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:23:45 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E355C0613D6
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 11:23:05 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id y199so2893078oia.4
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 11:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2J32mJO8e4ic/94GwzNwLvYnAPhiA/8f61KYiPDV4mk=;
        b=LAnRBeUPVEorIR2bgj4FLylddBynCt8gKrL42aiNcGpOhvzSn7j6Mqu8Z0zL9R7a/T
         I7xf3v7sKEZB2QZK+bABaKphUKjbUVpfxrnQYl+06dnPoPRjrlpCycoIjnskFxvljXC+
         oZgq4tvDhv26H/7lRLMxSIvdygJD3XfK1cjc2Y2fPq29s0Wh3MJFLtvYZfgDwGVBmcLU
         1oknICHX6ZvL1BssVnOQspVfT9o3VsU9wPjZ6RumnF4JftI0N9/NdkWwaiZmWX1nWokb
         saMSzWeLEwfuYhaPJEa7HGhyMNkcP4cBrPZXUEaDZz0bGZulpnZTgvNmMscaW5rO5y/n
         9kJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2J32mJO8e4ic/94GwzNwLvYnAPhiA/8f61KYiPDV4mk=;
        b=oBgdz6VQvSey1x+UEHC6rRSSDvaj8lKn/B75kB8c/tsNKP1agbFwikC1zNhtNA+gDT
         hNrTcAnj6kaYvyw7lDKMaO0DyZw0BjgjN5CkkI8ZRXIYMR6j+ObTIlkzh/XqNswOI0Sd
         Igcp3ZP2jonBQ1fBEbChWe9FeOoMlCYK0mT3TGlit1wDOGZfvoFTLkXGTNx2ovFmSqJE
         Di4EpWBPQTFKVCdxJ4IuWN2ohotcCkxPPs0vex3do2bD1y3UkltCHnmjZJWuZ6H1/odM
         M4RJjUo0KSXeqMJPC2NSOGn71F/h3Wtb0xo0BW0zusO5P1lSrT7sAPI5Co5W7jkKApL+
         3SPg==
X-Gm-Message-State: AOAM530DXqcIdcQqIUIHTF8/XronIJa3wVBvm3pai1Nakp/drY1B4w7h
        fxq8dJQkwIU+oj8dSfFBUEE9achXgyQlJOPJc/M=
X-Google-Smtp-Source: ABdhPJzZ2UWHbcr5cOkfQmx4NuPDq3mmeuknNajF6p62g+4eQz3YbVbh//Zg0m+8GFqThT713KevUxLtFadKMyzXTVk=
X-Received: by 2002:aca:b255:: with SMTP id b82mr713569oif.98.1612466584599;
 Thu, 04 Feb 2021 11:23:04 -0800 (PST)
MIME-Version: 1.0
References: <xmqqy2g4ad92.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2g4ad92.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 5 Feb 2021 00:52:53 +0530
Message-ID: <CAPSFM5cY6WcH+Mj64pvk_8vQeufj4BT6XOz_qjsCDPk8SvN2oQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2021, #01; Wed, 3)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 4 Feb 2021 at 06:00, Junio C Hamano <gitster@pobox.com> wrote:

> * cm/rebase-i (2021-01-29) 9 commits
>   (merged to 'next' on 2021-02-01 at 4f9aa6cec3)
>  + doc/git-rebase: add documentation for fixup [-C|-c] options
>  + rebase -i: teach --autosquash to work with amend!
>  + t3437: test script for fixup [-C|-c] options in interactive rebase
>  + rebase -i: add fixup [-C | -c] command
>  + sequencer: use const variable for commit message comments
>  + sequencer: pass todo_item to do_pick_commit()
>  + rebase -i: comment out squash!/fixup! subjects from squash message
>  + sequencer: factor out code to append squash message
>  + rebase -i: only write fixup-message when it's needed
>
>  "rebase -i" is getting cleaned up and also enhanced.
>
>  Will merge to 'master'.
>

Received reviews and suggestions on this patch series. So, updated
those changes and have sent the next version of this patch series (v5).

Thanks and Regards,
Charvi
