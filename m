Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812DBC433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 02:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbiBSCKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 21:10:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiBSCKB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 21:10:01 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEC85418B
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 18:09:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s14so1040508edw.0
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 18:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/5LNve4H6uYwYbLfKHwMNLE7Z3yXbNpi2N4sSWVca/U=;
        b=ZOXy9pbz4XIkgkm5FVZTDai7ysNOYyk0EwP32dCI7hUDcmiB7oTbmOk3ZuvazkR2sJ
         l4qVVaZJz+A8Y8yFtWKnMvZgSQlYj5qnSMLqZNPBFPG3gDLja7FFmP7eqzaH6wtISriJ
         2FsnioTOZrTmqdkx0L+YcfPENGoerOSmNpUcQbkbldFlvItnYJFe8LfIziDN6j+gZ1eh
         Pd8E7aqbqWhW2A4ivrJ7/qf0ZFOylbknAHDDdUL+xSI54XD2if8QDpU/aWuEf1zXcbLD
         RfeguVmrVyDgZqhfE1iAoruVARIm3lqSWPyGyjXERhG6dPzRxZNxltVe63GwkziHDA/W
         138g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/5LNve4H6uYwYbLfKHwMNLE7Z3yXbNpi2N4sSWVca/U=;
        b=rtqZbq/tr+9L/scAsV4LACuOA6K9rLkbA1H25FdTWvRQ8cXdOSfKIFgA5BUXjb+4tM
         6fAiFWZm9K8qjSkBtFffVyZpdk+2MVpMrcobjPkrpWB56ZRlnhg1P+FTQgchjRhAgofr
         JKtkBh3yoAwG1v57mzjDy750DJ7+pXw5hG2bBYFk1fC0EL2c8AKaBZtTimvFEMTc4JvA
         pnwrofNdwWCM2qmmehcoseUmfQyiqph54KRGzwl+O/xLCGtQND2sqZnI/swQlPhkTSBd
         DJZ/gdRCKdaoux0WjzUoz7LkhtgeYumYoofZtNZ7MUgi1hANb+RbOkS+DTxKVk5mZmpd
         Md3g==
X-Gm-Message-State: AOAM5329Zl8FHEkxiIvJxXsjQlJkrRX5PY6PeQPtcUAE2qLn4X4YynIB
        j8TJgVh5pAguxGPFtHmX+FQ=
X-Google-Smtp-Source: ABdhPJz2Re3WK0HP2UI8OeX6aULv+JRmPwHpK5Nygp6Qd0qesC2M0flz5ERdQUFx62LB5azFOsvPGA==
X-Received: by 2002:a05:6402:4c6:b0:410:b8e5:334 with SMTP id n6-20020a05640204c600b00410b8e50334mr10882996edw.321.1645236579160;
        Fri, 18 Feb 2022 18:09:39 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x7sm2306258edr.12.2022.02.18.18.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 18:09:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLFBq-004dfX-2O;
        Sat, 19 Feb 2022 03:09:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] test-lib: make $GIT_BUILD_DIR an absolute path
Date:   Sat, 19 Feb 2022 02:58:48 +0100
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
 <patch-2.4-4c53c6157ac-20220218T205753Z-avarab@gmail.com>
 <xmqqee3zycpg.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqee3zycpg.fsf@gitster.g>
Message-ID: <220219.86y227fvz1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the GIT_BUILD_DIR from a path like "/path/to/build/t/.." to
>> "/path/to/build". The "TEST_DIRECTORY" here is already made an
>> absolute path a few lines above this.
>>
>> This will be helpful to LSAN_OPTIONS which will want to strip the
>> build directory path from filenames, which we couldn't do if we had a
>> "/.." in there.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/test-lib.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 3212966a82f..4f523b82ce5 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -34,7 +34,7 @@ then
>>  	# elsewhere
>>  	TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
>>  fi
>> -GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
>> +GIT_BUILD_DIR=3D"${TEST_DIRECTORY%/t}"
>
> This makes perfect sense in the normal case, but the provision the
> code that precedes this part has, i.e.
>
>     if test -z "$TEST_DIRECTORY"
>     then
>             # We allow tests to override this, in case they want to run t=
ests
>             # outside of t/, e.g. for running tests on the test library
>             # itself.
>             TEST_DIRECTORY=3D$(pwd)
>     else
>             # ensure that TEST_DIRECTORY is an absolute path so that it
>             # is valid even if the current working directory is changed
>             TEST_DIRECTORY=3D$(cd "$TEST_DIRECTORY" && pwd) || exit 1
>     fi
>
> to allow TEST_DIRECTORY to be set externally robs the guarantee that
> you can sensibly strip "/t" from its tail and expect everything to
> work correctly.  The only thing the original requires on such an
> externally given TEST_DIRECTORY is that one level above it is usable
> as GIT_BUILD_DIR.
>
> IOW,
>
> 	GIT_BUILD_DIR=3D"$(cd "$TEST_DIRECTORY/.." && pwd)"
>
> would give you what you want to achieve in either code path, as long
> as the original was working correctly for whatever value that is
> given to TEST_DIRECTORY externally.
>
> So, perhaps
>
> 	if test -z "$TEST_DIRECTORY"
> 	then
> 		TEST_DIRECTORY=3D$(pwd)
> 		GIT_BUILD_DIR=3D${TEST_DIRECTORY%/t}
> 	else
> 		TEST_DIRECTORY=3D$(cd "$TEST_DIRECTORY" && pwd) &&
> 		GIT_BUILD_DIR=3D$(cd "$TEST_DIRECTORY/.." && pwd)
> 	fi
>
> or something like that?  I dunno.

I think you're being led astray by the "we allow tests to override this"
comment, which is something I added in 62f539043c7 (test-lib: Allow
overriding of TEST_DIRECTORY, 2010-08-19). I'm having some trouble
understanding what I meant at the time.

But it's not the case that we support a TEST_DIRECTORY pointing to
something that isn't inside the "t/" directory in our tree, as looking
at uses of the two shows:
=20=20=20=20
    $ git grep -E '\$(GIT_BUILD_DIR|TEST_DIRECTORY)' -- t/test-lib.sh
    t/test-lib.sh:if test -z "$TEST_DIRECTORY"
    t/test-lib.sh:  TEST_DIRECTORY=3D$(cd "$TEST_DIRECTORY" && pwd) || exit=
 1
    t/test-lib.sh:  TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
    t/test-lib.sh:GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
    t/test-lib.sh:if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
    t/test-lib.sh:. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
    t/test-lib.sh:"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
    t/test-lib.sh:. "$TEST_DIRECTORY/test-lib-functions.sh"
    t/test-lib.sh:                  $(printf '%s\n' "$1" | sed -f "$GIT_BUI=
LD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!')
    t/test-lib.sh:                  symlink_target=3D"$GIT_BUILD_DIR/t/help=
er/$base"
    t/test-lib.sh:                  symlink_target=3D"$GIT_BUILD_DIR/$base"
    t/test-lib.sh:  GIT_VALGRIND=3D$TEST_DIRECTORY/valgrind
    t/test-lib.sh:  for file in $GIT_BUILD_DIR/git* $GIT_BUILD_DIR/t/helper=
/test-*
    t/test-lib.sh:  make_symlink "$GIT_BUILD_DIR"/mergetools "$GIT_VALGRIND=
/bin/mergetools"
    t/test-lib.sh:  PATH=3D$GIT_TEST_INSTALLED:$GIT_BUILD_DIR/t/helper:$PATH
    t/test-lib.sh:          git_bin_dir=3D"$GIT_BUILD_DIR/bin-wrappers"
    t/test-lib.sh:  GIT_EXEC_PATH=3D$GIT_BUILD_DIR
    t/test-lib.sh:          PATH=3D"$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:=
$PATH"
    t/test-lib.sh:GIT_TEMPLATE_DIR=3D"$GIT_BUILD_DIR"/templates/blt
    t/test-lib.sh:GITPERLLIB=3D"$GIT_BUILD_DIR"/perl/build/lib
    t/test-lib.sh:test -d "$GIT_BUILD_DIR"/templates/blt || {
    t/test-lib.sh:if ! test -x "$GIT_BUILD_DIR"/t/helper/test-tool$X

I.e. we already depend on the build dir being one-above the
TEST_DIRECTORY, and per test-lib.sh we load test-lib-functions.sh from
$TEST_DIRECTORY, and refer to $GIT_BUILD_DIR/t/... for various things
(e.g. t/helper).

That being said it was a bit of a micro-optimization of mine to avoid a
"&& pwd" there, and perhaps it was too clever.

But I do think we can 100% rely on just stripping the "/t" from the end
of the string.

Re-reading it again, what that comment really meant to say is that we
allow overriding TEST_DIRECTORY from $(pwd) because when we run that
test-lib.sh we may be in another directory.

But that overriding code still sets us to the same directory, which ends
in a "/t". See my subsequent 7b905119703 (t/t0000-basic.sh: Run the
passing TODO test inside its own test-lib, 2010-08-19) for the first use
of it.

I.e. it's for the t0000-basic.sh testing where we run sub-tests, which
now live in t/lib-subtest.sh.

So I could keep that code as-is for a re-roll, but adjust the misleading
comment while I'm at it, how does that sound?
