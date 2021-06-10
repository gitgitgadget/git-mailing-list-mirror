Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7160CC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AC5613FE
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFJN3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFJN3g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:29:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4E7C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 06:27:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ba2so31283062edb.2
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AALfg99t50VoC9DN/hWyuS/0+nw52+l1Puz079pOy50=;
        b=Y8QYbwh/G5NSHiNdaU5cpu4N6uUPtQpoiOEwjuy8tOR/V6HeD2g4HWe6DVbZK0IwVg
         pDhKpnyXw7PcCvafia8lbJQjLBFbBsYZPiMZDa6+XV5cCkxRgku7QkAb4choI6Q6AaW9
         8Ww65f1mUSsTYkEkbJcje5/+c117UBARQKPoZJxZT3JEeGKyBN6xWP2SA42xZWrQsy5l
         vdrRKnSvIbaG98H7Ys3ni2uR9P0EBGU1gIP0HQTz+6cO/rlLSuNLXtoZ22+eV4z2uApi
         g/W/Paf6LNJXjYqDutsGNwXUY5m0myVzC6GqhnmsKFVQ6YBsvxWCpMaqHU0qISgCBW5C
         O+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AALfg99t50VoC9DN/hWyuS/0+nw52+l1Puz079pOy50=;
        b=Bma/QybK3Y2XvDYHtdJ8OqXbTVqoT2IRYqHa7ltLA60ros1ODU03+heoEai50ncazF
         Eeb5aXX0LcRVkInNEj8JDTqKDDvQ+SFU0n8pYThd4IgxuJY96M0VzawlVHFrcpHPoDa6
         U7HIV6IfqGDcS2CR25yu/X0DETK1h5YecHYpykJnm4HyGrPEXc8kzcLS5yt3pzaHnfIS
         nPOFh+sS8CuD4ElwdyZ2h4uJz9Ri1KTjV9qp9122n7O1nJmkhCI4L4YE0LF6HUHOP+dT
         N/BfBm7A22nXDYqXeT2htWUKQSoQDx8ayUYl0qlihoWaHLhD8lxSnNSHt1/PHnmNCoFN
         MIOQ==
X-Gm-Message-State: AOAM5321ACATZlxwB+jSjwP5Id1CTVL+nH5Ba3Lal4aJCPnlKHmuAmRu
        o6R23pTM3SSs0eoJWLeX7ak=
X-Google-Smtp-Source: ABdhPJxifB7Wu7eM9W19j9MP/QAUKNvZSFFBWWkpnjnjfhMTxrMFhUVZPQ3FcU2La3Fks4tk/Fyelg==
X-Received: by 2002:a05:6402:1ac9:: with SMTP id ba9mr4840011edb.250.1623331656291;
        Thu, 10 Jun 2021 06:27:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g11sm1372989edt.85.2021.06.10.06.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 06:27:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtins + test helpers: use return instead of exit()
 in cmd_*
Date:   Thu, 10 Jun 2021 15:19:37 +0200
References: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
 <YL8S9jDmrtdKr5N+@coredump.intra.peff.net>
 <71775f7d-eb60-7fdc-731e-d370f620735e@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <71775f7d-eb60-7fdc-731e-d370f620735e@gmail.com>
Message-ID: <87v96l26k8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 10 2021, Phillip Wood wrote:

> On 08/06/2021 07:49, Jeff King wrote:
>> On Mon, Jun 07, 2021 at 01:12:48PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>=20
>>> Change various cmd_* functions to use "return" instead of exit() to
>>> indicate an exit code. On Solaris with SunCC the compiler legitimately
>>> complains about these, since we'll e.g. skip the cleanup (e.g. closing
>>> fd's, erroring if we can't) in git.c's run_builtin() when we exit()
>>> directly like this.
>> Each of these cases looks like a simple and obvious conversion, and
>> I
>> certainly don't mind us doing it.
>> But I do wonder what SunCC is complaining about exactly. Calling
>> exit()
>> means you don't have to worry about cleanup anymore. Does the compiler
>> not have any notion of NORETURN or equivalent? If so, I'd expect many
>> more complaints in general that we probably _won't_ want to silence,
>> because it will be awkward to do so.
>
> It is curious that is only complaining abut exit() calls and not
> die(), maybe that is just a coincidence though if it is not
> complaining about all calls to exit()

It's "function has no return statement", usually things that die() will
also return if nothing goes wrong.

It also complains about e.g. cram() in imap-send.c under NO_OPENSSL=3DY,
which is an "non-void" returning function stub that just calls die().

I recall raising that on-list in the past and proposing that they have a
dummy return value, but that met lukewarm support, so I just consider
them false alarms and try to ignore them.

I do think we should have "die_report" or whatever versions of die() so you=
 could do:

    return die_report(...);

You can do that with error(), but that means changing the error message
from "fatal:" to "error:". Those cases are obscure though, e.g. piping
to a full disk where we'd die for other reasons. Now we'll hide that
error.

I mean, we'd do so anyway since cmd_builtin() in git.c won't reach the
"closing fd's" check, but that could be fixed, and there's other similar
cases where we needlessly conflate the desire to say "fatal" and exit
with 128 with returning an error and doing cleanup etc.

>>> diff --git a/builtin/difftool.c b/builtin/difftool.c
>>> index 89334b77fb..6a9242a803 100644
>>> --- a/builtin/difftool.c
>>> +++ b/builtin/difftool.c
>>> @@ -675,7 +675,7 @@ static int run_file_diff(int prompt, const char *pr=
efix,
>>>   		"GIT_PAGER=3D", "GIT_EXTERNAL_DIFF=3Dgit-difftool--helper", NULL,
>>>   		NULL
>>>   	};
>>> -	int ret =3D 0, i;
>>> +	int i;
>>>     	if (prompt > 0)
>>>   		env[2] =3D "GIT_DIFFTOOL_PROMPT=3Dtrue";
>>> @@ -686,8 +686,7 @@ static int run_file_diff(int prompt, const char *pr=
efix,
>>>   	strvec_push(&args, "diff");
>>>   	for (i =3D 0; i < argc; i++)
>>>   		strvec_push(&args, argv[i]);
>>> -	ret =3D run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
>>> -	exit(ret);
>>> +	return run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
>>>   }
>> This one I'm not surprised that a compiler would complain about. The
>> function returns an int, but there are no return paths from the
>> function (and hence the caller doing "return run_diff_files()" likewise
>> could not ever return there. Which is not quite what you said it
>> complained about above, hence my curiosity. :)
>> -Peff
>>=20

