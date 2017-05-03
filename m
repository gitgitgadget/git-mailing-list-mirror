Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B941F829
	for <e@80x24.org>; Wed,  3 May 2017 18:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbdECSex (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 14:34:53 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33170 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdECSev (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 14:34:51 -0400
Received: by mail-pf0-f173.google.com with SMTP id q20so16564239pfg.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 11:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QMQytB1Cy9RErS9Z5hH4HbBlvYBpBiJPLD7BqNYp1RM=;
        b=mG6zb0QKLyImr+4GqT2VLZoeVrsFqefQsn4zmW+YWThq8RiRAx3cAYBcsXI6f62ryF
         VkLWlXqyW8DCfSLuWQhaXfLvdJKMfVMgWrr7JAi/5QD4Z7VqYkneQ3waMrv/WJVyzXwu
         KeGxAsbZ/jIWffd4Ap+HYHVPRZ63RO1iKEMDb7/sEwKh0F80o1Ez6+FaDoJh8qTPzfHR
         zlzmLOHXMUscFwsSuW0I4c6tmN+smtT0drcYUjMiBTZQTNCNA3GHjGRv0/KtqYPy0EJK
         p4TLcXsgeuffIUEaA+bS9kZ7O+w3zPlVEvc9kIRqZlL9QTNP6tJEH+I4cMYzyJAC62qb
         w9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QMQytB1Cy9RErS9Z5hH4HbBlvYBpBiJPLD7BqNYp1RM=;
        b=aTCTw/cXQdDuPxEyjOPPRpUz7gvVRUJrtIrpnD5v7kyIbT7bv5cxlJHkvhAQhb4xOg
         FXGvvyJkIXMHt08lpK4jtZBOsWDFvOS0LLNuXbqdNS5DbvMgm+sk9TPndt5kEhwUeEpM
         /tsf5QuLMs5/UQ4UwAhNYF4OTN1v/NGbfLs2V+exOVwqqBg3jze+T//Wim45ClNRlDfc
         UxLTyMfq/unEnvdBZPe1WomK0Hrx9Zir0U4YIkTLRYoWfl8y8nnvJNVv9x/RqEomGgdE
         0+QRonU+HvloqdSwA/fqqiBmv67O1Oz5Tp6Pzubc+wkq9KMZ5cmGV0JoSPQ/SO37DWRz
         CRDw==
X-Gm-Message-State: AN3rC/4n10AP2ozD2GR9OchX8WZctI08FFzrr6KAWdJlxyEc94Qs1X3I
        Pc1paz/+dj0EFhN8Su5ZQLeu0dxK5Sja
X-Received: by 10.84.241.136 with SMTP id b8mr51410183pll.107.1493836490932;
 Wed, 03 May 2017 11:34:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 3 May 2017 11:34:50 -0700 (PDT)
In-Reply-To: <CAJZjrdWLuXF7c=kt4SM1CcOUPpmmZXmOZPUCuzcO0z2nNsVMLQ@mail.gmail.com>
References: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com> <20170503032932.16043-1-sxlijin@gmail.com>
 <20170503032932.16043-2-sxlijin@gmail.com> <CAGZ79kauf5tAEv1JJCbTsuKhPYFKq0DVChBBt2EjHxRRZEzYAw@mail.gmail.com>
 <CAJZjrdWLuXF7c=kt4SM1CcOUPpmmZXmOZPUCuzcO0z2nNsVMLQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 May 2017 11:34:50 -0700
Message-ID: <CAGZ79katJKWOY=FdoU2DO-bwyZSA9KL3kcUgw1uKLyytNCXd-Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] t7300: skip untracked dirs containing ignored files
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2017 at 11:26 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
> On Wed, May 3, 2017 at 1:19 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, May 2, 2017 at 8:29 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>>> If git sees a directory which contains only untracked and ignored
>>> files, clean -d should not remove that directory.
>>
>> Yes that states a fact; it is not clear why we want to have this test here
>> and now. (Is it testing for a recently fixed regression?)
>
> It was recently discovered that this is not true of clean -d (and I'm
> not sure if it ever was, to be honest). See
> http://public-inbox.org/git/xmqqshkof6jd.fsf@gitster.mtv.corp.google.com/T/#mf541c06250724bb000461d210b4ed157e415a596
>
>> Are you just introducing the test to demonstrate it keeps working later on?
>> Do you plan on changing this behavior in a later patch?)
>
> The idea was to introduce the broken test and then have the rest of
> the patch series fix it;

This is valuable information for the commit message.
Also to keep git-bisect happy we want to have all tests passing on all commits,
which this does not. However to further signal your intent, you can mark it
as test_expect_failure. This is marking a test as "if Git was not buggy, this
is a test that would pass", so it actually marks success when it
fails, for example
when running t7300:

...
ok 31 - should not clean submodules
ok 32 - should avoid cleaning possible submodules
ok 33 - nested (empty) git should be kept
ok 34 - nested bare repositories should be cleaned
not ok 35 - nested (empty) bare repositories should be cleaned even
when in .git # TODO known breakage
not ok 36 - nested (non-empty) bare repositories should be cleaned
even when in .git # TODO known breakage
ok 37 - giving path in nested git work tree will remove it
ok 38 - giving path to nested .git will not remove it
ok 39 - giving path to nested .git/ will remove contents
ok 40 - force removal of nested git work tree
...

Similarly if you were to mark that test as expecting failure, we'd see:

no ok  - 45 git clean -d skips untracked dirs containing ignored files
# TODO known breakage

And then in a later patch, when you actually fix the bug, you would just flip it
to test_expect_success.

Thanks,
Stefan
