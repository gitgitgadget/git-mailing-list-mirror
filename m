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
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C481F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 20:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKNUrR (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 15:47:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39637 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfKNUrR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 15:47:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id 29so4538775pgm.6
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 12:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JCjPAi4pTdTjrXh49eZfKac5Xftf+HEH2raLbYQUllk=;
        b=CWJv6ilfPuXweD3PVJVq1fwkLDQYhX0a530vZAKpENXrc5uLV+dsjAPOtar1Pg7OoJ
         rHiiHWv188K04AM+q+rm9FTFjxxaPCcKJV5lR+Pz+gKAotz5trWBnzB+BsN2lojmWVJ4
         omEiROYS+ayG03vS7FfW3yFBSXU/cBTTuB+xqKM932E9gd5B6zz2kTp+yfnIV2a4i0e4
         hhIcWODBiTrS7O+k9pCiQ6uHnuscnWeMzg4KnbsH2QkVvxr+ArlBho/jFL/aV3d4pe87
         +g+PH+0QvJ09WiFTEPbF9TvYtCvFlEkbBB75AnZ0BUg8pmfT78SfWlNqHPet1P7Fclks
         ePHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JCjPAi4pTdTjrXh49eZfKac5Xftf+HEH2raLbYQUllk=;
        b=fIIfEmxs363KaaC2pX98rJq6pZpCmB7bbsBrHzJyVDEUZuhIDwrGL8xuY/MOsAUrrr
         vAJ07SP9Gy3LUKKTp1XlntLdEiXo0v+0sfDRPSKb73tmX3lETiugCHJvcJH47cKNjcMr
         zEB7U03esqusII1WFLKQ35ljAt45rTrGXTLEmfHbAiImHqWLTPw7yR0JunkV/WQ3v2JC
         n1fGZC7PvYGcmQ2aU0ro5nmRN2qFcYOIq4t1xwZqowzCjs85iCr4y/eZ51A6FXUcbAf9
         rIircbrfBMK62AnX2Q3sh6tLwWxxoGu20OahIMKcPu6tX3Y24dgSnrFKguSlZY+1blxJ
         hmKQ==
X-Gm-Message-State: APjAAAXtwnH69Whc9L00Jeii99A5yv5Us//XCfjbjQNvFm66JgHLJgXy
        fMu1gRKJZirYx0e4eMhvo4xl9zHa
X-Google-Smtp-Source: APXvYqxbCSTMtIE2dXWCddaFcsU41zsC2QbK7ZVB3TMZmuvVEv/plfIsIOBH5dyW9LlXcjiTOf+yWQ==
X-Received: by 2002:a62:82c1:: with SMTP id w184mr13282657pfd.134.1573764436681;
        Thu, 14 Nov 2019 12:47:16 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id p123sm8057255pfg.30.2019.11.14.12.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:47:16 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:47:14 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 04/10] completion: complete `tformat:` pretty format
Message-ID: <442394eca88e6e355f435135ddc9a1349d121250.1573764280.git.liu.denton@gmail.com>
References: <cover.1573241590.git.liu.denton@gmail.com>
 <cover.1573764280.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573764280.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 00fbe6c03d..557d0373c3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1749,7 +1749,7 @@ __git_log_shortlog_options="
 	--all-match --invert-grep
 "
 
-__git_log_pretty_formats="oneline short medium full fuller email raw format: mboxrd"
+__git_log_pretty_formats="oneline short medium full fuller email raw format: tformat: mboxrd"
 __git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default raw unix format:"
 
 _git_log ()
-- 
2.24.0.346.gee0de6d492

