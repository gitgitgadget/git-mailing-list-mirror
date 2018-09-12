Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB3F1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 14:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeILTuk (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 15:50:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43211 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILTuk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 15:50:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so1118496pfi.10
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Ik0MbN4ZArw4wyYLAZRWOT5C+8I2+k0zD9lTumo1Ew=;
        b=SqNbZ7nb8QAlbMFax70mgIMrm8EYwAnHEg0KjtYEWHhY4AQSssq3lZGLkJEfVBs2Jy
         TrlTRlDhD0aF0VLU8G77e4dwjUyYzlECZju+huuWlHpv5IvdJMk5shKNZuI8BT1yGA+T
         xpgv7fJ1eGX7XuUFO95MKetkMH0Whd0z/MUtWsPLQY0K7k9V5pVy5IglBsLNcJnukzwS
         A0mAOPpNSC8g+grbcWlp9/He44ooFzNIJ1tsxJOIzkeVbOCO2TYaAuz5I1TI9uaYKWSn
         ZpC86VuZ+8Ob00KTxwh5FNDW3cuKpkvVg0Bmav716e03w33ijJEfAIBD/YbvRk+GaRVA
         0twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Ik0MbN4ZArw4wyYLAZRWOT5C+8I2+k0zD9lTumo1Ew=;
        b=TnTy4FJ9rAqJ5xUwymR63rhRqKeJiz7Cy03hfXWu3rUrdb+2kwLxm8UNg7hPUlQJTG
         c379H3qxD3riKzKNHvoon+G8TSGkdUdDFW6ofP8xw9nxDuhtgVFa3iEmIT/PXqLaUiBD
         SKkJH7Kiz2Oy5kjFAKeZRivWy3+YzgoTAfy0MgHFwaxqrvWie853WW4YL04AzuxMrfdG
         abhSjW1D5DVnb/eEkdlCVVQL34gCrixFzB+qcF8Lim1e4NKRWI9FGqRng5GWzG04BG2i
         B1xyakh+vj3BqLvGkmZ4bYTmXL6kHvzSAEhQ0J2rXoBbOzokMWZYkHT4boGJ0xmNzQj6
         lNlQ==
X-Gm-Message-State: APzg51Ad5JiTCbkPoZt8+aTa2xs6mb5fP6fpfpMqjFJ9T1dIhyjOqnaL
        NLQOM3SXDmCc0bi5vY51OEl0aVXr
X-Google-Smtp-Source: ANB0Vdao1EvZK3xY2a+qGTi/6dYyiQzEiqYGk3GA5RSBYYJPYagOhfnbxP4gB3QAkuEv/Te7POrsmw==
X-Received: by 2002:a62:435c:: with SMTP id q89-v6mr2789347pfa.135.1536763549647;
        Wed, 12 Sep 2018 07:45:49 -0700 (PDT)
Received: from localhost.localdomain ([203.142.78.193])
        by smtp.gmail.com with ESMTPSA id l70-v6sm2319839pge.36.2018.09.12.07.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:45:45 -0700 (PDT)
From:   Shulhan <m.shulhan@gmail.com>
To:     git@vger.kernel.org
Cc:     Shulhan <m.shulhan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>
Subject: [RFC PATCH 0/1] builtin/remote: quote remote name on error to display empty name
Date:   Wed, 12 Sep 2018 21:45:03 +0700
Message-Id: <20180912144504.7498-1-m.shulhan@gmail.com>
X-Mailer: git-send-email 2.19.0.398.gef7f67bed
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rationale: consistent error format

When adding new remote name with empty string, git will print the
following error message,

  fatal: '' is not a valid remote name\n

But when removing remote name with empty string as input, git did not
print the empty string with quote,

  fatal: No such remote: \n

Follow up question: If this is ok, should the po files also updated?

This is my first patch, sorry if I did some mistakes.

Shulhan (1):
  builtin/remote: quote remote name on error to display empty name

 builtin/remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.19.0.398.gef7f67bed

