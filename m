Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43455C4707F
	for <git@archiver.kernel.org>; Fri, 28 May 2021 01:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1154F61005
	for <git@archiver.kernel.org>; Fri, 28 May 2021 01:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhE1BiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 21:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhE1BiN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 21:38:13 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB4EC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 18:36:39 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g17so1668303qtk.9
        for <git@vger.kernel.org>; Thu, 27 May 2021 18:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eZllKgud/kkeBMFkHdKwEjcNX32NtA2PTGReup0MYH8=;
        b=UmpQiGHn/mJJLq6cs5bsLKuJztqhC0vWFW1yrFJEb1WU/mQ6dRbGIG3FjwwbTnv0KO
         rPZKIKkjM4VGyBlCvcici7DNHgoznAr8FsjXnbeGKiOUb25pLyzcxfidPyFsDr2oQHJr
         5mhsLAksMDo7QLeZlYJvxIilVuKq71Akt6Giy4K9oLPBs+fgfTGlb/eGS/ZVWZKAuO9F
         2APtUdCLJbqJNeCCFXXzD9tq9IlTtg7f41Gr4ow8pdEsCu/eKGSvpSzNce5Y0GV0xBgO
         JEWf8qKz+tyIcQB+aS5yi9TkoetN3ujZejBB3l8hqs/cq0sIoO0kkv4pG+y7EEY8w1g7
         8fkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eZllKgud/kkeBMFkHdKwEjcNX32NtA2PTGReup0MYH8=;
        b=qt/CFaBJKD1Oqs6PmAOrFk/YDVGjbD3PdpDLH+z4oywWtXirV9SRVHpcIjAsCj+41L
         EKWnOy2DF0unPb92ICO782HBVPKJKJRLioR31MWnd8EhxaN+e9gYwdGp1IyN70Rvvh8T
         AeScTTYVdToczwcSLk8IcNtFfvfsLBNXhcj/N2yH9b8xOTeAq4AArcdNVMc6cmZ7y7oM
         t2v2ZXFdNqn6WgH14hNwhm23WPVLeB1duo73ve9FJmsOv9kkbR0XIg3KTLjIAzSlF3sg
         vkg3CeDzmC5Ji/GptT21X3B4zt9lZR5+KASJ3DQl7IcWl35MW6chozznIg0q2jeIkDZv
         Rflg==
X-Gm-Message-State: AOAM531DxPkDB+l6kkS+tPC95ATyFPk7l2oVjfZNiFQ36JuQztCXUSeO
        bH4xcf6p9XIF/Mk6KfdvGiG59aycf/IOTgB+
X-Google-Smtp-Source: ABdhPJz2Vgh2IRmRheilfzcc7JxkA5awImTqaLXmcn9QYJvs0S7MVSG6m6oELIwdN86wr6zK9H89XQ==
X-Received: by 2002:a05:622a:110e:: with SMTP id e14mr1297613qty.283.1622165798585;
        Thu, 27 May 2021 18:36:38 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e878:3e85:58af:261f])
        by smtp.gmail.com with ESMTPSA id g5sm2409420qtv.56.2021.05.27.18.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 18:36:38 -0700 (PDT)
Date:   Thu, 27 May 2021 21:36:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
        Kevin Daudt <me@ikke.info>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Should we do something with #git-devel on Freenode?
Message-ID: <YLBJJEQEUW8MVJm8@nand.local>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com>
 <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
 <YK6XvmrtrdkJvsnI@nand.local>
 <YK6o/j7P0JIGW0Q0@alpha>
 <7e9683aee2c0fea2ff77b82bfa547e15@jk.gs>
 <87im33ltqr.fsf@evledraar.gmail.com>
 <60b046dd3f5f2_40592208df@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60b046dd3f5f2_40592208df@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 27, 2021 at 08:26:53PM -0500, Felipe Contreras wrote:
> Ævar Arnfjörð Bjarmason wrote:
>
> > I don't see why we'd advertise #git@liberachat and not #git@freenode in
> > order to achieve that goal, the latter doesn't seem to be a graveyard
> > and is probably still more active. I don't see why we'd need to pick
> > between the two, any more than we'd pick between advertising
> > #git@liberachat and the git-users mailing list. Both currently seem like
> > useful venues for git users to go to get help.
>
> Agreed.
>
> The primary purpose of an IRC channel should be to help users, and if
> right now the person that could help a user is on freenode, so be it.
>
> If the people with some political alignment want to emphasize
> LiberaChat, that's fine, but keep mentioning freenode.

git-scm.com was updated recently to mention LiberaChat instead of
Freenode [1]. That was done to reflect the reality of [2]. I suspect that
will have been the right decision, but in case it isn't (and there are
still people hanging around in #git on Freenode), then I'd be in favor
of mentioning both.

For what it's worth, I also do not care about the Freenode versus Libera
(or vice-versa?) debacle. That said, I do think having one central place
for people to hang out is better than two (if for no other reason than
  it's fewer places to check or go to if you want help), but I would be
  fine if the status-quo were that there is an active #git channel on
  both Libera and Freenode.

Thanks,
Taylor

[1]: https://github.com/git/git-scm.com/pull/1608
[2]: https://lore.kernel.org/git/7e9683aee2c0fea2ff77b82bfa547e15@jk.gs/
