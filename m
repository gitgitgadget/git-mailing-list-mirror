Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D2C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 16:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJQQ7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJQQ7N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 12:59:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6555FF73
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 09:59:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r17so26318959eja.7
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rVsjgjtSsaIPcU+V4dFwPNqK6bfsfe9ROnH2wKdRqNM=;
        b=FDjby6X0EzyX1uNIvtPMkX50DNVqEdTsEPXoEn5Hlgeoibo0VtRaFNzJDU9+tO05of
         EGwYFfFU5AshleD+uOQ55PI/r0dYT3NUq/4zxgbmVC8WNz9b5+UdwCZAHpZo55FsMy/N
         GF+GdNuvQ6x8pX2VFe7I3oFdV9GKdajbAV50wIQjdD+7YyB70bmiwGIbsIQZ+6IfjgUy
         sW6HFZoG41FTt9n8z3h12+JB8KIPKlIsdcOxvQxpT9UhgEzebWp7xZ4oqR6r1csaaZJm
         M+7rVoUUZesx5YBFwY/5AKP7f+BePRXntH2jbg2p0V6/VEi4APGNQpqTEnhGYW2iqybK
         4htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVsjgjtSsaIPcU+V4dFwPNqK6bfsfe9ROnH2wKdRqNM=;
        b=pGnuoLjoSqY6+2WSxv8piM9hmyFRYyi6XT1l2fhqf1DlOziHtSyv84lTAW8mPm97B+
         v1IvoeP2TKLtvRSfHb3xgFeohYDWInYFUUyu7SbiPBPbvZZXPm1EL/1s3F6ceJft0o9Y
         Jf/QD+OkP1VQC8OqHAahqP92HmsLDCjG2xMMpp/PwNkHsTtdmgcGxa/gaZ1Nhdmw4S/e
         3MzmqsScNGURXbcZHC/5c+Rq+0vZ4K8ULMFHDqAt1TM1uDHW7QinxMCc6/hUquFTNoCb
         dUWOhbXY6EYEDSfefR3sdrJRoZ3yoDhpBoAJ87jZf6oU16a8E3pVAvndnvgJy55eECvb
         WSiQ==
X-Gm-Message-State: ACrzQf1uYiYOzBTQZ6xt4gnOhRcbGU4corR9jBnldAvAvtFe460+B/eA
        jvLiEsUFHKbEJv3y4DAMroXLyKINX5LTzQ==
X-Google-Smtp-Source: AMsMyM4f6Pyg/AcI9NjxEdMbb25Ynn4Kb+NxZotJ8HREf/+bQdhft7nNjxf2a6oLaxGchubVRfLE0A==
X-Received: by 2002:a17:906:fd84:b0:730:acee:d067 with SMTP id xa4-20020a170906fd8400b00730aceed067mr9538495ejb.206.1666025951181;
        Mon, 17 Oct 2022 09:59:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7ce85000000b0045c72bba0bfsm7727369edv.4.2022.10.17.09.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:59:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okTSH-005YHu-28;
        Mon, 17 Oct 2022 18:59:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonas Bernoulli <jonas@bernoul.li>
Cc:     git@vger.kernel.org
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
Date:   Mon, 17 Oct 2022 18:50:06 +0200
References: <87czatrpyb.fsf@bernoul.li> <87a65xrnwz.fsf@bernoul.li>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <87a65xrnwz.fsf@bernoul.li>
Message-ID: <221017.86h702jsiq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Replying to both this & the parent post:

On Sat, Oct 15 2022, Jonas Bernoulli wrote:

> In v2.38.0 (31955475d1c283120d5d84247eb3fd55d9f5fdd9)
> "submodule--helper --list" was remove because
>
>> We're not getting anything useful from the "list | cut -f2"
>> invocation that we couldn't get from "foreach 'echo $sm_path'".
>
> But we get speed (this is with about one hundred modules):
>
> $ time git submodule foreach -q 'echo $sm_path' > /dev/null
>
> real    0m0.585s
> user    0m0.413s
> sys     0m0.182s
>
> $ time git submodule--helper list > /dev/null
>
> real    0m0.008s
> user    0m0.004s
> sys     0m0.004s
>
> Please consider restoring this subcommand or providing something
> equivalent that is just as fast.

Sorry about the slowdown, the removal of "list" was just an in-between
step to migrating "submodule" to a full built-in.

I can't reproduce anything like the 8ms v.s. ~600ms difference you note
here, but for me migrating it to a built-in is around 10% slower with
"foreach" than the old "list". I wonder what results you get?

I sent in a topic to migrate it since you sent this report. I was going
to do it in this development cycle, but this prompted me to do it
earlier:

	https://lore.kernel.org/git/cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com/

On Sat, Oct 15 2022, Jonas Bernoulli wrote:

> I just noticed that "submodule--helper name" was also removed, which I
> also found useful in scripts.  Please tell me if I am missing something,
> but it seems I now have to do something like this instead:
>
>   git config -f .gitmodules --list |
>       sed -n "s|^submodule.\([^.]*\).path=$path\$|\1|p"
>
> The old way was nicer:
>
>   git submodule--helper name $path
>
> I realize submodule--helper is for internal use and using it anyway
> comes with the risk of such removals and other changes, but again,
> please consider restoring that or providing something similar in the
> public interface.

This however is another case, I removed "name" along with "list" and
other leftover code we weren't using anymore for the internal-only
"submodule--helper" (which is at turns out, was not as internal-only as
we'd hoped).

For "list" it's clear how to use "foreach" instead, but for "name" then
AFAICT the "best" replacement is to do a:

	git submodule foreach 'echo $displaypath $name'

And pipe that into grep/sed. If that's fast enough would it satisfy your
use-case, or would a "name" equivalent be handy?

I think the best way to prove that would be e.g.:

	git submodule foreach-format '%{name}' -- <pathspec>

Which, due to the "foreach" taking N number of arguments isn't easy to
add to "foreach" without the interface becoming somewhat tortured (we
could add a [---pathspec=<pathspec>]...), but "-- <pathspec>" with a
different subcommand name seems better.
