Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E85C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 19:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2401207F7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 19:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOkYxZro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgI2TtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 15:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgI2TtH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 15:49:07 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426DC061755
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 12:49:07 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y194so3689209vsc.4
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hgZldS07uhEhU+sKzC4P0UKNHMUgBZvgtSEAwCGmpM=;
        b=tOkYxZroMrZuy2OrLSqgy513xlqWfH9/sDWMBHf+YYi44t4OlaT2Sbl0wO847z0fJV
         YmF933Y3aewlsENrnheJpnAORdKnEpOE+8kvcTy55psVjWYsT05Hwy4TZXPgc7LL3GEr
         h7yX1b5je8IL08iNmf8c8oKHdCUqrO3IeWEkh8bspc7LACK8fynu+OyprpiyMaRnveCJ
         9Y93iS6ssIO46HlkdRwWmsVXt4tRIlZZ/ECDFrS//DH7JKxcJMoRN5PCGpUghBlMvHMA
         j2ONFZHM3dXCGwkLOmoLv40UWTnJvfVItBj+MpI1jNcQ6myH3EYd5G0Eo+Ri73FyNoQo
         FG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hgZldS07uhEhU+sKzC4P0UKNHMUgBZvgtSEAwCGmpM=;
        b=Ync3kBFB8Yn5tqGsoVs5FYd8eoGFH15blGE3twioocqyNSojcelfd52ytDtLrGXTSo
         dokkFCn9fEop5INDPe0niGw0vhkMim6nzu7IFVxdk7G07EJ/qpEH0navV/tU6egYTSNa
         QZ/gSZg3tbCCXOM1/EgJSKetcY8hHQKiDuzi+dsxXlzoTFQTJHhtahnIv+AecDYHOFUf
         W2itzwY708iZU+XgGCHSmp7ZqLHIQik1C2Bm5Elj0O3s0u80GCtRcKUI117zsZCjETl2
         Q7yL2fnQodk7c5LAm5vhSurfbcE6IJ1Qpjroar1seWhPg3LDnApDINEWyRBUYPGnpk3B
         oxHw==
X-Gm-Message-State: AOAM533685PlOLzrvzM7gDR/iTr66JD6DzKiFnsrCWlkJACkGt0tj/vB
        BsguSkKsNk1XStVdUxno1/JXgO72P+C6Ly+CllA=
X-Google-Smtp-Source: ABdhPJw4LEEpLbVlcB9hIeniAHw5R+eXuwOEr6+FJvJNwi3YCXmxhRdwSUjJqUo08b/3+LiWSY7jN/QDqTd60Byw3Jc=
X-Received: by 2002:a67:fd44:: with SMTP id g4mr2996734vsr.49.1601408946278;
 Tue, 29 Sep 2020 12:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
 <pull.724.v2.git.1599846560.gitgitgadget@gmail.com> <f609c1bde27558db2a9601ac34f8a51ce86f0e2c.1599846561.git.gitgitgadget@gmail.com>
In-Reply-To: <f609c1bde27558db2a9601ac34f8a51ce86f0e2c.1599846561.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 29 Sep 2020 21:48:54 +0200
Message-ID: <CAN0heSqkJoqXKP5ccaGMA1_ppd0bcQ7G0ozUH+H7tBMonhcrjQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] maintenance: recommended schedule in register/start
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, sluongng@gmail.com,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Fri, 11 Sep 2020 at 19:53, Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> If a user sets any 'maintenance.<task>.schedule' config value, then
> they have chosen a specific schedule for themselves and Git should
> respect that.
>
> However, in an effort to recommend a good schedule for repositories of
> all sizes, set new config values for recommended tasks that are safe to
> run in the background while users run foreground Git commands. These
> commands are generally everything but the 'gc' task.

If there aren't any "schedule" configurations, we'll go ahead and
sprinkle in quite a few of them. I suppose that another approach would
be that later, much later, when we go look for these configuration
items, we could go "there is not a single one set, let's act as if
*these* were configured".

The advantage there would be that we can tweak those defaults over time.
Whereas with the approach of this patch, v2.29.0 will give the user a
snapshot of 2020's best practices. If they want to catch up, they will
need to drop all their "schedule" config and re-"register", or use a
future `git maintenance reregister`. ;-)

Anyway, this is a convenience thing. There's a chance that "convenience"
interferes with "perfect" and "optimal". I guess that's to be expected.

> +If your repository has no 'maintenance.<task>.schedule' configuration

Thank you for going above and beyond with marking config items et cetera
for rendering in `monospace`. I just noticed that this is slightly
mis-marked-upped. If you end up rerolling this patch series for some
reason, you might want to switch from 'single quotes' to `backticks` in
this particular instance.

While I'm commenting anyway...

> +static int has_schedule_config(void)
> +{
> +       int i, found = 0;
> +       struct strbuf config_name = STRBUF_INIT;
> +       size_t prefix;
> +
> +       strbuf_addstr(&config_name, "maintenance.");
> +       prefix = config_name.len;
> +
> +       for (i = 0; !found && i < TASK__COUNT; i++) {
> +               char *value;
> +
> +               strbuf_setlen(&config_name, prefix);
> +               strbuf_addf(&config_name, "%s.schedule", tasks[i].name);
> +
> +               if (!git_config_get_string(config_name.buf, &value)) {
> +                       found = 1;
> +                       FREE_AND_NULL(value);
> +               }
> +       }
> +
> +       strbuf_release(&config_name);
> +       return found;
> +}

That `FREE_AND_NULL()` caught me off-guard. The pointer is on the stack.
I suppose it doesn't *hurt*, but being careful to set it to NULL made me
go "huh".

I suppose you could drop the `!found` check in favour of `break`-ing
precisely when you get a hit.

And I do wonder how much the reuse of the "maintenance." part of the
buffer helps performance.

In the end, you could use something like the following (not compiled):

  static int has_schedule_config(void)
  {
         int i, found = 0;
         struct strbuf config_name = STRBUF_INIT;

         for (i = 0; i < TASK__COUNT; i++) {
                 const char *value;

                 strbuf_reset(&config_name);
                 strbuf_addf(&config_name, "maintenance.%s.schedule",
tasks[i].name);

                 if (!git_config_get_value(config_name.buf, &value)) {
                         found = 1;
                         break;
                 }
         }

         strbuf_release(&config_name);
         return found;
  }

Anyway, that's just microniting, obviously, but maybe in the sum it has
some value.


Martin
