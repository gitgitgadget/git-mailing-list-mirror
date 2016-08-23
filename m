Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1916D1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756490AbcHWWgj (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:36:39 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33428 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbcHWWgi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:36:38 -0400
Received: by mail-yb0-f193.google.com with SMTP id e31so4164775ybi.0
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=caqiambapqEov2/h2TS17iLkEhLxuCl10JCrzGXJmBU=;
        b=JuQ63fYrFb9vw1CcvppWUtXTtNpcoqRkGW84kOIIBl3qjYk5PlYVEgb/r7wyKXgxEv
         d87bVfOb1gn17K08CPRRGxVjBwWyg76z+wJPsBNISkCeE9LE3m24pI97+Gagjhdml/cb
         C7k2TnNVFOL5f8+Z5xZopXWQvcRRRHqsXuMP4k4G3HLayioIw/zi/Uk5UTTKQqUOwcAk
         ONcdJZtbcUZE5ldwwzpVWMxHuz32fDPTjQBAGzJU9PELvL2VEQuSswzMV0bgl9Ss9Vzc
         /oZiNCx4+iN5SwCcMLzgIdsmE5lIUjH8dz3KEYYzfZtoUKGIhJtk1xpwE+7HDKZEwZF2
         O8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=caqiambapqEov2/h2TS17iLkEhLxuCl10JCrzGXJmBU=;
        b=VApj+Qb5+IlNCWxZ2a6c2unjM7OTe1HvHQIWu2OOTA7I038JhiV+apuhh5uOVPqcyt
         jn49clBHTqHzy7Q/Emt/gT3btR71urKizXS2Yoh3KqTxaDIKYmnK3OrDAjzIReE+X8cn
         H6Si4sDP2dLXxkkfVJ+JvvS9hPExBZaXp2bWRZoDuofkzkBSd7WGHXQx9MyFrrZ30yXj
         xIkLIAu4VFm7dws5QzzO/kRZC2EjLwZyp226O58OOzSWBhuoT78kPoe3WQAIeyRNJrv1
         kwsKYrWEYSDTrvSQsz6ShHsbWAqqrfdThSI/vrDkBytFqvfa4OLbSAxRl11neuI2UFeD
         LscQ==
X-Gm-Message-State: AEkoouvqcBOYKa1pKC9y42GIKiFndQDeUvC8pGZNlAtVU/PpOysJ36udq6RYR7N1+i8s1ri1KHbfgV0wWO1sxg==
X-Received: by 10.37.60.67 with SMTP id j64mr22760142yba.111.1471991739890;
 Tue, 23 Aug 2016 15:35:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 23 Aug 2016 15:35:19 -0700 (PDT)
In-Reply-To: <20160815215327.15682-8-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-8-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 15:35:19 -0700
Message-ID: <CA+P7+xp1AQe6N9jANaRhO-QsNUkBh2kK5SR-=utihEGt=tzFnA@mail.gmail.com>
Subject: Re: [PATCHv5 7/8] clone: implement optional references
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2016 at 2:53 PM, Stefan Beller <sbeller@google.com> wrote:
> In a later patch we want to try to create alternates for submodules,
> but they might not exist in the referenced superproject. So add a way
> to skip the non existing references and report them.
>

Seems pretty straight forward to me.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git-clone.txt |  5 ++++-
>  builtin/clone.c             | 35 +++++++++++++++++++++++++----------
>  2 files changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index ec41d3d..e316c4b 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -90,13 +90,16 @@ If you want to break the dependency of a repository cloned with `-s` on
>  its source repository, you can simply run `git repack -a` to copy all
>  objects from the source repository into a pack in the cloned repository.
>
> ---reference <repository>::
> +--reference[-if-able] <repository>::
>         If the reference repository is on the local machine,
>         automatically setup `.git/objects/info/alternates` to
>         obtain objects from the reference repository.  Using
>         an already existing repository as an alternate will
>         require fewer objects to be copied from the repository
>         being cloned, reducing network and local storage costs.
> +       When using the `--reference-if-able`, a non existing
> +       directory is skipped with a warning instead of aborting
> +       the clone.
>  +
>  *NOTE*: see the NOTE for the `--shared` option, and also the
>  `--dissociate` option.
> diff --git a/builtin/clone.c b/builtin/clone.c
> index ef5db7c..0182665 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -51,6 +51,7 @@ static int option_progress = -1;
>  static enum transport_family family;
>  static struct string_list option_config = STRING_LIST_INIT_NODUP;
>  static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
> +static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
>  static int option_dissociate;
>  static int max_jobs = -1;
>
> @@ -81,6 +82,8 @@ static struct option builtin_clone_options[] = {
>                    N_("directory from which templates will be used")),
>         OPT_STRING_LIST(0, "reference", &option_required_reference, N_("repo"),
>                         N_("reference repository")),
> +       OPT_STRING_LIST(0, "reference-if-able", &option_optional_reference,
> +                       N_("repo"), N_("reference repository")),
>         OPT_BOOL(0, "dissociate", &option_dissociate,
>                  N_("use --reference only while cloning")),
>         OPT_STRING('o', "origin", &option_origin, N_("name"),
> @@ -283,24 +286,36 @@ static void strip_trailing_slashes(char *dir)
>  static int add_one_reference(struct string_list_item *item, void *cb_data)
>  {
>         struct strbuf err = STRBUF_INIT;
> -       struct strbuf sb = STRBUF_INIT;
> +       int *required = cb_data;
>         char *ref_git = compute_alternate_path(item->string, &err);
>
> -       if (!ref_git)
> -               die("%s", err.buf);
> -
> -       strbuf_addf(&sb, "%s/objects", ref_git);
> -       add_to_alternates_file(sb.buf);
> +       if (!ref_git) {
> +               if (*required)
> +                       die("%s", err.buf);
> +               else
> +                       fprintf(stderr,
> +                               _("info: Could not add alternate for '%s': %s\n"),
> +                               item->string, err.buf);
> +       } else {
> +               struct strbuf sb = STRBUF_INIT;
> +               strbuf_addf(&sb, "%s/objects", ref_git);
> +               add_to_alternates_file(sb.buf);
> +               strbuf_release(&sb);
> +       }

I might have done this with a "goto out" instead of the else block,
but this is reasonable as well.

Regards,
Jake
