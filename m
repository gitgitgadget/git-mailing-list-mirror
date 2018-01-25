Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251EF1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeAYXfY (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:35:24 -0500
Received: from mail-yb0-f178.google.com ([209.85.213.178]:44739 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeAYXfY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:35:24 -0500
Received: by mail-yb0-f178.google.com with SMTP id z90so3717320ybh.11
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PV8Bw124Rqiv5/wBY58S/t4XJGgWUf17HnDhM2pZXxc=;
        b=V6mXAGinmpy3TFO7UOusRisMuZss7n4R8D7Y669SYKEtN5Zjh19rGfsAwGbjONafoV
         RtLDhfgT2T3S9zEvoEp8G8C9AiZt6VEavy2MRKX9jy+cOoC6tOfnkQ5sSI4n3HSuCF4w
         8BQj/PZr/fCpdaS4yBtUh8HOyYpgwWa7KT/2/Xj2Oy9KuA4KS2OJtxkNJoIwwWuLESvi
         qeqB30s5WpB+AYuB4sSETE/wHusV5H7kz6JssXiyBQIZyFHgBIh6A6/c/kWwYUZzGN1C
         lNF2zlx4RLIFAshcAS7O+xQok1ZlEe6lcMFWPm7+A/i7ZNcfk2XJsNyRy0+pax4z2SI6
         Dfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PV8Bw124Rqiv5/wBY58S/t4XJGgWUf17HnDhM2pZXxc=;
        b=oJoyFFaX84KWGyRNfw1HeUBxEZw/30O/8cH2XfiQ7uzlLHnqRxwx0GVxD98Y1vPB6C
         c0YQ5U7UVWQt5yra4EIBaojooO1M7G0Z9J+k3s/dKBL8mKExyjfcssajozOxyzKBeXRW
         tepozm9vcrEfmKi0i9IowYuBvTltSFOJit6PaSIZ3/AQFGWnz5x5hNByZvFAcMjsqo5v
         qq2rTc9IhauNTnfg1+Q2/jmH9jsbVSw6OBPFbGhN+4o6gjUK6t519iFwSPJ05a6Zv3e/
         N+k0Ey4ufOI0llOZAckJiM5CW9KROOzAQfVPagp6QtZol1Grl/MW3RhMFL4NRi8ZgdQ3
         LsqA==
X-Gm-Message-State: AKwxytcQpKM79HLqpn9s4HLf4bIZ8FT/wAufuq5q31xckomNmc0m5HsK
        m/BcwTlQpjo5K44XCxvfFM3B/zx6xYa3DNdOQIS4xg==
X-Google-Smtp-Source: AH8x226mtNFRhtEE+yOh34MMmY7WIcWqAMN2vyM1rXeYEjkRI7QR+FFCX6+FfBTqCPjc80mF5wE0B1yc8N/1XHiuK/A=
X-Received: by 10.37.34.8 with SMTP id i8mr9941099ybi.114.1516923323304; Thu,
 25 Jan 2018 15:35:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.210.209 with HTTP; Thu, 25 Jan 2018 15:35:22 -0800 (PST)
In-Reply-To: <20180125140231.65604-10-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com> <20180125140231.65604-10-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Jan 2018 15:35:22 -0800
Message-ID: <CAGZ79kY9GD+ZiFCmAfUsJOqYOQg_a8FUzCiKwVST-_oLUPSnHg@mail.gmail.com>
Subject: Re: [PATCH 09/14] packed-graph: implement git-graph --clear
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
> Teach Git to delete the current 'graph_head' file and the packed graph
> it references. This is a good safety valve if somehow the file is
> corrupted and needs to be recalculated. Since the packed graph is a
> summary of contents already in the ODB, it can be regenerated.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>


>  static int graph_read(void)
>  {
>         struct object_id graph_oid;
> @@ -105,6 +130,8 @@ int cmd_graph(int argc, const char **argv, const char *prefix)
>                 { OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
>                         N_("dir"),
>                         N_("The pack directory to store the graph") },
> +               OPT_BOOL('c', "clear", &opts.clear,
> +                       N_("clear graph file and graph-head")),

Given the docs building up a large list of "Cannot be combined with",
maybe these OPT_BOOLS want to be OPT_CMDMODE ?
