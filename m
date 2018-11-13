Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6489E1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 00:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbeKMKf5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 05:35:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33294 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730608AbeKMKf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 05:35:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so2187589pgu.0
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 16:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rrsSPJw0xGxfqEeGCiZC8UQHbpts5qFv0Z2WTIe0jtU=;
        b=HphDfInwAym7u+nVNmC96s3SgcHDE1K+LdqrfODQqDkNJcJj5wZ2PtrgdgvC2c3mfC
         ZibXOcrgxCIM9roarWXVoQ0uN680VMZW5S3w9mZg4Swf/bWbkhQStXT+qi9UFBk8x2qA
         rbDULS6bYtG7CUTsPXN8kxSYEEiKsIKPvuXfUx3RK+X0liZlnB6R8339DiJnacuNA5Bg
         lxMNbcdU/PA8ug7SYI0wCvtfvFsJCwoJvJcXwqdCiJvTxvQtuzrXjrs0fCJqPgKurepK
         dn+raUK4104tV7AcCvxsVTg2/C6Cy7cjekPCksQM7vPK3fS2jaB1PcYWuoj7DUj2S1DZ
         X5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rrsSPJw0xGxfqEeGCiZC8UQHbpts5qFv0Z2WTIe0jtU=;
        b=J3jErJ4S9XGEGK8gH3hEWfHuVEO7DNCO7nPW1ahF8NKSDruIsdpchMCAIWV6rqYdR/
         Grxtel6VmrRHo8E2lcN/sDm0qsWFQ9gqcm9XTlFHsoF5rJnQCKlz2FUB7p81xuZu6TKY
         t1TfnypWEJdrlEjqyV7CzKw7hYbNu+86FPAat+dJ6gieFvcMYS+0+V90R3cNFAilqzPe
         0Q/jRQnCYTG0UEAE2o5aLSUWhadaD4wszdO65HcpqaX5fVO+oG3EhmZ8eQ2iJrLRkTi4
         7itDV/bhq+OXk1fIw0oT6fqIc/w+bxG2srBiopwgk8UfrRR4m8Kg6qE3+WdgOG+L7hxz
         SQOw==
X-Gm-Message-State: AGRZ1gI+M6+yhEeEAnnwP3OrSt3eiB83OQbKawD3pUVMKKDF/lpx57jn
        AHGjBzIIyzWnwOOiFCGTV10=
X-Google-Smtp-Source: AJdET5fY/Sp6flXtU6ADvb+rOfgWUejjBTwtpc/WteDN/KyhAM7/PYf/3uyFuqYkt/O/Vs6YkfRynw==
X-Received: by 2002:a63:40c6:: with SMTP id n189mr2703931pga.355.1542069621574;
        Mon, 12 Nov 2018 16:40:21 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id y9-v6sm18898145pfe.152.2018.11.12.16.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 16:40:21 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:40:19 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH 3/3] index: do not warn about unrecognized extensions
Message-ID: <20181113004019.GD170017@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113003817.GA170017@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation/technical/index-format explains:

     4-byte extension signature. If the first byte is 'A'..'Z' the
     extension is optional and can be ignored.

This allows gracefully introducing a new index extension without
having to rely on all readers having support for it.  Mandatory
extensions start with a lowercase letter and optional ones start with
a capital.  Thus the versions of Git acting on a shared local
repository do not have to upgrade in lockstep.

We almost obey that convention, but there is a problem: when
encountering an unrecognized optional extension, we write

	ignoring FNCY extension

to stderr, which alarms users.  This means that in practice we have
had to introduce index extensions in two steps: first add read
support, and then a while later, start writing by default.  This
delays when users can benefit from improvements to the index format.

We cannot change the past, but for index extensions of the future,
there is a straightforward improvement: silence that message except
when tracing.  This way, the message is still available when
debugging, but in everyday use it does not show up so (once most Git
users have this patch) we can turn on new optional extensions right
away without alarming people.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.  Thoughts?

Sincerely,
Jonathan

 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 290bd54708..65530a68c2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1720,7 +1720,7 @@ static int read_index_extension(struct index_state *istate,
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
 				     ext);
-		fprintf(stderr, "ignoring %.4s extension\n", ext);
+		trace_printf("ignoring %.4s extension\n", ext);
 		break;
 	}
 	return 0;
-- 
2.19.1.930.g4563a0d9d0

