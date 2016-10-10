Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3A2D20989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbcJJR5T (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:57:19 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33582 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbcJJR5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:57:17 -0400
Received: by mail-pa0-f53.google.com with SMTP id vu5so20910793pab.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=psTDTiMOvMdhKqwDPopaMKKK1G9HC+deJacE2w/n8aE=;
        b=JY7XW6wcnGujTQH1b/EUh/oTBHMUAVRgPLE/44o9WRgE2jlLnAXCWUMHzZVp0tQADM
         XVkFR5caUTOj8qe8FaAYtWQIr8UHz/6PWOAFyaccoe+YRVRLMV7BcAGkQjvWFfWZXzC9
         Z+c1X2pmU6+p1/KorWdBl2nNSP+zFLhtwmZMxt+i4aoFwOJ4Bod0eEI9IV0Sx70QIq+p
         NCPhkgnva/POPhC/3iCPg3VQGd4YbCEUNTKQCniELq1PKHAW4ATjA1FrKG2kzZWCqC7X
         qB2lOw3fW0GS7RLxGSE7udhNWgia/P/+m4U7Yz3pIvTz2xadWpx+b5L4U9FG3uuhXLXG
         ygqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=psTDTiMOvMdhKqwDPopaMKKK1G9HC+deJacE2w/n8aE=;
        b=laa4SUtgd+1fH0XyuvagrX/X4hbNRz5VbV29zt4hAvjaa9fy1fymwyhsnFsTPPtgxw
         P4XTmuFuiqOuVLNRe5FkDov2Gc9OCrvPk3Vrgqfg9MUATVl7OU+dhg+7P5nBe6U7vmZ3
         9BHCyfwea8NXaLh3yVlj0UQnn6gNfBtgCpOW3QzxQgMEImiLJjjtq5P0A4boM6TzhtwV
         uXoOnyxO0Mxbc3GG0TYuU3OKsUuglW4Z3/FUm33nITXXQoMxmRNGoIoofIt5wQTg5KSO
         D461fRKHWHcTZG0Y/NW20FPtsveho1IdEhZPd3vSXFElkIvUJEz/Q410iPkp2CR5JVf0
         4Rzg==
X-Gm-Message-State: AA6/9Rldj+bXf+8JQNG9LJ8C0WaspD6FagQ3SLuwQuE3qFBSGJe4RgXB/cBTZzU31tDUbOx0
X-Received: by 10.66.55.9 with SMTP id n9mr55563910pap.153.1476122178977;
        Mon, 10 Oct 2016 10:56:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id fi6sm61495912pac.20.2016.10.10.10.56.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 10:56:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, venv21@gmail.com, dennis@kaarsemaker.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule: ignore trailing slash in relative url
Date:   Mon, 10 Oct 2016 10:56:11 -0700
Message-Id: <20161010175611.1058-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161010175611.1058-1-sbeller@google.com>
References: <20161010175611.1058-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to the previous patch, though no user reported a bug and
I could not find a regressive behavior.

However it is a good thing to be strict on the output and for that we
always omit a trailing slash.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 2 ++
 t/t0060-path-utils.sh       | 1 +
 2 files changed, 3 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a7841a5..260f46f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -149,6 +149,8 @@ static char *relative_url(const char *remote_url,
 	}
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
+	if (ends_with(url, "/"))
+		strbuf_setlen(&sb, sb.len - 1);
 	free(remoteurl);
 
 	if (starts_with_dot_slash(sb.buf))
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 82b98f8..25b48e5 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -319,6 +319,7 @@ test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/submodule"
 test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
 
 test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../foo/sub/a/b/c"
+test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c/" "../foo/sub/a/b/c"
 test_submodule_relative_url "(null)" "../foo/bar/" "../sub/a/b/c" "../foo/sub/a/b/c"
 test_submodule_relative_url "(null)" "../foo/bar" "../submodule" "../foo/submodule"
 test_submodule_relative_url "(null)" "../foo/submodule" "../submodule" "../foo/submodule"
-- 
2.10.1.382.ga23ca1b.dirty

