Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1970BC53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 04:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjAHEgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 23:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjAHEf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 23:35:58 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853F521A0
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 20:35:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso4228551pjl.2
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 20:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUcEWEqsP8xZRc+QX2deuLIlocRQY7zr2PBv19BXFLk=;
        b=cidAAH09ujFLEpQlwWtvie3xo/wXfOv97ISnKBdKPcmJCr//lyUpf/vTLPl1N0YfjJ
         c5fs1cpnNFf7sMpB4Vb5cVueeXe0yK8uC0ZXS/ptOWPB8ftjNWTboiLdVCcOJ0KgRfM0
         aQvHDPLjyjPS3U+3/ULvYyiSmn1z57umSIAWicPFIzkxbw+WW8aIMu6RxUYWKvc0BeKC
         ycUranROHynJAk/nrOTK+MwCjT/QxHdgI+ITep8PxdpwMfHmI0VRJfJZT6jtcSwKyKiS
         +BD5PRuejkxD6Q9Wruu03nP7IRYI8HmWpUgfS0VyHmrkmTmIQpD5SJSTCtOxHyqMWW38
         sWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kUcEWEqsP8xZRc+QX2deuLIlocRQY7zr2PBv19BXFLk=;
        b=sy7Qi38dnRxXzkfy8icc+KSaeXVjENGPFZxJ2gL9GBbi3Dg1XcxGgr3InTbYiMNgBW
         d+F+My7KgwKqAZWDn0lKDpKVQ2INa6q+PsSpz9HUnIPjo+b+GIRIJ9MfDzwYbHXB79qM
         YIeeoWOJGqEvGANo0WFOUbBrEA+J4PtOGsia/b8WAAaZeJ3dEdMskGz0PMBQcMMMPi93
         OfO9OvmYzgMNYjRfSbLLN5fItYFTJUoecKHtB08TQS5d1lIBVoFQAl7OVYwtAre55j0S
         X/hOef8lVZUc/ZmhOmP3jTF+xlkWN92yxdGrrGE93GrhvIznZoy6HQdhZYRTiwPxZwWn
         nBiQ==
X-Gm-Message-State: AFqh2kq7GGRlx4YDh4jqUqvP1spr3dRmb1Gfd6wUIG5sKhVK6wOrGfqK
        kgdku+kJD11m5T898p0Q8ts=
X-Google-Smtp-Source: AMrXdXsXDXtUi6Lvzm7uN/eWb+hl8nKBLVqudWD4OIQYQTYgV2eMqKmhxYqws9GfWuAlQ8yO4lGRhw==
X-Received: by 2002:a05:6a20:4904:b0:9d:efbf:8156 with SMTP id ft4-20020a056a20490400b0009defbf8156mr79706751pzb.31.1673152550736;
        Sat, 07 Jan 2023 20:35:50 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q2-20020a63cc42000000b004788780dd8esm3029694pgi.63.2023.01.07.20.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 20:35:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     muzimuzhi Z <muzimuzhi@gmail.com>,
        Clemens Buchacher <drizzd@aon.at>
Cc:     git@vger.kernel.org
Subject: Re: Did config `branch.<name>.fetch` ever exist?
References: <CAEg0tHSLyaewkgGs0dEXfwQhKmbiO65bXZVU8t7Kn4WwJ1p0Fw@mail.gmail.com>
Date:   Sun, 08 Jan 2023 13:35:50 +0900
In-Reply-To: <CAEg0tHSLyaewkgGs0dEXfwQhKmbiO65bXZVU8t7Kn4WwJ1p0Fw@mail.gmail.com>
        (muzimuzhi Z.'s message of "Sun, 8 Jan 2023 01:34:09 +0800")
Message-ID: <xmqqfsclzlqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

muzimuzhi Z <muzimuzhi@gmail.com> writes:

> Git configuration `branch.<name>.fetch` is mentioned in the first
> `git-fetch` example [1]:
>
>> - Update the remote-tracking branches:
>>       $ git fetch origin
>>   The above command copies all branches from the remote
>>   refs/heads/ namespace and stores them to the local
>>   refs/remotes/origin/ namespace, unless the branch.<name>.fetch
>>   option is used to specify a non-default refspec.
>
> But I can't find its doc in `git-config`'s doc. Did
> `branch.<name>.fetch` ever exist?
>
> Searching in `git-config`'s doc for configs starting with `branch.` or
> ending with `.fetch`, it seems `branch.<name>.fetch` is a typo of
> `remote.<name>.fetch`.

Correct.  Care to send a patch to correct it?

Thanks.

