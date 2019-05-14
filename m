Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53CAB1F461
	for <e@80x24.org>; Tue, 14 May 2019 18:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfENSED (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:04:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53985 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfENSED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:04:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id 198so32919wme.3
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=4g3t76PKeVlJ7BWXB/aN86ogyhe7FjN3kVW23p59TrU=;
        b=tRJBepyrx87El/NwPOTITw5JPRPF+OoHWhJPddTUb7ZXXRX/wBsHVkPViapk5WiC9r
         ulL7YXb/2iLMbwRgdKmAT/xByxTH7rY9Oi+EG4fxX+7Jmjt+IvwsjNgJJxuS7n67ORJQ
         mbVhgUB6+Zo5plGzBQ+RG8MRmptofoTIqFflqlVS1ZmjtjVO439ep4KxHMFoLx6Vx8yZ
         wFP7MN6rp0tiJ2a+afBeJKyRLwOoXYHjA0rdRYvotFmlwH550R5lfsZUGIdBhY+OyBQd
         7DSUumzPl0cokm0xvldT8WUBO2ORYBDpnoVGfUktNITUd9SX0ncgbX5PjG4KfYkD5c9L
         INCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=4g3t76PKeVlJ7BWXB/aN86ogyhe7FjN3kVW23p59TrU=;
        b=AT0VMG6u1k8PyoAYF5mCm8YteM4c4CTOcFgDElacstOSNzid1jLLqysifa/+phWG2P
         xIEiMPVhC36zPcfygh/YLDlAZo/TGF0kT2zz5e8kyryaW3PzwKv28YvhKjitgXL20rIx
         F6waN2r8WCpaKA7QsTfaqXgo4dokJAbLSzLiFt3WhrxNMRrrji+JDvu5KgFKNd6ZvKB9
         N3qyKUfo+BMSYyI5bgaYA9g1QV6RvpES8WVxZ5UfXSRWi8Pdjhfyg5cfAhJfLjuy7XH6
         ikV9kFquKxh3S197cp5/6eFM55gyEUc77uv7q7IN1OuszSdCWxD+2GNCicqy+Di3/5GE
         9Trw==
X-Gm-Message-State: APjAAAWtTptOcAkgUIotqzKjyu62QsB6h6Ofb23ktFYULcQNZ3d+AGgS
        mkXCXs4B69hLlu0CFOpM1SmlxJ39
X-Google-Smtp-Source: APXvYqymQpKgVHW6fpE74OXK45VFE/4fJRdGmpxiSe1FScWBWtSc/6TyEWWBXDUBGYhnpj3TGordwg==
X-Received: by 2002:a1c:ab09:: with SMTP id u9mr19033978wme.29.1557857040642;
        Tue, 14 May 2019 11:04:00 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id a4sm4528230wmf.45.2019.05.14.11.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:03:59 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/4] rebase --abort/--quit: cleanup refs/rewritten
Date:   Tue, 14 May 2019 19:03:45 +0100
Message-Id: <20190514180349.17245-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426103212.8097-1-phillip.wood123@gmail.com>
References: <20190426103212.8097-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

refs/rewritten/ is now cleaned up on --quit as well as --abort. I've
also added a patch to make sequencer_remove_state() to return any
errors, so rebase now always reports any errors that occur when
cleaning up the state directory.

These patches are still based on pw/rebase-i-internal, the first 3
could probably be applied to maint if required.

I'm going to be off line for ten days or so from Thursday so there's
no hurry to look at these (also we're in an rc phase at the moment)

Best Wishes

Phillip


Phillip Wood (4):
  rebase: fix a memory leak
  rebase: warn if state directory cannot be removed
  sequencer: return errors from sequencer_remove_state()
  rebase --abort/--quit: cleanup refs/rewritten

 builtin/rebase.c         | 39 +++++++++++++++++++++++++++++----------
 sequencer.c              | 11 +++++++----
 t/t3430-rebase-merges.sh | 18 +++++++++++++++++-
 3 files changed, 53 insertions(+), 15 deletions(-)

-- 
2.21.0

