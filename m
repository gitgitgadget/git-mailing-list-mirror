Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ACE52047F
	for <e@80x24.org>; Wed, 27 Sep 2017 19:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbdI0TGs (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 15:06:48 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:44411 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdI0TGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 15:06:47 -0400
Received: by mail-wm0-f52.google.com with SMTP id m127so21854561wmm.1
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=X801YUb4qARmcM2qhY7uiNCTfBqC/wXjkVecEf2rkRU=;
        b=LpZbPIXDipSjYIWcPaFNH/unrsAACYTLWP9Jxk2gNq2BQf1chD/O/8r7uGrowWGjE/
         6b0rK8+9K11gF8mxpzA8z60N0uzR12bJB44/5wSd1RkBKkn6yBCuDz15m6nQwp3KpbCD
         o4V0HqLZAcEm5B4bhHrY8c32V/bDjjno83X2I4LGOX0CFILVOWVrQBAtG44qVCCU2Oha
         vUpnApWkePnzjvtl8CZxCa426PKfotM59i1nwi/lWCZLDvgJhNoscpBSAhY+ALPZf69T
         2v8VRuH+sSbUY4E8nXDECERAP5o/ODcFFHa/JMoFovziwQwHfTO50Q7LLE39eAqfVaDz
         ZPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=X801YUb4qARmcM2qhY7uiNCTfBqC/wXjkVecEf2rkRU=;
        b=aPjpR2U7FPtex+rbr9zdeRF0kvOrF0zMsx8ZyCGp9/13KwayoNtmgsjOZKtxG+EJUM
         bfTNv30Che3U+VC8+MhPhtYm5K85SVd/wvnXz8QCzQ5vGbljM4BCG2dKBxoeRuv2DpXD
         DXch7YdIBNHhaQ/W/ZhDO9fhJ7nG3PLANWXx4/66/ak9X1C6O79V1WdWhkXuMI06sDW7
         LsTNkZs250miDEcEkSZXCkhjHCdILg9H5HNnwMVgUvq4mpOe3Mr7CDVSM1pTJq/MFZKo
         5VFvCwNRZwdukjhuuDwL7IIr6/jqc0nhTmFc/mUhZ0lkSsjYamcmzbV5VCAI5LdMKzLg
         XZOw==
X-Gm-Message-State: AHPjjUhsv+3Sfdk++mKD4B/PWQUDj6Fy9XUOZFsjgDS9Hr8KuanVqywc
        J8ZkE7F3a35ma8mQllHv2HcpcIBU4d39aadsCtJPr2n4
X-Google-Smtp-Source: AOwi7QCzuyezTulZHlJLTozCP7E0CdQbfXfkjWv6tmXDgybS+ZsV7800zeg4qEPh6lq308shj6/Usr/t0NDm62l1d+A=
X-Received: by 10.28.210.5 with SMTP id j5mr1075352wmg.15.1506539206071; Wed,
 27 Sep 2017 12:06:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.154.163 with HTTP; Wed, 27 Sep 2017 12:06:25 -0700 (PDT)
From:   Ilya Kantor <iliakan@gmail.com>
Date:   Wed, 27 Sep 2017 22:06:25 +0300
Message-ID: <CAFU8umg2cgmmCvGYbu0P3M02AMcttUfTCFGTUcsF7shd80XwSw@mail.gmail.com>
Subject: What's the idea of specifying binary=true together with textconv?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

When textconv is specified, the program is always used for conversion.

E.g. consider this:
[diff "png"]
  textconv = wc

Even if a png file is ASCII (manually created), wc gets called, and
the result is made of its output.

So, the question is: why should one specify binary = true together
with textconv?

There is an example in docs:
[diff "ps"]
  textconv = ps2ascii
  binary = true

...But what binary = true does here?
Even if we remove it, textconv is called for all ps-files.

---
Best Regards,
Ilya Kantor
