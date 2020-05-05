Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DF6C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DAB9206B9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMvFiM1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgEEBjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgEEBjd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:39:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD76C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:39:31 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n11so289916pgl.9
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qcvYbAr3gQ5JwMYeumif0xq6Sys7qk0J/L7yvcuMzug=;
        b=tMvFiM1b25LWcLk5yRfErXy2kIvheFMHNdb2vGGQm0hgpxMXBpB5qsx3FvrQqBg4Gp
         vpAFjsePs/0qJD6Va1mH+Ol+LD4mVwp3WU+0/Dos9oVhe9IxzWZ2JvQXRTTjQ4sR/5XR
         T+eZOizBbAtkxHHHPuZFXj5/RaskGK3OLZbMC3AQtWpxMJXZ+qKHePWH0MSdyZo9BOXq
         2eRQWlV1gxHvCBI6Hhg8mVCj3G+5alz+CWVdOH38eAaCb15hqrP+YOkhg20g+HEiKPQ6
         rr4HZpGmqfoJQ7VcwSZ2Ubwyr97Hst5fM3qIklvIm2lesOXWpsqvlgmKoeCRjFnYgD8r
         slsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcvYbAr3gQ5JwMYeumif0xq6Sys7qk0J/L7yvcuMzug=;
        b=rQTSwmrgPuRTgqCjnfscLSE2uR40x1w08cAyQLtiFu8LxIlZMoUIlIj+f5og+5gWQ+
         NPtVqfWcP8OtccRgFWPoCBatE/h9uRJiFkokn+1WoxSW7yb3fh2xLDCqrTOBoO8wSZtc
         HcE7ykHrdRVduRBo1b/VaEmr2gP8tPN0XwmeoSwbold8G6vI36Nwm6OU2aeygvl26ETB
         0vo6xuDmAqn6FTu07QPTntjcsFzivVvRA9R3qMV+xlrqJ+Gn8eEMYsXrCER0oA4C0iZ4
         sH0gRQzlPdZjI5xK2lFujuII9FRpu/0gGCQwBtCH3UOuufb0YWYeHVoZhIJyWKkKwbUo
         /SPQ==
X-Gm-Message-State: AGi0PuZO6xQjD8o6ztcGrHMGwZazRMA0eiV4gExQsC7WkOfPo+KfHxRq
        pnSSGM7xtYVacRU5GfexskeMzXnN
X-Google-Smtp-Source: APiQypIipgg8XYQde8iHzTeiAT5xDEayl7zawX9fOMIB35Hc1WMrnVhGysHi8CFjei+KePKcsgd1MA==
X-Received: by 2002:a63:180a:: with SMTP id y10mr1058016pgl.204.1588642770906;
        Mon, 04 May 2020 18:39:30 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e196sm352027pfh.43.2020.05.04.18.39.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 18:39:30 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/4] credential: documentation updates for maint
Date:   Mon,  4 May 2020 18:39:04 -0700
Message-Id: <20200505013908.4596-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
In-Reply-To: <20200503063423.83152-1-carenas@gmail.com>
References: <20200503063423.83152-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

in line with Jonathan's wishlist for a 2.26.3[1] release, the
following changes address minimal code changes related to the latest
updates as well to documentation changes that would guide helpers to
adjust to the updated credential subsystem.

[1] https://lore.kernel.org/git/20200428055514.GB201501@google.com/

Carlo Marcelo Arenas Belón (4):
  credential: update description for credential_from_url_gently
  credential: correct order of parameters for credential_match
  credential: update gitcredentials documentation
  credential: document protocol updates

 Documentation/git-credential.txt | 20 ++++++++++++--------
 Documentation/gitcredentials.txt | 26 ++++++++++++++++++--------
 credential.h                     |  8 ++++----
 3 files changed, 34 insertions(+), 20 deletions(-)

-- 
2.26.2.686.gfaf46a9ccd

