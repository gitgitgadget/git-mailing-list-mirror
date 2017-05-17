Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9792201A7
	for <e@80x24.org>; Wed, 17 May 2017 21:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754395AbdEQVbw (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 17:31:52 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33520 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754383AbdEQVbu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 17:31:50 -0400
Received: by mail-pg0-f43.google.com with SMTP id u187so12843635pgb.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JEb9VzWV8PqYsV401+qtLCkIJvlaaB4J/FfzhMrhDqQ=;
        b=eDJF+hC0UJqX0q8R9qKq3zSvBy6LhD8+VsHIefBTHj73J0/mrql/w3SlJIWDsXPTQ5
         shXKp0+HQAtO3+XyAp/DpRj5omHJNC83JPXYoU8I5WTyKqxLSaRsqAS9nPjTi8Unk3l7
         fq1Y3dNYvXtXVs6DHoAHD9x7JSRAKSarK1qKdshLemXv4L0foEY7GYq0rWtDXU+8hXog
         RPCxP9oUxWyZs6Kxsenhb2hTKhOAZGoV+YOrucVYqK6Q8e/ouHAW66yXs6Ir1A5Uz25w
         V+5+c8lh2xoccbRQbL9Xof1xq6ErGKGR4wAYKmzCy64OTCy1JiLfvh+NGJJc2D+mhbjC
         Sj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JEb9VzWV8PqYsV401+qtLCkIJvlaaB4J/FfzhMrhDqQ=;
        b=CNENGFho4CrtqRRie1MlckqHyK3Xbaf6CfUhXnRXYQbxZHm4PEI5z8qWncjBCIGaPH
         XCcqhbdx0QURydn7JLnHiGCHaNMM6hzRwZFKsLO9NvrMVoRSjtAmPpuR0eMLF4O9cO5D
         Sa2B92X5iSrTiu9CTbJoAfZu3qjctX/kM7tvLmmk6Qe35kjfVa68qs2+bV4xNFFbmapU
         Z6Qm3BRFtO5bd4/H40Xyt8kmtSrnp1VqDc+ZhBHwuBjvyUWJ6cODrbXT2OwSyC1b01OR
         FymcpEgrBY+e0p/R1TgHBWoqIfFh7GV5HXCMKqGL3h+CnbKAPSjaQ1uTV7mxW/0nR+W/
         6oTg==
X-Gm-Message-State: AODbwcAbCZbHwO9T+IIGRfAfWaq/sFiWop460CegXlreVRU+fyLUJC48
        4tmIGKvJohSv/9+K
X-Received: by 10.98.66.214 with SMTP id h83mr854253pfd.182.1495056704726;
        Wed, 17 May 2017 14:31:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:f5dc:a4cd:fb33:e862])
        by smtp.gmail.com with ESMTPSA id d3sm5386331pfb.110.2017.05.17.14.31.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 14:31:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] Add option to recurse into submodules 
Date:   Wed, 17 May 2017 14:31:32 -0700
Message-Id: <20170517213135.20988-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a submodule heavy workflow it becomes tedious to pass in
--recurse-submodules all the time, so make an option for it.

Thanks,
Stefan

Stefan Beller (3):
  submodule.c: add has_submodules to check if we have any submodules
  submodule test invocation: only pass additional arguments
  Introduce submodule.recurse option

 Documentation/config.txt       |  5 +++
 builtin/checkout.c             |  8 ++--
 builtin/fetch.c                |  2 +-
 builtin/read-tree.c            |  2 +-
 builtin/reset.c                |  2 +-
 builtin/submodule--helper.c    |  6 +--
 submodule.c                    | 83 ++++++++++++++++++++++++++++++++++--------
 submodule.h                    |  8 +++-
 t/lib-submodule-update.sh      | 18 ++++++++-
 t/t1013-read-tree-submodule.sh |  4 +-
 t/t2013-checkout-submodule.sh  |  4 +-
 t/t5526-fetch-submodules.sh    | 10 +++++
 t/t7112-reset-submodule.sh     |  4 +-
 unpack-trees.c                 |  2 +-
 14 files changed, 121 insertions(+), 37 deletions(-)

-- 
2.13.0.18.g7d86cc8ba0

