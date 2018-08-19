Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 467361F954
	for <e@80x24.org>; Sun, 19 Aug 2018 11:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeHSOgQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 10:36:16 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40961 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeHSOgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 10:36:16 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so10373650iob.8
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 04:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlKx0oJ5mBzkl6mxGYf/EwDh73eyhLtMzjmDFfankRs=;
        b=afI5/W3oGZ46bN/Ljqh8A9DMcvYO95ZuLg0GjravdD3TFAIjBvoUQSFcAN809FmEPh
         nLCOcpSJZRRrcJBQpSN9jvesB3dBAJ3EaSuLWrd34YmfwkuSdq1n06RV+uiKP0dVe61m
         I2EAqXFChCaM7ZoClp6cUvdrTbdPP+mylgcyW0cc8ww9oL1Q1zqqiKjDKOFlCZwQSyZA
         UzoUX06ZUG/P3VycfsVd5bAIjvxLHTkUMq1XIbI62JhLrBE9ZquTyQ6icBKIEp9o/65K
         7VOSsL5cT/1lt5PhK1Vh3U3rIJUS048WQBqIirhr9JuIHv+fU+g5ARSl7hVLXBe42gMk
         uP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlKx0oJ5mBzkl6mxGYf/EwDh73eyhLtMzjmDFfankRs=;
        b=Q/+FrnSFToh5zizlM65oFSYvJgnVL26OzvAXaCl7haooGXxClWKRiH2YtJnAvm7QZ6
         ip1oOd6oJ09sxM6LFWJ7+GH+oV6JZn+cBnAkhYUkYvRCHaLl1qS7TZpayzjCx2yZsntY
         7iA7CF4utaMeeBs04EEY35BBWLrnaBbFb4NIc86Vsuy+wuknDfyvSVyNptbnennnhhGo
         ZMei+XJ40A3toUFYWZkL1p8oFQixgJAf79MyMGFXveY2Fc3VwTWGwLYORCS2ccwuTFxb
         j4UoegXlUNC/Wt7SJp8UY3eXc3yTxeVjnOv/zKSeqd0A3pMRT2Mhc5Nfe044cJ7SvmYr
         6UyQ==
X-Gm-Message-State: APzg51A6lDByHFOGFXFO9kzBdw3Yfj5Ms4tbL2MA+k3rxQ9HnbFyXv4s
        9ktJNUznOlklGGC/CbXIyx4s7KnBgyCZI+w9Juw=
X-Google-Smtp-Source: ANB0VdaWDIFGV9Ogzo9QUwrTsErZoLMDzA59Ng1D0GieNChAjVlqqEnkPuWzRyFoq/dYAFOAHkez07MW6FPJ5XD34Hg=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr1386209iok.236.1534677907580;
 Sun, 19 Aug 2018 04:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20171208155851.855-1-git@jeffhostetler.com> <20171208155851.855-10-git@jeffhostetler.com>
In-Reply-To: <20171208155851.855-10-git@jeffhostetler.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 19 Aug 2018 13:24:41 +0200
Message-ID: <CACsJy8D3nC+fXFYMKWh6AStbMVOVfmcAvAT9tBqtG9K6r043eQ@mail.gmail.com>
Subject: Re: [PATCH v7 09/16] fetch: support filters
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 8, 2017 at 5:00 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach fetch to support filters. This is only allowed for the remote
> configured in extensions.partialcloneremote.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/fetch.c       | 23 +++++++++++++++++++++--
>  connected.c           |  2 ++
>  remote-curl.c         |  6 ++++++
>  t/t5500-fetch-pack.sh | 36 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 1b1f039..14aab71 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -18,6 +18,7 @@
>  #include "argv-array.h"
>  #include "utf8.h"
>  #include "packfile.h"
> +#include "list-objects-filter-options.h"
>
>  static const char * const builtin_fetch_usage[] = {
>         N_("git fetch [<options>] [<repository> [<refspec>...]]"),
> @@ -55,6 +56,7 @@ static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
>  static int shown_url = 0;
>  static int refmap_alloc, refmap_nr;
>  static const char **refmap_array;
> +static struct list_objects_filter_options filter_options;
>
>  static int git_fetch_config(const char *k, const char *v, void *cb)
>  {
> @@ -160,6 +162,7 @@ static struct option builtin_fetch_options[] = {
>                         TRANSPORT_FAMILY_IPV4),
>         OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
>                         TRANSPORT_FAMILY_IPV6),
> +       OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),

Documentation is missing. Please add something to git-fetch.txt (or
fetch-options.txt) about this option. I would make a patch but I don't
know enough about this to write and I'm in the middle of something
else.
-- 
Duy
