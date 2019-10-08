Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BDD61F4BE
	for <e@80x24.org>; Tue,  8 Oct 2019 21:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfJHVim (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 17:38:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42908 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfJHVil (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 17:38:41 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so266389iod.9
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gYDrN0550IW4gaQ5Y4xHLKNKseVnYkuMzDH5AB21nrs=;
        b=IX46C/s/0A0DbfMyIVbG25lWsfhAnjl0beBNhMe1PFvrl8GeYA5tK7+blVzVlKk5Co
         tjzXfWF3wnrl1irgrDU5ZNnR2UGRTBri0Z7FtvFq7jSzdII728g5r/1CGKED12uwhtuD
         G7ubUyHo6TIJlx3T0ImJWrWMoFrKxD0brPxbayPFZO2R8Vre7kcFwchfaCqCaRLwT+DY
         G64jvygcQ4xS0xhU8XmY+E0HzhmRe+ywuxYTJ1+ZRXwc5yeInAF+5y/KdL5Ie1R1djB0
         OtaCeC6H9TwzBKXJrlcUdnbuHdAk+G13iyixBDHO6nYXOZSW5CinIEfgJbA3g/T/SUg8
         j3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gYDrN0550IW4gaQ5Y4xHLKNKseVnYkuMzDH5AB21nrs=;
        b=Hn1H2MhzYYFEj5QGD6TIaVbSf9LI7CneDCDlvrFGfdLNMBbaFghkINl639y1h2DlAb
         O9YMrRYTbtNM5PwOcVxWIpGPnc4NlBDfw3wdQyulj7Vdn2x2dDEMHodQrz1Tx/ntoVwW
         hdQQEyNmBeIruXBIq/okZHw3FDvLXt5WMyHtull9geRVbOlzfgBSSQxA6Qq/rAkqZpX0
         cP9aEd0SIWIPufbx7iQ9QvLwIOjlky7fQJIYvDgHoj3QqM/TttGqv/phAt8Q9GT4GYRC
         wKXjcoMUevbDfttAaU2kZIRptGq7gBF7lPKsFNFrkW8tAVnANdeL44bku6dZ1a28YY4Q
         WDUQ==
X-Gm-Message-State: APjAAAUwd1ZST2uRGMITP0lByIAvX8YmTcxf3+97y+wrIfNO4/n6Ps2u
        NZ0QwkyVBc2X7CNkYH26mNqWzeM79VpMwWw32J7rVpHy5Mw=
X-Google-Smtp-Source: APXvYqyZ4unvfAvXhsMMDNwxGq+p22MNo86m4B/ltuEx28Lm0k4d7aoHNiBpVq7iJFMcDyee5zyvGjF4WoDrzZABGTs=
X-Received: by 2002:a05:6602:2207:: with SMTP id n7mr354643ion.36.1570570720201;
 Tue, 08 Oct 2019 14:38:40 -0700 (PDT)
MIME-Version: 1.0
From:   Francis M <fmcbra@gmail.com>
Date:   Tue, 8 Oct 2019 22:38:27 +0100
Message-ID: <CAO+szGsZS9CaU4u77pwxwDssHszFeDAshVxLmqJhd3VAR5T=uA@mail.gmail.com>
Subject: Shallow-to-deep conversion error query
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Quick question, hopefully. Have tried searching through my local archive
of the list but didn't find an answer, so fingers crossed this hasn't come
up come up frequently in the past...

So, a fresh shallow clone[1] of Linus' mainline repo followed by
"git fetch --unshallow" results in:

  fatal: error in object: unshallow <sha1>

Re-packing with "git repack -d" sorts it all out, but my question is: is this
a bug, or is it instead down to something like the server-side version of
git that created the pack being outdated or similar?

Cheers,
Francis

[1]

# git clone --shallow-since='Tue  1 Jan 00:00:00 BST 2019'
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
torvalds/linux-mainline
[...]
Checking out files: 100% (65698/65698), done.
# git fetch --unshallow
fatal: error in object: unshallow 00f8ccd0c95f4e604297057a5bccec86c0903d14
