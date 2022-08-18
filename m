Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E9BC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 17:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345314AbiHRR4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbiHRR4F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 13:56:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3ECB99FE
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 10:56:03 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 196-20020a6301cd000000b0041b0f053fd1so1073841pgb.6
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=AT35HAtpZ2maT6QRoO6vk5rHhOGcgscKKkvJ/fsR6ns=;
        b=jDhkji4PFJIa5BU8N7hzR6oNS8OCfhTvLXbURbLABFbQEWa9rupJQU8c0Ug4FzJuXi
         kvip26R1yveJUIsAcIv1TouIjV42JdElaqHNiP63Nxh+JulPTlM3Q3LI1ISB34Q5ngtx
         8OO7yvisAOgYIYCxmX3WSu0/mwX7VLsuP69BZBTTa4BybvyUgGLTrPSOSXRFTTGyfPRC
         a4HRsniMCgBxQpVHlfTKqAz1MeWSVMP2UCJ6Eu4BxG9v7af34W9aDit8dwAKQ7Pvnveh
         LRgZBpv3fDlAilgKSC+DYwc/C/dixItwBXIeKl4k44S1U+QpUayFUaZZcKnJbC4y6ltk
         H9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=AT35HAtpZ2maT6QRoO6vk5rHhOGcgscKKkvJ/fsR6ns=;
        b=E/lUiI817T+31HU9g/I7F65P40f0YH7preobVe0etp6Sl1SNIzrhvsTAmlNwd9gHkY
         K+WFUkRJGQ2x+rV+E4vTEU3oumw7FGEAuWnbGn2RY0gNjwz7dias2t2B1uwmvGE4Fw4E
         0pbvDiDLNwDCFcXB0WR0yHJyqDhIAUyLNo2sJZt/IQFIcDrtKPzqCWunIPS6aVgAn3ap
         k5bLTWuJ7J71tE+RJb+c3cm6QIiPpWKG+Eue0DiGnUVNQy2an7PNb5ga4XebPhv4dBtW
         4QZ42fi2ynBsG0HUOP3gjOzboM3fAJg2YsfwrVIK1lqVnmdtA5bfB4CMU2/LcSuq9Ub+
         W21w==
X-Gm-Message-State: ACgBeo118j3W9RG3m2C+1gHS82zEvPRchyhw6wtZsHVRH6bX4KtJnw5j
        KI/BOp9JReoWjGG2KacxCqc4Z/p9gJCsWX/q73Yz
X-Google-Smtp-Source: AA6agR4sILXAj7WQ5Wrw4XK7DTYPavvpWfPIisD3JtRAoVuWb50mQHf0VcEZvNznwBSoX/xnglT6JMq90gB17oIVWkse
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:4c1b:b0:532:8f07:bba0 with
 SMTP id ea27-20020a056a004c1b00b005328f07bba0mr3863402pfb.37.1660845363285;
 Thu, 18 Aug 2022 10:56:03 -0700 (PDT)
Date:   Thu, 18 Aug 2022 10:56:00 -0700
In-Reply-To: <xmqqk075qyq0.fsf@gitster.g>
Message-Id: <20220818175600.3531267-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: [PATCH v2] trailer: allow spaces in tokens
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
> "Max Bernstein via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Range-diff vs v1:
> >
> >  1:  404a6d1b193 ! 1:  4d490851ac2 trailer: allow spaces in tokens
> >      @@ Commit message
> >       
> >           Signed-off-by: Max Bernstein <max@bernsteinbear.com>
> >       
> >      + ## t/t4014-format-patch.sh ##
> >      +@@ t/t4014-format-patch.sh: test_expect_success 'signoff: not really a signoff' '
> >      + 	4:Subject: [PATCH] subject
> >      + 	8:
> >      + 	9:I want to mention about Signed-off-by: here.
> >      +-	10:
> >      +-	11:Signed-off-by: C O Mitter <committer@example.com>
> >      ++	10:Signed-off-by: C O Mitter <committer@example.com>
> >      + 	EOF
> >      + 	test_cmp expect actual
> >      + '
> 
> So, the updated code mistook the body of the message that is not a
> sign-off, because there is a colon on the line, the line does not
> begin with the colon, and everything before the colon is an alnum or
> a whitespace, so squashed the paragraph break before the real
> trailer block and the last line of the body and made it a body-less
> commit log message?
> 
> This might be a good demonstration of why it is a mistaken design to
> allow whitespaces, which may steer us toward fixing the documentation?
> 
> I dunno.  What do others think?

Yeah, this was the same issue we discussed a few years ago [1]. "git
commit -s" has never supported spaces before the colon (at least, it did
not support it before my patch set in [1] and does not support it now)
so it seems that having no spaces is already the established convention,
and I think that interpret-trailers should follow it. I would agree that
we should fix the documentation to match the current behavior.

[1] https://lore.kernel.org/git/a416ab9b-ff1f-9a71-3e58-60fd4f8a6b8e@google.com/
