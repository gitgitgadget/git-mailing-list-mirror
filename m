Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1CDC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 11:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLGLsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 06:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLGLsd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 06:48:33 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987EF1118
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 03:48:31 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j4so28331361lfk.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 03:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VnPASsbuYUrpUlaUuKObNkze/TrNx9mdhjCqhsvXqMM=;
        b=J/EnPj8oxcDxV9370D25EgSGIk8LWqMDDhX+m0YMVe7wZZDzmU6psEIrMwdeBRAe2Z
         Y+CuW6D1GeiSTiOnt2s5ul01n7NIyVGyiaqmEEJ7C8u3d+fMi9MVV9gDp66IQTWJRaWT
         aunD3TK1aKTR0ukEhoIUWnWy8xufCMttrXtd2SHMDqH7nVtU2Y4CSjWXY1urJtZl/+7P
         4Ppd/lQM/MVULmgrxJ9260gvFbH9FZjson/EJoLOJI1vDzamovPPRuLYHR1Jh7/Hz3Fc
         95cFnM9QJ6ZDpLatFBtOkZu4WTEDgPOaneWdciKKXnvLRQloTKUf2AJs08O0eQ4bTvE2
         qVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnPASsbuYUrpUlaUuKObNkze/TrNx9mdhjCqhsvXqMM=;
        b=qsJbVQbtIywURdfSH3AuGlIH+VwIYLMaIjhhDLeVypt5aUD2WYFJjirXFMuyjwQioh
         5O36UbV7qsi7ZltM0fdMfxSnWw/j8XSqYnlt+86CYFChFNuw8Z3/59RmK2WvbJWAm1Lv
         Vlkly2QhdkLUUSh8OPLk0eW55w/CJxdfXaf9PuHsuuvR9u0IX72j523OFH/kDkLx4jUu
         BSNlWPz5fMqAw69/YmLsdIy/gqFY3yB20QDJy3XWyOpO9vfLAM0ClcoVGmKzmCsnmLRo
         kt21WdhGm4irv3iNtFSME8i3UqKORF+2DJ7XSpBthexUIVk4JTxwy/P++e5ye4Wck69a
         jWhQ==
X-Gm-Message-State: ANoB5pkomClrgzKyGCVkXaF44qIfj6p/FaQJrHggFgOrTjWjePlGiShy
        Ra07xtbCIHmfwnfsjed/LbhYupC029Jrqw==
X-Google-Smtp-Source: AA0mqf582DfdtguJQBSXgGvQ5Qmq46uIab20kdHllE4kaMNiZIns5d9HRnKH8k82hAGIoQzgXjWsrw==
X-Received: by 2002:a17:906:cc0d:b0:7be:bf6c:8756 with SMTP id ml13-20020a170906cc0d00b007bebf6c8756mr39092514ejb.62.1670413699035;
        Wed, 07 Dec 2022 03:48:19 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id lb25-20020a170907785900b007b43ef7c0basm8384755ejc.134.2022.12.07.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 03:48:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2suP-004Otk-3B;
        Wed, 07 Dec 2022 12:48:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
        toon@iotcl.com
Subject: Re: [PATCH 2/2] attr: add flag `-r|--revisions` to work with revisions
Date:   Wed, 07 Dec 2022 12:38:23 +0100
References: <20221206103736.53909-1-karthik.188@gmail.com>
 <20221206103736.53909-3-karthik.188@gmail.com>
 <xmqqedtc842m.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqedtc842m.fsf@gitster.g>
Message-ID: <221207.86lenja0zi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, Junio C Hamano wrote:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Add a new flag `--revision`/`-r` which will allow it work with
>> revisions. This command will now, instead of checking the files/index,
>> try and receive the blob for the given attribute file against the
>> provided revision. The flag overrides checking against the index and
>> filesystem and also works with bare repositories.
>
> As "check-attr" was not invented as a user-facing subcommand but was
> a hack for debugging, I would have minded this change, but these
> days people seem to treat it as if it is just one of the proper
> plumbing commands, the new command line convention bothers me a
> bit.  No other command uses --<anything> to signal that what comes
> after it is a rev.
>
> But I do not think of a better alternative without making the
> command line ambiguous, so I'll stop at raising a concern, so that
> others who may be better at UI can come up with one.

I don't really like it either, but maybe we've backed ourselves into a
corner here.

But let's look at that. So the command takes:

	git check-attr <attr>... -- <path>...

Or:

	echo "<path>" |
	git check-attr --stdin <attr>...

So we'd want to specify a <revision>, without making the <attr> or
<path> ambiguous.

Now, when we map the attributes we go through attr_name_valid(), which
checks that the attribute names are valid. A commentthere says:

         * Attribute name cannot begin with '-' and must consist of 
         * characters from [-A-Za-z0-9_.].

So can't we instead accept:

	git check-attr [<rev>:]<attr>... -- <path>...

I.e.:

	git check-attr HEAD~:foo -- path

And it wouldn't be ambiguous because attribute names can't contain ":"?
This would be consistent with e.g. "git show" and "git cat-file", just
with "<attr>" instead of the "<path>".

This would also mean that we'd support:

	git check-attr HEAD:foo HEAD~:bar HEAD~2:baz

etc., i.e. the ability to support multiple revision/attribute
pairs. Skimming the currently proposed code there seems to be no good
reason not to support that (we just need to look up other blobs), and it
would allow querying those without spawning N processes.
