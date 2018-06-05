Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 059BB1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 21:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeFEVQn (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 17:16:43 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45302 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbeFEVQm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 17:16:42 -0400
Received: by mail-pg0-f66.google.com with SMTP id z1-v6so1833867pgv.12
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r0vSmuJGpIM6/S3/GUOcxuAFpqdKGNI2XTFjSpM+tRA=;
        b=K1IyTzdg2suHBqgIuylcTjAhwc6AohQYpVxlyMdGbSZ8io8Ls4ueuC4MlVZALIwaLW
         ULGmAcxawZzmA/zYCXlvWGx708oS4FT4L2VM3zsYoLF4f9GX0V54RuvRaC/Y4C8d0CfE
         M0PVHRn/qHXWur1ITT0ezK8SsceKgLRIoCdoSnt991T+TIqQocy3ZW+s7Mb6Ay6OHelH
         dp5y92X7cJ0lKPumdjgpnCMiNGrQ2dfAUa9bMbXA5UBR59+2y5VUBXtb7dUmhfrifBQ9
         mzTWayenyrDUB/njDilcmrE03jUZDDcg+t474iE8cbp8UIhjJe0nv/xBUyKC7kjNqL5P
         DzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r0vSmuJGpIM6/S3/GUOcxuAFpqdKGNI2XTFjSpM+tRA=;
        b=IbIJqUuFfzKiS4W0verfZRlwiKsyjaYHKkDdlcx3wypmcJ6l58fDHIwmFe6+ZgfXnY
         rJhDlcN4DcJ6JTJoIqSTt0PLaTrldWkQ9XIr53MzpyBJ0vjKCF8jXG5KQooHEcti3xOT
         KJXClQLoNGRfS7Kql67KkUy59aUxdheIS9PeV9/k/MgF87jfT/5e8NX1EXH6DCTOHzhJ
         tBtC6HZAelsL0VLsilL86zp/SXCB/8nBhgZtTE8ToO/7w8kAuhzYd5lISuCL7B7Zml9R
         amvEjeJaGRa7Okw1joalGZJaQcNbU9T4E2GP2ucvQ5zEn1m4De0cLPzJiI8fCy4wPcaR
         7NhA==
X-Gm-Message-State: APt69E1WVmbtOkkFmxfodVWBZlxn9kImy4HPDfUH4Hq/en50rEu94cDP
        KExZr310I+z6LzhdGRruhaZz2uO40Uo=
X-Google-Smtp-Source: ADUXVKJySos3kqNYFaOgqvHIIkEnhRtUjYjPHXUoRDbFVU/YHn1fIHzIUZ4wrSTCTTh48ho6tZePvw==
X-Received: by 2002:a62:18a:: with SMTP id 132-v6mr271227pfb.62.1528233401125;
        Tue, 05 Jun 2018 14:16:41 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id b15-v6sm76641614pfi.144.2018.06.05.14.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 14:16:39 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com
Subject: [PATCH 0/2] Fix protocol v2 tag following with CLI refspec
Date:   Tue,  5 Jun 2018 14:16:33 -0700
Message-Id: <cover.1528233146.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the events that led up to Jonathan Nieder's patch fixing fetch by
SHA-1 in protocol v2 [1], while expanding protocol v2's test coverage, I
found a bug with tag following. Patch 2 is a patch that fixes that bug
(and patch 1 is a related but independent test that I had written
beforehand).

[1] https://public-inbox.org/git/20180531072339.GA43435@aiede.svl.corp.google.com/

Jonathan Tan (2):
  t5702: test fetch with multiple refspecs at a time
  fetch: send "refs/tags/" prefix upon CLI refspecs

 builtin/fetch.c        |  2 +-
 t/t5702-protocol-v2.sh | 65 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.17.0.768.g1526ddbba1.dirty

