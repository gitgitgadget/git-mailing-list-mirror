Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A4EC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 19:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbiCBTgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241521AbiCBTgO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 14:36:14 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0505FD7622
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 11:35:31 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 62-20020a621541000000b004f110fdb1aeso1794245pfv.13
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 11:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=07tArAKbJtTaczthFjppVGY4jTC4DHHsLieNQNWeDV4=;
        b=Od3QmNu7Jmd5NQk+tZZqG/qgE7z4lgpppYRdtNvFuw/rtrODplYYgTzPebWdoL0WUH
         /hqZ1+384021tf4XXwR0LNKQOHkrnMouORIpeMlrgQQV7k7lMhj6sb7Lj3uLmDEZl/S0
         r4ahz7+ysEXiXhKLklzV/XBgTAiJswOz1ZEBYgCTf2Ye41d0A4HyinNzUdHoTJsYGj8W
         zGwoIG/lUgwt8St6hbBIgC9uuKfZe+5Vb8eGrp5fXFUglTNymb2arUmqdnMlO7w4hvMe
         Fp61R+drry7O3RetM/mxNyA98MpByeTakcr6V370djacZnmWXS0R0WxlreApaKfBy0vj
         x3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=07tArAKbJtTaczthFjppVGY4jTC4DHHsLieNQNWeDV4=;
        b=AsCt2OQpTcaFDtmOwcEckxu55gXIH0A3ZBq2FUBzmSzBTU0p6SXKQZ0gj97nd4ROM1
         sS7ZcHEG1JqEwqCFc47J3KyEatinKyrqJYTYVAyZjeU02XaqJJvnBMEnkCdTwJ1frWZO
         OrbT1ev6H9epbBaWfyBoFXuiqU0qsVJsC0DWy759OBgYbTJAIR/N0BVFvjsmhG/Qa5fx
         Q6C9snS1HFOomeWz7clRF/JlsGdPNZ1RKIfEVmzoe2kThnsYDXxzThMk0iDIcaCFnIQ/
         2VObjIjCfM6zDojs7LMkK4/42JsbnnuKcjEzGs8m8YmEs7qXlwNqXLKjfZSbSRg6MuoR
         yxkQ==
X-Gm-Message-State: AOAM5332IjNS36mbji2lwNl1NNx7WIOwxGGprFa6TuUVaXadJ0yhfQ8E
        aSC7I0ARhbJD95Qg+QqGG6sngDVbkZf5lg==
X-Google-Smtp-Source: ABdhPJxem2MuCgzWtlP8nwBAD3Ott+TPva34XD8dMmHS4Xwzsx+ECiJrtdivxzuCIJZtWK/IXxU4uOWQJ8/oVA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4f43:b0:1bc:7e5c:e024 with SMTP
 id pj3-20020a17090b4f4300b001bc7e5ce024mr699894pjb.0.1646249730146; Wed, 02
 Mar 2022 11:35:30 -0800 (PST)
Date:   Wed, 02 Mar 2022 11:35:27 -0800
In-Reply-To: <xmqq5yowolvs.fsf@gitster.g>
Message-Id: <kl6lilswdu68.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220302003613.15567-1-chooglen@google.com> <xmqq5yowolvs.fsf@gitster.g>
Subject: Re: [PATCH] checkout, clone: die if tree cannot be parsed
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> -		tree = parse_tree_indirect(old_branch_info->commit ?
>> -					   &old_branch_info->commit->object.oid :
>> -					   the_hash_algo->empty_tree);
>> +
>> +		old_commit_oid = old_branch_info->commit ?
>> +			&old_branch_info->commit->object.oid :
>> +			the_hash_algo->empty_tree;
>
> I guess this is done only so that you can use the object name in the
> error message, which is fine.

That's correct.

>> +		tree = parse_tree_indirect(old_commit_oid);
>> +		if (!tree)
>> +			die(_("unable to parse commit %s"),
>> +				oid_to_hex(old_commit_oid));
>
> "unable to parse commit" is a bit of a white lie.  In fact, there is
> nothing that makes oid_commit_oid the name of a commit object.
>
> "unable to parse object '%s' as a tree" would be more technically
> correct,

Hm, yes. With regards to parse_tree_indirect(), "unable to parse object
'%s' as a tree" is a more accurate description of the failure. But since
we know that the oid is a commit in this context, I'm not sure if we
need to offload that much information to the user - if we failed to
parse the given object id in the appropriate manner, the user would
still be directed to figure out what's wrong with the object.

>          but one random-looking hexadecimal string is almost
> indistinguishable from another, and neither would be a very useful
> message from the end user's point of view.  I am wondering if we can
> use old_branch_info to formulate something easier to understand for
> the user.  update_refs_for_switch() seems to compute old_desc as a
> human readable name by using old_branch_info->name if available
> before falling back to old_branch_info->commit object name, which
> might be a source of inspiration.

I think it's actually more helpful to have the oid instead of a
human-readable description like old_branch_info->name.

For an advanced user/repo admin, seeing the oid makes it very obvious
that there's a particular problem with the given object, and this would
direct them to hunt down the object locally (without partial clone) or
on the remote (with partial clone, as in the original motivation). From
there, it's easy to figure out which branch points to the offending
object. The branch name might be misleading - the user would presumably
start with hunting down the ref, then explore several possibilities
before realizing the problem is actually with the _object_.

For a novice user, neither the branch name nor the object id is
actionable because they probably wouldn't be able to fix the issue
anyway. The advantage of the opaque hex string is that by being
intimidating and unrecognizable, it indicates to the user that they
shouldn't try to debug the issue and so they might give up sooner and
ask for help from someone who might be able to fix it.
