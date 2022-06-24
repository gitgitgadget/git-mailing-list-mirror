Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F81C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 16:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiFXQsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiFXQsk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 12:48:40 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB47460DF
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 09:48:38 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t24-20020a170902b21800b00168e27c3c2aso1521215plr.18
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=nGkw47YS70ebVp6i72UltNqFWtdP/VylD4vicGjq/+k=;
        b=jmOKaY8fkjxBecDrZyKrO90/x/ycQpPz1RriFXp86fQJ0kzns1CHHyXFw+rXLmD5zC
         0ZUH2bwOqKPGLtp0Di1PI9oejLtywwWKXjs7xDgNoAZy174p10uqNcdt9sn3mCaRNc4k
         V5Ug+PEC1INgvsqSqQBAyfOBOzQepSKU5p9V9NMAFYrnhLLqFTn54SRBiOUYHdMAelxI
         +lAD3Q7+sXiQ94jLwHk5WcVeCKf/VQHUBf02PcaC0OsqrbKYwcCPNGgoTlfoKxEphphL
         0eMVZHJsIn68adnVntNJE9l/el5wplfd0TdH21eRWR13m1+Y7296JlcA7F32uIogTmnn
         1Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=nGkw47YS70ebVp6i72UltNqFWtdP/VylD4vicGjq/+k=;
        b=izC6hTqNsckxXOzJQw8YjIyqD/XzQj7OI0fZLMu3Ll3H+nEhIhXUQDM0emLeEzFD9o
         R+Vf/6SsY1PZ+3WgJCqi6xe6/CHhTNNRIJRSRIVDlICfJ77tmpKZa7kXH5ZXLUSw8TdE
         urqd9MO52z7O7pci3lI88TYve4ulBbMS+kAvdeB+Ci423pnsJQ/trfbdpAIPYTf04kE8
         hgdKUQxq1bA0D7Na5uxheEUCiJveB/vU9XnxCDpXhthC7kVltjvGeP7xcr5QIJj/bwTi
         LxKaNb5VMwTWI9o5Et/45Wz3qBukcXtyOzE6wCS3MyIzXoHqKCj8jaMSrvOMjGP+qJSN
         7fJA==
X-Gm-Message-State: AJIora+BfE6n5VelVYw0L6AaKwjgDD0WwKZtPC5kAXLQwf843OB0WEh9
        c04vhz/TSeJsUo3O6W4OedagubHgWk69GA==
X-Google-Smtp-Source: AGRyM1s4SPiR4lMOYCRREAN6CCtE5RG590Bpe/t1XD6DEI9C+0dESjDc7/rUtK1Eo+7H8Vz5YjUW+Rg5loT/+A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2403:b0:4fd:e84a:4563 with SMTP
 id z3-20020a056a00240300b004fde84a4563mr82568pfh.60.1656089318238; Fri, 24
 Jun 2022 09:48:38 -0700 (PDT)
Date:   Fri, 24 Jun 2022 09:48:36 -0700
In-Reply-To: <220624.86h74ahygt.gmgdl@evledraar.gmail.com>
Message-Id: <kl6ledzehusb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
 <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
 <patch-v3-02.12-082e015781e-20220622T142012Z-avarab@gmail.com>
 <kl6ltu8ci7r5.fsf@chooglen-macbookpro.roam.corp.google.com> <220624.86h74ahygt.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v3 02/12] git-submodule.sh: remove unused $prefix var and --super-prefix
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jun 22 2022, Glen Choo wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> Remove the $prefix variable which isn't used anymore, and hasn't been
>>> since b3c5f5cb048 (submodule: move core cmd_update() logic to C,
>>> 2022-03-15).
>>>
>>> Before that we'd use it to invoke "git submodule--helper" with the
>>> "--recursive-prefix" option, but since b3c5f5cb048 that "git
>>> submodule--helper" option is only used when it invokes itself.
>>>
>>> Since we haven't used it since then we haven't been passing the
>>> --super-prefix option to "git submodule--helper", and can therefore
>>> remove the handling of it from builtin/submodule--helper.c as well.
>>>
>>> Note also that the still-existing code in builtin/submodule--helper.c
>>> to invoke other "git submodule--helper" processes with
>>> "--super-prefix" is not passing the option to
>>> "cmd_submodule__helper()", rather it's an argument to "git" itself.
>>>
>>> One way to verify that this is indeed dead code is to try to check out
>>> b3c5f5cb048^ and apply this change to a part of the code being removed
>>> here:
>>>
>>> 	-#define SUPPORT_SUPER_PREFIX (1<<0)
>>> 	+#define SUPPORT_SUPER_PREFIX 0
>>>
>>> Doing that will cause t7406-submodule-update.sh to fail with errors
>>> such as:
>>>
>>> 	-Submodule path '../super': checked out 'e1c658656b91df52a4634fbffeaa7=
39807ce3521'
>>> 	+Submodule path 'super': checked out 'e1c658656b91df52a4634fbffeaa7398=
07ce3521'
>>>
>>> I.e. the removal of the --super-prefix handling broke those cases, but
>>> when doing the same ad-hoc test with b3c5f5cb048 all of our tests will
>>> pass, since the "--super-prefix" will now be handled by earlier by
>>> "git" itself.
>>
>> Your finding is correct, but I just can't figure out why it is this way.
>> Neither b3c5f5cb048 nor b3c5f5cb048^ make any use of "--super-prefix"
>> (both use "--recursive-prefix"). And what's most puzzling to me is...
>>
>>> @@ -3402,15 +3399,9 @@ int cmd_submodule__helper(int argc, const char *=
*argv, const char *prefix)
>>>  	if (argc < 2 || !strcmp(argv[1], "-h"))
>>>  		usage("git submodule--helper <command>");
>>> =20
>>> -	for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
>>> -		if (!strcmp(argv[1], commands[i].cmd)) {
>>> -			if (get_super_prefix() &&
>>> -			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
>>> -				die(_("%s doesn't support --super-prefix"),
>>> -				    commands[i].cmd);
>>> +	for (i =3D 0; i < ARRAY_SIZE(commands); i++)
>>> +		if (!strcmp(argv[1], commands[i].cmd))
>>>  			return commands[i].fn(argc - 1, argv + 1, prefix);
>>> -		}
>>> -	}
>>> =20
>>>  	die(_("'%s' is not a valid submodule--helper "
>>>  	      "subcommand"), argv[1]);
>>
>> that all we do here is die() if we see "--super-prefix" but it is not
>> supported. I wouldn't expect that the printed result is different; I'd
>> expect git to die(). This isn't even an issue with SUPPORT_SUPER_PREFIX
>> either - if we just had:
>>
>> 	if (get_super_prefix())
>> 		die(_("%s doesn't support --super-prefix"),
>> 		    commands[i].cmd);
>>
>> we still see the same failure. At any rate, we don't seem to need
>> "--super-prefix" any more, so I didn't look deeper into it.
>>
>> One thing that I noticed (while trying to replace "--recursive-prefix"
>> with "--super-prefix" is that since this check checks the environment
>> for the super prefix and not the CLI option, it will complain if we do
>> "git --super-prefix=3Dfoo submodule unsupported-command", and e.g. t7407
>> will fail if we add
>>
>>   -	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
>>   +	{"foreach", module_foreach, 0},
>>
>> I don't like this check but for another reason: the super prefix is set
>> in a GIT_* environment variable so it gets passed to all child
>> processes. So e.g. if we teach "git submodule update" to use
>> "--super-prefix", we must mark module_update with SUPPORT_SUPER_PREFIX.
>> But because that invokes "git submodule clone", "module_clone" must also
>> be marked SUPPORT_SUPER_PREFIX.
>>
>> Frankly, I'm not sure why we need to check for SUPPORT_SUPER_PREFIX in
>> the "git submodule--helper" subcommand. I see that it was introduced in
>> 89c8626557 (submodule helper: support super prefix, 2016-12-08) as part
>> of what eventually became absorbgitdirs, but I couldn't find any
>> discussion of why we need this check when it was first proposed [1].
>>
>> I'm not 100% sure of why we need the top level check either, but as I
>> understand it, it's a way of saying whether a command "supports
>> submodules" or not [2]. If so, then checking whether a "git
>> submodule--helper" command can recurse into submodules sounds like a
>> pointless exercise.
>>
>> I'm still all for deleting this because it really doesn't seem useful,
>> but I'd be lot more confident if someone knows why we have this to begin
>> with.
>>
>> [1] https://lore.kernel.org/git/20161122192235.6055-1-sbeller@google.com=
/
>> [2] https://lore.kernel.org/git/1474930003-83750-2-git-send-email-bmwill=
@google.com/
>
> I think I figured this out. I'm right about it being unnecessary, but
> the explanation in the commit message is wrong.
>
> What threw me off the trail is that the series that included b3c5f5cb048
> (submodule: move core cmd_update() logic to C, 2022-03-15) has in
> intra-series regression, which is what you're seeing here.
>
> I.e. its parent 75df9df0f81 (submodule--helper: reduce logic in
> run_update_procedure(), 2022-03-15) will fail with the above "../super"
> error without that local change. You won't get the failure on its
> parent, c9911c9358e (submodule--helper: teach update_data more options,
> 2022-03-15).
>
> I.e. 75df9df0f81 & b3c5f5cb048 should have been squashed, anyway.
>
> The actual point *for that test* at which we could have deleted that
> "define" is 29a5e9e1ffe (submodule--helper update-clone: learn --init,
> 2022-03-04), but other tests fail.
>
> The actual point is this commit in this series, I'll dig some more,
> sorry about sending you down the wrong path. That digression was just
> about chechking if we'd passed --super-prefix, which is changed in this
> same commit...
>
> I'll dig some more and re-roll.

Ah that might explain some things. I'm still not sure how removing
SUPPORT_SUPER_PREFIX gives the result we see here, but here are some
observations using the extra info I learned while converting
"--recursive-prefix" -> "--super-prefix":

- 29a5e9e1ffe and its parent teach init_submodule() how to use the
  "--recursive-prefix" flag as a substitute for "--super-prefix".
  "--recursive-prefix" is used exclusively by "git submodule update" and
  does exactly the same thing as "--super-prefix".

  Those commits pass "--recursive-prefix" to
  do_get_submodule_displaypath(), which is an escape hatch to
  get_submodule_displaypath() (which always uses "--super-prefix").

- 75df9df0f81 introduced a regression because we now pass
  update_data.prefix to get_submodule_displaypath() instead of prefix,
  and update_data.prefix was never set (oops, that's my mistake). This
  was rectified in its child (b3c5f5cb048), where we start to set
  update_data.prefix when the two subcommands were combined.

  As a sidenote, in 75df9df0f81's diff, we see that recursive_prefix is
  used in conjunction with get_submodule_displaypath(), which means that
  we could theoretically use *both* "--recursive-prefix" AND
  "--super-prefix" at the same time. We don't do that though, because
  "--super-prefix" was never used by "git submodule update".

  (This prefixed_path stuff is going away when I convert
  "--recursive-prefix" to "--super-prefix", so don't feel the need to
  clean it up).
