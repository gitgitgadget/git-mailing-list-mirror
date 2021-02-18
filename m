Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54CFC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566C264D9C
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhBRMYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhBRKpb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 05:45:31 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106EFC06178C
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:44:35 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 6so1465342ois.9
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1XdEUiPatQT6Xhs3D9dyd4Nc7agQ1M3PoJkRCToIwY=;
        b=OJ5RiDd1fd3DDrV1H+gtT13gtNAz3BSkRUo3RZ6qxQncginEpBXBg1nA5AcqsmXOvJ
         Pg+Fv7EOA6xL8E5UE5pKVNoSz4xZ1K7y4ag+GgoClvOIbYmq9yc88G4mR+/GqR9D6JhV
         aTYZBbncsO0Qk2XMEDjt0WKxT+8mqb5stg+FVntld6GLHBFlhdlq7jNzIEEqZDmYXjbs
         xZsTN5repu35kHVzZhWGfrXYK0FoKVVoqZUMzeJPRFJj/KXTLlI950T8lDpdHbM8h5U+
         Wz7RWcvfhxChKNjh6a89NBIkp+9333b13iek35eiSM7Ots6eAJtIeeXzMOyZc5NasuXx
         LYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1XdEUiPatQT6Xhs3D9dyd4Nc7agQ1M3PoJkRCToIwY=;
        b=YgrUjWN8SpJLpdFlvaeTe/5VhjpUHz9g7lyznp1QZMrcE9z6xpI87YwfZilPaop9mk
         lKOaM7mCz4AxkcEudtvBcNquJm/MBVgQTwruRl44xUs5e1V/h6IXS+jTWzmZ17GX53RJ
         NHgpxdiQFBwynU8H6KmKABOrgEMWQqm2SNYtVLiKPWb5p/TVE2IcPF2W9UkHMFW9QdjM
         s5YzLDgnhYCwjzG4mdLPcyiHf9VbF/yQw2x9EQ5lNQgoLz+1E2xZLPXElJsnnx+WVGbg
         w/MAmC8WdyYyhiqAgp7922VnF28PC0kyydyG65WKV9ZRcH4emXtcHnZKeNGeXYHZzYKD
         BauQ==
X-Gm-Message-State: AOAM533X3Jodim/YkQN+10gWO+eb7F9WNHS19HeUu6X7ucS76p3gLWIv
        U3QeM3ZM5kvwYbknA/ByoItJo2lWPaspkVg8Qh4=
X-Google-Smtp-Source: ABdhPJwxZpJ2CTwH6ioYhpy75IbC3TNZpIrbDrR6Qn6PWXfhck8jE8uWVSd7XCzEqGdeug/sR2hFqfttl7pdbJ6unkI=
X-Received: by 2002:a05:6808:aa6:: with SMTP id r6mr2137330oij.163.1613645074516;
 Thu, 18 Feb 2021 02:44:34 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1legm5v.fsf@gitster.g>
In-Reply-To: <xmqqr1legm5v.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 18 Feb 2021 16:14:23 +0530
Message-ID: <CAPSFM5efu6MF2RzfDkw8XJ9kF79akEesdA0WFAG3n9fo9N26vQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2021, #03; Wed, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Feb 2021 at 07:44, Junio C Hamano <gitster@pobox.com> wrote:
>
> * cm/rebase-i-fixup-amend-reword (2021-02-17) 6 commits
>  - doc/git-commit: add documentation for fixup[amend|reword] options
>  - t3437: use --fixup with options to create amend! commit
>  - t7500: add tests for --fixup[amend|reword] options
>  - commit: add a reword suboption to --fixup
>  - commit: add amend suboption to --fixup to create amend! commit
>  - sequencer: export subject_length()
>  (this branch uses cm/rebase-i and cm/rebase-i-updates.)
>
>  "git commit --fixup" learns to optionally create "amend!" and
>  "reword!"  commits, that use the log message in "fixup" commit
>  as the message of the resulting commit.
>

I would like to put light on the description of the patches. I might have
misinterpreted the meaning of  _"reword!" commit_ as written above.
But I thought to explain that here both additional suboptions i.e
`amend` and `reword`
of `--fixup` introduced in the patch series creates "amend!" commit only.

Thanks and Regards,
Charvi
