Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D7EC2D0A3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 21:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3C721D41
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 21:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mustmodify-com.20150623.gappssmtp.com header.i=@mustmodify-com.20150623.gappssmtp.com header.b="t3lzUzVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764544AbgJXVHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 17:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763077AbgJXVHF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 17:07:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEF1C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 14:07:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k3so7570282ejj.10
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mustmodify-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=XRzilvYjYIFFcYfjTvkBWDIbuBtz0+ZypmMhK7a16Bc=;
        b=t3lzUzVbLh2/2WF7ctS5EuhKRxpYG0U6TFJFMqYCe8r0GpQFh1LsX/29w1XFRAUYTQ
         LIS5nXcHB4hNnhBYOQoAM9S8O0JccmBNzDyQBB/D1t0GndcqSKJptezV4vEu1nEyT7H6
         4qLiLzlLb9Az+smzKtYQiQaqhty7Rx1iWwapWmkzmZnV1N70aNcFAxfqFp5BQn7HTWw+
         J4P7h7N+46UDg5amNRaEhTReYq/AAItsEyw7xvvCK2jtbEEATR5nv0qlYdRBHkYdLGv9
         B/RfV3BacG8PPiZPqjxPgiAoUuyFS6uqP0emQBl/oQqZZUeoB0/o+6xMn28hw9ZtTL9I
         X25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XRzilvYjYIFFcYfjTvkBWDIbuBtz0+ZypmMhK7a16Bc=;
        b=I32vCwdhnfjGQAIWqJQFAXUwb3gD+9pGwXYe5vg4FUVuk53m9DYyiZI5sFYyOXofCe
         4l4XG360pliaCPS4yUAU+2z6KGmNVd7pE5i1wdmOZ1U9+y+ja5xFGie2nEJ4cEJgmQez
         kXFWqv2srVYpxVJZZACwGdLk+kNKWeDtFnhpWe4rIEh31NbQxVnBhsCcYwOZEv4rC8t4
         SbI4gZ9SQa4ra+sQQw13xW/qDbojcv+zAoYnU/sHLk22X9VO75jE4EHLkKhsskrfsXFp
         epnJSLlRSH6wfC5O/khG2IqvX8k94niGw2KkH7CQkoBJlxbuKH6nqlQkZXRrcTDlP7Q2
         i0RA==
X-Gm-Message-State: AOAM533XlHrGIvByytoUfSDRUZ7w6AJgMW0mhh4c9Q5EJwnsPeIeqhvW
        SY61jJd961VxLQCbzuBz64u67LGLBf7XbcHtG9vUE1cu3NHEAgSQ
X-Google-Smtp-Source: ABdhPJwbBZ94c44B+4HNZGI4sh5QUArKcEHdLKAUN9wXqEpOVMNlZIUqr1tSpx/ZTiU68td6Tcal6YWeIvrCz0ykso8=
X-Received: by 2002:a17:906:3e4b:: with SMTP id t11mr8134693eji.420.1603573617378;
 Sat, 24 Oct 2020 14:06:57 -0700 (PDT)
MIME-Version: 1.0
From:   Johnathon Wright <jw@mustmodify.com>
Date:   Sat, 24 Oct 2020 17:06:40 -0400
Message-ID: <CAD6JFnNX03MLBSUjdTjvK1TsBR-sntqgXMDKR9z2OjdUKBERKQ@mail.gmail.com>
Subject: Please explain why this merge ignored changes from one branch in
 favor of another rather than showing a conflict
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Your Excellencies:

I'm a new tech lead trying to figure out what caused a significant
production issue. I want to know why the merge described below
discards the content of a certain file from one branch and uses
content from another branch, while saying that the file was "added by
them". More importantly, I want to know how to prevent this in the
future.

DETAILS

A dev wrote a feature across many files, including
app/events/checkout_event.rb. Once merged and deployed, it was
discovered that his changes to that file didn't make it to
production... but many other changes from the same commit(s) did make
it.

After much research, we have isolated the issue to a specific ref -- a
merge. It appears that, during the merge where both branches had
changed that file, git decided to throw out changes to a from one
branch and to use the other branch.

I created three tags so my small brain didn't have to remember refs:
* "working" (aa29d0f4)
* other_parent (7f9ebfa5).
* broken (ccbeb88)

----
jw@logopolis:/projects/unity/atlantis$ git show broken

commit cbbeb883428a468e9c906c646becdf751ecff99a (broken)
Merge: 7f9ebfa5 aa29d0f4
Author: Johnathon Wright <jw@mustmodify.com>
Date:   Fri Oct 16 13:17:43 2020 -0400

    merge

...
----

'git show broken' doesn't show any changes to the file in question.

Here, you can see that the files were different:

----
jw@logopolis:/projects/unity/atlantis$ git ls-tree working
app/events/checkout_event.rb

100644 blob 077013dc52f03b336143b892c1468516cae29dce
app/events/checkout_event.rb
----

and

----
jw@logopolis:/projects/unity/atlantis$ git ls-tree other_parent
app/events/checkout_event.rb

100644 blob 21b3d4e9b5ac4903c2aadbed28ab5b60eb77e8ce
app/events/checkout_event.rb
-----

Then I tried to reproduce the merge:

----
jw@logopolis:/projects/unity/atlantis$ git checkout working

HEAD is now at aa29d0f4 Track instances of price changing

jw@logopolis:/projects/unity/atlantis$ git merge other_parent

CONFLICT (rename/delete): spec/events/single_payment_event_spec.rb
deleted in HEAD and renamed to spec/events/checkout_event_spec.rb in
other_parent. Version other_parent of
spec/events/checkout_event_spec.rb left in tree.
Removing spec/commands/generate_ticket_and_send_command_spec.rb
Auto-merging db/schema.rb
CONFLICT (content): Merge conflict in db/schema.rb
Auto-merging config/routes.rb
Auto-merging app/models/user.rb
CONFLICT (rename/delete): app/events/single_payment_event.rb deleted
in HEAD and renamed to app/events/checkout_event.rb in other_parent.
Version other_parent of app/events/checkout_event.rb left in tree.
Auto-merging app/controllers/products_controller.rb
Auto-merging app/controllers/priceline/price_points_controller.rb
Automatic merge failed; fix conflicts and then commit the result.


jw@logopolis:/projects/unity/atlantis$ git status

HEAD detached at working
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Changes to be committed:

        new file:   app/controllers/criteria_sets_controller.rb
        modified:   app/controllers/priceline/price_points_controller.rb
        modified:   app/controllers/products_controller.rb
        modified:   app/events/search_hotels_event.rb
        modified:   app/forms/search_hotels_form.rb
        modified:   app/interfaces/priceline_api.rb
        modified:   app/models/priceline/criteria_set.rb
        modified:   app/models/user.rb
        modified:   app/queries/hotels_filter_query.rb
        new file:   app/views/products/waiting.html.erb
        modified:   app/workers/generate_booking_ticket_worker.rb
        modified:   app/workers/update_priceline_hotels_worker.rb
        modified:   config/routes.rb
        new file:
db/migrate/20201009200507_add_timestamps_to_pl_criteria_sets.rb
        new file:
db/migrate/20201009235952_add_completion_flag_to_criteria_sets.rb
        deleted:    spec/commands/generate_ticket_and_send_command_spec.rb
        modified:   spec/forms/search_hotels_form_spec.rb

Unmerged paths:
  (use "git add <file>..." to mark resolution)

        added by them:   app/events/checkout_event.rb
        both modified:   db/schema.rb
        added by them:   spec/events/checkout_event_spec.rb
----

note that even though app/events/checkout_event.rb exists in both the
"working" and "other_parent" branches, git here says "added by them".

Note that "working" and "other_parent" both have parent nodes which
rename the file in question from something else TO
app/events/checkout_event.rb (same for the spec.) The two ancestors
have different refs but the same datetime and commit message.

This might also be of interest, or perhaps not.

----
jw@logopolis:/projects/unity/atlantis$ git diff working..broken --
app/events/checkout_event.rb | grep "^-" | wc -l

158

jw@logopolis:/projects/unity/atlantis$ git diff working..broken --
app/events/checkout_event.rb | grep "^+" | wc -l

51
----

Final bit of information:

----
jw@logopolis:/projects/unity/atlantis$ git --version

git version 2.17.1
----

So, why does git say that this file was "added by them" instead of
saying it had a conflict that needed merging?

It has been suggested that this might have something to do with some
team members using merge and others using rebase. Or possibly rebasing
shared history. I don't know how to determine whether that's the case
or whether that might have caused this.

If so, I would appreciate seeing a set of instructions from a blank
repo that cause this same thing to happen, so that I can help my team
to understand the situation and how it can be avoided.

If it is not related to rebasing and then merging, any help would be
appreciated in diagnosing this issue.

Thanks,

jw
