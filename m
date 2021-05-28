Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C85CC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D23611C2
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhE1VO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 17:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1VO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 17:14:29 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E7EC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:12:53 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so4749886otc.6
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:references:subject:mime-version
         :content-transfer-encoding;
        bh=poiSkarFLlO7+vMMIbTxYiPzG53E9zJuDJiZBtMFn/A=;
        b=eGqq2YKTWBjB/GhRde2+W5tomzKbsl8KTbOJ7/TIm6KpSUkN+AsgK3LGP9iGHmk0cQ
         uRf1+LJE3sXTw10YL4e2g+f9pDt7eB3kNDkbXfTJsPsyaLXSbB0yjazfIiUBqkiiWLul
         Zzx8+TwNBZ2hOBNksQVTlU0W+9oTCSy3nlZqRNa5j+nEDXm6KtfYoQx6aAs+nOvmo/aQ
         RmqPCC7292ZxKwej8rJEoxsCKwas19qoQJwS1kY9mj5R82d1St3A8dgXSDExsvZZIWA5
         pKQBsz9ATnWTqO18hXZV3djQ6Yw9Mr5FshyzPxVriEXmfcYxgxP/ue/OJDvn0bPDfapj
         J7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:references:subject
         :mime-version:content-transfer-encoding;
        bh=poiSkarFLlO7+vMMIbTxYiPzG53E9zJuDJiZBtMFn/A=;
        b=F6aX4QoshvXUdG59CCO7SxRi5AI7qVdxscAHuHJaMnybbSmanX9WPXXMKEX0GRch09
         FOy2+Di60eg+yXZsu9eJVKrng9LNO9M5B9XYGpN/nb57FYBnxGtfwIdebbbVgyT/GTSu
         9ENCsOanZPicTJtd+cQ86fIJ7ra1YdLDXzqBuob7EKS1rdl6FSijP4gB4L3jcHfHsskM
         y45Ot2K3ZNxyAVSo1P8mKlrQoCc1EG9er4cshkJf7IAsr3yiKHBQClrTkJ+HCcz0Bcsp
         ht+XO0IS7NqbLzY8c5Ahr1S75QCxRnEupfOIInLBWPMNorXjOvyE6ZgUDynRZ0v+2d/N
         K5hw==
X-Gm-Message-State: AOAM532fvWO3xu623PMg/qAFOczQoeMQqrbTC+YXh0Xcq/49hqHspVDk
        CHRSvrkdMEzBIrxTGw9zRsc=
X-Google-Smtp-Source: ABdhPJzBpE/uh+crmmRQmxbGb8qOj1rW2QVknR9WEYtQwuNatgdMRE1SybTJoMBBzNypTKUH32SwSw==
X-Received: by 2002:a9d:491:: with SMTP id 17mr8795421otm.184.1622236372483;
        Fri, 28 May 2021 14:12:52 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u24sm1375487otg.73.2021.05.28.14.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 14:12:52 -0700 (PDT)
Date:   Fri, 28 May 2021 16:12:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Mathias Kunter <mathiaskunter@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <60b15cd2c4136_2183bc20893@natae.notmuch>
References: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com>
 <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
 <CABPp-BEeqqGwN3=MbWCYnsyryBm3WoaX5GZyXTWy18UiYUT4zg@mail.gmail.com>
 <f9f38d42-2b93-0d3b-798b-4c6f44eb111d@gmail.com>
 <287483ba-d682-6d04-23fa-22c33ab70376@gmail.com>
Subject: git push default doesn't make sense
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Kunter wrote:
> However, the advised "git push <name>" command won't work on that branch 
> with the default settings of Git. To make it work, `simple` pushing 
> would have to use `current` behavior on a branch without upstream.
> 
> Please consider changing that. Thank you.

OK, after reorganizing the code to actually make it understandable [1],
I ended up with this:

	if (centralized) {
		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
			die(_("The current branch %s has no upstream branch.\n"
			    "To push the current branch and set the remote as upstream, use\n"
			    "\n"
			    "    git push --set-upstream %s %s\n"),
			    branch->name,
			    remote->name,
			    branch->name);
		if (branch->merge_nr != 1)
			die(_("The current branch %s has multiple upstream branches, "
			    "refusing to push."), branch->name);

		/* Additional safety */
		if (strcmp(branch->refname, branch->merge[0]->src))
			die_push_simple(branch, remote);
	}
	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);

I agree this doesn't make sense.

If this works:

  git clone $central .
  ...
  git push

Then this should too:

  git clone $central .
  git checkout -b fix-1
  ...
  git push

Cloning automatically sets up an upstream branch for "master", and
therore it passes the safety check of `push.default=simple`, and that is
much more dangerous than pushing any other branch.

Why do we barf with "fix-1", but not "master"? Doesn't make sense.

This is what we want:

	if (centralized &&
		(branch->merge_nr && branch->merge && branch->remote_name))
	{
		if (branch->merge_nr != 1)
			die(_("The current branch %s has multiple upstream branches, "
			    "refusing to push."), branch->name);

		/* Additional safety */
		if (strcmp(branch->refname, branch->merge[0]->src))
			die_push_simple(branch, remote);
	}
	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);


In other words: `simple` should be the same as `current`, except when
there's an upstream branch configured *and* the destination branch has a
different name.

Cheers.

[1] https://lore.kernel.org/git/20210528201014.2175179-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
