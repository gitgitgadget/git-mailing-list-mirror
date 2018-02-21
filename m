Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DFDE1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 21:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751158AbeBUVex (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 16:34:53 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:44471 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeBUVew (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 16:34:52 -0500
Received: by mail-yw0-f182.google.com with SMTP id x197so754458ywg.11
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 13:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9W8SRQ2HK/74ugjg2zBog+nyKnFwh3Pc2nj2FljTFzQ=;
        b=Y72VdNd4oLG31xDdlqGPfehXJGW5fJwiZe8yRKjsGqD/WObmAfrQLj8Rhb9184xclL
         lBVC1h+QcgI1Vtyb4hA1bO2sfgeIl9puZJU4wgn47G5lBLRCyHSm/ytXdPjl2NQehcWb
         hecF5itBQtF+z6mjQNYAOlab1hG/sZPr3It4HachyERq4XV1aqDtx2Ya/exTykZRgmvN
         87Y2bfhWE7tD7q1HCwsH8fzSAeVZPwxbe/qncLDD7CX06exqFEg6Swgxx4y8LyxXfqaT
         DQQ8iCbB8J7LsQH3b8onOT/1RdbyQ2RtaoKkBk46c6WBX2R83A0KYaXjfmGEUrkXujAd
         A1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9W8SRQ2HK/74ugjg2zBog+nyKnFwh3Pc2nj2FljTFzQ=;
        b=g1FW9tA2svw+MQ8LBUJ9LjcdeJzcI4i/VBfySBqwfwdRhhP/+AJlvnWCkEx6X9YVM2
         Qix9oVsz8XVukRsCjbY2lft5ZPS6uBrf2EVSD9ZeTqCRMW+OYdGa6LfWrvkaVBC3f8Sf
         jTloPujTOU1DFOBIz1MjYu2WkxIFAXNnc91GSilqzWK7MQgFEQLNch/iXZLROYu95eQM
         gBCJTYhMTaSkzsT0Wkhq+88uF+qN90TjBM97t6BNViZbc9ybg9AQgFV/rDY6gdSXqIK7
         mmQEt3XrzeFXjlujjPJ2+LWO7Z9I60fgdUfBkhMP3UcZULWuLkJZUyBQeFMVPLIiF7mv
         JfpQ==
X-Gm-Message-State: APf1xPBmWQmjZXkEF83TzA5zhQlqtb4KNnnsIpy2CGQD4HVl6fWLkacN
        /e0/eQcFO5S3qgxIzbozfznd8rujMMiXtbdZUSB83w==
X-Google-Smtp-Source: AH8x225gDFBbAX2vsVc2mAJZ1cpq4m7WQCXmVpIXk9yJ5HRIRQDi/4w3SLVM+a4B2kATScMzFADGXUU0W/NpciaJTaY=
X-Received: by 10.13.237.70 with SMTP id w67mr3348975ywe.414.1519248891270;
 Wed, 21 Feb 2018 13:34:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 21 Feb 2018 13:34:50
 -0800 (PST)
In-Reply-To: <1519066406-81663-9-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com> <1519066406-81663-9-git-send-email-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Feb 2018 13:34:50 -0800
Message-ID: <CAGZ79kai=KegG-XPmtZJRhTcD-M5Edsw8eocje41mdbL-RARAA@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] commit-graph: implement --delete-expired
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 10:53 AM, Derrick Stolee <stolee@gmail.com> wrote:

>         graph_name = write_commit_graph(opts.obj_dir);
>
>         if (graph_name) {
>                 if (opts.set_latest)
>                         set_latest_file(opts.obj_dir, graph_name);
>
> +               if (opts.delete_expired)
> +                       do_delete_expired(opts.obj_dir,
> +                                         old_graph_name,
> +                                         graph_name);
> +

So this only allows to delete expired things and setting the latest
when writing a new graph. Would we ever envision a user to produce
a new graph (e.g. via obtaining a graph that they got from a server) and
then manually rerouting the latest to that new graph file without writing
that graph file in the same process? The same for expired.

I guess these operations are just available via editing the
latest or deleting files manually, which slightly contradicts
e.g. "git update-ref", which in olden times was just a fancy way
of rewriting the refs file manually. (though it claims to be less
prone to errors as it takes lock files)

>
>  extern char *get_graph_latest_filename(const char *obj_dir);
> +extern char *get_graph_latest_contents(const char *obj_dir);

Did
https://public-inbox.org/git/20180208213806.GA6381@sigill.intra.peff.net/
ever make it into tree? (It is sort of new, but I feel we'd want to
strive for consistency in the code base, eventually.)
