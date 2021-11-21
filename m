Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280F1C433F5
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 17:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbhKUSCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 13:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbhKUSCT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 13:02:19 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0185FC061574
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 09:59:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r25so29688232edq.7
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 09:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Ei0yG77KKSgI5iyGlbOB9BVj0HlWTrh1zw76R8BjJGk=;
        b=GVi8PKykQj8Uw/P4ovoWWartVnsEtS/Rkf+FgjgCHCIX1WslyYr4Kssykd6IcdGXPw
         T2dxqtIhNOczOxd9LUGm8dm+GxpxcpKzBdD4xbVJFo9cHq3HLd9SNwuWPbtLcvvaPmkG
         4OD/1oytfUwlfiyZKY1al6dLqFLqvBcy4rgzVXp0XvOGytE0pKpsu4zIipb1x4Evd4Hi
         T/Ow+nxTn9VcbddoW2tDbmkwBwKvP2JouxWDGK51aSRzd6SOjNFVrs+tIdqwgrG0Svw/
         roM5ElMw7zj2PQsMpi38jCQS9JDKiptVsKFCanKjLxBG+cf4BhmMNEG/2J4wqrMO+e3k
         nnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Ei0yG77KKSgI5iyGlbOB9BVj0HlWTrh1zw76R8BjJGk=;
        b=tlNcUacOG3EGTcPagtbug8KB4ifLN+nZzNXsyIkpx7DHmo8KGY5XRtByvA5tJUe+OM
         zYAOsfRrTQVY+5oGs0OQ0KiRxT5lcsdWOq1SpnZ/tzeg3lldzqDGG3fR7LtvGY+DGqbp
         9zHG0KZ3ZpVQIrdt2qL3G3EsbD/G6T3XxUldwMA/sHZyfKqL1NfLYZmlOEKgXVXxtJeh
         C/RmzGyHyYJaly6ZQEiFv214sBHsb3bzUesJRfBtFjOi1b6X3nw/1e+O81McDgJnrGLh
         FzpkBsWFdTaM92/ty4z7cqMqlFwPGt9cL1o1gYPUxXjkM3qCIWa+N0gHDJu0W0iU8Bvj
         jXUA==
X-Gm-Message-State: AOAM531ijl8OkTNJR0/e5HlMlCC3KFHLnX+MJOd195TfP1S30pthcQTP
        YDyrMegChYnSZIffJANtFVoUdTtllcQ=
X-Google-Smtp-Source: ABdhPJz/dI3taRd0SGxsVFGtUVgyYoQjxW02IGbXCY5lGGqcark0pzGh/pvFuLpS1ksIndXlXHMK0w==
X-Received: by 2002:a17:906:390:: with SMTP id b16mr31786149eja.522.1637517552243;
        Sun, 21 Nov 2021 09:59:12 -0800 (PST)
Received: from gmgdl ([109.38.153.63])
        by smtp.gmail.com with ESMTPSA id kx3sm2582611ejc.112.2021.11.21.09.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 09:59:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mor7P-000wst-1Z;
        Sun, 21 Nov 2021 18:59:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/8] t2501: add various tests for removing the current
 working directory
Date:   Sun, 21 Nov 2021 18:57:11 +0100
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <0b71996a3b462d4147fb792b20057544b9ef1710.1637455620.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <0b71996a3b462d4147fb792b20057544b9ef1710.1637455620.git.gitgitgadget@gmail.com>
Message-ID: <211121.867dd11jbl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 21 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>

> +test_expect_failure 'checkout fails if cwd needs to be removed' '
> +	git checkout foo/bar/baz &&
> +	test_when_finished "git clean -fdx" &&
> +
> +	mkdir dirORfile &&
> +	(
> +		cd dirORfile &&
> +
> +		test_must_fail git checkout fd_conflict 2>../error &&
> +		grep "Refusing to remove the current working directory" ../error
> +	) &&
> +
> +	test_path_is_dir dirORfile


I'd find this & the rest of this series much easier to understand if we
started out by positively asserting the current behavior here, and
didn't test_cmp/grep for erro r messages that don't exist anymore.

It would also help to show how exactly operations that currently "work"
behave, e.g. if you git checkout a revision within "t/" which is a
subdir, and it turns into "t" the file etc.

I'm also generally knee-jerk reactionary to test_expect_failure for its
fragility[1], but in this case more because it makes explaining this
step-by-step harder & not as obvious.

1. https://lore.kernel.org/git/87tuhmk19c.fsf@evledraar.gmail.com/
