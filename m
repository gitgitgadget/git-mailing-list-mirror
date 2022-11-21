Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E6DC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 04:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKUEFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 23:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUEFo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 23:05:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1BA2DA9E
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 20:05:44 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u6-20020a17090a5e4600b0021881a8d264so7837176pji.4
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 20:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LdgAypeeHfnmmZwtycqtiIHypm+BoVCvOQD/0qgDehE=;
        b=hek3Fu3UXgKlCijl/xEQjNkoq2lrWaLD+vmpfcovcdEWtQp256BSSu/aYZu/7m1eXG
         E8bLdt/QcGnZXSdkQ2ndo1+0oGB93CoRyTwDJH8ntc6GjeKl9j/CeSYQWWDakjPvPqBE
         96fqjgknPzc2toBdj/EkrmBJS850fwLfZumX8swht7gKtny8AKpzOeQP3Pn0pMEkM+cz
         LsUrgg4IgW5sYoZcuLIRu9gDEqoXenSmvbFpS9cdhk5VOchH5RzZpuSXpi5hK7n0ND70
         dGJ1PzdeiAX160Hl+5727CX/yAs5Pw1X7q6Fucj8U8JdSQLxtnnf+3xqPshgtlSQqykD
         oljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdgAypeeHfnmmZwtycqtiIHypm+BoVCvOQD/0qgDehE=;
        b=QEL4oa8/GiGYpBTyznl9g0d8fnE9BaNeoaAnCRG0QJwVhX+tnudMyNNIp2C632/iC7
         ZaaeS02JItKxEE7WVppWCgVJb2ondp20cinQFYhoAHy8Amt+2imGtVmiWyKOS/PnE5kj
         UeDpzmvjCNQekCpGhzCdwxGY6wDLOgou7jvyreeeCGpf/Q92Xmp/ANAbOb3pe1Tn/mOx
         sRS3mBld/lmEOpYa9AMBvh/s8RWTjdFgVTweKmf+Yyl5+COpUxFilNEx4hl53KWiwKSL
         vBzuvhL/29Ct5DMJPD9nmTGGa6SLBzBeYBbEA9ReCY3wl3CyZ6txXcbDptMGM/pykfJ2
         3qRw==
X-Gm-Message-State: ANoB5pmr8Yb/LmL8aJVdkB3R9HzAqF1onvsRIKDM1tlvsI2zBrPjyVoK
        jyNiyMF/kSYwxnIttxOo0ICUKmxjkmzncTiQamzV0PLuu6Y=
X-Google-Smtp-Source: AA0mqf5Sy1f36CxMoUyaxz+wUvFKkVLlLt1+lxd9WAy5CiccvdXgEuXvmrXqUSF+rWXBZXXOfa633vgou6ABQHwuJnw=
X-Received: by 2002:a17:90a:bd86:b0:213:8cf1:4d9d with SMTP id
 z6-20020a17090abd8600b002138cf14d9dmr18989929pjr.5.1669003543495; Sun, 20 Nov
 2022 20:05:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
 <ed19668db860c8aafcb008aef306520e36d12dee.1668866540.git.gitgitgadget@gmail.com>
 <CAPig+cSMoAoVW_NTidyN0rgTTY-FaQ49CAFQZhPyaYBsYu-RfA@mail.gmail.com>
 <CAF5D8-ujg3Tp2s2+eGMgZfXXcZEyRKreAj=EkG0KiMniKjoKBQ@mail.gmail.com> <CAPig+cR6+H2gqZbnj9FHzZRefwTjYme94kNeQ9qmVi-wLYZ6fw@mail.gmail.com>
In-Reply-To: <CAPig+cR6+H2gqZbnj9FHzZRefwTjYme94kNeQ9qmVi-wLYZ6fw@mail.gmail.com>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Mon, 21 Nov 2022 13:05:32 +0900
Message-ID: <CAF5D8-uYU3WdDW1GY=G9hcRkKx73Ha6dwdMQ19XcQS8630+mWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-jump: invoke emacsclient
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Also, on macOS, I need to set EDITOR (or GIT_EDITOR or VISUAL) to the
> > full path of emacsclient, but the regex used here is too tight to
> > recognize that. Perhaps loosening it to just 'emacsclient' would be a
> > good idea (as it seems unlikely to falsely match any other editor)?
>
> It is a good idea. Thanks!

I found we can support both emacs and emacsclient by using --eval
option instead of -e option.
I'll deal with it.

On Sun, Nov 20, 2022 at 8:59 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sat, Nov 19, 2022 at 6:44 PM Yoichi Nakayama
> <yoichi.nakayama@gmail.com> wrote:
> > On Sun, Nov 20, 2022 at 12:53 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > Would it make sense to expand this to support the VISUAL and EDITOR
> > > environment variables too? For instance, since I want to use Emacs for
> > > all my editing needs, I have EDITOR set to reference emacsclient. So,
> > > if GIT_EDITOR is unset, then check VISUAL, and if that is unset, check
> > > EDITOR.
> >
> > "git var GIT_EDITOR" does respect VISUAL and EDITOR environment variables.
> > See git-var(1) reference manual.
>
> Excellent.
>
> > > Also, on macOS, I need to set EDITOR (or GIT_EDITOR or VISUAL) to the
> > > full path of emacsclient, but the regex used here is too tight to
> > > recognize that. Perhaps loosening it to just 'emacsclient' would be a
> > > good idea (as it seems unlikely to falsely match any other editor)?
> >
> > It is a good idea. Thanks!
>
> Thanks.



-- 
Yoichi NAKAYAMA
