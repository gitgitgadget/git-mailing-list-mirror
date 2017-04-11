Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B1A20970
	for <e@80x24.org>; Tue, 11 Apr 2017 12:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdDKMyA (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 08:54:00 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33938 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdDKMx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 08:53:59 -0400
Received: by mail-oi0-f66.google.com with SMTP id o83so4602527oik.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=tlUr8paksoCu4ShHvmq4nVSkek2PQRi3ZQNqgUiJw5v9zf7PP8BifwGkbiaBOu/cs3
         AhpUVX0xRvnEIxn6Jkthd4tJOHHAcid+zoUGkhxh6qh5Yt8KO9pKo5CTRjWUzhxtbGSA
         DanMiOVuC83gyCbfTy8UxLIy7uYgz9fT/lhE04lPxRO5WBKjs1Arm7Izm1rWbPymnfLP
         aYPI2u0/9zhLV6uhpZ+nW6Z6iangCGnrGQxqVPDXJz44cJ98ck7I698KZ+sA6aeaWxcr
         TH1Rp9Y/Kzn0bxWXP57+1zwaGTvoSWBP2fBABUczCWwXhXSwWXmhtiVDZIUiahbgRHFd
         d9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=IXnZpyutu3is1LwWbPJ4nruPSv1R7l2HoD3UA0Nm8JnoXpGCHcSrl6DWbuJUYhB0vk
         RHpmNxh/cyocOHRrOGY63hj/TrYeoCuwKnzrCzQ/eiWUFPtLi55nqA5SLX1Yebdf8uJY
         r87t3gkiMb/zSzKpwsEBwViVmHVCfoya75Be4P8i8wSVXNwf7mZat0KYX0qkHG59pJ9k
         G0e5fVVTVn9F3bBlDO0+5cX3URfrnt6ZxNdah7mC4SVxiLl8ImBGnHvMLcTe/9LXtoE/
         5RKzD4g2RNBB/AHWHwDOHkK8YVqRkVB1RdE/OzOVSNv2CIj1zaYmsov9vNZ04uTANc0Y
         u8hA==
X-Gm-Message-State: AFeK/H19td7jrV/8OGkliEy4ev7lxzSOO419RAsrMjl3JFlwu7kegrBNDdldK0Vj0IQlZA==
X-Received: by 10.202.186.138 with SMTP id k132mr31847430oif.157.1491915238331;
        Tue, 11 Apr 2017 05:53:58 -0700 (PDT)
Received: from ?IPv6:2600:100c:b225:8bba:5d59:cfed:afca:c2ac? ([2600:100c:b225:8bba:5d59:cfed:afca:c2ac])
        by smtp.gmail.com with ESMTPSA id 94sm7640393otj.55.2017.04.11.05.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Apr 2017 05:53:58 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Devan Lucas <devanlucas8@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 11 Apr 2017 07:53:56 -0500
Subject: Re: [PATCH] read-cache: avoid git_path() race in freshen_shared_index()
Message-Id: <E95E97DE-E70D-4C5A-B437-4784E1049BDE@gmail.com>
Cc:     avarab@gmail.com, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org, pclouds@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com
To:     gitster@pobox.com
X-Mailer: iPhone Mail (14E304)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
