Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CBB1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 20:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404100AbfJWUqp (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 16:46:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33836 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391748AbfJWUqo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 16:46:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id e14so14492275qto.1
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QQKS7lLenexWy6vqFN3sNHd1ugNuTfoQZHO2ZTtRn4k=;
        b=lKEIPWfCp7+S2TkoW/FKQP6PNrUyYB2UGCxv5DrT0jec/Kmg2Ts54Mr791ZGyGRR36
         wtfJQPauiqrWYo1ONDCyXfnpCVcQDpYXQ7lB07PCP+g0/ev4KBKT03EP1IfI6vSirqKv
         P1uDgL/YijErtZO4eRKQVbYoCnHwmmM94WgljKsBsY7eXJIMWeOASTnquDtrqcmfq0aK
         FhfHT2htFj/hbgjmscIlWk3ZCO03cVDUjl8u9Hc56NV90HcNJg1wKdGIcfeddQPO6puy
         NeHYL7zo9+XORRT8c5Cn8gr0hdZwngTBtjyno4Pp0MIzP2dLyn/+sYRrnRTn7vRi+hGI
         MkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QQKS7lLenexWy6vqFN3sNHd1ugNuTfoQZHO2ZTtRn4k=;
        b=K3hjc08wrqP90MI4LFckFYRbN3pwzYLApksetZ3++2X6WA0MR15w5Q7j+pPFUyb8SI
         oyvi0UG0ML2uiwP6hgeF3f2rwAOSulK1+zNg34coqIhSeo2d/QGA2Rz3DmAE3lGm2K5s
         EXHO0R1/TkFzUNhLnc5cO44SmRcKbZwNINUZLU/HL98eQzCGqRUrE3nELiwqo6K3NqgP
         YDiKCh+lufa7rZQHFYftepWWGHQWJ9F+iONlTwpZOUHxNdPJ2WMFUsA3OciRlYGoO7sn
         9nwy1t2a/K8jCtA/OcTiDm+zu6IOpqozvXjSktCLrN2HySfjSiavfknclVLSU1u8R83y
         XFtA==
X-Gm-Message-State: APjAAAWAzO9YJZIzVNIyge6+ehVzEDAMOJ3MtXDgibbMEgfzn4pw2BjM
        vG6lL4Sivfh0Dw7DbXxhNCs=
X-Google-Smtp-Source: APXvYqwOmBksp6pf/4ppmdY8t9QMHsfKkgktmN8rSH8MHZT4KqXJ4pw94coLD4fplB1XniAW3fYB6w==
X-Received: by 2002:ac8:32c3:: with SMTP id a3mr537263qtb.320.1571863603690;
        Wed, 23 Oct 2019 13:46:43 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bd19:92e0:6c87:b219? ([2001:4898:a800:1012:6e4d:92e0:6c87:b219])
        by smtp.gmail.com with ESMTPSA id s42sm14523485qtk.60.2019.10.23.13.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 13:46:43 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] t5510-fetch.sh: demonstrate fetch.writeCommitGraph
 bug
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
 <pull.415.v2.git.1571835695.gitgitgadget@gmail.com>
 <6ac0a05746df8ac3b1dd788f525b2620bc4d9a08.1571835695.git.gitgitgadget@gmail.com>
 <20191023141813.GA26017@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a9ba6007-aeb9-96b4-9436-8e956798be59@gmail.com>
Date:   Wed, 23 Oct 2019 16:46:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191023141813.GA26017@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/23/2019 10:18 AM, SZEDER Gábor wrote:
> On Wed, Oct 23, 2019 at 01:01:34PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> While dogfooding, Johannes found a bug in the fetch.writeCommitGraph
>> config behavior. His example initially happened during a clone with
>> --recurse-submodules, we found that this happens with the first fetch
>> after cloning a repository that contains a submodule:
>>
>> 	$ git clone <url> test
>> 	$ cd test
>> 	$ git -c fetch.writeCommitGraph=true fetch origin
>> 	Computing commit graph generation numbers: 100% (12/12), done.
>> 	BUG: commit-graph.c:886: missing parent <hash1> for commit <hash2>
>> 	Aborted (core dumped)
>>
>> In the repo I had cloned, there were really 60 commits to scan, but
>> only 12 were in the list to write when calling
>> compute_generation_numbers(). A commit in the list expects to see a
>> parent, but that parent is not in the list.
>>
>> A follow-up will fix the bug, but first we create a test that
>> demonstrates the problem.
>>
>> I used "test_expect_failure" for the entire test instead of
>> "test_must_fail" only on the command that I expect to fail. This is
>> because the BUG() returns an exit code so test_must_fail complains.
> 
> I don't think this paragraph is necessary; using 'test_expect_failure'
> is the way to demonstrate a known breakage.
> 
> 'test_must_fail' should only be used when the failure is the desired
> behavior of a git command.  (I used the word "desired" here, because
> you just used the word "expect" above in the sense that "I expect it
> to fail, because I know it's buggy, and I want to demonstrate that
> bug")

I guess that I prefer pointing out which line of the test fails, and
making that part of the test (that must otherwise pass). However, you
are right that test_expect_failure does a good job of communicating that
the test script shows an existing bug. Those are not always cleaned up
immediately, but at least we can find them easily.

>> Helped-by: Jeff King <peff@peff.net>
>> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Helped-by: Szeder Gábor <szeder.dev@gmail.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  t/t5510-fetch.sh | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index ecabbe1616..e8ae3af0b6 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -583,6 +583,23 @@ test_expect_success 'fetch.writeCommitGraph' '
>>  	)
>>  '
>>  
>> +test_expect_failure 'fetch.writeCommitGraph with submodules' '
>> +	pwd="$(pwd)" &&
>> +	git clone dups super &&
>> +	(
>> +		cd super &&
>> +		git submodule add "file://$pwd/three" &&
> 
> Nits: couldn't the URL simply be file://$TRASH_DIRECTORY/three ?

True, that would be better. Thanks!

 
>> +		git commit -m "add submodule"
>> +	) &&
>> +	git clone "super" writeError &&
> 
> There is a write error now, because we have a bug, but after the next
> patch the bug will be fixed and we won't have a write error anymore.

Good point.

Thanks!
-Stolee
