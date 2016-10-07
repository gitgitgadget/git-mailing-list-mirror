Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B98B320986
	for <e@80x24.org>; Fri,  7 Oct 2016 18:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbcJGSQp (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 14:16:45 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36809 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbcJGSQf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:16:35 -0400
Received: by mail-qk0-f182.google.com with SMTP id o68so50047970qkf.3
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IlnxiVdcEYFyKC5OQ78qm9ecgEdj1RDphwmJTfJqg7E=;
        b=NF/0Puf4n1QRv+ecmEV3ZVYQy6sblMGDxS3Ai4hGe8E3rw9sLEbxQAXYL3MXi5pL4q
         sQyZRzQ4s+73BeNKlh+6rWx/unzZ+/dZy35DbKUdIjmkOc0wdvpmsQJnFo1uJrpZIVyS
         haGUO8z7wuR6ha2fCrmjoNyC3a5dbVLbcyXcqeVmVaulhIimYmBOcHJ/ZS83iXtX96OT
         PJM/m0c842y3BFdaZbouCP3qH0QjVqTI+dMU17BeH0epw0Y1qCyUKKXSdY0shes0JDjC
         Unwq1YSSQEUzuvRH3HRIEUJUBijysbANzu6qG0GF4ZJvbmu5kEebeNaayUwB/yfFbAPF
         VnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IlnxiVdcEYFyKC5OQ78qm9ecgEdj1RDphwmJTfJqg7E=;
        b=MYYxaURmpsi01tAwohoN2JlixhcJ6IFbhe+A8jgIYN9s3A+yjqDIoHYZnd7REHWr00
         WgEgzma+TBOQM+nr8VgVIDBj4RAILoBQJd9+m2MC+dwPBc6yAAYZI1mT+yX4Bs5r7ut6
         ESAkx2gphVRq+aM+NjXTh3KzEX0hQWH7Efbu6hAEUFsab+pbzrpFskc5wj1+lV5MUVmR
         3khXF7ooizum0DHtdefWdZEPGUE9LmJ7R6hRoA7OTE44nfV28fPya0yMlS10m4ebtb6a
         IFStBcJSXDPTssS/2n5WWCC/AVy0f+nHa9Bax2cj1R26Qo8x0UTsumCXUtsGS4xNH+W3
         qz3w==
X-Gm-Message-State: AA6/9Rl2VV5aiR2br3I4pucuAIaszIcslvi0wNvRyBjPxDiqtGHkVFb44ALEev05h7nKuQwUtJNpp4bhRiYmNqzM
X-Received: by 10.55.45.193 with SMTP id t184mr17837984qkh.58.1475864192057;
 Fri, 07 Oct 2016 11:16:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Fri, 7 Oct 2016 11:16:31 -0700 (PDT)
In-Reply-To: <81bdbf6a1295c17c1b9233c91da6e5eb4583785e.1475851621.git.hvoigt@hvoigt.net>
References: <cover.1475851621.git.hvoigt@hvoigt.net> <81bdbf6a1295c17c1b9233c91da6e5eb4583785e.1475851621.git.hvoigt@hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Oct 2016 11:16:31 -0700
Message-ID: <CAGZ79kZ5CPTuW2fARDs3BUt89b8H_=P3otZv+Vm5nTV70NLWtg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] serialize collection of refs that contain
 submodule changes
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2016 at 8:06 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> We are iterating over each pushed ref and want to check whether it
> contains changes to submodules. Instead of immediately checking each ref
> lets first collect them and then do the check for all of them in one
> revision walk.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  submodule.c | 36 +++++++++++++++++++++---------------
>  submodule.h |  5 +++--
>  transport.c | 29 +++++++++++++++++++++--------
>  3 files changed, 45 insertions(+), 25 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 59c9d15905..5044afc2f8 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -522,6 +522,13 @@ static int has_remote(const char *refname, const struct object_id *oid,
>         return 1;
>  }
>
> +static int append_hash_to_argv(const unsigned char sha1[20], void *data)
> +{
> +       struct argv_array *argv = (struct argv_array *) data;
> +       argv_array_push(argv, sha1_to_hex(sha1));

Nit of the day:
When using the struct child-process, we have the oldstyle argv NULL
terminated array as
well as the new style args argv_array. So in that context we'd prefer
`args` as a name for
argv_array as that helps to distinguish from the old array type.
Here however `argv` seems to be a reasonable name, in fact whenever we
do not deal with
child processes, we seem to not like the `args` name:

    $ git grep argv_array |wc -l
    577
    $ git grep argv_array |grep args |wc -l
    293

The rest looks good to me. :)
