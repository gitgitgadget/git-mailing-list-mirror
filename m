Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C79FC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2238161429
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhGBNlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhGBNli (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 09:41:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC3C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 06:39:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l24so13258897edr.11
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 06:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VJmGSzxFZMJEXw2ElwqLB1Uyvp8jFn41mFF+4gvsKy0=;
        b=NU2oM2wxnsvubtIMB6PqsDXoN+Y6uuylbcg8B0cYB6XVjspP3xrW27ZpFIUJWUXVNY
         mRnHALXzjGhhXR8X3GzXCRpHlAlT2rqqtl2a65EJLM027d7rhU1NwkLhiAMHivtIW2xL
         7Zpsr9koe5dfyrJXLOu2Ek7ixVo2BxjLXyXNALc5fSbbKOkYuTKQM3WSGEzM+MciMlE3
         GyHKC8r36PSKObrSSw4cz8UIW6kgOBWBI2Nk7tMV1nmUhDwiU0zd/49WxR/i9DBcNrh1
         tWxrxQzAUnWZ0UN7uAAtcJtmke1ujFZM8RU7aVcgPckDvSskKbFSxdrM83zj8LrD5Mm3
         6KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VJmGSzxFZMJEXw2ElwqLB1Uyvp8jFn41mFF+4gvsKy0=;
        b=oXDo1J5ilpVVwxiVviIK3akX51P5XKYzXJAzn+nw7lyk7t7WHk/ZYgZ2cty05Wro0l
         Ckb1fQWzE0BfjDWCjOe73vCjlvXnQfYH9kjVpvNokWf8lJFoQ4Kay7L+RtNCNiHXdYO8
         OS37+ZeDThs9avtayYJqIuwuoXQoxTdd60btWANP3yuSr5MqiRuOh97ihNrziUVxt2cA
         1J0YHjB24uCybA9zM62avYYpUQNzTr4AX1MENdtsUky7at6PIlw3Hnc1M1TsX5BVCkm/
         bYAxcw9RJryndWPPKiAbnk7bhaGp6/4VV9zbBFvNgZFmYRehGsMXEDoLL4iFH4I9impz
         itSg==
X-Gm-Message-State: AOAM532dQ4WLICu6RbUtbz4/tIEvi5GykixeEC1eW0pWkcRQgj417Uy7
        DKVdb4DpEiy+LdlOHawKULug8+JgdLtEFQ==
X-Google-Smtp-Source: ABdhPJxu4K7wGaS0Tp3otAVKB744rR1YOtV4OwmrdDbBCtZtm5M79WmTxe5E+QR+D46lbKzJVhAW2A==
X-Received: by 2002:a05:6402:7cf:: with SMTP id u15mr6788353edy.197.1625233145042;
        Fri, 02 Jul 2021 06:39:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h14sm1072128ejl.118.2021.07.02.06.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:39:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 12/15] [GSOC] cat-file: reuse ref-filter logic
Date:   Fri, 02 Jul 2021 15:36:32 +0200
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <e04b970ccb0cad8c0b651ab11f5f52063bd84606.1625155693.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <e04b970ccb0cad8c0b651ab11f5f52063bd84606.1625155693.git.gitgitgadget@gmail.com>
Message-ID: <877di8al8n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> In order to let cat-file use ref-filter logic, let's do the
> following:
>
> 1. Change the type of member `format` in struct `batch_options`
> to `ref_format`, we will pass it to ref-filter later.
> 2. Let `batch_objects()` add atoms to format, and use
> `verify_ref_format()` to check atoms.
> 3. Use `format_ref_array_item()` in `batch_object_write()` to
> get the formatted data corresponding to the object. If the
> return value of `format_ref_array_item()` is equals to zero,
> use `batch_write()` to print object data; else if the return
> value is less than zero, use `die()` to print the error message
> and exit; else if return value is greater than zero, only print
> the error message, but don't exit.
> 4. Use free_ref_array_item_value() to free ref_array_item's
> value.
>
> Most of the atoms in `for-each-ref --format` are now supported,
> such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
> `%(then)`, `%(else)`, `%(end)`. But these atoms will be rejected:
> `%(refname)`, `%(symref)`, `%(upstream)`, `%(push)`, `%(worktreepath)`,
> `%(flag)`, `%(HEAD)`, because these atoms are unique to those objects
> that pointed to by a ref, "for-each-ref"'s family can naturally use
> these atoms, but not all objects are pointed to be a ref, so "cat-file"
> will not be able to use them.
>
> The performance for `git cat-file --batch-all-objects
> --batch-check` on the Git repository itself with performance
> testing tool `hyperfine` changes from 669.4 ms =C2=B1  31.1 ms to
> 1.134 s =C2=B1  0.063 s.
>
> The performance for `git cat-file --batch-all-objects --batch
>>/dev/null` on the Git repository itself with performance testing
> tool `time` change from "27.37s user 0.29s system 98% cpu 28.089
> total" to "33.69s user 1.54s system 87% cpu 40.258 total".

This new feature is really nice, but that's a really bad performance
regression. A lot of software in the wild relies on "cat-file --batch"
to be *the* performant interface to git for mass-extrction of object
data.

That's in increase of ~70% and ~20%, respectively. Have you dug into
(e.g. with a profiler) where we're now spending all this time?
