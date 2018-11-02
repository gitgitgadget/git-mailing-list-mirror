Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD181F453
	for <e@80x24.org>; Fri,  2 Nov 2018 17:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeKCCi2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 22:38:28 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41636 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCCi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 22:38:28 -0400
Received: by mail-yb1-f196.google.com with SMTP id t13-v6so1087488ybb.8
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Io+Hw39Vss24O1Rhj39TqvQ1v+lSL+nGQOFbbxE7e6k=;
        b=lD5WdNpXeYXBixzUX+gPWZHRVXc2cLJKMRw44bRSiB+mrC1IMKI62ZaWU5Lw9SQhy/
         +I3FpwzfkarKvNn/qWjR6Xkk1OWMSJPkzaJK8lNaF5SqQR991fhY7v25MZb61u/1X29P
         2I0N+cv8PciOS/DwrXsq5pcOKOXIXgg2e7Pva4TcikbIxQ33ywEthd1UlKbzRLXThZOU
         K9sR4fa4nYtQvZ65LuyP3oMYqcpSrmmc952VObcCF3Armric2fRDpesf6I2NGPxjEA4C
         b8q3dGurssla4/n2VsffEQK80opp2YglP21epyUnKya6Lr3eisVtWolcwnX61CjGGtib
         rxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Io+Hw39Vss24O1Rhj39TqvQ1v+lSL+nGQOFbbxE7e6k=;
        b=m/HBR5nneaJGy8Kl4NUrgQXq69UA7OXhf/pTeol0FT3IiIPPlavkNKqg3eCCR/Sr9o
         sW/40311GXzvid9zxZJ9aTBf+D6s9CYNiyKaSVnYhY6qAqzyKjdaJT9i0p/0Z8OL+0Lo
         HH1Htm1bhfwcJ4YgYbD4ZQgopj4jnp9FVUlpA+E9oQUNqO28+EWuP/in0kbp7qhDktfo
         6jBk3arxx7kmOIENvG8nGyZbiV4HVEIFVfjKvXayMJ30wmt5Un373sNcHFl16d+kYgN5
         9Y656ViCimZRpMX14Ja2P0/FJDaVpLxQMXsnYTtg3qxz3b2yahzkvUucMJ9i/phQIjds
         aZPA==
X-Gm-Message-State: AGRZ1gLAyiKn9KCtAz9fDxzCBJcl4+DONOiNKKpD3d8pBOC8r8YrBdNW
        Ja3FjDxxqZyyEtKbqDIeG/U=
X-Google-Smtp-Source: AJdET5fQkY6HZfh9mCdgrHEIBmrZk9wuMrjAtNfrf3QLcDPC53IzkdApQS7dXAEq81uS5StSME6M2w==
X-Received: by 2002:a25:1585:: with SMTP id 127-v6mr12682138ybv.208.1541179832630;
        Fri, 02 Nov 2018 10:30:32 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id b186-v6sm1546064ywe.27.2018.11.02.10.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 10:30:32 -0700 (PDT)
Subject: Re: [PATCH v3 8/8] merge-recursive: improve
 rename/rename(1to2)/add[/add] handling
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20181014020537.17991-1-newren@gmail.com>
 <20181019193111.12051-1-newren@gmail.com>
 <20181019193111.12051-9-newren@gmail.com>
 <d23b4e26-4df4-273d-a75c-a0af915a6e5e@gmail.com>
 <CABPp-BFZugCFDS_A7FrWdRhp7WO0m8jhsqbSnNCSUWnAVz7mtg@mail.gmail.com>
 <CABPp-BFwimcDhwMeFcTJLy-omXiBNzZApkyCnSSRfwXvKi2OUQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c3b4d1d5-2a7e-b83c-d8cc-bdac6a8835e2@gmail.com>
Date:   Fri, 2 Nov 2018 13:30:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFwimcDhwMeFcTJLy-omXiBNzZApkyCnSSRfwXvKi2OUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2018 1:27 PM, Elijah Newren wrote:
> On Thu, Nov 1, 2018 at 12:01 AM Elijah Newren <newren@gmail.com> wrote:
>> On Wed, Oct 31, 2018 at 8:08 AM Derrick Stolee <stolee@gmail.com> wrote:
>>> On 10/19/2018 3:31 PM, Elijah Newren wrote:
>>>> [snip]
>>>>
>>>> +                     char *new_path = NULL;
>>>> +                     if (dir_in_way(b->path, !o->call_depth, 0)) {
>>>> +                             new_path = unique_path(o, b->path, ci->branch2);
>>>> +                             output(o, 1, _("%s is a directory in %s adding "
>>>> +                                            "as %s instead"),
>>>> +                                    b->path, ci->branch1, new_path);
>>> I tried really hard, but failed to get a test to cover the block below.
>>> I was able to
>>> find that the "check handling of differently renamed file with D/F
>>> conflicts" test
>>> in t6022-merge-rename.sh covers the block above. Trying to tweak the
>>> example using
>>> untracked files seems to hit an error message from unpack-trees.c instead.
>>>
>>>> +                     } else if (would_lose_untracked(b->path)) {
>>>> +                             new_path = unique_path(o, b->path, ci->branch2);
>>>> +                             output(o, 1, _("Refusing to lose untracked file"
>>>> +                                            " at %s; adding as %s instead"),
>>>> +                                    b->path, new_path);
> So now I'm confused.  This block was not listed in your coverage
> report[1].  And, in fact, I think this block IS covered by testcase
> 10c of t6043.  However, there is a very similar looking block about 30
> lines up that is uncovered (and which was mentioned in your report):
>
>              } else if (would_lose_untracked(a->path)) {
>                  new_path = unique_path(o, a->path, ci->branch1);
>                  output(o, 1, _("Refusing to lose untracked file"
>                             " at %s; adding as %s instead"),
>                         a->path, new_path);
>
> covering it, I think, is just a matter of repeating the 10c test with
> the merge repeated in the other direction (checkout B and merge A
> instead of checking out A and merging B) -- and touching up the checks
> accordingly.
>
> However, now I'm wondering if I'm crazy.  Was it really the block you
> had highlighted that you were seeing uncovered?

Trust the report (generated by computer) over me (generated by squinting 
at an email, trying to match line numbers).

Thanks,

-Stolee

