Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB1D20D0A
	for <e@80x24.org>; Sun, 28 May 2017 07:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbdE1HPp (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 03:15:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33704 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdE1HPo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 03:15:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so8951524pfe.0
        for <git@vger.kernel.org>; Sun, 28 May 2017 00:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=DwJw4y/pAXTI3DaOSV7aqryJGNg6iWl27GfODlsNgtw=;
        b=DX4XOdm4KVag3ZQnWoiDN9+VsvUv09pWsL9ogvRsr/XkxKq+FdYtEOCzYghzl8JNeu
         CMCnrngPUIRnHDps3hehk/DBKN84pxPVDmbWG+bGgTAPf1fN7HbgFNt9BpyXIwOCxIM1
         GksO8L3wWApyBO02WDytJE6msL1Hgun6d5OVpHrrigGQQUX5Rctk+Kjrx1oIB/itQ7WZ
         ZB+b2aexnCUOHroNxRb/+cKN32lL8csSpAGiRP048+oMARf+eVHq8H/3SuaDm84UwQWL
         518bnn35C7Xnjq2zGY7nZ+dhgp4Uj26wIbEiHBc0QfzYiuxA3mL+P6/co/yJ7OcPdzhK
         gqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=DwJw4y/pAXTI3DaOSV7aqryJGNg6iWl27GfODlsNgtw=;
        b=jufl4xpFRGGfecxvF4eALKO6PdYmWdFX3WUbJ2gfTNo3xw+fhdEGjA37TRc+Oh5k+3
         jXDNckThM60+kf5V95ayLuQEfwAOOAfBV2RN3I7nTe+rGeCSAWQr5JTPreJot68xNz8v
         PVSmQmZAipAyUDE6lGB8W/3fUUYkRcaeLu6q8ixmUpASW7fCnEeY4NKuXa2vr6CVZ6en
         bmTWUG86LSRhZQcwtiz55VTKVp6ynV3ZPirZkXmhsagDEfiMXmKNqe86Mdt4mOwduV1X
         s1xFIkmsOvwTvsTv/9W5f/BYqSMz8XDkXY4d4RuR9cBhYi4YoTgEJwtW+6MSkZlKf3KG
         fiug==
X-Gm-Message-State: AODbwcA2YcArv1U8ETZvOnDyyhkxMi0F1bEPEJ5XxkXH3USzsnQQWExY
        MJkeH02dIWSxZL0hl8U=
X-Received: by 10.84.216.79 with SMTP id f15mr10051255plj.178.1495955743293;
        Sun, 28 May 2017 00:15:43 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id m123sm10111937pfc.51.2017.05.28.00.15.41
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 May 2017 00:15:42 -0700 (PDT)
Message-ID: <1495955737.4716.3.camel@gmail.com>
Subject: Missing: Consistency of clean state output of "git add -i"
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Date:   Sun, 28 May 2017 12:45:37 +0530
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,
When the "git add -i" command is triggered with a clean working
directory and index, the outputs of the various options don't seem to
be giving consistent results. A few of the distinct outputs are,

1. No output, the options are displayed
2. A single blank line and the options are displayed
3. The "add untracked" option, prints "No untracked files." and adds a
empty line and prints the options
4. The "patch" option, prints "No changes" and prints the options

It seems that the clean state output should be improved for the sake of
a consistent user interface. 

Note: I could possibly help if I were pointed to the implementation.

Quote: "We hate most in others that which we fail to see in ourselves."
- Anil Dash
--
Regards,
Kaartic


