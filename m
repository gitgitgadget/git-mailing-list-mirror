Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5F351F404
	for <e@80x24.org>; Wed,  7 Feb 2018 13:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbeBGN3M (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 08:29:12 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:39812 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeBGN3M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 08:29:12 -0500
Received: by mail-oi0-f50.google.com with SMTP id j188so632688oib.6
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 05:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HugHSu4+wIcx2/oszvWw/gHU2dvavEuPkLj7a7jdR0Y=;
        b=Lfj46S7EzXnrT+mMGyLjfNsNw2QTJRrSq7mhEX5eCWuXEupmMchRmpEdY5x7LQYtMY
         88y2ZiihD8YBHCzQTm29lNfO/2Psiplroavr88eNjusJdABe9GhqWbRU/M5hnQsr7LU8
         Yy78L+6Ti0jKgQuk3BhyFQRAto83DD/tQyYrikj1ifMj767UeVALTXrmYgj69t54WlNz
         Ndk9kPIPM2qksu773DLLFznqM17/+MKH9K25jKH0wbOVpNG6qRummtOQ6IDTpkrzBaw5
         h6mOMbqyPhHQirX6+5jq4vCblLZzeEq7sdBsNpbZtmXhKToH62m31hd8WRt6qUua4E34
         obLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HugHSu4+wIcx2/oszvWw/gHU2dvavEuPkLj7a7jdR0Y=;
        b=hQR/hrsyGi4R21qR5hGeIBaHUl3gBUiKVi98eExU4OnmmA1or2LB/Iev4KxThfyHtF
         JyNVnsCS9cgAz+kVrsvysND8GA04qEFH/EKSM/G3nr2+2QP5L67guq0EkMnsuG9/RTPI
         JUJEOzQ6lg2m/7quxvmHUXmB16fW5NQO6GwHhSj8tjtnU0dkPPG3OdUkKz851PBatqhb
         JGW99Q8kWNGiKEXnPSxgw5aRYVxLoSEOoCtAnAzO6jbXwDxrn+Oy6vVd5DkZT+LkV+uf
         1ZKv9LoHCcPp9fN5ZiB1LewFdvAKr2rh4PDPA0SOYnMIVDZ/sq/IEALmVsTVRmlMT8o3
         3/SA==
X-Gm-Message-State: APf1xPBylCRq6HPBg43Zp3kcSVX+JheAEPflDFYXZPXN+tPgDaxrGDXF
        uZvgIZ2Og7l1Jn7OeA5WFKk6EO84ScCZN0VU/2x1NSTQ
X-Google-Smtp-Source: AH8x226GLPuiWAk7B/62YRguRedvcwhu0zswuZtbYNNJ2Dursd8Lj5sTN+u65v2bsVgdxRZePeYI+Y6pJF6ioUkBI0Y=
X-Received: by 10.202.0.200 with SMTP id 191mr4097077oia.206.1518010149801;
 Wed, 07 Feb 2018 05:29:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.168.52.129 with HTTP; Wed, 7 Feb 2018 05:29:09 -0800 (PST)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 7 Feb 2018 14:29:09 +0100
Message-ID: <CAGr--=+V6zBo_0c_pX=PNVq1+8N-Q14+wgYx1j_odSGcRAv0hQ@mail.gmail.com>
Subject: BUG: On some Linux systems, "Stage To Commit" hotkey in git-gui
 stages one file only, even if multiple files are selected
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-gui, multiple files from the "Unstaged Changes" widget can be
selected. Once multiple files are selected, they can be staged by
clicking (toolbar) "Commit"->"Stage To Commit". All the files that
were selected then gets staged for the commit. The "Stage To Commit"
hotkey (CTRL+T) behaves like the command itself, staging all files
that are selected (Tested on Windows 10).
However, on some linux systems (currently tested on Ubuntu 17.10),
only one file (the most recently selected) gets staged when using the
"Stage To Commit" hotkey (CTRL+T), while the other, selected files
remain unstaged.

Steps to reproduce (on Ubuntu 17.10):
- Open git-gui in a repository with two or more unstaged, changed files
- Select two or more files in the "Unstaged Changes"
- Click CTRL+T to stage the files that you have selected
(Only a single file will get staged)
