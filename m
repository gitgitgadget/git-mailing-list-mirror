Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20B81F404
	for <e@80x24.org>; Mon, 12 Feb 2018 19:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBLThu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 14:37:50 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54226 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbeBLThq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 14:37:46 -0500
Received: by mail-wm0-f65.google.com with SMTP id t74so11722158wme.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 11:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dRyowT6gTIb4QO2+P+iSXhCJpHu/zkdk4wf9TddCngs=;
        b=HjDblPahmhJkfOydbZa6Cc4RixViBLGqKxxk/fjmtosx81zfkLZXx+g8LwaBx3TdS8
         wBkeCCWSworwavys7/ai//Lk0qbt2V/N51hy5fsrJVlgMINB0iSskl4oDVoWBWoLDv9J
         VL2t8hnbHYb3RPzKn//zvKynEY517CfXWbYdZngurOqWSwaVnFVtp72Sui6tHHNjH6aG
         HSTcMP974KoBfw8HC4iGrF7OEYStrFGVbhS+e+WzuwlU9vGUZ6Pm5Q4JO0k/RMfzHtdh
         drMnGBoSfzLjg5mCHrMHoP2IwniLrAJTPk+vLAkkvnQyH+V0O5JwFea1PgTt7q86X1za
         vu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dRyowT6gTIb4QO2+P+iSXhCJpHu/zkdk4wf9TddCngs=;
        b=BwT4QNPT0546Ys0ZnCjqVOExr3hE+xu4qWMADoxCzzjaBfBZGML37bFgU7NbrabnP1
         od2+vJmiHmpX7oV9bv176rfCqzNm59uM9l+40izRGwCGsjYFHiefzCnyao89caT2zlcy
         s+D/njdckgHDAeIto+ezE2bvJuDcMsXPpqhcmRozqMvblMmfHbtYdZ5TVFTCoTRZsY/2
         OKKFEbxN8nmkhvhx5ieSEmI8PUHfORFjku+zD8nAHvs7ESzfPXkIaFkt6gFt4cETGOAr
         kJWdwjScDIEW4wKUh8lmI/8vrAKXkyyIbxaEaGxOSV1CfM6TAr61N+nNfPLNfPotVqaU
         Yt6g==
X-Gm-Message-State: APf1xPCpYkiDhBceOHZ1kRkePMTDpFLlzz9ND7LJ31dqrLHR93LNXhAI
        stMf1wkjRpWj5DpjnkAwSh8=
X-Google-Smtp-Source: AH8x225LO9mfzLJovqkdTjMArGWFezirpQYJNScdUdn97+Q1gFZ7doqdBVBTCRzI/M7Dbl1HTFQsIg==
X-Received: by 10.28.21.136 with SMTP id 130mr4057867wmv.152.1518464264733;
        Mon, 12 Feb 2018 11:37:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y90sm18178436wrc.24.2018.02.12.11.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 11:37:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        matthew.k.gumbel@intel.com
Subject: Re: [PATCH 2/2] worktree: add: change to new worktree directory before running hook
References: <20180210010132.33629-1-lars.schneider@autodesk.com>
        <20180212031526.40039-1-sunshine@sunshineco.com>
        <20180212031526.40039-3-sunshine@sunshineco.com>
Date:   Mon, 12 Feb 2018 11:37:43 -0800
In-Reply-To: <20180212031526.40039-3-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Sun, 11 Feb 2018 22:15:26 -0500")
Message-ID: <xmqq7erit2wo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Although "git worktree add" learned to run the 'post-checkout' hook in
> ade546be47 (worktree: invoke post-checkout hook, 2017-12-07), it
> neglects to change to the directory of the newly-created worktree
> before running the hook. Instead, the hook is run within the directory
> from which the "git worktree add" command itself was invoked, which
> effectively neuters the hook since it knows nothing about the new
> worktree directory.
>
> Fix this by changing to the new worktree's directory before running
> the hook, and adjust the tests to verify that the hook is indeed run
> within the correct directory.

I like the approach taken by this replacement better.  Just to make
sure I understand the basic idea, let me rephrase what these two
patches are doing:

 - "path" that is made absolute in this step is where the new
   worktree is created, i.e. the top-level of the working tree in
   the new worktree.  We chdir there and then run the hook script.

 - Even though we often see hooks executed inside .git/ directory,
   for post-checkout, the top-level of the working tree is the right
   place, as that is where the hook is run by "git checkout" (which
   does the "cd to the toplevel" thing upfront and then runs hooks
   without doing anything special) and "git clone" (which goes to
   the newly created repository's working tree by calling
   setup.c::setup_work_tree() before builtin/clone.c::checkout(),
   which may call post-checkout hook).
 
I wonder if we need to clear existing GIT_DIR/GIT_WORK_TREE from the
environment, though.  When a user with a funny configuration (where
these two environment variables are pointing at unusual places) uses
"git worktree add" to create another worktree for the repository, it
would not be sufficient to chdir to defeat them that are appropriate
for the original, and not for the new, worktree, would it?
