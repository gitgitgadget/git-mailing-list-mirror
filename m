Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74E5C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 22:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhLPWqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 17:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhLPWq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 17:46:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89192C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 14:46:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso789162pjl.3
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 14:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=9ULnxW+fJWBWLZLmmdrAwOW0QgYlCjx1gKmqyQQ1+ug=;
        b=DRxSyfm6PfVLn8jAXh7C3MLZOnnZrrLdIsmtFXe2zfpR7C7Yl+MvawygxKrqa29KJQ
         QMpRtsSCZgCOdQaA7yMFOzh6IU6vqQGDmikG8QN8HTXTOU9pynExNGVIgg8KEvan8mcf
         s9LyMfbQIur8Ytn11tXM5psyW/WMthXbUUgGg1yQTVLt7mIg9EpcdeYNgGZGU0jpHqGR
         mBqkPTZL7YqY96e7IAvVDZlTIo+d+Gp7Dw+ffqZXKX3Mq44rQPEmcVekNtaqTiTM527Y
         7HGGhrLE/bC79nmNZS/xBoODqLce0URlJLNOrBthDOs0DTuxmmk3xXsMxzSELJzPKPxv
         Acqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=9ULnxW+fJWBWLZLmmdrAwOW0QgYlCjx1gKmqyQQ1+ug=;
        b=zoBtt2UPu2dFdW+NF+pRPCPKpPpkdgHiVgtIZYK+u+5eeYHt9e+d13tpIFB+IfeObH
         +kIi7VG2CbbMS641uBMoq8Ifj3nPfb2V5nHV2hIHkXgdxesdNsp+Em56AZqTOy3tI7X1
         GYXZg6e2VORT2D/teQsuBvlDq6sd/UxKsLNpZK8V/1kV3rJyNgmrzK7l85D9oIe9ZeQv
         6hNos0v/TxS4WIySj3ixEzrDrCnNQeW7IEGIBtFBF159zDQQ56B0UYlv6ZMWJElCtezE
         HNYV6XhzDYDmFPPw1Z4v38Ln2AqRu4cbZQeH/Gq2/RO/I7Pve52ptlAJo7baoKSG2lmj
         8efw==
X-Gm-Message-State: AOAM533kwfCB0nFZfNsLu6efhmqjM/RTCK77z6uZ5+kiUrHhrYDpF1a3
        2IzDnP54nVGXZU7XbY32YUefNheU0ElDmw==
X-Google-Smtp-Source: ABdhPJzmepA9Wuu99vDHnk9Sck89rQDJ1Ok6zX8//PeXv/ni2DD2LhQ3mP7Twlpus/XO77nGsiksiQ==
X-Received: by 2002:a17:90a:f001:: with SMTP id bt1mr1648611pjb.60.1639694787106;
        Thu, 16 Dec 2021 14:46:27 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:af62:7ab9:588c:62f])
        by smtp.gmail.com with ESMTPSA id u10sm267931pfm.58.2021.12.16.14.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 14:46:26 -0800 (PST)
Date:   Thu, 16 Dec 2021 14:46:21 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, steadmon@google.com,
        chooglen@google.com, calvinwan@google.com
Subject: Review process improvements
Message-ID: <YbvBvch8JcHED+A9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

Recently in our team at Google I revived a conversation we've had many
times before upstream - in fact, at every contributor summit that I've
attended since I joined the project mid-2019. At each summit, we have
some conversation around review efficacy, process, tooling, and so on.
In late 2019[1], we discussed difficulty with performing reviews and
keeping track of them on the mailing list. In early 2020[2] we discussed
the unfortunate case of reviews with no responses whatsoever, and what
might be preventing Git contributors from reviewing more topics, more
regularly. In late 2020[3], lots of different topics in the
inclusion-focused contributor summit centered around reviews - tone,
tooling, workflows, and so on.

Some of those discussions resulted in changes - for example,
GitGitGadget was improved and added to git/git, and we enjoy easy,
non-noisy CI runs via GitHub Actions. But some things we thought were a
good idea never went into practice. In the next few months, the Google
Git team is planning to implement some of the following changes, and
we'd appreciate your thoughts ahead of time as well as your review later
on:

1. Draft a MAINTAINERS file
One recurring theme from the conversations I had with the Google Git
team was that selecting a topic to review in the first place can
actually be pretty time-consuming. Choosing from the series subject line
or the "What's cooking" mail isn't always straightforward - it can be
hard to tell whether the series is working on a goal you are interested
in or in a part of the codebase you care about. It's not feasible for
someone wanting to get involved to review every single series that comes
across the list - but it might be feasible for someone to review every
series in a particular subsystem or topic.

In the first half of January, I'd like to have a review out to the list
adding a kernel-style MAINTAINERS file with a few areas of interest. To
that file, I'd like to add "R:" ("CC me!") lines to subsystem mailing
lists and interested individuals. My hope is that that will make it easy
for someone to either add themselves as an "R:" or to subscribe to the
subsystem list, and then be able to filter their mail based on "stuff
I'm CC'd to" or "stuff sent to git-partial-clone@linux.dev" - and then
be able to review every patch in that list. I'd like to create lists on
topics where it makes sense, too.

Since the Git codebase isn't modularized into subsystems as plainly as
the kernel is, I don't think that the MAINTAINERS list needs to be
machine-parseable yet, although it would be a nice goal. Maybe over time
we will decide we'd rather organize the codebase differently and
implement a machine-parseable MAINTAINERS list to incorporate into a
sendemail-validate hook, or something. So I envision lines looking
something like this (just examples, sorry for directly calling people
out ;) ):

  Submodules
  submodule.[ch], git-submodule.sh, builtin/submodule.c,
    Documentation/git-submodule.txt, anything else adding a feature involving
    submodules
  R: git-submodules@example.com
  R: emilyshaffer@google.com

  Config improvements
  Documentation/config/*, config.[ch], builtin/config.c, changes which add new
    config options
  R: emilyshaffer@google.com
  R: avarab@gmail.com

It would be extremely useful to hear other suggestions from the mailing
list about subsystems which deserve a MAINTAINERS line and possibly a
subsystem mailing list.


2. Draft a ReviewingPatches doc
Another theme we discussed was the general ambiguity around the act of
performing code review. How detailed should the review be? Who should be
examining interoperability with the rest of the codebase? Is it OK to
reply with only "I don't know what you're trying to do, rewrite your
commit message please"?

Sometime in January I'd like to have a review out with an outline with
agreement on the content and organization for a ReviewingPatches doc.
I'm hoping that it can give some structure to review by including:
  - How to give different types of review (maintainer vs. individual vs.
    drive-by nits)
  - Review best practices (Sage Sharp's article on stages of review[4],
    CCing experts/lists from MAINTAINERS file above, short-circuiting by
    sending comments early instead of reviewing a patch in-depth when
    the idea seems so-so or unclear)
  - Checklists for new contributors to use or to help make in-depth
    review more thorough

Since this is intended to be checked into Git's codebase, I expect that
we'll want to discuss a lot and make sure we all buy into the contents
of that doc.

3. Google Git team will review cover letters and commit messages
   internally before sending series to the list
I often find that when I send a patch to the list, reviewers reply
without understanding the point of what I was trying to achieve in the
patch. It sounded like this happens to some other Google Gitters as
well. Luckily, that's fixable by the patch author.

To try and make sure we're sending patches that are easy to understand
and decide whether to review, we're adding a step to our process ASAP to
require commit messages, cover letters, and "---" notes to be reviewed
and approved by at least one other Googler before a topic goes to the
mailing list. Those reviews don't need to be formal, but do need to
happen for every reroll of a series. We also will intentionally *not*
review the diff of changes in this private setting - reviews for code
correctness, etc. should continue to happen upstream, in public.

I'm mentioning that takeaway in this email to say: if you find you don't
understand the purpose of a patch from a Googler, please let us know! It
would be really valuable for us to receive a review saying "I think you
might be saying X but it's still confusing because you wrote Y"
so that we can incorporate the source of your confusion as we continue
to review each other's "accompanying context".

4. Documentation changes to encourage commit message quality
Commit messages are important, but one comment I hear a lot from new
contributors to the Git project is: "why do these people care about the
commit message so much? The commit message doesn't compile!" That tells
me that instead of explaining the importance of quality commit messages
over and over at review time, we should be doing a better job of
explaining why we have high standards and helping them meet those
standards in documentation a contributor is likely to refer to.  On the
one hand, we want the list to be friendly and inclusive, but on the
other hand, it’s pretty demanding for a reviewer to review patches if
the commit message isn’t clear enough.

SubmittingPatches has a short blurb about commit message quality under
the "Make separate commits for logically separate changes" heading and a
longer one under "Describe your changes well". But I think it doesn't do
a great job explaining *why*, only explaining how. I'd like to send a
review sometime in January for a modification of SubmittingPatches to
include a paragraph about how we use commit messages - for example, to
identify the motivation behind a certain line of code during 'git
blame', or to decide whether a patch is worth reviewing. My hope is that
this documentation change would help convince authors that it's worth
their time to write a good commit message.

I'd also like to add a short hands-on section to MyFirstContribution,
looking up both bad and good example commits to underline the importance
of the commit message and the way that it's used after the patch is
merged. I don't think it needs to be long: "git show abcdef; can you
tell what the commit is doing? Now git show 123456; can you tell what
this one is doing?" where 'abcdef' is an example of a not-so-great
commit message and 123456 is an example of a fantastic commit message.
But I'd like to make sure that whatever commits we use as an example are
volunteered by the patch author, rather than chosen to be some example
of an antipattern. So if anybody wants to volunteer an example of a
particularly unclear commit that they wrote, that would be incredibly
useful.

For both these documents, the most useful help I could see from the
upstream mailing list would be to review and ensure we're conveying the
goals and the purpose of good commit message writing accurately.

---

For all 4 of the above, either I or another Google Git team member will
be responsible for taking action. If someone else wants to volunteer or
beats us to the punch with a patch on list, that's certainly fine with
me - but I'm not trying to ask for these changes from the community at
large. What I am really looking for is to be held accountable: if the
end of February 2022 rolls around and we still don't have any of the
things I described, feel free to raise a fuss. And I hope also to hear
from you all in the form of reviews and suggestions, or shouts of "no!
don't do that!" if something sounds incorrect or counterproductive to
you.

As it's reaching the end of the year and the holiday season, I'm
planning to spend the rest of the year with family and away from my work
email as much as possible. Some other Googler Gitters will be working on
and off and may chime in. But I am expecting to be able to engage more
with this mail in the first week of January.

Thanks very much for reading and discussing.
 - Emily

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.1909261253400.15067@tvgsbejvaqbjf.bet/
(see discussion #10)

[2] https://lore.kernel.org/git/6DAC1E49-9CA0-4074-867E-F22CD26C9FEB@jramsay.com.au/

[3] https://docs.google.com/document/d/1g_QapVhHejHorpUzzjpT5DlPi6ovNlEK4423uYWypbU/edit#heading=h.9tcri25458a
(See Day 2 notes; it's possible these notes are closed to those who didn't
attend the summit)

[4] https://sage.thesharps.us/2014/09/01/the-gentle-art-of-patch-review/
