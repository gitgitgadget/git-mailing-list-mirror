Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BDD02018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbcF1STt (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:19:49 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36083 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbcF1STs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:19:48 -0400
Received: by mail-wm0-f41.google.com with SMTP id f126so151015747wma.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 11:19:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=M6D4QAFhDWvWT8N29A8T6LGZYuyPk810saMAB2oIh1g=;
        b=u4Vn6YjraBJzocERvZaWdKAZKGSktR1b64dGG8ZuyO2m80nUjuJ2o76l+fjPO055Wi
         dQGfuTZsQ3aRf7lr2Uq1nkJgthPgTLL6z1kzMOGKplo+PjYZGn0BsB9jrUodct+jwNGl
         SImVui+tYntFunbRqO2TeoMf3FRLlHVlPe3eU5OJT3GAnTM+V188QVRxPz9JDYqQv7au
         nsNEMxF8s42lCPVrZk1TXno4F32eK0faQ5kl0257wouAtw9L+Qiho1BTAJys1n3UFc2C
         wymmcM6KJOVXXwQziVUaKeOX8SAieZ5sT9cJsRz8bkpU2WDa0624BGxdIKQxOKjaPeh8
         dBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M6D4QAFhDWvWT8N29A8T6LGZYuyPk810saMAB2oIh1g=;
        b=Qf1CG+q8y8Vao6otDvKNzVBH+75lpLiI7V4V1wpLSJm1j8wyLgLuvKZY/I+F3xa9lV
         xQRqzZ/1s0ZikTEAZ7rqybosPZlJRDtTfgSbuW3fPlg6T2Zg8T7XVzmfsIPnwQzvWpd4
         pjgyKDOneBINBq3QpnVzdd0Y6/LoWH0iY27GQjX7FkaI86nZ3imAJ0ITBtV3lPKufR4F
         h9eN9q33lChb3cRlYrMzgDBiGr7OKgLWjRFrIVcmO4UV1rPffX+bis6ydGyjqdYZmxKD
         k/YXO+LoiTPxzLkVdEt/h5g8cDwU9MJqRUFEp+fBnNkQNhgC4LWC05hT3jO4+YiMc1Ie
         FNbw==
X-Gm-Message-State: ALyK8tKeVhpMcB5e/fj4GR9bCRJFwQ0tqf8EHQeGeKD+EelREKoGyjQk0bN9nn2wcdKfXQ==
X-Received: by 10.28.176.7 with SMTP id z7mr4660124wme.17.1467137986825;
        Tue, 28 Jun 2016 11:19:46 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id yr4sm2061048wjc.18.2016.06.28.11.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 11:19:46 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v2 00/10] Add initial experimental external ODB support
Date:	Tue, 28 Jun 2016 20:19:23 +0200
Message-Id: <20160628181933.24620-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.11.g990c140
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
they store. This patch series show how this is possible using kind of
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

* Other

This RFC patch series for now does not address the following important
part of a complete solution:

  - No real external ODB has been interfaced with Git. The tests use
another git repo in a separate directory for this purpose which is
probably useless in the real world.

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

    - Patches 01/10 and 02/10 are Peff's initial work. They are not
      changed since v1.

    - Patches 03/10 is an optimization in the odb-helper script that
      is used for testing. I will probably squash it into 01/08, but
      didn't yet. So there is no change since v1.

    - Patches 04/10 and 05/10 are adding "put" support in the
      odb-helper script and testing that. They are not changed since
      v1.

    - Patches 06/10 and 08/10 are enhancing external-odb.{c,h} and
      odb-helper.{c,h}, so that Git can write into an external
      ODB. They are not changed since v1.

    - Patch 07/10 limits write support to "blobs" for now to
      simplify things. It did not change since v1.

    - Patch 09/10 add a GIT_NO_EXTERNAL_ODB env variable to disable
      using the external database. It is new in this series.

    - Patch 10/10 add test t0410 that shows how odb refs can be used
      to transfer information about blobs managed by an external
      odb. It is new in this series.

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

Another interesting thing would be to use an http server as an
experimental external odb.

Previous work and discussions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Peff started to work on this and discuss this some years ago:

http://thread.gmane.org/gmane.comp.version-control.git/206886/focus=207040
http://thread.gmane.org/gmane.comp.version-control.git/247171
http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020

His work, which is not compile-tested any more, is still there:

https://github.com/peff/git/commits/jk/external-odb-wip

Initial discussions about this new series are there:

http://thread.gmane.org/gmane.comp.version-control.git/288151/focus=295160

Version 1 of this RFC/PATCH series is here:

http://thread.gmane.org/gmane.comp.version-control.git/297164

Links
~~~~~

This patch series is available here:

https://github.com/chriscool/git/commits/external-odb

Version 1 is here:

https://github.com/chriscool/git/commits/gl-external-odb12


Christian Couder (8):
  t0400: use --batch-all-objects to get all objects
  t0400: add 'put' command to odb-helper script
  t0400: add test for 'put' command
  external odb: add write support
  external-odb: accept only blobs for now
  t0400: add test for external odb write support
  Add GIT_NO_EXTERNAL_ODB env variable
  Add t0410 to test external ODB transfer

Jeff King (2):
  Add initial external odb support
  external odb foreach

 Makefile                  |   2 +
 cache.h                   |  18 +++
 environment.c             |   4 +
 external-odb.c            | 154 +++++++++++++++++++++++++
 external-odb.h            |  16 +++
 odb-helper.c              | 287 ++++++++++++++++++++++++++++++++++++++++++++++
 odb-helper.h              |  32 ++++++
 sha1_file.c               |  69 ++++++++---
 t/t0400-external-odb.sh   |  77 +++++++++++++
 t/t0410-transfer-e-odb.sh | 136 ++++++++++++++++++++++
 10 files changed, 780 insertions(+), 15 deletions(-)
 create mode 100644 external-odb.c
 create mode 100644 external-odb.h
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100755 t/t0400-external-odb.sh
 create mode 100755 t/t0410-transfer-e-odb.sh

-- 
2.9.0.rc2.11.g990c140

