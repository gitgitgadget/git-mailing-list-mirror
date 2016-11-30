Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5051FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754403AbcK3VRg (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:17:36 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35272 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbcK3VRf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:17:35 -0500
Received: by mail-wj0-f196.google.com with SMTP id he10so9769182wjc.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 13:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jHrYUVRc5LjV45xjsSE3l8EclasUvnsLOIV1zlfJnOA=;
        b=WawL68gqWcf8sRAwjRA2zJ6kzV8C1kJKiQPdnHB3PfXBWSbAETO6+vgp/0yHbrhiHc
         cUAvdCIcmUUCBCDG5l+5MFv/KQ4hdo6I3D70TN171UYoN+RF1o/N0UH3LVfwE1TF2aCx
         kHSkbhOdEY+0Y8ebM18ABuQG2uKnWvzOtuYVH3/Y1iHHS5Kn9XRFUEsdNygwnEXxm+lX
         rlfp9D4FpGYYR4/PUpPv3mNyuhHp3N1TNe9VnWOC428L7j607NFrsFCiipnMjkkStrku
         KiartIjpv72mQkfo/4mYuZ0YMeOUVdkyY8fQ2VMFxZDo4o6BJ5KYNPJO4vkwn/wZuQWj
         C/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jHrYUVRc5LjV45xjsSE3l8EclasUvnsLOIV1zlfJnOA=;
        b=XTI2yngLSqOZH1GEsTXDMw76UrT4CglSz4rY4evSxCc4TeOUq1sJHVcR97jnvHDtAN
         M1g2hQFTEfHb/OdqNHpV+WHnwqkj/SCkRpsGJxqqN3QN6plJrIGUsZ8Z+whaDWB6YuGE
         i+r77jtH+ac+wC2m2YbjMPhze46yWyUeqk/ybWVERxVzXWSJMvV9y/S0XuivfT56bI2u
         lGlND2K4Mp/mHtIS7BqPNxjCS88C4jf1NuDMugNyBLUd09q1FORXZlLGp4ByISjjrXwA
         qI0mh3lALHu2/gpQXHzIrZShGchy5WtRkkR6RRlHxeeGd+EM7Rnuy6EAYEPjNv5G/JVA
         KPCw==
X-Gm-Message-State: AKaTC00cVkVxqVUMNfNdHFk9dSUOo+bmqZ1GuAJBFWJh0+F6OlWenV6c9vjM6IPhOOWJYw==
X-Received: by 10.194.111.231 with SMTP id il7mr29377664wjb.52.1480539882679;
        Wed, 30 Nov 2016 13:04:42 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:04:41 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 00/16] Add initial experimental external ODB support
Date:   Wed, 30 Nov 2016 22:04:04 +0100
Message-Id: <20161130210420.15982-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
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
using "odb.<odbname>.command" config variables, to access external
ODBs where objects can be stored and retrieved.

External ODBs should be able to tranfer information about the blobs
they store. This patch series shows how this is possible using kind of
replace refs.

Design
~~~~~~

* Registered command

Each registered command manages access to one external ODB and will be
called the following ways:

  - "<command> have": the command should output the sha1, size and
type of all the objects the external ODB contains, one object per
line.

  - "<command> get <sha1>": the command should then read from the
external ODB the content of the object corresponding to <sha1> and
output it on stdout.

  - "<command> put <sha1> <size> <type>": the command should then read
from stdin an object and store it in the external ODB.

* Transfer

To tranfer information about the blobs stored in external ODB, some
special refs, called "odb ref", similar as replace refs, are used.

For now there should be one odb ref per blob. Each ref name should be
refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob stored
in the external odb named <odbname>.

These odb refs should all point to a blob that should be stored in the
Git repository and contain information about the blob stored in the
external odb. This information can be specific to the external odb.
The repos can then share this information using commands like:

`git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`

* External object database

This RFC patch series shows in the tests:

  - how to use another git repository as an external ODB
  - how to use an http server as an external ODB

Design discussion about performance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Yeah, it is not efficient to fork/exec a command to just read or write
one object to or from the external ODB. Batch calls and/or using a
daemon and/or RPC should be used instead to be able to store regular
objects in an external ODB. But for now the external ODB would be all
about really big files, where the cost of a fork+exec should not
matter much. If we later want to extend usage of external ODBs, yeah
we will probably need to design other mechanisms.

Here are some related explanations from Peff:

{{{
Because this "external odb" essentially acts as a git alternate, we
would hit it only when we couldn't find an object through regular means.
Git would then make the object available in the usual on-disk format
(probably as a loose object).

So in most processes, we would not need to consult the odb command at
all. And when we do, the first thing would be to get its "have" list,
which would at most run once per process.

So the per-object cost is really calling "get", and my assumption there
was that the cost of actually retrieving the object over the network
would dwarf the fork/exec cost.

I also waffled on having git cache the output of "<command> have" in
some fast-lookup format to save even the single fork/exec. But I figured
that was something that could be added later if needed.

You'll note that this is sort of a "fault-in" model. Another model would
be to treat external odb updates similar to fetches. I.e., we touch the
network only during a special update operation, and then try to work
locally with whatever the external odb has. IMHO this policy could
actually be up to the external odb itself (i.e., its "have" command
could serve from a local cache if it likes).
}}}

Implementation
~~~~~~~~~~~~~~

* Mechanism to call the registered commands

This series adds a set of function in external-odb.{c,h} that are
called by the rest of Git to manage all the external ODBs.

These functions use 'struct odb_helper' and its associated functions
defined in odb-helper.{c,h} to talk to the different external ODBs by
launching the configured "odb.<odbname>.command" commands and writing
to or reading from them.

The tests in this series creates an odb-helper script that is
registered using the "odb.magic.command" config variable, and then
called to read from and write to the external ODB.

* ODB refs

For now odb ref management is only implemented in a registered command
in t0410, but maybe this or some parts of it could be done by Git
itself.

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

    - Patches 01/16 and 02/16 are Peff's initial work. They are not
      changed since v1.

    - Patches 03/16 is an optimization in the odb-helper script that
      is used for testing. I will probably squash it into 01/08, but
      didn't yet. So there is no change since v1.

    - Patches 04/16 and 05/16 are adding "put" support in the
      odb-helper script and testing that. They are not changed since
      v1.

    - Patches 06/16 and 08/16 are enhancing external-odb.{c,h} and
      odb-helper.{c,h}, so that Git can write into an external
      ODB. They are not changed since v1.

    - Patch 07/16 limits write support to "blobs" for now to
      simplify things. It did not change since v1.

    - Patch 09/16 adds a GIT_NO_EXTERNAL_ODB env variable to disable
      using the external database. It was new in v2.

    - Patch 10/16 adds test t0410 that shows how odb refs can be used
      to transfer information about blobs managed by an external
      odb. It was new in v2.

    - Patches 11/16 to 14/16 are preparing cgi and a apache config
      file so that an apache server can be used as an external object
      database. It is based on existing infrastructure in t/lib-http/.
      This is new in v3.

    - Patch 15/16 adds support for external ODBs that are storing
      files in their original format instead of as Git objects. It
      adds the odb.<helper>.plainObject config option to support these
      external ODBs. This is new in v3.

    - Patch 16/16 adds test t0420 that shows how an apache server can be used
      as an external ODB. This is new in v3.


Future work
~~~~~~~~~~~

I think that the odb refs don't prevent a regular fetch or push from
wanting to send the objects that are managed by an external odb. So I
am interested in suggestions about this problem. I will take a look at
previous discussions and how other mechanisms (shallow clone, bundle
v3, ...) handle this.

One interesting thing also would be to use the streaming api when
reading from or writing to the external ODB. (If it is not
automatically used already when the blob is bigger than
core.bigFileThreshold.)

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

Version 1 and 2 of this RFC/PATCH series are here:

https://public-inbox.org/git/20160613085546.11784-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20160628181933.24620-1-chriscool@tuxfamily.org/

Links
~~~~~

This patch series is available here:

https://github.com/chriscool/git/commits/external-odb

Version 1 and 2 are here:

https://github.com/chriscool/git/commits/gl-external-odb12
https://github.com/chriscool/git/commits/gl-external-odb22


Christian Couder (14):
  t0400: use --batch-all-objects to get all objects
  t0400: add 'put' command to odb-helper script
  t0400: add test for 'put' command
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
  t0420: add test with HTTP external odb

Jeff King (2):
  Add initial external odb support
  external odb foreach

 Makefile                       |   2 +
 cache.h                        |  18 ++
 environment.c                  |   4 +
 external-odb.c                 | 156 ++++++++++++++++
 external-odb.h                 |  16 ++
 odb-helper.c                   | 396 +++++++++++++++++++++++++++++++++++++++++
 odb-helper.h                   |  33 ++++
 sha1_file.c                    |  69 +++++--
 t/lib-httpd.sh                 |   8 +-
 t/lib-httpd/apache-e-odb.conf  | 214 ++++++++++++++++++++++
 t/lib-httpd/list.sh            |  34 ++++
 t/lib-httpd/upload.sh          |  45 +++++
 t/t0400-external-odb.sh        |  77 ++++++++
 t/t0410-transfer-e-odb.sh      | 136 ++++++++++++++
 t/t0420-transfer-http-e-odb.sh | 118 ++++++++++++
 15 files changed, 1309 insertions(+), 17 deletions(-)
 create mode 100644 external-odb.c
 create mode 100644 external-odb.h
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 t/lib-httpd/apache-e-odb.conf
 create mode 100644 t/lib-httpd/list.sh
 create mode 100644 t/lib-httpd/upload.sh
 create mode 100755 t/t0400-external-odb.sh
 create mode 100755 t/t0410-transfer-e-odb.sh
 create mode 100755 t/t0420-transfer-http-e-odb.sh

-- 
2.11.0.rc2.37.geb49ca6

