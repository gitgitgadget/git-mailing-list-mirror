Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6455220954
	for <e@80x24.org>; Wed, 22 Nov 2017 18:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbdKVS4I (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 13:56:08 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41091 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbdKVS4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 13:56:06 -0500
Received: by mail-qk0-f195.google.com with SMTP id f63so18085478qke.8
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 10:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4pAcz1zgGrWFJXQPZMuHFAMv9f0cTZxTIYnwoAKauRY=;
        b=XEqjd+XSwEdPHFuX0MztAFHleDy3Ak64U+MXf4T67/G6ysuvTx8feT/YSndFsswAmO
         Z9bdi3ABkqa9HQIQfF/q89s+2vlNVXzg2GiY/e/7OgIswICCJ9pUgwFCpAlZ0WyR+LlN
         4KCO/lu31MIS2kOXLMHnmZVvowKVPP2jkGg6OBxPYfEgWm/qpS9YyBBFHf95nuDxPf++
         OXQT4vurr+yVjTE4mwhTffe65NIqbcqgj+QNJhpcf84KQD1oAZiKzisTa7hDhA8IV/y/
         fXfzh2uEghmAt56lytpIrBG2ddhuIVuE/2q6rFX5hzqZqfywdEK+ELFjYDldilR6swO9
         3RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4pAcz1zgGrWFJXQPZMuHFAMv9f0cTZxTIYnwoAKauRY=;
        b=Yfm91lYx5JFj5jkG6mCtxJl9m7aj5h8HpmR0nDC4yQGBPQdko4bjLxMxsYrCbRp2jb
         6SOC7jS1FZFCdR1aJC4/0Zhpwimo3fvUNDs8XYuV5SgOOByPCQKpepg0BUYnJinZrWR4
         z6j9lboC5BrFhK4/PypuyqAOw29DklH49jUVS6s1dDzhWovzi5uDh5BY/HJf8/dmLzsU
         o8wvARWFGh83l80Bh3vgxF5BIuQKq6wS9qLxo2rjQD2FIwmnudxQPaP8DXkYOdIL0NiE
         bH6DFKPtYZx5Dhh/wm/GjAd4SpMx///mQ0bDKwtuNI2GLnQ4jIcY/53VNX8K0GaMTZhQ
         UxjQ==
X-Gm-Message-State: AJaThX65yDx7thdbnB3T+n2EyA7OELN9lKuVt/m8t7VTwgezvmluWxbz
        oCkCaUyaAHs0NXMmvE5lRp1cYbyvE3ZVUnqKi/hTkg==
X-Google-Smtp-Source: AGs4zMau9M7dngONDFy5pxXXUepf+GD+PgBNYa/vIci2LwNHfEw5D+6ly8obU/5U+nxz1XVofz8CzkPhb6fufaaVb7w=
X-Received: by 10.55.124.198 with SMTP id x189mr33977518qkc.40.1511376965944;
 Wed, 22 Nov 2017 10:56:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 22 Nov 2017 10:56:05 -0800 (PST)
In-Reply-To: <20171121080059.32304-26-newren@gmail.com>
References: <20171121080059.32304-1-newren@gmail.com> <20171121080059.32304-26-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Nov 2017 10:56:05 -0800
Message-ID: <CAGZ79kaUTKvfBfVGjjohsuFcQg8cjo7ZBZ7z-ypreXx21nU2Xg@mail.gmail.com>
Subject: Re: [PATCH v3 25/33] merge-recursive: check for file level conflicts
 then get new name
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 12:00 AM, Elijah Newren <newren@gmail.com> wrote:
> Before trying to apply directory renames to paths within the given
> directories, we want to make sure that there aren't conflicts at the
> file level either.  If there aren't any, then get the new name from
> any directory renames.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c                   | 192 ++++++++++++++++++++++++++++++++++--
>  t/t6043-merge-rename-directories.sh |   2 +-
>  2 files changed, 185 insertions(+), 9 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index b8c7d6dce3..5bc207b819 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1496,6 +1496,109 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
>         }
>  }
>
> +/*
> + * Write:
> + *   element1, element2, element3, ..., elementN
> + * to str.  If only one element, just write "element1" to str.
> + */
> +static void comma_separated_list(char *str, struct string_list *slist)

This is quite a low level function, so I wondered if we have such functionality
already, but neither string-list.h nor strbuf.h present a drop-in replacement.
Speaking of strbufs, this might be another "big thing" to use in this series as
strbufs make using strings (and its memory management) easier in git.

This functionality could look like this (in strbuf.c):

/*
 * Adds all strings of a string list to the strbuf, separated by the
given separator.
 * For example a list of ("a", "b") with sep=";" would result in "a;b" added
 * to the strbuf.
 */
void strbuf_add_separated_string_list(struct strbuf *sb, struct
string_list *slist, const char *sep)
{
    int add_sep = 0;
    struct string_list_item *item;

    for_each_string_list_item(item, s_list) {
        if (add_sep)
            strbuf_addstr(sb, sep);
        strbuf_addstr(item->string);
        add_sep = 1;
    }
}


> +{
> +       int i;
> +
> +       for (i = 0; i < slist->nr; i++) {
> +               str += sprintf(str, "%s", slist->items[i].string);
> +               if (i < slist->nr-1)

style nit: blanks before and after '-';

> +                       str += sprintf(str, ", ");
> +       }
> +}
