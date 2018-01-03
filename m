Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A7D21F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbeACQe0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:34:26 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:41221 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeACQeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:16 -0500
Received: by mail-wr0-f174.google.com with SMTP id p69so2140353wrb.8
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8riQuOLqTe7mFPdbysQijnGoj54FGliwjIN87djjaiM=;
        b=NWBFLmixcJ3X8ufAxk48cXmUblmriqJxs2ARrbkHPbLrbmGhL5xKREkvy2Luw//BIH
         FkRn67a+SSynCKteezdMpfZzQgdi5CpQGKIRmtkWPbWr0R/iJ1+ydcqWmabiumAaC270
         YdR1bpiP0qKaW8WVqxM1PfKmhdvhwv0atVg4jP3MJbqaHz+h70wk5FieGQ3CQVianpWp
         zHpwK7PffVWmySmClK2zVRD5CsH70CxRI9QA0R9+S3SeKRfDp6qA778Wt7L8QcOuhzGs
         /W5PNrtPdVBBmm6HFMHH6PsP9PjlinFxRVVH80CoIPVkmZy8YT//RD3I6rvutCXdPKLi
         uRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8riQuOLqTe7mFPdbysQijnGoj54FGliwjIN87djjaiM=;
        b=dGSM+gMO5E8ooL/f/T0Dgp8yTlW0Wwlv+vnkwHYWK/2fdrrv+seCZaq9ed3FCBrP4b
         880pXXCDblwZErs4dZp0OylXsXObtKKwi1d9WHIJpv3t4Bwc7/5u7ef5NkmbYb/On0J7
         SUu25HR8zv4sOYcwC7xZxcIjzQ43H/OEsw1cffoq792myErEmTI6BezmyBaV8vVqVxYC
         F5Nhgbg3S88gQ6i8jd17fuBhnchURrIlCkg7Gl7+Oq8xcOReRehY9iaRxG3GHNw/qw29
         W/BPOnwl3GMsnHLYhFpwW0LrznjNgVhFCp7gEBLJx4mynR08mive0z0RWLk4xcsV/aBu
         NxmA==
X-Gm-Message-State: AKGB3mKpsqvI8p4Tuf85sOhNmo6wpDtB9uywjmoSR5MJUA4z5yxG1Vxc
        zw1ZtEyHMKjbDprcABMkV3mSfDby
X-Google-Smtp-Source: ACJfBovHH1kAvYLPHM2OgAIpjiSbQ78OFWlCiVWkWswyuHiISVM28mW3Op8UEs8Go28U13Mc6onm1g==
X-Received: by 10.223.200.8 with SMTP id d8mr1898727wrh.190.1514997254868;
        Wed, 03 Jan 2018 08:34:14 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:14 -0800 (PST)
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
Subject: [PATCH 00/40] Promisor remotes and external ODB support
Date:   Wed,  3 Jan 2018 17:33:23 +0100
Message-Id: <20180103163403.11303-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an early patch series that start to merge the
jh/fsck-promisors patch series (which is currently in pu) with the
external odb patch series.

The merge is not complete and there is still work needed, but all the
tests pass and in my opinion this shows that it is a good way forward
to share the same mechanism to handle (many) remote object stores and
the related fsck and gc problems.

The jh/partial-clone (a separate patch series on top of
jh/fsck-promisors) still needs some work before it can be used on top
of this series. I rebased it on top but the tests do not pass yet. The
result of my rebase and current attempt to fix tests is here:

https://github.com/chriscool/git/commits/gl-partial-clone-rebased

This patch series does not include the last part of the previous
external odb series which was about adding an `--inital-refspec`
option to `git clone`.

A few promisor related links
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

v6 partial clone part 2:
https://public-inbox.org/git/20171205165854.64979-1-git@jeffhostetler.com/

v7 partial clone part 3:
https://public-inbox.org/git/20171208155851.855-1-git@jeffhostetler.com/

External odb related links
~~~~~~~~~~~~~~~~~~~~~~~~~~

Peff started to work on external odbs some years ago:

http://thread.gmane.org/gmane.comp.version-control.git/206886/focus=207040
http://thread.gmane.org/gmane.comp.version-control.git/247171
http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020

His work, which is not compile-tested any more, is still there:

https://github.com/peff/git/commits/jk/external-odb-wip

Initial discussions about external odbs are there:

http://thread.gmane.org/gmane.comp.version-control.git/288151/focus=295160

Version 1, 2, 3, 4, 5 and 6 of the external odbs series are here:

https://public-inbox.org/git/20160613085546.11784-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20160628181933.24620-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20161130210420.15982-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170803091926.1755-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170916080731.13925-1-chriscool@tuxfamily.org/

Some of the discussions related to Ben Peart's work that is used by
this series are here:

https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
https://public-inbox.org/git/20170322165220.5660-1-benpeart@microsoft.com/
https://public-inbox.org/git/20170714132651.170708-1-benpeart@microsoft.com/

Version 1, 2, 3, 4, 5 and 6 of the external odbs series are here:

https://github.com/chriscool/git/commits/gl-external-odb12
https://github.com/chriscool/git/commits/gl-external-odb22
https://github.com/chriscool/git/commits/gl-external-odb61
https://github.com/chriscool/git/commits/gl-external-odb239
https://github.com/chriscool/git/commits/gl-external-odb373
https://github.com/chriscool/git/commits/gl-external-odb411

A patch series to add Git/Packet.pm that is now in master is also
related:

https://public-inbox.org/git/20171019123030.17338-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20171105213836.11717-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20171110132200.7871-1-chriscool@tuxfamily.org/


https://public-inbox.org/git/20171019123030.17338-1-chriscool@tuxfamily.org/

Ben Peart (1):
  Add t0450 to test 'get_direct' mechanism

Christian Couder (30):
  Add initial external odb support
  Add GIT_NO_EXTERNAL_ODB env variable
  external-odb: add has_external_odb()
  external-odb: implement external_odb_get_direct
  sha1_file: prepare for external odbs
  external-odb: add script mode support
  odb-helper: add 'enum odb_helper_type'
  odb-helper: add odb_helper_init() to send 'init' instruction
  t0400: add 'put_raw_obj' instruction to odb-helper script
  external odb: add 'put_raw_obj' support
  external-odb: accept only blobs for now
  t0400: add test for external odb write support
  Add t0410 to test external ODB transfer
  lib-httpd: pass config file to start_httpd()
  lib-httpd: add upload.sh
  lib-httpd: add list.sh
  lib-httpd: add apache-e-odb.conf
  odb-helper: add odb_helper_get_raw_object()
  pack-objects: don't pack objects in external odbs
  Add t0420 to test transfer to HTTP external odb
  external-odb: add 'get_direct' support
  odb-helper: add 'script_mode' to 'struct odb_helper'
  odb-helper: add init_object_process()
  Add t0460 to test passing git objects
  odb-helper: add put_object_process()
  Add t0470 to test passing raw objects
  odb-helper: add have_object_process()
  Add t0480 to test "have" capability and raw objects
  external-odb: use 'odb=magic' attribute to mark odb blobs
  Add Documentation/technical/external-odb.txt

Jonathan Tan (9):
  fsck: introduce promisor objects
  fsck: support refs pointing to promisor objects
  fsck: support referenced promisor objects
  fsck: support promisor objects as CLI argument
  index-pack: refactor writing of .keep files
  introduce fetch-object: fetch one promisor object
  sha1_file: support lazily fetching missing objects
  rev-list: support termination at promisor objects
  gc: do not repack promisor packfiles

 Documentation/git-pack-objects.txt       |   11 +
 Documentation/gitremote-helpers.txt      |    7 +
 Documentation/rev-list-options.txt       |   11 +
 Documentation/technical/external-odb.txt |  342 ++++++++++
 Makefile                                 |    3 +
 builtin/cat-file.c                       |    3 +
 builtin/fetch-pack.c                     |   10 +
 builtin/fsck.c                           |   26 +-
 builtin/gc.c                             |    4 +
 builtin/index-pack.c                     |  111 +--
 builtin/pack-objects.c                   |   41 +-
 builtin/prune.c                          |    7 +
 builtin/repack.c                         |    9 +-
 builtin/rev-list.c                       |   69 +-
 cache.h                                  |   29 +-
 environment.c                            |    4 +
 external-odb.c                           |  204 ++++++
 external-odb.h                           |   13 +
 fetch-object.c                           |   31 +
 fetch-object.h                           |    6 +
 fetch-pack.c                             |   48 +-
 fetch-pack.h                             |    8 +
 list-objects.c                           |   29 +-
 object.c                                 |    2 +-
 odb-helper.c                             | 1079 ++++++++++++++++++++++++++++++
 odb-helper.h                             |   53 ++
 packfile.c                               |   78 ++-
 packfile.h                               |   13 +
 remote-curl.c                            |   14 +-
 revision.c                               |   33 +-
 revision.h                               |    5 +-
 sha1_file.c                              |  139 +++-
 t/lib-httpd.sh                           |    8 +-
 t/lib-httpd/apache-e-odb.conf            |  214 ++++++
 t/lib-httpd/list.sh                      |   41 ++
 t/lib-httpd/upload.sh                    |   45 ++
 t/t0400-external-odb.sh                  |   83 +++
 t/t0410-partial-clone.sh                 |  343 ++++++++++
 t/t0410-transfer-e-odb.sh                |  147 ++++
 t/t0420-transfer-http-e-odb.sh           |  145 ++++
 t/t0450-read-object.sh                   |   28 +
 t/t0450/read-object                      |   68 ++
 t/t0460-read-object-git.sh               |   28 +
 t/t0460/read-object-git                  |   78 +++
 t/t0470-read-object-http-e-odb.sh        |  112 ++++
 t/t0470/read-object-plain                |   83 +++
 t/t0480-read-object-have-http-e-odb.sh   |  112 ++++
 t/t0480/read-object-plain-have           |  103 +++
 transport.c                              |    8 +
 transport.h                              |   11 +
 50 files changed, 3978 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/technical/external-odb.txt
 create mode 100644 external-odb.c
 create mode 100644 external-odb.h
 create mode 100644 fetch-object.c
 create mode 100644 fetch-object.h
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 t/lib-httpd/apache-e-odb.conf
 create mode 100644 t/lib-httpd/list.sh
 create mode 100644 t/lib-httpd/upload.sh
 create mode 100755 t/t0400-external-odb.sh
 create mode 100755 t/t0410-partial-clone.sh
 create mode 100755 t/t0410-transfer-e-odb.sh
 create mode 100755 t/t0420-transfer-http-e-odb.sh
 create mode 100755 t/t0450-read-object.sh
 create mode 100755 t/t0450/read-object
 create mode 100755 t/t0460-read-object-git.sh
 create mode 100755 t/t0460/read-object-git
 create mode 100755 t/t0470-read-object-http-e-odb.sh
 create mode 100755 t/t0470/read-object-plain
 create mode 100755 t/t0480-read-object-have-http-e-odb.sh
 create mode 100755 t/t0480/read-object-plain-have

-- 
2.16.0.rc0.16.g82191dbc6c.dirty

