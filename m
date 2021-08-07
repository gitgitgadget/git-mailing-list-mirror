Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60053C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 02:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3524B61078
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 02:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhHGCzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 22:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhHGCzI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 22:55:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5766C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 19:54:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x90so15778994ede.8
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 19:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=sIKVX5PDpVTGnn0nqAx+REQ97f3qBptkqrFfqBP9ums=;
        b=Km/VUtet2U/LUYzECnamsn5YnOZxREWJCvo70j9m1//RC8fPy2Ebv7F+ZT/kSWSl3j
         B1aP3CjCjMPA7zslKLNV2sPaJplxwAWq4GppAKAVZVmQPZCmoaDiURDYLexFI3q2jbBz
         k8aqIeChbGk+5a0bHPJ5O+qsiT1VgxlnDhorIceKzl41h8UBTpEKu/A5v1kE7SenQa/I
         ogfwAhztRQ38hc1PjDg8gvxpQqS+UA0AE+9vWyUbri+5EuDCVA8EZEHB1IJX0BbZQeMd
         tifEUQIPBYBeMCGtpRvyxdshoNzYStvZN9XVF4splfaaBMbXXvAPrfVGdOrOK2L/rzE9
         0VIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=sIKVX5PDpVTGnn0nqAx+REQ97f3qBptkqrFfqBP9ums=;
        b=Zu+LEpn5M9c/odiPL5hI27wpoU2T9/e+2GtD1U8lUQH97shh294afaTIy+H+5rQtq5
         RQTC9LnV4PYSRKEvK1At9a8rMByl5wL4p1zRaQimJavlcEi+r1+a3pDV4nDj8kZhHTZa
         M3y03+vVPIyVyUNu54t/68zfwYLc8EZSijgTE19VaDqhlxQNavqcKBj1P0pkK8445apQ
         JIeoPz3AasXOoudHa9/vkpvbfWKcscRybbmsflCOzzBeE9q6wvdvUjqbPACBd4WGvcpC
         kTkwpwDK9f3ln3fvaeC6lmz+Yu9I2IGWOPxtllaKquvLfjDo0esL//fxzKlsCktfZTtL
         XGxQ==
X-Gm-Message-State: AOAM531BPvX+sWXBjE1t6EC6CKkP86KDICDr4eEDvXSOskSl2sSYGTOU
        sa1NTJNbz6uHzv9+Ugu8mTRHfrJ/8yS3cA==
X-Google-Smtp-Source: ABdhPJye7Zygg22HnAUL2nf69xWhS2M0qP6wJ3ovCMasLCTCk3B0w2RTTAw19BxQ2ruJZcyNWAnSwQ==
X-Received: by 2002:aa7:de05:: with SMTP id h5mr161183edv.174.1628304889245;
        Fri, 06 Aug 2021 19:54:49 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n26sm4570132eds.63.2021.08.06.19.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 19:54:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH 00/13] Add bundle-uri: resumably clones, static
 "dumb" CDN etc.
Date:   Sat, 07 Aug 2021 04:19:59 +0200
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
        <YQ1JW8hHmG8B/oE3@google.com> <87h7g2zd8f.fsf@evledraar.gmail.com>
        <YQ2eLRjMRnVpdGVZ@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQ2eLRjMRnVpdGVZ@google.com>
Message-ID: <878s1eynew.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 06 2021, Jonathan Nieder wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Or perhaps not, but they're my currently my best effort to explain the
>> differences between the two and how they interact. So I think it's best
>> to point to those instead of coming up with something in this reply,
>> which'll inevitably be an incomplete rewrite of much of that.
>>
>> In short, there are use-cases that packfile-uri is inherently unsuitable
>> for, or rather changing the packfile-uri feature to support them would
>> pretty much make it indistinguishable from this bundle-uri mechanism,
>> which I think would just add more confusion to the protocol.
>
> Hm.  I was hoping you might say more about those use cases --- e.g. is
> there a concrete installation that wants to take advantage of this?
> By focusing on the real-world example, we'd get a better shared
> understanding of the underlying constraints.

I hacked this up for potential use on GitLab's infrastructure, mainly as
a mechanism to relieve CPU pressure on CI thundering herds.

Often you need full clones, and you sometimes need to do those from
scratch. When you've just had a push come in it's handy to convert those
to incremental fetches on top of a bundle you made recently.

It's not deployed on anything currently, it's just something I've been
hacking up. I'll be on vacation much of the rest of this month, the plan
is to start stressing it on real-world use-cases after that. I thought
I'd send this RFC first.

> After all, both are ways to reduce the bandwidth of a clone or other
> large fetch operation by offloading the bulk of content to static
> serving.

The support we have for packfile-uri in git.git now as far as the server
side goes, I think it's fair to say, fairly immature, I gather that
JGit's version is more advanced, and that's what's serving up things at
Google at e.g. https://chromium.googlesource.com.

I.e. right now for git-upload-pack you need to exhaustively enumerate
all the objects to exclude, although there's some on-list patches
recently for being able to supply tips.

More importantly your CDN reliability MUST match that of your git
server, otherwise your clone fails (as the server has already sent the
"other side" of the expected CDN pack).

Furthermore you MUST as the server be able to tell the client what pack
checksum on the CDN they should expect, which requires a very tight
coupling between git server and CDN.

You can't e.g. say "bootstrap with this bundle/pack" and point to
something like Debian's async-updated FTP network as a source. The
bootstrap data may or may not be there, and it may or may not be as
up-to-date as you'd like.

I think any proposed integration into git.git should mainly consider the
bulk of users, the big hosting providers can always run with their own
patches.

I think this approach opens up the potential for easier and therefore
wider CDN integration for git servers for providers that aren't one of
the big fish. E.g. your CDN generation can be daily cronjob, and the
server can point to it blindly and hope for the best. The client will
optimistically use the CDN data, and recover if not.

I think one thing I oversold is the "path to resumable clones",
i.e. that's all true, but I don't think that's really any harder go do
with packfile-uri in theory (in practice just serving up a sensible pack
with it is pretty tedious with git-upload-pack as it stands).

The negotiation aspect of it is also interesting and something I've been
experimenting with. I.e. the bundles are what the client sends as its
HAVE tips. This allows a server to anticipate what dialog newly cloning
clients are likely to have, and even pre-populate a cache of that
locally (it could even serve that diff up as a packfile-uri :).

Right now it retrieves each bundle in full before adding the tips to
negotiate to a subsequent dialog, but I've successfully experimental
locally with negotiating on the basis of objects we don't even have
yet. I.e. download the bundle(s), and as soon as we have the header fire
off the dialog with the server to get its PACK on the basis of those
promised tips.

It makes the recovery a bit more involved in case the bundles don't have
what we're after, but this allows us to disconnect really fast from the
server and twiddle our own thumbs while we finish downloading the
bundles to get the full clone. We already disconnect early in cases
where the bundle(s) already have what we're after.

This E-Mail got rather long, but hey, I did point you parts of this
series that cover some/most of this, and since it wasn't clear what if
anything of that you'd read ... :) Hopefully this summary is useful.
