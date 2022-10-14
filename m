Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A642C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 19:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiJNTOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 15:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiJNTOl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 15:14:41 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA9AC11
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 12:14:36 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id r20so3009306ilt.11
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 12:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l58Kj5Ubj2uNZvmNY2Z4hGeNm9YNLrbmzJq4tX9g1RU=;
        b=X/bfao8kq9R90Xney3ewna1TY0UP6p7uTcU1bTw5IJkNCxZwUvyPaEKi884hgv6llP
         uDV/HIz37XuWJUSooOZFYOjR2AmdEPUGylLs+zCCEa0W9R5hFnDZKa5g3/MgEjOjkXAj
         4ER7YSDqURo3CB0Fd+iI5QDqr129kVvTBsxHy8Y4opr0dP2Y5YxQQNxPSS5Ke6jkc5oa
         dCMFyEyDjwuAhurbaUPBMIGHJsvR8+sw271fC/HKk9VA8g8//3STuiJFVfp2lJ4NfH43
         GB9XKiMSO8ysJe3Gq/luxy17HWT6DQszKHvB2dlkZ+vXnSt6/gFY+Wlg0TVirrZjEcaG
         IAjw==
X-Gm-Message-State: ACrzQf3CN8ZVyfKr8MA7EOt+qmGGQWFfynZNGjQ91EEZQFBsKWD8mQa4
        7YnhAQVH1DckAjLpoLgCwmrdUlUjlizmuJzQzKw=
X-Google-Smtp-Source: AMsMyM7JPdVVamOyg4lsdz7n1oUQipyAOXVOWRnf0D7TC3zNioJttBda6eRMWHd20vl2/DOCv5h8NX9jLxabdatMEZA=
X-Received: by 2002:a92:c561:0:b0:2fa:3ca6:1672 with SMTP id
 b1-20020a92c561000000b002fa3ca61672mr3366108ilj.23.1665774875548; Fri, 14 Oct
 2022 12:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
 <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
 <xmqqv8om9yaz.fsf@gitster.g> <f064ce46-8ed0-a9c1-8df5-5c258677d95f@github.com>
 <CAPig+cT=bJ7BP9CDh5-oYYF376vVxsh7E0UAE_QN0wfAgR3AAg@mail.gmail.com> <xmqqh7068bta.fsf@gitster.g>
In-Reply-To: <xmqqh7068bta.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 14 Oct 2022 15:14:24 -0400
Message-ID: <CAPig+cR2R3EY=53ELaFY3wqy7danQmHNm0Qeqqh9nW7n8XHNHg@mail.gmail.com>
Subject: Re: [PATCH v3] [OUTREACHY] t1002: modernize outdated conditional
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 3:06 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Fri, Oct 14, 2022 at 12:35 PM Derrick Stolee
> > <derrickstolee@github.com> wrote:
> >> GitGitGadget will read the "cc:" lines from the end of the pull request
> >> description, not the commit messages. I'm pretty sure they will be
> >> ignored if there are other lines after them.
> >
> > For Wilberforce's edification for future submissions, presumably the
> > reason that the CC: in the pull-request's description didn't work is
> > because the CC: line wasn't the last line in the description? Does
> > there need to be a blank line before the CC: line? Is it okay to list
> > multiple people on the same CC: line as done in this case, or is that
> > also a problem?
>
> Ah, now I can see why the round v4 is CC'ed to you and Derrick on
> the list.  The pull-request text (visible in GitHub UI in the top
> most box of https://github.com/git/git/pull/1362) ends with two
> lines of cc: that list you two.  The one named Christian and Hariom
> were not at the end and was ignored by GGG, it seems.

Yes, the CC: line mentioning Christian and Hariom was not at the end
of the description, which is likely why GitGitGadget didn't pick it
up. (Presumably Stolee overlooked that line when responding to my
question.) However, clarification about whether or not there needs to
be a blank line before the CC: line would be nice (I presume the blank
line is needed), but also whether or not GitGitGadget correctly deals
with multiple people mentioned on the same CC: line or if they each
need to occupy a single CC: line.
