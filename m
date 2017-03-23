Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F378220958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754301AbdCWTbV (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:31:21 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33502 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbdCWTbU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:31:20 -0400
Received: by mail-pg0-f46.google.com with SMTP id w20so26059077pgc.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pZVNj6MqPH+1Ztk2YNf206ZrpZBYVxB9Yoq2k5qyomg=;
        b=pEsyztHRUUbtCm05EBpEYa4B3sduPFjGYkDHWC1vRmgmUzzrohcMZCGCYY+a7cHjji
         jQTaxHWtny3S0JjEs7by10EokziQ1OnS+cXTzRsjoy27Q7DGgdebRSBXUZvWFzGtcU0B
         BZsglWjz4mlJ2OzW8x9s8ph9/dGd0d9jN0O/bI+TCHoN+HlT4aoYps3KR8W81KsIPXCV
         dwpb4h4rZqSY46/oOf+log51bmZazcgecXcNo/BlCcOxT5A+r3+4BKBzv4eyTl01Ikp1
         S7lCcJGa2H+l5y2gbY7lZbykv9ecM05qyG5fndUkqswAWGqpui7Djo2pJ3DUss3pZPTo
         4t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pZVNj6MqPH+1Ztk2YNf206ZrpZBYVxB9Yoq2k5qyomg=;
        b=Zwy22d4ia1S/VGsHFFz+zrs/UVs+NEjVVOPgUhPXq6hlWm3iAb/J1DWbmV8oaAGGGJ
         4UJgm4jAnN3v3NkaDtoQYdlBwqph8Kb0clq0HRsmN9CFnOYMgUtwdgcI7s5K40DDP4sS
         r6rymqCRUT1nSMtLrwHQEA3MgnCRlQtOp+66ReqV3kpIAERr9zzG2DOj41EUwQKdYFG1
         rsvq1an8DoVdwCBEPz0U9JYlR3u9ePC0fq/r96lgsqfgbGFW75eZLbhGRG+Wm0K7uFG9
         aFDoH4DLReOH+7eAr8qZRS1K2wjwtnYGE09h+lByldU3ynUdMqawp1RkCOjOC6yOJBZE
         nM6w==
X-Gm-Message-State: AFeK/H2EbSqUqE9khzYHd7jp0eaedSU3KSZTEr5tdPJHXdDl7Im0Hlg4LC43wOfSMSGc2a2OL8LsjXsvhWaF36v+
X-Received: by 10.84.231.135 with SMTP id g7mr5757803plk.12.1490297479263;
 Thu, 23 Mar 2017 12:31:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Thu, 23 Mar 2017 12:31:18 -0700 (PDT)
In-Reply-To: <20170323192313.ytr56pjpnillnh63@sigill.intra.peff.net>
References: <20170323155012.6148-1-szeder.dev@gmail.com> <4382e211-63f6-811f-6f33-1cf5d2c087a8@web.de>
 <20170323192313.ytr56pjpnillnh63@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Mar 2017 12:31:18 -0700
Message-ID: <CAGZ79kZ-yP=6bKnDg8zKjebDkDdQ4ZEur0sC+CCcv5OTdEC3RA@mail.gmail.com>
Subject: Re: [PATCH] refs.c: use skip_prefix() in prettify_refname()
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 12:23 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 23, 2017 at 08:18:26PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> Am 23.03.2017 um 16:50 schrieb SZEDER G=C3=A1bor:
>> > This eliminates three magic numbers.
>> >
>> > Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> > ---
>> >  refs.c | 10 +++++-----
>> >  1 file changed, 5 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/refs.c b/refs.c
>> > index e7606716d..0272e332c 100644
>> > --- a/refs.c
>> > +++ b/refs.c
>> > @@ -366,11 +366,11 @@ int for_each_glob_ref(each_ref_fn fn, const char=
 *pattern, void *cb_data)
>> >
>> >  const char *prettify_refname(const char *name)
>> >  {
>> > -   return name + (
>> > -           starts_with(name, "refs/heads/") ? 11 :
>> > -           starts_with(name, "refs/tags/") ? 10 :
>> > -           starts_with(name, "refs/remotes/") ? 13 :
>> > -           0);
>> > +   if (skip_prefix(name, "refs/heads/", &name) ||
>> > +       skip_prefix(name, "refs/tags/", &name) ||
>> > +       skip_prefix(name, "refs/remotes/", &name))
>> > +           ; /* nothing */
>> > +   return name;
>>
>> Nice, but why add the "if" when it's doing nothing?
>
> It's short-circuiting in the conditional.

You do not need a conditional to short circuit things.
|| works outside an if, too. ;)

Anyway, maybe it's worth spelling it out with an if .. else if
cascade for readability?

After your comment of short-circuiting this code is pretty clear,
so maybe just a small comment would do?

Thanks,
Stefan

>
> -Peff
