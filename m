Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5385D201C8
	for <e@80x24.org>; Thu,  9 Nov 2017 19:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbdKIT6Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 14:58:25 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:52688 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdKIT6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 14:58:24 -0500
Received: by mail-pg0-f51.google.com with SMTP id j16so38247pgn.9
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 11:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id;
        bh=4zGl8WDibxnK6SlzQQfKEX5VMzpwDx4Wb8l7RFElC90=;
        b=UVb0sNa4tZ6LPT0ghw7NDI8Cjb/rME+1illLjjfb1Ry+BkBhjYfsXtp9r8DXz0xf4j
         4caYo9kW5nZ0y/PxThyahU46Y3b859EYCro9mf37UoTeap96B+iL7dLQO0OXvNBi6A8U
         MRgzLowJjiZyxdNJ88psbT7ogX1e7TundddS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4zGl8WDibxnK6SlzQQfKEX5VMzpwDx4Wb8l7RFElC90=;
        b=H9BtUC05+Nj+lHpkmNYhN/H7EZFbq21Mx3pH/KcKK6tcsC8oOAXkoJZ2TmoWuLHxyH
         aj6pJjCtp22T4RPH9vzhauivtu6rxKhaw0KiLtUF4bDkYdEXf9ApUi2VaxWXtyTu5dTq
         MXOz4TByntMzBNtPVC1GqpQju3/Lx5dy1f+imgCRp859UgUGXTD1aoF9JXArkmLdW9ig
         GLx6zr1OOMAYiYhyj46ekh8//wggjMsjnYrtZCAv4sgz115dASAvvuNpCtwoZErZzMeQ
         33jKxrM1ZFsX1pH9RceAhT0mUwsj1GOUFz06OqythPkbBLaEIUM+evyM8MF4CBmMvuK3
         6VGw==
X-Gm-Message-State: AJaThX40hMQqzBEzpSvtMNDgByvYNyqtgAnIRt/nhOvIAK6Mbu3xG8HQ
        lj+AcV38d0jbXRuCFHFBdbl7yp7uBOY=
X-Google-Smtp-Source: ABhQp+Sj1A598O6BSVULDlIweUt3gzik6+IaUOXW9DJKacDH03ERbUT1tPDYg2dO/DrlgId/49o/Pw==
X-Received: by 10.84.175.3 with SMTP id s3mr1439012plb.279.1510257503628;
        Thu, 09 Nov 2017 11:58:23 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id p83sm15150760pfd.61.2017.11.09.11.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Nov 2017 11:58:23 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 0/2] fsmonitor: Stop reading from PWD, write fsmonitor+split index right
Date:   Thu,  9 Nov 2017 11:58:08 -0800
Message-Id: <20171109195810.30446-1-alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple further patches for the fsmonitor branch, which ideally I'd
have noticed before my previous series landed.

In the first patch I believe I've found the underlying reason for the
PWD confusion in the previous go-around -- but I'm not sure I'm wholly
convinced about my solution to it.  Specifically, it seems like this
problem is likely more widespread than this one place, so adjusting it
in the example hook may just be leaving the same dangerous edge for
others to stumble across later.

 - Alex
