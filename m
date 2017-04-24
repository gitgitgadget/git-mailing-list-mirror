Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099F0207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 22:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S978758AbdDXWR1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 18:17:27 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35510 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S978738AbdDXWRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 18:17:25 -0400
Received: by mail-pg0-f52.google.com with SMTP id 72so19003491pge.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 15:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=635+zc0wK1+VvpInlKoJumOOyQmoXbHHP2UpPOClm5c=;
        b=rOM5em/nD2rzwrtnIrXjDR6jZqX/DCwHBs3tfvnDhgoDcDwD2HmA5UnXqj735Hsd2R
         vJd/CgcWXJuPT4w+sp8z8aslvZqFTed3TiRQ+NasUUz3zMVqsaGQxapO6UzKkhGZdHFY
         FegKJVp8WYF/P4TgR/DfDBuN9so2qyZX4lFlWcRG1wh68QjLdKJENLhQApkvbLewxaWw
         PzrlTauRpipQt8eoW++VcV3OBOb7lQVEq7h/rm7JicX5X7lh9Gr08j8pnOHmM81k96L5
         f9BQkMJ7m6dHm+kkxDg4xXVyo77rXxkQ2KG7MhtvgTcwpvVBmo5fKNLdzXVD5f2PNxY+
         UWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=635+zc0wK1+VvpInlKoJumOOyQmoXbHHP2UpPOClm5c=;
        b=HMUnmrG+pOUJEeDuRyclHjIaGtwmBdZsd2ofidAB+h5K9u5dB6rf25U3LgaBLv2Avl
         QmIV9SXoUJTbskZnKNjJnQcP59lZsu3dctlCXS8OTuOCoCqDR4LZvd80jwfEWOKlR9VH
         PYC/yHX2U4ZDypMhDaqJliOHomI5QEtOTtYelyUFzVz4/pN1p5LXIZHOwN+hObjjml3T
         CT5lIWZKTc2b9roWmfhKS4wAPqzKZQrEPpi1C/TS2y3a7DHvHpPZSQzUUZWywOFXJRjL
         Tx4UWxt5EXm2UvYre7Ys0wcVpIH1bJCiBL4IJ3koPo0N2pX+dyHyI6Oqno8glnR4RVML
         g+eg==
X-Gm-Message-State: AN3rC/4wf7vN3skQgE+i5g0DmOJTip61EU/LIaio0YXIHbqKjHD6WZWh
        9otctRxujoUb+j2wutV3QZnecawplbAszJxSkw==
X-Received: by 10.84.232.133 with SMTP id i5mr27754245plk.172.1493072245085;
 Mon, 24 Apr 2017 15:17:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 24 Apr 2017 15:17:24 -0700 (PDT)
In-Reply-To: <efe8e82d-a021-5fc4-492a-e6e0ab7d52d3@ramsayjones.plus.com>
References: <CAGZ79kYmRe+NURkgxRQM2QsGQEqtp+oGas5H0ryfztx8s2chwA@mail.gmail.com>
 <20170422195804.18477-1-pc44800@gmail.com> <CAGZ79kb1CR3qKOzByFC_wy7+Fh7cofFT1urhA06RuBK_3vGKmg@mail.gmail.com>
 <efe8e82d-a021-5fc4-492a-e6e0ab7d52d3@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Apr 2017 15:17:24 -0700
Message-ID: <CAGZ79kbU4LcRFHh5dM7i+L5DKpxKSrK-mZdYEeScrzVnYZsJmg@mail.gmail.com>
Subject: Re: [GSoC][RFC/PATCH v2] submodule: port subcommand foreach from
 shell to C
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 3:11 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 24/04/17 21:03, Stefan Beller wrote:
> [snip]
>
>> +
>> + argv_array_pushf(&cp.env_array, "name=%s", sub->name);
>> + argv_array_pushf(&cp.env_array, "path=%s", displaypath);
>> + argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
>>
>> You mention keeping 'sm_path' in the notes after the commit message. I would
>> add that part to the commit message, to explain why we have multiple variables
>> that have the same value. Maybe even a comment in the code:
>>
>>     /* Keep sm_path for historic reasons, see tests in 091a6eb0fee. */
>>     .. sm_path ..
>
> Hmm, you need to be a bit careful with putting 'path' in the
> environment (if you then export it to sub-processes) on windows
> (cygwin, MinGW, GfW). See commit 64394e3ae9. I would have liked
> to remove $path altogether from the 'submodule-foreach api' in
> that commit, but users and their scripts were already using it
> (so I couldn't just drop it, without some deprecation period).
> So long as whatever was being 'eval'-ed in the script didn't
> export $path, ...
>

Oh, I misread the comment

     # we make $path available to scripts ...
     path=$sm_path

as it was such a casual friendly thing to say in that context.
So the *real* historic baggage is
    argv_array_pushf(&cp.env_array, "path=%s", displaypath);
whereas
    argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
is considered the correct way to go.

Thanks,
Stefan
