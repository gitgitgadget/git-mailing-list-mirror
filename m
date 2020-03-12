Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208DAC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2410206E2
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1V+rjtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCLT37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:29:59 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43933 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCLT36 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 15:29:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id p125so6718644oif.10
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQAnlU7ew4ToZ2m+fwY2CiO1K5S/P+QKuSFwJKlmnWI=;
        b=F1V+rjtSlpd1X3ONvo4ALCf1qgSIsoUleVhWQnvc6xDlFz4TzN20YxkfEI+1vWE/3n
         zZc9DE/AHxLryfd5z09pzkA4z5ARwnlX/RfiumzPIl2kg16ajN3chlxibm2osZ9fENVf
         wUBKQIWyclATNzVpfuiOc67LYjrsoxiUVBW9VFNNgSKL/GZlwfQ+j+LIeeua68lw6Qto
         I+ywfbpKUtC5UbaEuz8Ax7/cmzS/lzLUuH0HKlAJXcidtZy0hUnielsj5GtprUUUGawG
         89m5cp8i0eeSgLD5XwGqClx6JH3ZO2ZUXHDEj4aaIzXASMLDQUmQIxl2LMnL8qlNghdI
         6Wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQAnlU7ew4ToZ2m+fwY2CiO1K5S/P+QKuSFwJKlmnWI=;
        b=kPo9BtQzqkxoiKxk8hhDQaBpEb7kYO9PtZnhBfJFsEroEMlFfdHR1XiiJBqCvgfvnr
         yiVozGWizgTq/+akQV88yy4QFLl0Y1b/USsWFLLrN40b9Xue3lBdr0X5tJ/0kyZ3dm0g
         uMkCpXXuhmxgB+8lcmLwV4C2qoeSDRjie8QEV9hPZebwNR7R5crTJ7SP8EwuUpOnk0Dj
         0h7TBbtXLaHItjTUjXEtzhGRFV5w7okOLumpiYRfZm/F/AgLDAclvHfy0BSzptWw2J5k
         X+SVbGPplmZ5hfx2YaiUn9E7wSdwOxwKR/sSGvAd2vr11okb/Kb7MOAdauqR8hsAe8vS
         KJSQ==
X-Gm-Message-State: ANhLgQ0EGpKwUUNiSP57dnrT86+2gkEPNwfXGpo5G2egnNFod0J42X72
        BOSpMtT5vvidDDugDoG1ME2XDiMer6N0jLrTSN8=
X-Google-Smtp-Source: ADFU+vsqy/nb3w6d0WogiWij8Gm+ZqkGCY32Z7PlPlXcrm42kMcVzcteOS3Jz2GqOs3L7Ta5DXEs1udgY0v3Asd2YWE=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr4031243oig.39.1584041396158;
 Thu, 12 Mar 2020 12:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com> <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
 <20200312151318.GM212281@google.com> <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
 <xmqqftedfkvy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqftedfkvy.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Mar 2020 12:29:45 -0700
Message-ID: <CABPp-BGvqUEDoj6_mUAsSVeS8+h5ruCFcMTENtf5LY2XWKVj-g@mail.gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 12:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Thu, Mar 12, 2020 at 8:13 AM Emily Shaffer <emilyshaffer@google.com> wrote:
> >> ...
> >> This broke quite a few upstream users for us today...
>
> One more thing I've been wondering was if we should really have said
> "ok, the two known gotchas have been dealt with, so let's ship it".
> It is quite likely that users may be hit by remaining differences
> between the merge and apply backends that we assume to be merely
> subtle and easy-to-work-around ones, and it may be prudent to use
> the "let's not change the default just yet, but ask people to test
> it in their workflow by advertising the configuration" patch.

Good question, but there's several things to unpack here...

First, note that this particular breakage would have occurred
regardless of the default setting, because the problem was that they
setting rebase.backend to an unrecognized value, not that we used a
different backend than they were used to.

Second, for the particular case of the post-commit hook that they
referenced in their rationale, that item was documented near the end
of the 2.25 cycle and mentioned in previous patchsets[1, 2] so I
figured this case was already considered.

Those two points may obscure the issue, though; your question is still
valid.  I think the bigger question is whether there are other unknown
differences, or even known differences that are a bigger issue than we
currently realize.  That's hard to judge, and it may not be possible
to judge until we've flipped the default.  As such, it's a judgement
call.  I can see the judgement call going either way.  A couple things
to weigh in on how to go:
   - Making rebase.backend default to 'apply' for 2.26 is certainly
the conservative option and may give us more feedback and time to iron
out differences
   - We had multiple complaints this cycle about rebase.backend=apply
merging things incorrectly with the only workaround being to use the
merge backend[3,4]
   - The rebase-backend topic wasn't merged down to master until less
than a week before -rc0.  (For a variety of reasons.)  A big change
like this probably would have been better to merge down earlier in
some cycle.

To be honest, if I was maintainer, I'm not sure which direction I'd
pick.  If you feel safer switching the default backend to apply for
this cycle and then (re-)revert it early next cycle to the merge
backend, I think that's totally reasonable.


[1] https://lore.kernel.org/git/pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/CABPp-BHONuRyt8VJqRuoCF2rGYZ5EhH9KJXQZ3NO69rYwA5J3g@mail.gmail.com/
[3] https://lore.kernel.org/git/CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com/
[4] https://lore.kernel.org/git/20200108223557.GE32750@szeder.dev/
