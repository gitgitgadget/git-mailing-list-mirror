Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6502203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 12:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbcGYM6o (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 08:58:44 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34815 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbcGYM6n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 08:58:43 -0400
Received: by mail-pa0-f68.google.com with SMTP id hh10so11496444pac.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 05:58:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=x6rsLl5I5BwW6FSrcoH5A2T33gpAGiIj90q1UzxaZe8=;
        b=H3WMRT+c0SIlxa/EOjNsi2HsPNRAbSGvR+vH/HlS/AayJiMyVZ+DEiCxdRSMVRweP2
         Q74mpdALJtxwjsNI0SEqN6ioKFIQ26gNNInP1qJmSJOVH1EV4q8wwz6l8i+DKyfrqyUb
         s8VbkL7nJtLaG0s/jhupWZC2fqCgN7Mk1j2Q1GVha7smghtRAK2uZ0kckG2BfrtnR5mP
         +p8kVT+Nn2RrMG4nNRz7UeVT9WXbeJI8ql+Dw49cYi0ThrQlBa7pJYBTtDRuNurcAk1u
         W0ILzNRQimQsafUR+/R0n8DlvS6ZwM1/6tR+vRIeJTNLfD2w5Lo70a2OXrQ4wr396Wmj
         d+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=x6rsLl5I5BwW6FSrcoH5A2T33gpAGiIj90q1UzxaZe8=;
        b=R2OQlKhuQ2RKry+1t+mzb+SYuLIfJ8G3xsjlqirjjopghqRnRbQ5rxh3VPXfxDpxWc
         UBW9FHCC8LiN0bwbWXL28KIX+WY/284buQ8qhUpfkVFWa/Wc0ZPAlExPdOCFxzMAizTV
         p9NolJpiFAJW0yyTfkhOPGEd+pt1OMyeiDuOYOy5X++C+DOp3CLNHGMG1UgSyxqpHQ2y
         CansQmDStDdKQXnb7PxNWorf4WgVGZRGWEW0AUA+UAhWZZpbF4m59HOnvktYqHsmk8E9
         SDbeMLgca4odTlaNAecyNJulzLY2ucmsj6UjinqKpgkInGh0K06IXnFAiPu0uRwrqVEL
         wQuQ==
X-Gm-Message-State: AEkooutjWsZaHDRBeSDmmVxWOYXgfHYBUBczIxC66xsazQQsTv/lOaH/uMEKgvDmdiMXGA==
X-Received: by 10.66.229.9 with SMTP id sm9mr29134975pac.138.1469451522199;
        Mon, 25 Jul 2016 05:58:42 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.150.0])
        by smtp.gmail.com with ESMTPSA id xv9sm18072214pab.36.2016.07.25.05.58.40
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2016 05:58:41 -0700 (PDT)
From:	Sidhant Sharma <tigerkid001@gmail.com>
Subject: [RFC] git subcommand to check if branch is up-to-date with upstream
To:	Git Mailing List <git@vger.kernel.org>
Message-ID: <57960CFF.5060104@gmail.com>
Date:	Mon, 25 Jul 2016 18:28:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,
I was wondering if it would be a good idea to have a command to check if a
push or pull is required. Perhaps it can also suggest if changes are
fast-forward or the branches (local and remote) have diverged.
The reason I feel the need of such a command is when I need to check if my
branch is up-to-date with the remote, and when I need to know if my local
has diverged. Currently I use a script based on this stackoverflow answer[1]
Not an extremely useful tool, but I thought it'll be good to have it.

Warm regards,
Sidhant Sharma


[1] http://stackoverflow.com/a/3278427/5211579
