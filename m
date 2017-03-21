Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4CE720323
	for <e@80x24.org>; Tue, 21 Mar 2017 10:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932373AbdCUK0t (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 06:26:49 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:36009 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932333AbdCUK0s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 06:26:48 -0400
Received: by mail-ot0-f180.google.com with SMTP id i1so148987054ota.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=pnrWsE09FBzyMCctbZpCGDfuErI+8P3nQCWkrK8+Z18=;
        b=UwJQih+NrknExvVumBsRdR/tzwASgJsSxYfmKlttJnARV0/WcSr/hHPpbMcA+jGAHm
         WD/LeMmjfB7Xb2fgg1aZLHLeOrp9S6DjIHWKWIq4/5iJDNhh01PnPaydCdOus4c7fGO7
         eJh573Hl2t1c3443f7MAQ1f8GKZ6PPEaL+3GMtC3isl4zScKeakjRwzDGvum4iDw0JPC
         cqnQWLm0HOo93Obq9p45TijHcEcSY+sEc6ozJ0uJQoOp90PimeCu48/euWWMQXrSAiAG
         vpjq/YnA6BiMvTCA4yQHni9LEjf+0eL9H3CVQqisWM4XfAF+nyabs3hOjOA2pyxxdGKI
         K81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=pnrWsE09FBzyMCctbZpCGDfuErI+8P3nQCWkrK8+Z18=;
        b=K96uGWic2sfoTN5drLwCbkclKhIuDdBvLZh/pWjbJ3grJeu3/8JpSMAgDcFLeqDpi+
         504MA4P4OoQZwEF5XP+5+wcRGlBKnYCeZbUErhMEjDmiBYW++5WRfxJtkCxAeOJIgpDS
         P+FardJOl0Gj2y3Y0rS4GajLq92EYCV+6Dt2XxYhXAviXSyUSeaWh/P/FCHydUywcBLF
         gOzVW8ef9pQ6GOoZGW5m/XDoMx/0yw6Gidr2omGsXcxQuhFE0vYhYFhX7aQeFs9S/QLs
         W0K4WnOCFqCya+7/4l0Ou3Ibtp5CAvIZT2P3olyEQu71iMcyxyyoTGujSpK3/wrfvDt7
         n/5g==
X-Gm-Message-State: AFeK/H0zqiZf3jMnkJxubTouJOZYTB5RucjHuQph9+gFE+22rHLJ+1onfoI+ufufnOW+X6PRO8NmtOAn6s7EGg==
X-Received: by 10.157.36.202 with SMTP id z68mr10455832ota.271.1490092006861;
 Tue, 21 Mar 2017 03:26:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 21 Mar 2017 03:26:16 -0700 (PDT)
In-Reply-To: <20170320231752.gzo2uk6d2qob5ovk@genre.crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
 <20170318211954.564030-7-sandals@crustytoothpaste.net> <CACsJy8Ch0=ovmmfHikQG04K249TEpA3HONWpknUn_kWbQa=8Fw@mail.gmail.com>
 <20170320231752.gzo2uk6d2qob5ovk@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 Mar 2017 17:26:16 +0700
Message-ID: <CACsJy8Drb8vuL2mqk_NC4w8Z78bx_eDREyG3Xo0KYWXispi3rA@mail.gmail.com>
Subject: Re: [PATCH 06/20] builtin/receive-pack: convert portions to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 6:17 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Mar 20, 2017 at 07:56:17PM +0700, Duy Nguyen wrote:
>> On Sun, Mar 19, 2017 at 4:19 AM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> > @@ -1489,23 +1489,24 @@ static struct command **queue_command(struct command **tail,
>> >                                       const char *line,
>> >                                       int linelen)
>> >  {
>> > -       unsigned char old_sha1[20], new_sha1[20];
>> > +       struct object_id old_oid, new_oid;
>> >         struct command *cmd;
>> >         const char *refname;
>> >         int reflen;
>> > +       const char *p;
>> >
>> > -       if (linelen < 83 ||
>> > -           line[40] != ' ' ||
>> > -           line[81] != ' ' ||
>> > -           get_sha1_hex(line, old_sha1) ||
>> > -           get_sha1_hex(line + 41, new_sha1))
>> > +       if (!linelen ||
>>
>> I think you can skip this. The old code needed "< 83" because of the
>> random accesses to [40] and [81] but you don't do that anymore.
>> parse_oid_hex() can handle empty hex strings fine.
>
> I just realized this looks fishy:
>
>         while (boc < eoc) {
>                 const char *eol = memchr(boc, '\n', eoc - boc);
>                 tail = queue_command(tail, boc, eol ? eol - boc : eoc - eol);
>                 boc = eol ? eol + 1 : eoc;
>         }
>
> If eol is NULL, we subtract it from eoc?  I mean, eol will be zero, so
> we get eoc, which seems like what we want.  I think I'm going to send in
> a separate patch to fix that, because clearly that's bizarre and not at
> all compliant with the C standard.

Eck.. Good eyes!

>> > +           parse_oid_hex(line, &old_oid, &p) ||
>> > +           *p++ != ' ' ||
>> > +           parse_oid_hex(p, &new_oid, &p) ||
>> > +           *p++ != ' ')
>>
>> maybe "|| *p)" as well? I think the old code, with "linelen < 83",
>> makes sure reflen is at least one. Not sure what FLEX_ALLOC_MEM would
>> do if reflen is zero.
>
> I don't think that line is actually guaranteed to be NUL-terminated.  It
> may be terminated instead by a newline, such as by
> queue_commands_from_cert.
>
> If we did get an empty reflen, we'd call xcalloc, where we will allocate
> exactly the size of the struct otherwise.  We'd then try to memcpy zero
> bytes into that location, and succeed.

Actually I think we allocate an extra byte for NUL as well, so
cmd->ref_name is still valid (as an empty string). Yes we should be
fine.
-- 
Duy
