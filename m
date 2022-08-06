Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F47C3F6B0
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 19:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiHFTRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 15:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiHFTRt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 15:17:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A070ED130
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 12:17:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gb36so10140899ejc.10
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BRRloT7h2h1aYxTZdIPA8UOu2MFYaDRRf/b7PCUoGMY=;
        b=hW0tpbNwDO3gOsFIfIgYlXuPGyO/oVW11LJSzMqtNnpm/zoMdAeR0sg2l+MuhXF6CF
         TWUBOycAm8MeXrROZlsGFuEyI+s0SgADj2+PK5E9iG3YdyqgwMJ22LyyFzbCgQ9H4FAZ
         73nrQefd0XnWkf8UjGHCFN/Uh9+5RWzH2WfQv3AJWg9ykuCez7E3oq6iYjlBRjC3ENo8
         XiVLLVVDWmq2Ovou68i0cxbtDHc9HXUw2M+gwYiFII8YRoIbvToJGXQ3Bu2LjHCRFP0Y
         Kd0SXtFPgiw8RAFHLbMqRYwPShMMp5QceK3JUtQIuDbSsiwl2zD1rW0/5sXp1J+eRu4U
         akCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BRRloT7h2h1aYxTZdIPA8UOu2MFYaDRRf/b7PCUoGMY=;
        b=qCeRlDQBYn9xk9O1Dcsgi3ZbbaMTQFVGg0Q3GOUp42yOWrnHMASnX/V3ChyN3/h1dQ
         8dGlGLRrPqEtzZuUd4CPFIZlXlWzWTcs6GbAlnrMMTTp4LoZSZhUkhPY/slqxKtRBX5t
         0t3iVQ4yXcEMPhPlux8Bu561dKDy8n6v2qVrwc/KyioDn91fz6+9BoC3RODSS+lrOFG3
         CQ78N9KyTMKU3EJ0Ta1tMNLDb6ZYJRcYa9KkH/7PkeaXE1mTatwGN37r60MobywkUYHD
         ZmZ3YP3pLUYqUw58aDnzKQJ9m5xWJodX9bQnGkfwQHnibv3IYFFM/qbhcwFpF6SKYTXS
         idSg==
X-Gm-Message-State: ACgBeo2ZtZwTJX18OOBoT6HQ9MLMOqW5KXMXCEgtiHZnR/7rt39Dd63E
        WUiOp0AqXPkhY/XSavTeLJPHFoTffGkeBkbfQctI00wpRLU=
X-Google-Smtp-Source: AA6agR7oQu9TZ55dE2BUWMZSx4pFW8Fq7C/P0LR5Tzx++cY4maCwOcuSzFA3tMeHayAGO6zcw86Xhe0Uh7XF4G53EQA=
X-Received: by 2002:a17:907:2c62:b0:730:d9b9:aabb with SMTP id
 ib2-20020a1709072c6200b00730d9b9aabbmr8269851ejc.84.1659813467167; Sat, 06
 Aug 2022 12:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220802214134.681300-1-felipe.contreras@gmail.com>
 <Yu6V4cIajhoMhB3t@zacax395.localdomain> <CAMP44s1uPFGYVJ7dzf1pFXENnUjTTwxHye2iT_HPNiMcmPjD9A@mail.gmail.com>
 <Yu6zEiknXKFMJUVn@zacax395.localdomain>
In-Reply-To: <Yu6zEiknXKFMJUVn@zacax395.localdomain>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 6 Aug 2022 14:17:36 -0500
Message-ID: <CAMP44s3-RG5k4ZkhAFG_9JtbxcyDhkUmeBh0jCH9+Xwyumyu9w@mail.gmail.com>
Subject: Re: [PATCH 0/2] mergetools: vimdiff3: fix regression
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 6, 2022 at 1:29 PM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> On 22/08/06 12:53PM, Felipe Contreras wrote:
> > Two observations though.
> >
> > 1. The "silent 4b" is ignored, since bufdo makes the last buffer the
> > current buffer, so if you want a different buffer you have to make the
> > switch *after* bufdo.
> >
>
> Yes, you are right. For the particular case where there are no windows (only
> hidden buffers) it does not have any effect. It's presence there comes from
> the fact that the command generation function works in the most "generic" way
> (ie. producing output that works for all cases: windows, tabs and buffers).
>
> In order not to have another special case in the generation logic I left it
> there, but you are right in that it is not needed (fortunately it also doesn't
> make any harm :)

That's not my point. vimdiff3 is essentially the same as vimdiff with:

    git config --global mergetool.vimdiff.layout MERGED

But the code is written in such a way as to allow:

    git config --global mergetool.vimdiff.layout LOCAL

I don't know why anyone would want to do that, but the code interprets
that as the user wanting '1b', which is completely ignored.

If we are not going to care about these cases, we can just remove all this code:

--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -254,30 +254,7 @@ gen_cmd_aux () {

        # Step 4:
        #
-       # If we reach this point, it means there are no separators and we just
-       # need to print the command to display the specified buffer
-
-       target=$(substring "$LAYOUT" "$start" "$(( end - start ))" |
sed 's:[ @();|-]::g')
-
-       if test "$target" = "LOCAL"
-       then
-               CMD="$CMD | 1b"
-
-       elif test "$target" = "BASE"
-       then
-               CMD="$CMD | 2b"
-
-       elif test "$target" = "REMOTE"
-       then
-               CMD="$CMD | 3b"
-
-       elif test "$target" = "MERGED"
-       then
-               CMD="$CMD | 4b"
-
-       else
-               CMD="$CMD | ERROR: >$target<"
-       fi
+       # If we reach this point, it means there are no separators.

        echo "$CMD"
        return

> > I don't see the need for all this complexity for this simple mode, but
> > anything that actually works is fine by me.
>
> ...in fact, back in May I just wanted to add a new "vimdiff4" mode and what
> originally was a 5 lines patch became the current 1000+ lines patch monster
> after all the (very welcomed, I'm not complaining!) suggestions :)

I understand the need if you want a complex layout, like
"MERGED+LOCAL,BASE,REMOTE", that's very nice, but if you just want
"MERGED", most of the code does nothing, the extra -c "tabfirst" isn't
needed either.

Either way, adding the silent stuff and "set hidden" make vimdiff3
work, which is all I care about.

Cheers.

-- 
Felipe Contreras
