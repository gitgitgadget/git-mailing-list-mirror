Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F161D1FAE5
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755482AbeCSNcL (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:11 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:46723 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755194AbeCSNcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:10 -0400
Received: by mail-wr0-f172.google.com with SMTP id s10so5768865wra.13
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SQJsQi7daaRcyGYNvcRvNElITYUkx+Etbml5wMifsJk=;
        b=KwQQyPAxeIc0ILpXoxkj37hpMYfl+lhUAn6lqqNhzd3DWJYgqoahrjpuq1zmwgh7hi
         H768pI+4G75hkQkfeXT00631SDWR6dvEckOFiQ5xfmKOD5+uHxtZB4LvhwNEIzW8hnZ7
         ZJV8WuzwRayUK/PmppkQyibpip+m7f+FxMsRrHT+pvLrzkqp/n0KxZvEmHth59SgLY8e
         mTEQJ28nYJBVfwnLlY0iJ8FT2lIIJaeWTy4GTYBAnWEaINcgVff5bCZaPjsYTC0az7BM
         wC9441vUdSEgznf5Gnw0EP4uaWNlRmqkmaeTp7stLw4wb3sHqbqL+FgWVEVkC7VvbHx+
         asxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SQJsQi7daaRcyGYNvcRvNElITYUkx+Etbml5wMifsJk=;
        b=BYgJfYL7tuF8FSQBv7OqrQrg7F0H1focMu9+2flRZqxVwDAQOwLy+g+MAtiwn99o8z
         ZaUyxxW8PNkVYzD08rKAThZduh/1v9fFNeeQ0Csi8mJctAA/QpOfEWWlIaTOtzaNe82D
         d+ctYHymyFcnauNbzW2+zheKP7mQ/+sWq1H9up0NXI0sXAuL8Tea/wc1I6ATmNwd3A0M
         OKTq2xH2csbRyMAWbtw8bK3ZTWj2tloEGb1fWPS0D5V/kglY9UL3sRfxJaeVbVRlRNC0
         oDSt+pkJpYB1rlWKBwCHEX5s1dUluSk7os9U2LVC8uJF1q/jfxf2dw3GYM2oMdMzGDgs
         t6Ag==
X-Gm-Message-State: AElRT7F0QEqnPDxMXTwE4NW1mH2W3nKj9LmRht0lr3FX0y+iPJEo2h98
        jBqpS9nk+5ElUKpeZQhHf0g1dXa3
X-Google-Smtp-Source: AG47ELudpOM9egGxQaNyy545/N0zpW9DRfc9SyVdBtA7yYr7sltCmbvv7nw5EhYva6BqxLle5/bo/A==
X-Received: by 10.223.178.163 with SMTP id g32mr9966121wrd.204.1521466328200;
        Mon, 19 Mar 2018 06:32:08 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:07 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 00/36] Promisor remotes and external ODB support
Date:   Mon, 19 Mar 2018 14:31:11 +0100
Message-Id: <20180319133147.15413-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow up from an early patch series at the beginning of the
year that started to integrate the jh/fsck-promisors patch series with
the external odb patch series.

A lot of things are different because the jh/fsck-promisors and
jh/partial-clone have been merged into master since the v1. So the
integration is much more complete now (though not fully complete), and
this integration happens quite early in the patch series.

This integration makes it possible to have many promisor and partial
clone remotes (instead of just one) with possibly different partial
clone filters, though that is not tested yet.

I am not sure that the "external odb" name is still the best, as the
promisor remotes are not quite external. So I am open to suggestions
about a new name.

This patch series does not include the last part of the original
external odb series which was about adding an `--inital-refspec`
option to `git clone`, as this might not be needed anymore and this
current series is long and complex enough.

High level overview of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In general the external odb tests are now numbered 05XX instead of
04XX, so that they don't conflict with promisor objects/partial clone
tests. Also there are a lot of changes since v1, so I don't think an
interdiff would be useful.

  - Patches 1/36 to 12/36:
  
These patches implement the external odb infrastructure as well as the
support for promisor objects and partial clone.

  - Patches 13/36 and 14/36:

These patches move over the promisor objects and partial clone code to
use the external odb mechanism. The result of 13/36 is that instead of
the "extensions.partialclone" config variable, a
"odb.<name>.promisorRemote" config variable is now used. The result of
14/36 is that instead of the "core.partialclonefilter" config
variable, a "odb.<name>.partialclonefilter" config variable is now
used.

  - Patches 15/36 to 36/36:

These patches implement the rest of the external odb mechanism. Patch
36/36 is a documentation patch that explains how this mechanism work,
though this patch needs to be updated.

Future work
~~~~~~~~~~~

  - add tests that show that one can now use more than one promisor remote
  - add fsck, gc and repack tests for script and process modes
  - see if partial clone filters could be used for other modes
  - update documentation patch
  - fix memory leaks
  - take another look at prepare_helper_command() [1]
  - take a look at changing the order of the have object lines [1]
  - take a look at what happens when a server creates a pack [2]
  - add tests with different kinds of external odbs

[1] https://public-inbox.org/git/ebf67bcc-3e17-3fda-9f56-dd152e7bf3af@jeffhostetler.com/
[2] https://public-inbox.org/git/8de3597a-01bd-a721-fffb-20769701d0af@jeffhostetler.com/

Links
~~~~~

This patch series on GitHub:

https://github.com/chriscool/git/commits/gl-small-promisor-external-odb-next

Peff started to work on external odbs some years ago:

http://thread.gmane.org/gmane.comp.version-control.git/206886/focus=207040
http://thread.gmane.org/gmane.comp.version-control.git/247171
http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020

His work, which is not compile-tested any more:

https://github.com/peff/git/commits/jk/external-odb-wip

Initial discussions about external odbs:

http://thread.gmane.org/gmane.comp.version-control.git/288151/focus=295160

Version 1, 2, 3, 4, 5 and 6 of the external odbs series:

https://public-inbox.org/git/20160613085546.11784-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20160628181933.24620-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20161130210420.15982-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170803091926.1755-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170916080731.13925-1-chriscool@tuxfamily.org/

Some of the discussions related to Ben Peart's work that is used by
this series:

https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
https://public-inbox.org/git/20170322165220.5660-1-benpeart@microsoft.com/
https://public-inbox.org/git/20170714132651.170708-1-benpeart@microsoft.com/

Version 1, 2, 3, 4, 5 and 6 of the external odbs series on GitHub:

https://github.com/chriscool/git/commits/gl-external-odb12
https://github.com/chriscool/git/commits/gl-external-odb22
https://github.com/chriscool/git/commits/gl-external-odb61
https://github.com/chriscool/git/commits/gl-external-odb239
https://github.com/chriscool/git/commits/gl-external-odb373
https://github.com/chriscool/git/commits/gl-external-odb411

Version 1 of this "Promisor remotes and external ODB support" series:

https://public-inbox.org/git/20180103163403.11303-1-chriscool@tuxfamily.org/

Version 1 of this "Promisor remotes and external ODB support" series on GitHub:

https://github.com/chriscool/git/commits/gl-small-promisor-external-odb12


Ben Peart (1):
  Add t0550 to test 'get_direct' mechanism

Christian Couder (35):
  Add initial external odb support
  sha1_file: add prepare_external_alt_odb()
  Add GIT_NO_EXTERNAL_ODB env variable
  external-odb: add has_external_odb()
  external-odb: implement external_odb_get_direct
  sha1_file: prepare for external odbs
  odb-helper: add 'enum odb_helper_type'
  external-odb: add external_odb_reinit()
  external-odb: add script mode support
  odb-helper: add 'script_mode' to 'struct odb_helper'
  odb-helper: add odb_helper_init() to send 'init' instruction
  external-odb: add external_odb_get_many_direct()
  Use external_odb_get_direct() and has_external_odb()
  Use odb.origin.partialclonefilter instead of core.partialclonefilter
  external-odb: add 'get_direct' support
  t0500: add 'put_raw_obj' instruction to odb-helper script
  external odb: add 'put_raw_obj' support
  external-odb: accept only blobs for now
  t0500: add test for external odb write support
  Add t0510 to test external ODB transfer
  lib-httpd: pass config file to start_httpd()
  lib-httpd: add upload.sh
  lib-httpd: add list.sh
  lib-httpd: add apache-e-odb.conf
  odb-helper: add odb_helper_get_raw_object()
  pack-objects: don't pack objects in external odbs
  Add t0520 to test transfer to HTTP external odb
  odb-helper: add init_object_process()
  Add t0560 to test passing git objects
  odb-helper: add put_object_process()
  Add t0570 to test passing raw objects
  odb-helper: add have_object_process()
  Add t0580 to test "have" capability and raw objects
  external-odb: use 'odb=magic' attribute to mark odb blobs
  Add Documentation/technical/external-odb.txt

 Documentation/technical/external-odb.txt |  342 +++++++
 Makefile                                 |    2 +
 builtin/cat-file.c                       |    5 +-
 builtin/fetch.c                          |   13 +-
 builtin/gc.c                             |    3 +-
 builtin/pack-objects.c                   |    4 +
 builtin/repack.c                         |    3 +-
 cache.h                                  |   20 +-
 connected.c                              |    3 +-
 environment.c                            |    5 +-
 external-odb.c                           |  250 +++++
 external-odb.h                           |   25 +
 list-objects-filter-options.c            |   46 +-
 list-objects-filter-options.h            |    3 +-
 odb-helper.c                             | 1109 ++++++++++++++++++++++
 odb-helper.h                             |   49 +
 packfile.c                               |    3 +-
 setup.c                                  |    7 +-
 sha1_file.c                              |  120 ++-
 t/lib-httpd.sh                           |    8 +-
 t/lib-httpd/apache-e-odb.conf            |  214 +++++
 t/lib-httpd/list.sh                      |   41 +
 t/lib-httpd/upload.sh                    |   45 +
 t/t0410-partial-clone.sh                 |   30 +-
 t/t0500-external-odb.sh                  |   83 ++
 t/t0510-transfer-e-odb.sh                |  147 +++
 t/t0520-transfer-http-e-odb.sh           |  145 +++
 t/t0550-read-object.sh                   |   28 +
 t/t0550/read-object                      |   68 ++
 t/t0560-read-object-git.sh               |   28 +
 t/t0560/read-object-git                  |   78 ++
 t/t0570-read-object-http-e-odb.sh        |  112 +++
 t/t0570/read-object-plain                |   83 ++
 t/t0580-read-object-have-http-e-odb.sh   |  112 +++
 t/t0580/read-object-plain-have           |  103 ++
 t/t5500-fetch-pack.sh                    |    4 +-
 t/t5601-clone.sh                         |    2 +-
 t/t5616-partial-clone.sh                 |    4 +-
 unpack-trees.c                           |    6 +-
 39 files changed, 3254 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/technical/external-odb.txt
 create mode 100644 external-odb.c
 create mode 100644 external-odb.h
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 t/lib-httpd/apache-e-odb.conf
 create mode 100644 t/lib-httpd/list.sh
 create mode 100644 t/lib-httpd/upload.sh
 create mode 100755 t/t0500-external-odb.sh
 create mode 100755 t/t0510-transfer-e-odb.sh
 create mode 100755 t/t0520-transfer-http-e-odb.sh
 create mode 100755 t/t0550-read-object.sh
 create mode 100755 t/t0550/read-object
 create mode 100755 t/t0560-read-object-git.sh
 create mode 100755 t/t0560/read-object-git
 create mode 100755 t/t0570-read-object-http-e-odb.sh
 create mode 100755 t/t0570/read-object-plain
 create mode 100755 t/t0580-read-object-have-http-e-odb.sh
 create mode 100755 t/t0580/read-object-plain-have

-- 
2.17.0.rc0.37.g8f476fabe9

