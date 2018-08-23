Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11CDB1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 17:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeHWUzW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 16:55:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46004 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeHWUzW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 16:55:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so4087550eda.12
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oVSJIjnEYk29+1m31kJTPhaHeCqy5kwmeB2HAHFMLwI=;
        b=TLZZxFlLZCHbFGHn88qwaoWgpmrLqdIcmBiIUik6oeZs8PGAcfH/e0O64qBIVjv0+v
         c413TwDN5jHEHr4uNfHVxGAVOd2dU1BYvwWF0HdTIJ/pbTBrJEtFWy01MeoDFG0jbB8B
         s/qGuw64LgVDSgXo3s30Y+4nGGcmZRMFhbRUuGkgpaDq8w5RNyyYTnliG2Msd9bK74xp
         lvoVNDQgKouFG+/yPgRd17AnMti4+KoCHdOlaZ+Rq7yq4T9rXnJdgJKk0TcVNCm7cBAZ
         qCmTmMkXCHekk6XXbt1btw/muubhshLDmVF3/IYa1oz8lBjdaBSmdUBuzY4fOLenMEXL
         8KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oVSJIjnEYk29+1m31kJTPhaHeCqy5kwmeB2HAHFMLwI=;
        b=jCR7HTk8bC8kQch0EiK80asgpUAiuROpOkIhVudev0iQmskkcqfn2vVtNisTvh7zos
         uAU1vGtqpaVN1ljroXy+htAcl/Xvtg8Tep7uqrfUQcn0Dp6YNLZrC+4tkpdMwkBDndY+
         1kJs8UwOspFP71IkUt2/4OuYdSj+2jD674mdadLYDGbW3D1gnRVBXWAlrebp4sk1FtKy
         zeDdkMjJIa4Mh/xPOj+MlEAFG41BpK/BkKLXZcVA31il0Y/FnxUz6xDMVroWmVeSLnGM
         Xj10DT516r22PHMYCqKm0Kkb9dr/lANE9yrKb7F+zxglSWn97tl6iLz9qFWYfxR+sbCK
         eFLg==
X-Gm-Message-State: AOUpUlE6oGRCyDMs7CO184H5pkpN8oLO0uu1GS/SYrsg+nHboiQfEIXX
        VW3X+dAVXLFtVEOAPr/WTKUrXzzuFRg=
X-Google-Smtp-Source: AA+uWPz7BNMIKrD4XUkh8/94bmRxZSuGwU9yYOUHnmjyi4Hffz6RnHA0ShkZ2b4hD9yPohUx9xwDuA==
X-Received: by 2002:aa7:c416:: with SMTP id j22-v6mr29420853edq.134.1535045077771;
        Thu, 23 Aug 2018 10:24:37 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id l16-v6sm2694558edb.41.2018.08.23.10.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:24:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org
Subject: Re: [PATCH] tests: fix and add lint for non-portable head -c N
References: <20180823091427.1756-1-avarab@gmail.com> <xmqqmutdjdid.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqmutdjdid.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 23 Aug 2018 19:24:36 +0200
Message-ID: <8736v5f12j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 23 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Junio: Even though this isn't a 2.19.0-rc0 regression I think it makes
>> sense for 2.19.0. The fix is trivial, and it'll unbreak (at least some
>> of) the tests on stock git on OpenBSD.
>
> I would have been a bit more sympathetic if this were recent
> regression (say, 2.18 or so), even if it is not new in this cycle,
> and the patch applied to the target track cleanly (say, maint or
> maint-2.17),

Yeah it's not a big deal if it's not in 2.19.

> but seeing that some of these are quite old, dating back to 2009, I am
> not sure I am enthused.

Note that those parts are the "while I'm at it" valgrind-specific parts,
i.e. parts of the code that likely never ran on anything except a GNU
toolchain.

> The changes certainly look trivial.  Let's apply.
>
> Thanks.
>
>>
>> OpenBSD guys: If you CC the git mailing list when you find you need to
>> apply patches like these, we're happy to fix this more pro-actively. I
>> just happened to be testing the upcoming 2.19.0 on OpenBSD and spotted
>> this.
>>
>>  t/check-non-portable-shell.pl | 1 +
>>  t/t5310-pack-bitmaps.sh       | 2 +-
>>  t/test-lib.sh                 | 4 ++--
>>  3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
>> index d5823f71d8..94a7e6165e 100755
>> --- a/t/check-non-portable-shell.pl
>> +++ b/t/check-non-portable-shell.pl
>> @@ -35,6 +35,7 @@ sub err {
>>  		chomp;
>>  	}
>>
>> +	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
>>  	/\bsed\s+-i/ and err 'sed -i is not portable';
>>  	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
>>  	/^\s*declare\s+/ and err 'arrays/declare not portable';
>> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
>> index 557bd0d0c0..7bff7923f2 100755
>> --- a/t/t5310-pack-bitmaps.sh
>> +++ b/t/t5310-pack-bitmaps.sh
>> @@ -335,7 +335,7 @@ test_expect_success 'truncated bitmap fails gracefully' '
>>  	git rev-list --use-bitmap-index --count --all >expect &&
>>  	bitmap=$(ls .git/objects/pack/*.bitmap) &&
>>  	test_when_finished "rm -f $bitmap" &&
>> -	head -c 512 <$bitmap >$bitmap.tmp &&
>> +	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
>>  	mv -f $bitmap.tmp $bitmap &&
>>  	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
>>  	test_cmp expect actual &&
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 8bb0f4348e..44288cbb59 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -867,7 +867,7 @@ then
>>  		# handle only executables, unless they are shell libraries that
>>  		# need to be in the exec-path.
>>  		test -x "$1" ||
>> -		test "# " = "$(head -c 2 <"$1")" ||
>> +		test "# " = "$(test_copy_bytes 2 <"$1")" ||
>>  		return;
>>
>>  		base=$(basename "$1")
>> @@ -882,7 +882,7 @@ then
>>  		# do not override scripts
>>  		if test -x "$symlink_target" &&
>>  		    test ! -d "$symlink_target" &&
>> -		    test "#!" != "$(head -c 2 < "$symlink_target")"
>> +		    test "#!" != "$(test_copy_bytes 2 <"$symlink_target")"
>>  		then
>>  			symlink_target=../valgrind.sh
>>  		fi
