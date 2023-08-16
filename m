Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC140C04E69
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 14:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbjHPO0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 10:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343586AbjHPOZw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 10:25:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D722711
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 07:25:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso10317277e87.2
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692195949; x=1692800749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMG0Z7X35pOkRrRF6yT2UFcirQktHqrUje7jHxgM3QQ=;
        b=a+jaflxGUhdni2wg2q/ote62Cx103zlw6hhdWmDGkp4EY7QkeiJn7b+DIJS5gMMSse
         r0dyevqIK+qhI1CVxlAJI8/fV8choa6ZHG93/9n0xeXeymN0EtlxzltgRRXo6mHYrXwg
         6l8VQIJh9l7p0nOiqL2jr8EjC3lkzFcS5CiqIPqbky0UL7QyFeUib3b5PToevBpmgAcO
         6SGTsLspqcdNcH5tqTTuYqnDmk8F6IdoCvfruKTYHS09Vmx3/PiZJ55TgXDC5oCIla0U
         /4+wF4FcCvyidh000YgpqswkpJRUKY2frJtwr4nGpXDGum3z0hz0/SuzDi4u6roXQJhB
         NJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195949; x=1692800749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMG0Z7X35pOkRrRF6yT2UFcirQktHqrUje7jHxgM3QQ=;
        b=drAPZqnaVxzqyOP8DTCZZ+qEG+cdqiT0P3OgGz/2wiO8G+eOFWUgqMQ9Qy2q8+YOB6
         phbe+jJrn6tXRCNw9FEFmplqiO2PssTuikYoOujsYcOQO407BzA73uWa/gTe/EdVBfo2
         yzzaRDKJZW8GuOiM7jmOgLpOiEKsubYQsmEDPw7F/Jrcw1x/82a90DLnEhyLBBgsYxBR
         rdd/22Le4hA2WouVhR41nv55SrIv0HwPqzvjbA6Jvn69Q1EbO8rNPs9biYyA2ng+GBt6
         OPx131EjS9qE/ijWwJRIMyXGkqBSdDqu2bVmAEakpdmqlurLqMx5NlH0UrzdjxwmMVzg
         FDHw==
X-Gm-Message-State: AOJu0YzfeY7xmZcNRKSTS6vvZynq9aZpkDv9DUYlrC3oo7joVucvY6oB
        6u5Bx5mpzRX4yUBzJZFYjfaJQT1ZlqA=
X-Google-Smtp-Source: AGHT+IHXwsT8aQgm0/0aE4d2FGa6h1XK13/FmumnjfhT/wdx5O2LhvFKMo8uYw31cNZwNdtTLGi4qw==
X-Received: by 2002:a05:6512:3d20:b0:4f8:586a:8af6 with SMTP id d32-20020a0565123d2000b004f8586a8af6mr2177636lfv.4.1692195948499;
        Wed, 16 Aug 2023 07:25:48 -0700 (PDT)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id c18-20020a05651221b200b004fe1c9ce61bsm2927925lft.116.2023.08.16.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:25:47 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] some doc fixes on v2.42.0-rc2
Date:   Wed, 16 Aug 2023 16:24:32 +0200
Message-ID: <cover.1692194193.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.42.0.rc2.215.g538df5cf27
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looking into the changes to our documentation from v2.41.0 up to
v2.42.0-rc2, I found some improvements we could make. I've cc'd the
original authors on this cover letter and the respective patches.

I realize we're fairly late in the release cycle. The impact of these
patches is small, which could mean they're "low risk" or "low benefit"
depending on how you want to look at it.

Martin

Martin Ågren (4):
  notes doc: split up run-on sentences
  notes doc: tidy up `--no-stripspace` paragraph
  show-ref doc: fix carets in monospace
  rev-list-options: fix typo in `--stdin` documentation

 Documentation/git-notes.txt        | 15 +++++++--------
 Documentation/git-show-ref.txt     |  4 ++--
 Documentation/rev-list-options.txt |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.42.0.rc2.215.g538df5cf27

