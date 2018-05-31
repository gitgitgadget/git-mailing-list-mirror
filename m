Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36EE61F51C
	for <e@80x24.org>; Thu, 31 May 2018 07:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbeEaHXL (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 03:23:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52336 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeEaHXK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 03:23:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id 18-v6so46496305wml.2
        for <git@vger.kernel.org>; Thu, 31 May 2018 00:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1UAhO//WBJp4smE/2FxC7oR4lCMqQrVQKf2Y8mGSGZw=;
        b=mvdG9ieojlwrYyXtJXJGyxZohMTrF6ooqa2zSUoIR0vtVAXGh/uq9bH2C2W0qG887t
         ilsMUSYQOYvvHVKKJTAQ9+Jh1B7ciiuTIwoy08RayhzNNmT5flkbClz4TEbIbyy5YaN0
         fQnadqPGIymBTBhxX30wv++kT78uQfkAR+B6disjaePGHdzPvkV4tm8MzOjnmHvLGTHt
         gF2zd6oqi/9R3Yg8xX0oxvbKNRUrzYPxgo4gMwsmp+1IA2DLlujEaRZp6JAOyRTl5Q1M
         VJkn/5CX7pQiszE6Zyln9P+METmh6qHX3RcqnoHaphch0A7npTZqQRyyVkVLwnXlp/c9
         ZJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=1UAhO//WBJp4smE/2FxC7oR4lCMqQrVQKf2Y8mGSGZw=;
        b=JbzIuseeVI1l7JN3Z226huCEQQJqadGJYsu7iQ2fhZSz2DoP4c2a2ZLvwBNKnyufiZ
         rLSdNmrcSpqpd6hhij4tOvTDqtxt+h0fH1lO2emsN6UF7y7aLPTWZC1m0OiXDOgcRAeW
         rL0ffW2UibemFz1pGPPko1N4eVtoh1qsmINhkxhItFdd5hXd1r+nfahkB6cQB8kXQcOj
         hu5OLDzcKqKEvUqpIaTlzgN1s+K9iOp68sZ8OtYaCvDv/lCdEBsWW7VhD43PwfwdCGF+
         g66/rqsg6JNkQGmvQzfLmk648KP3VlVuW3Dv+6PptvRwsZMF5cmS4SxHo3MvVrDj3Wel
         d+Qw==
X-Gm-Message-State: ALKqPwdNaSfK1U4XkziMKbircUDgtbqYd5M3edWyKqitKSVgcCw32tA2
        KxuvTmoGQbuCNU6eNQBlfI0=
X-Google-Smtp-Source: ADUXVKKYF23ekpbT44r/xs4T17SodKzWD26Xwb0fGKQ/UeQK817yPiBgC7tPlf/Ponp23oLLfguHaA==
X-Received: by 2002:a50:83a5:: with SMTP id 34-v6mr6663621edi.276.1527751388907;
        Thu, 31 May 2018 00:23:08 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b47-v6sm21647517ede.70.2018.05.31.00.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 00:23:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 5/5] fetch: implement fetch.fsck.*
References: <20180525192811.25680-1-avarab@gmail.com> <20180524193516.28713-1-avarab@gmail.com> <20180525192811.25680-6-avarab@gmail.com> <xmqqin75ere0.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqin75ere0.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 31 May 2018 09:23:07 +0200
Message-ID: <87efhs9tlw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 30 2018, Junio C Hamano wrote:

> Earlier I mumbled "this 4-patch series generally looks good but I
> need to re-read the implementation step"; I meant this 5-patch
> series and here is my impression after re-reading the implementation
> step.
>
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index f97f21c022..f69cd31ad0 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1426,6 +1426,16 @@ fetch.fsckObjects::
>> ...
>
> Nicely written.
>
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index 490c38f833..9e4282788e 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -19,6 +19,7 @@
>>  #include "sha1-array.h"
>>  #include "oidset.h"
>>  #include "packfile.h"
>> +#include "fsck.h"
>>
>>  static int transfer_unpack_limit = -1;
>>  static int fetch_unpack_limit = -1;
>> @@ -33,6 +34,7 @@ static int agent_supported;
>>  static int server_supports_filtering;
>>  static struct lock_file shallow_lock;
>>  static const char *alternate_shallow_file;
>> +static struct strbuf fsck_msg_types = STRBUF_INIT;
>
> s/msg_types[]/exclude[]/ or something, as this is not just about "we
> tolerate known and future instances of 0-padded mode in trees", but
> also "we know this and that object is bad so do not complain" as well.

I copied the fsck_msg_types variable as-is from builtin/receive-pack.c
which Johannes added in 5d477a334a ("fsck (receive-pack): allow demoting
errors to warnings", 2015-06-22).

That's not a justification for doing the same here, but does your
critique also extend to that variable name, so I could fix it there
while I'm at it?

> Other than that, the implementation looks good.
>
>> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
>> index 49d3621a92..b7f5222c2b 100755
>> --- a/t/t5504-fetch-receive-strict.sh
>> +++ b/t/t5504-fetch-receive-strict.sh
>> @@ -135,6 +135,20 @@ test_expect_success 'push with receive.fsck.skipList' '
>>  	git push --porcelain dst bogus
>>  '
>>
>> +test_expect_success 'fetch with fetch.fsck.skipList' '
>> +	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
>> +	refspec=refs/heads/bogus:refs/heads/bogus &&
>> +	git push . $commit:refs/heads/bogus &&
>> +	rm -rf dst &&
>> +	git init dst &&
>> +	git --git-dir=dst/.git config fetch.fsckObjects true &&
>> +	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
>> +	git --git-dir=dst/.git config fetch.fsck.skipList dst/.git/SKIP &&
>> +	echo $commit >dst/.git/SKIP &&
>> +	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec
>> +'
>
> If the test does not change meaning when file://$(pwd) is replaced
> with "." (or ".." or whatever if other tests below moves cwd
> around), I'd think it is preferrable.  Seeing $(pwd) always makes me
> nervous about Windows.

Thanks. Will fix.
