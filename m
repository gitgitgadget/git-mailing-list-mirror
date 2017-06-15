Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD50220401
	for <e@80x24.org>; Thu, 15 Jun 2017 22:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbdFOWKR (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 18:10:17 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33196 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdFOWKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 18:10:17 -0400
Received: by mail-pg0-f53.google.com with SMTP id f185so12255236pgc.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+Mgtl5yTH6p60mA3xPZXbnm7SOLbfS8wCN8pKfMDuN0=;
        b=nOkhsjAdSNszTKDeEAfycviKrYs0yZNteI72jhrOu8/3KelD/9LwzrDv0tQx6bZdQw
         mIuCCsew9BNhzchnH3FXvMzJl/4i6tO1Bd9zDY29P7mJGU8l9RBi0WFXTj+9s6UTXRPf
         avnU7FIqSrD+h7/7ltQ+K2kUm5UsYFzl3yJtnrdqnyjt5hC/qE24Fdsexrs4j90ooCAI
         qDBpp/cJWXDas5rUvf/0DDWM5bPQ1rdk016KoaStsiFmB6uqGqVCxFw6eM0plxeWzoUX
         ZMWRE5IIDsUdzckZ7kQ+iVcn35Xwe28eMNFlKBqSPEdbYyCa+CbzNjfwjJr+XqWhzK2D
         HFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+Mgtl5yTH6p60mA3xPZXbnm7SOLbfS8wCN8pKfMDuN0=;
        b=NF0ntGfdJHk6fr0ltBmTzikBDf7788GCg/3BK8SL/krTQTHdDUS99+asTywV+7oOFN
         xdDVkZy/21sSEwAT1J95IvX9fnvIQeTx/NEQreCYL8QcDpjpEp/zufy1Pdg2FLLI2Y1u
         5BVsIqKi/9qsigQTCDxx6Gq+HP3PVMzaHhExZbcA/+/KBuG+z9sG8uBpGQMZkoGW52iC
         koaE1G3u/ONvKEDdBgq6gcDWUtHFH2mJoSzqHRCfo6nCwpoXQOAumy/A1ct2Xz9buYYo
         bn87cT5uKVqtNqf15zmF23jpV8LUhN0lAyVpGyiNen9tGTpgPTImYpGZ8B4GT1DA0Uy1
         ALOA==
X-Gm-Message-State: AKS2vOxJlGTiOFIYT28AqsAmn12z7rXYXthVih42MhTrHi9v2cLMSOmQ
        zt6xa4CgXkHJg+t1uBE=
X-Received: by 10.84.129.4 with SMTP id 4mr9012683plb.9.1497564616346;
        Thu, 15 Jun 2017 15:10:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id t2sm472387pfi.76.2017.06.15.15.10.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 15:10:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] builtin/clone: get rid of 'value' strbuf
References: <20170614150148.29298-1-chriscool@tuxfamily.org>
Date:   Thu, 15 Jun 2017 15:10:14 -0700
In-Reply-To: <20170614150148.29298-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Wed, 14 Jun 2017 17:01:48 +0200")
Message-ID: <xmqq1sqkzyux.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This makes the code simpler by removing a few lines, and getting
> rid of one variable.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

This patch may have meant well, but I think e5698f3a ("clone:
respect additional configured fetch refspecs during initial fetch",
2017-05-30) makes this change a moot point.

cf. https://public-inbox.org/git/20170530071244.32257-1-szeder.dev@gmail.com/

Thanks.



