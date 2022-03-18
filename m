Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC2CC433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 17:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiCRRPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiCRRPC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 13:15:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5CE15FDD
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 10:13:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h23so11959202wrb.8
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korea-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=q+4JJJuiyY1tcZbY3gaIeSzdw1PvLX3/XOHGz2YR3as=;
        b=0F54HtH26voqvS6D6PPvgD+7yAeFCC35EQkj766i75RPPcudb7y8qrmZmqMrYfFvrC
         0I62BLZNZbnhGDqYW1IOET0A9QgZUcD1L34VElNmZkT+k0XJfELcAopVxqIbH9emoNBS
         VFqmZ2ctPHv6xsOIWvTkYB001C2EC86MjSPceCDF2CvcJmVr2tHBZl1HKzvi4JECbZxz
         /GTyEQT8xl39Nj6muzAAJ+Ybu4cXu/Jxp1zLcZVR339pwm9XK6fsOM4yQ9gWg2ZbPrq+
         znHieI3gK7Aw8/6WC+R1/UZzSLEsjdDUpscEGtskiIqxT2woazuzXXwCKSgJjX3i2wsU
         lF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=q+4JJJuiyY1tcZbY3gaIeSzdw1PvLX3/XOHGz2YR3as=;
        b=mTHTZ0IFheKOtisEvPBQsgYvn7MJHZ19jAyRkvpOdKMf410DwQkZrMAP8huo2CBs7/
         7qysw/4r69/gHv8ghOPvQrr/W/Et7OUmqiS2IiRg7fu4jb185zvt9UP46TKySF5q1J2U
         GLEpnbmyq60moCocKLEE1TU8tdN80Mpc0uwP2Cxp6FFfzrAISxcWvR6gf2RIVTH/AKI8
         fbWDjgrBndnghHUBkQY76xwmTETvkq3JOmf+uDfgiai9YH2uIJOK0un0wlEAGZCDVshP
         DnHpFgkKfy/iyaHy8S6D3uImTd+Ekq1Tdv4cMChVRnCJ7ufXQl8VPzOZolL2Q4y1zKV2
         ceOw==
X-Gm-Message-State: AOAM531twATPEQOHK9dBFzoTAkdYjckpy4bsyBm2Jc1YFID5NmK69mQy
        hYgI/jQyMm3p1OcfMUKBJaq51KtRPXaCq7v3sNRq+EZFLQqEjw==
X-Google-Smtp-Source: ABdhPJy244i0upnnUk6WGpQwiupO4RbVBCzzJfqsW7kQ5ba4OWAvu/tr7kROHH7DvoRiUeldB+80oOo32VUi8bp3XjY=
X-Received: by 2002:a05:6000:156a:b0:1f1:f168:69ac with SMTP id
 10-20020a056000156a00b001f1f16869acmr9249942wrz.184.1647623617988; Fri, 18
 Mar 2022 10:13:37 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?4oCN7Jqw7Iq57ZuIWyDrjIDtlZnsm5DshJ3Ct+uwleyCrO2Gte2VqeqzvOygleyImOujjOyXsA==?=
         =?UTF-8?B?6rWsKOyerO2VmSkgLyDsu7Ttk6jthLDtlZnqs7wgXQ==?= 
        <seunghoonwoo@korea.ac.kr>
Date:   Sat, 19 Mar 2022 02:15:30 +0900
Message-ID: <CAPb83E-Y8grG7MVWqjqPH6SsdZ2JJ62XUeQAe=Wb_zgn0RL90A@mail.gmail.com>
Subject: Possible bug reports for git-credential-libsecret
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Development team

Hi.
Recently, I noted that the vulnerability patch (CVE-2020-5260) for
"git credential" is not applied in the "git-credential-libsecret"
program (./contrib/credential/libsecret/git-credential-libsecret.c).

Actually, I'm not sure whether "git-credential-libsecret" is actually
used. But it can be potentially intimidating, thus it would be good to
apply the same patch of "git credential" to
"git-credential-libsecret".

- Patch for CVE-2020-5260
   * https://github.com/git/git/commit/9a6bbee8006c24b46a85d29e7b38cfa79e9ab21b

- Similar but not patched code in "git-credential-libsecret"
   * https://github.com/git/git/blob/master/contrib/credential/libsecret/git-credential-libsecret.c#L306-L311
   * When I put the malicious URL in the test code shown in the
CVE-2020-5260 patch into "git-credential-libsecret", it does not
terminate.

Could you please check whether this is an actual bug?

Thank you.
Best regards,
Seunghoon Woo

-- 

Best regards,
Seunghoon Woo
Korea University Dept. of Computer Science and Engineering
Computer & Communication Security Lab.
seunghoonwoo@korea.ac.kr
(+82)10-8147-9308
