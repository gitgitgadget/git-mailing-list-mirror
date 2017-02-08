Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 685AC1FCC7
	for <e@80x24.org>; Wed,  8 Feb 2017 11:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932855AbdBHLby (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 06:31:54 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34351 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbdBHLbv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 06:31:51 -0500
Received: by mail-pf0-f195.google.com with SMTP id y143so11522438pfb.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 03:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4k/eBsboqY70bbrcq2kHqvUfwO5IjM48p87/CN+MK4=;
        b=rLa+/tryfh+S3xV7mDFpVtCIq+tin4SSBRz+F3tj+JYGu89wXE+GbiEfcsWVLqu1rq
         UzDBLegf3KpNJtxWvHXvKlSZsaEXPOH3t78TEtoPmcKNw6DkWjqRaYa/ismQkQ4VditR
         vC+WKuU+x0qX1DLqAcrC5Xd7IPv7zF+fMSYpoU6dQe/Po8p3SjUIAcGXiEY0rv8XulYw
         q/uP+6x3MyUYTXZuxHtgvaz8aux9ZlnC9DEHxlBTq65PO3eSKZKBio1gdggoUoQCibE3
         4gvPDSPxxb0jnJAjd87SeRcHyEg+cprxGXb5BgVTOpTTt6imW3IpoP3QLw++W0R43EwY
         gIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4k/eBsboqY70bbrcq2kHqvUfwO5IjM48p87/CN+MK4=;
        b=A3z8I+LQsldES4zPZtYfS+EovtPI82LcDmo4HMfGbJXZN6CGiRTkigy3Jwoe7UsHkM
         4q8s1n5D7wTtHpTnYiAFt1NjN8cBR4ZUtYwXab/Bjs7BzX4m2MzalSuz8SILoJU7XIta
         bJfbffwG+LTRv0lTUzEzK4kq2H6ETeozN7VRv3sexXc09MjTeXzbC85Xt0TDwhzvU9aM
         mnxw5S+ZehVVKUm84HMS6NpDGZ1KwbFMyCS6VVoZYZVJWEVROzhkq7/yEYRr0oTpIKN6
         MTVkW5R0ylpfcemQjDCdiE/pAVSikJ5RSwPgCgXrM8jdvwNKmKrPN5a4hcgmSQncLRvy
         /2ZA==
X-Gm-Message-State: AMke39lL7SUl6GytUbIAxiUARcfNSoE9ZpXEnxpKqc06SgDNnkq1n9ajJ0i+/tYRniZ+LA==
X-Received: by 10.84.217.72 with SMTP id e8mr389756plj.102.1486553510843;
        Wed, 08 Feb 2017 03:31:50 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id f188sm19578747pfa.35.2017.02.08.03.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2017 03:31:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 08 Feb 2017 18:31:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH RFC 0/2] Kill manual ref parsing code in worktree.c
Date:   Wed,  8 Feb 2017 18:31:42 +0700
Message-Id: <20170208113144.8201-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A hundred years ago I added this code because a "standalone" ref
parsing code was not available from refs.c and the file was going through
some heavy changes that refactoring its ref parsing code out was not
an option. I promised to kill this parse_ref() eventually. I'm
fulfilling it today (or soon).

I would really like to you double check the approach I'm using here
(using submodule interface for accessing refs from another worktree)
since that may be the way forward to fix the "gc losing objects" in
multi worktrees. I've given it lots of thoughts in the last 24 hours.
Still can't find any fundamental flaw...

Nguyễn Thái Ngọc Duy (2):
  refs.c: add resolve_ref_submodule()
  worktree.c: use submodule interface to access refs from another worktree

 branch.c   |  3 +-
 refs.c     | 20 +++++++++----
 refs.h     |  3 ++
 worktree.c | 99 +++++++++++++++-----------------------------------------------
 worktree.h |  2 +-
 5 files changed, 44 insertions(+), 83 deletions(-)

-- 
2.11.0.157.gd943d85

