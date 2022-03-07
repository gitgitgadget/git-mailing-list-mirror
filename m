Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305A4C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 20:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbiCGUYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiCGUYD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 15:24:03 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B1F36E30
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 12:23:08 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id z10so7039202uaa.3
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 12:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rexzKpIBezLdNZw5McdxKoJRuEoNJbihh42NLa3Z12U=;
        b=llgHE5W1lRI2tb+JsEgkLA/d+rP86kcXrSSr0o6ej+Z3sXuBqpOMky8oZs/V0u3tpn
         6MeYY3r6Jeb4zUb7QQlBoRMRqaYHcOSdQOMXWgI/ZJflvBXMlxa7o9XNbO/pbI+7oRvQ
         WEBVpt+KV5TL20nRN/t/72AUSh1wrh0/XSpAi/XebCZZ82CSIyn9QRxVrDOhZzNXqBsU
         LPWmXhsniLhm/3d5YgoRQRXwq2nr22fGHgUnFDE851KdFcJp3AJQpygkGzKrlFRcvhxs
         dYok+tgR9W3g7ZwJTQMJris4U2TrvqbV1ZDDkQTqxr6+17sUrf+NrXV8Rtd5JVma9qc8
         fWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rexzKpIBezLdNZw5McdxKoJRuEoNJbihh42NLa3Z12U=;
        b=HCD84TNdp4sygnX8SDhHvMk+I/OzgJ9VGf7FSIrQyn49gf8iZSUaRxhRZp+t8s59Wy
         Dh4fGtkZ7PjxNioDiE0dAX+/XGfFUYYjB2reET3aszyVJbAneS0Xy87QxU4XyXHA1Vbq
         m5KRsUZ3Jq/BVHtFzfW9KsdcfoYgipxCBCDMmyPRHPPaTfM99OT3mjonxLPzfj6uCeXN
         ujZca3yIQJ4urjT5/PFipILDmikeZkUma8An/1CFLAlVsLNGDOBNGiXEQ3xlUQyJXkDB
         r22mkr5HmoaRhyu7hLpszG+jrjVC2BOgkMLfQJ8GgBlDY5H9HumQfNB9tBYyIuE5Dlh5
         6nKQ==
X-Gm-Message-State: AOAM531KjWYx/ThLDm+UHBfIyeWU5yF6DhLY/HjcxXm/ViZ9DIf/ZF1b
        NDWWWp84dp00R2lz+SSb8sriQdbgSdQD4T90+Xk=
X-Google-Smtp-Source: ABdhPJxYOylFRlrDEKJia+TswhAOrKC+Rf42QV+DGq+cHfEv9e2kBt9N0ZvfUlzglmeLPWMvClrprSVwCo9VNXHPPLY=
X-Received: by 2002:ab0:7a66:0:b0:34b:7604:b052 with SMTP id
 c6-20020ab07a66000000b0034b7604b052mr4048173uat.7.1646684586605; Mon, 07 Mar
 2022 12:23:06 -0800 (PST)
MIME-Version: 1.0
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
 <20220228215025.325904-3-jacob.e.keller@intel.com> <xmqqpmn6wg98.fsf@gitster.g>
 <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
 <xmqqfso2t9cu.fsf@gitster.g> <6b00c67b-01c9-bf22-a8e6-904f47fa7acf@github.com>
 <f5ca62f4-eb3d-eeb7-e7c8-7fb800f3d6cd@intel.com> <3c3e6063-7eb4-7ff4-3a1b-a07db1fe969f@github.com>
 <xmqqfso1pgmv.fsf@gitster.g> <CO1PR11MB5089DC997DB42023324F1BF0D6029@CO1PR11MB5089.namprd11.prod.outlook.com>
 <xmqqilsvet82.fsf@gitster.g>
In-Reply-To: <xmqqilsvet82.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 7 Mar 2022 12:22:55 -0800
Message-ID: <CA+P7+xo=UwUQ422o36_8XGNWoYjROGi5wBT4=jy4ThJBs_z=Xw@mail.gmail.com>
Subject: Re: [PATCH] name-rev: use generation numbers if available
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 2, 2022 at 5:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Keller, Jacob E" <jacob.e.keller@intel.com> writes:
>
> > Let's clarify. There are two versions of the test in this version:
> >
> > 1) test which enables commit graph and tests that it does the right behavior.
> >
> > 2) test which removes commit graph and tests that it behaves the old way.
> >
> >
> > test (1) checks the flow with the commit graph enabled, and verifies that with a commit graph the new behavior is used. This test will fail if you revert the name-rev commit-graph support.
> >
> > test (2) always performs the way we don't like. (since we disable the commit graph and the new flow doesn't kick in) This is the test I think I will eliminate in the next revision.
> >
> >
> > I will remove the 2nd test, since the first test covers the change
> > in behavior just fine, and I think I agree we don't need to set
> > in-stone the implementation without commit graph.
> >
> > I will also look at adding a test which performs a count of which
> > revisions get inspected and makes sure that we actually are doing
> > the optimization.
>
> Sounds like a sensible thing to do.
>
> In any case, in the current patch, #2 is not working in
> linux-TEST-vars job at CI.  You can visit this URL
>
> https://github.com/git/git/runs/5400048732?check_suite_focus=true#step:4:68062
>
> while logged into your GitHub account for details.

Looks like this job sets all the TEST variables including
GIT_TEST_COMMIT_GRAPH=1? The negative test passes because the commit
graph is enforced on and we then succeed even though we were trying to
test the negative case.

I'm going to remove that test in v3 anyways, so I don't think it is a
big deal. However, I wonder is there some way to mark a test as
explicitely "don't run if GIT_TEST_COMMIT_GRAPH is set"?

Thanks,
Jake
