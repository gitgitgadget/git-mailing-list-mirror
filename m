Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315721F404
	for <e@80x24.org>; Sat,  3 Feb 2018 00:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeBCA0x (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 19:26:53 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36162 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752882AbeBCA0u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 19:26:50 -0500
Received: by mail-yw0-f194.google.com with SMTP id q6so14521325ywg.3
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 16:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ug3tb5KOJoSGBngMYKYrrhtE9eIidzaJB1pzqgYgfaU=;
        b=UiPYu92bOS2QPM0WPkLIiACqNiQDFOZwhA5zzsV0hMX2kpSgVxt1ehQjC9UGUCc0o4
         37N6YXx8O+rbudraX30mvylpopY6S4+OY/rISBL0SF9pTD9i5p7awd0RdUVH+yxdbs0w
         SZdY75x/PMsrEdv8RqMpgmCxxkfvMN/fD0Yd4pQLlsznDhfAkIgxOPsnnR1kxvp8c7YR
         VF6VNyq9halZa+4EHFMPrnGQZlJAsLynY1yUEbsBjL6IqN5tlq6ge2F/kTqnRlKkxgrR
         PHSQ7k1H/MpzDdMQZExbTJvO5raMYi6cXE1TGDoZ5gPkXxitaz47Fmm1DrAd533NpUGE
         cKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ug3tb5KOJoSGBngMYKYrrhtE9eIidzaJB1pzqgYgfaU=;
        b=CYDP7B+kCCBftPkyV9HXjVSdx1Z79CyC+iGwohwaf5Xaclto72m4lJgsl7WViwTH3u
         0eNuoWHUHTrFjbSqpoWTCKf4T83zriZZApBMwb4Moct9lBJu9acdQP7Fu7EJ70kVpr59
         SIZi29FKtitDCijBZ7ddIQI+iXZnEkI4DXgGTRnpWs6y8Kb1p4vBeZMf/8KpE7wlZBbU
         Y0tiGPfmcImzsfjGIxiAOqm1ICExy+sdy6ZppUQUt52tBH9rc30MywDU4kbtsByDQhnu
         R+AknrkDc3ZrpY7DYhfuVlb+Iv0tHQoAG9vgy6YG8XNOCwjOZCBQSD4aIEVRv0xwOXXq
         nWLA==
X-Gm-Message-State: AKwxytecv0lmm+/ZiCPBRw93D68thfcVMBmm40d6PC5hIrQS5YoTnQJC
        1cLnXI0tJkmv0BA3znHQPo8OzX4xNkHsXBP0CAkjzuSj1OI=
X-Google-Smtp-Source: AH8x227Ldw2bz7lHJts1ezGcD/90NMkuM7sAurnuXdpw8Bg2Vt8mKayRAVeoHiaYruO/lcla9dF4L0c8Nvnoe7WqaAs=
X-Received: by 10.129.119.131 with SMTP id s125mr27336136ywc.166.1517617609876;
 Fri, 02 Feb 2018 16:26:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 2 Feb 2018 16:26:49 -0800 (PST)
In-Reply-To: <20180130232533.25846-18-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-18-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Feb 2018 16:26:49 -0800
Message-ID: <CAGZ79kYcmq9JyD4smH1Vdm5YOFXRXjhYhhHYjNV=Z7mxz2UVGw@mail.gmail.com>
Subject: Re: [PATCH v7 17/31] merge-recursive: add a new hashmap for storing
 directory renames
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> This just adds dir_rename_entry and the associated functions; code using
> these will be added in subsequent commits.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 35 +++++++++++++++++++++++++++++++++++
>  merge-recursive.h |  8 ++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 8ac69e1cbb..3b6d0e3f70 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -49,6 +49,41 @@ static unsigned int path_hash(const char *path)
>         return ignore_case ? strihash(path) : strhash(path);
>  }
>
> +static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *hashmap,
> +                                                     char *dir)
> +{
> +       struct dir_rename_entry key;
> +
> +       if (dir == NULL)
> +               return NULL;
> +       hashmap_entry_init(&key, strhash(dir));
> +       key.dir = dir;
> +       return hashmap_get(hashmap, &key, NULL);
> +}
> +
> +static int dir_rename_cmp(void *unused_cmp_data,
> +                         const struct dir_rename_entry *e1,
> +                         const struct dir_rename_entry *e2,
> +                         const void *unused_keydata)
> +{
> +       return strcmp(e1->dir, e2->dir);
> +}
> +
> +static void dir_rename_init(struct hashmap *map)
> +{
> +       hashmap_init(map, (hashmap_cmp_fn) dir_rename_cmp, NULL, 0);

See 55c965f3a2 (Merge branch 'sb/hashmap-cleanup', 2017-08-11) or rather
201c14e375 (attr.c: drop hashmap_cmp_fn cast, 2017-06-30) for an attempt to
keep out the casting in the init, but cast the void->type inside the function.

> +static void dir_rename_entry_init(struct dir_rename_entry *entry,
> +                                 char *directory)
> +{
> +       hashmap_entry_init(entry, strhash(directory));
> +       entry->dir = directory;
> +       entry->non_unique_new_dir = 0;
> +       strbuf_init(&entry->new_dir, 0);
> +       string_list_init(&entry->possible_new_dirs, 0);
> +}
> +
>  static void flush_output(struct merge_options *o)
>  {
>         if (o->buffer_output < 2 && o->obuf.len) {
> diff --git a/merge-recursive.h b/merge-recursive.h
> index 80d69d1401..d7f4cc80c1 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -29,6 +29,14 @@ struct merge_options {
>         struct string_list df_conflict_file_set;
>  };
>
> +struct dir_rename_entry {
> +       struct hashmap_entry ent; /* must be the first member! */
> +       char *dir;
> +       unsigned non_unique_new_dir:1;
> +       struct strbuf new_dir;
> +       struct string_list possible_new_dirs;
> +};

Could you add comments what these are and if they have any constraints?
e.g. is 'dir' the full path from the root of the repo and does it end
with a '/' ?

Having a stringlist of potentially new dirs sounds like the algorithm is
at least n^2, but how do I know? I'll read on.

This patch only adds static functions, so some compilers may even refuse
to compile after this patch (-Werror -Wunused). I am not sure how strict we
are there, but as git-bisect still hasn't learned about going only
into the first
parent to have bisect working on a "per series" level rather than a "per commit"
level, it is possible that someone will end up on this commit in the future and
it won't compile well. :/

Not sure what to recommend, maybe squash this with the patch that makes
use of these functions?

Thanks,
Stefan
