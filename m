Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC30C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 17:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbiHRRwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbiHRRwW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 13:52:22 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA6BC6B5B
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 10:52:21 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id x9-20020a4a8009000000b0044a835beeddso1081068oof.7
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=8ZZNaEqO0EuBDv+0FKpUYXuAlj/GFOhTcGqRVhV0/0w=;
        b=OLcomzQguwDT6VgFSI5ooIyiU6WQCdv+NRTCYm6d5fohkuRO3gwxoni3GcPylZp2Tr
         HnL6/ThWl9qQWcNikPt3I3sNqR83TC9HnJQ6VOlnT59K2T+y6L8ZnxmZsz9pbs8LaFTg
         VUIMCSWjg4TXs6YLxqDrZP6QlbMncK+1IDMTRwP5QKCHb6gqSoOaA1zUOw7dyHDqCgBv
         BO6jpf0np+NfWLce0g3tx5sn0c6dqJ/hXXUSjRj1QLUIisC5nY0ERUaNIej05CzdXWus
         3BNFJ0tMS36T6giO2+kBWCTav/zy8Ko5qn9UrrFYFLIRsI86JZEv3jGnkEUWwO85yy8n
         LvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=8ZZNaEqO0EuBDv+0FKpUYXuAlj/GFOhTcGqRVhV0/0w=;
        b=kU7oifkYo6p7GWZxZ/Wi6b9DQHbOyiGLSJBoXCyTpl5tddfLE6cRMna41uaG6uh7oD
         2EOGl1gUOj0LUP4oX4qtmovZlUpPWretVYoTyR6+HlWQDZwjb5P9kT9YIIEiB1o92hHi
         Giy/Z5znK4RgzlZ3dq1sf6dLE3WNwlFZsT85u/jUh82tJNezXM20QR4WcOEYXZ803fun
         oeU6Ua6DC2fvRIWvMwHlAM8sk8E0PPkAM8ruPZURnOefDpWeou1omtN1I3ZNO8Cgoev+
         MDkRURnRR6ATYWWLNB6eOM7Cub+KhNNd4Z/un7ClMVK0ozXQaSGajEpCZslIbQR8TP/P
         wqlA==
X-Gm-Message-State: ACgBeo2+ak1Av8cTBS6ZP4l8Okv9jd3ihouuzEmw9BBvCGhCXoC8OZN+
        BWE5KMGOaJnPjEWHhJjBSqYlMXs/DIWlSke95z73
X-Google-Smtp-Source: AA6agR6QUJSYy0HFbEzjPdxO6JkcWu2UZ3QRb0fXF3xK9GfoH8rWSl13FWD0913p6kWzBee/t9OgzqKF9aAYTJoQxenS
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6870:1604:b0:116:82f4:a0f6 with
 SMTP id b4-20020a056870160400b0011682f4a0f6mr1871720oae.246.1660845140831;
 Thu, 18 Aug 2022 10:52:20 -0700 (PDT)
Date:   Thu, 18 Aug 2022 10:52:16 -0700
In-Reply-To: <xmqqo7whqyzs.fsf@gitster.g>
Message-Id: <20220818175216.3530525-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: [PATCH] trailer: allow spaces in tokens
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Max Bernstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Max Bernstein <donotemailthisaddress@bernsteinbear.com>,
        Max Bernstein <max@bernsteinbear.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Jonathan, do you remember if the "be stricter" was in a response to
> specific real world issues, or is this "we no longer allow whitespace"
> an unintended side effect of the change?

Rereading the relevant mailing list thread, I think it's a bit of both.
The sequence of events was as follows:
 - I made a patch set that changed sequencer.c (which, among other
   things, controls the behavior of "commit -s") to use
   interpret-trailers's functionality. This caused a change in the
   behavior of a "commit -s" unit test (the "I want to mention about
   Signed-off-by: here." one), because "commit -s" previously did not
   support spaces before the separator. [1]
 - You mentioned that perhaps we should tighten it back. [2]
 - I agreed and tightened it, but didn't change the documentation. [3]

[1] https://lore.kernel.org/git/a416ab9b-ff1f-9a71-3e58-60fd4f8a6b8e@google.com/
[2] https://lore.kernel.org/git/xmqqtwbroykt.fsf@gitster.mtv.corp.google.com/
[3] https://lore.kernel.org/git/cover.1478028700.git.jonathantanmy@google.com/

So the "real world issue" was a test in our test suite, and perhaps the
side effect was unintended in that we wanted to preserve the behavior of
"commit -s" but didn't think about other possible uses of
interpret-trailers.

> If the former, an equally valid "fix" to what Max reports here would
> be to add such a real world issue or two as new tests to demonostrate
> why allowing whitespaces was a mistake that hurts real-world workflow,
> and fix the documentation.
>
> I actually am suspecting it is the latter, only because we would have
> added a testcase to show why whitespaces in the trailer label is a
> bad idea in e4319562 if this was triggered by a real-world issue.

The "I want to mention about Signed-off-by: here." test might be a
sufficient real-world issue.

> I would say that it would be a disaster, if we took any random
> line with colon : in it in the middle of the commit message and
> mistook it as a trailer (like the line above), but since we do not
> allow paragraph breaks in the trailer block, as long as the message
> has a valid trailer block, it might not be a huge issue.  I dunno.

Yes, it would be fine if the paragraph was two or more lines long, but
not if it's a single line.
