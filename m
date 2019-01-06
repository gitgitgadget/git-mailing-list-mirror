Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19905211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 22:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfAFWwI (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 17:52:08 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:33711 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfAFWwH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 17:52:07 -0500
Received: by mail-io1-f42.google.com with SMTP id t24so33529079ioi.0
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 14:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zKxB4dPKTYmUS44D/HpdHS8zKWchgRXYhvMY3ONlGFQ=;
        b=s0oOt1A7+T8FVQ4yzuZtqUsPCoH4XI+cz5V5i43PusPnzfPrTSJZGN0XnfOhqcSVwa
         T33nsW06zfM26GgkRkzWR+6At91rdu1o+3vFqFKh664mQkd8I829QsgQHz1Wmw2F2L4t
         CBnPN+d5iRliT6laLkkZOY1vSB6m9sugBlgXpTCHMWKiKpl2WKZqKVtsg6wkNkLy4tBb
         aDYDOsYRO6YucFeZIlc8RRvcqZk/ZRAXSpJOsXvfvjuooYDtW0Y1GKvEat1uXhQy+TC+
         E0HdsREEMpu4Pmgot+Znaz0x0wbXAU0YffxW0tB/p8UZr85D4vxJSg4cXy9eXLGbP3EG
         ON5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zKxB4dPKTYmUS44D/HpdHS8zKWchgRXYhvMY3ONlGFQ=;
        b=GazNsxiQCXj6iuUU7yEnDMUusITKHCFSCfNpk8uIGr3TrduWBp09htLQ4bu4lGTCQt
         /MaSsRLP36GW+g2+1bGAR3bUJq84W+ityaG4UdbmvBckFIXZqji9ohADcRqJh+lnibgt
         Y/BDZDNYLxoOVwi8Dupf87tqLMdO35r2vDk3VZCF3b2cm6WjzkoR9UCbL2lRbCQO1yEH
         LV4f+z9ojmg4eWu4cKQGE2a5Kjea2C1cnYdvM12NQ0hi3cVZ3JsPmxAUZIYyehlyv5vu
         k9OFMV+fU+YMBPrKUW7fKs0rFCxecXeEF+nIdlUDc189yfYL1HLX+aKvZYUo/72zAanP
         hMQw==
X-Gm-Message-State: AJcUukcJwt5bIJNRRdfeaI5Wy7UGyS1Rs1oMqp/bMWVhrZ4MZpKFWsjD
        lnUTXST7c+sQwQo4/Gc/4BHIvd/plF/I8c34M7PXUU1T
X-Google-Smtp-Source: ALg8bN5JnlIl1hTpPI7+d9F6mCz8cKtdTdBx+TMSzU95IV5EvepMyctqnrlQ1ZB2GuSIVNHdoCDeXvMEM5l0OyChVZM=
X-Received: by 2002:a6b:3c17:: with SMTP id k23mr28679184iob.182.1546815126614;
 Sun, 06 Jan 2019 14:52:06 -0800 (PST)
MIME-Version: 1.0
From:   Jacob Kroon <jacob.kroon@gmail.com>
Date:   Sun, 6 Jan 2019 23:51:55 +0100
Message-ID: <CAPbeDCm5hjq06fbs=SUPR1rm3bD3GJvifZovP1d-Xd=01JfpYQ@mail.gmail.com>
Subject: gitk shows local uncommit changes after touch file + reload
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Not sure if this has already been reported, but I observe this odd
behaviour in gitk from master:

git status
gitk # everything looks good
touch <file-under-version-control>
gitk # gitk shows "local uncomitted changes" on the file I touched
git status
gitk # gitk is back to normal again, showing no local uncommitted changes

The issue has been discussed on stackoverflow here:
https://stackoverflow.com/questions/49990403/after-tar-untar-of-git-repo-gitk-shows-local-uncommitted-changes-not-checked

Any chance gitk could be changed to so that it doesn't display the
"local uncommitted changes" blob in this case ?

Regards Jacob
