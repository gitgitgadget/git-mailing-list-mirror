Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32984C25B06
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 02:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiHLC5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 22:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiHLC46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 22:56:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC30DA00E8
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 19:56:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o3-20020a17090a0a0300b001f7649cd317so7179758pjo.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=h+mx8RpQ5BSIxCRrcWqn9+Q4/Svl8m65gEkMhTjCfSk=;
        b=IGoj5fB7Cnb7L6YMPUKRH0zL23lH+ipPHnimEe0L+J9DdOmMX7GUjn1WQ03nhJfOwG
         ntYSKqBm2N4c4fvPIvPjX7S19yh7tef+GfZQfIKANjFlJGRZQ5Um47GlwAnMkj7wyNzD
         xI1IDuHw5CRCYvPAdNL+ibvXNB3pbuMOOtiLPdlkSmcstPiFZtiufoay/GosLowNnhnc
         35/RpaRh/9D2uHvglBFY7Ov/uBUYYXswFDEQ5+O0Etd5YYcXE1IpISPfSVX4oOAwnVKV
         U8l972J4waJOluvqNIgbg91d7sxMRf8FgYe139NMtHJ9TOeIbgZe0oF+aGykzmwPdT+J
         /63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=h+mx8RpQ5BSIxCRrcWqn9+Q4/Svl8m65gEkMhTjCfSk=;
        b=o8qMKHqyyxFU0tdjwCZFmtbHfn8ctVpcjBxrPpuhVROS67McxBxuhp9Zm0KL1Noiv8
         do96AwAUyq7kim00oxUdHOmdHbLDmcPJPqQzN/hzpVvER9zQD0r7yfgWpVsBj0VS7SAR
         osY9MhKjxwJlfUJwiy2opKu2pXt0Mn+kUVY3s7nqQYxGaItAzkqYGwvfqRoxSLsWkzFH
         0kBuKbshDwL+Khr+99dUC/8URj4HhHjaEVcIi3FK49fiAEwQ0IsLyJR7VQ7hefUmD3+y
         gf7yqYAz8H9ybaymwSCZw/mPbQ0RbV8ytG3rXifvyJx1cLgXv3yq3TTQAXGVSYHjApvu
         d1+g==
X-Gm-Message-State: ACgBeo0vinixHJtHhKCsXLXNs3hhNiZPh2WIAoJ0V8VcEf+SapXfBPox
        xTCFUqXN7yCs7a6loP/RT88=
X-Google-Smtp-Source: AA6agR4w94JCmSZWaa9dQVlyXcAN+Owu0ZD81TGvvTlTFj+jAIXbDEuCEWn/sciTTW2x+3so74Oqng==
X-Received: by 2002:a17:90b:3d0a:b0:1f4:f03c:5f55 with SMTP id pt10-20020a17090b3d0a00b001f4f03c5f55mr1998840pjb.103.1660273016163;
        Thu, 11 Aug 2022 19:56:56 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902a50100b0016f0c2ea14csm390631plq.275.2022.08.11.19.56.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2022 19:56:55 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v2 0/2] tr2: shows the scope unconditionally with config 
Date:   Fri, 12 Aug 2022 10:56:44 +0800
Message-Id: <cover.1660272404.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <cover.1658472474.git.dyroneteng@gmail.com>
References: <cover.1658472474.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Diff from v1:

* Fix the premature code in [1/2] by Junio's comment in:

  https://public-inbox.org/git/xmqqy1wkc0yw.fsf@gitster.g/

* Optimize the documentaion in [1/2] by Ævar's comment in:

  https://public-inbox.org/git/220722.86fsits91m.gmgdl@evledraar.gmail.com/

I send this patch version a little earlier maybe because some context not fully
discussed or solved, intend to avoid context signal disappearance because it's
been lasted a while now. 

Thanks.

Teng Long (2):
  api-trace2.txt: print config key-value pair
  tr2: shows scope unconditionally in addition to key-value pair

 Documentation/technical/api-trace2.txt | 40 ++++++++++++++++++++++++++
 trace2/tr2_tgt_event.c                 |  3 ++
 trace2/tr2_tgt_normal.c                |  5 +++-
 trace2/tr2_tgt_perf.c                  |  9 ++++--
 4 files changed, 54 insertions(+), 3 deletions(-)

Range-diff against v1:
1:  bebd97c832 ! 1:  84bd8a71d7 api-trace2.txt: print config key-value pair
    @@ Documentation/technical/api-trace2.txt: at offset 508.
      This example also shows that thread names are assigned in a racy manner
      as each thread starts and allocates TLS storage.
      
    -+Print Configs::
    ++Config (def param) Events::
     +
     +	  Dump "interesting" config values to trace2 log.
     ++
    -+The environment variable `GIT_TRACE2_CONFIG_PARAMS` and configuration
    -+`trace2.configparams` can be used to output config values which you care
    -+about(see linkgit:git-config[1). For example:
    ++We can optionally emit configuration events, see
    ++`trace2.configparams` in linkgit:git-config[1] for how to enable
    ++it.
     ++
     +----------------
     +$ git config color.ui auto
2:  2f8fce6599 ! 2:  9856058df6 tr2: shows scope unconditionally in addition to key-value pair
    @@ Documentation/technical/api-trace2.txt: The "exec_id" field is a command-unique
      {
      	"event":"def_param",
      	...
    -+	scope: <a string that 'git config --show-scope' would return>
    ++	"scope":"global",
      	"param":"core.abbrev",
      	"value":"7"
      }
    -@@ Documentation/technical/api-trace2.txt: Print Configs::
    - +
    - The environment variable `GIT_TRACE2_CONFIG_PARAMS` and configuration
    - `trace2.configparams` can be used to output config values which you care
    --about(see linkgit:git-config[1). For example:
    -+about(see linkgit:git-config[1). For example assume that we want to config
    -+different `color.ui` values in multiple scopes, such as:
    +@@ Documentation/technical/api-trace2.txt: We can optionally emit configuration events, see
    + it.
      +
      ----------------
     -$ git config color.ui auto
-- 
2.37.1.1.g8cbb44ffc4.dirty

