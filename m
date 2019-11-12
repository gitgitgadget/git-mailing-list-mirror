Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48DD71F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKLXH4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:07:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41792 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfKLXHz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:07:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id p26so163273pfq.8
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FuQvl+O6C49lF2W+/zr2MMJEYh6cCBsX8aEHKqqQwAQ=;
        b=Y4nS4HeBlvqODcMyNY2lqmcrQrlXKp1RldZLBlb3WEtA7HS7dgDzrhuwo5wcTQ6ehw
         YlVvFis+ak/Mp9jhZOqcHOLYk3Ntxkpcn7TrbKS9bNtEnOZUd6KwjLjXpUbtjRsguPGZ
         YNSNv1YPTxjNrFCDSddQG6kjqH8AZgm+GMhAMMiGBpufxbBROqALdvi7/QGJ3dtZmIaw
         6GvxekOhQKmg/6B7tMYCxiUHgpmKw1yI9lceKi0dTU1WYra+V5jSTllY5J8wK9Q3lbie
         60wsxv40FntOfaHZt9guJux43nIpVR28fP9Z3ks1ZP+WCOS3IuRqpZAA58aWh+D6mGCX
         nuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FuQvl+O6C49lF2W+/zr2MMJEYh6cCBsX8aEHKqqQwAQ=;
        b=cBOY/EFYuKmZieKyBCMpuR+zXpSOx+AqOEuZDXnekpx3nWJqHvHs0Po/vycddrhCgK
         25RR88OyI6/4rmlL6nCXFEcqRI/6iBmUw9sSEwKopne5nO3tCXZ7AyJqxPaDBoAHlHNQ
         60av1Q3Nrbaz0Ald6zBGy87409LhA999wauq6y6OzYaeLdJ95dDxCtSB9R/EgcfIEsZU
         HdCmBdQFHEXthLSCb14zOeuKW5XmUZua6iVdTqps98ytgy/kFCMJh423u5J6z2SpwC1i
         8rt9r7t2YA8YjnuJyfAC15rt5UGkRfP5PxOgKUH9tdHTj0QxwPNdcWuxfjNxZdENrkJN
         iYQg==
X-Gm-Message-State: APjAAAURN2SCCXIDUly7xrX50A6jKynsz4wJN4/+JVAmogTBsTDg/Tv3
        OBIh9iDu6KmqVZ6xELO2dyFf8xha
X-Google-Smtp-Source: APXvYqyuh47gHAjiWfST6xYO6HzKDke7GaXC75mM7vc9VilqU9EZT8Tq/XqKb9DHZagNLyhLZpTw8w==
X-Received: by 2002:a63:7b5c:: with SMTP id k28mr24871pgn.442.1573600074847;
        Tue, 12 Nov 2019 15:07:54 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id f189sm47158pgc.94.2019.11.12.15.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:07:54 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:07:52 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 04/14] t5520: let sed open its own input
Message-ID: <0660aa3ffffefb89307a02a0235fd3f8730ae618.1573595985.git.liu.denton@gmail.com>
References: <cover.1573517561.git.liu.denton@gmail.com>
 <cover.1573595985.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573595985.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were using a redirection operator to feed input into sed. However,
since sed is capable of opening its own files, make sed open its own
files instead of redirecting input into it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a3de2e19b6..55560ce3cd 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -5,7 +5,7 @@ test_description='pulling into void'
 . ./test-lib.sh
 
 modify () {
-	sed -e "$1" <"$2" >"$2.x" &&
+	sed -e "$1" "$2" >"$2.x" &&
 	mv "$2.x" "$2"
 }
 
-- 
2.24.0.346.gee0de6d492

