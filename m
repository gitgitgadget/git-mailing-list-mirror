Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF701F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfGKR0j (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:26:39 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37138 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKR0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:26:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id s20so6654147otp.4
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=yE6TwGqKOk6ziZv0xyAXHk8hanwIYiI2iVLjWKglLKw=;
        b=lw1Dq0GnmCydSaT1V26d/OsnwoSagwzHTnCO9uEFusybO8ufx9v6IpqLtu0l2147E5
         eFADS1/v7Ld+gt4foRVQcC2mrvTyl4xzJRc3QM6mQ+1RD8W8JstpcXBTkBA30fyBq3Is
         6SjyDSMOTWzyxsSknodObj9fTBO+LbecFrwApHzwQZV476rhS3IML+i4+4s+pv80fCM0
         ZfIvtXR6XbJ9PV8ZGrTJkjxvGeA++cC0LSZbmkl87bVWGCfEnDplEOYQ674kqyjGamBA
         6bepeTQVtrfABP4Y6xzejGp7KJD0R3Slh4Wjhlyai5RGBzPawr/IWbZ0DvoTmb5lyeS5
         gwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yE6TwGqKOk6ziZv0xyAXHk8hanwIYiI2iVLjWKglLKw=;
        b=QYEdFVBTa35Zy9iIHkIObvQPa4UET+D1rcs4iN/VpowCEWccs+pgAR2kwv3ihG+7NV
         w7N9Jn01gN++kmcd8gXd1yWISb/d9Qhy4mQ9Hd5kbMida3Ox9URG2kgguINup3nFpNcx
         mR7ULa4PpMkCsvOKoDUshUVVxKGBEAK9NoLWEl7cyxSm2YwFCYTU4v7+Qxab73BGJAjM
         PXVleenkhINbAPMWP0zufYTTkwMzVI2EjY/in3KN5gDrlqpmrxOmCGBHox02+vLMsmzs
         xhXNBuVs85eVDnc77hdWWiiclKjXjThgbJXwZsk855zPNKOKHqNSJglH5Oqb4N2+pe8U
         3BWg==
X-Gm-Message-State: APjAAAUSMOywDvMHsS9Q2N6U0zRu7q7dJ4GUueUjMzzl5xArl6j24dm7
        is/vYQGK7GoktWdl10c0GlFVVQAf
X-Google-Smtp-Source: APXvYqw6ZJlNqxHFufiDAOeH75T0Jj2qkOQ8KsJSvCGPU8Ktbspf0qA5Rrkrp3EKa+iK8D9ER164fA==
X-Received: by 2002:a9d:744a:: with SMTP id p10mr4562582otk.321.1562865997818;
        Thu, 11 Jul 2019 10:26:37 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5d50:4f59:ae8:3eb7])
        by smtp.gmail.com with ESMTPSA id h11sm2045933otj.76.2019.07.11.10.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:26:37 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v2 0/3] use mailmap by default in git log
Date:   Thu, 11 Jul 2019 12:26:23 -0500
Message-Id: <20190711172626.16480-1-ariadne@dereferenced.org>
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

New in version 2:
- The `--no-use-mailmap` option, which complements `--use-mailmap`.
- Tests for `--no-use-mailmap`.

Ariadne Conill (3):
  log: use mailmap by default
  log: add --no-use-mailmap option to complement --use-mailmap option
  tests: add test for git log --no-use-mailmap

 Documentation/git-log.txt | 5 +++++
 builtin/log.c             | 3 ++-
 t/t4203-mailmap.sh        | 8 ++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.17.1

