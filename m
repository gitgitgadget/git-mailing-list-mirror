Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8422070F
	for <e@80x24.org>; Mon, 19 Sep 2016 13:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758464AbcISNxG (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 09:53:06 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37006 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756134AbcISNxF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 09:53:05 -0400
Received: by mail-it0-f49.google.com with SMTP id 186so71138150itf.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PMZtPzQQqaLal7gGZY+A6mrlQf9TFo28Vxfrx5b+D2k=;
        b=ssYiBi4Wei1UJkw/fGB7Ib3Id76jVIpIlKzy+XgZdLByTSXWMOgt8rKuH1SUOI8Iei
         u4OfE+8xwOQt49Lsy2nTWjw3mms6Tp5o/FK9zFxz+IKOHRBzHX9neelFeNeSeMdXZPFU
         FblSA+0OnszbIrM3KsZnkG8nlgJVBftGg+M5TCwwk2yLbmwQMiEbZhsi34n2oCAfsGdD
         LR7WcFGQdrk92IWOzeB2b3LmJZxi+5rT96pstkDXsJC6GP1d5eqGtu6mg1bbiozzIaa2
         rXzA7BbH4vlAe7wMYVTl/RKE6xtV1zy9wgw3mBvMQ19Cr747yD6CsVJNk192KwR2lyRE
         hdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PMZtPzQQqaLal7gGZY+A6mrlQf9TFo28Vxfrx5b+D2k=;
        b=MWC/wb1FvWa5URxN07dUoh5f2bKt8LThFpOfpj7OT6GpfHWgaoH7opV95RDMndaaDA
         jBjqn/LndDwqPzJ1AXng6vJjnbU/uVhUp+5L9qs8ULL6tTiRivt3AdkLuSgbAAa4qcRU
         gzV0CoSDDUdozc6XeaI3pEsb3yzxYQSSZDIt5wvCkt2uAcGca6EPQJfFj7IIaHb6uSWn
         hl5i7zWhaQn0QTarszxV/09kRKkOPVKOz40rNqnz2vFcK1QkJGdLZB+ZTNp/TwWyHlFi
         YCeX3B2ZX7I4HRyqAIP3hlwA/D6NflGV+vZiAoHqVCXUmof2p9nbpwZv8iH0PA5LC1NL
         t2CQ==
X-Gm-Message-State: AE9vXwNzBJCaXU3L64rC8uhjXaIPRv5sLxBHrTJBD8WfrE925L86UmWDTtggQMJah2Zx8xqttStdDoJBU2xsNQ==
X-Received: by 10.36.20.204 with SMTP id 195mr11549315itg.83.1474293184772;
 Mon, 19 Sep 2016 06:53:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Mon, 19 Sep 2016 06:52:34 -0700 (PDT)
In-Reply-To: <1473984742-12516-5-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com> <1473984742-12516-5-git-send-email-kevin.m.wern@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Sep 2016 20:52:34 +0700
Message-ID: <CACsJy8C+0M8o15E+iVX+f=izO2CtK7U642NC=XXaG-g41wYAUg@mail.gmail.com>
Subject: Re: [PATCH 04/11] Resumable clone: add prime-clone to remote-curl
To:     Kevin Wern <kevin.m.wern@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 7:12 AM, Kevin Wern <kevin.m.wern@gmail.com> wrote:
> +static void prime_clone(void)
> +{
> +       char *result, *result_full, *line;
> +       size_t result_len;
> +       int err = 0, one_successful = 0;
> +
> +       if (request_service("git-prime-clone", &result_full, &result,
> +                       &result_len, HTTP_ERROR_GENTLE)) {
> +               while (line = packet_read_line_buf_gentle(&result, &result_len,
> +                                                         NULL)) {
> +                       char *space = strchr(line ,' ');
> +
> +                       // We will eventually support multiple resources, so
> +                       // always parse the whole message
> +                       if (err)
> +                               continue;
> +                       if (!space || strchr(space + 1, ' ')) {
> +                               if (options.verbosity > 1)
> +                                       fprintf(stderr, "prime clone "
> +                                               "protocol error: got '%s'\n",
> +                                               line);
> +                               printf("error\n");
> +                               err = 1;
> +                               continue;
> +                       }
> +
> +                       one_successful = 1;
> +                       printf("%s\n", line);

A brief overview for this service in
Documentation/technical/http-protocol.txt (and maybe
Documentation/gitremote-helpers.txt as well) would be great help. It's
a bit hard to follow because at this point I don't know anything about
the server side (and on top of that I was confused between http
send/receive vs transport send/receive, but this is my fault).

> +               }
> +               if (!one_successful && options.verbosity > 1)
> +                       fprintf(stderr, "did not get required components for "
> +                               "alternate resource\n");
> +       }
> +
> +       printf("\n");
> +       fflush(stdout);
> +       free(result_full);
> +}
-- 
Duy
