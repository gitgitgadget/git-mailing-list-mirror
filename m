Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F05F1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 18:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfGKShe (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 14:37:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34697 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbfGKShe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 14:37:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so6897176otk.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mTJ5+j8YrhBpPoMjuxVRJ8ICivq0fOfdeugPAQDOmCQ=;
        b=IE7xIWQnVKACXcz3/rQ+bsjceQLb69jilweAYweFni0s2LH3uWl1MyGgq8+Hwm5OSB
         9PUVmPczRxK3BbrJSypfTX1f+OTR3WIpsxRa0rFXk7Z0MmQNbYj1DmVTNaCIviOsUGyf
         +rDl1R0926kxPHmtiQ5RkT1TRzLn13tkUcWbAHrjNahfTPWxfubY/lud8z2djQZ+aWlf
         dbMhAuooQkO5be0BqIm0FMP4opb+uL9z7+7yToCAV/P4XzxwRueAp2JFVAnjfh+6g/sd
         MSX7IC7s/J5kAd0AJYSg2jTW3K4uZGqVZgX48EFL5ZfpFHZnexpE37mfPv6r5Aywuk0K
         yGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mTJ5+j8YrhBpPoMjuxVRJ8ICivq0fOfdeugPAQDOmCQ=;
        b=ntRmIsgZenMTOjqLklVyIm+WTa/LHLT23I6XRL5c5g/mn8z92LzVYxOXDov8q2w+in
         i8RJcQQ3S4rg23aLaVYSL4dBQU/06079V4S5Tw3rjYRIdGwdjpJg9T+Z3sH+FuxcL6c6
         r4deBRBcwDRG15Hcbg4cEG+wJGwzLwaUWwcByvXUgItvTFjJrm/usEkms4GuotDr01h8
         6FEWs05UyzHYg0hpP82wUhY3IwhY7AWp4I9J91X6rogB+lkGqQdIA4geEzNTLU2ujlBe
         vFSjtQs+bPygKc38Lbu89Wc3sUNtGx4ehYVdck6jMgKudhHSfHDJpD4OqVcdKZGXk4gd
         54kw==
X-Gm-Message-State: APjAAAXebBButwtCTy3xcvbzaNW1pvLllKz1quBWODxrzDKXN+EYBJ1Q
        7jJZF6nsnNKMjO3DeZIkAbz80sL+
X-Google-Smtp-Source: APXvYqzn0qQCOmLql6v7rdzec1tCxCuzXzEqXaLkYXbX5Ciih2v0F7ZLd25QyAv+nRiX5thqOzcLPQ==
X-Received: by 2002:a9d:64ca:: with SMTP id n10mr4377189otl.249.1562870253001;
        Thu, 11 Jul 2019 11:37:33 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5d50:4f59:ae8:3eb7])
        by smtp.gmail.com with ESMTPSA id h9sm2016646otl.51.2019.07.11.11.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 11:37:32 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v4 0/3] use mailmap by default in git log
Date:   Thu, 11 Jul 2019 13:37:24 -0500
Message-Id: <20190711183727.8058-1-ariadne@dereferenced.org>
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

This should be the finished version of the patch set, thanks to
everyone who has helped review it!

New in version 4:
- Remove reundant `--no-use-mailmap` option, the option parsing
  code automatically handles negation.
- Update config/log.txt documentation to reflect the new default.

New in version 3:
- Rework many mailmap tests to drop redundant `--use-mailmap` and
  more rigorously test --no-use-mailmap and configuration variants.
- Typo fixes in the commit messages.

New in version 2:
- The `--no-use-mailmap` option, which complements `--use-mailmap`.
- Tests for `--no-use-mailmap`.

Ariadne Conill (3):
  log: use mailmap by default
  log: document --no-use-mailmap option
  tests: rework mailmap tests for git log

 Documentation/config/log.txt |  4 +--
 Documentation/git-log.txt    |  2 +-
 builtin/log.c                |  2 +-
 t/t4203-mailmap.sh           | 49 ++++++++++++++++++++++++++++++------
 4 files changed, 45 insertions(+), 12 deletions(-)

-- 
2.17.1

