Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B57C433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 14:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663726108F
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 14:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhKAOeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhKAOeL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 10:34:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51529C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 07:31:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u5so29714991ljo.8
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 07:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3TadLKFQ4bfKGVK27p0TwINO+FE34pudA8n7ezz53J0=;
        b=Ipo2fnFv+S5RqYH6ZXpVHTnMEB0uFVlQl68rshTbZXTRfcYohE5KwrGj7n6mKtIafO
         8rXIU2iJCQFrtFEafXSIOUXe7Eygt/yVfbxGC1LePauSSKpTs+A0TpNshjrn9UQMJWft
         iX39Tz7F/FzFPgFiu/wk25Kfqh8fqe8KH5D+lzZBDcha5JxrsFFFNgE2KhlT8eeAobMC
         6EPG16DsFjlR2qVja/jtlRT2eHsvk12ayXgVSKbAjXUUd7ZsWrRtroeaAs9b02m2hnCD
         xol0d5nZkjuXJCt2hyyMZWsWAoVunYLtqCZPoTmtR6LCJCsCsIBPPxP5SMw1cUomhcJO
         cUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TadLKFQ4bfKGVK27p0TwINO+FE34pudA8n7ezz53J0=;
        b=wki1svZR/va/k4CLZYTUgYW0zf/c5uPHfVU0dV2Agl3O8FJBVin15DqsqQ1Gf0tBYD
         bo075BsKEkfWqfdqApRkdpqGhWBDHlyudnOtQuclrtRw5lawUMwJ5cV0uxuSN25ExaCy
         XeqZsZJerJ1JXWah78Pu2hJ7hVVsP0p+CTPE3WSKLCsCOS/cMiUcMcZLWsa4/b1gXugu
         QnZPqmErFz0GU/AV94W93NWHZ3Pfuyv+MpXODPUAnRCwKkWE4S/iEOOpSUYsnxb5e36/
         G4f2oco6getV/Q251qWjD0rhsDrFASeN971OlNi34eCz/iGkv11W9VyuNKmMvVZNpC/o
         Cc+g==
X-Gm-Message-State: AOAM532lA+cygOKnrl/t2RWAAaTeKypmfTQ5ieF2aNIRMeaDJnTK+97C
        lwsncoE0b9n+DCPc8+h8/2BIM05wauKmQ2GMUG/U8pqyWVmLDGt3
X-Google-Smtp-Source: ABdhPJzyOePlol9VgP8t0tvesQa4elDpOastEQR/FzEoJoCzbvzdES+pEt2DNc3nmOwm7n6Gv4oQoh12Xb6CHZ8Ujsw=
X-Received: by 2002:a2e:1613:: with SMTP id w19mr18796523ljd.497.1635777095682;
 Mon, 01 Nov 2021 07:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
 <YX5Zo9uV7qG73p6R@coredump.intra.peff.net> <CAE8XmWqexT89v0R+iVcjOHF+WsF1caMu+toY_gyNmJ6BU_L=ZQ@mail.gmail.com>
 <xmqqcznldobz.fsf@gitster.g> <YX9nLJZXB3rOrMru@coredump.intra.peff.net>
In-Reply-To: <YX9nLJZXB3rOrMru@coredump.intra.peff.net>
From:   Dongsheng Song <dongsheng.song@gmail.com>
Date:   Mon, 1 Nov 2021 22:31:18 +0800
Message-ID: <CAE8XmWoHpESNK9QJ3d0u0x+Q-OfJEu7117rmV9YZpQjv7JF5ZQ@mail.gmail.com>
Subject: Re: timezone related bug of git
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

Your patch looks good to me.  Here is my test result:

$ patch -p1 < x.patch
patching file cache.h
patching file date.c
patching file strbuf.c

$ make

$ ~/git-testing/bin/git --version

$ ~/git-testing/bin/git log 11990eba -1 --date=format:%s
commit 11990eba0be50d1ad0655ede4062b7130326c41f (HEAD -> trunk,
origin/trunk, origin/HEAD)
Author: rillig <rillig@NetBSD.org>
Date:   1635633678

    indent: move debugging functions to a separate section


$ ~/git-testing/bin/git cat-file -p 11990eba
tree 5d62150f5e2bafd3db76641450ca5d902302a039
parent 892557a74bd49983fac28366b772b53c9216ca73
author rillig <rillig@NetBSD.org> 1635633678 +0000
committer rillig <rillig@NetBSD.org> 1635633678 +0000

indent: move debugging functions to a separate section


PS:
Thanks Junio for clarification, Jeff's explanation is very clear,
I'm just frustrated with the limitations of the system, I greatly
appreciate Jeff's work.

Best regards,
Dongsheng Song

On Mon, Nov 1, 2021 at 12:03 PM Jeff King <peff@peff.net> wrote:
>
> On Sun, Oct 31, 2021 at 11:46:40AM -0700, Junio C Hamano wrote:
>
> > Dongsheng Song <dongsheng.song@gmail.com> writes:
> >
> > > Thank you for the clarification, it's really a disappointing answer.
> >
> > The situation may be disappointing, but I found the answer eminently
> > clear and helpful.
>
> The most disappointing thing IMHO is the lousy state of system-level
> date routines. ;)
>
> I have some patches working towards allowing timestamps before 1970, and
> the system routines are quite unreliable (both in giving insufficient
> portable interfaces, but also just doing weird things with negative
> values).
>
> > > Perhaps the manual needs to be clearer about this limitation.
> >
> > Sounds like we have a volunteer ;-)?
>
> Yeah, I'd be happy if somebody wanted to note this in the manual. But if
> anybody wants to pursue manually intercepting %s, I think the patch
> below might point them in the right direction.
>
> I won't be at all surprised if it has funny corner cases. Our
> tm_to_time_t() is pretty basic and hacky. We can't use mktime() because
> it only handles the current system timezone. OTOH, I think the tz_offset
> we're undoing here originally came from comparing mktime() versus
> tm_to_time_t() via local_time_tzoffset(), so it could be cancelling out
> any bugs exactly. :)
>
> So maybe the code below is sufficient, but we'd probably at least want
> some tests on top. Maybe something somebody interested would like to
> pick up and run with?
>
> ---
> diff --git a/cache.h b/cache.h
> index eba12487b9..aa6f380d10 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1588,6 +1588,7 @@ timestamp_t approxidate_careful(const char *, int *);
>  timestamp_t approxidate_relative(const char *date);
>  void parse_date_format(const char *format, struct date_mode *mode);
>  int date_overflows(timestamp_t date);
> +time_t tm_to_time_t(const struct tm *tm);
>
>  #define IDENT_STRICT          1
>  #define IDENT_NO_DATE         2
> diff --git a/date.c b/date.c
> index c55ea47e96..84bb4451c1 100644
> --- a/date.c
> +++ b/date.c
> @@ -9,7 +9,7 @@
>  /*
>   * This is like mktime, but without normalization of tm_wday and tm_yday.
>   */
> -static time_t tm_to_time_t(const struct tm *tm)
> +time_t tm_to_time_t(const struct tm *tm)
>  {
>         static const int mdays[] = {
>             0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
> diff --git a/strbuf.c b/strbuf.c
> index b22e981655..8b8b1900bc 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1019,6 +1019,13 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
>                         strbuf_addstr(&munged_fmt, "%%");
>                         fmt++;
>                         break;
> +               case 's':
> +                       strbuf_addf(&munged_fmt, "%"PRItime,
> +                                   tm_to_time_t(tm) -
> +                                   3600 * (tz_offset / 100) -
> +                                   60 * (tz_offset % 100));
> +                       fmt++;
> +                       break;
>                 case 'z':
>                         strbuf_addf(&munged_fmt, "%+05d", tz_offset);
>                         fmt++;
