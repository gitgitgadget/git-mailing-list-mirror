Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCDDC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 23:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiFVXoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 19:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFVXoK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 19:44:10 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E6E427EA
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 16:44:09 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m5-20020a170902768500b0016a1c410f6cso6348051pll.13
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 16:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=+S/rT4Nk+kv/q4RIHqY7vDfk1ZewFbGYHgA2JTE3SIQ=;
        b=LrjFkx65GxMpvSrCdNjRLTaR5nDBNOlTtpKRmxrYOWaGwJzsTylQwOjrs+lSDaVhbd
         +4lcx5p/0vm8sWQqGa1LEx8LTrGvcFNqqKj2h2tnG3a4sD3GtKPzCpID4gqtk3f48NUo
         qNJQ5LMS/dExkdFMaSzUjCwuMlfIyp3DwZcMzsHbQujVHmrKyiacf7lBfPvQzosxKoiz
         G7PjNvfOUPXLrg8p1YhE3C3DiWaGyOOJWrIt8gnkq7UFU6vPkfHgPOzF9Yr0u9NroI0k
         1dTRus1a33VAsEi2LnVIWzH7Wdl0xlMdbA6AJRguxzh4zLGf7retQPqB8dar1EHP6QXK
         K9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=+S/rT4Nk+kv/q4RIHqY7vDfk1ZewFbGYHgA2JTE3SIQ=;
        b=YYOnBdK1lc2KF+pvURjShyZu4qgRS7F9HyyCnP86JWntaQcVSD1qQXGnCbUKaQwORx
         DqxPzlhBCtm5k1Wbt43Nyo/v2EyYBBQK1kpjpUMHBoV6Iaz/nlgIrg4Ow2YDQz/eukgJ
         NJtK7kL34iXGlrmrv0znmGPAwbqX7SssSbdySBE0wWiVI6228CUD0PkHJtbHcnQgZD+e
         WbLxCuK/oH6CX08zDD0gmw3KweQqgB/SZNIcP41kYYwJrO7hJKexxfyuTNv6GlqL5ZHR
         F3bDTAj289vSmus3DcP+oUIlp4ctMyyTxsDxepPluUqY7q3Auq91ME531pKCx43WBSO3
         IYnw==
X-Gm-Message-State: AJIora/LMm3Sl++tFzr21aIj2cvfzwHjpJMzk856Pl47NCvKRCwbZvR8
        6IJIIUoIGo4J38v7iwiMdozVcTzpOdY6LA==
X-Google-Smtp-Source: AGRyM1tO+C2N2E2p+jl2w0N6ImmAAc3vQuCtTVhaV5MxbgVO/v2npHx/HbFzXa6X7pM/LX+UUhNBfFXN9ozkSA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:6946:0:b0:40d:e26:f2e0 with SMTP id
 e67-20020a636946000000b0040d0e26f2e0mr5001876pgc.118.1655941449080; Wed, 22
 Jun 2022 16:44:09 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:43:58 -0700
In-Reply-To: <patch-v3-02.12-082e015781e-20220622T142012Z-avarab@gmail.com>
Message-Id: <kl6ltu8ci7r5.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
 <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <patch-v3-02.12-082e015781e-20220622T142012Z-avarab@gmail.com>
Subject: Re: [PATCH v3 02/12] git-submodule.sh: remove unused $prefix var and --super-prefix
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Remove the $prefix variable which isn't used anymore, and hasn't been
> since b3c5f5cb048 (submodule: move core cmd_update() logic to C,
> 2022-03-15).
>
> Before that we'd use it to invoke "git submodule--helper" with the
> "--recursive-prefix" option, but since b3c5f5cb048 that "git
> submodule--helper" option is only used when it invokes itself.
>
> Since we haven't used it since then we haven't been passing the
> --super-prefix option to "git submodule--helper", and can therefore
> remove the handling of it from builtin/submodule--helper.c as well.
>
> Note also that the still-existing code in builtin/submodule--helper.c
> to invoke other "git submodule--helper" processes with
> "--super-prefix" is not passing the option to
> "cmd_submodule__helper()", rather it's an argument to "git" itself.
>
> One way to verify that this is indeed dead code is to try to check out
> b3c5f5cb048^ and apply this change to a part of the code being removed
> here:
>
> 	-#define SUPPORT_SUPER_PREFIX (1<<0)
> 	+#define SUPPORT_SUPER_PREFIX 0
>
> Doing that will cause t7406-submodule-update.sh to fail with errors
> such as:
>
> 	-Submodule path '../super': checked out 'e1c658656b91df52a4634fbffeaa739=
807ce3521'
> 	+Submodule path 'super': checked out 'e1c658656b91df52a4634fbffeaa739807=
ce3521'
>
> I.e. the removal of the --super-prefix handling broke those cases, but
> when doing the same ad-hoc test with b3c5f5cb048 all of our tests will
> pass, since the "--super-prefix" will now be handled by earlier by
> "git" itself.

Your finding is correct, but I just can't figure out why it is this way.
Neither b3c5f5cb048 nor b3c5f5cb048^ make any use of "--super-prefix"
(both use "--recursive-prefix"). And what's most puzzling to me is...

> @@ -3402,15 +3399,9 @@ int cmd_submodule__helper(int argc, const char **a=
rgv, const char *prefix)
>  	if (argc < 2 || !strcmp(argv[1], "-h"))
>  		usage("git submodule--helper <command>");
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
> -		if (!strcmp(argv[1], commands[i].cmd)) {
> -			if (get_super_prefix() &&
> -			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
> -				die(_("%s doesn't support --super-prefix"),
> -				    commands[i].cmd);
> +	for (i =3D 0; i < ARRAY_SIZE(commands); i++)
> +		if (!strcmp(argv[1], commands[i].cmd))
>  			return commands[i].fn(argc - 1, argv + 1, prefix);
> -		}
> -	}
> =20
>  	die(_("'%s' is not a valid submodule--helper "
>  	      "subcommand"), argv[1]);

that all we do here is die() if we see "--super-prefix" but it is not
supported. I wouldn't expect that the printed result is different; I'd
expect git to die(). This isn't even an issue with SUPPORT_SUPER_PREFIX
either - if we just had:

	if (get_super_prefix())
		die(_("%s doesn't support --super-prefix"),
		    commands[i].cmd);

we still see the same failure. At any rate, we don't seem to need
"--super-prefix" any more, so I didn't look deeper into it.

One thing that I noticed (while trying to replace "--recursive-prefix"
with "--super-prefix" is that since this check checks the environment
for the super prefix and not the CLI option, it will complain if we do
"git --super-prefix=3Dfoo submodule unsupported-command", and e.g. t7407
will fail if we add

  -	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
  +	{"foreach", module_foreach, 0},

I don't like this check but for another reason: the super prefix is set
in a GIT_* environment variable so it gets passed to all child
processes. So e.g. if we teach "git submodule update" to use
"--super-prefix", we must mark module_update with SUPPORT_SUPER_PREFIX.
But because that invokes "git submodule clone", "module_clone" must also
be marked SUPPORT_SUPER_PREFIX.

Frankly, I'm not sure why we need to check for SUPPORT_SUPER_PREFIX in
the "git submodule--helper" subcommand. I see that it was introduced in
89c8626557 (submodule helper: support super prefix, 2016-12-08) as part
of what eventually became absorbgitdirs, but I couldn't find any
discussion of why we need this check when it was first proposed [1].

I'm not 100% sure of why we need the top level check either, but as I
understand it, it's a way of saying whether a command "supports
submodules" or not [2]. If so, then checking whether a "git
submodule--helper" command can recurse into submodules sounds like a
pointless exercise.

I'm still all for deleting this because it really doesn't seem useful,
but I'd be lot more confident if someone knows why we have this to begin
with.

[1] https://lore.kernel.org/git/20161122192235.6055-1-sbeller@google.com/
[2] https://lore.kernel.org/git/1474930003-83750-2-git-send-email-bmwill@go=
ogle.com/
