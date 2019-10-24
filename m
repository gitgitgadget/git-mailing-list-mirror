Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48AC31F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 23:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfJXXg3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:36:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47771 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727309AbfJXXg3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Oct 2019 19:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571960187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yly3hFal7aCGb2yM3yD+ADd8rOYOPfvXgrsrstNKvV0=;
        b=OdDKXreoUb/xUWxm138NW8Ob74bFGxuK3G3g6dl1U0+zUrA2S7lKB/fHI+rQK+FZldw8oT
        kwW7xTYvCNGfr/Z4OHAWLs5B6bSyuqQyLPgjjo+5aNMtw6rWnnwfJ+DGLCgGxsjS/XkEm1
        KNj6PdD07LCJjoeKG9ltWF1ledgKyZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-TUHAe17QMkKkvioUdoRY9Q-1; Thu, 24 Oct 2019 19:36:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51BE7800D49;
        Thu, 24 Oct 2019 23:36:23 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73792600C6;
        Thu, 24 Oct 2019 23:36:22 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, peff@peff.net,
        szeder.dev@gmail.com, Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v3 0/3] Implement option to output local-part of email addresses
Date:   Thu, 24 Oct 2019 19:36:14 -0400
Message-Id: <20191024233617.18716-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: TUHAe17QMkKkvioUdoRY9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In many projects the number of contributors is low enough that users know
each other and the full email address doesn't need to be displayed.
Displaying only the author's username saves a lot of columns on the screen.
For example displaying "prarit" instead of "prarit@redhat.com" saves 11
columns.

The first two patches are clean-up/prep patches that modify tests t6006
and t4203 to use the definitions in test-lib.sh.  The third patch implement=
s
the "%aL"|"%al|%cL|%cl" pretty options.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Prarit Bhargava (3):
  t6006: Use test-lib.sh definitions
  t4203: Use test-lib.sh definitions
  pretty: add "%aL"|"%al|%cL|%cl" option to output local-part of email
    addresses

 Documentation/pretty-formats.txt |   8 ++
 pretty.c                         |   9 ++-
 t/t4203-mailmap.sh               | 122 +++++++++++++++++++------------
 t/t6006-rev-list-format.sh       |  28 ++++---
 t/test-lib.sh                    |   8 +-
 5 files changed, 113 insertions(+), 62 deletions(-)

--=20
2.21.0

