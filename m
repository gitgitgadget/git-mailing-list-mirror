Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA5DC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 16:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242395AbhLAQV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 11:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbhLAQVz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 11:21:55 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CECDC061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 08:18:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e3so104073628edu.4
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 08:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Hz89kpVorjLFbSH/GU3/httt+xEU44WNNF0AIMNEXW0=;
        b=c2rXdN+0ZYkHeBDyGuO8ObILJT8gHrRPi3XG9+jvl8/mZwahlwC93EEPt2HvGnyg0S
         KlQegXa8KUsuC4pxigcjBOwjZR4P2FxahLFDXvdyNBTWaFkw+br7g6OxvMQgswZNlFIh
         v78SAq/DN8W+nJy0Dv7VIsf77NiFieHrIf6/xDF2CmZOIsuySHNtUHIU3cLzM13NbFHH
         XM28rPWvPbXBp+jkVMGzQf5k93XrM4IkEESiGd16frTCjag8Tmvuz9SB8TOqKwC+AFgb
         XZ/+r7Cy3I4FgVAKxfOMd+SnQRsIztgm2HxlifscYCW/5XniW5Cw/KARgbnP23EYz6t1
         wUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Hz89kpVorjLFbSH/GU3/httt+xEU44WNNF0AIMNEXW0=;
        b=ttI45cdbyx9RO3vcW8fHkz0damiRIES06E3wKmJRJBmATdhMlzmAInY8Tbmn5Ltv33
         tIEqtZbYUCZKnsTibxG8vR/7AMyGdykZE5nEzkAZ27rz+tjW4usZM6OZfA5lFmzYX/ck
         g6dCJAx764y3dAV8j9kLsnnZwWVu0GRRSCMNB7YqOtsgPG1jj6Tg4o/F8DfNOzXgqepo
         hiwmy0KyrBXsOHzvTBqUYaXc/4tuXnd7VnrxvFamAFpo4tdr5KPbD8Vxi6Eup0t4Ne2y
         iKAQNlINIuZW1ta8DmhPHF8sCC+5MdILswdQtSi+prmc2XWQKAYMA4A5d4kW6hzDufXH
         SRkw==
X-Gm-Message-State: AOAM532wrxFxiDXztyRX+OcQOXHQrNwkO6VznPz7xddsaTQjZY1fquZ6
        FhoRDskMBX91h2PImD6bHRY=
X-Google-Smtp-Source: ABdhPJxtLULJ5NqphNY5zmfl9vX2yBtR9C1Nlq+QwAzRmxKaPGjj3wI2ZDBmW5toNZ4jIbk3lDxJng==
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr8297176ejc.493.1638375511852;
        Wed, 01 Dec 2021 08:18:31 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id he17sm98785ejc.110.2021.12.01.08.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:18:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msSJS-001KH5-Dz;
        Wed, 01 Dec 2021 17:18:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] trace2: increment event format version
Date:   Wed, 01 Dec 2021 16:57:16 +0100
References: <ebc4d9a6960f0350772c14981ef211876f29d0fa.1636669891.git.steadmon@google.com>
 <xmqqh7cijnwx.fsf@gitster.g> <YY2h5lO90vo3Dy42@google.com>
 <xmqqczn6jlvu.fsf@gitster.g> <211112.867ddduhly.gmgdl@evledraar.gmail.com>
 <9ce9c989-5a8c-1d5c-cc7e-9447760ed110@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <9ce9c989-5a8c-1d5c-cc7e-9447760ed110@jeffhostetler.com>
Message-ID: <211201.86zgpk9u3t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 01 2021, Jeff Hostetler wrote:

> On 11/12/21 5:33 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Nov 11 2021, Junio C Hamano wrote:
>>=20
>>> Josh Steadmon <steadmon@google.com> writes:
>>>
>>>> On 2021.11.11 15:03, Junio C Hamano wrote:
>>>>> Josh Steadmon <steadmon@google.com> writes:
>>>>>
>>>>>> In 64bc752 (trace2: add trace2_child_ready() to report on background
>>>>>> children, 2021-09-20), we added a new "child_ready" event. In
>>>>>> Documentation/technical/api-trace2.txt, we promise that adding a new
>>>>>> event type will result in incrementing the trace2 event format versi=
on
>>>>>> number, but this was not done. Correct this in code & docs.
>>>>>>
> ...
>> On the field itself I also wonder if it's useful at all. I'd think
>> anyone implementing a parser for the format would dispatch to a lookup
>> handling known keys, so having a version indicating "new keys here"
>> seems rather useless.
>>=20
>
> That may be true, but it is easier to have a version number and
> allow parsers to ignore it, than it is to not have a version number
> and at some point in the future require parsers try to figure it
> out. IMHO.
>
> So far we've only added new event types (cmd_ancestry and child_ready)
> and everything is in regular JSON forms, so parsing and dispatching
> is relatively easy and the version number is not really needed.
> But, if in the future we decide to change the contents within one of
> those events, then the version number may be significant.

Yes, exactly. Versioning it makes sense, I'm commenting specifically on
the criteria for bumping the version. I.e. this bit in
trace2/tr2_tgt_event.c (with my comments)::
=20=20=20=20
     * The version should be incremented if new event types are added

That seems entirely useless, i.e. just ignore unknown types. If you get
an unknown type you know something is new, no need for a version number
bump for this case.

It adds no new information you're not getting with "oh? a new field?".

     * if existing fields are removed, [...]

Useful, you don't always know if the absence of a field means it won't
be there at all, or if something else is up, particularly if the field
is optional. E.g. if we rename "error" to "exception" (or whatever) we
don't want an older consumer to report that there's no errors happening.

     * [...]or if there are significant changes in
     * interpretation of existing events or fields.

Carving out "significant changes" seems rather odd.

Let's just say "any changes"? E.g. I don't think my 2d3491b117c (tr2:
log N parent process names on Linux, 2021-08-27) qualifies as
significant change, but why not bump the version even for that?

In that case it was part of a release where we bumped the version
anyway, but let's come up with some sane criteria.

What's "significant" is also entirely subjective. I think 2d3491b117c is
trivial in the context of the entirety of our trace2 data. But if all
you care about is logging process trees it's highly significant.

     * Smaller changes, such as adding
     * a new field to an existing event, do not require an increment to the=
 EVENT
     * format version.

I'd think a new sub-field would be in the same class as a new top-level
event field, i.e. adding a version wouldn't add any information. It
falls under the same general rule that you can traverse future data with
your "version" in hand, and a whitelist of fields you know how to
handle. If the version is the same but you've got new unknown fields you
shouldn't need to care.

IOW I think this would make more sense as a version bumping criteria:

    The version should be incremented whenever an existing consumer of
    trace2 data might want to act differently based on the new data.

    An exception to this is that any new event types do not merit
    bumping the version number. E.g. we have a top-level event type
    "error" now, but might hypothetically add a new "warning" type.
    Such an addition won't require bumping the version.

    Likewise adding new mandatory fields to existing events doesn't
    require bumping the version. E.g. the "error" type has (as of
    writing) a "fmt" and "msg" field. Let's say a future version adds an
    "id" (as in unique id for the error) field, such an addition won't
    require bumping the version.

    In other words, consumers of the trace2 JSON format are expected to
    walk the structure and only pick those things that they know about.
    Any unknown fields the consumer doesn't know about can be safely
    discarded. This won't apply if the version is bumped, then all bets
    are off, and the meaning of existing fields may or may not have
    changed.

    The idea is to encourage additive changes over changes to existing
    fields, and to reduce the work in maintaining the consumers of the
    format.

    As long as consumers ignore new unknown data they won't need to
    be updated every time the format changes in any way, only for
    potentially backwards-incompatible changes.

Wouldn't this be a saner policy for version bumping? AFAICT the only
thing you wouldn't be getting that you're getting now is the trivial
optimization of being able to say cheaply route trace2 payloads based on
version number alone (but even that is iffy now due to the subjectivity
of "significant change").
