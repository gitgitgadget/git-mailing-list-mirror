Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BDFC001E0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 12:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjHJM4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 08:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbjHJM4f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 08:56:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ED72698
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 05:56:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe4a89e7efso7282315e9.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691672193; x=1692276993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W1zcxqU1/tyZgLr1a71XIe+VUhVgOd8p9Iz5uTxuMQo=;
        b=OIUVb3xEUBMFAWl65tzDeblDmUuemXhgSpujQqvrwslp4D/4m7YkEuIsia2xTdPvEG
         S3D0CQDXYzJpG8852BX+829usk7ew7Ro/JsBC0kswcij99JIYwi2wMWF5BLhFJrf70Qg
         97c9lLtwWvMymDDt9xKP7o8PJb1C+kkaBfcoxpnkBM0jmFEsn0GCBxGCpl+iZpA4PHEI
         9YQw23l4MPgfxozKB71Tf7vzlZbaz7Jnrsy24TSqHaQKeWsLqnYR1Fv8+VyrNkf96YoA
         M71FGCtuqx2k9N+KDDH1hxb6MzekeV8DOJRrhET6Vm5yc0TjTcH8QELVo/5ufYdTJu2T
         DuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691672193; x=1692276993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1zcxqU1/tyZgLr1a71XIe+VUhVgOd8p9Iz5uTxuMQo=;
        b=kKj/qvkKeKmTZ1c3oNeQN/qDqWVMasPDcsHb2JzFW0bA08Ovh5AQMMFMbUrV1xxKix
         dP5YAGRpDVWrlJX5Y1cCurXmtEikRHmjq6YYruRbGFpS+6c+S2k6+9oZa3KIPLYx1iOS
         UB10me8i/mMLveb1OBhW1p1Y/MlLaualTj+gYuK2ztI3uCDJMQTmE1qxqaCdAijzGYP+
         uyX/rKUiqjbkhpxgFNdpTr6kySOetlEtQYFDrSOzYCgHB0M2JI4AHwxsckJFknoXsamD
         1ejVtZnraoxzJKE3HAEvEVUUbtgS0aE/h3xLHX81zMk9hktNebze465QBBOZsZ1Eavv6
         Z2qw==
X-Gm-Message-State: AOJu0Yy3bAfI7wHkk4ys6mk2J9JEooex9aInZcoEUXaoal3Uuhoq1tCI
        VMZv91PZ9kuo52zO6PHsn988gUZ9aiE=
X-Google-Smtp-Source: AGHT+IHA1GGiSsF8LDa32csiXhk0zRzc2ogEYQcdmvHAjrX/FYRapOKtsgg3sHZhfnG2uTzWC/4geg==
X-Received: by 2002:a1c:f702:0:b0:3fe:ba7:f1ef with SMTP id v2-20020a1cf702000000b003fe0ba7f1efmr1718658wmh.30.1691672192758;
        Thu, 10 Aug 2023 05:56:32 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id w2-20020a05600c014200b003fbc9b9699dsm2056719wmm.45.2023.08.10.05.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 05:56:32 -0700 (PDT)
Message-ID: <148cf4e2-e6ce-4c10-a08a-bf946ce3b95d@gmail.com>
Date:   Thu, 10 Aug 2023 13:56:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] diff --no-index: support reading from named pipes
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
 <cover.1688586536.git.phillip.wood@dunelm.org.uk>
 <4e05a0be54f66f2b394642762832e426a545426c.1688586536.git.phillip.wood@dunelm.org.uk>
 <20230809171731.GA3663609@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230809171731.GA3663609@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eff

Thanks for reporting this

On 09/08/2023 18:17, Jeff King wrote:
> On Wed, Jul 05, 2023 at 08:49:30PM +0100, Phillip Wood wrote:
> 
>> +test_expect_success PIPE 'diff --no-index refuses to diff a named pipe and a directory' '
>> +	test_when_finished "rm -f pipe" &&
>> +	mkfifo pipe &&
>> +	{
>> +		(>pipe) &
>> +	} &&
>> +	test_when_finished "kill $!" &&
>> +	test_must_fail git diff --no-index -- pipe a 2>err &&
>> +	grep "fatal: cannot compare a named pipe to a directory" err
>> +'
>> +
>> +test_expect_success PIPE,SYMLINKS 'diff --no-index reads from pipes' '
>> +	test_when_finished "rm -f old new new-link" &&
>> +	mkfifo old &&
>> +	mkfifo new &&
>> +	ln -s new new-link &&
>> +	{
>> +		(test_write_lines a b c >old) &
>> +	} &&
>> +	test_when_finished "! kill $!" &&
>> +	{
>> +		(test_write_lines a x c >new) &
>> +	} &&
>> +	test_when_finished "! kill $!" &&
>> +
>> +	cat >expect <<-EOF &&
>> +	diff --git a/old b/new-link
>> +	--- a/old
>> +	+++ b/new-link
>> +	@@ -1,3 +1,3 @@
>> +	 a
>> +	-b
>> +	+x
>> +	 c
>> +	EOF
>> +
>> +	test_expect_code 1 git diff --no-index old new-link >actual &&
>> +	test_cmp expect actual
>> +'
> 
> I've had t4053 hang for me once or twice in the last few days. I haven't
> managed to pinpoint the problem, but I did notice that running it with
> --stress seems to occasionally fail in thie "reads from pipes" test.
> 
> The problem is that the "kill" is racy. Even after we've read all of the
> input from those sub-processes, they might still be hanging around
> waiting to exit when our test_when_finished runs. And then kill will
> return "0". So I think we need to either:
> 
>    1. Soften the when_finished to "kill $! || true" so that we are OK if
>       they are still there.

I think this is the easiest option, I'll send a patch later today

>    2. If the diff command completed as expected, it should be safe to
>       "wait" for each of them to confirm that they successfully wrote
>       everything. I'm not sure it buys us much over testing the output
>       from "diff", though.

If the diff output is OK that's I think that's all we really care about.

> I still don't see where the hang comes from, though. It might be
> unrelated. I'll try to examine more next time I catch it in the act.

I had a look at the tests again and nothing jumped out at me. If you do 
manage to catch it hanging we should at least we should be able to tell 
which test is causing the problem.

Thanks again,

Phillip
