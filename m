Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4081F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeADWKp (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:10:45 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:46500 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbeADWKo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:10:44 -0500
Received: by mail-qt0-f172.google.com with SMTP id r39so3662277qtr.13
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x0hTf4EChrvWcCiifmqKzAk1HmmSudHAcW02K797zwE=;
        b=W+r6bH1ukV3Mk3VIZF+l6CqrCJz3Vxto307dXhx+H08k3hE8guFtWF213WQ55uazqU
         vcdz6eNwQ4xxYmoH9J4LvQVjbD0PYcCyhvXvWRybWWtp3StP9gW/5/iEx0wAtdfuRoke
         VmiHSgrouOzPKi3ya4F1V9te+a3JU09TZHew0iMfpnO37H2tu4H6fZ4T2xUeh09SsN+A
         4eBnFv0lSX+0VOX2AALBl2VwwYuO8KAUJ89hud+gEywbCqc4YZzOBRs0tS+L6gj4mCr0
         p9Z0co7oNHWw9yZ/ta+vw9IxSHTc1VYswZuIoY4TF4vePNdcjwCV20mjiesZszEI9Saz
         BCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x0hTf4EChrvWcCiifmqKzAk1HmmSudHAcW02K797zwE=;
        b=eq3hDNEdcm2lXWYMz4ofdBMIOX5/QBFEDPcLA6TQtDUz4zn31UKWThh8UvaJBJ15zI
         wAAMqJVPnbpmVtDtKbixVT1PqckQFWgg/1GYNZVZwuLwIIgduRAjR/Dg+TdN+UDBuyuZ
         h0zvIt0yPCccvToyKFKjvJ7ULqG83tZ4QitI3Z9pBjQU1LPPf/4/mAp88X3+TyjseGB4
         knctNVKPJ3Rw5ZJOsOqLPhWeySiMhG/aWOZ2DL5M1tHo3EikJGT+gkksG0UniOzTfV92
         cgv6EqC7kuNUFfjGVZEIYqGM01JqokCvDrdxn9YyifYX5DlRi2bRDC+adOz66rm3Fgpy
         OXPg==
X-Gm-Message-State: AKwxytczUMiF1wsocNEYYXy60dTLcBY0+mz346OHKb5QKob6sxlzvSA1
        8mHpIMVhtsiqchgeGGwZ0LLuxQMyLQL2dRzLSFGG+lhg
X-Google-Smtp-Source: ACJfBos0AOqvVL9yoGKNdmXULgWYyIoChZna7Pj4swhdBAgH1fcZiMDbgI+gLmhcm5G+bYrnnS5gfWx7CEoEycCrOh4=
X-Received: by 10.237.38.35 with SMTP id z32mr1513958qtc.180.1515103843481;
 Thu, 04 Jan 2018 14:10:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 4 Jan 2018 14:10:42 -0800 (PST)
In-Reply-To: <CAPig+cTkxmiJZwLqYhKhvApZubJLTLufv2Yo6D5nLMLmrUc2cg@mail.gmail.com>
References: <20171228210345.205300-1-sbeller@google.com> <20171228210345.205300-3-sbeller@google.com>
 <CAPig+cTkxmiJZwLqYhKhvApZubJLTLufv2Yo6D5nLMLmrUc2cg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 4 Jan 2018 14:10:42 -0800
Message-ID: <CAGZ79ka22DPHX5_etFREvdVjfsQPzQG66iFgyfsjCdLnwUcAdA@mail.gmail.com>
Subject: Re: [PATCH 2/4] builtin/blame: dim uninteresting metadata
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 28, 2017 at 2:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Dec 28, 2017 at 4:03 PM, Stefan Beller <sbeller@google.com> wrote:
>> When using git-blame lots of lines contain redundant information, for
>> example in hunks that consist of multiple lines, the metadata (commit
>> name, author, date) are repeated. A reader may not be interested in those,
>> so offer an option to color the information that is repeated from the
>> previous line differently.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> @@ -367,6 +370,28 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
>> +static inline void colors_unset(const char **use_color, const char **reset_color)
>> +{
>> +       *use_color = "";
>> +       *reset_color = "";
>> +}
>> +
>> +static inline void colors_set(const char **use_color, const char **reset_color)
>> +{
>> +       *use_color = repeated_meta_color;
>> +       *reset_color = GIT_COLOR_RESET;
>> +}
>> +
>> +static void setup_line_color(int opt, int cnt,
>> +                            const char **use_color,
>> +                            const char **reset_color)
>> +{
>> +       colors_unset(use_color, reset_color);
>> +
>> +       if ((opt & OUTPUT_COLOR_LINE) && cnt > 0)
>> +               colors_set(use_color, reset_color);
>> +}
>
> I'm not convinced that this colors_unset() / colors_set() /
> setup_line_color() abstraction is buying much. With this abstraction,
> I found the code more difficult to reason about than if the colors
> were just set/unset manually in the code which needs the colors. I
> *could* perhaps imagine setup_line_color() existing as a separate
> function since it is slightly more complex than the other two, but as
> it has only a single caller through all patches, even that may not be
> sufficient to warrant its existence.

Have you viewed this patch in context of the following patch?
Originally I was convinced an abstraction was not needed, but
as the next patch shows, a helper per field seems handy.

>
>> @@ -383,6 +408,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>>         for (cnt = 0; cnt < ent->num_lines; cnt++) {
>>                 char ch;
>>                 int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
>> +               const char *col, *rcol;
>
> I can't help but read these as "column" and "[r]column"; the former,
> especially, is just too ingrained to interpret it any other way.
> Perhaps call these "color" and "reset" instead?

will fix.

>
>> @@ -607,6 +636,12 @@ static int git_blame_config(const char *var, const char *value, void *cb)
>> +       if (!strcmp(var, "color.blame.repeatedmeta")) {
>> +               if (color_parse_mem(value, strlen(value), repeated_meta_color))
>> +                       warning(_("ignore invalid color '%s' in color.blame.repeatedMeta"),
>> +                               value);
>
> Does this need to say "ignore"? If you drop that word, you still have
> a valid warning message.

dropped 'ignore'.

>
>> +               return 0;
>> +       }
>> @@ -681,6 +716,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>>                 OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
>>                 OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
>>                 OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
>> +               OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line"), OUTPUT_COLOR_LINE),
>
> Not sure what this help message means. Do you mean "color redundant
> ... _differently_ ..."? Or "_dim_ redundant..."?

Originally (in a patch set a couple months back) I had 'dim', but Junio
seems to have an interesting color setup, such that he would not call
it dimming IIRC, hence I think I wanted to say color _differently_. Fixed.

>> diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
>> @@ -0,0 +1,18 @@
>> +#!/bin/sh
>> +
>> +test_description='colored git blame'
>> +. ./test-lib.sh
>> +
>> +PROG='git blame -c'
>> +. "$TEST_DIRECTORY"/annotate-tests.sh
>> +
>> +test_expect_success 'colored blame colors continuous lines' '
>
> What are "continuous lines"? Did you mean "contiguous"?

Thanks for hinting at the subtle difference!

Thanks for the review!
(I will drop the abstraction and see how it goes)

Stefan
