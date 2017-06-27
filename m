Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52DAB20401
	for <e@80x24.org>; Tue, 27 Jun 2017 12:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbdF0MQF (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 08:16:05 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36781 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbdF0MQF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 08:16:05 -0400
Received: by mail-vk0-f41.google.com with SMTP id y70so14783277vky.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=U8B2CZIuGjwgNa6g2QM4BbQ5cQlU9yra+PGNTbXbtKw=;
        b=skxBpI55AON9dXLCjJD9yHqBJHbrujZ7P7gcpXdG3NvXQjvLJmIvB5Yv89RtG+7hcQ
         T2UMm8o0bDF4W2CJKE31Z2/lIsC+B2GJMEs5QqgZgE8sLSLiopJqkug3p6wUjREj/DPH
         iql6muBRemJTy9zaFBuCWW6cXbkKjuCbjU8dg18SErxcOrELnMvEI7aJH4XvMbdlkWue
         AgKmLmcRCKOBRi0qbYoA9PJJ7hIQYaCtNlOis34R5IFdLENs8i8ahCsWMdMrzWkkyiCe
         ArAJWpVkgiaoQx6zUW+cMB/LzmjKoVNIJUoPWd90kaQXIV1fz67A7U5Fwaq02ixQzJqi
         etCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=U8B2CZIuGjwgNa6g2QM4BbQ5cQlU9yra+PGNTbXbtKw=;
        b=PzVUWHqQallH7xpKA4GEsHc+JOU893LHQXledCA1BA8fQ4iYQuFyWSi0FBYfI9A4/a
         JsqogXfWQmY/1xS//X7b4RB3S14jhwEIaDVB9ExH9sEkGa5DR2E0eLxgf3lLUc805Bjd
         0OqlvEhyMKwNjhEGqK+ufiVNcHCKXqtpggeP9fjmskhNQrTXK2sP6t6pHp8jBtpyYE/P
         IcmAutntMLdefzaZP7p7OfP6NaeVmlN1eTyuLJHPjrZ8BMOvhXdQzPuHlmDtjF+XGMR6
         WrL30UWo2kaKV9wm/Dyz9Vod/LUk08QOmXuvETyrDyeDKiHSos+mvty2KaSHYu3hwN/B
         uxfw==
X-Gm-Message-State: AKS2vOw1wGDoj7U/ZLpsjTXjsZ3YowdZzeWB67m8s+xPV3PhVoV803xr
        UiJTjfsEDxMhgO2PUdFwdmm2Az3Faa51Ank=
X-Received: by 10.31.2.209 with SMTP id 200mr2330472vkc.65.1498565763648; Tue,
 27 Jun 2017 05:16:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.13 with HTTP; Tue, 27 Jun 2017 05:15:43 -0700 (PDT)
From:   Michael Kebe <michael.kebe@gmail.com>
Date:   Tue, 27 Jun 2017 14:15:43 +0200
Message-ID: <CAKKM46uJLu+w-UUFZc1HRar3apAD6Db2KD+GjiNL5v+Q2Ni7hA@mail.gmail.com>
Subject: Solaris 11.3 SPARC grep problem with t1450-fsck.sh
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running the test suite on Solaris 11.3 SPARC fails on a test in t1450-fsck.=
sh.

not ok 60 - fsck --name-objects
#
#               rm -rf name-objects &&
#               git init name-objects &&
#               (
#                       cd name-objects &&
#                       test_commit julius caesar.t &&
#                       test_commit augustus &&
#                       test_commit caesar &&
#                       remove_object $(git rev-parse julius:caesar.t) &&
#                       test_must_fail git fsck --name-objects >out &&
#                       tree=3D$(git rev-parse --verify julius:) &&
#                       grep "$tree (\(refs/heads/master\|HEAD\)@{[0-9]*}:"=
 out
#               )

Solaris has /usr/bin/grep and /usr/bin/ggrep. grep is a solaris
version and ggrep is the GNU grep.

Replacing grep with ggrep in t1450-fsck.sh script the fixes the problem.

I chatted with =C3=86var and he thinks that the problem is that configure
finds the right grep but it is not properly passed to the tests.


Furthermore I discovered that some tests in t3900-i18n-commit.sh are failin=
g.

e.g.: not ok 17 - ISO-2022-JP should be shown in UTF-8 now

But that's another topic, which I will open once this is fixed.

Greetings
Michael
