Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3470AC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0408D60C3D
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344058AbhDMMId (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbhDMMId (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 08:08:33 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EAFC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:08:12 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id s19so4036808uaq.4
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iFRqEawiFI4IDZQ3bTXOU1obs7ZKsqEqvz7seBXwNks=;
        b=XSTT7zmnyQYUvQcwuofesTHVXhRHD0gCzZTljghiXCU9KRzZQzATz4C5Zin7ZDjIJG
         h49FUZcg4Nbrba43lD+IuwByW2A+rB7RmmL7aKd+NIOzinfkO+8Pux+cBY25vR+PO1fA
         yhXHeUV7t+cDaLXdzCLBThtB74fcSBg7A5NWaFOB0Md+sDH2D5YjhkgB9nQ59pYN+BpK
         6uMv+P5cHUxbdVRbrghR7WQGqsS+u5At3W8RbXUfCNFLvEga/NzhRwqhzGwO3hIEEsut
         y0KicpHucKfb3R9Sk1FwPP7G96QwNydH1OrML/aPOPeO+6dPudsO3lx98HeykCSAYA2d
         aU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iFRqEawiFI4IDZQ3bTXOU1obs7ZKsqEqvz7seBXwNks=;
        b=uF0L/P8HYHPd4OCkFTMmhs13cwqh86Ji8u9icYIbX0z1RaMjlFPUbuL3umPi/+o9GS
         rlmxNfvLWl9yTAaLw0NOpXrNCbXWKUOaGJRN5wdtQP0j0DvYr7nuHoHHxJoDRJE1Rfog
         8ip/Jh9HmuW0jreSZ7SI7sAxjHCQytX7zm0z/F9FsLjYXBs2QMAmrwwvr7zqNIqwt2pq
         W66v/rlQva4XFSyMmlGjTmHLmtSIek+UR1rFNzkyF8Hm9rhB5p/ywRsHaM4FpHx+X0JB
         GvoIQNNXDkW06CZHtFQ+/TWafMxcgXyk3RI3pLBOhn49//tChwrWyYC/oCT5b9Iy4a2u
         WImQ==
X-Gm-Message-State: AOAM532PfCmfctEntFvJQD582uPLfkgyE1knRX+oojWnZ259Sx2clFOT
        kJqPyVdxbQjekvp/YQuQZyag7pHJsaIJb3armIseUpjnHM1fjd5n
X-Google-Smtp-Source: ABdhPJy19xZ5wY1IQGgjX5BN334nrn3n8gJqPgGi1a6Y/+N9BAhgdb0KXyhndpcvzMnIky87tqvl72H02fMLMu3lzgA=
X-Received: by 2002:ab0:1868:: with SMTP id j40mr3823708uag.143.1618315691105;
 Tue, 13 Apr 2021 05:08:11 -0700 (PDT)
MIME-Version: 1.0
From:   Vitaly VS <strikervitaly@gmail.com>
Date:   Tue, 13 Apr 2021 15:07:58 +0300
Message-ID: <CAEaE=iyUGiPK-HX850mEgC=X6atEhbjJ0dCK0dci0nOCahPhgQ@mail.gmail.com>
Subject: Git via MITM transparent proxy with HTTPS Interception
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello! Can a Git client work properly through a MITM transparent proxy
with HTTPS interception?

Is there any documentation or recommendations on how to configure a
MITM proxy with HTTPS interception for the Git work?

Getting a bunch of errors when trying to "git clone https://SOME_REPO.git"
On small REPOs (about 1-5 MB) there is a chance that the clone will be
successful, but mostly I get these errors:

git clone https://github.com/aaptel/wireshark.git
Cloning into 'wireshark'...
remote: Enumerating objects: 524729, done.
fatal: protocol error: bad line length character: ??:s00 KiB/s
error: inflate: data stream error (invalid literal/lengths set)
fatal: pack has bad object at offset 2093488: inflate returned -3
fatal: index-pack failed

git clone https://github.com/aaptel/wireshark.git
Cloning into 'wireshark'...
remote: Enumerating objects: 524729, done.
fatal: protocol error: bad line length character: ????06 MiB/s
error: inflate: data stream error (incorrect data check)
fatal: pack has bad object at offset 17119052: inflate returned -3
fatal: index-pack failed


git clone https://github.com/aaptel/wireshark.git
Cloning into 'wireshark'...
remote: Enumerating objects: 524729, done.
error: RPC failed; curl 56 Malformed encoding found in chunked-encoding
fatal: the remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed

git clone https://github.com/Homebrew/brew.git
Cloning into 'brew'...
remote: Enumerating objects: 148, done.
remote: Counting objects: 100% (148/148), done.
remote: Compressing objects: 100% (80/80), done.
Receiving objects:   3% (6247/180213), 2.64 MiB | 1005.00 KiB/s
Receiving objects:   4% (8247/180213), 3.75 MiB | 1.00 MiB/s
Receiving objects:   5% (9011/180213), 4.47 MiB | 1.05 MiB/s
fatal: protocol error: bad line length character: ?V?V7 MiB/s
error: inflate: data stream error (incorrect data check)
fatal: pack has bad object at offset 6558416: inflate returned -3
fatal: index-pack failed
error: RPC failed; curl 56 Malformed encoding found in chunked-encoding

git clone https://github.com/Homebrew/brew.git
Cloning into 'brew'...
remote: Enumerating objects: 148, done.
remote: Counting objects: 100% (148/148), done.
remote: Compressing objects: 100% (80/80), done.
Receiving objects:   0% (1/180213)
Receiving objects:   0% (687/180213), 436.01 KiB | 397.00 KiB/s
Receiving objects:   0% (1029/180213), 548.01 KiB | 338.00 KiB/s
Receiving objects:   1% (1803/180213), 972.01 KiB | 309.00 KiB/s
Receiving objects:   1% (2091/180213), 1.11 MiB | 309.00 KiB/s
Receiving objects:   2% (3605/180213), 1.82 MiB | 214.00 KiB/s
fatal: protocol error: bad line length character: O20000 KiB/s
fatal: pack has bad object at offset 2776352: inflate returned -5
fatal: index-pack failed
error: RPC failed; curl 56 Malformed encoding found in chunked-encoding

P.S. We trust proxy root certificate in the system, also tried to add
in config but no luck
