Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00EDC4320A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900F5613A7
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhHWN3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbhHWN3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 09:29:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DFEC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:28:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a25so10351192ejv.6
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jl9Lv6F8LNJnQ0j37KmhWCN1mJZHA6NksK1tyDU45KE=;
        b=cPBxDTy/bUXrudI4JH+BoCxsi6qLycspP+zwoE/BuL4YMsCKqLTuloeXdM4j+VJ5F7
         CTLe1nV15ube7nhQMi+H8aKZtfh4S+aSJwW10yTRfxq6D333VfmQp3r57Q6PTZRiskIX
         6xjeUX+ZJOCzPhTvg8XhNBFv4UCQs7mKhMBqonEwqmReGW8ptB7cc2msq2prr+gCUWJU
         N0zp7meUde0IXxO5sMSTZC6aaySbzQRNL/DjnrecCEVbWcQZ8tnxsseC8eLpr0vpmEcA
         mvbIajT9gub/ohre93azI7APoixZebRP0HLmPpwTWgn38MkhUfbzsaANGQkq7nFH+n/b
         85qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jl9Lv6F8LNJnQ0j37KmhWCN1mJZHA6NksK1tyDU45KE=;
        b=s/l3nFWu0mKceckFxcHJThpBoFwsCa4HGTL3INnlKyBZFJnAdITWOrBPBExqLKDaB1
         9NzLpiKnJkOYziN6R7PdU2tcalLIKisE6cxwnXtrb8gkY3UOUUvc29g7ThLt62xg0Dtc
         8IjSNWm29u9pK54QvEkQ0qFYjTfEd93XIBjWCsYzVi6/zWBc6TZu8Cwz7g8cLMMUyif6
         8x3T7psOEAT7FnCCaWAVJVVFkNEAWTiF1Uay0qDwIWpWRvwwXkYhyHgG9fxClEPuJ/42
         WtERXJd/INS5eELS7nRwvp/ho64smfVJS35i0s4xcxZmqK3Ft3+EPF/HLlOROwy6Ncv1
         VW9A==
X-Gm-Message-State: AOAM531YqrTNPE/8YXf+Nyhltpp8vJUhRwmDMZyhIA9i8zJlBoiF9/jm
        RDLgqtpDj7I31ThqA/RM4k+tD7HHQaHyMLu3
X-Google-Smtp-Source: ABdhPJwjLJRCkscdD8MkdjtSt6j0tSaQekdcaRo5+f1vTjo78Q4zFu3eL75hja3yTBr7GMbxzMHsIw==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr36170426ejc.188.1629725311775;
        Mon, 23 Aug 2021 06:28:31 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o15sm4287686ejj.10.2021.08.23.06.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:28:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH 01/13] serve: add command to advertise bundle URIs
Date:   Mon, 23 Aug 2021 15:25:08 +0200
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
 <RFC-patch-01.13-4e1a0dbef5-20210805T150534Z-avarab@gmail.com>
 <c7ba048f-86a9-6f29-476a-7d546e477285@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <c7ba048f-86a9-6f29-476a-7d546e477285@gmail.com>
Message-ID: <87mtp8ffy9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 10 2021, Derrick Stolee wrote:

> On 8/5/2021 11:07 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> ...
>> +bundle-uri CLIENT AND SERVER EXPECTATIONS
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +The advertised bundles MUST contain one or more reference tips for use
>> +by the client. Bundles that are not self-contained MUST use the
>> +standard "-" prefixes in the bundle format to indicate their
>> +prerequisites. I.e. they must be in the standard format "git bundle
>> +create" would create.
>> +
>> +If after an `ls-refs` the client finds that the ref tips it wants can
>> +be retrieved entirety from advertised bundle(s), it MAY
>> +disconnect. The results of such a "clone" or "fetch" should be
>> +indistinguishable from the state attained without using bundle-uri.
>> +
>> +The client MAY also keep the connection open pending download of the
>> +bundle-uris, e.g. should on or more downloads (or their validation)
>> +fail.
>
> The only technical thought I had (so far) about this proposal was that
> leaving the connection open while downloading the bundle would leave
> unnecessary load on the servers when no communication is happening.
> There is a cost to keeping an open SSH connection, so here it would be
> good to at least have the Git client close the connection after
> getting a 200 response from the bundle (but not waiting for all of its
> contents).

Thanks. Yes it's something I'll have to fix. I was hoping that I'd get
away with it for an initial implementation, but e.g. using
transfer.injectBundleURI to bootstrap chromium.git's repo from a bundle
will take so long that Google's server will give up and hang up on you.

I wonder if it's something the transport layer should be doing in
general to resume connections if they go stale if it's at a point of
clean separation in the dialog, but in any case I'll need it for
bundle-uri.

Closing the connection is also going to be more expensive in some cases,
e.g. if the bundle takes 1s we'll open/close/download
bundle-uri/open/close the connection, instead of of open/download
bundle-uri/close. I wonder if anyone cares though, we can always apply
some heuristic later I guess...
