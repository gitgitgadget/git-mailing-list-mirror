Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD9F202AF
	for <e@80x24.org>; Tue, 14 Nov 2017 23:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755974AbdKNXhY (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 18:37:24 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:47650 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbdKNXhW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 18:37:22 -0500
Received: by mail-qt0-f171.google.com with SMTP id y5so14131217qtk.4
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 15:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=87iEuf85JW44pJ89dy6DhW6YsdF0wLtuL7oA3bK13LY=;
        b=HMKUQezeVxLZMwrHsiL5AEvlzNP69ZnNjKiUelZgXmok3CWB0i5mPLtLBmoAKKgo15
         cQ+9nG2YR0BvQ8lJOJ19t2D/BsYcwhEB0EdPfWHxiF5irfz8uf3Tu3LuCLPJdQ75DXwQ
         UtfdVb1ox9sjPUL+z14U9A6Mfdz+LtJOmvpGCm2x/jtqWh15J1Ivpsg0ahBR89gqypF7
         W1KDFBivaMrMbAi8+Nh9c5nL//zgRHGodq2Gt4gzxtzIfdu18HABsvYig0APwh28R7/g
         mwiJV20SecmpJ9YNIQp1x9kwfFU6WQ04Z4sBPwDHYyWc3NOHpnVcS0BCjSNouFJcrch+
         eavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=87iEuf85JW44pJ89dy6DhW6YsdF0wLtuL7oA3bK13LY=;
        b=JzFq+CBKLP6Yd8RYJSv3AENvCatwMp8IXIp9sOv3onYelaujzcsFkvfvFOWdnGUN8Y
         582+EKDgOqYAGrK2xV+puTIZtr0lEm/3LcGOEaxKu/1Z/lRCTfuM16Z1X1D2hNbdM+KF
         jP2zM6bDpPt0kani09Dm9Twez+o49G0s/v4NmV7SZVW0DSEQMu6mVFi1pJ2EJjKMLTXN
         nGSx5fQDHk/vcrojiBwW7LO50F1xU7IwEA1j2rwf2LIBkUNU1A6t35TnsVufLnDsUDyu
         T2EMpFtUR0mZ8KQ8Pk7VJujuk1IEvpbdLfocEDhRSvswN7uoNPQ1dA4kDmTMQ4tr7FcO
         uFHg==
X-Gm-Message-State: AJaThX6XP5r/61oyuxwtR26Qd1XMnUHE91uc/eD9x4QTFy+UVIkRvZHB
        jxzs4/JSNJp9heTBMjyVogTQfXeymJPQo8KYXhKsBg==
X-Google-Smtp-Source: AGs4zMZkG+oR2wnYs3K7IDidZ0Ruhgrjtw316tBiCAWsBHhGYrwaVXtQfB4CK2UofaM0gftNGRKPDAzmvWPjzL1QJmE=
X-Received: by 10.233.239.70 with SMTP id d67mr22029785qkg.308.1510702641506;
 Tue, 14 Nov 2017 15:37:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Tue, 14 Nov 2017 15:37:20 -0800 (PST)
In-Reply-To: <xmqqtvxzarnc.fsf@gitster.mtv.corp.google.com>
References: <xmqqo9obhqo0.fsf@gitster.mtv.corp.google.com> <20171110224425.15299-1-sbeller@google.com>
 <20171110224425.15299-2-sbeller@google.com> <xmqqtvxzarnc.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Nov 2017 15:37:20 -0800
Message-ID: <CAGZ79kZ4siux1BV42cbF4e5fxgZfx1bVc3mL8KUj9ep5_OhiVA@mail.gmail.com>
Subject: Re: [PATCH] builtin/describe.c: describe a blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>,
        Kevin Daudt <me@ikke.info>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 5:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Sometimes users are given a hash of an object and they want to
>> identify it further (ex.: Use verify-pack to find the largest blobs,
>> but what are these? or [1])
>
> Thanks for finishing the topic you started.
>
>> @@ -11,6 +11,7 @@ SYNOPSIS
>>  [verse]
>>  'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
>>  'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
>> +'git describe' <blob>
>
> OK.
>
>> diff --git a/builtin/describe.c b/builtin/describe.c
>> index 9e9a5ed5d4..acfd853a30 100644
>> --- a/builtin/describe.c
>> +++ b/builtin/describe.c
>> ...
>>  static void describe(const char *arg, int last_one)
>>  {
>> ...
>> @@ -445,11 +497,18 @@ static void describe(const char *arg, int last_one)
>> ...
>> +     cmit = lookup_commit_reference_gently(&oid, 1);
>> +
>> +     if (cmit)
>> +             describe_commit(&oid, &sb);
>> +     else if (lookup_blob(&oid)) {
>> +             if (all || tags || longformat || first_parent ||
>> +                 patterns.nr || exclude_patterns.nr ||
>> +                 always || dirty || broken)
>> +                     die(_("options not available for describing blobs"));
>> +             describe_blob(oid, &sb);
>
> I am not sure if I agree with some of them.
>
>> +     } else
>> +             die(_("%s is neither a commit nor blob"), arg);
>
> This side I would agree with, though.
>
> The caller of the describe() function is either
>
>  * 'git describe<RETURN>' makes a single call to it with "HEAD" and
>    exits; or
>  * 'git describe A B C...' makes one call to it for each of these
>    command line arguments.
>
> And 'git describe <blob>' code is most likely trigger from the latter,
> as it is not likely for HEAD to be pointing at a blob.
>
>     $ blob=$(git rev-parse master:Makefile)
>     $ git describe --always master $blob
>
> and trigger the above check.  Is the check against "always" useful,
> or is it better to simply ignore it while describing $blob, but
> still keeping it in effect while describing 'master'?
>
> The 'dirty' and 'broken' check is redundant because we would have
> already errored out if either of them is set before calling describe()
> on user-supplied object names.
>
> If I understand the way "describe <blob>" works correctly, it
> traverses the history with objects, doing a moral equivalent of
> "rev-list --objects", stops when it finds the blob object with the
> given name, and when it stops, it knows the commit object that
> contains the blob and path in that commit to the blob.  Then the
> commit is described to be a human-readable string, so that the path
> can be concatenated after it.
>
> Aren't these options that affect how a commit object is described in
> effect and useful when you do the "internal" describe of the commit
> you found the blob object in?  IOW, wouldn't this
>
>     $ git describe --exclude='*-wip' $blob
>
> make sure that in its output $commit:$path, $commit is not described
> in terms of any "wip" refs?

yes, we would exclude those refs. But the name alone (without reading the docs)
suggests anything given in --exclude is excluded, so what about the blob

    $commit:path-wip/test1.c

which I might want to exclude from the search using the exclude pattern?
After reading the docs, this is silly of course, and the exclusion only applies
to the commit description part.

--all is an interesting case, as we pass --all to the revision walking machinery
for blobs, but that is slightly different than the --all flag given to describe,
which also only relates to the commit name that should be produced.
So, I'll go through all the options and see which we can drop.

Thanks,
Stefan


>
