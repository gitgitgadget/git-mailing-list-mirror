Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA0520401
	for <e@80x24.org>; Fri, 16 Jun 2017 05:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751922AbdFPFaC (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 01:30:02 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34259 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdFPFaB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 01:30:01 -0400
Received: by mail-pf0-f175.google.com with SMTP id s66so17775091pfs.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 22:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0dInJoNzwcQS8X1JVsp+mQ6b20jxbTyt0cxvoXNNXRQ=;
        b=A3DFrrJZVZ4JdRHY4+mFtYDGE3KF5/PvnaaeTUZpijTyS5U0mAz+wD7EyEXdk2pNwJ
         Ne/tVg/g8BkJxNIJtNKNh7+LrKHkxr9d/pOhusXvCr6mz/6wC99a4S7oTjm8O5N22vX7
         caa1gWZiHo+qFifRFjF9lTbfgSRppnf+wY46V/EMIAI6sZYFOCb0OR7CibYFZLn0H7dv
         ZeDX3jKbmSYtsdhqa7UOf7vi8aqQDxTr+bohzBEM+JIji+4z5KdQcPf4VHbFosKwgyHN
         PICfRSeRvbkn/rGyY4MyzacnMiZbIMvF4xYlGja4cnlbPSVk/HCauo0cVB5JdMJUS0rn
         e38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0dInJoNzwcQS8X1JVsp+mQ6b20jxbTyt0cxvoXNNXRQ=;
        b=ni2HR4ut5/8IFRNVdbiOxm1lIILy4MqUxndd8zgp4wweFXNAmvbaQj3gy+bPQwWy/Q
         7UkO7PdSbHCDiHsZg2/z8wUnV0COVblySr3VHkf8HLxh4YFRPo4oFkKCsWgjOBbP6hMP
         Ux8KxUea4dGlF6Uuf3S5Oz/7PhQS8WaLWYPRom9ALYB5l2hFZub+fy0A64PLY5vxqXvI
         12V9E7whODsPXDkqGz4QXmDO5bQ0OhVMh2ay2ej82WNWWEqOBNbIj8dQ3Nw/RXbt2BN6
         P4RtrEOt+XuHiWO8peHjsEgkgcITNxjh5AHYwrW7SOyQw3V1A7wPxWf3Bpb5dzPLOkT4
         Is0g==
X-Gm-Message-State: AKS2vOw9KIXUJgw3P2p07p5vJmTHBaNmrK9rv/K6dSNMHAf3MVeTpnOu
        L16/aQqI6sUdQiksuAT1SiPoC42wOX6y
X-Received: by 10.84.217.138 with SMTP id p10mr5729763pli.66.1497591000567;
 Thu, 15 Jun 2017 22:30:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Thu, 15 Jun 2017 22:30:00 -0700 (PDT)
In-Reply-To: <2aa91c07ef7f0f9c679aab8898341520eda76016.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu> <2aa91c07ef7f0f9c679aab8898341520eda76016.1497534157.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Jun 2017 22:30:00 -0700
Message-ID: <CAGZ79kYOtGc5p2bU5-oWCq60N87v4CbcdYjAurzirjRsyVdEwQ@mail.gmail.com>
Subject: Re: [PATCH 03/28] packed_ref_store: move `packed_refs_path` here
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 7:47 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Move `packed_refs_path` from `files_ref_store` to `packed_ref_store`,
> and rename it to `path` since its meaning is clear from its new
> context.
>
> Inline `files_packed_refs_path()`.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/files-backend.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 2efb71cee9..c4b8e2f63b 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -54,6 +54,9 @@ struct packed_ref_cache {
>  struct packed_ref_store {
>         unsigned int store_flags;
>
> +       /* The path of the "packed-refs" file: */
> +       char *path;
> +
>         /*
>          * A cache of the values read from the `packed-refs` file, if
>          * it might still be current; otherwise, NULL.
> @@ -61,11 +64,13 @@ struct packed_ref_store {
>         struct packed_ref_cache *cache;
>  };
>
> -static struct packed_ref_store *packed_ref_store_create(unsigned int store_flags)
> +static struct packed_ref_store *packed_ref_store_create(
> +               const char *path, unsigned int store_flags)
>  {
>         struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
>
>         refs->store_flags = store_flags;
> +       refs->path = xstrdup(path);

mental note: the destructor (if introduced later) has to
free the path.
