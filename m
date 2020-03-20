Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA21C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 13:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CEE2070A
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 13:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSZau3zB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCTNJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:09:14 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:44905 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCTNJO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 09:09:14 -0400
Received: by mail-pl1-f176.google.com with SMTP id h11so2457084plr.11
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 06:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJAXhf5E3qx1VX4flbkeC2ceF7GGfQAjaUEXgrH2KzQ=;
        b=SSZau3zBvxq+LtlKGaMkgbWD7CZFvyETl+J6/SOaNJfuni6KnxXLQ2VinLwVqNa/yT
         66dmO1SP7cdIXu9lPDiU1iBb3tOeqLugj/t0SAS6P/2GSKh58c5I58/7ckmkGJtqXlGQ
         oTVXuocH0/nZ9gddh6Wb+91fwIyeT919V9R/UauI66bWq61KjxgRP8MNc6UVIoCHGjaz
         4Xbz7jXHzWJkO2VXQ7y4SWXbdmt92x9RrqWgIRSb4w+wbnYroJ6RcvscO6Ea4q5YAsLh
         MqleZQS7j4FI1ueEB1zodD4wJ51ZajR95RqVEyXnxvoJo36m1gE33VpfDr39YT87vGoG
         PoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJAXhf5E3qx1VX4flbkeC2ceF7GGfQAjaUEXgrH2KzQ=;
        b=VFAeUX2GB7Kppg7awINwoxpXRklZkN3moW+PSp/9/zPIyzRulEs5hDs1lS7Wo+QccS
         GgCNJnYx1ZBWAXBEnYRPtKbF+KyhR7Y9SgSG4zqW4P57dcYNbEcsHdDF94eOemH/abdY
         nj9RgFz0VOlIwPCCkhs3f04C7bGpC6u9FMbH9axDnFd2+cbhPJKBKpyZWsF132Gix5/d
         6oBqYl7/K1jRgWQTkxhcJTce/SZx9rN2agO7tS8H2bPYJLMYbv2rEfrkC7uopQxxQSM6
         /SO11UbGTJLApNpSjMgEjJ6Vf+1xEuVsWA/lq8Zq5d/aZmvB5MQyvy/aaZnisj4AHnz4
         0tWQ==
X-Gm-Message-State: ANhLgQ1szZON/Dxvtf3Lj1DkSetgrweYHZ+l0fLGNDuSe25/9uuh9bJm
        PNYjx4aNbd9kWCT4X4UI0uU=
X-Google-Smtp-Source: ADFU+vsoQSzNUF4Bv7Xpyn4EqUQ/BqY/sWbJ9LhBhhhVylXTCvvEjeOmiWAzCaL2Kue0IL1kMA3BDg==
X-Received: by 2002:a17:90b:1997:: with SMTP id mv23mr9624555pjb.84.1584709753315;
        Fri, 20 Mar 2020 06:09:13 -0700 (PDT)
Received: from localhost.localdomain ([2409:4052:817:5e21:ec32:affe:2929:752d])
        by smtp.gmail.com with ESMTPSA id l7sm5433176pff.204.2020.03.20.06.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Mar 2020 06:09:12 -0700 (PDT)
From:   Harshit Jain <harshitjain1371999@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, harshitjain1371999@gmail.com,
        shouryashukla.oo@gmail.com
Subject: [GSoC][Patch 0/2] made the changes as per community suggestions
Date:   Fri, 20 Mar 2020 18:38:43 +0530
Message-Id: <20200320130845.23257-1-harshitjain1371999@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <xmqq1rpodn25.fsf@gitster.c.googlers.com>
References: <xmqq1rpodn25.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Greetings!

Thank you for suggesting the changes in my patches. I have made the changes
as advised by Junio C Hamano in the following patch emails. Please look into
those patch mails and suggest any further changes if needed.

Thank you once again.

Harshit Jain

