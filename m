Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F55ECAAD2
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 07:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245184AbiHZHMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 03:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244966AbiHZHMr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 03:12:47 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E99FD2B21
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:12:46 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-324ec5a9e97so14821317b3.7
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=QNlxIB4IVA+cp6sRLMGR3+lVI+dSu4VLntaSO58nvkg=;
        b=Yg5GLXJtZWVQjga/HcUph//d/M4umO+dNxUR3Z2jcjBmmPxeQ2dxh9rtV6WS0+a3ME
         +p1lFKd9TXC7Hrm7DrfJVD2wLQNOxT+W+4XvoQ1oMe/hgXgBdbsHIZE/S21OZWKvonuD
         cvwsJqE6gfiggM/foqhMopbKOOcnnwUVnsf6LCK2eTW4ZFvOAfNiEa8mjXQS5AjtixVk
         MkHhMMgGJoU9tqPVpxLC81gGQsahg+9gtbTkCXczdW3HofC+TKW2DatzgE9/IaQYCivb
         73SA7dUs/f+gHd3eEtpy/7j9xDzNEINpuaf3RkKF7tmF444da4E7URHEs6T4pD4vRkXy
         ZqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=QNlxIB4IVA+cp6sRLMGR3+lVI+dSu4VLntaSO58nvkg=;
        b=yK0J+NHLREUAqROgwM4u33KWkQIzDsFbpM9kgBOqRWLY4X/mnyI/MSvnC2NF71hsA/
         jsoVGb04FBoiV3PhnSDil3vNF47JS4WzAOs4Qa9Gj211oraKpGzZwK/g6z3LCA3v4sIz
         uGQufoxpyAB9gANxApQAHkIUI+I0bzq/ErTcrx28cDkyp+EO3x2NhVb+w3DtWNy/eob3
         fXGtD15azAcKnKBRafGMwpJIokhdLwb98Y/osLIMBA3wcBK35MJNYUu9IJQ3ITEhNo8h
         Z7OYeIQK8RnOhHsTCTP23teR9JhDcqhefzuB0vv2xgy97UKbsEJy9Qil/2fADGSWmOMa
         qdYw==
X-Gm-Message-State: ACgBeo3VD9uFxz8tDthAG9iLRCVUGiDJ1Mq4uVC+KD+65gt7Aan3QJSo
        Da554mHd9+zR15M5rVsiAAvlYgcg79+yl/+TwAG9XpiWe48=
X-Google-Smtp-Source: AA6agR42qwULknb5qQBIwAo2voKrfn2h6KfutcyjLoRKmGF5fTskMwLzegUY9QufPwNWc7wFRC98Crl8ltZKogM3DJc=
X-Received: by 2002:a81:ae0e:0:b0:33f:767b:5e3d with SMTP id
 m14-20020a81ae0e000000b0033f767b5e3dmr345191ywh.418.1661497964883; Fri, 26
 Aug 2022 00:12:44 -0700 (PDT)
MIME-Version: 1.0
From:   Zang <zealot0630@gmail.com>
Date:   Fri, 26 Aug 2022 15:12:34 +0800
Message-ID: <CAOrge3pTP5WU3Z1HRLz7xqExwt7_n33FUkh9KQP2m6VyuA9sJw@mail.gmail.com>
Subject: Considering add log.format and show.format configure option
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi forks,

People including me are asking feature to use different format for log and show:

https://stackoverflow.com/questions/20579889/different-pretty-formats-for-git-log-and-git-show
https://stackoverflow.com/questions/37898232/make-different-pretty-settings-for-git-log-and-git-show

Can we consider add such option to git-config

[format]
    mylogformat = <...>
    myshowformat = <...>
[log]
    format = mylogformat
[show]
    format = myshowformat

Which should work same as

git log --format=mylogformat
git show --format=myshowformat
