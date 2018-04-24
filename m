Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748431F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755877AbeDXFIB (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:08:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34858 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755793AbeDXFHy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:07:54 -0400
Received: by mail-pf0-f195.google.com with SMTP id j5so11240609pfh.2
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s4fJssExTs+XbxSZy/Iob4denxci4B2d+18CM0kW3gE=;
        b=ltPVEADcth8YFCF4vXLwNPIep3EyafNWtl1F2JB0ut28hRKoGSXSIzvopbkKShfbIL
         6tdCYJU3LbrSBJLdfB8wqBlr1YDQx3KyAXe10M1+jSL96zdXMrooJ/3mqPISGfcJjW5K
         RDHqlVbr/0b2rLPfFIL/DutCaSFL+UeTLhiHcEsBEbsXPyTJkHp5hR7nKKSKzg2ZFsGJ
         wkT+q/iyzBP2CEVuf2IPUM2SOGBbiMDPir+kz7iBq39+OXsSa6DIuXPrnnKKckSgFiKn
         U+E8epBU1y6cBr6FRPmgCnSq2uu8g65x/hAal4R392pIit4TXx6z2eAvwXe4W0YLPgnj
         xzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s4fJssExTs+XbxSZy/Iob4denxci4B2d+18CM0kW3gE=;
        b=WrkwWvmZDXP7lXSs+IE8pg/0zOEchG0TYIAUynvK7edQfuKpbDVOOllZgyrktCQCxL
         HGu9wQa4qmpcKTK256y5L/HiuOyvvem6RSa8k0/H8jRiemA6op1vCOSiR0CIpqf7ObMc
         M/jBcGYVM5OdsS4NgD0pOdsj58J1btveHzNRxyoWvgBuBwqO0SGV8+vd6AvbWU2mwzef
         b+waIC+OrJZriduKwREklLLcyo9lWpt5vu3i7I1lzSyBwRtxbbbzoZHBOhUwThqYVFwK
         LrSqLgZo7cQpcxefnmguDEYIsiKBZ8WMVcLF1J1fSoNkMo941GhBqk+GoRsSafGgvSkP
         /t6g==
X-Gm-Message-State: ALQs6tAaRnfWEwNjLfunLupU9Uwuu55GD8b3wWdQ8OWzi9keengsAOFv
        PUPK9JPWNVuYUuH1Bl4zVi0PoRg529ww3A==
X-Google-Smtp-Source: AIpwx4/2J7W2WQ7EYC+lkNIsX/5ij85asze094vndzvuxxQlAg/JjZ5muuUDEHJ9SJqOlt6gusy0qQ==
X-Received: by 10.101.70.141 with SMTP id h13mr19269577pgr.166.1524546472933;
        Mon, 23 Apr 2018 22:07:52 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:3dfa:3e1b:ab89:1ffb])
        by smtp.gmail.com with ESMTPSA id v16sm20834428pfj.123.2018.04.23.22.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 22:07:51 -0700 (PDT)
Date:   Mon, 23 Apr 2018 22:07:51 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v3 7/7] contrib/git-jump/git-jump: jump to match column in
 addition to line
Message-ID: <23ea226b544e9e5fcdbbcda3adb5982e2cae2123.1524545768.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1524545768.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524545768.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take advantage of 'git-grep(1)''s new option, '--column-number' in order
to teach Peff's 'git-jump' script how to jump to the correct column for
any given match.

'git-grep(1)''s output is in the correct format for Vim's jump list, so
no additional cleanup is necessary.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 contrib/git-jump/git-jump | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 80ab0590bc..8bc57ea0f8 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -52,7 +52,7 @@ mode_merge() {
 # editor shows them to us in the status bar.
 mode_grep() {
 	cmd=$(git config jump.grepCmd)
-	test -n "$cmd" || cmd="git grep -n"
+	test -n "$cmd" || cmd="git grep -n --column-number"
 	$cmd "$@" |
 	perl -pe '
 	s/[ \t]+/ /g;
-- 
2.17.0
