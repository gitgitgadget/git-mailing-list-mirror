Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E5C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A19233EE
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbhAGUDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbhAGUDj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:03:39 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0322EC0612F5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:02:59 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id x13so8726011oic.5
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Al6AnFiZgDoC3QPpzLAQmCVSRDel9pacL9f+zOrKH1U=;
        b=GFJ6XHDFZkZ7MHHTSKcCdOzTczYW/sb475V68/KwaMX+dyT1zDZBh17TYo8nKORX9h
         FG9mHx9PaiBycAF6M42FCR8IoiZhr9j5qXwu46Dl48MGGTURDuK7T+1oi0A6gFpLb9R/
         6c0BvS9zcXylpLgCHLTFVKly1N9Qfcg4AksktNpqekVL7O9UVee19Pa5wKTmM2K38qmP
         Hw1SyPWXH0fqqSHQ6voWhreuhfVVaxRsVVnRRdN3s5gomqg/0Swql2HMixVogPNPY80M
         u7AXSGa7rUonVlneRE2Lj7Cb8FQpNyzueoS4yh9UVYvJtApO+mIKQr5TTOXENe/Cyvnq
         dB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Al6AnFiZgDoC3QPpzLAQmCVSRDel9pacL9f+zOrKH1U=;
        b=ppUaOiCnv40sG+DnOw7U6Kl7b6a7wwVEew9lK89YVzCGntdTNgJEBLD7ZxztfoAuE4
         8RDc+7I589Fxi6hgnr9VbzeZkKmCcKwU5eggoqU+w46qMNhpgZJOjY5WJZ/8mxOHigTr
         SBNN18OnjOtQMnqrjf8DZJFWnLnkEIxi2Kevibbq0cBfrAn5w35Wdm6+SRS6CfRlpGfw
         77bHrQE7WFjzhH+15pdQr2S3VHyCAo+QklIBPCTWdO7drebrVgY9y7xiGZN+S2F1qGyO
         jxcNkWZoZzJBVy0Cxy0tXOo4DovzqVNG542k6yjpL+tmsh1e+Jq3LqRfYcBZPJJW/in+
         z+2w==
X-Gm-Message-State: AOAM530FiE6d+U1CXOtYqINBa9+Gc2a5G5hr6m4uyYl0TeeYJx+stSep
        /qktELHMwECRt9GmtufpN5DFogjPj4ryDMqkDh4ibydG
X-Google-Smtp-Source: ABdhPJyOR9deP6KOfFpW5+4+/StT0nvZZiSSEyM+oGFWWybrxiTU7DglLN7P22bYw2jnLoCS2MwEIzJfzVrAFaalHUo=
X-Received: by 2002:a05:6808:991:: with SMTP id a17mr153616oic.167.1610049778404;
 Thu, 07 Jan 2021 12:02:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.git.1610049687.gitgitgadget@gmail.com> <786dc8f0c449958174a4cf5e98704d36f3ae4076.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <786dc8f0c449958174a4cf5e98704d36f3ae4076.1610049687.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Jan 2021 12:02:47 -0800
Message-ID: <CABPp-BGFQfFBdGtPxTnCG8-5yUwnUK9tsEzdWDgHk4pHfx2s9A@mail.gmail.com>
Subject: Re: [PATCH 18/18] DO NOT SUBMIT: directory rename stuff for redo_after_renames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whoops.  Ignore this patch, of course.

On Thu, Jan 7, 2021 at 12:01 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> I believe the
>    ci->dirmask & sidemask
> stuff was leftovers from before I added dirs_removed.  I think it's
> dead, useless code; just need to check.
>
> Also, the
>    !mi || mi->clean
> portions should only be triggerable once I do the redo_after_renames
> stuff.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 55a835f8b97..1eb3a2e0fbb 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1031,6 +1031,48 @@ static void get_provisional_directory_renames(struct merge_options *opt,
>         }
>  }
>
> +static void remove_invalid_dir_renames(struct merge_options *opt,
> +                                      struct strmap *side_dir_renames,
> +                                      unsigned side_mask)
> +{
> +       struct hashmap_iter iter;
> +       struct strmap_entry *entry;
> +       struct string_list removable = STRING_LIST_INIT_NODUP;
> +       int i;
> +
> +       strmap_for_each_entry(side_dir_renames, &iter, entry) {
> +               struct merged_info *mi;
> +               struct conflict_info *ci;
> +
> +               mi = strmap_get(&opt->priv->paths, entry->key);
> +               INITIALIZE_CI(ci, mi);
> +               if (!mi ||
> +                   mi->clean ||
> +                   (ci->dirmask & side_mask)) {
> +                       /*
> +                        * !mi: This rename came from a directory that was
> +                        * unchanged on the other side of history, and NULL on
> +                        * our side.  No directory rename detection needed.
> +                        *
> +                        * mi->clean: Due to redo_after_renames, on the second
> +                        * run, collect_merge_info_callback was able to
> +                        * cleanly resolve the trivial directory merge without
> +                        * recursing.  As such, we know we don't need
> +                        * directory rename detection for it.
> +                        *
> +                        * ci->dirmask & side_mask: this directory "rename"
> +                        * isn't valid because the source directory name still
> +                        * exists on the destination side.
> +                        */
> +                       string_list_append(&removable, entry->key);
> +               }
> +       }
> +
> +       for (i=0; i<removable.nr; ++i)
> +               strmap_remove(side_dir_renames, removable.items[i].string, 0);
> +       string_list_clear(&removable, 0);
> +}
> +
>  static void handle_directory_level_conflicts(struct merge_options *opt)
>  {
>         struct hashmap_iter iter;
> @@ -1050,6 +1092,9 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
>                 strmap_remove(side2_dir_renames, duplicated.items[i].string, 0);
>         }
>         string_list_clear(&duplicated, 0);
> +
> +       remove_invalid_dir_renames(opt, side1_dir_renames, (1 << MERGE_SIDE1));
> +       remove_invalid_dir_renames(opt, side2_dir_renames, (1 << MERGE_SIDE2));
>  }
>
>  static struct strmap_entry *check_dir_renamed(const char *path,
> --
> gitgitgadget
