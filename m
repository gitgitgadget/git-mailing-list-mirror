Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC7BC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiGYU4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGYU43 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:56:29 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8BC22BEC
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:56:28 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q12-20020a17090a1b0c00b001f2710822e9so3679159pjq.9
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=jzHC3/0suIAL00bsj4NELCTqU0CgkPNK8H958eAhLsU=;
        b=soGRP/mEvDtPw2FprlOs7R5m3ljtQWjNbUsFaxmyOWq9/JScri0FachvXcFF2ijGXc
         iHmaFJf3i+kKQCDJxTPvlIUQqqYoFN2iX+Mh25XruBSLzHzWSsCDZnMlbwqK7V3xfPtP
         oflwY8dOBbqtubx/1kMe3ylX8YHdZ3/a1EzoZ4UlFQr2wWrkGG3E/elgo2x6T6x/TdTH
         fJv1L8MA4tg72dsuzCuC5UMZxj3P57+zXG4og2oxxDbYsG90WAjnYSn5ooenuxGrgp5h
         wKC5rLvhGHiiut+CJ++e/ozflzi9ZpfaIk+JqpW2l8NrEeFQt0gJ0DNjDqeG83uLgVKo
         SEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=jzHC3/0suIAL00bsj4NELCTqU0CgkPNK8H958eAhLsU=;
        b=l21/bZaOB6F0F07Ibz1sscuRKuFhDZ4NhNKb8buw5EM/O/9oBqf540Lj4kZkQWJc4v
         GR2Fbh8pqfTgnpo3co/VljgwvMmVT202oZbLgQ4M256zAZp/co7M/+utAgqKmwFf6Fd7
         wToDZ/nas4lraA6OhjhjbQMONrNR1C9nAS5NmKDeTTRjOjOkOxXj8VvvJ1Uu0Ws3M7S2
         jDAXzrR+jcEXgq7Rq4WJCe4GfIeqpPU0x/jD8Cb7ejO4qB46m+2QlP3NbE8cP18d2mV2
         Ix/Ut26r/TLTd0XQdmPRKtBu0lPY1Dz2wCfLXbEFM+MrcZEQwghnVnMvOa4b51vrlwYo
         etUg==
X-Gm-Message-State: AJIora9SE46mG6L0rQJ34DtzwMS2i0r+VrmNjiOuRkrRAbxoAEIXcgik
        DW5/KpqE5uMcduBKggn270jWRVXupeRolA==
X-Google-Smtp-Source: AGRyM1vTqfGFd3KCgVgZ9nW+ZaqD4nq8i8RIyPyGvCTmtJhC5soe8Fsp0wUBi9Z3/1V2clnkyAH50YpScnxL1w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:2452:b0:16d:6d10:3e52 with SMTP
 id l18-20020a170903245200b0016d6d103e52mr7424091pls.121.1658782587961; Mon,
 25 Jul 2022 13:56:27 -0700 (PDT)
Date:   Mon, 25 Jul 2022 13:56:26 -0700
In-Reply-To: <220725.86o7xcords.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lzggwsyh1.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
 <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com> <30ac73716cbc234a1f176d2d417bf0e2b0b335cf.1657834081.git.gitgitgadget@gmail.com>
 <220725.861qu9oxl4.gmgdl@evledraar.gmail.com> <kl6l35ept0e1.fsf@chooglen-macbookpro.roam.corp.google.com>
 <220725.86o7xcords.gmgdl@evledraar.gmail.com>
Subject: Re: SANITIZE=address failure on master (was: [PATCH v8 3/5] config:
 learn `git_protected_config()`)
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Jul 25 2022, Glen Choo wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Thu, Jul 14 2022, Glen Choo via GitGitGadget wrote:
>>>
>>>> +/* Read values into protected_config. */
>>>> +static void read_protected_config(void)
>>>> +{
>>>> +	char *xdg_config =3D NULL, *user_config =3D NULL, *system_config =3D=
 NULL;
>>>> +
>>>> +	git_configset_init(&protected_config);
>>>> +
>>>> +	system_config =3D git_system_config();
>>>> +	git_global_config(&user_config, &xdg_config);
>>>> +
>>>> +	git_configset_add_file(&protected_config, system_config);
>>>> +	git_configset_add_file(&protected_config, xdg_config);
>>>> +	git_configset_add_file(&protected_config, user_config);
>>>> +	git_configset_add_parameters(&protected_config);
>>>> +
>>>> +	free(system_config);
>>>> +	free(xdg_config);
>>>> +	free(user_config);
>>>> +}
>>>
>>> Noticed after it landed on master: This change fails with:
>>>
>>> 	make SANITIZE=3Daddress test T=3Dt0410*.sh
>>>
>>> Running that manually shows that we fail like this:
>>> =09
>>> 	$ cat trash\ directory.t0410-partial-clone/httpd/error.log | grep -o A=
H0.*
>>> 	AH00163: Apache/2.4.54 (Debian) configured -- resuming normal operatio=
ns
>>> 	AH00094: Command line: '/usr/sbin/apache2 -d /home/avar/g/git/t/trash =
directory.t0410-partial-clone/httpd -f /home/avar/g/git/t/lib-httpd/apache.=
conf -c Listen 127.0.0.1:10410'
>>> 	AH01215: AddressSanitizer:DEADLYSIGNAL: /home/avar/g/git/git-http-back=
end
>>> 	AH01215: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D: /home/avar/g/=
git/git-http-backend
>>> 	AH01215: =3D=3D27820=3D=3DERROR: AddressSanitizer: SEGV on unknown add=
ress 0x000000000000 (pc 0x7f7af5dc0d66 bp 0x7fff11964450 sp 0x7fff11963be8 =
T0): /home/avar/g/git/git-http-backend
>>> 	AH01215: =3D=3D27820=3D=3DThe signal is caused by a READ memory access=
.: /home/avar/g/git/git-http-backend
>>> 	AH01215: =3D=3D27820=3D=3DHint: address points to the zero page.: /hom=
e/avar/g/git/git-http-backend
>>> 	AH01215:     #0 0x7f7af5dc0d66 in __sanitizer::internal_strlen(char co=
nst*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_libc.cpp:167:=
 /home/avar/g/git/git-http-backend
>>> 	AH01215:     #1 0x7f7af5d512f2 in __interceptor_fopen64 ../../../../sr=
c/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:6220: /ho=
me/avar/g/git/git-http-backend
>>> 	AH01215:     #2 0x562a65e37cc8 in git_fopen compat/fopen.c:22: /home/a=
var/g/git/git-http-backend
>>> 	AH01215:     #3 0x562a65df3879 in fopen_or_warn wrapper.c:431: /home/a=
var/g/git/git-http-backend
>>> 	AH01215:     #4 0x562a65a12476 in git_config_from_file_with_options co=
nfig.c:1982: /home/avar/g/git/git-http-backend
>>> 	AH01215:     #5 0x562a65a124f4 in git_config_from_file config.c:1993: =
/home/avar/g/git/git-http-backend
>>> 	AH01215:     #6 0x562a65a15288 in git_configset_add_file config.c:2389=
: /home/avar/g/git/git-http-backend
>>> 	AH01215:     #7 0x562a65a16a37 in read_protected_config config.c:2649:=
 /home/avar/g/git/git-http-backend
>>> 	AH01215:     #8 0x562a65a16b5c in git_protected_config config.c:2661: =
/home/avar/g/git/git-http-backend
>>> 	AH01215:     #9 0x562a65dd9f9a in get_upload_pack_config upload-pack.c=
:1342: /home/avar/g/git/git-http-backend
>>> 	AH01215:     #10 0x562a65ddc1cb in upload_pack_v2 upload-pack.c:1706: =
/home/avar/g/git/git-http-backend
>>> 	AH01215:     #11 0x562a65d2eb8a in process_request serve.c:308: /home/=
avar/g/git/git-http-backend
>>> 	AH01215:     #12 0x562a65d2ec18 in protocol_v2_serve_loop serve.c:323:=
 /home/avar/g/git/git-http-backend
>>> 	AH01215:     #13 0x562a6593c5ae in cmd_upload_pack builtin/upload-pack=
.c:55: /home/avar/g/git/git-http-backend
>>> 	AH01215:     #14 0x562a656cf8ff in run_builtin git.c:466: /home/avar/g=
/git/git-http-backend
>>> 	AH01215:     #15 0x562a656d02ab in handle_builtin git.c:720: /home/ava=
r/g/git/git-http-backend
>>> 	AH01215:     #16 0x562a656d09d5 in run_argv git.c:787: /home/avar/g/gi=
t/git-http-backend
>>> 	AH01215:     #17 0x562a656d174f in cmd_main git.c:920: /home/avar/g/gi=
t/git-http-backend
>>> 	AH01215:     #18 0x562a6594b0b9 in main common-main.c:56: /home/avar/g=
/git/git-http-backend
>>> 	AH01215:     #19 0x7f7af5a5681c in __libc_start_main ../csu/libc-start=
.c:332: /home/avar/g/git/git-http-backend
>>> 	AH01215:     #20 0x562a656cb209 in _start (git+0x1d1209): /home/avar/g=
/git/git-http-backend
>>> 	AH01215: : /home/avar/g/git/git-http-backend
>>> 	AH01215: AddressSanitizer can not provide additional info.: /home/avar=
/g/git/git-http-backend
>>> 	AH01215: SUMMARY: AddressSanitizer: SEGV
>>> ../../../../src/libsanitizer/sanitizer_common/sanitizer_libc.cpp:167
>>> in __sanitizer::internal_strlen(char const*):
>>> /home/avar/g/git/git-http-backend
>>> 	AH01215: =3D=3D27820=3D=3DABORTING: /home/avar/g/git/git-http-backend
>>> 	AH01215: error: upload-pack died of signal 6: /home/avar/g/git/git-htt=
p-backend
>>>
>>> (We really should have a SANITIZE=3Daddress in CI, but it takes a while=
...)
>>
>> Thanks. I narrowed the failure down to the hunk above, specifically this
>> line:
>>
>>   git_configset_add_file(&protected_config, xdg_config);
>>
>> Since xdg_config can be NULL, this results in the failing call
>> fopen_or_warn(NULL, "r").
>>
>> This logic was lifted  from do_git_config_sequence(), which checks that
>> each of the paths are not NULL. So a fix might be something like:
>>
>> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>>
>>   diff --git a/config.c b/config.c
>>   index 015bec360f..208a3dd7a7 100644
>>   --- a/config.c
>>   +++ b/config.c
>>   @@ -2645,9 +2645,13 @@ static void read_protected_config(void)
>>     system_config =3D git_system_config();
>>     git_global_config(&user_config, &xdg_config);
>>
>>   -	git_configset_add_file(&protected_config, system_config);
>>   -	git_configset_add_file(&protected_config, xdg_config);
>>   -	git_configset_add_file(&protected_config, user_config);
>>   +
>>   +	if (system_config)
>>   +		git_configset_add_file(&protected_config, system_config);
>>   +	if (xdg_config)
>>   +		git_configset_add_file(&protected_config, xdg_config);
>>   +	if (user_config)
>>   +		git_configset_add_file(&protected_config, user_config);
>>     git_configset_add_parameters(&protected_config);
>>
>>     free(system_config);
>>
>> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>>
>> I'm not sure if system_config can ever be NULL, but (xdg|user)_config is
>> NULL when $HOME is unset, and xdg_config is also unset if
>> $GIT_CONFIG_GLOBAL is set.
>
> Not having looked into it much at all: Doesn't this then introduce
> another logic error where git_protected_config() is now buggy, i.e. it's
> a "lazy load" method where we'll expect to read_protected_config()
> first.
>
> The assumption with that seems to have been that it's invariant within a
> single process, is that still the case, or can e.g. HOME be set during
> our runtime when we rely on these functions?
>
> (I don't know)

I don't think this introduces an error, or at least, not one that we
don't already have. This mimics do_git_config_sequence() (which also
assumes this invariant), which is used under the hood by
(git|repo)_read_config(),

In retrospect, it might have been a good idea to implement
read_protected_config() using do_git_config_sequence() /
config_with_options(); those functions are a bit bloated, but at least
we'd only have one implementation.
