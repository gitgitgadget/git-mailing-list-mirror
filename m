Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B8B1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 17:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932424AbdBPRHV (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 12:07:21 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32954 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932348AbdBPRHU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 12:07:20 -0500
Received: by mail-lf0-f65.google.com with SMTP id x1so1964946lff.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 09:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3GsMORHnuYG29fwYGWOhc39DZSOwWwMd/0+Eyn8+ZFc=;
        b=F1KuO3fnhZMkbXvHTPb0rb50QVSO+vypfeK+dWuAq6+Zk96yOIs+n2HMqBJBXMQORY
         D16K0KGQVIfUXOU+yFTbGmDSWII9ULPxKwVZIHtkpL5G3Y8XVrSb2OJqL2CjkRiwR4gh
         ZQ2UsbjG+9I25T1eAQvRf75/pmxLJiEYK0JKIRd1u/Y+MNd7b68M7YyWD00UuVvawREr
         2z3wbqP2iZodTkcyBjxBseAPMr+T+Sc3dfu4rL6ZkL4dnBA2ZqVDtYVQNXOuFKf5mCBG
         s4K8k0TWOkzkYrxjyqWp7vCVcbYvbCGpG55uj9G6krTfSgYEN8APyo/WKQIcItQ8sSFW
         x9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3GsMORHnuYG29fwYGWOhc39DZSOwWwMd/0+Eyn8+ZFc=;
        b=RWykVBq26rB9lO1e3IA4yVBGzXDOAA0Xf9u1VuDm65e9ZMw4kGwqo3vP7atoMPhwRg
         BqVDS2DrAVYjeNLrqsAoJGnVAypnpddFD26FVY/ZOL6cXZNE9R7zJh99M8Rb1ec19K+t
         UWiJ11AyHmU7TVuizlCUBfHmrpR50V5S3FoJai9eAzCYiP2A3zohMFF1fYlmLLdw/FwJ
         4A2Slsjlg6erQVq0a9xTW3ifcICmDJ1cT7GYAP3C0tci3pX7qb9bSzhA3Nd68QLoj+5e
         4ikhJnjmlEHdyTDt5m1jy5ocyj6mW6wRXoAvIkYEJ1R9ThQIpBDydyvqq3U1aMHIZ4Te
         aP3w==
X-Gm-Message-State: AMke39nzvAq5zoQcfAcWJsKHwx4FUDdCHfatfCITVQ/xkZoJShSmSxEGZHqNdYBclWzLvw==
X-Received: by 10.46.83.29 with SMTP id h29mr903488ljb.84.1487264838969;
        Thu, 16 Feb 2017 09:07:18 -0800 (PST)
Received: from localhost.localdomain ([2001:470:1f0b:8fc:eda1:2dcd:3a83:adeb])
        by smtp.gmail.com with ESMTPSA id s7sm1867896lja.27.2017.02.16.09.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 09:07:18 -0800 (PST)
From:   Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Subject: [PATCH V2 0/2] Fix l10n
Date:   Thu, 16 Feb 2017 20:07:11 +0300
Message-Id: <20170216170713.10065-1-franchesko.salias.hudro.pedros@gmail.com>
X-Mailer: git-send-email 2.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some places static size buffers can't store formatted string.
If it be happen then git die.

Jonathan Tan: Thanks a lot for your help.

Maxim Moseychuk (2):
  bisect_next_all: convert xsnprintf to xstrfmt
  stop_progress_msg: convert xsnprintf to xstrfmt

 bisect.c   | 9 +++++----
 progress.c | 9 +++------
 2 files changed, 8 insertions(+), 10 deletions(-)

--
2.11.1

