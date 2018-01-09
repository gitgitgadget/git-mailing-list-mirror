Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0B061F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755155AbeAISAz (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:00:55 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38903 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeAISAy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:00:54 -0500
Received: by mail-pg0-f65.google.com with SMTP id t67so8486190pgc.5
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 10:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lUl3abjHdBE53A5KAaE2eP1cL/F4n4d41RniqjQsjI4=;
        b=EeYDq9sHfBSs10v9II6J1+XOjSJKmJbkFCNWMaO9YwZinTLnkoUXtCmVr1s9eZtwhl
         GL0mG/3Fc3bbJ7YTnDt14EzCf6pvsmdxPORpuKXYNfLR/bRvmdZyK9ZDLtaTvLDte0b6
         rlIbFH6lzIkS/HQTfYytJl0dzVGv5umloYzQDOX+3HgyV9wIKVEzlqP3K9RZvy/wv3yr
         BYbGq653lbiMMQkiqvAJVStHyZ0dXB48Zr80QxAoWbKXpQobxU+S4CamsOdndKlzE75/
         buqLN+Srn+K2SqRObJQjnd+JlTUBmQaMWSM7I2mcYWsRN6zxEMprE8YQbauy5z9mF+LG
         4Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lUl3abjHdBE53A5KAaE2eP1cL/F4n4d41RniqjQsjI4=;
        b=cPSLcjLypKJlPYIe0XVDQ0BV4n+QWZnslxlYnS9xBzBGfTY/Z78PlOitrRQXKUdxqB
         8k+Z+g8ayTXzotyNHLoRGbdzUHRvx02x1n0O31fOCcIb79apC6feohPPjZSZQT5Sewbo
         9cGqWWLLMlLIk3PboKGLfGcN9dSbKx0X+23E3FZwL6SxBOdseWIpw/m5P9W6TkE6hziM
         LqfAma8JwNdd/sfH3zONW8ce81QV3LXqGpxnKh0I89lhcvHOwR8FFYF1g9iZvLow+02D
         o4j31yIq6Y1AeTy61Fl80YfWNy468r/Hxb7NcQpIWAgEjpB6dh8FrEKZ2zNDDgelCixk
         LskA==
X-Gm-Message-State: AKGB3mKX948D74HRLHPVUO8KacX4yHbtJZOTuuGjVZkdjgQj2sTMpfRR
        uCtQ/Dl1MKtJM34qZcDuTAlUxEZo
X-Google-Smtp-Source: ACJfBovwGcPsMRf50tE47myClOvwTb5T5oieAPZ8+GbLUKBnIXbv3Z6WSK9nch5Aa48BLrv9IGb8MA==
X-Received: by 10.84.235.72 with SMTP id g8mr6225698plt.243.1515520853405;
        Tue, 09 Jan 2018 10:00:53 -0800 (PST)
Received: from localhost.localdomain ([223.176.44.24])
        by smtp.gmail.com with ESMTPSA id z85sm2582446pfk.110.2018.01.09.10.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Jan 2018 10:00:51 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v1 0/2] Incremental rewrite of git-submodules
Date:   Tue,  9 Jan 2018 23:27:01 +0530
Message-Id: <20180109175703.4793-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patches [1] and [2] concerning the porting of submodule
subcommands: sync and deinit were updated in accoudance with
the changes made in one of such similar portings made earlier
for submodule subcommand status[3]. Following are the changes
made:

* It was observed that the number of params increased a lot due to flags
  like quiet, recursive, cached, etc, and keeping in mind the future
  subcommand's ported functions as well, a single unsigned int called
  flags was introduced to store all of these flags, instead of having
  parameter for each one.

* To accomodate the possiblity of a direct call to the functions
  deinit_submodule() and sync_submodule(), callback functions were
  introduced.

As before you can find this series at: 
https://github.com/pratham-pc/git/commits/patch-series-2

And its build report is available at: 
https://travis-ci.org/pratham-pc/git/builds/
Branch: patch-series-2
Build #195

[1]: https://public-inbox.org/git/20170807211900.15001-6-pc44800@gmail.com/
[2]: https://public-inbox.org/git/20170807211900.15001-7-pc44800@gmail.com/
[3]: https://public-inbox.org/git/20171006132415.2876-4-pc44800@gmail.com/

Prathamesh Chavan (2):
  submodule: port submodule subcommand 'sync' from shell to C
  submodule: port submodule subcommand 'deinit' from shell to C

 builtin/submodule--helper.c | 345 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 112 +-------------
 2 files changed, 347 insertions(+), 110 deletions(-)

-- 
2.14.2

