Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C181F461
	for <e@80x24.org>; Thu, 11 Jul 2019 18:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfGKSHQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 14:07:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37393 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfGKSHP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 14:07:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so6781486otp.4
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 11:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2OZ2FtnOfIdzXhy5nf/m+8+EV27khHm0VRRvidpan6E=;
        b=AWZcYSn6bnFwkiXt9AIP1W9vVGuhrJYphZMruDT8H7SqWsNRHDxznSomnDjiFqcr8f
         0YKzRgntQwIDGq5kYlKxegR30EqmgUuS2fZK9z6wmXoohxAIsZhwP0IzezMIwr8mtN41
         1Oz4HVrX0rDOfQgtvmTNS4FxidIvimMVMAoskVVxO35GNad+BnTxV1lfRzkUjffX71Ca
         pW8C2Lp+ECTjTw93vn1wbPOVzXjCKNcgeeYTDB7Nj+yQyQ/+nBDTZlRwLGWPzVz/8tft
         RwMWb21IBSHsbZ8rrxMA9hy5PL+9viuksINc9sLCf4aA0hUhJNoYUgk+cdV05DDzz8cg
         zvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2OZ2FtnOfIdzXhy5nf/m+8+EV27khHm0VRRvidpan6E=;
        b=KkzyxBPLhiCz6YUipvB2Aajl0uwqSeNJAQpTCWwKbckXddzLHHw/iTuY2ww77eDUpY
         tNCHrSJ0MDLDOdOIuhoHs+PZygz/24i1wcnF0E8FLmjuO8e6OTTJ6HSqRTrgE4flRRJ4
         RRMPax9m0Z95NEyRnjPYM3j/jH4fAfpqY3ShN70f2uPvAg6Bl7tBsl6nd7CnrYpYDLfN
         xiJxZ55Ip/2O9wB8ZSdmp4bds+RAaRfUlssSSsW4tjYw++2VZLPANHbHF/pLNfYVsWEa
         tKDsrDoqSJo59CoTramCdl8/78oGBwTyoph8YUQI4Zqan3jkK8Osv2qsU2xgtKnOqPvy
         rhMQ==
X-Gm-Message-State: APjAAAWOwZXXzTGpBPZyqZ9lozk2O5MzZS5LkCf2/kY4O5lIZsEncbzN
        R+JECKYVRnkRxdPVqxPZphekxMfD
X-Google-Smtp-Source: APXvYqwhtZcSaSGQRZtZs0tXPMw8guCWnhF/2EMZwIXT21yNppn/txDDNnRajio3ykeYnNvS9Wkb/w==
X-Received: by 2002:a9d:6c13:: with SMTP id f19mr2863279otq.76.1562868434742;
        Thu, 11 Jul 2019 11:07:14 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5d50:4f59:ae8:3eb7])
        by smtp.gmail.com with ESMTPSA id 132sm2131545oid.47.2019.07.11.11.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 11:07:12 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v3 0/3] use mailmap by default in git log
Date:   Thu, 11 Jul 2019 13:06:41 -0500
Message-Id: <20190711180644.30417-1-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is not uncommon for people to change their name or e-mail address.
To facilitate this, Git provides support for the `.mailmap` file,
which contains a list of identities and previously used e-mail
addresses that are associated with that identity.

Unfortunately, while Git's support for the `.mailmap` file is generally
excellent, I recently discovered that `git log` does not treat the
mail map file the same as the other tools, instead requiring an
explicit flag to use the mailmap file.

I believe this is an unfortunate flaw, as the mailmap file should
ideally contain the most current known contact information for a
contributor, allowing anyone to contact the contributor about their
patches in the future.

New in version 3:
- Rework many mailmap tests to drop redundant `--use-mailmap` and
  more rigorously test --no-use-mailmap and configuration variants.
- Typo fixes in the commit messages.

New in version 2:
- The `--no-use-mailmap` option, which complements `--use-mailmap`.
- Tests for `--no-use-mailmap`.

Ariadne Conill (3):
  log: use mailmap by default
  log: add --no-use-mailmap option to complement --use-mailmap option
  tests: rework mailmap tests for git log

 Documentation/git-log.txt |  5 ++++
 builtin/log.c             |  3 ++-
 t/t4203-mailmap.sh        | 49 ++++++++++++++++++++++++++++++++-------
 3 files changed, 48 insertions(+), 9 deletions(-)

-- 
2.17.1

