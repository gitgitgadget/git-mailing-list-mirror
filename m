Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6E41F404
	for <e@80x24.org>; Mon,  2 Apr 2018 23:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754675AbeDBXYU (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 19:24:20 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42179 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeDBXYT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 19:24:19 -0400
Received: by mail-wr0-f194.google.com with SMTP id s18so16001837wrg.9
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 16:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gb71d5sJ4cAp5BvXTRdFDGcrtBJjSIDXw8umbZfwDg4=;
        b=SfIt3Ic6ZpCfSgR3eeFhYHEwevcZbIhj/EUrs1X25cZrtwwSyNfueoiystH9CcKnYY
         /gexsza5sD48eqIx0lsPlBT9Ad8dFQHSIhEzbAAAFS8Bi69e0QUOC6C/VOTPQQX1NQAB
         XmPK95bqVJ2YkCbpKzlAOmHhvZ0zjUJJ+I3Yrnlrk6pj1y2+Brd15uYScocxmNDAqmJq
         iCIudSakkldNsmTTrN7pWd2kJDdTbJmlxsDV2FJRYqJ/j0qmox7H3oy48xZPD08tylbR
         BNmYr1sQGgJfxa7taE9XHn0FsC4ozIh6goLZ62KEh9TAfS5TYDePfMw0kLqD8j/mkETi
         5RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gb71d5sJ4cAp5BvXTRdFDGcrtBJjSIDXw8umbZfwDg4=;
        b=SQ357dp72OTKe+UkAXKqN5pooRzx4ia529SYEqLiPzzZ8lW96X8KF4/gxyf64wMV1g
         NXYOIFExzxDxLSSG+OjAev7R/T5ecogE8MbmGC8gYfSgnOvghARkDsA5F3oH/0s+JSvq
         VVbgB3AcglkHRw74W44Cz36DAyWgoG20sXAO6s09UF5MmSxkUYmIBVFAy60VBKidEOCa
         v2FJAEdZojuskJ68Ie/v/vSsFgJ9TXho/WF5R0yVXE8ioI+4xwxr99y5wEsL5yzY1mzv
         tgXNotm/A3vJafy1sHV5/ox3ybOplEmzthSf7gX4UVWDgW1RA0uWvHp/0rFvS6ezJFBz
         Ennw==
X-Gm-Message-State: AElRT7FbY87jrTtE5WYWk64liLcJngRBCl6zo3GeBD0Sfvbm5IoSc5D8
        lWZ1nSlEWMlKzcYQKryv6Ck=
X-Google-Smtp-Source: AIpwx4/FZ55ptpTd/qg+sVOGixqhHe1CAqzsIWReafU1n/dybTpSvljzTkcIEokpSqYYUUq7GhNlzA==
X-Received: by 10.223.164.142 with SMTP id g14mr7696696wrb.18.1522711458049;
        Mon, 02 Apr 2018 16:24:18 -0700 (PDT)
Received: from darkstar.home ([2a00:23c1:ed80:4001:2f9f:42eb:2064:5ffa])
        by smtp.gmail.com with ESMTPSA id c141sm3756710wmh.21.2018.04.02.16.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 16:24:16 -0700 (PDT)
From:   Michal Nazarewicz <mina86@mina86.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Rappazzo <rappazzo@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Nazarewicz?= <mina86@mina86.com>
Subject: [PATCH] send-email: fix docs regarding storing password with git credential
Date:   Tue,  3 Apr 2018 00:23:48 +0100
Message-Id: <20180402232348.20293-1-mina86@mina86.com>
X-Mailer: git-send-email 2.17.0.1.ga3da07cdf
In-Reply-To: <xmqqk1tpxo0g.fsf@gitster-ct.c.googlers.com>
References: <xmqqk1tpxo0g.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, ‘git credential fill’ does not store credentials
but is used to *read* them.  The command which adds credentials
to the helper’s store is ‘git credential approve’.

Second of all, git-send-email will include port number in host
parameter when getting the password so it has to be set when
storing the password as well.

Apply the two above to fix the Gmail example in git-send-email
documentation.

Signed-off-by: Michał Nazarewicz <mina86@mina86.com>
---
 Documentation/git-send-email.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 71ef97ba9..172c7b344 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -477,13 +477,12 @@ https://security.google.com/settings/security/apppasswords to setup an
 app-specific password.  Once setup, you can store it with the credentials
 helper:
 
-	$ git credential fill
+	$ git credential approve
 	protocol=smtp
-	host=smtp.gmail.com
+	host=smtp.gmail.com:587
 	username=youname@gmail.com
 	password=app-password
 
-
 Once your commits are ready to be sent to the mailing list, run the
 following commands:
 
-- 
2.16.2

