Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D7801F404
	for <e@80x24.org>; Sat, 21 Apr 2018 03:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeDUDps (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 23:45:48 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34389 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeDUDpr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 23:45:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id q9so5088621pff.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 20:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y5sGpXFe7gC+wDxoTkkbKnDPrkVOfFJT7S5xCazQmiY=;
        b=T3r2w5zX2oJmS0mck0wG1jcRaQpNEre+JLubfTcEdaoGMW2GcVjYDx5rrBZImeLdXM
         IhfITZZHZUyDjX/hV61U89tn23XaKW3pVc5i0XK3TWvy7i0VZTxSw1kAK+83dcQwShry
         hY/Hd2Fz79bb8M+7MbkNGWceDVmyZMAns8MWjJWSSeJ9NZA0P/YWJDP07GF4tssdqewc
         4hoNcuLT7Ry1913NYodM5VHrbbpq25W5MzT1F54tohXa/L1dGwRGZNrJuLKsoodlPxuu
         a0NLeZ05K+o5JiiTHuTI6qIIjTl8MdzlV1zIj4AyjOJtNOlId58vKvQQnZriH0GbD0oB
         BRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y5sGpXFe7gC+wDxoTkkbKnDPrkVOfFJT7S5xCazQmiY=;
        b=EiO5zyfYv5G/qax4Guhj6Uw0qmLV+15Of56UfyTZHXGbTdBh3wYQn4beE5ZLBIspFX
         0K4MV+ksp6zpGZElYCtWF52R4hedziF3VjwAAa5tp54FM9McwKw4F8mhv/JiYBcMnaiH
         c08ekFQ/mjSgOuymf9BIPN/PPvDRvCl4tYTYfJO4OoIXcbfW/ewXDb9+IWVkgojoYTMp
         ThaVpgt+X0JWzgpDAnk2RJfDgFS+SUPug51fSjtLTKCKRjO9fnJ3h/9LJi9qfkbrxUfB
         M6artConD1cePPzPZoOVkROUL4WfFU43LRl+9DZO5aHUu2oGrJ4OPIfHjiRympOoWbBX
         ro0A==
X-Gm-Message-State: ALQs6tBPE0AmPjXAtTpUUuHEJbgcNZ6iClCXTay4QVReU0hGvQ4eSZen
        WQAJ7bM/nyNg9tC0aWvShMI1fYkKURU=
X-Google-Smtp-Source: AIpwx49NILcg85bnPkdX2hsG080BqO50riyQC5yTXqfK1IWsTCSX93jgLUB4JZGrInu7LWRnmo9lbQ==
X-Received: by 10.99.103.131 with SMTP id b125mr10100014pgc.177.1524282345699;
        Fri, 20 Apr 2018 20:45:45 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:ddb8:3db2:8ad2:955])
        by smtp.gmail.com with ESMTPSA id l3sm15255057pfg.49.2018.04.20.20.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Apr 2018 20:45:44 -0700 (PDT)
Date:   Fri, 20 Apr 2018 20:45:43 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, peff@peff.net
Subject: [PATCH 6/6] contrib/git-jump/git-jump: use column number when
 grep-ing
Message-ID: <20180421034543.GG24606@syl.local>
References: <cover.1524281843.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524281843.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds the '--column-number' synonym '-m' to the default
grep command so that callers are brought to the correct line _and_
column of each matched location.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 contrib/git-jump/git-jump | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 80ab0590bc..2706963690 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -52,7 +52,7 @@ mode_merge() {
 # editor shows them to us in the status bar.
 mode_grep() {
 	cmd=$(git config jump.grepCmd)
-	test -n "$cmd" || cmd="git grep -n"
+	test -n "$cmd" || cmd="git grep -n -m"
 	$cmd "$@" |
 	perl -pe '
 	s/[ \t]+/ /g;
-- 
2.17.0
