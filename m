Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D61B1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753226AbdFMVGL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:06:11 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:32949 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbdFMVGK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:06:10 -0400
Received: by mail-io0-f175.google.com with SMTP id t87so61641920ioe.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Di2z5xWI87Sl3jzJYvFdSCHr3uhzH1AO4+8OJHuq7jQ=;
        b=m5Ui8GIGiPRx45r5vpSrWK5L2B2FfkOiUAtnHAQip/zNRV95jTb+wwG4Hbuu+dB2kL
         ALS2H7ooja9Lk1dfJLcqXsjsW3AyrO0POdSl0ISf9CQeADQ79dxtbmeZlxrYWWGMxxee
         rPXZ8CK1rE/O5HVDHjI4m2Hz5UeqjiCdMC90j7Gxdhy3peqISIbWBawR3J4CyYieegkN
         5ayM9obBltY6jlyS/W3nrG60g2My2h7r+fSgO7aDaYlYUsmjhfevRWE3kx0TCNc1ySIC
         i09cPlFwmKG3dQ7H+s8vBa5VeqCOw7lzq/HAFB/5hA+u5AWcsyNVHbO5WbdQA5BO8z4F
         4oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Di2z5xWI87Sl3jzJYvFdSCHr3uhzH1AO4+8OJHuq7jQ=;
        b=gDqx0nuFBXix/CCjQsoNhg3+PZw7nUQ8U3cHLOykvQTGmNxDRgYrhdrMdWjnj0cLfl
         cvxy5QKx66EstRvoYehMwxUwgwoYJOfrtu7RobYm3jx7dhca/jEGD/xwdZKGnys0fVfK
         MjgVGvM6DoLcr4XdT3p1U/pWyKp+lIminOr5dIEahRcUNgVFXeTXsoWxCrs8HA8erG0E
         5LCohg/GvaQMdjHFcYJ1xmOf+RUEf5nLtQQdxRQd2Cpw1/HFAzJkEKqGtIDL0EyUvj03
         BLeupyiQSxtJ4S7H8C7QrBMoTd6wqx6/xsAQACl3QT+F58QNlP6+iWtrE0jpv/P8vnW5
         l3XA==
X-Gm-Message-State: AKS2vOy72gp0TPQzbWQIRecMRp2R+B8YYk1NjOa9nNEyAnv1H6yPh5HE
        J6IN1Kv/sy/nE1/9ku/31A==
X-Received: by 10.107.197.68 with SMTP id v65mr2403902iof.218.1497387969460;
        Tue, 13 Jun 2017 14:06:09 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id d185sm6885228ioe.38.2017.06.13.14.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:06:08 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v2 0/4] Improvements to sha1_file
Date:   Tue, 13 Jun 2017 14:05:56 -0700
Message-Id: <cover.1497387713.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <cover.1497035376.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff suggested putting in a new field in struct object_info for the
object contents; I tried it and it seems to work out quite well.

Patch 1 is unmodified from the previous version. Patches 2-3 have been
rewritten, and patch 4 is similar except that the missing-lookup change
is made to sha1_object_info_extended() instead of the now gone
get_object().

As before, I would like review on patches 1-3 to go into the tree.
(Patch 4 is a work in progress, and is here just to demonstrate the
effectiveness of the refactoring.)

Jonathan Tan (4):
  sha1_file: teach packed_object_info about typename
  sha1_file: move delta base cache code up
  sha1_file: consolidate storage-agnostic object fns
  sha1_file, fsck: add missing blob support

 Documentation/config.txt |  10 +
 builtin/fsck.c           |   7 +
 cache.h                  |  13 ++
 sha1_file.c              | 506 +++++++++++++++++++++++++++++------------------
 t/t3907-missing-blob.sh  |  69 +++++++
 5 files changed, 418 insertions(+), 187 deletions(-)
 create mode 100755 t/t3907-missing-blob.sh

-- 
2.13.1.518.g3df882009-goog

