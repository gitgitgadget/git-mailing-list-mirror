Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 310D81F453
	for <e@80x24.org>; Mon, 29 Apr 2019 12:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfD2Msz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 08:48:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38863 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbfD2Msy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 08:48:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so11661199qth.5
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=clRl/Qdsj6BTWxIDMOdnuc2FXTDNuaOm73J50Gzrgvw=;
        b=mQoNpbD9sFs1XlTyYO/aKfM/1aze1J80e1PjvYXf3D+plLj/UAbDCkh6CoV3jmaCOE
         52GYo5gLM3ZACddAqO66xYkdvH9dkEZ7HUWFinhJi1KmFJmHvJckD/0Nfn64pnp/vAam
         3bgUiKtSMMexQIwV+GR+tg5XEjvVhcdShPwkf0ug9VQz2vPSfJ44iCQ2Oxxg4WmyhSN9
         104GEEQYmWCnpu5Pk7FsRo6zCEgWspeMmfqpZO/g5jVkmhZFKg1b+tVg5r7QGoaYCvYZ
         lIqrLQaFnQT557NZ4VY5yK71zq4rpUJaZLo2cFMu1qBP+c1RJy+n7J+m/4k9FhJlw0Sd
         HqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=clRl/Qdsj6BTWxIDMOdnuc2FXTDNuaOm73J50Gzrgvw=;
        b=qowIdcQEkGYktcRoJdnI/dzpRoU5Pecg4Nsco0FNnmSAXhS8EZM72fb/pc3Qa9xEsR
         NluKXhdCUkMnAlQQrRw1p9ZmxGnSptNK8wX10mPGdoJdiY3r+0GkvcBYijHjXVpRgMuU
         7e3wlwvQwf1xq6XuhQ2I1VlU0J/EK1vKm9IKjucsbGAJokZVLnQE/kSImpM+mMNBl1z/
         mDc11+vwPbnjscoQn92LVGwYox0V8Ligzm4fVONcdhJSE74Tey6rMyFyCAvqQW9CMsn/
         rHjqfjgIxFdurtb/+j7KguTIhssZRvy1L10STV1x4XoyOWWtwk9xvlPjMNeM3q4XGjFo
         +5sw==
X-Gm-Message-State: APjAAAXpqzNhuqyqLQ7vv6id5YCMggFFi0bzgMsQfN0t7B5zWkbOCNB7
        qummbNH5mKpQiuMDifpDOx4=
X-Google-Smtp-Source: APXvYqwjKEqp1e/CfSVE/A8wRj9yqHTHnh2yucen0NafBNVGREhclSkT1Wj7w4iq9V0jnRhxBIw9+g==
X-Received: by 2002:a0c:9e9a:: with SMTP id r26mr47411540qvd.57.1556542133605;
        Mon, 29 Apr 2019 05:48:53 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:44d4:80ba:e568:f586? ([2001:4898:8010:0:2e0a:80ba:e568:f586])
        by smtp.gmail.com with ESMTPSA id r4sm10440370qkb.20.2019.04.29.05.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 05:48:52 -0700 (PDT)
Subject: Re: [PATCH v3 4/8] commit-graph: don't early exit(1) on e.g. "git
 status"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20190314214740.23360-1-avarab@gmail.com>
 <20190325120834.15529-5-avarab@gmail.com>
 <87y33vr41k.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3518ad3e-bc4a-c2c3-d4bd-c87f9e828b1c@gmail.com>
Date:   Mon, 29 Apr 2019 08:48:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <87y33vr41k.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/27/2019 9:06 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> There's still cases left where we'll exit early, e.g. if you do:
> 
>     $ git diff -U1
>     diff --git a/commit-graph.c b/commit-graph.c
>     index 66865acbd7..63773764ce 100644
>     --- a/commit-graph.c
>     +++ b/commit-graph.c
>     @@ -1074,3 +1074,3 @@ void write_commit_graph(const char *obj_dir,
>             chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
>     -       chunk_offsets[2] = chunk_offsets[1] + hashsz * commits.nr;
>     +       chunk_offsets[2] = chunk_offsets[0] + hashsz * commits.nr;
>             chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * commits.nr;
> 
> Which is obviously bad, but something I encounterd while hacking up [1]
> we'll still hard die as before this patch on:
> 
>     $ git status
>     fatal: invalid parent position 1734910766
>     $

I really appreciate you digging in deep into these kinds of issues. You
seem to be hitting corrupted commit-graph files more often than we are
(in VFS for Git world). However, we should be _very careful_ when turning
some of these errors to warnings. At the very least, we should do some
high-level planning for how to handle this case.

The biggest issue is that we have some logic that is run after a call to
generation_numbers_enabled(), such as the `git rev-list --topo-order`
logic, that relies on the commit-graph for correctness. If we output a
warning and then stop using the commit-graph, then we will start having
commits with finite generation pointing to commits with infinite generation.

Perhaps, with some care, we can alert the algorithm to change the "minimum
generation" that limits how far we dequeue the priority-queue. Changing it
to zero will cause the algorithm to behave like the old algorithm.

But, having an algorithm that usually takes 0.1 seconds suddenly take 10+
seconds also violates some expectations.

Q: How should we handle a detectably-invalid commit-graph?

I think most of your patches have done a good job so far of detecting
an invalid header, and responding by ignoring the commit-graph. This case
of a detectable error in the chunk data itself is not something we can
check on the first load without serious performance issues.

I hope we can decide on a good solution.

Thanks,
-Stolee
