Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3CAC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B25361029
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbhIMTXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240837AbhIMTXh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:23:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9F6C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:22:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qq21so17476796ejb.10
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=IQnrGVZlb9FPvFgaFFrjGbxLACv/NR+1VBvXXs8tFjE=;
        b=GkrJ+xa+nt+9IR7waZe7vRgvjzUCHADrU9vezWZPA0ZfsRncYXowxuPtXATX7SEOxd
         G2B2r5gd32RjdvOlFkINje2ol9inGoj3rov/vihj0DxjfMz7D6gS3n3rU6wfOVGlgBg8
         dONu6OjBlGbjyouNScviM96DxaaxvFpDjCz9RabdPuAwWxwIUeajon7/Twn+48YDK1fC
         kUISDaaxGJkpVSudAjktYqnEO8zXkS/FxKwenzwp3xHFtpOVr2bMwH5fl6u4mSlWSJU8
         Od30aBo2UMOJagknrrrNLEW4EhEuMdJbhkkw1WU0/nDRv2WROCHC+goKK4Ue2CZJd8qh
         zscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=IQnrGVZlb9FPvFgaFFrjGbxLACv/NR+1VBvXXs8tFjE=;
        b=MCKCBPSkdrmr8msXfeHaQpMxl0n+G548wm92qm/cCzMYLHDvCr/Fw9RawtEHabfSFC
         lT/nCn5pdaNYZELRMI/4l1WeN5ZuOuN3n9L+9jdtyiLtaTZtMvcsdHGoFB9N7QEa1GB2
         9o+QP/WS6JJmDQT4hRjsfDlZglXisbraHi4hDS1R7v7p3pU4K+P0KbINMlLnxIQveQm9
         IrWKa44M7yYbuWVA668ib8NSpRt4sMBsIPaQ9HvBViNw7tRHiBIryJYK3R/RRE9cuxcK
         +wme9xdsQ6gDex71Vw2uB8f/e4v3jwk2NG+En/zMMhfNAF83WWyczp9uzyeOEfMZCw39
         jZ1A==
X-Gm-Message-State: AOAM533/ErLPlmzfpIW09X0b4xUI7umJ/FKfxs+WrLLW5Ye4QRtGo8U6
        BHQ0tjnp4es0rP9uEE43O8U=
X-Google-Smtp-Source: ABdhPJwWmHsHEy2+S4YdXLExiYEDlmk2z5AKgg5eIubyZfO460vjpMNSyI3uyawNC7/YmR0hnaUn5w==
X-Received: by 2002:a17:906:4d53:: with SMTP id b19mr13942957ejv.180.1631560939403;
        Mon, 13 Sep 2021 12:22:19 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lb12sm3859005ejc.28.2021.09.13.12.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:22:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/4] difftool: use run_command() API in run_file_diff()
Date:   Mon, 13 Sep 2021 21:13:43 +0200
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
 <patch-v2-3.4-2b093bd71fc-20210913T033204Z-avarab@gmail.com>
 <YT+SkhLsfE/yIqhN@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YT+SkhLsfE/yIqhN@coredump.intra.peff.net>
Message-ID: <87a6kg46xh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 13 2021, Jeff King wrote:

> On Mon, Sep 13, 2021 at 05:35:39AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Change the run_file_diff() function to use the run_command() API
>> directly, instead of invoking the run_command_v_opt_cd_env() wrapper.
>>=20
>> This allows it, like run_dir_diff(), to use the "args" from "struct
>> strvec", instead of the "const char **argv" passed into
>> cmd_difftool(). This will be used in the subsequent commit to get rid
>> of OPT_ARGUMENT() from cmd_difftool().
>
> It also fixes the existing leak of its "args" strvec.
>
> I like the general direction here of putting the child_process in the
> parent. There's a few opportunities for further cleanup it opens, but
> I'm happy whether you want to pursue them or not (I'm also happy to do
> them as real patches on top myself, but don't want to de-rail your
> series).

*nod*

>>  static int run_file_diff(int prompt, const char *prefix,
>> -			 int argc, const char **argv)
>> +			 struct child_process *child)
>>  {
>> -	struct strvec args =3D STRVEC_INIT;
>>  	const char *env[] =3D {
>>  		"GIT_PAGER=3D", "GIT_EXTERNAL_DIFF=3Dgit-difftool--helper", NULL,
>>  		NULL
>>  	};
>> -	int i;
>>=20=20
>>  	if (prompt > 0)
>>  		env[2] =3D "GIT_DIFFTOOL_PROMPT=3Dtrue";
>>  	else if (!prompt)
>>  		env[2] =3D "GIT_DIFFTOOL_NO_PROMPT=3Dtrue";
>
> This "save a NULL in env where we might stick something in later" is
> ugly. Now that we have a child_process, it might be nicer as:
>
>   strvec_push(&env.args, "GIT_PAGER=3D");
>   strvec_push(&env.args, "GIT_EXTERNAL_DIFF=3Dgit-difftool--helper");
>   if (prompt > 0)
> 	strvec_push(&env.args, "GIT_DIFFTOOL_PROMPT=3Dtrue");
>   else if (!prompt)
> 	strvec_push(&env.args, "GIT_DIFFTOOL_NO_PROMPT=3Dtrue");

Yes, I had something like that in the earlier round, but decided to try
to keep the diff minimal, churn and all that. So it would be nice, but
let's do it as some later cleanup if someone's interested.

>> +	child->git_cmd =3D 1;
>> +	child->dir =3D prefix;
>
> These are the same in run_dir_diff(). We could do more of the shared
> prep of the child_process in the caller. Likewise, we might want to pick
> up run_dir_diff()'s no_stdin and clean_on_exit settings (and unsetting
> use_shell, but I think that is already pointless; it defaults to false
> in the first place, and git_cmd takes precedence over it anyway).

*nod*, but can be left for some other time.

Aside: I did most of that removal of "argv" from the child_process
struct you suggested, it's in
avar/run-command-use-less-argv-use-args-instead in my repo if you're
curious / wanted to pick any of that up. I won't be submitting it any
time soon for the reasons noted upthread.

In any case it has rather large semantic and textual conflicts with the
outstanding hook.[ch] topic, but with that branch + that applied + a few
changes on top I was able to get the whole tree compiling & testing
successfully earlier.
