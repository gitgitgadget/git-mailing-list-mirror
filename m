Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A981F461
	for <e@80x24.org>; Mon, 19 Aug 2019 14:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfHSOuv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 10:50:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36582 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfHSOuu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 10:50:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id d23so1621542qko.3
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ECmYlXs68iR/0Vs/qyo+v4CasG8I/gD+EKyUVYFVi00=;
        b=I0E2+48W7ZYrJOBV8woqFch8srHbx35WmEwCBkIUF1h4sGe7fxnZKVqfkHiXBxVffv
         yYxwW8nXwxQeMq5afsspQjMcMmhjw0BtwEBtIcofxFinJyjHyFqP0xsJ5AGshwB1NyOF
         Xcm5puuwLoDqd7ci8NzuIcQFspFVRCaGdzr7qAxqzyBzoQ+Z51P517ZlhPYArK+N3TQ6
         8fa6ydWWr5pn27y+0ZXgK0eQcDQPNHuaJVhGtiBkrSfQOqy++ytV77rMkISKCnF/P49u
         oV0eJWwg6XQcRv0HqfOEAxF64T8ngOuujdp2ijouJeOJ+3NrYq160uAbgjdcXMG933pz
         YU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ECmYlXs68iR/0Vs/qyo+v4CasG8I/gD+EKyUVYFVi00=;
        b=bqNmD3GBg4Dn5g56ZGxa3zv9iB3WrIeUnf3esmGf9BOZDavpvb5KnG/N1huVJmkWrk
         0f3vWiXJZvAAXM83Wq80tVrGgtCgW/wDQzx7GrbSFoxbaJY3BOskZO7b1ruX5NeSOTi2
         5/t6VG2jjqPpZkMbCxNq6xz9cvLibE40clsIC+6lRYOqha1iCIS5AO8+gv+0tAMsobbN
         UIskguXzNmQyNS+ePwzzXhr7Hk1uT2g62bWtCC4T8L53IRlCOrOEEuCdw3EcdLIqa6rw
         ose4kVsDXmof26jYstLhTu/TJaX0B3prrwMv/GyDDBnbC9oLa1yXUbYf0/otNMPUyYYK
         KePg==
X-Gm-Message-State: APjAAAV1BzQrau+2o2WOrLHDGB9EYZ73/jqh2YfMKA0E7ApnYgRzC1TA
        hkgHxMmy6HMK4PDI3HNjBC8=
X-Google-Smtp-Source: APXvYqwfGDcpXE0jTRESU4BAq8VjgMS4hxfuYZMsSh46mZaB0gbHHyaaDPN32L9nFTnuC7/0YVyLHA==
X-Received: by 2002:a05:620a:1109:: with SMTP id o9mr18990131qkk.324.1566226249331;
        Mon, 19 Aug 2019 07:50:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3cc4:beea:5454:ae58? ([2001:4898:a800:1012:edf7:beea:5454:ae58])
        by smtp.gmail.com with ESMTPSA id b24sm7152037qtp.25.2019.08.19.07.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 07:50:48 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] line-log: towards a more responsive, incremental
 'git log -L'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
 <a3f8b468-5ee5-4056-db67-bb8ba5390002@gmail.com>
 <20190819130323.GU20404@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5611dad6-94fe-e4e1-c06d-7dd0642be3ae@gmail.com>
Date:   Mon, 19 Aug 2019 10:50:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190819130323.GU20404@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2019 9:03 AM, SZEDER Gábor wrote:
> On Mon, Aug 19, 2019 at 08:00:11AM -0400, Derrick Stolee wrote:
>> On 8/18/2019 2:27 PM, SZEDER Gábor wrote:
>>> Line-level log performs a preprocessing step in
>>> prepare_revision_walk(), during which it filters and rewrites history
>>> to keep only commits modifying the given line range.  This
>>> preprocessing causes significant delay before the first commit is
>>> shown, wastes CPU time when the user asks only for a few commits, and
>>> does parent rewriting with no way to turn it off.
>>>
>>> This patch series addresses these issues by integrating line-level log
>>> filtering into the revision walking machinery and making it work
>>> together with generation number-based topo-ordering (though for now
>>> only in the case when the user doesn't explicitly asks for parent
>>> rewriting, which is probably the common case).
>>>
>>> The first two patches are quite straightforward (and arguably somewhat
>>> unrelated), but the rest deals with history traversal and parent
>>> rewriting, which I don't usually do, hence the RFC.
>>
>> Hi Szeder,
>>
>> Thanks for sending this series! I'm particularly excited about it
>> because we recently got a bug report from a user in the Windows OS
>> repo about "git log -L" being very slow. I put it on the backlog [1]
>> but haven't had time to investigate it myself. After we are done
>> updating to v2.23.0 [2], I'll have time to test your changes on
>> the Windows repo. I anticipate your change to provide a massive
>> boost.
> 
> Well, it depends on what you mean by "boost"...  As discussed in patch
> 4's commit message, this series doesn't really optimizes much, and the
> total amount of work to be done remains the same, except that 'git log
> -L... -<N>' will be able to return early.  So when you benchmark it
> with e.g. 'time git log -L... >/dev/null', then you won't see much
> difference, as it will still take just about as looooong as before,
> apart from the faster generation numbers-based topo-ordering.  (But I
> have a few WIP patches waiting to be cleaned up that might bring about
> 3-4x speedup in general.)
> 
> In the meantime, until these changes trickle into a Git release, for a
> faster line-level log I would recommend to:
> 
>   - Limit the revision range up front, i.e.:
> 
>       git log -L... ^a-not-too-old-version
> 
>     because this can greatly reduce the amount of commits that that
>     expensive preprocessing step has to churn through.
> 
>   - Use '--no-renames'.  Although it won't follow the evolution of the
>     line range over file renames, this might be an acceptable
>     compromise.  (this is what those WIP patches are focusing on)
> 
>   - Or both.

Usually when I'm testing something involving the --topo-order logic,
I'll use a simple "-10" to limit to something similar to a "first page".

In this line-log case, I'll use "-1" to just get the top result, as that
is essentially how long it takes before the user gets some feedback.

Here are the results using a random path I picked out from the Windows
repo (it was only changed ~10 times in the 4.5 million commits):

Before:

real    2m7.308s
real    2m8.572s

With Patch 4:

real    0m38.628s
real    0m38.477s

With Patch 5:

real    0m24.685s
real    0m24.310s

For the specific file in the bug report from a real user, I got
these numbers:

real    0m32.293s (patch 4)
real    0m19.362s (patch 5)

Note that I don't include the "without patch" numbers. For some
reason the path provided is particularly nasty and caused 20,000+
missing blobs to be downloaded one-by-one (remember: VFS for Git
has many partial-clone-like behaviors). I canceled my test after 55
minutes. I'll dig in more to see what is going on, since only 37
commits actually change that path.

Thanks so much for finding these "easy" wins. Your changes are
nicely isolated, but give us a target to improve even further!

I expect that we will incorporate your commits into microsoft/git
very early.

Thanks,
-Stolee

