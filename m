Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B9EC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 00:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBBAJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 19:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBBAJN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 19:09:13 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FF769B3D
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 16:09:11 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bk15so1375331ejb.9
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 16:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GjDhR4mbIzNiiTLjczQp3n+P/3liVd7o5bPVqIPMZd0=;
        b=LBe49/Ee8dHWJpa24DmkSwLTwW3bjaEBJNiIJaXROIZMa5a7n0/41Z79GtI+Y6wHBH
         BXEQOSV0182tX7BTslu2N33+ts14dyKY5L1U0/3w+R6Bzl/GIOQ5aqIAkN8rgz2M9a4Q
         3xZK8zqqz+QhzucBkqH3aqdOIAzXUEp+gpxVGTxaRVgD3OuIS/0iq4sTOje0tZ1n79JC
         EoIkmUc+v6A4oZZHm0qDwoT4EzOY6+3Tuj0r13tgrPGqibiRH13Hsvpv41YJTI5rYZLn
         Dt/xwPGdonNQ0edF4Ho3/bQqsHfVCZzBQQTXfVx943rpw3eA8d3yTNCpRK3n+ywIAxnC
         lTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GjDhR4mbIzNiiTLjczQp3n+P/3liVd7o5bPVqIPMZd0=;
        b=ec+k7RFpKJGtEzaoZBw8LcP7gLXjMX6c3l/2nT2Ao/hv/Art1tvuJNb1aj8zKI/xH/
         d3qJZ7mHzaHAZthSn5drWyGvU3FC81/pYPyMDTLIIaIHl/qZ2cWAyYRdvA7GwlapxSZr
         D75wunAuqwTBMfX8i0QswmVib3n8EuV6ImO3TCap1WuN1iNNV3jeIb/+45HZARnTlxqJ
         z8C8FHM1fCwQ9ktNqMf3sHDPfWkPdWkfEm7lodg8rtlI7O0PX0s6yNUY2K8o2RjTsCn4
         gDoBQlVVPD5g28tm/90rszKeBzgCafyxIWGB80LVo2giAh5/WEK+CiFF8GNBmip5mshS
         hZ6Q==
X-Gm-Message-State: AO0yUKXDecNVCWfPPtpO5aSUID9nxcLHfUp8oLM+mJZGHQbsnourMU2b
        5Jtdm62zojs2smVi5wsXke6cUSXFh4NDet8u
X-Google-Smtp-Source: AK7set/DSraAHKPEHYlzokIbuZZMq3lBDFSoRr2fogBV4BwzT4/IN7yhEviSk/vo2jLLAFAZdyQsXQ==
X-Received: by 2002:a17:906:5287:b0:878:4e83:b058 with SMTP id c7-20020a170906528700b008784e83b058mr3998057ejm.1.1675296550323;
        Wed, 01 Feb 2023 16:09:10 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090631c600b0088879b211easm5616343ejf.69.2023.02.01.16.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 16:09:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNNA4-002Mql-29;
        Thu, 02 Feb 2023 01:09:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH] imap-send: replace auto-probe libcurl with hard dependency
Date:   Thu, 02 Feb 2023 00:56:24 +0100
References: <20230201113133.10195-2-worldhello.net@gmail.com>
 <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
 <xmqqlelhx973.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqlelhx973.fsf@gitster.g>
Message-ID: <230202.86zg9xormj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 01 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the "imap-send" command to have a hard dependency on libcurl,
>> before this it had an optional dependency on both libcurl and OpenSSL,
>> now only the OpenSSL dependency is optional.
>>
>> This simplifies our dependency matrix my getting rid of yet another
>
> "my" -> "by", I think.

Thanks, I'll fix that in a re-roll, pending the below...

>> special-case. Given the prevalence of libcurl and portability of
>> libcurl it seems reasonable to say that "git imap-send" cannot be used
>> without libcurl, almost everyone building git needs to be able to push
>> or pull over http(s), so they'll be building with libcurl already.
>
> OK.
>
>> So let's remove the previous "USE_CURL_FOR_IMAP_SEND" knob. Whether we
>> build git-imap-send or not is now controlled by the "NO_CURL"
>> knob.
>
> OK.
>
>> Let's also hide the old --curl and --no-curl options, and die if
>> "--no-curl" is provided.
>
> In other words, if we are building imap-send, we sure know cURL is
> there, and there is no need to tell a running imap-send not to use
> cURL to talk to the IMAP service?  I am not sure the linkage of this
> change with the rest of the patch.  Isn't that a totally orthogonal
> issue?  Your imap-send might be cURL enabled, but unless we stop to
> ship with our own IMAP routines compiled into imap-send, --no-curl
> does have a purpose.

The equivalent of USE_CURL_FOR_IMAP_SEND is now always true, and that's
what "--curl" would enable.

The "--no-curl" option would then have us use the OpenSSL codepath, but
that'll no longer be supported, we'll always use curl.

The link to the rest of the patch is then that "USE_CURL_FOR_IMAP_SEND"
and "curl_check" etc. was needed to check if we had curl with imap-send,
now we declare that we'll always need it.

And the link to the thread-at-large is that Jiang Xin's upthread version
moves those checks from the Makefile into the code itself, I agree that
wolud be an improvement, but if we're happy to just make it a hard
dependency we won't need it there either...

> Or did you just forget to document that we stop to ship with our own
> IMAP routines in the above?  If so, as long as it is made a bit more
> prominent in the proposed log message in a reroll, I would be happy
> with such a change rolled into the same patch.

I'm not sure what you mean here, we still ship with the same routines,
we just always take the "curl" codepath for the non-tunnel codepath now.

Is this perhaps confusion because while we do make curl mandatory, we're
not dropping the OpenSSL code? That's because we're dropping its use for
the non-tunnel codepath, but unfortunately for the tunnel case we'll
still need it.

So we only make curl mandatory, but OpenSSL remains optional.
