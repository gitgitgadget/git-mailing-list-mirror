Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A202023D
	for <e@80x24.org>; Mon, 22 May 2017 13:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759906AbdEVNuH (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 09:50:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35125 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758628AbdEVNuF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 09:50:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id g15so13759196wmc.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gCLBfpp+WeKjwRbumAGQC1TJhER2+m0OWmGYcF0vZvE=;
        b=VX6wCwmXB/wLb9AR11E56/e0XC6t+Jbr9l9kHODm6xvah8FK0+kfvDuSQ99nftHCwI
         vuxaiXbbnndx6E28CFGgQsxm9dRkVyWbBGCAGoYrXbvv3ouVbEDiEPDYwEiEWTW3LnCF
         FhDMO/ubcZUXZnjzmokcXRoSnsev1DT/XdfUIS+Hmg3F0tyZeEj9i7YaN5r6zPpkc6Tu
         nScLQyzs98tpMOngpUYWtPZwRrF002mpb/kSIWY1ZEDGjA0IngDV643N5K8JKIq7Ut2Y
         LBfcS2YIscR+z9jOhamGPK706szK/0L8qEV1nDSqVCUtAh1kQOrY3zjNRaFo5mYDR3TC
         L1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gCLBfpp+WeKjwRbumAGQC1TJhER2+m0OWmGYcF0vZvE=;
        b=AwDnOOYeG/ltR6ITl58Z0jWIqJl0bkTYSZ71fpYHpvuCWoxvxGsubfOrDOscpkT8yP
         MxA8JKJmmblDpA7EdHV1BSQgV7jzDN8q1FRQPq3WlbkgKUSeeQanF45dOTAvjuAkndNx
         sUeVW8Jh9+e7/5ehTbm+o4Vas7vB7swkn54ljZAFJfuergzJf7pIMHPeQjeJJisx5NMq
         UmRL/5BUMTd9ieNFHRbAXDak5ZFprIAjn66OrHzlhZp1mQhLP29veMr+PQt02lNxJkrG
         zVgMFiOgLM5HYls9D81snxcDGil3hP7ieTFVV+aPzW4qSjNpvFKlgzptVj3OBpmHHSNy
         hvZw==
X-Gm-Message-State: AODbwcAJADQpSliRFIkvJJCHKnx1nu/bEhsdASj20NEokTnHRsO6yadl
        0FMeY+bwcluE1s/o
X-Received: by 10.28.15.67 with SMTP id 64mr14245195wmp.61.1495461004254;
        Mon, 22 May 2017 06:50:04 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id y3sm22638070wmh.21.2017.05.22.06.50.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 06:50:03 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com
Subject: [PATCH v4 0/4] convert: add "status=delayed" to filter process protocol
Date:   Mon, 22 May 2017 15:49:57 +0200
Message-Id: <20170522135001.54506-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

here is the 4th iteration of my "status delayed" topic. I am sorry for
the large delays between iterations. Patch 1 to 3 are minor t0021 test
adjustments and haven't been changed since v3. Patch 4 is the new feature.

Most significant changes since v3:
* removed "delay-id" approach. Delayed blobs are identified by their pathname
  (suggested by Taylor, the main user of this new API, see
   http://public-inbox.org/git/20170412173404.GA49694@Ida/ )
* rebased the topic onto master (2.13)
* moved "struct delayed_checkout" and "enum ce_delay_state" to convert.h

If you review this series then please read the "Delay" section in
"Documentation/gitattributes.txt" first for an overview of the delay mechanism.
The changes in "t/t0021/rot13-filter.pl" are easier to review if you ignore
whitespace changes.

Thanks,
Lars

RFC: http://public-inbox.org/git/D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com/
v1: http://public-inbox.org/git/20170108191736.47359-1-larsxschneider@gmail.com/
v2: http://public-inbox.org/git/20170226184816.30010-1-larsxschneider@gmail.com/
v3: http://public-inbox.org/git/20170409191107.20547-1-larsxschneider@gmail.com/


Lars Schneider (4):
  t0021: keep filter log files on comparison
  t0021: make debug log file name configurable
  t0021: write "OUT" only on success
  convert: add "status=delayed" to filter process protocol

 Documentation/gitattributes.txt |  65 ++++++++++++-
 builtin/checkout.c              |   3 +
 cache.h                         |   6 +-
 convert.c                       | 131 ++++++++++++++++++++++----
 convert.h                       |  21 +++++
 entry.c                         | 110 +++++++++++++++++++++-
 t/t0021-conversion.sh           | 136 ++++++++++++++++++++-------
 t/t0021/rot13-filter.pl         | 199 ++++++++++++++++++++++++++--------------
 unpack-trees.c                  |   2 +
 9 files changed, 544 insertions(+), 129 deletions(-)


base-commit: 10c78a162fa821ee85203165b805ff46be454091
--
2.13.0

