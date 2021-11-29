Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C944C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 09:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245113AbhK2Jpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 04:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245132AbhK2Jnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 04:43:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C486C06179C
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 01:24:30 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g14so68879760edb.8
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 01:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SDRMpstBl/qe3yMPTlRJLSLxENtFQ9gA8Z0U/ITApJI=;
        b=F52f3u1QpBF32r3ZNo7BX+ciM3Z06y1YVQe0vY2MEzg9kdAKlAed7ZmZzuy2IauR1N
         ZMquIpg0kv8d6VE0qarI49bV/UBS1FMQbSOQdOjp+/KZnTvP24BUUNjbscjHWzL4mKiL
         54w3Z7V/ZJALxyGH9rnuqOmZBYNT9XH9cf9FXGnNA2mpRJdRRGLmg6PvjVDF3a41k5sA
         G3DIuBlqGKf5Vd0VQ0487L+9U4PoDXPIFN7aXVERB1ex6KcwO/sUfZVDPghrEnnFpRUH
         8A502O4pSw2A18h9sFp2b16wqn6xa3RuSDPBuJnimN6QHtLKhDkGNhB9i9Iqe6lzhpgR
         6/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SDRMpstBl/qe3yMPTlRJLSLxENtFQ9gA8Z0U/ITApJI=;
        b=XMwJxS8sgvYSDP8gJ9lS3Q3r0CvOvcFQdNdjpyKGojMXU4xov+izbnlWUfA3thIdOX
         tOgi1Yv3d9EydnEzpV/WgzgAcUmKPxmYeRpXQJgKcoyplIW08NIMdTj8YW0xNwvAhs0v
         gUk67SoPfErxoqYFLgBC7D7K8VYPl/UmRegGhiqpcQ05V0Aia9QzDE7fTfP4wSUHfi59
         xtdbpmZDFHTzyHqvPvdV0OW0L0g+wKz7024NdRlQ1oB8hJoL34HkC9OkxPuYZufdcWJ6
         6IFNs8JAw1UIW1PLmBXniYjiSZFTntDRMK9NENOKucHlpoHV8X3I++r1stiE6h7+x79C
         7Rhw==
X-Gm-Message-State: AOAM530A6VBvpmz9G8idZ1vuZa7HOgehU1dkV64HBdXuPaN/lzgg19+U
        PLdv/XkGicmlej1tq27uaP4=
X-Google-Smtp-Source: ABdhPJyrNDCMNR8jUpSTJZ9A3l9CfNMTadalpRCHhCC70uvuT/RzIs0/jk6dHRPiMrBl6w6tno2E6Q==
X-Received: by 2002:a17:906:dfe4:: with SMTP id lc4mr61096203ejc.125.1638177868530;
        Mon, 29 Nov 2021 01:24:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id de15sm6963650ejc.70.2021.11.29.01.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 01:24:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mrcte-000fup-OA;
        Mon, 29 Nov 2021 10:24:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: Re* [PATCH 2/4] refs: trim newline from reflog message
Date:   Mon, 29 Nov 2021 09:39:58 +0100
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
        <xmqq35nnddw7.fsf@gitster.g>
        <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
        <xmqqczmqajdk.fsf@gitster.g>
        <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
        <xmqqzgpu7grv.fsf@gitster.g> <xmqqczmn71ru.fsf_-_@gitster.g>
        <211128.86r1b0gnv6.gmgdl@evledraar.gmail.com>
        <xmqqpmqk5co6.fsf@gitster.g> <xmqqk0gs5bgw.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqk0gs5bgw.fsf@gitster.g>
Message-ID: <211129.86h7bvgvqt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 28 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> Nitpicking aside, perhaps these two pargaraphs would be better as simply
>>> replaced by:
>>>
>>>     Consult "Git internal format" in git-commit-tree(1) for
>>>     details about the "<unix timestamp> <time zone offset>" format, and
>>>     see show_one_reflog_ent() for the parsing function.
>>
>> Much nicer; this is developer facing and reducing risk of
>> inconsistency by incorrectly duplicating is much more important than
>> having the info available in a single place.
>
> Having actually read the description, I do not think
> "Documentation/date-formats.txt::Git internal format" is a good fit.
> We are describing the format of a single string there (e.g. <unix
> timestamp> and <time zone offset> form a single string with one SP
> in between), but the parameters are integral types.
>
> Specifically because the "Git internal format" is textual, an
> example "+0100" given there makes it sufficiently clear that the
> offset is a "a sign followed by 4 digits" string, but those who need
> to use the value in "int tz" must know that is represented as a
> positive one hundred, not sixty, which does not have to be captured
> there for the intended audience of date-formats.txt pagelet.
>
> Here is what I came up with
>
> ---- >8 -------- >8 -------- >8 -------- >8 -------- >8 ----
> Subject: [PATCH v2] refs: document callback for reflog-ent iterators
>
> refs_for_each_reflog_ent() and refs_for_each_reflog_ent_reverse()
> functions take a callback function that gets called with the details
> of each reflog entry.  Its parameters were not documented beyond
> their names.  Elaborate a bit on each of them.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * rewrite timestamp and tz, adjusting the internal format's
>    description from Documentation/date-formats.txt pagelet, as
>    pointed out by =C3=86var.
>
>  refs.h | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
>  The indented patch shows the part that was changed from the
>  previous one.
>
>     diff --git i/refs.h w/refs.h
>     index 4fa97d77cf..f6fed5c7d8 100644
>     --- i/refs.h
>     +++ w/refs.h
>     @@ -467,13 +467,15 @@ int delete_reflog(const char *refname);
>       * The committer parameter is a single string, in the form
>       * "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" (without double quot=
es).
>       *
>     - * The timestamp parameter gives the seconds since epoch when the re=
flog
>     - * entry was created.
>     - *
>     - * The tz parameter is an up to 4 digits integer, whose absolute val=
ue
>     - * gives the hour and minute offset from GMT (the lower 2 digits are
>     - * minutes, the higher 2 digits are hours).  A negative tz means wes=
t of,
>     - * and a positive tz means east of GMT.
>     + * The timestamp parameter gives the time when entry was created as =
the number
>     + * of seconds since the UNIX epoch.
>     + *
>     + * The tz parameter gives the timezone offset for the user who creat=
ed
>     + * the reflog entry, and its value gives a positive or negative offs=
et
>     + * from UTC.  Its absolute value is formed by multiplying the hour
>     + * part by 100 and adding the minute part.  For example, 1 hour ahead
>     + * of UTC, CET =3D=3D "+0100", is represented as positive one hundre=
d (not
>     + * postiive sixty).
>       *
>       * The msg parameter is a single complete line; a reflog message giv=
en
>       * to refs_delete_ref, refs_update_ref, etc. is returned to the

Thanks, this version of these docs looks good to me!
