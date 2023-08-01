Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE39C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 16:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjHAQNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 12:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjHAQNP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 12:13:15 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68D7189
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 09:13:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 20C693200583
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 12:13:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 01 Aug 2023 12:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=masklinn.net; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690906390; x=1690992790; bh=U3
        X3agssx5tR5epx968+goDyugB4fvBQv7diU1utOc4=; b=RezlPHsNaUcaMwr0yu
        Anh1AhHWj2MfC92SLASkyjzH/DYRzP8VzpJyYlZB3TfdvJ1SM6+/tBMXZvO8/XMV
        8QF9wKO/+E6EIW54IkLSu5JXRia5aWBWsLYJW5JAd4oDGIynC1Sne34CN24t537x
        FXjl6DvCtBhN+CxlQ9+kss5wmojCwQ8bM4ETwJdqNSs+EecUhcH5+WJh4BJRAGy2
        XuTMyGLj/6FkvQqXytEEmZwDuTvj6IFn2nGvRLcnnjQwqALoYTjPE5UPfKzC6P5C
        flcUYyyJK5Da40VYChJpJVJu0AUxPPJFTGSpn23CGJWmqkeJfDAov2IlN4h1J97w
        JAKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690906390; x=1690992790; bh=U3X3agssx5tR5
        epx968+goDyugB4fvBQv7diU1utOc4=; b=ZRIrC1vynFFaAin7h2eSzSdjeBx+2
        K+XazsrX5h9K76nvZejqxxUsW8lWO3q0NBj2e57ZW2tHT0adcVvxbB5NOACkCk9j
        25x4Z6XCRYyHOO4+pVDzJkQeYp/zmj0nSFK5PtKE+9i5F4Icnj5rSSrf1UPWF0yA
        WqJzYn0+dCoJopO8g+YJbYdEx/TKyDeeX49QvEQIrF2Ku1E6wfTPCWu+ou/GgoWJ
        t9/6PM1flv57/cCU/5bV5Fhb59/7Kq3hBSPuLh5bzcTWwVexJZTNcHIdXs5LI2TQ
        SWL2UGLuEwNUuBEAWo+IcJq8aF29b1+7+zz/DDVA/pN0qF4CEws/dunMA==
X-ME-Sender: <xms:Fi_JZCK9gse_7PIXWrccWcFz6RCWhnaYF59HfU9GH3iDXJO7N0oKzA>
    <xme:Fi_JZKIv5YdXOJb3p0v_KyWPInmDIpSLwRjPhHqC3ZqRwEoT3E1JVMjSjf8v1YrMu
    yY5FPPjyEVSuxbgRU8>
X-ME-Received: <xmr:Fi_JZCssGSKfBH0yF-ZdPEYr8sOehY0NvEKIfPkvG__r1YbrMALKZKJnlf2Md-lu-8PIyy-et4r7ORNnTy8b2N60VJRVXBe3PGrTPFQ6pWyGtbzPSXyK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephfgtgfgguffkfffvofesthhqmhdthh
    dtvdenucfhrhhomhepiggrvhhivghrucfoohhrvghluceogigrvhhivghrrdhmohhrvghl
    sehmrghskhhlihhnnhdrnhgvtheqnecuggftrfgrthhtvghrnhepfeeviedtleeihfdvff
    evtedvvdeglefhvdevjefhfefhffegjeeuteelleelfffgnecuffhomhgrihhnpehgihht
    qdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepgigrvhhivghrrdhmohhrvghlsehmrghskhhlihhnnhdrnhgvth
X-ME-Proxy: <xmx:Fi_JZHbc7WjHqTwcYiiEkv0ypd1eZzjCkIk1FYxq83prQJ9m4vf6jA>
    <xmx:Fi_JZJamZC6P0BjV3oZYexRFu_BITiix_M5ste8gAZumb2mCwghr9A>
    <xmx:Fi_JZDBOtFUcv55GBRt0Nc8t5SZWcDSl11qHEDiaBENHpfkcNL4mgw>
    <xmx:Fi_JZL30Ts06IW-r1DbKCIV-t1WevvRyahwmKlkIVCNoRjqyxB9jVw>
Feedback-ID: i3619468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Aug 2023 12:13:09 -0400 (EDT)
From:   Xavier Morel <xavier.morel@masklinn.net>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: follow-up: can't get any fsck msgid to fire for tags
Message-Id: <086FB120-911A-4660-8964-3CD585442049@masklinn.net>
Date:   Tue, 1 Aug 2023 18:13:07 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following the previous investigation of commits I figured I'd look at
tags, and I'm wondering if I'm doing something wrong because going
down the list I attempted to trigger 5 fsck diagnostics and got 0 to
work.

My process is simple: create a loose object with an error in it e.g.

    object 00
    type blob
    name bad
    tagger a <a> 0 +0000

    msg

which has an invalid sha1 reference for the object and thus seems like
it would trigger badObjectSha1[0].

Then run fsck on that object, enabling the msgid if it defaults to
IGNORE or INFO, and look at the result.

- badObjectSha1: error in git show (fatal: bad object), fsck says
  "object could not be parsed" and "object missing"
- badTagName: the diag doesn't trigger at all
- badType: does error with "unknown tag type" (followed by "could not
  be parsed" and "object missing") but the msgid is never listed so I
  don't think this is from fsck
- extraHeaderEntry: "object could not be parsed" and "object missing"
  (also "bad object" from "git show", despite extraHeaderEntry being
  ignore by default so that's quite strange)
- missingObject: "object could not be parsed" and "object missing"

I'm really confused at this point.

Note: creating a ref for the annotated tag and fsck-ing the entire
repository sometimes generates different but not materially
better errors.

[0] =
https://git-scm.com/docs/git-fsck#Documentation/git-fsck.txt-codebadObject=
Sha1code=
