Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF89C433E6
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 14:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E693A64D99
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 14:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbhCAOJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 09:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbhCAOIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 09:08:49 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A350C061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 06:08:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lr13so28393938ejb.8
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 06:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=uaJSb1mJKmpoBFDWS+HAoVTomjyG3cV14Mp5g27DROo=;
        b=DcIfSdZ0mayVMUuSDK9LEMcFQsPF+hB2y+hwVxkRxfE489EtR2BLIemexkg5gQjzWn
         LucX+cnaGzClDjCiJmM5amgFRi7VxrWPDWgwhyjf+FCO7jDzaKhbeEuJpxRm8DM2QqWp
         4pLpg4OUBbzd5yR/52iy1vFdR7RjYas7BKhWzDBh4x8YjYXPlzXkvVB31vnFHvTiL9PW
         Tl3p7T2zrjEiqjt8ql7U44zfar6bJ/CDWexhSuJ8gROPJsC+vbC1vPo372BEOrmuFB8/
         PtePkMdKXfnIUZKxf/xftbzTtresfmmP7jg6GZZdje47ifcSeH06ZtjkLyD6KSR1YCOk
         EoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=uaJSb1mJKmpoBFDWS+HAoVTomjyG3cV14Mp5g27DROo=;
        b=bStLtQ3hkPpJqdi/Q/LIcFFxW23qS4SscplOx0q0uhTVDv/yyuZ/yRj8rYHV8OBbIP
         7Omb8FEeKj+yKrYHCZbhAPPeZh4tTKc1CMHFT9ohRBMg5rPLSpZbpQAWX4E8Uzss481y
         jjVSHOxPglnC8nN6xKnmV8tJybP+JDMcskVSjBrSm1trqV66k/JlsasmqpdXHJO5YEMR
         k39HwBeDbP3T0fXOAvGW4UQltAnUqtQa8DRGoPTDJZzsEZVMsBB3ZFI4ZWQzpqzHD+ot
         /O0BXMtGvQLjcDn3j5HLyoX4iAcY3LvCDOiWFi8uYUY42PJFYKogg9i3w9+U9qxCeyZ6
         G59A==
X-Gm-Message-State: AOAM532pXMLc0rvd7H0I0J6UB1uf1tUFeIKDjuL/wUL5HAO6tB25I9tz
        e1Jmj3+mc64d+jzIcoLnHzQ=
X-Google-Smtp-Source: ABdhPJxl/sjkLu6dIITgQvOvSZmL0v7J5cDuWA2JLnVg0s/wN5keEO6Zb3LcQdy08WehE5F+IFfcIA==
X-Received: by 2002:a17:906:b159:: with SMTP id bt25mr16063891ejb.364.1614607687367;
        Mon, 01 Mar 2021 06:08:07 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i4sm13275783eje.90.2021.03.01.06.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:08:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stef Bon <stefbon@gmail.com>
Cc:     Ori Bernstein <ori@eigenstate.org>, git@vger.kernel.org
Subject: Re: FUSE fs for git.
References: <CANXojcx0TOP9SSr1NgXCddQ3PWze-wBLZA5SRO3YhczqO68u0Q@mail.gmail.com>
 <20210224204007.4937ee80121aa1ed553a2d91@eigenstate.org>
 <CANXojczH=r-mugP-zJgrATG5XQUqmoqfY3zUTiZTUDDhx59oJg@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CANXojczH=r-mugP-zJgrATG5XQUqmoqfY3zUTiZTUDDhx59oJg@mail.gmail.com>
Date:   Mon, 01 Mar 2021 15:08:06 +0100
Message-ID: <87o8g3j7ax.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 01 2021, Stef Bon wrote:

> Thanks a lot Ori.
>
> Especially the link to libgit2 and your own 9p based git filesystem I
> appreciate.
> What is 9p? Is it a name or something?

https://en.wikipedia.org/wiki/Plan_9_from_Bell_Labs
