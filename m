Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFE71208DB
	for <e@80x24.org>; Wed, 23 Aug 2017 00:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbdHWAAN (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 20:00:13 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36855 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbdHWAAM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 20:00:12 -0400
Received: by mail-pf0-f173.google.com with SMTP id c28so784156pfe.3
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 17:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0eHuW2tcKvMYywxmsniGfIqOR5gT8iAcaCiJn1Z6YC0=;
        b=A+ke/rRJ6eXGmk1jCfgC3krRUGHffqm2Kq5nOD+Y7sR+T7uD4n7zdCehfC6PbvRz/s
         qd75XP7PlpkE1fGhOYSVdZvk/FQgK1rLm16WZ8KQ5az72xL+Xjh/FnaUTpmgj7zbuFKs
         caIKrQAMSzOEUfjOt7cq7TwpoqXRzMBvXVEqbiNJyrAHySZ8MUZNsEP5etOOiLxBkaP2
         YFkH9RyGe6rZvc3WPqannruG/nzjHGfYTzn7oj3VbBfiP/Jktta2swHjHX3YRbxeAPve
         0TJYqKTl5x7qs0MEf37zbo09CgSq0FaQHBJQmM8BPFT2bLbMTSIvx1lueNFnn+fdc0nu
         qBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0eHuW2tcKvMYywxmsniGfIqOR5gT8iAcaCiJn1Z6YC0=;
        b=bPE4cLbGwrPrOuj2d87V9IaIgaHCTFtlxfD00W60OicEOr7KhbvltRcNoGf6cf0/+M
         UZCp5LvVG5dPbOKpVpsx71BDaeoO3W4sMGUlgZ/5H5L//CpOSysXIYZ78WnWNvDNzY56
         YKWnCazvCI/pV7APKDvie1xTNq3nqEhV9mR3aSJA3mw3zIWmZbQwBz7SpdXT4AH0ygY5
         CYLEfFAcmJ6mZIcf3SlXyHGnO6S5M8RUfoLvZND9kRLmBrgD0D3W3aJcDX8zf/3YBmEj
         vun3eGewbwlObXb5Etx0Hw8evF1KB2NlNeMv3GmOAKpJ3hnXu1EvYUptwO5JA2+d2HUb
         65cw==
X-Gm-Message-State: AHYfb5j24GNSE9vL7zDc+hAHDzde5M1QnEtULB05MNkFcOR0I4d/3ng8
        +4uGPyf13ZYY3jo5Da8=
X-Received: by 10.84.217.206 with SMTP id d14mr901234plj.319.1503446411255;
        Tue, 22 Aug 2017 17:00:11 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id i81sm198528pfj.32.2017.08.22.17.00.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 17:00:09 -0700 (PDT)
Date:   Tue, 22 Aug 2017 17:00:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 bc/vcs-svn-cleanup] vcs-svn: remove repo_tree library
Message-ID: <20170823000007.GD13924@aiede.mtv.corp.google.com>
References: <20170822233732.GX13924@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822233732.GX13924@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Jonathan Nieder wrote:

> This is an alternative to bc/vcs-svn-cleanup from 'next'.  Those
> patches weren't cc-ed to me and I missed them --- sorry about that.  I
> can rebase on top of them if that is more convenient.

Here is the same series rebased on top of bc/vcs-svn-cleanup.

Thoughts welcome, as always.

Jonathan Nieder (4):
  vcs-svn: remove more unused prototypes and declarations
  vcs-svn: remove custom mode constants
  vcs-svn: remove repo_delete wrapper function
  vcs-svn: move remaining repo_tree functions to fast_export.h

 Makefile              |  1 -
 vcs-svn/fast_export.c | 41 +++++++++++++++++++++++++++++++++++++----
 vcs-svn/fast_export.h |  3 +++
 vcs-svn/repo_tree.c   | 48 ------------------------------------------------
 vcs-svn/repo_tree.h   | 16 ----------------
 vcs-svn/svndump.c     | 33 ++++++++++++++++-----------------
 6 files changed, 56 insertions(+), 86 deletions(-)
 delete mode 100644 vcs-svn/repo_tree.c
 delete mode 100644 vcs-svn/repo_tree.h

> [1] https://public-inbox.org/git/20170822213501.5928-1-sbeller@google.com
> [2] https://public-inbox.org/git/20170821000022.26729-3-sandals@crustytoothpaste.net
