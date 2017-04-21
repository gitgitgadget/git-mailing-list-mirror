Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645FC1FAA1
	for <e@80x24.org>; Fri, 21 Apr 2017 22:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426298AbdDUWCC (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 18:02:02 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35671 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423683AbdDUWCB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 18:02:01 -0400
Received: by mail-io0-f177.google.com with SMTP id r16so129805236ioi.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 15:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VnuLjkkaRCvTxyjxUwVXiwZcaAOioS8B4y2iacci4tk=;
        b=jRH/su0NywZlyLV4hAgZpvN9plBMZoWi3+m48rOE+ls0xNV1hrWsx1MZ6ox5RxvhPe
         jDRhlhcqBCKj9jy1EvF6JDwjZIjTgzlk5xyNfnlP2s0/8ERIv2pJfKRglStVxDHxKYCJ
         8VRiA4DRKNCx4rt2/y7xMOEohzVbnsD+U2+PlYI0TowIXSoGfrlz5ZYSHSeebS8bZF/h
         DYdanb9HZ+EJbeb7pvxil0UBBBpOxt1JuXWVSIDlfaoRrMGDlOjveux56L7UadjIKH19
         yr+IHpCGt0f1dpzudg9HmuT2fGBdqcsiAxCbNM00309dY9WGU3GfnpjPlVH6l1KNysGh
         FjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VnuLjkkaRCvTxyjxUwVXiwZcaAOioS8B4y2iacci4tk=;
        b=gtlaraPk96fcrFPy0KaJeujwKWe43UOKoUlO5xSlVWDGcZaImOg8xrLeRS3Lf3lYLD
         RXF0kZAiUvBSv3DsXe0qNQz5Z1dEQj5a0djM3Fr+saaFyHIHLqD2Vfj29KgAzI03g/0a
         W+LH7sDIwBTFqoNzZxYpIps2j11to3udoPnTrRVLxjJunZz0Wj1G33ZNC2UnN07mL2Nh
         pxpgB+E9gsnt+LMPJVoXUy2tlWbVqB6wAc2qBgzjsFyQ0acU9k/9JvpYEQQPlL2HNH16
         xEIeMcXVGbsy9ROVMWuGu7KhBwB5zDV5KdwX03ui8w6X9K2TUPQMv4BN025YmUWZ6jb9
         WRFA==
X-Gm-Message-State: AN3rC/4pEwkBAN0ZkPSXPsbF8nYLe6RjBPnTrjsgsNHnKhUYzDJdmi7Y
        5e6L2o8Q8Z8j97FT
X-Received: by 10.98.35.10 with SMTP id j10mr14316214pfj.23.1492812120509;
        Fri, 21 Apr 2017 15:02:00 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:5c03:9ef:c5a9:d5e9])
        by smtp.gmail.com with ESMTPSA id c3sm17730657pfg.46.2017.04.21.15.01.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 15:02:00 -0700 (PDT)
Date:   Fri, 21 Apr 2017 15:01:55 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     git@vger.kernel.org
Subject: [GIT 2.12.2 REGRESSION] git cherry-pick -x
Message-ID: <20170421220155.GA142345@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I haven't tried bisecting precisely, but somewhere along the way git
cherry-pick -x regressed between 2.9.3 and 2.12.2.

Looking at upstream linux.git, I can do:

git fetch git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
git cherry-pick -x 7b309aef0463340d3ad5449d1f605d14e10a4225

And see the following ending to the new commit:

Acked-by: Arnd Bergmann <arnd@arndb.de>(cherry picked from commit 7b309aef0463340d3ad5449d1f605d14e10a4225)

On 2.9.3, this worked fine:

Acked-by: Arnd Bergmann <arnd@arndb.de>
(cherry picked from commit 7b309aef0463340d3ad5449d1f605d14e10a4225)

This issue doesn't happen on all commits; maybe it's bad parsing looking
at 'Signed-off' and the like?

Regards,
Brian
