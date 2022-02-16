Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C328C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 17:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbiBPRdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:33:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbiBPRdu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 12:33:50 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A8E21F5C6
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 09:33:38 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id g19-20020a17090a579300b001b9d80f3714so1797912pji.7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 09:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=exdQdxisUnW2bmoiOBP2nO/sGn9vRXiRX2IK5vBVYEE=;
        b=M8DubX8zZMYe2opVrFw7C+Vl2Bf6NkCh43kVrOdhzCIcEVx5/HCDbh8MHld/0OWWVi
         /ue9JootSDBq03U5uOcoeQq+rB/pNFX4JWQ78RUWlK+RHotagyh6vVNCoVdSUSBliW/D
         7RK4PEw14YneC4B/pXNJR7RtnxLfgAurV8qLsNMScpTD6aCryTHQgK3n0A9v8jlWwcYZ
         N7LxyRnt1RerdH1sHx9EuTJYur3EMOMw2S1a6KZx9+FRal5+DBSV+telDo1IQPnh0l8j
         Hkk1pXsn7FWyDjYw6pqpGc+1ki7lGd+JfyG2qj9aRaR1ulin8kznX6sFM1wAvmSgBK3a
         Oouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=exdQdxisUnW2bmoiOBP2nO/sGn9vRXiRX2IK5vBVYEE=;
        b=E8VJ5Jj17Xft/QXd24zI6PMQYn0sCnH6BqXtXrTFt/lqxJ0rCHMrN8eEJwC49r0hV/
         IBwOedEXnabOKYo6kFENeySFpK/g1Y7AXovTlgecyQD3YYHh/1TohTxlY7P0Wh9YE8Fa
         Es0AFrUuMlz6enBwNYvOcpVn6yIBX5Sv5n0LuuPGUhXIDcigWPSuR9zWrV42HMtZGQYD
         xbyK9K0MYiqNigrmlLrZcqhrSpOpfc/6VRO/WGl6rA0gtqyNN+8Cw7C991hEqOew2tHQ
         rXWk1YoNRjGg51L0fe5rPs1IxttHHWhMJroiXpXoyYv9Z6UHkLJDDkumSDjC1ACq4pWO
         Yuxg==
X-Gm-Message-State: AOAM533xKljC54HibMy1AaCVd3ZQ3D/yFWLxX7/DZE2P+moVqbwOfwVm
        ZeCXnmdnvSK4vGvcXIY3cSKR7mZqeDM9Iw==
X-Google-Smtp-Source: ABdhPJyc5l8UMk865Fbr2oOCowkGQ+H3t4Mj2AXDSti6QsUV5z0pIHqZPNc5ld9nLJPISrqPK0uIn6G988ND0A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:6942:b0:14c:b20e:2b1a with SMTP
 id k2-20020a170902694200b0014cb20e2b1amr3656764plt.112.1645032817604; Wed, 16
 Feb 2022 09:33:37 -0800 (PST)
Date:   Thu, 17 Feb 2022 01:33:25 +0800
In-Reply-To: <220216.86bkz7uowl.gmgdl@evledraar.gmail.com>
Message-Id: <kl6la6eq67iy.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220215220229.1633486-1-jonathantanmy@google.com>
 <kl6lr1835poe.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lee435g72.fsf@chooglen-macbookpro.roam.corp.google.com> <220216.86bkz7uowl.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v2 7/9] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Feb 16 2022, Glen Choo wrote:
>
>> Glen Choo <chooglen@google.com> writes:
>>
>>> Jonathan Tan <jonathantanmy@google.com> writes:
>>>
>>>> Glen Choo <chooglen@google.com> writes:
>>>>> +	# Create new superproject commit with updated submodules
>>>>> +	add_upstream_commit &&
>>>>> +	(
>>>>> +		cd submodule &&
>>>>> +		(
>>>>> +			cd subdir/deepsubmodule &&
>>>>> +			git fetch &&
>>>>> +			git checkout -q FETCH_HEAD
>>>>> +		) &&
>>>>> +		git add subdir/deepsubmodule &&
>>>>> +		git commit -m "new deep submodule"
>>>>> +	) &&
>>>>> +	git add submodule &&
>>>>> +	git commit -m "new submodule" &&
>>>>
>>>> I thought add_upstream_commit() would do this, but apparently it just
>>>> adds commits to the submodules (which works for the earlier tests that
>>>> just tested that the submodules were fetched, but not for this one). I
>>>> think that all this should go into its own function.
>>
>> I'm testing out a function that does exactly what these lines do, i.e.
>> create a superproject commit containing a submodule change containing a
>> deepsubmodule change. That works pretty well and it makes sense in the
>> context of the tests.
>>
>>>> Also, I understand that "git fetch" is there to pick up the commit we
>>>> made in add_upstream_commit, but this indirection is unnecessary in a
>>>> test, I think. Can we not use add_upstream_commit and just create our
>>>> own in subdir/deepsubmodule? (This might conflict with subsequent test=
s
>>>> that use the old scheme, but I think that it should be fine.)
>>
>> We can avoid the "git fetch" if we first need to fix an inconsistency in
>> how the submodules are set up. Right now, we have:
>>
>>   test_expect_success setup '
>>     mkdir deepsubmodule &&
>>     [...]
>>     mkdir submodule &&
>>     (
>>     [...]
>>       git submodule add "$pwd/deepsubmodule" subdir/deepsubmodule &&
>>       git commit -a -m new &&
>>       git branch -M sub
>>     ) &&
>>     git submodule add "$pwd/submodule" submodule &&
>>     [...]
>>     (
>>       cd downstream &&
>>       git submodule update --init --recursive
>>     )
>>   '
>>
>> resulting in a directory structure like:
>>
>> $pwd
>> |_submodule
>>   |_subdir
>>     |_deepsubmodule
>> |_deepsubmodule
>>
>> and upstream/downstream dependencies like:
>>
>> upstream                             downstream           =20
>> --------                             ----------
>> $pwd/deepsubmodule                   $pwd/downstream/submodule/subdir/de=
epsubmodule (SUT)
>>                                      $pwd/submodule/subdir/deepsubmodule
>>
>>
>> So we can't create the commit in submodule/subdir/deepsubmodule, because
>> that's not where our SUT would fetch from.
>>
>> Instead, we could fix this by having a more consistent
>> upstream/downstream structure:
>>
>> $pwd
>> |_submodule
>>   |_subdir
>>     |_deepsubmodule
>>
>> upstream                             downstream           =20
>> --------                             ----------
>> $pwd/submodule/subdir/deepsubmodule  $pwd/downstream/submodule/subdir/de=
epsubmodule (SUT)
>>
>> This seems more convenient to test, but before I commit to this, is
>> there a downside to this that I'm not seeing?
>
> Won't this sort of arrangement create N copies of e.g. a zlib.git or
> some other common library that might be used by N submodules.
>
> But I haven't read all the context, I'm assuming you're talking about
> how we store in-tree a/b and x/y/b submodules now, we store those in
> .git/ both as .git/modules/b.git or whatever? I can't remember ... :)

Ah the problem I'm describing is much simpler, it's just "how do we want
our test setup (which has submodules) to look".

But we can also consider the question you are asking :)

> Whatever we do now I do think the caveat I've noted above is interesting
> when it comes to submodule design, e.g. if both git.git and
> some-random-thing.git both bring in the same sha1collisiondetection.git
> from the same github URL should those be the same in our underlying
> storage?
>
> I think the answer to that would ideally be both "yes" and
> "no".
>
> I.e. "yes" because it's surely handy for "git fetch", now you don't need =
to
> fetch the same stuff twice in the common case of just updating all our
> recursive submodules.

Hm, and it would save space on disk.

> And also "no" because maybe some users would really consider them
> different. E.g. the you may want to "cd git/" and adjust the git.git one
> and create a branch there for some hotfix it needs, which would not be
> needed/wanted by some-random-thing.git.

I don't think we could say "yes" for all users, because the subset of
users you describe here will probably appreciate them being separate.

But I can imagine doing this manually, like a "git submodule dedupe",
that lets users who really need it can opt into this risky setup where
submodules are shared. Does anyone really need it though? I'm not sure
yet.
