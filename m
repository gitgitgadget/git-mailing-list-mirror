Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C084B1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 12:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeJKUBD (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 16:01:03 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:39113 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJKUBD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 16:01:03 -0400
Received: by mail-qk1-f176.google.com with SMTP id q5-v6so5271926qki.6
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ibr2U5VzDzz+zyU45Im1KdoDKDt7sYiYbyLKWMzOfNE=;
        b=Orgiq3/y6G+DxDJrI+b8QJ43ZLl08JfBkcuUtnTsf2FOKhoEdqE5WENNz/b/fzqzYR
         MJrflGUlFfGi5CKoZueL84+q7nxvpGj+zM8Olqw/hcU/qRrgGmCJK2RCYOUIUEMCGzoB
         T1cx4d3We0pgNPC8D+WqmH5Nz1iQlzHzKdWm5OXNTrvN6PrugE4gjdee68dKM1UvtYqS
         x+vazuTXhczW7Jy92TutlRsJ9MqwgZ23JYEnZyocQzectCPdxiTz9+swJVjvHrK6q6Am
         Ii1a9QyrqiCKsABQoYTfrDmqL7Nk7oaoW/83xmSbrWYT2AeGp2g4IHyY9Tdn3k6WnY7L
         wD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ibr2U5VzDzz+zyU45Im1KdoDKDt7sYiYbyLKWMzOfNE=;
        b=fuRcRMe1D8BJFbMUKcnEEuOdo2ezrrNHOv2e5kKyfdDsd8dAfTeCYhefi3Ct1YB1/7
         iYxU/BHKJsxMheRCSSGnvEBfnd4mzG7urBeaNf7sBzI7NSLMdgAO8sftZ6WSHPf8hojG
         TQucEf5rSRvYeA778QqWB08jWgIYojSgTNTVvW7q5TfdTjATZtEMzl9pnilYNpfqEilT
         RmKIGyo+JizalX8kjooOR47Da9vUPgFIaD+/4UEkDJpBgNChy1DxrD9F+iFI662cjxoB
         yzlLwmk3/bhNsSYuX86jaa2UJJq3vT07SvK0h6dCOLH/xjeLZMW0K5PqRWiXhjarDDVZ
         jxHQ==
X-Gm-Message-State: ABuFfoixptZMXRkFjsRI1kBDJsFltYKD+wB+IoB2W1RcjYwW9vk+bN3N
        4nQMjuzFMoy/QEGzHupn7qk=
X-Google-Smtp-Source: ACcGV61WDAg4ncbP2siHKEOzPEoG33Lbn6JZV8KA9h68/mIfp/C/DH5GCQ4fhY29ojtM3Tq2IMN+cA==
X-Received: by 2002:a37:ae86:: with SMTP id x128-v6mr1220502qke.282.1539261242019;
        Thu, 11 Oct 2018 05:34:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:60fa:c2a9:b517:a087? ([2001:4898:8010:0:4a30:c2a9:b517:a087])
        by smtp.gmail.com with ESMTPSA id d12-v6sm10237986qte.75.2018.10.11.05.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 05:34:00 -0700 (PDT)
Subject: Re: Bloom Filters
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
References: <20181003191805.GB16666@sigill.intra.peff.net>
 <20181008164141.GZ23446@szeder.dev>
 <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181008181015.GA23446@szeder.dev>
 <9ad5f166-f7c5-de79-0f86-f1f952cd33d2@gmail.com>
 <20181009030803.GA6250@sigill.intra.peff.net>
 <f877020c-3098-e4c4-ad64-cca57f764b91@gmail.com>
 <20181009184647.GA7014@sigill.intra.peff.net>
 <ec3ca377-0434-322e-4ab9-49e27f96f4af@gmail.com>
 <20181009211449.GB9563@sigill.intra.peff.net>
 <20181009231250.GA19342@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bcf5586e-d0b0-e5e2-0dff-fb4606ff91c4@gmail.com>
Date:   Thu, 11 Oct 2018 08:33:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009231250.GA19342@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2018 7:12 PM, Jeff King wrote:
> On Tue, Oct 09, 2018 at 05:14:50PM -0400, Jeff King wrote:
>
>> Hmph. It really sounds like we could do better with a custom RLE
>> solution. But that makes me feel like I'm missing something, because
>> surely I can't invent something better than the state of the art in a
>> simple thought experiment, right?
>>
>> I know what I'm proposing would be quite bad for random access, but my
>> impression is that EWAH is the same. For the scale of bitmaps we're
>> talking about, I think linear/streaming access through the bitmap would
>> be OK.
> Thinking on it more, what I was missing is that for truly dense random
> bitmaps, this will perform much worse. Because it will use a byte to say
> "there's one 1", rather than a bit.
>
> But I think it does OK in practice for the very sparse bitmaps we tend
> to see in this application.  I was able to generate a complete output
> that can reproduce "log --name-status -t" for linux.git in 32MB. But:
>
>    - 15MB of that is commit sha1s, which will be stored elsewhere in a
>      "real" system
>
>    - 5MB of that is path list (which should shrink by a factor of 10 with
>      prefix compression, and is really a function of a tree size less
>      than history depth)
>
> So the per-commit cost is not too bad. That's still not counting merges,
> though, which would add another 10-15% (or maybe more; their bitmaps are
> less sparse).
>
> I don't know if this is a fruitful path at all or not. I was mostly just
> satisfying my own curiosity on the bitmap encoding question. But I'll
> post the patches, just to show my work. The first one is the same
> initial proof of concept I showed earlier.
>
>    [1/3]: initial tree-bitmap proof of concept
>    [2/3]: test-tree-bitmap: add "dump" mode
>    [3/3]: test-tree-bitmap: replace ewah with custom rle encoding
>
>   Makefile                    |   1 +
>   t/helper/test-tree-bitmap.c | 344 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 345 insertions(+)
>   create mode 100644 t/helper/test-tree-bitmap.c
I'm trying to test this out myself, and am having trouble reverse 
engineering how I'm supposed to test it.

Looks like running "t/helper/test-tree-bitmap gen" will output a lot of 
binary data. Where should I store that? Does any file work?

Is this series just for the storage costs, assuming that we would 
replace all TREESAME checks with a query into this database? Or do you 
have a way to test how much this would improve a "git log -- <path>" query?

Thanks,
-Stolee
