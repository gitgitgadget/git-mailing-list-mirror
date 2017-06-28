Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A1D20209
	for <e@80x24.org>; Wed, 28 Jun 2017 00:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbdF1A47 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 20:56:59 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34377 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbdF1A46 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 20:56:58 -0400
Received: by mail-pg0-f42.google.com with SMTP id t186so23604247pgb.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 17:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2dJi3qhJrWKjlnVugP9ubWGR4WW3E30ZrSk+yZ1y1Jk=;
        b=jCfz+fTeNFtjBNFe/ym+U8+7xlz4a5dHY8z6ImOmFbXkw1tjm2z7CjQym0bNNaMvu9
         nbjwLyyg3g7EjnWZV9jiic1E/bu7+MjGluziOm6sdmLFC7J5eLxnqzD27lecyP4YyP6u
         yy2uihFbFEglS4oNURYT0I1GN2i+NYvd9EWjyu7OL6BhgGTJCJFD57ArUoWnPujszGHa
         OQCVAQR09/8MttkI0l/ENn8Umq3obpzao1iud6CZWudrRg/NH+7KdTchXwKqpjLBNiw8
         Vtsl+LQBsSz1G9FNSNPvETdVELKE4OE3Q037BWGh3WsGCKvaABLirTfOPuBkVLpvT+Cm
         3iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2dJi3qhJrWKjlnVugP9ubWGR4WW3E30ZrSk+yZ1y1Jk=;
        b=fjaoig9eWq4ToNHpZcU+emi7oVgZEI1iUcbXR3rfqYqguq4I+blP9M4RgMD7oRarup
         gqrSJXmVQklIIUusbhM2AMMGcpo7vjmktIvTIDEYihMnKM7UJNDuyyasdB2r2E11noTg
         qgBCSWevzZX+sB83vsCln3i1hvhBDtj0WoS9oitSUSW/wwkLOmnpO5bIKuPRT4G1p+VR
         81dkoAJ6+jnAHOLEk5lq6erEw4wGLPiN1lKuJn5BGe9S6dA6zax3Cb7qwjt0GJkjGP/C
         X3XUuFkBm2TPfP4wqoKCFXYXLo+mR860D6tFHU/6XvsPxliNW4xEskPM/Moitkh1wG75
         IG0A==
X-Gm-Message-State: AKS2vOzCKXUrQvsy56ElqIt+Z5W56wjliT+rcgA0PAJVbimtgukJn6NM
        QE9OukNT2jceKjib
X-Received: by 10.84.217.25 with SMTP id o25mr8604218pli.299.1498611418148;
        Tue, 27 Jun 2017 17:56:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ac62:ae13:b066:f242])
        by smtp.gmail.com with ESMTPSA id b85sm818040pfe.94.2017.06.27.17.56.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 17:56:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/6] Fixing up sb/diff-color-moved
Date:   Tue, 27 Jun 2017 17:56:45 -0700
Message-Id: <20170628005651.8110-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This goes on top of sb/diff-color-moved.

Each patch is written as if it can go in as a normal patch,
but I intend to squash them into the series appropriately if
there is more feedback on that series in general.

Stefan Beller (6):
  diff.c: factor out shrinking of potential moved line blocks
  diff.c: change the default for move coloring to zebra
  diff.c: better reporting on color.moved bogus configuration
  Documentation/diff: reword color moved
  diff.c: omit uninteresting moved lines
  diff.c: detect blocks despite whitespace changes

 Documentation/config.txt       |  6 ++--
 Documentation/diff-options.txt | 10 ++++--
 diff.c                         | 79 ++++++++++++++++++++++++++++--------------
 diff.h                         |  2 ++
 t/t4015-diff-whitespace.sh     | 65 ++++++++++++++++++++++++++++++++++
 5 files changed, 131 insertions(+), 31 deletions(-)

-- 
2.13.0.31.g9b732c453e

