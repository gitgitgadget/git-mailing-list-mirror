Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF6220288
	for <e@80x24.org>; Tue, 18 Jul 2017 10:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbdGRKat (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 06:30:49 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:36589 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbdGRKas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 06:30:48 -0400
Received: by mail-qt0-f174.google.com with SMTP id 21so12010864qtx.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 03:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WcK1PRpy2z4LB3a0/I7V+OcXpBPUzWPAo0uYnZlYXaw=;
        b=lVHq4oe3VpK+SVUlCRKU0QlWBhB1vNkAIVY7enFTLebG3Uas64E0Id5yZUm+canlvK
         7kpk7iVhPk0ufARqUNUzcpPDA2sIPPbbNqLYAh98+9czyYaJ6dWZ1HqEBM/i/W8/5H26
         KUFHC4WLitQFgi6FF/C0ROkF1hgPHk5MF9MKBf2o/kEfMI6NX6I9F/3lZiwStlHGAqlH
         eRMpOtfFKpzC7JXDoUBIriuo+j9+KXvapbPsz+UeG2yGync/ILPajlPRzxaIucbmAk9p
         ee4n4TzcqghNvM+vGqb6lPasLlRv/uMJgv1zCse+2jZdGY79km4VTODFHiEdY6n80c3W
         ocdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WcK1PRpy2z4LB3a0/I7V+OcXpBPUzWPAo0uYnZlYXaw=;
        b=JDaZTuPTP8SbVn+F05oTorPG9dgfnq1QG97jSPheBMQWSnv+pLF/5+gCL70YWQGRTK
         P9T5jMgwytqRJMyv4LoRI9HqWex4wO7qCBTQCyGz7P6M1x4mieNu96WuELGgQCIfm9O4
         avBi2UPrxirEajxY//RCVqWZNW0aCra846OHtNJ8xoOmIK0EL2pji0g+ep6ilMpo7VWc
         ieUCa5Q+gpIH+ikZVpY5hOO7krA6v4NBChoSUmn2RLuspXA2TNoPfAfduZWXZXemL4jj
         S+NDASue+Qv10JKLAq0XHl1c3aHS49Pi9KOHkAGVa3ZA6uGglg5sgM56NAV4jSc9cPOO
         AReA==
X-Gm-Message-State: AIVw111095Uzf/tgTReZfcf29qQ/vsAn7VDVXf0JG1Y8RBo/6RiSEQA+
        DlsfrsbsAO1GoZj3qbelHTCLPeRy1w==
X-Received: by 10.237.62.157 with SMTP id n29mr1068318qtf.0.1500373847414;
 Tue, 18 Jul 2017 03:30:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Tue, 18 Jul 2017 03:30:46 -0700 (PDT)
In-Reply-To: <a4f04b3ec9cc1ba08a5dd7f459dce95411fb03e2.1498091579.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
 <cover.1498091579.git.jonathantanmy@google.com> <a4f04b3ec9cc1ba08a5dd7f459dce95411fb03e2.1498091579.git.jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 18 Jul 2017 12:30:46 +0200
Message-ID: <CAP8UFD24QVAuTXXH3zvR5zwZwub20o37uGyt8Uf+rRtjjk8QTA@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] sha1_file: refactor has_sha1_file_with_flags
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 2:40 AM, Jonathan Tan <jonathantanmy@google.com> wrote:

> diff --git a/sha1_file.c b/sha1_file.c
> index bf6b64ec8..778f01d92 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3494,18 +3494,10 @@ int has_sha1_pack(const unsigned char *sha1)
>
>  int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
>  {
> -       struct pack_entry e;
> -
>         if (!startup_info->have_repository)
>                 return 0;
> -       if (find_pack_entry(sha1, &e))
> -               return 1;
> -       if (has_loose_object(sha1))
> -               return 1;
> -       if (flags & HAS_SHA1_QUICK)
> -               return 0;
> -       reprepare_packed_git();
> -       return find_pack_entry(sha1, &e);
> +       return sha1_object_info_extended(sha1, NULL,
> +                                        flags | OBJECT_INFO_SKIP_CACHED) >= 0;
>  }

I am not sure if it could affect performance (in one way or another) a
lot or not but I just wanted to note that has_loose_object() calls
check_and_freshen() which calls access() on loose object files, while
sha1_object_info_extended() calls sha1_loose_object_info() which calls
stat_sha1_file() which calls lstat() on loose object files.

So depending on the relative performance of access() and lstat() there
could be a performance impact on repos that have a lot of loose object
files.
