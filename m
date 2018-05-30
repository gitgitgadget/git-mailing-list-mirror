Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D4391F42D
	for <e@80x24.org>; Wed, 30 May 2018 03:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbeE3Drk (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 23:47:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35782 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeE3Dri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 23:47:38 -0400
Received: by mail-wr0-f193.google.com with SMTP id i14-v6so27968602wre.2
        for <git@vger.kernel.org>; Tue, 29 May 2018 20:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jtNEDS9hwWkCpLJipaPe0Ce0VjC+5/k9BwsAbqiScn4=;
        b=qm8zZ1S6rpopBXLPSkjANoaOGJ4IOxZXtq/pKVmA7Tmq+EPg9jhZSU+EvxxtMaCKND
         4KKqEe7PNqQqzl0Wrl5p9UHvpCdZpQxKs7YJPKPmWwV97+geUolOZF40Ovcl9e46mHA5
         4Sq539dET0+WKfLCBgjwZvcmVVdx74B5c3YMRNkhZfVgzp3cZeS+pchyOdMPdGlbyXHe
         Mh+HbBWj0oY79X1nzhyjq35ouiEGGVgfKVzlFSuR6gX+I1xueebpSfqnMhKFJ+bK4MZZ
         6gPbJCp7d96HHE8uQ/3LxHElbuGQc9q8IiIyB9czO2Fvm/Bmxu1MZHPczAWI7IsjMg2k
         aINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jtNEDS9hwWkCpLJipaPe0Ce0VjC+5/k9BwsAbqiScn4=;
        b=jqGECHpUi75VzVEQENCDRYRLpzAC9eiHs8HpGWDFJ1MLgaDYJC1BAj0Nsx9U94OF1T
         4wzObNSY6SGsueEXRtY6lBhWPuT5+k5fZBOrMJOTgnS+sLLOuBWq1CBe2yBiHvxUDGQO
         ofw0BNzXWdjdRHH0yioCRmZHbdTKBdb0OwC6djRkYiqAxMfLTmBNtBkhrMFrIiyhps16
         AMCf9a8n74R0CTeowx1hZuILCmlUMlqaK0rcP5exBt+abDOugZt41Vn4ikIFNSq2Y3wp
         zdM8NRV3bEeEHltixBSPckj0j4SUyKwoFQuI7IEHguer9jdsgobOzpkxN7Out25yRVg6
         eWWQ==
X-Gm-Message-State: ALKqPweI3JWNzX2NJTt0OB+3EKaB3c/a0Gc/meBk55Va9AbF4RbGi8wl
        u02WgNu5pTiBJvZW0tnBQ4w=
X-Google-Smtp-Source: ADUXVKLH0DNz6P4VfKwsIMy49RErmMBbKWscDBubbIqnDsjd4Jz/vsUtBcuzdJ+nzlkVnn655Ghwzg==
X-Received: by 2002:adf:e5d0:: with SMTP id a16-v6mr600879wrn.190.1527652056825;
        Tue, 29 May 2018 20:47:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y42-v6sm62561868wry.21.2018.05.29.20.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 20:47:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 5/5] fetch: implement fetch.fsck.*
References: <20180525192811.25680-1-avarab@gmail.com>
        <20180524193516.28713-1-avarab@gmail.com>
        <20180525192811.25680-6-avarab@gmail.com>
Date:   Wed, 30 May 2018 12:47:35 +0900
In-Reply-To: <20180525192811.25680-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 25 May 2018 19:28:11 +0000")
Message-ID: <xmqqin75ere0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier I mumbled "this 4-patch series generally looks good but I
need to re-read the implementation step"; I meant this 5-patch
series and here is my impression after re-reading the implementation
step.

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f97f21c022..f69cd31ad0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1426,6 +1426,16 @@ fetch.fsckObjects::
> ...

Nicely written.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 490c38f833..9e4282788e 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -19,6 +19,7 @@
>  #include "sha1-array.h"
>  #include "oidset.h"
>  #include "packfile.h"
> +#include "fsck.h"
>  
>  static int transfer_unpack_limit = -1;
>  static int fetch_unpack_limit = -1;
> @@ -33,6 +34,7 @@ static int agent_supported;
>  static int server_supports_filtering;
>  static struct lock_file shallow_lock;
>  static const char *alternate_shallow_file;
> +static struct strbuf fsck_msg_types = STRBUF_INIT;

s/msg_types[]/exclude[]/ or something, as this is not just about "we
tolerate known and future instances of 0-padded mode in trees", but
also "we know this and that object is bad so do not complain" as well.

Other than that, the implementation looks good.

> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
> index 49d3621a92..b7f5222c2b 100755
> --- a/t/t5504-fetch-receive-strict.sh
> +++ b/t/t5504-fetch-receive-strict.sh
> @@ -135,6 +135,20 @@ test_expect_success 'push with receive.fsck.skipList' '
>  	git push --porcelain dst bogus
>  '
>  
> +test_expect_success 'fetch with fetch.fsck.skipList' '
> +	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
> +	refspec=refs/heads/bogus:refs/heads/bogus &&
> +	git push . $commit:refs/heads/bogus &&
> +	rm -rf dst &&
> +	git init dst &&
> +	git --git-dir=dst/.git config fetch.fsckObjects true &&
> +	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
> +	git --git-dir=dst/.git config fetch.fsck.skipList dst/.git/SKIP &&
> +	echo $commit >dst/.git/SKIP &&
> +	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec
> +'

If the test does not change meaning when file://$(pwd) is replaced
with "." (or ".." or whatever if other tests below moves cwd
around), I'd think it is preferrable.  Seeing $(pwd) always makes me
nervous about Windows.
