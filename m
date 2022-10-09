Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F2FC433FE
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 06:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiJIGqz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 9 Oct 2022 02:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJIGqm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 02:46:42 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00F812A8D
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 23:46:41 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id d142so478515iof.7
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 23:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH7x+kxILmlEcACkSi+bKfSlivBIF+LVp3RJz0lBSvE=;
        b=2sUcHlQL0DCVDy/rozLl/8AReMtRxMsvauHtBGEsBHWWuHXVBI1VavRPypCD6maMWX
         Owc2qYF4QxgftPKlvhPdKaT4DEqvhEb8whqNwa9Kdt0sMUkCYe5qbXebfhQMlW4C6vYj
         V/qEo+zOtLSXlmBBUi6zcp66akcRBMrbUIHxfvTRjTXlOnjczFT5/TGw+mGyYyHTYx8Y
         hy0ewv5dMUKWuIoxy3/Q72b8On1yNeKvVdJA0QcBGopixJ5yErHJzz7+0YcHokzVfi1y
         JM38+SmBsR0OyKCmGUa+rR8Bw71yK7Kxzzu7LweyjczDMTrBTPqlhwDjNH0PNJgyj2RJ
         YjVQ==
X-Gm-Message-State: ACrzQf3mhrI4Raz7RCoclYcDs1koaWIkfyGRUkeEAKECONOBWKXnSn9G
        JxLGwDdNixLrNf088ruSZ62zAfLdU1RV5hNuOcY=
X-Google-Smtp-Source: AMsMyM4MO8lNWngPNkjQ2UwGgFixmE/quwIgeIHYTVBUVFQAELUlE8u8PM6dgqERMnypmc/XIV+/FQzyRXt8ljZe+bQ=
X-Received: by 2002:a05:6602:2f02:b0:6a4:5b5d:9dbb with SMTP id
 q2-20020a0566022f0200b006a45b5d9dbbmr5732812iow.32.1665298001001; Sat, 08 Oct
 2022 23:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com> <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com> <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
 <f24837e9-7873-c34c-bd78-8ae3be0fc97a@gmail.com> <CAPig+cSn29Fq4ywC9zXoJYRVG8KUEhHuDdwEUSioFMUVs+S-ow@mail.gmail.com>
 <a7aca891-dd37-7e5e-61fc-8012fec18ae9@gmail.com> <CAPig+cRxy5C+CqUOzmhe16j+hssxsygha3huVga8tLJ+imM4Hw@mail.gmail.com>
 <32e4f8cf-696c-317d-236b-0f64c1398a01@gmail.com>
In-Reply-To: <32e4f8cf-696c-317d-236b-0f64c1398a01@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 9 Oct 2022 02:46:30 -0400
Message-ID: <CAPig+cSdQsK7xVBb=ooOfP-hq1zavSV++iorLoni6o6etoLjzQ@mail.gmail.com>
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
To:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 8, 2022 at 7:28 PM Rubén Justo <rjusto@gmail.com> wrote:
> On 8/10/22 19:10, Eric Sunshine wrote:
> > However, `test_cmp` gives you that behavior for free, and it emits a
> > helpful "diff" upon failure, so these days we usually go with
> > `test_cmp`.
>
> I understand the possibility of losing exit codes or segfaults in
> subcommands or pipes, but I'm more thinking in the element to compare to.
> Having something like:
>
>         test_cmp_str () {
>                 test -f "$1" || BUG "first argument must be a file"
>                 if test "$#" -gt 1
>                 then
>                         local F=$1
>                         shift
>                         printf "$@" | eval "$GIT_TEST_CMP" '"$F"' -
>                 else
>                         eval "$GIT_TEST_CMP" '"$1"' -
>                 fi
>         }
>
> to allow writing simpler tests like:
>
> +       test_cmp_str actual "Branch description\n\n"
>
> +       test_cmp_str actual <<-\EOF
> +       Branch description
> +
> +       EOF
>
> My doubts are that maybe this can induce to some bad usages, is
> unusable in some systems, it has already been explored and discarded,
> using files gives the diff with nice names not "-",...

I wouldn't be at all surprised if this sort of thing has been
discussed already (it sounds familiar enough), or that such an
improvement has already been submitted in the form of a patch
(possibly by Ævar, Cc:'d).

My knee-jerk reaction is that the form which takes a string as
argument would hardly be used, thus an unnecessary complication. The
form which accepts stdin could even be retrofitted onto the existing
test_cmp, thus you don't even need to invent a new function name. A
different approach would be to introduce a function `test_stdout`
which both accepts a command to run, as well as the "expected" text on
stdin with which to compare the output of the command; i.e. a
combination of the existing `test_stdout_line_count` in
t/test-lib-functions.sh and your proposed function above.

That said, I'm not yet seeing all that much added value in such a
function; at most, it seems to save only a single line of code, and
it's not as if the code it's replacing was doing anything complicated
or hard to grok. So, I'm pretty ambivalent about it. But, of course,
I'm only one person expressing a knee-jerk reaction. Submitting the
idea as an RFC patch might generate more feedback.
