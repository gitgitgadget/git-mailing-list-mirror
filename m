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
	by dcvr.yhbt.net (Postfix) with ESMTP id 035971F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfH0Epm (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:45:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43023 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0Epm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:45:42 -0400
Received: by mail-io1-f68.google.com with SMTP id 18so43123913ioe.10
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kKoezlPeroE0lOvzpwrLCwn9Zih3h/izUPPa722c01U=;
        b=Dw0dwNyfXo7b4ijdTuvLvrDKjPG1bnGj7XvHPI2pWIjI+DFjRbQ+3AFU8r11/SGUhK
         p6r5dQlqMfAEtkfOhsmhKzz8wS57ovUPoDkhTVOdOE6Jpb3YEiKGvooAxqXaAT8464o5
         LzjyP2EHHzr5zdKaz0lVQbuubeWZEdndCLt75oGwoQ3zENQRR1+o6xxStm9my+uZYlKt
         hdJjH0geXLWoLgudHmROjpxvGbZpRTM4sk9CTL6bEWu8KBfRtISG5AN/nT+k9mVa/75l
         mnksBQzinXjqfQuOp4v5xnKhtzc1BzcFYEMXpgt/2/g0DbKHoNzSrQ5GJgLspy8LNlup
         d2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kKoezlPeroE0lOvzpwrLCwn9Zih3h/izUPPa722c01U=;
        b=LvcVWR1UGJiK5JdiHed54KPvweaPrgw9poHvoDcZlD4uXJqdfURU3J2B4kUyJUe9Ls
         ZbR7F+xxYIcBKTMEM4jgBQCXTBdqvdFF3yjUG3tOf/WobxqkqRbn4HkEPwL4PCCgy9CA
         S//5mQn2wc90piOxwSOZcTtLCioWQR8Jq+kEOH4MrAaHQhOGJIdzKtFT7WVrZy6UbaC+
         ZIzIKzmRpgp3jzBu2bYwVlAoeYBvA2jbtanG14OksyYWKsy2/S1i5BAoKgIMsSMU2RL0
         gwco+cbv3mIUnl4LFYQGYgSHnYbRErMRc8yCxpXMxFk6IB7BmGikrLSE3cbmRkZF9IHk
         ywkA==
X-Gm-Message-State: APjAAAWxeZcH9eo5EawjtgAdbeMXPk30CrXTUbm9sadoBdsfFTmRDaEs
        /IX4JHkY3lqzvu/JULriOFBdLdfd
X-Google-Smtp-Source: APXvYqzkboqx5iv7RD38IOlpx83TyCQMTjDjKtMl+hwYIQsOY59vV/eU/XGnzJIy/YR3987BOVN3GQ==
X-Received: by 2002:a5e:9917:: with SMTP id t23mr1698338ioj.23.1566881141464;
        Mon, 26 Aug 2019 21:45:41 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id y25sm23166987iol.59.2019.08.26.21.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:45:41 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:45:39 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] completion: add --skip for cherry-pick and revert
Message-ID: <c83feb3d6e15ee4666310aa0ac94596faec56d94.1566880835.git.liu.denton@gmail.com>
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

Even though `--skip` is a valid command-line option for cherry-pick and
revert while they are in progress, it is not completed. Add this missing
option to the completion script.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a7d3f58627..b4651411b2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1361,7 +1361,7 @@ _git_checkout ()
 	esac
 }
 
-__git_sequencer_inprogress_options="--continue --quit --abort"
+__git_sequencer_inprogress_options="--continue --quit --abort --skip"
 
 __git_cherry_pick_inprogress_options=$__git_sequencer_inprogress_options
 
-- 
2.23.0.248.g3a9dd8fb08

