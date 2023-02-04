Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6EBC61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 15:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjBDPMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 10:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjBDPMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 10:12:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05C837F26
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 07:12:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so579056wmb.2
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 07:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ziXgiCed7w8YbYxxTFq95jEu8XuGKR/+V4V+P7pvWs=;
        b=QAtAnY+yTFmfU6XQqcV42ahnCFof25YIcR1QpDkpNopGMI1Tufl6/J2Y2rINo3evTI
         I2kQmCAfq+VlIFfaJQ0LRwFk2jdPhAYWErkLJYdoKhiUAE4zgA+bsBOcmy/FOSIqLGOU
         ovGtXMAimDBLFwm5Cuu/X+e6ZijvgLsNYZxcQbuebf8bZiSMv2vHv7euyd7r83wW4tov
         t541VafML1fcfZFALZmjiVPtYM/t2Rmg9hI9Zh0JTP8OH0YqUe9wYaAO4qLzvLTSyyOi
         b24WRPXwuG+d7/OIlSvJYAWHQsJ3qXrqFnX79J9P9fL9W6J3iTPM15dYJu3IYjHmCFiw
         rIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ziXgiCed7w8YbYxxTFq95jEu8XuGKR/+V4V+P7pvWs=;
        b=ll4DOn2TXPP1oyTiV182btGe21Gjd8PhZ1VgYklYnocJRfgw4vuUJtIqGOjl1CcjhK
         zPOGBe9sSg1dKcNIrTwZGpoWVTO3G+/GH2AN5tCvpPDBAow5FpgI205yGsiUoIrnjQU6
         tfszmGOtlvd14VkXCuZd3ztfE46wVgRyIJRrKRuRplDLv1C7fDENMR3XC6fNDP+HW2yR
         Nhm0TsRXAY3IiM6XBlRGElv0fKpRQTbp5LFzOnFvhIvHXChh7+X3WnBPPcPPuDDJInx5
         X9FW60KmqBinq7oT4CDMr81nZmZHAOqKQ0mz6e4a3TmD4wqfwwYBYiLUeQc8ye9tW5ks
         dE1g==
X-Gm-Message-State: AO0yUKUKBMJCB7HbwXekKVafamJmnzN+f7cloFj5WDkpGS2MQhzxDZpJ
        aG3mLRCBnML30lrsdlpqI6XP/FcCzeovMrUhYqhj/HQ2QEoMvaSj
X-Google-Smtp-Source: AK7set/mu8+2WOyyUlTETnkoo1YnvORmQ/+DvtXzJfgJvK8nh6ztKOXtCnbb/108LeqbPBkpCw3kDfQsB4hWkeeoPXI=
X-Received: by 2002:a05:600c:5102:b0:3dc:45a5:8132 with SMTP id
 o2-20020a05600c510200b003dc45a58132mr510985wms.111.1675523545171; Sat, 04 Feb
 2023 07:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20230202202557.19297-1-kostya.farber@gmail.com>
 <xmqqa61vsniy.fsf@gitster.g> <CAPig+cTC4TUK2NXFmP6ymEYYjYAmCSd53dzFhKn0ido8x6uh1Q@mail.gmail.com>
In-Reply-To: <CAPig+cTC4TUK2NXFmP6ymEYYjYAmCSd53dzFhKn0ido8x6uh1Q@mail.gmail.com>
From:   Kostya Farber <kostya.farber@gmail.com>
Date:   Sat, 4 Feb 2023 15:12:14 +0000
Message-ID: <CAPRQfCYxdkTqqBuN3qY1_UsXYk59ocxNd6D31rO+MoGf_4fsUw@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t/t5000-tar-tree: add helper function
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2023 at 11:09 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Feb 2, 2023 at 5:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Kostya Farber <kostya.farber@gmail.com> writes:
> > > Add the helper function test_file_path_exists to the
> > > interpret pax header test. This change makes it clearer
> > > as to what the test is trying to check, in this case whether
> > > a file path exists.
> > >
> > > -                             if test -h $data || test -e $data
> > > +                             if test -h $data || test_file_path_exists $data
> >
> > Nothing seems to be adding a new helper whose name is
> > test_file_path_exists; the patch expects such a helper already
> > exists and uses it in place for existing "test -e".
> >
> > Perhaps you meant to say "use test_path_exists" not "add helper" on
> > the title, and use that function in the patch instead?
>
> A couple comments...
>
> The test framework does not define a function named
> "test_file_path_exists". Probably "test_path_exists" was intended.
>
> Delving more deeply, though, this change seems undesirable from a
> clarity viewpoint. The function "test_path_exists" is an assertion;
> its purpose is to make the test fail if the path is expected to exist
> but doesn't. However, in the original code from t5000:
>
>     if test -h $data || test -e $data
>     then
>         path=$(get_pax_header $header path) &&
>         if test -n "$path"
>         then
>             mv "$data" "$path" || exit 1
>         fi
>     fi
>
> it is perfectly fine if the path is neither a symbolic link nor an
> actual file; that's not considered an error. Therefore, using an
> assertion function -- which suggests test failure -- muddles the
> intent of the code rather than clarifying it.

Okay, that makes sense. Thanks for explaining why this function isn't
desirable in this instance, and why it actually reduces the clarity of
the test.

> Additionally, t/test-lib-functions.sh also defines the function
> "test_path_is_symlink" which would seem to be the obvious complement
> to "test_path_exists", thus one might have expected the patch to
> change the code to:
>
>     if test_path_is_symlink $data || test_path_exists $data
>     then
>         ...
>
> however, "test_path_is_symlink" is also an assertion, thus not really
> suitable for this case in which it is acceptable (not an error) if
> neither condition holds true.
>
> So, t5000 seems to be one of those relatively rare cases in which the
> raw "test" command is more correct than the higher-level helper
> functions.

Yes on first glance it would look like test_path_is_symlink would be
the obvious complement, but as you say I guess it doesn't make sense
in this case for the same reasons as using test_path_exists.
It's a good learning experience for me to understand when, and in
which contexts, to use the helper functions.

Thanks
