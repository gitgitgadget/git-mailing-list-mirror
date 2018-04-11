Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C72A1F424
	for <e@80x24.org>; Wed, 11 Apr 2018 09:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeDKJGQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 05:06:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37956 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeDKJGO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 05:06:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id i3so2375540wmf.3
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 02:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/BkLg/77mG+M5BXpTFV7VZz3WSsYpBVCw2w9dYUV4V0=;
        b=fHY1QT90bh3MTcWxsB5Ezk3jEbE3DWBKyiTRXMOPZB7CVi1aAE/zSc5ofkrcXvr286
         C8x1p3Osy+bay2dPx4mWOrc7DKwOckWe/EvNXU9byita9TdRnYsNiz1VJt7yyQ/qY25h
         Tkp0DE1U6qMStM4izzK0ko6103vN/kqsc4aRP49W4w94LgSQr4iQIwiEvGuyJ2Cz+oNX
         3oH9GZJ+KCvMR1u3Xo6ifEFXgpN5T15GycqXTC0oZn4X5DK0zoPtgRjx4duZOUXm0sZB
         v1tmKFGaJGYACxoygxhk1/b/DuRiLlj9VXjNKsb/L0W3WFHh2hYUynvJ4OgCEvayQcmT
         JylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/BkLg/77mG+M5BXpTFV7VZz3WSsYpBVCw2w9dYUV4V0=;
        b=GdnAIeYu5rNkainlWWLjQebFFRBh5cA3Wo1alD0AwDWVINxmWdjHFaQ7+hVi6JcBov
         sDKaYN9O4Re12R9gJ7dP/f9UhbH4RzT7mpkFx5RNtiWP6IQIAmKdBjIqbBlwjCJ30uOh
         QddXpxx9HfuAk7QSCZLINaVpWZBn1EZwH34ym9+86v1NoCtICeuH2ZG5SomZ8ZqIBdtn
         nti0DBoPeBXferkjndkAPyca3tYtfF8viRGeyP412JJzHBzVktJURGkER1d1SlprhjGX
         aHRtN1S4UXC48yi4JHotH7eC5mO+l7LrmGJ7AtvX2YSdNek14k3aX33E2XUDjVH+oTSI
         qrgg==
X-Gm-Message-State: ALQs6tDYEaHmguTkMemfWtmVh06WYgbFZt5Q5YWzh4suBfDkG5Etvjpg
        /AibyvAuMmorzaHj1WhjWkctvUyt
X-Google-Smtp-Source: AIpwx4/7hqy1meTres8lFOm6hI+LJSTYPJJqTaQ8x6iPVtSFuKb1HhqX5aF1JpEXEm5av5UNHEjYQg==
X-Received: by 10.28.6.8 with SMTP id 8mr2105488wmg.39.1523437572853;
        Wed, 11 Apr 2018 02:06:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v22sm595550wra.91.2018.04.11.02.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 02:06:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: Re: [Git] recursive merge on 'master' severely broken?
References: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 11 Apr 2018 18:06:10 +0900
In-Reply-To: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 11 Apr 2018 16:19:31 +0900")
Message-ID: <xmqqin8y3yf1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It appears that a topic recently graduated to 'master' introduces a
> severe regression to "git merge" when it merges a side branch that
> renames paths while the trunk has further updates.
> ...
> I suspect that the culprit is the merge e4bb62fa ("Merge branch
> 'en/rename-directory-detection'", 2018-04-10), and I am planning to
> revert it out of 'master' as soon as possible, but it is already
> buried deep in other topics, so I may not be able to get to it until
> later this week.  Sorry about that.

An interim report.

It indeed is that merge with the topic.  I rebuilt an equivalent of
'master' without that topic on top of v2.17.0 and tried the same
merge of sb/filenames-with-dashes fd055186 ("replace_object.c:
rename to use dash in file name", 2018-04-10) topic into pu^
35f7512e ("Merge branch 'fg/completion-external' into pu",
2018-04-11), and that version of Git does not exhibit the problem.

I do not yet know which one of the ~30 individual commmits is the
real culprit, but in the meantime, I'll revert the merge out of
'master' and push the result out, so that real Git-using projects
won't get silent mismerges.  Those who run in-house version of Git
that is based on anything newer than the released version may want
to do the same.

Sorry for the crappy 'master' X-<.
