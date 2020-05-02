Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6731C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 21:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7891020757
	for <git@archiver.kernel.org>; Sat,  2 May 2020 21:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sudoforge.com header.i=@sudoforge.com header.b="Rk7aBkgu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DY3ew1AJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgEBVB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 17:01:58 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36453 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728472AbgEBVB5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 17:01:57 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 884385C0078
        for <git@vger.kernel.org>; Sat,  2 May 2020 17:01:56 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute2.internal (MEProxy); Sat, 02 May 2020 17:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sudoforge.com;
         h=mime-version:message-id:date:from:to:subject:content-type; s=
        fm1; bh=OqhzOYM5rt12mOzn/diGIu88P3SQkmuQN92moCiVyHo=; b=Rk7aBkgu
        6tO8iFsyfpb1s1jRxJoITvS7eQaNG7JxgviEWNr11pUe2XgPDEizVUm3ip5rq8nv
        Yn3IgvBUPX6SoqvadklhVImbwGqopFiFHU8IBV6OMM1ccBtf2WpkeBfYhPrOwpH7
        mB9+6TEnhLC6e7bhPHqx1DBNhfyr2qJnmiAQ8Y5Ma6wyJxRcfh7ldp1FGU8290tS
        gldo81ZRVwERDpcTSAdIS4gbbLcelzmxOGdDk8JMhzRWn3QveIdSfUBbapghtp8F
        o6YKWHefYNd9mEPiH0D0Wv3nskxr1mH1rHPsTSJ//v1SQwBT/x1tuspvq51Y7EUj
        5LzZJuu6knxK3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=OqhzOYM5rt12mOzn/diGIu88P3SQk
        muQN92moCiVyHo=; b=DY3ew1AJH4T/yCMrqR7EpdzsyAjECNyMHHw2ByguxHI7B
        cnR+eF/wCZm5P4Y1DbfUixYLxCzzBHVpKw9Rlj3uq1Ut7hfeY6+VtkBgtv+5KzGD
        6ZHNLpR6wZ413HWYmEQZrFHxE2QDQFHnPDJqaoMb9VEo2DoB96VMmuUxA78st4Wf
        pkHBd9hD9JFETq0NPkZPHYGrq4YzmM95WIBCJ8hkBllIY0143efYW2toRTOi71wa
        03Y6Q8M4f0ycHdfROYbYPSP83fdKX7BJklODDjEqZEUcHbAq7JXs/TJSMEe0Q/4B
        wYWy1l9+ZnxOvE1FHY736AaOkZAZWfv1dSBkh2Nog==
X-ME-Sender: <xms:xN-tXrDyoGIT1JisUPOqeGzT29QEfOLgApU1zNRWMI7tzsr1m15aEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieelgdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfuegvnhcuffgvnhhhrghrthhoghdfuceosggvnhesshhuugho
    fhhorhhgvgdrtghomheqnecuggftrfgrthhtvghrnheptdejieettdeigeefgfehgeekte
    ekffeludehieffffdtteeivdffkeegffehleeknecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsggvnhesshhuughofhhorhhgvgdrtghomh
X-ME-Proxy: <xmx:xN-tXlxq9pOgrqrxhq-Nf9MR1DIkh7JcJvtwQOgj8dBfslqWqqb5vA>
    <xmx:xN-tXhne9PlTiE_-MOOcOm1uwRRwl9vzAbaePLQr3BNXRGXt8hp3LQ>
    <xmx:xN-tXiEQ2Oisgs8jbntiPUZv-y8xiHeY3e3oNA52on8hBqNRYbK1Hw>
    <xmx:xN-tXq7BR8bdNY_QOYwL2hqqtqQ10bizy31TctzY7dpQ1WKvqnbyVQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 266F0E00A9; Sat,  2 May 2020 17:01:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-351-g9981f4f-fmstable-20200421v1
Mime-Version: 1.0
Message-Id: <7480e635-97cc-4acd-875e-54bc71a88068@www.fastmail.com>
Date:   Sat, 02 May 2020 14:01:35 -0700
From:   "Ben Denhartog" <ben@sudoforge.com>
To:     git@vger.kernel.org
Subject: --no-tags doesn't appear to be working as intended
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From the documentation, it would appear that `--no-tags` should avoid pulling tags, even if they point to refs which match the refspec being fetched:

>        -n, --no-tags
>            By default, tags that point at objects that are downloaded from the remote repository are fetched and
>            stored locally. This option disables this automatic tag following. The default behavior for a remote may
>            be specified with the remote.<name>.tagOpt setting. See git-config(1). 

This, however, does not appear to be the case: Either using the `--no-tags` flag on the command line directly or setting `remote.<name>.tagopt = --no-tags` appears to be ignored when running `git-fetch`. This can be recreated simply:

```
# /tmp/a will be our "origin"
# /tmp/b will be our "fork"
mkdir /tmp/{a,b}

# set up the origin
git -C /tmp/a init
echo "Hello, world" >/tmp/a/README
git -C /tmp/a add README
git -C /tmp/a commit -m 'initial commit'
git -C /tmp/a tag 0.0.1 HEAD

# set up the fork
git -C /tmp/b init
git -C /tmp/b remote add -f --no-tags upstream file:///tmp/a
```

You'll see the 0.0.1 tag being fetched. You can delete it all you want, set the `remote.upstream.tagopt = --no-tags`, etc -- it will always be pulled. This is the opposite behavior I would expect based on the available documentation and discussion around the tag in the mailing list.

-- 
  Ben Denhartog
  ben@sudoforge.com
