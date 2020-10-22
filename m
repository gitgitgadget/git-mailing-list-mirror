Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A515C388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 20:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D15B241A4
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 20:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=speicherleck.de header.i=@speicherleck.de header.b="iSgXiFae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370502AbgJVUAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 16:00:21 -0400
Received: from www.speicherleck.de ([173.249.60.202]:38366 "EHLO
        speicherleck.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370423AbgJVUAP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 16:00:15 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Oct 2020 16:00:13 EDT
Received: from quasicoherent (unknown [79.143.177.192])
        by speicherleck.de (Postfix) with ESMTPSA id 0433525E2410
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 21:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=speicherleck.de;
        s=201902; t=1603396236;
        bh=JQh99id59JwcrYXVEkw9B4L5gQgl/zd/IDOQRWNw1hU=;
        h=Date:From:To:Subject:From;
        b=iSgXiFaedPeS0jeK4AROBpnGQOeDUrgvTKBZNENP4AaMCDLYXjz5i2zx12sYi+9EB
         cqLEAuojnMDM5TcCpzWN2SdAXOCV1uRaXboBGPWxBbznO0pP8kWYjqxfsE/uK5l3Rg
         3SZViuyynXtaDD+gF1EdfYgUmWdBtZXkL+4WVz+yOPgotx5hKX7z2NQyogoWIpgBA/
         iWdCf6bWIDQUK8dHOnUxSdZ5qS/P03QMRZ9WFZgSGwQGhesHKYIqLZlT0l6fs5htjp
         EQtWvCUao2ID1iHGm2mgs9u8lXRUM78T313c8lfjRXGmviFsYRxEXHfkrLfWAhHSev
         fZCFx93DaWP9A==
Date:   Thu, 22 Oct 2020 21:50:33 +0200
From:   Ingo Blechschmidt <iblech@speicherleck.de>
To:     git@vger.kernel.org
Subject: [bug] gitk doesn't start if font name contains spaces
Message-ID: <20201022195033.GA29199@quasicoherent>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Registered-Linux-user: 232173 http://counter.li.org/
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git developer community,

the following bug in gitk has surfaced in the NixOS bugtracker
(https://github.com/NixOS/nixpkgs/issues/86003):

gitk fails to start if the X resource "font" contains spaces. The
command

    $ echo "*font: xft:Bitstream Vera Sans Mono" | xrdb -merge
    $ gitk

reproduces this bug. The gitk window does not open, instead the
following error message is printed on the console:

    Error in startup script: expected integer but got "Vera"
	(database entry for "-font" in widget ".___tk_set_palette.button")
	invoked from within
    "$q .___tk_set_palette.$q"
	(procedure "tk_setPalette" line 82)
	invoked from within
    "tk_setPalette background $c selectColor $selc"
	(procedure "setui" line 8)
	invoked from within
    "setui $uicolor"
	(file "./gitk" line 12498)

I'm not subscribed to the mailing list but am happy to help on this issue.
Thank you for your continued work in maintaining gitk, very much appreciated!

Cheers,
Ingo
