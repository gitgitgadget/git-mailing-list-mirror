Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CD0D20437
	for <e@80x24.org>; Tue, 31 Oct 2017 18:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbdJaSMz (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:12:55 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:52182 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbdJaSMw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:12:52 -0400
Received: by mail-qk0-f177.google.com with SMTP id 17so21590445qkq.8
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3B5bMNZ+nh+1/ivERwdQBX2Z+WqAf2he+vKI6c8VSUY=;
        b=aEItWhLfigZNFcMwc3expGdRgeL693s6Js5n8f8dls9NhAhpIqP1nEIihOugtEip2m
         ID2syjy4ua+7MVZwrd2y9pFFoQ2H5QTSlXq/N0TwqE6LZQzID/8CAytzXDPPXoIQ4my5
         3RR74vQ7fSPTQ5ZxvwwiiA/lJpWEQH8JYVfC8tu7jYEs7pHzrmV9ojX99LMkptHdMsgu
         8KApv6F21nCWu09xgQ6urY2Wso2pywIzfw+n3uef77WrVYF0TuKhSOfYfeJle/OITrbj
         wyUl+W3Of+81M65kCTOcYtdJ4qb8VEAnuQhS8ybwy02kem0lbDsYCOoYJt41AzUKzhgO
         34cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3B5bMNZ+nh+1/ivERwdQBX2Z+WqAf2he+vKI6c8VSUY=;
        b=cwI+d6H7np7vjb6kD4adUizOlcjCunJHrQvTzey+v1mtuvj/MzxeiryT4K+dTFx/HP
         5kNGsjIhUKj0wdjH1eMfzRFeAX5MgZm2OYKfKUIoO202E5F0h+dAabo3F7M8gKZ9W1Bn
         M6TZsjJnIRUSvv1NsF8lcezlbqbOHJO7hEkWVgMn48zpyrz29URRqyLo4qcrDzHOIOms
         Hcrfv3nxoaG0/9Hqi91Ukg3VoN/y83gc4L8yJ4YBuqjztrORPjcf5+eCqir2HxUonMpz
         IzWnsQtrN7P5S75WwlSJTub0U8Q/LnkJcLXHmgFZWI3Be88ObPo89/6QXlgbtXWoQSE8
         OnIw==
X-Gm-Message-State: AMCzsaUu1EY/7LJTAuRzqyTsKPvb6Z+5grdVvqNiny0pUVH9dAxn2pVq
        qlyKcSB2180FF9s4IMupro1qlT+J9vL7fdXfeFPoDg==
X-Google-Smtp-Source: ABhQp+SdYDQHRRLSLw2vOGN/Ad//C3rA0Vb9YQ0A4DS8v7s5N5/I9ymPhuie6QBwYXf90M6G8zKiZdBQAk6uBH8zURk=
X-Received: by 10.55.129.70 with SMTP id c67mr4296365qkd.230.1509473571499;
 Tue, 31 Oct 2017 11:12:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 31 Oct 2017 11:12:50 -0700 (PDT)
In-Reply-To: <xmqqa807ztx4.fsf@gitster.mtv.corp.google.com>
References: <20171028004419.10139-1-sbeller@google.com> <20171031003351.22341-1-sbeller@google.com>
 <20171031003351.22341-3-sbeller@google.com> <xmqqa807ztx4.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 31 Oct 2017 11:12:50 -0700
Message-ID: <CAGZ79kayAgLc7Wju0h39ee7eB37ZgHR8OotX3Uima6QGZ+5n1Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] revision.h: introduce blob/tree walking in order of
 the commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 30, 2017 at 11:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/list-objects.c b/list-objects.c
>> index bf46f80dff..5e114c9a8a 100644
>> --- a/list-objects.c
>> +++ b/list-objects.c
>> @@ -237,6 +237,8 @@ void traverse_commit_list(struct rev_info *revs,
>>               if (commit->tree)
>>                       add_pending_tree(revs, commit->tree);
>>               show_commit(commit, data);
>> +             if (revs->tree_blobs_in_commit_order)
>> +                     traverse_trees_and_blobs(revs, &base_path, show_object, data);
>>       }
>>       traverse_trees_and_blobs(revs, &base_path, show_object, data);
>
> This one is interesting.  While we walk the ancestry chain, we may
> add the tree for each commit that we discover to the "pending.  We
> used to sweep the pending array at the end after we run out of the
> commits, but now we do the sweeping as we process each commit.
>
> Would this make the last call to traverse_trees_and_blobs() always a
> no-op?

That is my understanding of the code, the important part of the previous patch
was the move of 'object_array_clear(&revs->pending);' into the
`traverse_trees_and_blobs` function.

>  I am not suggesting to add a new conditional in front of it;
> I am just asking for curiosity's sake.

Thanks for being clear on that. I have the same taste for this.

(Though for a split second I wondered if we can pull some esoteric trick
to skip this, but I could not find any that is sane as well as readable.)

>> +test_expect_success 'setup' '
>> +     for x in one two three four
>> +     do
>> +             echo $x >$x &&
>> +             git add $x &&
>> +             git commit -m "add file $x"
>> +     done &&
>> +     for x in four three
>> +     do
>> +             git rm $x
>> +             git commit -m "remove $x"
>> +     done &&
>
> There is break in &&-chain in the second loop, but in any case, for
> loops and &&-chains do not mix very well unless done carefully.
> Imagine what happens if "git commit" in the first loop failed when
> x is two; it won't stop and keep going to create three and four and
> nobody would noice any error.
>

I'll fix that.


> Even though we do not have --stdin for rev-parse, you can still do:
>
>         git cat-file --batch-check='%(objectname)' >expect <<-\EOF &&
>         HEAD^{commit}
>         HEAD^{tree}
>         HEAD:one
>         HEAD:two
>         ...
>         EOF

sounds better than the current implementation.
