Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B27C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 09:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiGAJhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiGAJho (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 05:37:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA522747B7
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 02:37:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e2so2235681edv.3
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 02:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=n8bW6NR2+XB/MyqaT9dvZQfPEo6B8byJ4jqG3IW6RNY=;
        b=m2FKzmlN7CPPNATo6SRm01nxIpJ16iqL/gRkGZaTaD6aLMJa71m/NvALuF761DUFC8
         2b37Xd8BS6OseAoBog+d+PrLch7RZo87R1cM2bze96dDKho/pJSsetTBemDDa9yqr6tf
         nQs9k0RlkdAGUqyta64L36HOcbfNBrmz9HIRZaH+AX0GVdQDbQ+v8OR84+jeGLIkdFrD
         fv7IK0SXIYfuugEsYsMIJZAU2rbUi+LBTbxKpKsBn2QAyHij454EsyuXdUVFQZgBGO0l
         EsPgfNSCNiN8Ycv19kx9lOHjV2Q3vlGZRYz3iZ/Ejtk9vLnuPG/p/ilN+FtfhQOVCoh5
         wgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=n8bW6NR2+XB/MyqaT9dvZQfPEo6B8byJ4jqG3IW6RNY=;
        b=xyQF8A5NYr/wp7xDnUk/b2XoP5NQn5vek188HvwrKauDxKa+TCZmeSqaE0Jq5Ynuup
         9RZorlGej8/dRGbom6abfr44MdymsTNqplU2fJcbgSsajr0vO+0Lt13UgYtnfbLmwfgD
         /UXxVEIiGYcWzt469jQCFxBVnYtr5qitsRTXyee6c7oyDQiILIv5MhvBOctgkNjiPKDI
         ZWzGbdMuo7jGC8oa4PRU/k9aJtPJjNyqSi31B/9mNhzk0OFcHNDOkt2U5Rha26I0K9MU
         YRw5TF+MLKIpXLtNoT3KPalgapjQjnBhRKnHImTz2w6ruG4HYSaq3VJ/1JnCbYVWJud0
         AcPw==
X-Gm-Message-State: AJIora+oMnMeWpWP9idd3kcKsvkRwU3jhtcQkYv8V9tpQeOMSamYkA4x
        +283aNRS6zTy2YdwECBBn51fMUKiGQa3pQ==
X-Google-Smtp-Source: AGRyM1uf8fxqNRt5hg8ukiwvnieOOmfDMU9P/QGggaSD+xDvdQ1jercF2oyPefNIHPQ37G4UhWc80A==
X-Received: by 2002:aa7:c309:0:b0:439:4e82:36ce with SMTP id l9-20020aa7c309000000b004394e8236cemr9309386edq.318.1656668261240;
        Fri, 01 Jul 2022 02:37:41 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id m7-20020a056402050700b004356c0d7436sm14767213edv.42.2022.07.01.02.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 02:37:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o7D5o-0039ad-48;
        Fri, 01 Jul 2022 11:37:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v2 1/3] t6423: add tests of dual directory rename plus
 add/add conflict
Date:   Fri, 01 Jul 2022 11:29:32 +0200
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
 <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
 <bf4c03d01d5730503eb710e92a80136d5caa981a.1656572225.git.gitgitgadget@gmail.com>
 <220630.86tu82e9b8.gmgdl@evledraar.gmail.com>
 <CABPp-BEcojvfeuhp7rSi-O+9oEu4KpwPDwbKS-MiD1qCKde-CA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CABPp-BEcojvfeuhp7rSi-O+9oEu4KpwPDwbKS-MiD1qCKde-CA@mail.gmail.com>
Message-ID: <220701.86bku9b2cb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 30 2022, Elijah Newren wrote:

> On Thu, Jun 30, 2022 at 3:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Thu, Jun 30 2022, Elijah Newren via GitGitGadget wrote:
>>
>> > From: Elijah Newren <newren@gmail.com>
>>
>> > +test_setup_12l () {
>> > +     test_create_repo 12l_$1 &&
>>
>> Can & should just be "git init", see f0d4d398e28 (test-lib: split up and
>> deprecate test_create_repo(), 2021-05-10).
>
> I've switched to "git init" and even encouraged others to do the same
> in other test scripts, but since literally every other test in this
> file uses test_create_repo, I think they should all be converted at
> once and just be consistent here.  But, so we can stop having this
> conversation, after this series lands, I'll send one in to update the
> various merge testfiles that make heavy use of test_create_repo and
> convert them over.

Sorry, genuinely I didn't mean to mention it again, just saw it scroll
past & wondered if it was intentional. I'm fine with keeping it...

>> > +     (
>> > +             cd 12l_$1 &&
>> > +
>> > +             mkdir -p sub1 sub2
>>
>> The "-p" here isn't needed, you're not creating recursive directories.
>
> Indeed; will fix.

Thanks!

>> > +             git ls-files -s >out &&
>> > +             test_line_count =3D 5 out &&
>>
>> Can't this just use test_stdout_line_count? Except...
>
> Ooh, new function from late last year that I was unaware of.  Yeah,
> I'm happy to start using it.
>
>> > +
>> > +             git rev-parse >actual \
>> > +                     :0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
>> > +                     :2:sub1/sub2/new_add_add_file \
>> > +                     :3:sub1/sub2/new_add_add_file &&
>> > +             git rev-parse >expect \
>> > +                     O:sub1/file  B:sub1/newfile O:sub2/other \
>> > +                     A:sub2/new_add_add_file \
>> > +                     B:sub1/sub2/new_add_add_file &&
>> > +             test_cmp expect actual &&
>> > +
>> > +             git ls-files -o >actual &&
>> > +             test_write_lines actual expect out >expect &&
>> > +             test_cmp expect actual
>>
>> This test seems a bit odd, here we're just checking that we've created
>> scratch files for the internal use of our test, why is it important that
>> we have an "out" file, when the only reason we have it is because we
>> needed it for checking the "ls-files" line count above?
>
> Nah, you've misunderstood the purpose of the check.  It isn't "make
> sure that these untracked files are present among whatever else might
> also be present", it's "make sure the merge step did not introduce
> *any* untracked files" (something the recursive backend periodically
> did, and they weren't cruft untracked files but stored actual merge
> results).=20

Ah, thanks!

> There wasn't a nice easy check for that, the closest was to
> translate the requirement to "make sure the only untracked files are
> the ones explicitly added by this test script", which is the check you
> see here.  I don't actually care about "actual", "expect", or "out", I
> just care that there aren't any _other_ untracked files.

I'm fine with keeping this as-is, but FWIW perhaps this pattern is more
explicit about the intent:

	test_expect_success 'do merge stuff' '
		... &&
		rm -f expect actual &&
		git ls-files -o ':!out' >out &&
		test_must_be_empty out
	'

Or piping it to ".git/out", to avoid the path exclude, but like this is
also fine:) Thanks.
