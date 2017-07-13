Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2B520357
	for <e@80x24.org>; Thu, 13 Jul 2017 06:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbdGMGvF (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 02:51:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33895 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdGMGvD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 02:51:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id p204so3071499wmg.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G3E20SLNL5+4lVH5/9bMlgg1LRU87OT3U9dlQ1LhEfM=;
        b=IxdyjX8rctBdrVykWiFGoO4potvB0x44EdvfSU/cO3noh5EYQfsqn0xbCn7GZ3MR3f
         RSjfNJimW1FlQRXetoyUEabtdglSKmOTYaQlUilNhn3hFtHUdyfYwq+H2v7wQSHndOJ1
         y/thaBGFz763YLJVHW/zg1NJuveVBPMVi0AYbMrgRHhHlDmRdnJIhfg0RFnpYXf0PsiF
         Iq4aN6Ve/The7a88cghfrPwijBwOG8y3KEZQ4b1Lf+rxy+Yy4PaZNtSIV0gNn90D35jx
         OxxJu8KtWEL7uBbd83I8bDUwECW6tMDfySWYh4UA+vL0W8+C+GSElmdqV3jcEF9ux0r6
         A3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G3E20SLNL5+4lVH5/9bMlgg1LRU87OT3U9dlQ1LhEfM=;
        b=EJYSpWy7OmDg1kZbaW4YzkvNosu7SqfbCAhvhLeE/64NOKVUJ1TV47v15qThPRJr6f
         AMw61qqCRSLgoNhFF6oExFt0mAfW7cSsma/rNkVxJ0lB24Vhce9eZgNfkqOG7gs5R4mF
         8CunRPPoJtiwIBIWKjgcrHYKaZng1M6ADVA3LPbPdj9XnjTJBvcrt55lVAI5bNjjemBC
         hEbURr/E+BELYheZoa5eyDUk28B4CLGQlhNgTjo3noLSS2wTMQ/q8dgRF1Ux1PpzlVq3
         QLw6k8Q08wpFzFBrKKNSXh36e0MeXa18oKJjT7TcZSDTKIO45/CC+5yxPo0MMRRp0M9T
         T7EA==
X-Gm-Message-State: AIVw112cPi044CsaGzgcgvQEvqg0l+M41DC7xthggTpgU7f+HnBhcu5Q
        /+tifUjCO+efa12f
X-Received: by 10.28.47.67 with SMTP id v64mr739185wmv.84.1499928661846;
        Wed, 12 Jul 2017 23:51:01 -0700 (PDT)
Received: from localhost.localdomain (43.40.120.78.rev.sfr.net. [78.120.40.43])
        by smtp.gmail.com with ESMTPSA id l20sm3332564wre.25.2017.07.12.23.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 23:51:00 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 0/4] Teach 'run' perf script to read config files
Date:   Thu, 13 Jul 2017 08:50:46 +0200
Message-Id: <20170713065050.19215-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.2.647.g8b2efe2a0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal
~~~~

Using many long environment variables to give parameters to the 'run'
script is error prone and tiring.

We want to make it possible to store the parameters to the 'run'
script in a config file. This will make it easier to store, reuse,
share and compare parameters.

In the future it could also make it easy to run series of tests. 

Design
~~~~~~

We use the same config format as the ".git/config" file as Git users
and developers are familiar with this nice format and have great tools
to change, query and manage it.

We use values from the config file to set the environment variables
that are used by the scripts if they are not already set.

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Patch 1/4 teaches the '--config <configfile>' option to the 'run'
script, but <configfile> is just put into the GIT_PERF_CONFIG_FILE
variable which is not used yet.

Patch 2/4 add the get_var_from_env_or_config() function to read config
options from the <configfile> and set values to some variables from
these config options or from default values.

Patch 3/4 and 4/4 use the get_var_from_env_or_config() function to
make it possible to set parameters used by the 'run' script.  

Future work
~~~~~~~~~~~

We want to make it possible to run series of tests by passing only a
config file to the 'run' script.

For example a config file like the following could be used to run perf
tests with Git compiled both with and without libpcre:

[perf]
        dirsOrRevs = v2.12.0 v2.13.0
        repeatCount = 10
[perf "with libpcre"]
        makeOpts = DEVELOPER=1 CFLAGS='-g -O0' USE_LIBPCRE=YesPlease
[perf "without libpcre"]
        makeOpts = DEVELOPER=1 CFLAGS='-g -O0'

This will make it easy to see what changes between the different runs.

But this can be added later, and the current series can already be
useful as is.

Links
~~~~~

This patch series is also available here:

  https://github.com/chriscool/git/commits/perf-conf


Christian Couder (4):
  perf/run: add '--config' option to the 'run' script
  perf/run: add get_var_from_env_or_config()
  perf/run: add GIT_PERF_DIRS_OR_REVS
  perf/run: add calls to get_var_from_env_or_config()

 t/perf/perf-lib.sh |  3 ---
 t/perf/run         | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.13.2.647.g8b2efe2a0f

