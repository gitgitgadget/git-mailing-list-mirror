Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0EEB1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 09:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbfJ2J1r (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 05:27:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50953 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfJ2J1r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 05:27:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so1733939wmk.0
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=M+4Q3XFBjvnfD5qpxcrsyFD/TzKQveR4O8r4Hc6TxQw=;
        b=RWtHAvz0Eroy7Zl7Ls6pEBhoNQQe4pJb5kGlNM3/LU51IDH9nmBBtlYreRnEza2N3z
         wu5RbCgQP2VDY/EmdhKAZdxd34JUgLFgVtrmo6+blejm3TIKrwflbViaNwARbkIVj3rf
         /+t4WBFa3Ii/vRgLPVHDmYoB5sPF96lhN4ZqIJoksiAO38cSGB/aluHaJAc/iNBlsIfN
         kUhfMGMkAQF/9QEeScQy0Mq3BfLHSWc++otMo4RXW1kXkkg01cseAvY+8vs/DcxeRddh
         b7TpuxjxjVm6eVyZYSt5L4j3c50So0ifCQ0xsC7I9cU+gY0E3rMvEVAxpHSwu1QTn+l1
         mVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=M+4Q3XFBjvnfD5qpxcrsyFD/TzKQveR4O8r4Hc6TxQw=;
        b=NVKXu36BvPF6IV5uuafrHvsdQas8hQZOx/t9WFUX32mLpTPnNRPPgkM+ePOUlKL2NJ
         cKu0GYYKC9TTqPjqLzfsooXzsdRcna0Ohvu1fOC8LBizPpoDvVxjFh4gkjHxKdPRElqT
         urKuMgpOxDtxeAkVQV0hZxJbmZiiIs1XwYouIwt8/0Tq9Rw5Mp/JPEvihScTZQQR347K
         aLRtrbQEDPwquDFQSM5qMg3BOiN0LT3LzGqkta7rU1HiUQHBsxnFwXD4UMIAc6OG3twb
         JMRr+1rzaHzSZ3BqFKWDgSZwG9+nE13k+N61swLzMldj1MosZLQ9BCDZzPK4yHhuBfHa
         iweQ==
X-Gm-Message-State: APjAAAUPOLDYCxI1Wpbsfx3KE8ddIjD/DsOQqGq7hkfQ+8D4yP/9DeMY
        GjHa/toOZgsOLD4f8KR/wnlGdzpm
X-Google-Smtp-Source: APXvYqyWjOLsx4Kq7eMDmWRW3zvt3+3YjlvGYeE7lLbQQZjxXwV39DTON1fLzL7RrOAhtuaIKTm/YA==
X-Received: by 2002:a1c:2706:: with SMTP id n6mr3274277wmn.154.1572341265653;
        Tue, 29 Oct 2019 02:27:45 -0700 (PDT)
Received: from localhost (host54-59-dynamic.49-79-r.retail.telecomitalia.it. [79.49.59.54])
        by smtp.gmail.com with ESMTPSA id a7sm1746702wrr.89.2019.10.29.02.27.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 02:27:45 -0700 (PDT)
Date:   Tue, 29 Oct 2019 10:27:35 +0100
From:   Davide Berardi <berardi.dav@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] Segmentation fault on non-commit objects.
Message-ID: <20191029092735.GA84120@carpenter.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixed segmentation fault that can be triggered using
$ git clone --branch $object $repository
with object pointing to a non-commit (e.g. a blob).

Signed-off-by: Davide Berardi <berardi.dav@gmail.com>
---
 builtin/clone.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index f665b28ccc..6ad2d8fe77 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -720,6 +720,9 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(the_repository,
 							   &our->old_oid);
+		/* Check if --branch specifies a non-commit. */
+		if (c == NULL)
+			die(_("unable to update HEAD (cannot find commit)"));
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
 			   UPDATE_REFS_DIE_ON_ERR);
-- 
2.23.0

