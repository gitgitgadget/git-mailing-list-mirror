Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361F4C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5E261264
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhDUITf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 04:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhDUITe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 04:19:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86913C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:19:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u21so62256232ejo.13
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=tF8eVPrbsFlxqgyzbHuCviFt7qqGesasnxvxc644nOo=;
        b=uehTV9BvTQm1nh05CE2hz1kyYDVNdIgUmRTjpT3VQloJFKThpjr8LU4XwFoiDVTefF
         AX8rV9pYFLysW6pN+E6wX53jra2vTK/FuDjrdjZMLgFBjrQCUOrpoM2k9GnnwCe4Rg/w
         gg+bV6HnK8nbho9vYV84k70IVPkl2bVnIyORz7A5PlEqQ09hLLSRuLh2QhnhUXnGbrlv
         zbd35pe7iFi9U0yA929n5F+w010qk0eC7pnp/TuyQuQ944oznQ+3rXCj/I4gZf2kLMLu
         6EjJbTEL5hcYE5eraM6S0MvRC7S/Yj4C/ZoEc5Q392JxAcU60x/JL5K0j8VjiLvYy/OR
         knng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=tF8eVPrbsFlxqgyzbHuCviFt7qqGesasnxvxc644nOo=;
        b=Ao/A81806j2y6Btf/qgTWuhtVXT9gV5P6OHxmicgEPt8NCMi2ci5MFXIsjngUWB2sG
         eoM6sCpNccTBdrnD4v/Mfe2UhuAHOndncbnaO+z/iU/GigwVWugodFH0GAgCQf9pPeqT
         MNhW3D5WNsoH7rKjFQA2F6ERA9DgkoKXCFA6qYToPc0eOQfPvzqObqK3EdsJBh9fj2Cl
         Yv1rBEj1QagaWQsdvt3zZmHPMaSTR+vbm5sHc7zFsj3iHz4FhXL/KkXx6FID/+oIxyZF
         R+IGuhyBekoDWQpzOxtRD8Av5T4vhz3HNRo82783UKvXHUXI1obx6DBJ/5sA1uzTj087
         SXTQ==
X-Gm-Message-State: AOAM530xhhU1xCDO/7cC7HAnav8p3mmKQxVPlwsLUn6lHVtfVC7sXumB
        0vhc0zbtGQyb4zHO9w+GJCY=
X-Google-Smtp-Source: ABdhPJx6ec+3wN5MRpQu1Wk/fWKDJrO0nKB1o7pRj5w2HKFjl7aSBzBkVtjRRHhdNKDw/nn7NDIskg==
X-Received: by 2002:a17:906:a385:: with SMTP id k5mr31218713ejz.148.1618993140190;
        Wed, 21 Apr 2021 01:19:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id by27sm1596408ejc.47.2021.04.21.01.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 01:18:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Luke Shumaker <lukeshu@lukeshu.com>, git@vger.kernel.org,
        Luke Shumaker <lukeshu@datawire.io>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
References: <20210420190552.822138-1-lukeshu@lukeshu.com>
 <xmqqa6ps4otm.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqa6ps4otm.fsf@gitster.g>
Date:   Wed, 21 Apr 2021 10:18:58 +0200
Message-ID: <87zgxs2gp9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 20 2021, Junio C Hamano wrote:

> Luke Shumaker <lukeshu@lukeshu.com> writes:
>
>> That'd work fine if they're lightweight tags, but if they're annotated
>> tags, then after the rename the internal name in the tag object
>> (`v0.0.1`) is now different than the refname (`gitk/v0.0.1`).  Which
>> is still mostly fine, since not too many tools care if the internal
>> name and the refname disagree.
>>
>> But, fast-export/fast-import are tools that do care: it's currently
>> impossible to represent these tags in a fast-import stream.
>>
>> This patch adds an optional "name" sub-command to fast-import's "tag"
>> top-level-command, the stream
>>
>>     tag foo
>>     name bar
>>     ...
>>
>> will create a tag at "refs/tags/foo" that says "tag bar" internally.
>>
>> These tags are things that "shouldn't" happen, so perhaps adding
>> support for them to fast-export/fast-import is unwelcome, which is why
>> I've marked this as an "RFC".  If this addition is welcome, then it
>> still needs tests and documentation.
>
> I actually think this is a good direction to go in, and it might be
> even an acceptable change to fsck to require only the tail match of
> tagname and refname so that it becomes perfectly OK for Gitk's
> "v0.0.1" tag to be stored at say "refs/tags/gitk/v0.0.1".

Do you mean to change fsck to care about this it all? It doesn't care
about the refname pointing to a tag, and AFAICT we never did.

All we check is that the pseudo-"refname" is valid, i.e. if we were to
use the thing we find on the "tag" line as a refname, does it pass
check_refname_format()?

"git tag -v" doesn't care either:
	
	$ git update-ref refs/tags/a-v-2.31.0 3e90d4b58f3819cfd58ac61cb8668e83d3ea0563
	$ git tag -v a-v-2.31.0
	object a5828ae6b52137b913b978e16cd2334482eb4c1f
	type commit
	tag v2.31.0
	tagger Junio C Hamano <gitster@pobox.com> 1615834385 -0700
	[.. snip same gpgp output as for v2.31.0 itself..]

I think at this point the right thing to do is to just explicitly
document that we ignore it, and that the export/import chain should be
as forgiving about it as possible.

I.e. we have not cared about this before for validation, and
e.g. core.alternateRefsPrefixes and such things will break any "it
should be under refs/tags/" assumption.

There's also perfectly legitimate in-the-wild use-cases for this,
e.g. "archiving" tags to not-refs/tags/* so e.g. the upload-pack logic
doesn't consider and follow them. Not being able to export/import those
repositories as-is due to an overzelous data check there that's not in
fsck.c would suck.
