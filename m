Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45282C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041052070A
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbhA0D6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404361AbhA0B3V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 20:29:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DE2C06174A
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 17:28:40 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ox12so396297ejb.2
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 17:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=cBJ33Gk/HgEeWNlVnscstbM3YW7WjY1Dj1+foKGyMjU=;
        b=OigmeanDIEVDtiP+zfvql5jmlDNWsUSFfr1dYWTbUSFS0QPIxXVQmsFnkTU2jBADH6
         oRzP4ngj/I6ubov0dtofuGqmYKZ7ds46+y3aaI0cY9nrGI/vyzdoTw3fL99PzTQSRihr
         UdaXVzgWAkOsnkVP1pgo5qij4eUJXG61Sc3M/naY6BCJWq2sa7wy9+uns0yuFmCE4rwi
         hbjTlw/bNPM3iT7Q0Y6u8/qXnWrMmfrgCY8B7vY0KkyryaZgHs9sBuVio+XOGVqAl+Qm
         9R+U4zoalmCzyI24CyfhUmKPgVOGYgBFJnGYICVwaVPJlr+ndPz/1q1WslTbo76+8H4A
         kHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=cBJ33Gk/HgEeWNlVnscstbM3YW7WjY1Dj1+foKGyMjU=;
        b=bs4srVw1fCQks9pKQLmdef3mz6VXCW2TpqnHRC5PzH7+t3/MKN2FFF8sjGMmU8VC87
         Kga2HTqiLCTDxY1uVaW3NfvDtk4F8eix2GLAYFRDQ5tuQZDD5mJgu/s+rL0HBRcoSbfM
         PootRNN6yQkLmVN1CXqL/0GcJKDedJA4yTMWMtMNxNqxoi68OMK+qDBbXHukfL1AKllm
         XHiRJpt7HdfvWNk81SA/3uy65HEgMFMKa2EY0v3hKCZ5QrZmW9KHR4v3Pgp+K+qL5MLV
         rDJUWc1EhKH90DSwDW+rcM1jvR45K/nM+0njekbhS9nlWlR+QGA8A32RLKzz6j1uiTGE
         SCWw==
X-Gm-Message-State: AOAM5320oGmfTe/7X5IBJFvD/BKdGpqQLI5/fddxYNBvG0d6qdxfAY+T
        Z8dxEE6UziQBIBSLi6UuB0E=
X-Google-Smtp-Source: ABdhPJz2sZD32U4mjxFQKTiSUH0YJXt/fpd1FBZY0KFxoEDv0fevOf1RB2Sfv1Akk08fByeXyPbEfQ==
X-Received: by 2002:a17:906:cc89:: with SMTP id oq9mr5072694ejb.154.1611710919304;
        Tue, 26 Jan 2021 17:28:39 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id gb14sm129652ejc.61.2021.01.26.17.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 17:28:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/3] ls-refs: report unborn targets of symrefs
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <cover.1611686656.git.jonathantanmy@google.com>
 <32e16dfdbd3f54c0d4b39cbd555e66aa3950fffd.1611686656.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <32e16dfdbd3f54c0d4b39cbd555e66aa3950fffd.1611686656.git.jonathantanmy@google.com>
Date:   Wed, 27 Jan 2021 02:28:38 +0100
Message-ID: <87k0rzp3qx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 26 2021, Jonathan Tan wrote:

> +If the 'unborn' feature is advertised the following argument can be
> +included in the client's request.
> +
> +    unborn
> +	The server may send symrefs pointing to unborn branches in the form
> +	"unborn <refname> symref-target:<target>".
> +

"branches" as in things under refs/heads/*? What should happen if you
send this for a refs/tags/* or refs/xyz/*? Maybe overly pedantic, but it
seems we have no other explicit mention of refs/{heads,tags}/ in
protocol-v2.txt before this[1].

1. Although as I've learned from another recent thread include-tag is
   magical for refs/tags/* only.
