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
	by dcvr.yhbt.net (Postfix) with ESMTP id 018871F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKOBBB (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34686 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfKOBBA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id z188so4905834pgb.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d52BVKZc/Nha/9ErbijJvvRcy8PWmhgWxHG7MHn6dN8=;
        b=FmfPFlXUOwWBVEnYTJZSjFIul68QHwvtI4tiwIb8ArYAWTvZNJUyCN0WGKG8pyktgG
         goUs0Y3mlkMVKIG7ofCFfyrSC4KcOufPMkIXAwOi51Dv83mp3gg1rF2lnVswJwtX2Pp3
         qonfaifq3iPWPbHvgKdvrAfVssBD88ZaDLP0i3YegIoAEP5DHZD1WpJAPeqGbQhwwqGD
         v7FQiaegq/oh1OqRniIa5jfBzUKykuKDebMkZKJ1ihwWFg+3JPT+BcQUcn37Eryty6dB
         6cPVQj0LGPoRfYdflEd/3KJleSeKv41lEwDDQdNKmSkudlu4k+6KlpAko34i+D32iXHx
         mv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d52BVKZc/Nha/9ErbijJvvRcy8PWmhgWxHG7MHn6dN8=;
        b=e3WpHBw/wsCQ2YUpaPXdqcYvSC/O4rm04kp6C66EAVhFwPF2bFjbeD/azyrgT//mqY
         lk5xBbDZ+3ZEWs8ZFEWDoQhF0FggQU3QPRZXgiYg3yDgC9cbzNHGnrc2lWFUTotZ8HG+
         Z2bOIso1fClBODkuAfqnZX/5aiAY57WCbhZ2flDtN7+rrd/oNHDLcJoRFf4c35KdPJBk
         ewA7wv+CIBgiMYplg3el1lV1NK4fKRnPrsktkwnwTyG9C8QqhyEPW2FntVwZ36c0PfAh
         uGNIUcy3kL4xzEeyYMEGGL+c8R8avpFTwPcif/KqpKwLzeCEsFmM3/1x3Inc/lGe6ca0
         vj3w==
X-Gm-Message-State: APjAAAVnmfn8eRdUg1FuzorAgdL4aqSd4PRHeH+O+96BkpF7VIGxL8qT
        GiZuVVLe1laSaEJYfz6smkZXOt7c
X-Google-Smtp-Source: APXvYqwL8+tyYmQqxNcNePdkvaKn0lZxNtoNPPAHBR/bSaW9lgoGVotdLXzq/k1969+s/dOh9UI0iA==
X-Received: by 2002:a62:83c8:: with SMTP id h191mr4379798pfe.118.1573779659322;
        Thu, 14 Nov 2019 17:00:59 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id y4sm7529157pgy.27.2019.11.14.17.00.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:00:58 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:00:57 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 11/27] t5317: stop losing return codes of git commands
Message-ID: <105f0a7a873fce4c741ffdb7bfa458a85311ac79.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there are two ways where the return codes of git commands are
lost. The first way is when a command is in the upstream of a pipe. In a
pipe, only the return code of the last command is used. Thus, all other
commands will have their return codes masked. Rewrite pipes so that
there are no git commands upstream.

The other way is when a command is in a non-assignment command
substitution. The return code will be lost in favour of the surrounding
command's. Rewrite instances of this such that git commands output to a
file and surrounding commands only call command substitutions with
non-git commands.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5317-pack-objects-filter-objects.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 2d2f5d0229..a8bbad74e2 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -72,7 +72,8 @@ test_expect_success 'get an error for missing tree object' '
 	echo foo >r5/foo &&
 	git -C r5 add foo &&
 	git -C r5 commit -m "foo" &&
-	del=$(git -C r5 rev-parse HEAD^{tree} | sed "s|..|&/|") &&
+	git -C r5 rev-parse HEAD^{tree} >tree &&
+	del=$(sed "s|..|&/|" tree) &&
 	rm r5/.git/objects/$del &&
 	test_must_fail git -C r5 pack-objects --revs --stdout 2>bad_tree <<-EOF &&
 	HEAD
@@ -230,10 +231,9 @@ test_expect_success 'verify explicitly specifying oversized blob in input' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
-	HEAD
-	$(git -C r2 rev-parse HEAD:large.10000)
-	EOF
+	echo HEAD >objects &&
+	git -C r2 rev-parse HEAD:large.10000 >>objects &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k <objects >filter.pack &&
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
@@ -377,7 +377,8 @@ test_expect_success 'verify sparse:oid=OID' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	oid=$(git -C r4 ls-files -s pattern | awk -f print_2.awk) &&
+	git -C r4 ls-files -s pattern >staged &&
+	oid=$(awk -f print_2.awk staged) &&
 	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
 	HEAD
 	EOF
-- 
2.24.0.399.gf8350c9437

