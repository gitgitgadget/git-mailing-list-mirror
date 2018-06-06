Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 600FC1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 19:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeFFTc2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 15:32:28 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33130 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeFFTc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 15:32:27 -0400
Received: by mail-oi0-f53.google.com with SMTP id c6-v6so5241456oiy.0
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=krWjIq5zoKHONiPQl5Yw46MsPGhdGvoa3BWSNUJYybM=;
        b=fq3dLmXoPoJE5PebgN115/jk7XECcxpFvmttYThztxFSX9qgarvhtb7tJI28ovR5wq
         8vP6rsJDUAcNZuxuaGGz9aJaDNaZCqbHA97aCf9/TrSW0LSOrxBx1N4RRBcEp8ydEL8j
         FNlArz5ABDBZnKS+1F3LwYYdeLqDZCKHwwYKTaA7MF7zXxYFuUVauNYyYMrNSdV3unEa
         tXOuKYLF9fZ2C+VeSfvUrKq62jzfNCloYsFkKTxt/mcbvwGPM08TdQpai5i/qGHf9ygC
         rnzzDQ+egTO8Rai1Z4XyuGu1VxQOPt33v3nf1tXlOFcFyELa85rg5zqdv1jfzlpdG9kr
         EDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=krWjIq5zoKHONiPQl5Yw46MsPGhdGvoa3BWSNUJYybM=;
        b=SfnlwhmypygLPofXLsnckpX5q6Xlt1dewpKNj7aMHj/n29zkLLKPaSq7lT1Y9ZgVdF
         dpjj/rkkgCIkMu0VtBeHVkHR3V7eugYbneZKqFCuPiJrR23pSnI4zcrjXJ8+W9e7QF5a
         omccNpXsWL3rqng8BEtRQYr4xNGan+uBAtqk9APJic3vRFATX3wnEv5ttgFsyQGJJz2K
         gE0q5g60o5dtvTksFWQrC9mZ7itgw98DgCY6tQeo2XAHwXeo6PeRE1BO3i7mZur0gC9r
         C9bPx20ga/bsR3Vze3VnQPzap/0eukyWF39sG17j+H7gYUlZWpX80kGKNGcFHANW6n+r
         vLsA==
X-Gm-Message-State: APt69E3dBJCFmcYwvCHadipLV22mD79aP1frJKls7YG/0eB3wTVo5zDz
        YJ9PK6BBgf8/5dYk3oMNKBrZWU+u8Ig3icgW1Oc=
X-Google-Smtp-Source: ADUXVKIbTaLrBOlN8V6SeddhjmU94xv3kLmknYGD0iINtJYQkQCk2qIHwJM2MvjOljgE+d3XMvr5eUIP9msZa/NbchA=
X-Received: by 2002:aca:f02:: with SMTP id 2-v6mr2566512oip.216.1528313546927;
 Wed, 06 Jun 2018 12:32:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 12:31:56 -0700 (PDT)
In-Reply-To: <20180530004810.30076-29-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180530004810.30076-29-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Jun 2018 21:31:56 +0200
Message-ID: <CACsJy8BQGqNDkoL0ykNdbgAx75MjPzW3Ki5+rbHxxJ8TNWDZcw@mail.gmail.com>
Subject: Re: [PATCH 28/35] commit.c: migrate the commit buffer to the parsed
 object store
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 2:48 AM, Stefan Beller <sbeller@google.com> wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  commit.c | 29 +++++++++++++++++++++++------
>  commit.h |  2 ++
>  object.c |  5 +++++
>  object.h |  2 ++
>  4 files changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index fd31c453fdc..45dbf6f1453 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -248,18 +248,32 @@ struct commit_buffer {
>         unsigned long size;
>  };
>  define_commit_slab(buffer_slab, struct commit_buffer);

struct buffer_slab is defined locally here...

> diff --git a/commit.h b/commit.h
> index 536fa03955f..df199498bfb 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -81,6 +81,8 @@ static inline int parse_commit_the_repository(struct commit *item)
>  }
>  void parse_commit_or_die(struct commit *item);
>
> +struct buffer_slab *allocate_commit_buffer_slab(void);

So you would need a forward declaration of struct buffer_slab in
commit.h before it's referenced here?

> diff --git a/object.h b/object.h
> index 6adc8323ca4..45e22282101 100644
> --- a/object.h
> +++ b/object.h
> @@ -22,6 +22,8 @@ struct parsed_object_pool {
>         char *alternate_shallow_file;
>
>         int commit_graft_prepared;
> +
> +       struct buffer_slab *buffer_slab;

and maybe here as well

>  };
>
>  struct parsed_object_pool *parsed_object_pool_new(void);
> --
> 2.17.0.582.gccdcbd54c44.dirty
>



-- 
Duy
