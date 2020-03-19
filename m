Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14024C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 13:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D041B20409
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 13:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzW8dcgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgCSNaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:30:19 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:37208 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgCSNaS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 09:30:18 -0400
Received: by mail-pf1-f182.google.com with SMTP id 3so1442275pff.4
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=AkdP4Pyhd8RDPKT0FN6Is+FvjX6svzRCemSFeHgvO/8=;
        b=RzW8dcglKSj99yiAng1vXHWDTnnOTHz4fb857mvfPdp4IZ9efthVHcs9VQgh0m4wZF
         vpadp2lR9jKOLO6LIvRuFleCKbj6P8UNkqgq4ZxpDvY/nA+uQfMnrYUiaKOdZyUDKAxr
         BtA+lVcActj/5qRhJKxb85h4bCzkN9swibg+/RxAzyFfXVXjW8E5PHhlXTcNKAcIxTck
         3De0uP6PNvwp9uaDQFHVIR5JLwForIWqxeacCkwHQEEeivW4g2lKI330GDn/vje2wTFB
         WjPXoNuwpogyR7KsBV5Lw3bKFkJdMeLx5Ek4Js0G7cAUHvRkzQzoUv2ne+pMzR9iyw5o
         7FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=AkdP4Pyhd8RDPKT0FN6Is+FvjX6svzRCemSFeHgvO/8=;
        b=cKstoF6dTWZ19EYVPImkiHDc+2UEc5XNNLkaFYFW5GFMcCtn6qo3B+qkP5crghFBWV
         kf3FgbcTYko4omfCH8Q9FBWF/rxHLoaSC/LOvFQ33SsT8MpXTuQzdciVdUs41Tt3U1YG
         JjEdlY8tB5CYJGrZXdqgagxaneKtF3x0fVgYLJZtUWyoQqaOzq/6ukrPqna2t/DGEUFz
         T42GrZsv12YBN/5KEEoZl00dnJg1L76Z6s71caGUafJ8BavB2pUkLgdBam6I2D+IihmZ
         Wbkk/r3r7U25Xvcy+FfybkLS+LEOD+7fDrhW2b323+DXRmChSlivq691Z5trcu0ihT3W
         CzhQ==
X-Gm-Message-State: ANhLgQ1c+7KfffAn8o3arhmpuPfEDpKe0EhMY4Kp+X0Frt9si2g80uKj
        VxoXVD5Zy4Uk8zLFh0y9vkAHKrAYh2U=
X-Google-Smtp-Source: ADFU+vuRRCmgzP+9EQoNKL/kyiA4zm2IGquUBEbQhHi4OFH+cdZjByPy+gad0UMB1GzFlzXF8a1+tA==
X-Received: by 2002:a62:5a03:: with SMTP id o3mr3957418pfb.301.1584624613711;
        Thu, 19 Mar 2020 06:30:13 -0700 (PDT)
Received: from localhost.localdomain ([2409:4052:2e20:ac22:ec32:affe:2929:752d])
        by smtp.gmail.com with ESMTPSA id my15sm1960440pjb.28.2020.03.19.06.30.11
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Mar 2020 06:30:13 -0700 (PDT)
From:   Harshit Jain <harshitjain1371999@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][Patch 0/2] t4131: update test script
Date:   Thu, 19 Mar 2020 18:59:55 +0530
Message-Id: <20200319132957.17813-1-harshitjain1371999@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2
Reply-To: Harshit Jain <harshitjain1371999@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Greetings!

Here is my very first contribution to the open-source community. I have always been a great admirer of the open-source developments and am really excited to begin my journey in the open source development.

In this patch, I have:
        - modernized the script code to adhere to the CodingGuidelines
        - replaced 'test -f' with the helper function 'test_path_is_file' as it make the code more readable and also gives better error messages

Just to add, I have done this as a microproject for my GSoC application, and am hoping to contribute more to the git during the coming summers.

Thanks,
Harshit Jain

