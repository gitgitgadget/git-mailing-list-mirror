Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2B151F403
	for <e@80x24.org>; Thu, 14 Jun 2018 22:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965016AbeFNWyd (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 18:54:33 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:33738 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964987AbeFNWyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 18:54:32 -0400
Received: by mail-vk0-f74.google.com with SMTP id s185-v6so2995297vke.0
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 15:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=t+Kw/LYhpAbTi50tinYi88RQg08+o99ieq1uwDz33Rk=;
        b=PilodnOSzjELduLtDXGcux3UZcAc2j9Bf/KuPrCkXEgCuhmSA7fYlqmx+5bSGOLuuL
         hDH2uXn2sEqOBlnjar4AyUin80QCUCbQ5GhdIu/2pJ3/6AUEVGL0KFXvWZbnzRO2dhnA
         gWLa9qhDjjJfEoOnKjFOR/dY9yCf4ULeGG3nfge5X6oEy41RhW5Iv7uO8M8V0oB7D/w4
         n+VPRmQ/OKeK0zNic3mfs2kIciVH7fcC+VoASyi3bqqfYUAWUn5p0SVBRcrLiZtt/5ix
         AMvI+rKx0eju2aCqWfQ1RnxX7wYKaWt7r8xcT3rXVOXpQpQRzwAuroTdVPErE5WxIocp
         z+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=t+Kw/LYhpAbTi50tinYi88RQg08+o99ieq1uwDz33Rk=;
        b=JZWVyrFKy5cBcCjiMQ+YIm0AR2WiCaobkvkGqXADDM6jp5vvQ6ldvsvcj+9rYr4lEA
         bFS4RpfcakaR1wGSUhMc5ZUgUQTpRgHV1WcGLQyLi+ZPOJm3of1guXx/hZmLQO11q8OQ
         USMwDiAm33aszqbkaRczcVnqHa+UEegr2cXPSkjdk+jP0EZPedB8tzJTTV0NlOKiwJkZ
         YrGJ+knq8vVCBfafyAbUtdqO1tbcWdxL2bOSk52xVRD1zBIinkmvXvEu/POzO9bbBhcz
         O7gWvIFz9rYzoDg+16VQOvWrzWFS9Mm1w4ZG+uOzvxZgjxIGFSpCanjH1NicG1NtslfR
         2tTA==
X-Gm-Message-State: APt69E2t2nbtcWbkp1OS6IBkfXnBB4bPUeTMv7RCUrRG2Vass/JpDUsV
        P+3jhpDRKYnLK1F7/IL5No2NgmMcbPteHe5W3ooCUbkSVn9maZc///Ilz4peJtT673jDJzL7CDF
        ShFydCJwt5Sp1CA/hxVm/w1CZtNFdjW7MfcL+eJ1PWhp0Yx4gXYIQetuKDSrz2OCM07IJQ7Md0z
        eX
X-Google-Smtp-Source: ADUXVKL7Qr/PVXG1yALq+gUdXClG+ZtuoOvCG1b6ofbk9/BGRsPe/jmgRkp1kUdwfB0+EsYIIrIQvNZ2CeNx+5bqOgM1
MIME-Version: 1.0
X-Received: by 2002:a1f:bdcf:: with SMTP id n198-v6mr1958381vkf.38.1529016871926;
 Thu, 14 Jun 2018 15:54:31 -0700 (PDT)
Date:   Thu, 14 Jun 2018 15:54:21 -0700
In-Reply-To: <cover.1527894919.git.jonathantanmy@google.com>
Message-Id: <cover.1529016350.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c4
Subject: [PATCH v3 0/7] Refactor fetch negotiation into its own API
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Brandon and Junio, for your comments.

Updates since v2:
 - nothing new in patches 1 and 2
 - patch 3: now clear priority queue unconditionally once we are done
   with it (as requested by Brandon in a comment for a later patch)
 - patch 4: updated commit message to not mention everything_local() (as
   pointed out by Brandon), updated test to not rely on the fact that
   fetch-pack uses prefix matching (thanks, Junio, for the observation)
 - patch 5: used a more descriptive name ("struct negotiation_state")
   for the struct, instead of "struct data"
 - squashed patch 8 into patch 7; this means that the comments are not
   moved verbatim, but for the reviewer, verbatim-ness of comments is
   probably not that important anyway

Jonathan Tan (7):
  fetch-pack: split up everything_local()
  fetch-pack: clear marks before re-marking
  fetch-pack: directly end negotiation if ACK ready
  fetch-pack: use ref adv. to prune "have" sent
  fetch-pack: make negotiation-related vars local
  fetch-pack: move common check and marking together
  fetch-pack: introduce negotiator API

 Makefile              |   2 +
 fetch-negotiator.c    |   8 ++
 fetch-negotiator.h    |  57 ++++++++++
 fetch-pack.c          | 255 ++++++++++++++----------------------------
 negotiator/default.c  | 176 +++++++++++++++++++++++++++++
 negotiator/default.h  |   8 ++
 object.h              |   3 +-
 t/t5500-fetch-pack.sh |  33 ++++++
 8 files changed, 373 insertions(+), 169 deletions(-)
 create mode 100644 fetch-negotiator.c
 create mode 100644 fetch-negotiator.h
 create mode 100644 negotiator/default.c
 create mode 100644 negotiator/default.h

-- 
2.17.0.582.gccdcbd54c4

