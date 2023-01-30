Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB151C54EAA
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 10:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjA3Kxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 05:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjA3Kxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 05:53:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191FC13D60
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 02:53:41 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v13so10499080eda.11
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 02:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jMJNlZ4wspdj2WNCidqYwIT0plFeQbb3QmzUWlmmrwc=;
        b=QYhtbyId/mxlaJLD5BBoKixHSMWLEHtyLLjAIelJfM/QAWlDg1yKQncEOta56R1zgK
         k4cWuTWzVt+N1Fo9UPuBCvQkjwouaAGLrIBq5kLz39nbVgoeU5l8IiAypsLd9GX+AqUk
         rUgYwNd5PNQFjzWNtoA6+ZxCS/NyRCqQhZhOGixKsqC7zUYsNqpsLCf6zNTfO8moxuRO
         8kJ1P5mHVhFqpw0Gs5gL1edEavBDYI2HrMfdBxQI1BenKmtl6sbDmHRtPOIq40opany5
         6ejccThQPT73sQdZh8xzxTy3HQ6XXIJ8ORh3n/ghGaWTiSsBs/sXzi81N+AbBVyhxdH3
         6qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jMJNlZ4wspdj2WNCidqYwIT0plFeQbb3QmzUWlmmrwc=;
        b=y2EgZI1ljpFU5Pa4zf0RobgJ+M2m++zh9zQwl3pEAWtxrQL7muI0BsjwNurR0coW3F
         2z5pe2exZ01glHriG5ukki3QPFGATOyb6gjD6ipVETRKzCSZ2fbJUS2y7cuK5ffI1pqZ
         le+LyvxHLeY0N+UooRjZFGDZ6/7VI/0UauaUzGTbAtSj1z2Hn32KC4La/fi+16DcvDC5
         VqvMrhwqTW/aDbMlUb+WCPhhQ4lVoCFdvnqpSvll6N1q+gYKggGyjK7kI2oMNasikbFC
         zabq30ef83WVydsSCsCelwiRsTkpQdg2EpP8n2wk38eFIyQ3KKNtDXC5s4058oG4gJTI
         oRAg==
X-Gm-Message-State: AO0yUKVUkz2R7yWNdCZSF89mGlqmkwe5SxpSyh9k9jkLjSue5l6T8EzG
        UQ4jzbSHfNLoReRinHfKW34wbrpmezvO/w==
X-Google-Smtp-Source: AK7set/PRazdaSnGbu4XhkSRNoC3xjuRD7U/rMQjALnCv791SA640wrmp2fx5m0ek9SebweFgS0bSA==
X-Received: by 2002:a50:9559:0:b0:4a2:3d3d:a3d9 with SMTP id v25-20020a509559000000b004a23d3da3d9mr5571611eda.2.1675076019610;
        Mon, 30 Jan 2023 02:53:39 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id ev11-20020a056402540b00b004a2348c5613sm2662453edb.77.2023.01.30.02.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:53:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pMRn8-001jYp-1V;
        Mon, 30 Jan 2023 11:53:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Strawbridge <michael.strawbridge@amd.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Date:   Mon, 30 Jan 2023 11:40:14 +0100
References: <20230120012459.920932-1-michael.strawbridge@amd.com>
 <230123.86wn5ds602.gmgdl@evledraar.gmail.com>
 <5758ffc7-eb8c-4c16-d226-dd882cb2406b@amd.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <5758ffc7-eb8c-4c16-d226-dd882cb2406b@amd.com>
Message-ID: <230130.86bkmgs37x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 23 2023, Michael Strawbridge wrote:

> On 2023-01-23 08:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
  * Aside from that, shouldn't we have a new "validate-headers" or
>>    whatever hook, instead of assuming that we can add another argument
>>    to existing users?...
>
> While it's true we could (and I don't have a super strong opinion here),
> I suppose I was foreseeing the potential that a user may want to have
> logic that requires both the email headers and contents.=C2=A0 For exampl=
e,
> only checking contents for a specific mailing list.=C2=A0 If we split the
> hooks, a user would then need to figure out how to have them coordinate.

...

>>
>>  * ...except can we do it safely? Now, it seems to me like you have
>>    potential correctness issues here. We call format_2822_time() to make
>>    the headers, but that's based on "$time", which we save away earlier.
>>
>>    But for the rest (e.g. "Message-Id" are we sure that we're giving the
>>    hook the same headers as the one we actually end up sending?
>>
>>    But regardless of that, something that would bypass this entire
>>    stdin/potential correctness etc. problem is if we just pass an offset
>>    to the the, i.e. currently we have a "validate" which gets the
>>    contents, if we had a "validate-raw" or whatever we could just pass:
>
> I think there might be a part missing here: "problem is if we just pass
> an offset to the ___."=C2=A0 So there's a chance I may not fully grasp yo=
ur
> suggestion.

Sorry, a byte offset into the file to indicate the boundary between the
headers and the content.

>
>> 	<headers>
>> 	\n\n
>> 	<content>
>>
>>    Where the current "validate" just gets "content", no? We could then
>>    either pass the offset to the "\n\n", or just trust that such a hook
>>    knows to find the "\n\n".
>>
>>    I also think that would be more generally usable, as the tiny
>>    addition of some exit code interpretation would allow us to say "I
>>    got this, and consider this sent", which would also satisfy some who
>>    have wanted e.g. a way to intrecept it before it invokes "sendmail"
>>    (I remember a recent thread about that in relation to using "mutt" to
>>    send it directly)
>>
>>=20=20=20=20
>
> Are you suggesting to simply add the header to the current
> sendemail-validate hook?

No, I'm saying that we currently don't pass them at all, and your patch
adds another argument to a file with the headers.

That *may* break some existing users if they're only expecting the
current argument(s) (although that's probably unlikely), more
importantly we're now doing extra work for all existing hook users, for
the benefit of only some new users.

So I'm suggesting having some opt-in mechanism for the new semantics,
both to preserve the existing semantics for existing users, and for
current and new users avoid writing out the file etc. when we don't need
to.

Which we could do with a config variable,
e.g. hooks."sendemail-validate".includeHeaders=3Dtrue, or just by having a
new "sendemail-validate-raw" (or whatever we'd call it).

I think it's fine to enforce that if such a new hook exists we'd take it
over the "sendemail-validate" (if any), i.e. we wouldn't need to support
both.

