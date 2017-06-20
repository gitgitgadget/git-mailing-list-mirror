Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 709F020D0C
	for <e@80x24.org>; Tue, 20 Jun 2017 07:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbdFTHzw (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:55:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34231 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdFTHzv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:55:51 -0400
Received: by mail-wr0-f194.google.com with SMTP id y25so14131514wrd.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OLCa4aSIwnWe05wcH5+RZogBig8VQhaVMqm9LcgeNCE=;
        b=BPjtMuLYVUTQOqi3BtIyIgs/nQZ7K8z4g25SUdZBL+pcJjwFFgqNNjh3tV2n3oSp8m
         BRituzbGLF3B3oXcAhdJPgpZrStg6JH1IPh+jGpoUvwiWa7CVarTGbkITC61RYzCA5zC
         ZS50gmJL3PJdL7kcQiyEsiPviy1ziJt3PdHNju+fG9BUA6XE/6uKzgPEFwb4fYSLj3DJ
         ot28vbhWmhbtCd+IFFFn+/eWDljlwizKCiz8YS8x5BP41j5y0uUqpgD+IFqSiCOjKKjl
         7maN8hAv9CYUQ+HXpnyLyYvfjHmC0MnG9+1Rdf2kHVktYVDweWDuEySJI8b8DzSCxzsE
         jIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OLCa4aSIwnWe05wcH5+RZogBig8VQhaVMqm9LcgeNCE=;
        b=BTARLQrDSrRx4xiSWBdC2UbWLI89LwTpeGZTrB+GIcZwB/KHXm3g/GEnQ4UFxuhWsf
         rwP0NqMcJ3kb4g0JCo+d5uryG3wNpgkJf7nDDPtTzWy30WhI5qs53XXM+KJVB28A42wN
         9T4w59Ey2JurT+Hh+0Fe0VmLGEx4Fc9Bu54cmWuBCByNwkUEqoh2Low7JQ+PL4IRy60v
         VTPv+CYV/WDVlYBHVXz/UmZJw4fhu7l4oTffWGTUJDN9yOnaD1ZDZqpO/JtG11tvMVIe
         UaSsX+iDyTzOAFUcf2PXjbWvS/m0dGrOc5nQ5BDscefBceUpdIdjVVBcwDwQimRMe5Mt
         Tv+w==
X-Gm-Message-State: AKS2vOyOjgnHFpSiIasI3At7AkQV6ylMou6kypfPQwRIk46D6XQhtNiM
        l5NzDbvwkLWmVkAO
X-Received: by 10.223.168.82 with SMTP id l76mr8144596wrc.37.1497945349013;
        Tue, 20 Jun 2017 00:55:49 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:55:48 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 00/49] Add initial experimental external ODB support
Date:   Tue, 20 Jun 2017 09:54:34 +0200
Message-Id: <20170620075523.26961-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal
~~~~

Git can store its objects only in the form of loose objects in
separate files or packed objects in a pack file.

To be able to better handle some kind of objects, for example big
blobs, it would be nice if Git could store its objects in other object
databases (ODB).

To do that, this patch series makes it possible to register commands,
also called "helpers", using "odb.<odbname>.command" config variables,
to access external ODBs where objects can be stored and retrieved.

External ODBs should be able to tranfer information about the blobs
they store. This patch series shows how this is possible using kind of
replace refs.

Design
~~~~~~

* The "helpers" (registered commands)

Each helper manages access to one external ODB.

There are now 2 different modes for helper:

  - When "odb.<odbname>.scriptMode" is set to "true", the helper is
    launched each time Git wants to communicate with the <odbname>
    external ODB.

  - When "odb.<odbname>.scriptMode" is not set or set to "false", then
    the helper is launched once as a sub-process (using
    sub-process.h), and Git communicates with it using packet lines.

A helper can be given different instructions by Git. The instructions
that are supported are negociated at the beginning of the
communication using a capability mechanism.

For now the following instructions are supported: 

  - "have": the helper should respond with the sha1, size and type of
    all the objects the external ODB contains, one object per line.

  - "get <sha1>": the helper should then read from the external ODB
    the content of the object corresponding to <sha1> and pass it to Git.

  - "put <sha1> <size> <type>": the helper should then read from from
    Git an object and store it in the external ODB.

Currently "have" and "put" are optional.

There are 3 different kinds of "get" instructions depending on how the
helper passes objects to Git:

  - "fault_in": the helper will write the requested objects directly
    into the regular Git object database, and then Git will retry
    reading it from there.

  - "git_object": the helper will send the object as a Git object.

  - "plain_object": the helper will send the object (a blob) as a raw
    object. (The blob content will be sent as is.)

For now the kind of "get" that is supported is read from the
"odb.<odbname>.fetchKind" configuration variable, but in the future it
should be decided as part of the capability negociation.

* Transfering information

To tranfer information about the blobs stored in external ODB, some
special refs, called "odb ref", similar as replace refs, are used in
the tests of this series, but in general nothing forces the helper to
use that mechanism.

The external odb helper is responsible for using and creating the refs
in refs/odbs/<odbname>/, if it wants to do that. It is free for example
to just create one ref, as it is also free to create many refs. Git
would just transmit the refs that have been created by this helper, if
Git is asked to do so.

For now in the tests there is one odb ref per blob, as it is simple
and as it is similar to what git-lfs does. Each ref name is
refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob stored
in the external odb named <odbname>.

These odb refs point to a blob that is stored in the Git
repository and contain information about the blob stored in the
external odb. This information can be specific to the external odb.
The repos can then share this information using commands like:

`git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`

At the end of the current patch series, "git clone" is teached a
"--initial-refspec" option, that asks it to first fetch some specified
refs. This is used in the tests to fetch the odb refs first.

This way only one "git clone" command can setup a repo using the
external ODB mechanism as long as the right helper is installed on the
machine and as long as the following options are used:

  - "--initial-refspec <odbrefspec>" to fetch the odb refspec
  - "-c odb.<odbname>.command=<helper>" to configure the helper

There is also a test script that shows that the "--initial-refspec"
option along with the external ODB mechanism can be used to implement
cloning using bundles.

* External object database

This RFC patch series shows in the tests:

  - how to use another git repository as an external ODB (storing Git objects)
  - how to use an http server as an external ODB (storing plain objects)

(This works in both script mode and sub-process mode.)

* Performance

So the sub-process mode, which is now the default, has been
implemented in this new version of this patch series.

This has been implemented using the refactoring that Ben Peart did on
top of Lars Schneider's work on using sub-processes and packet lines
in the smudge/clean filters for git-lfs. This also uses further work
from Ben Peart called "read object process".

See:

http://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
http://public-inbox.org/git/20170322165220.5660-1-benpeart@microsoft.com/

Thanks to this, the external ODB mechanism should in the end perform
as well as the git-lfs mechanism when many objects should be
transfered.

Implementation
~~~~~~~~~~~~~~

* Mechanism to call the registered commands

This series adds a set of function in external-odb.{c,h} that are
called by the rest of Git to manage all the external ODBs.

These functions use 'struct odb_helper' and its associated functions
defined in odb-helper.{c,h} to talk to the different external ODBs by
launching the configured "odb.<odbname>.command" commands and writing
to or reading from them.

* ODB refs

For now odb ref management is only implemented in a helper in t0410.

When a new blob is added to an external odb, its sha1, size and type
are writen in another new blob and the odb ref is created.

When the list of existing blobs is requested from the external odb,
the content of the blobs pointed to by the odb refs can also be used
by the odb to claim that it can get the objects.

When a blob is actually requested from the external odb, it can use
the content stored in the blobs pointed to by the odb refs to get the
actual blobs and then pass them.

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    - Patch 1/49 is a small code cleanup that I already sent to the
      mailing list but will probably be removed in the end bdue to
      ongoing work on "git clone"

    - Patches 02/49 to 08/49 create a Git/Packet.pm module by
      refactoring "t0021/rot13-filter.pl". Functions from this new
      module will be used later in test scripts.

    - Patches 09/49 to 16/49 create the external ODB insfrastructure
      in external-odb.{c,h} and odb-helper.{c,h} for the script mode.

    - Patches 17/49 to 23/49 improve lib-http to make it possible to
      use it as an external ODB to test storing blobs in an HTTP
      server.

    - Patches 24/49 to 44/49 improve the external ODB insfrastructure
      to support sub-processes and make everything work using them.

    - Patches 45/49 to 49/49 add the --initial-refspec to git clone
      along with tests.

Future work
~~~~~~~~~~~

First sorry about the state of this patch series, it is not as clean
as I would have liked, butI think it is interesting to get feedback
from the mailing list at this point, because the previous RFC was sent
a long time ago and a lot of things changed.

So a big part of the future work will be about cleaning this patch series.

Other things I think I am going to do:

  -   

Previous work and discussions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(Sorry for the old Gmane links, I will try to replace them with
public-inbox.org at one point.)

Peff started to work on this and discuss this some years ago:

http://thread.gmane.org/gmane.comp.version-control.git/206886/focus=207040
http://thread.gmane.org/gmane.comp.version-control.git/247171
http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020

His work, which is not compile-tested any more, is still there:

https://github.com/peff/git/commits/jk/external-odb-wip

Initial discussions about this new series are there:

http://thread.gmane.org/gmane.comp.version-control.git/288151/focus=295160

Version 1, 2 and 3 of this RFC/PATCH series are here:

https://public-inbox.org/git/20160613085546.11784-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20160628181933.24620-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20161130210420.15982-1-chriscool@tuxfamily.org/

Some of the discussions related to Ben Peart's work that is used by
this series are here:

http://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
http://public-inbox.org/git/20170322165220.5660-1-benpeart@microsoft.com/

Links
~~~~~

This patch series is available here:

https://github.com/chriscool/git/commits/external-odb

Version 1, 2 and 3 are here:

https://github.com/chriscool/git/commits/gl-external-odb12
https://github.com/chriscool/git/commits/gl-external-odb22
https://github.com/chriscool/git/commits/gl-external-odb61


Ben Peart (4):
  Documentation: add read-object-protocol.txt
  contrib: add long-running-read-object/example.pl
  Add t0410 to test read object mechanism
  odb-helper: add read_object_process()

Christian Couder (43):
  builtin/clone: get rid of 'value' strbuf
  t0021/rot13-filter: refactor packet reading functions
  t0021/rot13-filter: improve 'if .. elsif .. else' style
  Add Git/Packet.pm from parts of t0021/rot13-filter.pl
  t0021/rot13-filter: use Git/Packet.pm
  Git/Packet.pm: improve error message
  Git/Packet.pm: add packet_initialize()
  Git/Packet: add capability functions
  t0400: add 'put' command to odb-helper script
  external odb: add write support
  external-odb: accept only blobs for now
  t0400: add test for external odb write support
  Add GIT_NO_EXTERNAL_ODB env variable
  Add t0410 to test external ODB transfer
  lib-httpd: pass config file to start_httpd()
  lib-httpd: add upload.sh
  lib-httpd: add list.sh
  lib-httpd: add apache-e-odb.conf
  odb-helper: add 'store_plain_objects' to 'struct odb_helper'
  pack-objects: don't pack objects in external odbs
  t0420: add test with HTTP external odb
  odb-helper: start fault in implementation
  external-odb: add external_odb_fault_in_object()
  odb-helper: add script_mode
  external-odb: add external_odb_get_capabilities()
  t04*: add 'get_cap' support to helpers
  odb-helper: call odb_helper_lookup() with 'have' capability
  odb-helper: fix odb_helper_fetch_object() for read_object
  Add t0460 to test passing git objects
  odb-helper: add read_packetized_git_object_to_fd()
  odb-helper: add read_packetized_plain_object_to_fd()
  Add t0470 to test passing plain objects
  odb-helper: add write_object_process()
  Add t0480 to test "have" capability and plain objects
  external-odb: add external_odb_do_fetch_object()
  odb-helper: advertise 'have' capability
  odb-helper: advertise 'put' capability
  odb-helper: add have_object_process()
  clone: add initial param to write_remote_refs()
  clone: add --initial-refspec option
  clone: disable external odb before initial clone
  Add test for 'clone --initial-refspec'
  t: add t0430 to test cloning using bundles

Jeff King (2):
  Add initial external odb support
  external odb foreach

 Documentation/technical/read-object-protocol.txt | 102 +++
 Makefile                                         |   2 +
 builtin/clone.c                                  |  91 ++-
 builtin/pack-objects.c                           |   4 +
 cache.h                                          |  18 +
 contrib/long-running-read-object/example.pl      | 114 +++
 environment.c                                    |   4 +
 external-odb.c                                   | 220 +++++
 external-odb.h                                   |  17 +
 odb-helper.c                                     | 987 +++++++++++++++++++++++
 odb-helper.h                                     |  47 ++
 perl/Git/Packet.pm                               | 118 +++
 sha1_file.c                                      | 117 ++-
 t/lib-httpd.sh                                   |   8 +-
 t/lib-httpd/apache-e-odb.conf                    | 214 +++++
 t/lib-httpd/list.sh                              |  41 +
 t/lib-httpd/upload.sh                            |  45 ++
 t/t0021/rot13-filter.pl                          |  97 +--
 t/t0400-external-odb.sh                          |  85 ++
 t/t0410-transfer-e-odb.sh                        | 148 ++++
 t/t0420-transfer-http-e-odb.sh                   | 159 ++++
 t/t0430-clone-bundle-e-odb.sh                    |  91 +++
 t/t0450-read-object.sh                           |  30 +
 t/t0450/read-object                              |  56 ++
 t/t0460-read-object-git.sh                       |  29 +
 t/t0460/read-object-git                          |  67 ++
 t/t0470-read-object-http-e-odb.sh                | 123 +++
 t/t0470/read-object-plain                        |  93 +++
 t/t0480-read-object-have-http-e-odb.sh           | 123 +++
 t/t0480/read-object-plain-have                   | 116 +++
 t/t5616-clone-initial-refspec.sh                 |  48 ++
 31 files changed, 3296 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/technical/read-object-protocol.txt
 create mode 100644 contrib/long-running-read-object/example.pl
 create mode 100644 external-odb.c
 create mode 100644 external-odb.h
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 perl/Git/Packet.pm
 create mode 100644 t/lib-httpd/apache-e-odb.conf
 create mode 100644 t/lib-httpd/list.sh
 create mode 100644 t/lib-httpd/upload.sh
 create mode 100755 t/t0400-external-odb.sh
 create mode 100755 t/t0410-transfer-e-odb.sh
 create mode 100755 t/t0420-transfer-http-e-odb.sh
 create mode 100755 t/t0430-clone-bundle-e-odb.sh
 create mode 100755 t/t0450-read-object.sh
 create mode 100755 t/t0450/read-object
 create mode 100755 t/t0460-read-object-git.sh
 create mode 100755 t/t0460/read-object-git
 create mode 100755 t/t0470-read-object-http-e-odb.sh
 create mode 100755 t/t0470/read-object-plain
 create mode 100755 t/t0480-read-object-have-http-e-odb.sh
 create mode 100755 t/t0480/read-object-plain-have
 create mode 100755 t/t5616-clone-initial-refspec.sh

-- 
2.13.1.565.gbfcd7a9048

