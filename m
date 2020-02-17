Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737EDC34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E58214D8
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 15:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubLwFJ53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgBQPuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:50:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34093 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgBQPuO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 10:50:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id r18so21190899edl.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 07:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ToGy6XcGCEXcFVhpkyHZlZYP8L+US5H6xJDJ65rsa0E=;
        b=ubLwFJ53mYBIOp0INcpvK8nJJ9BnpLjOn/lTWB3x7EHWp2BZWfgP+MHXfXdOC1Cf/g
         TOgdujgc7ueXUTWSVVvVC+ZaQavkFzDSMe/3h8lVVLmbd1s4TOopdCBJ9uPNm2zpZzU0
         P3/CwY6MJrDElNPCsVuWUW7u8UedDyzrJJ0bTwfj/q8mEAiutTvJSUC/036trfVwfHvv
         f2u6JFSu99n9IEH0tbgntRChtWu8/aIUbd269Ykki+DB9ekZdvaFWJ/gk1N+nQNuJ7Np
         Rgd1aWPKsq2JvHP4Zl4WxID+5dRnC4LsMbJLSr5OtG4R7TX3DWPmzl4nqyXq1QcWss0u
         +FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ToGy6XcGCEXcFVhpkyHZlZYP8L+US5H6xJDJ65rsa0E=;
        b=AvFo268+AfHUuCSBaKQOaJiVxrjXc+1UNoZGMd86+FDJErbBjZNWmA3JvMBAIm58ZY
         yiWal4m6E7zrajl5X72A5h1ktCSHRy+0fpfB/iSYKW+9+h/sTtAiKCV34NBBsHJ81Bt4
         hfOz/z8Do6w8M8zvGSKCfkoCvmZ84lDmrGTHx2XBSA8M/tvsI1msc4YgV5bNNDlomlVU
         m3b2BcOEym2zMZRPNeg60FL04qVnuG6LKssGHbf5ot9GTeV1NJ9Z0P5OSVgq2Ry7Fdhr
         YV/QgMdfwd2IEUz6nXln05NswAnfJ0J+fw3bLJdnw7ejxYtnFA4SQZ02BfsoXYnhvUPQ
         szZA==
X-Gm-Message-State: APjAAAX0X4cC2rSzYYE3LxCfsD+3wrw3iL1jUPAX46BTzmMX2G8Axm1H
        0pbmc5wLLn9NYKC0/OVJMYwiOpd4YC+IW9wLNq/DXRefGaM=
X-Google-Smtp-Source: APXvYqwBoOb/7BE8F59abMwA81EUZtyc6XHFjOSG+tg4fckEuibxIO1uE36lzKz8coHh+TAEUOuVzlkPjKffDOoemy0=
X-Received: by 2002:a50:f70c:: with SMTP id g12mr15033332edn.142.1581954612472;
 Mon, 17 Feb 2020 07:50:12 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 17 Feb 2020 16:50:01 +0100
Message-ID: <CAP8UFD3fE-JHFweU+VM5xwEph7d6eUEFS23TLVsOrW6F+68QDg@mail.gmail.com>
Subject: Draft of Git Rev News edition 60
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Torsten Krah <krah.tm@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Eric Raymond <esr@thyrsus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-60.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/410

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Wednesday
February 19th in the afternoon.

Thanks,
Christian.
