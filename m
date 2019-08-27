Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 470E21F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfH0Epk (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:45:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40241 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0Epk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:45:40 -0400
Received: by mail-io1-f67.google.com with SMTP id t6so43212954ios.7
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7GYwZSmNkJA7qLEr5X341A9jJ/weY7cRYvFm1vBdq20=;
        b=N+Ku5aAdWuvmXxZnIu6HzYoK2ALk4a1JrOwj55BgOUqoUQ/wUVVZu+63kC4+lvIM4j
         A710ki7QQjvzm5zoBlo27IepbTI54+G0UUbI8ArH7Hl5w7c7jZ3driw5RA+1FcPFoVzz
         uMyN6T0TBayb8idvMNCnQTxjJTsgnNwMrRTu8n2Sl8K3h3ZBgZy8ykTNFOVvWkKgz5hG
         GEXAWii6Po3UVwfnnMt4FX3KNXmGjyWoTylEVcExgmTh+9jGyGvWLL8YM8iKI2771TSf
         l7JoNns5E8CZot6Bi5sm18z/C8s8Dpd9i4xjXuGJXP2ZdjmdWMERaHkpQrxt4vOSrhhR
         /jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7GYwZSmNkJA7qLEr5X341A9jJ/weY7cRYvFm1vBdq20=;
        b=P/rLLJlT9Jjq0Bfmh0da4xOo8SOkxY9na+sJQjyPYsSQETQKE1cout0GjKcsgaOcLz
         7s1r9BjWoGSAqVUMeHfMMW5W7YkbfDHfSXRAuZMWdpGWGxKAHVMhSA0NVBym81Cf6mKy
         HDbZuZyWl9KeBUGDYLFMPcCYwPbuKCzASBe3RCchz7unp38B4Z14/IW4DSX3pVhyFtLM
         9XHBxtw9o45d9cvxkAhYcixA/LFbnZtqOCp6pzVdR9EHlnUmd7H0hKrsZCBX+/AyxkIX
         t5jS2ju3FYtku/l2ns1ItxIpg+EyPOtCvZP6Kr4G74kxd1v83Z/edQC9sddYN6xKb6KB
         qyeg==
X-Gm-Message-State: APjAAAWlxx+EdvxtH8fxl3zAmnShONyysf/5DJl1oRTMFzYfnhD3rfBj
        QkESnVrQDYe7txcNS4VdlqBnJRxS
X-Google-Smtp-Source: APXvYqxHEqpY1EoSrMKilptB3gCFpsuJrBgPcQM7QmPkyekbxi4zRxomG3jt2ww/a9lGuwdBofMhtg==
X-Received: by 2002:a02:a11e:: with SMTP id f30mr21536358jag.0.1566881139045;
        Mon, 26 Aug 2019 21:45:39 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id s6sm11259023ioe.6.2019.08.26.21.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:45:38 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:45:36 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] completion: merge options for cherry-pick and revert
Message-ID: <862802366ab2dc636614b737bbb5d4fe26dba9e4.1566880835.git.liu.denton@gmail.com>
References: <cover.1566637431.git.liu.denton@gmail.com>
 <cover.1566880835.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566880835.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since revert and cherry-pick share the same sequencer code, they should
both accept the same command-line options. Derive the
`__git_cherry_pick_inprogress_options` and
`__git_revert_inprogress_options` variables from
`__git_sequencer_inprogress_options` so that the options aren't
unnecessarily duplicated twice.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e087c4bf00..a7d3f58627 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1361,7 +1361,9 @@ _git_checkout ()
 	esac
 }
 
-__git_cherry_pick_inprogress_options="--continue --quit --abort"
+__git_sequencer_inprogress_options="--continue --quit --abort"
+
+__git_cherry_pick_inprogress_options=$__git_sequencer_inprogress_options
 
 _git_cherry_pick ()
 {
@@ -2512,7 +2514,7 @@ _git_restore ()
 	esac
 }
 
-__git_revert_inprogress_options="--continue --quit --abort"
+__git_revert_inprogress_options=$__git_sequencer_inprogress_options
 
 _git_revert ()
 {
-- 
2.23.0.248.g3a9dd8fb08

