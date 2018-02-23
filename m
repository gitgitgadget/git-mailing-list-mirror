Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DDA1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 17:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeBWRn1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 12:43:27 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:39264 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeBWRn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 12:43:26 -0500
Received: by mail-qk0-f178.google.com with SMTP id z197so11699714qkb.6
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 09:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4kHmJUr8TV6jz7c88yH35ptmbGjy85Qfab5YJfpTUAU=;
        b=D/kaVmVzVV2Ypa6ZyTogGRXeTDQWK0YyGhe21f4fZFwg0fvHcpHC2AKs7GjUI3u6M3
         H5ue36qODCJv9iTQT0lp7Q1s+Alcl/UrhWbkuqFpRegugG3KnrhYe7ywThfzE1zqmqtl
         ElPcC8zd9uj5YMK8YjjgGV8KqzsaAB2Kb65PC1YfaJ59JrDRFnF9PTAHxUrpVoGaWnlM
         QiDHbL67Dla15Zm0QO0iDDR99yq5S6S/d2TLn9z+W9+qlx3mzyNpT7nyia0tyw70IIMa
         qi1NLA45rdOfIp2HIXSYWJA8+g5mdWF4hFg8jAbxaBJZMyS19ah5b1p3peu2lXx8b40L
         M3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4kHmJUr8TV6jz7c88yH35ptmbGjy85Qfab5YJfpTUAU=;
        b=EQvMdvJKiSWvTiCGSAQsPV0fBX7dV2Ve0CfSQKXPQwe+HmBNA2nC3yZriJVhP9D5Zt
         ToD0GM+RvjUPFT59rW40Dfe0+z1gF6NLAx2un7M2bNWDsDTfdzjLyaR6JBT2USGWZmzU
         uonqWp6m+Y2FBnbL2Hp/vH+7kk1f8CIlFhUXS5Smd5VhzvQeNFF5wr1+h4o+isaWR7ps
         5/advEQqxCG3uXe8yYeM+hNkM7NbrFTgXHgF5vGfAoMey5AQvFeupF5KWI0k+2KTnDuf
         rII0ruTJ2VCH/9W55kWP/S+ES3WDw3qGryR1MfGSeo4SPu8IoEPOjY+TjQwGZmp80kwk
         DI+g==
X-Gm-Message-State: APf1xPD2rM5DBUq08FGJRp/E2FqBGx9PE/OS2GNa/XFaQGTqLZ4QdsGp
        ehn+/j1FdgnY4LMlbSAGlAo=
X-Google-Smtp-Source: AG47ELv4y0VwC8lPuEN5D5UN9FoSKEnlefmHf8ExMJPYXiGDhYKoKdpGV3zuyraP3pAKbMzsm1FmVA==
X-Received: by 10.55.76.206 with SMTP id z197mr3535942qka.143.1519407805847;
        Fri, 23 Feb 2018 09:43:25 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id p4sm1658943qtd.55.2018.02.23.09.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 09:43:24 -0800 (PST)
Subject: Re: [PATCH v4 08/13] commit-graph: implement --delete-expired
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <1519066406-81663-9-git-send-email-dstolee@microsoft.com>
 <CAGZ79kai=KegG-XPmtZJRhTcD-M5Edsw8eocje41mdbL-RARAA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <deac2f34-d3c3-b17d-e7f0-b1c044c0d3ff@gmail.com>
Date:   Fri, 23 Feb 2018 12:43:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kai=KegG-XPmtZJRhTcD-M5Edsw8eocje41mdbL-RARAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/21/2018 4:34 PM, Stefan Beller wrote:
> On Mon, Feb 19, 2018 at 10:53 AM, Derrick Stolee <stolee@gmail.com> wrote:
>
>>          graph_name = write_commit_graph(opts.obj_dir);
>>
>>          if (graph_name) {
>>                  if (opts.set_latest)
>>                          set_latest_file(opts.obj_dir, graph_name);
>>
>> +               if (opts.delete_expired)
>> +                       do_delete_expired(opts.obj_dir,
>> +                                         old_graph_name,
>> +                                         graph_name);
>> +
> So this only allows to delete expired things and setting the latest
> when writing a new graph. Would we ever envision a user to produce
> a new graph (e.g. via obtaining a graph that they got from a server) and
> then manually rerouting the latest to that new graph file without writing
> that graph file in the same process? The same for expired.
>
> I guess these operations are just available via editing the
> latest or deleting files manually, which slightly contradicts
> e.g. "git update-ref", which in olden times was just a fancy way
> of rewriting the refs file manually. (though it claims to be less
> prone to errors as it takes lock files)

I imagine these alternatives for placing a new, latest commit graph file 
would want Git to handle rewriting the "graph-latest" file. Given such a 
use case, we could consider extending the 'commit-graph' interface, but 
I don't want to plan for it now.

>
>>   extern char *get_graph_latest_filename(const char *obj_dir);
>> +extern char *get_graph_latest_contents(const char *obj_dir);
> Did
> https://public-inbox.org/git/20180208213806.GA6381@sigill.intra.peff.net/
> ever make it into tree? (It is sort of new, but I feel we'd want to
> strive for consistency in the code base, eventually.)

Thank you for the reminder. I've removed the externs from 'commit-graph.h'.

Should I also remove the externs from other methods I introduce even 
though their surrounding definitions include 'extern'?

Thanks,
-Stolee
