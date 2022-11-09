Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CAEC433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 21:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiKIVVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 16:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiKIVVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 16:21:09 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F346C31DCC
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 13:21:08 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 63so14985183iov.8
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 13:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zZlHBDtnXc2w8RjcVyDIbfI9BEuMa+muKMybrfxRK3k=;
        b=iUweRCkm5ysFSoEPzu8qOYz4aoW99W2n9qR9ZxLob5FiIAW/sATGXyk9eFmyCoaeZ9
         Z0V8jwpwl0sJoasCLPNtWKBksJ3U7bh9PqnfnF2u+F33lOYVogl74FJK+TYsVgntxs8s
         EaNVoADoOJuGduopr6/I51yY6VfvEBYaASH0k3BhF8zf2qf2mspUcPYwGPiqW0EkU0cl
         kIlpH3FGDrWZuqWtFiIAJjWfj0MAjXfrxbVLdFyBpGR6yQp2gVCEq8eG3c2sVinSlRP9
         4gXfAhm1OSfz2GYWTdywyyoy3Zhr/6Ybm4qp5i0KnanIoBLFLvEVPYUDJIDsbk8Nb8mo
         MVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZlHBDtnXc2w8RjcVyDIbfI9BEuMa+muKMybrfxRK3k=;
        b=QVYrOoCieKMQhX5t1Cw9HufqH9BaOukQ03L7ET3HogmrlnwZvwRpntdBqONiOPmDnh
         8V3zyH98TuwaABYDkPfwMNu4FYwk8RvUsTF102sl98kb6lRPwvUAGcAuqfhJPekLeZ1V
         n8LnJY/qp4ueGfOkv+MDt7sJmurtR8n1ESgS7RV+OLDrABfjRx5BUpyrLQTPq+3K6DJo
         GUnWrAF7PuTfAHsl1BXKJtIqPhYKhtOk7fgjZX7obK1bOp91RnFp5sojFORQmooehZxy
         8ExMDeC7f201EogwxbaO7AvsIQ2QjGQyzZwffJAtXjNEporyXwJmqM2PylTSuupTZudJ
         6HQQ==
X-Gm-Message-State: ANoB5pmpG02Jok7iX+TO2TNFIvmpPiubrscLpJZ8v7+dwv2ohRZXGd9W
        EBYbYjI9SOwrjJ4LFRa3rjdD7Q==
X-Google-Smtp-Source: AA0mqf7ajRerKrYbNQq8hPneyFAVeisf/055LvuS54aw35Y8ytXm6/rQ7maFKdthtAe/TkIiX0OTSw==
X-Received: by 2002:a5e:9413:0:b0:6bc:6352:9853 with SMTP id q19-20020a5e9413000000b006bc63529853mr924796ioj.65.1668028868304;
        Wed, 09 Nov 2022 13:21:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m21-20020a0566022e9500b006d276f4e01csm5895137iow.20.2022.11.09.13.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:21:07 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:21:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
Message-ID: <Y2wZw3eYO4ykwtA8@nand.local>
References: <20221109004708.97668-1-chooglen@google.com>
 <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 08:34:28PM +0100, Ævar Arnfjörð Bjarmason wrote:
> An RFC alternative to Glen's [1], and what I *thought* he might be be
> going for in the earlier discussion[2].

I am a little puzzled with what to do with this series. For one, it
doesn't seem to apply cleanly on top of 'ab/remove--super-prefix':

    $ git log --oneline -1
    04e36effde (HEAD -> ab/remove--super-prefix) Merge branch 'ab/submodule-helper-prep-only' into ab/remove--super-prefix

    $ git am -sc3 ~/patch
    Applying: submodule--helper: don't use global --super-prefix in "absorbgitdirs"
    error: sha1 information is lacking or useless (submodule.c).
    error: could not build fake ancestor
    Patch failed at 0001 submodule--helper: don't use global --super-prefix in "absorbgitdirs"
    hint: Use 'git am --show-current-patch=diff' to see the failed patch
    When you have resolved this problem, run "git am --continue".
    If you prefer to skip this patch, run "git am --skip" instead.
    To restore the original branch and stop patching, run "git am --abort".

But it would be nice to have a clearer path forward between this and
Glen's series. I understand that they are both still RFCs, but I am
counting on you two working together to find a path forward that is
satisfactory to you both.

In the meantime, it would be nice to have a version of this series that
I can apply to start playing around with.

Thanks,
Taylor
