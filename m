Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6F520136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbdBPL3s (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:29:48 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34796 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbdBPL3r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:29:47 -0500
Received: by mail-lf0-f65.google.com with SMTP id q89so1221812lfi.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=euOXiLEhE9suU1JAwWjH9CevYHvAEts661bYWdxIQ6Q=;
        b=G+nal52AXFz6Dp60I7M9G23UywTOeU1sZsjqPkiM/V17vkuE1Abze5SmheKlSrcup8
         xi40bxP/d6WnbIPdoVSuNlLOtj7QxJnqYj3F7f2yh5Aba4AsDNVT3qbqbdsu8PjpOe+/
         DwMZQ1YQpAw6zPgF35CkmuRsRajk/laWN5o+bIC8ctzWh0hP9CVmH3xZEov/6dZhjCAp
         u3Fr1vl4zWnyI4zn+xMTdZTuf9jOQuh29WdB5Hx2dX38BfqZURHkyhJxp//U6hRMOtAA
         bLQ6LlihTnnn9okU1z2OaEZpMRxHNPthMvRl2rZ4v5rFkJAh7BrV8Vr420xK5/3uDOfi
         zAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=euOXiLEhE9suU1JAwWjH9CevYHvAEts661bYWdxIQ6Q=;
        b=pscwjqvM0K256JYsUDbZ9iE8OZXVVIymeXPt2sc8HXwDkQfPdLcCv20jdQUz5H/EJa
         drtB+HkTP1mjAINWo1ksuC0sY8v3EZBZn7ywOohH+1em9VLZjSvhni4e/e+WUX+cZka6
         DL86PGsEKkSU5W7ztdcR3Shqz2QpSho49citKb/XPpBYptGC1xIoxCNifTt7NY9ChxMX
         UOniNnWhd9nrFwOo+k9rtjSaCpMSqaas/F03oDjcCjyOrr/V5ODfhQHE4ApFhzVlPLqV
         cuk26mOtLXKel27VgVLBrGT8Zbe0Xzm3ov8RWruGhCz0CcftaWnquWupllEBbcoFMS4r
         RoKQ==
X-Gm-Message-State: AMke39kLMU2jYUOevdLD+80aBwlMC+xq+Vcy+GqHBp8U7hPWm+6WoOspAiZyJQ/WgPH4rg==
X-Received: by 10.46.0.218 with SMTP id e87mr501332lji.137.1487244585237;
        Thu, 16 Feb 2017 03:29:45 -0800 (PST)
Received: from localhost.localdomain ([193.106.40.78])
        by smtp.gmail.com with ESMTPSA id v3sm1641430ljd.65.2017.02.16.03.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:29:44 -0800 (PST)
From:   Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Subject: [PATCH 0/3] Fix l10n
Date:   Thu, 16 Feb 2017 14:28:26 +0300
Message-Id: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
X-Mailer: git-send-email 2.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some places static size buffers can't store formatted string.
If it be happen then git die.

Maxim Moseychuk (3):
  add git_psprintf helper function
  bisect_next_all: convert xsnprintf to git_psprintf
  stop_progress_msg: convert xsnprintf to git_psprintf

 bisect.c          |  9 +++++----
 git-compat-util.h |  3 +++
 progress.c        |  9 +++------
 wrapper.c         | 19 +++++++++++++++++++
 4 files changed, 30 insertions(+), 10 deletions(-)

-- 
2.11.1

