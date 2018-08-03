Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD9D1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 22:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbeHDAWR (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 20:22:17 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:34741 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbeHDAWR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:22:17 -0400
Received: by mail-ua0-f201.google.com with SMTP id n10-v6so3662234uao.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 15:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=OhNEga/VStr53dmK0Dw/ELCeUIifcjZcAxIP2D/8su4=;
        b=jPrc6zd1HRh0ATc0zOtICU56EyyG0bhCe/i9T8E1LFM1gNKggRh+RnWT6tejSCNtSk
         gBAzIv85SEs6T258VJzL2+3h5s598deSHVCigXoVGb1XJj+nDl2pt4M2uWfz7gY1T2BC
         RjNPDjDnGlrKWnCvEWpg4klppAaOQI7lDoNp6dBXYr6m2/Tpl8DqoaWzdui+JJDQoHcp
         cZVEgl36nO8Vn+a6SJDy1SsS9yUvEY0Z+If26PguL3m2fOhsbMPxAdlz7V2WOveFiLMX
         aP3ZYTKwc4wAdYxrxxHzT9UfDcbRgz69StyuvXGH7VKyqG2I9NnpwFdap9rogjuzYFoj
         uzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=OhNEga/VStr53dmK0Dw/ELCeUIifcjZcAxIP2D/8su4=;
        b=mLxi5AtvQS3cya/EWwRir6ZFzUxndtPP3aSzki6dCY1SCSQEKKMIM2ZvAoLyww+P5w
         I32bbH7jQ6vBUCasYEuisucmFJnDONUniohWc+pI3zh90NDkoTHimyoMdc1dxOm/VVKw
         NsFXI0Mh8yHnU7dN7phHFKg2/OJgmr587FtXygUjodIhS5LCbpCO6hvTubbUeeOtmkG6
         H7ahrY88wSnzOPRwB4RZEZzwgzlSy0pdTcWRml5+vWGK9HXrdWwAu07PwKZEA4iLJUzz
         t9s/wUJxbhaeXy2cz7gpjIllILsyudCgVjlX/VZakrvtS4WK5RkgB5rl8q/FwIw8f30G
         AZMQ==
X-Gm-Message-State: AOUpUlEU7rolsD74yr+HKfhtt2aYzQCePyuYCeI7Ceq4iHuognQsS/9I
        SV8s8JDVLQ0smfpgzp9+cBikmk+VLjP2lo1AIIPAuH2jhp8OaBT9jQOaHVLqG5IMUeacEkJCgbV
        fhZu9WYxzTuijcJ0DWbSPAchHaPtmH8VsMimOLWQVpIH35KFKJDs8e4idfFfR
X-Google-Smtp-Source: AAOMgpe3I7FqWlMk6UDZ74Vt4wPoJ+kXJfSIzFHiAQhJf+HTTVHwDoPETz6UT5jsxDsbQQogBbdq2eA1IZd5
MIME-Version: 1.0
X-Received: by 2002:a1f:315:: with SMTP id 21-v6mr4538233vkd.121.1533335044185;
 Fri, 03 Aug 2018 15:24:04 -0700 (PDT)
Date:   Fri,  3 Aug 2018 15:23:16 -0700
In-Reply-To: <20180803222322.261813-1-sbeller@google.com>
Message-Id: <20180803222322.261813-2-sbeller@google.com>
References: <20180803222322.261813-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 1/7] git-submodule.sh: align error reporting for update mode
 to use path
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All other error messages in cmd_update are reporting the submodule based
on its path, so let's do that for invalid update modes, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8b5ad59bdee..5a58812645d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -632,7 +632,7 @@ cmd_update()
 				must_die_on_failure=yes
 				;;
 			*)
-				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
+				die "$(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
 			esac
 
 			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
-- 
2.18.0.132.g195c49a2227

