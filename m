Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A45C43217
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 09:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJRJZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJRJZd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 05:25:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3622E5E64B
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 02:25:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t16so326359edd.2
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6gJBvusA/I3w+ZKfi3MG6LIq9AuuLPvulkMq4lAysbk=;
        b=Ti8dMibkrzJF8Vk36alEoWxOYzlx/W4KLM3/SX/mPTd2hlqKRHuxGHYk9L06cllcWR
         nQRdjA1ja/fgvPr1MQdsKOrQE4NSR305GSR1x50wOI5rNkenSnqujypmr8X4a/v9pu+t
         6KUNuvRbSNlg/13Plckts/DgpwOuogfqOYJ8okLmUzuYryZIotezEIXm3FczoszXqxgf
         mDVqasYvlTGxL5IbC6Hn9jCWNMsIybhUpdb13MHXZANYmffPtq7V05dyrJJ4kjunW2X7
         tQshm3DyjFWcEgrEI5aWPTyIhGOnExjQB5fozD7ysKQR34uRzBPWdaWyJjAIG2axm0Bs
         +0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6gJBvusA/I3w+ZKfi3MG6LIq9AuuLPvulkMq4lAysbk=;
        b=zkqJQrzTns0SZjROSb1+9pCkIBktUT16G0st9Vcs99EkB42p9cZHZm5fHJSP5I2JAi
         PsRC3iN95ef31OiWw63R7EEoEGH18lhp8uQcK2CHOiBTYsBBQP3IPeeAiOQzhthL+Pgo
         TI7XXyl9Fgbrifceq25jY3hTtHuTtsGMDncvv35eZrbG6w3Z8mFE7lkf2ovP0aaQzJ2n
         Yto7vT4q69KkuRk/KY7kYuvU5Q/m9UaO+/MSkUmAB4WoSjJT5WuzOZcc9VbOEgp1qmMB
         2oPxdYy1nm57dpHyEQawv4xcSkmpx9OjwNEvVHY/MI13H6nCuVzzr26toA8lFODGEmT6
         OF+w==
X-Gm-Message-State: ACrzQf2j2TaMKsdC5m0M0snXViZ33Czhf3hYpLR2xZZTYWh1SOh2jC99
        O3UfSW3I1L38LuWosQvStaTZULk5DhQjEA==
X-Google-Smtp-Source: AMsMyM5MT+cuGt/STLWRoI04akDN5WNmLAatkoiSwOBpq/TMRo3PBLQ0zIR5OOrHrEsX5D+oX/PC+A==
X-Received: by 2002:a50:ec8f:0:b0:459:b0e0:e030 with SMTP id e15-20020a50ec8f000000b00459b0e0e030mr1737292edr.303.1666085108512;
        Tue, 18 Oct 2022 02:25:08 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906304800b0077b2b0563f4sm7358530ejd.173.2022.10.18.02.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:25:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okiqQ-005hIq-0t;
        Tue, 18 Oct 2022 11:25:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     --cc=avarab@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 2/2] notes.c: fixed tip when target and append note
 are both empty
Date:   Tue, 18 Oct 2022 11:23:10 +0200
References: <221013.86wn94kqq1.gmgdl@evledraar.gmail.com>
 <20221018031144.73730-1-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221018031144.73730-1-tenglong.tl@alibaba-inc.com>
Message-ID: <221018.864jw1jxfx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 18 2022, Teng Long wrote:

> "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason" <avarab@gmail.com> writes:
>
>> Hrm, interesting that (at least my) gcc doesn't catch if we don't
>> NULL-initialize this, but -fanalyzer does (usually it's not needed for
>> such trivial cases0. Anyawy...
>
> On my local env the warnings shows , show I change the line (initialize w=
ith
> NULL to "logmsg").
>
> But it seems like different as the last time I built... However now "sugg=
est
> braces around initialization of subobject" appears, is it normal or we sh=
ould
> repair this?
>
> builtin/merge-file.c:29:23: warning: suggest braces around initialization=
 of subobject [-Wmissing-braces]
>         mmfile_t mmfs[3] =3D { 0 };
>                              ^
>                              {}
> builtin/merge-file.c:31:20: warning: suggest braces around initialization=
 of subobject [-Wmissing-braces]
>         xmparam_t xmp =3D { 0 };
>                           ^
>                           {}

The fix for this is in "next": 54795d37d9e (config.mak.dev: disable
suggest braces error on old clang versions, 2022-10-10)


> 2 warnings generated.
> builtin/notes.c:641:13: warning: variable 'logmsg' is used uninitialized =
whenever 'if' condition is true [-Wsometimes-uninitialized]
>         } else if (!cp.buf.len) {
>                    ^~~~~~~~~~~
> builtin/notes.c:653:7: note: uninitialized use occurs here
>         free(logmsg);
>              ^~~~~~
> builtin/notes.c:641:9: note: remove the 'if' if its condition is always f=
alse
>         } else if (!cp.buf.len) {
>                ^~~~~~~~~~~~~~~~~~
> builtin/notes.c:570:14: note: initialize the variable 'logmsg' to silence=
 this warning
>         char *logmsg;
>                     ^
>                      =3D NULL
> 1 warning generated.

Yes, we should initialize it to NULL, so this is the expected
warning. Clang spots it.
