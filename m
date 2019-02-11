Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA7041F453
	for <e@80x24.org>; Mon, 11 Feb 2019 21:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfBKV2L (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 16:28:11 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:39294 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfBKV2L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 16:28:11 -0500
Received: by mail-pf1-f169.google.com with SMTP id f132so169117pfa.6
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 13:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=djsbx-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=49L4cgm8toXAyD2ZEUaHsHpjHOYgAy6IfvXfuPRP5Yk=;
        b=f73zVJxjYAyw8PhDX8VdpbVfIcvdOLsNTToWaR23Z52zGSCZJXpn2AlUJPBxgQ+pHA
         a0YPk3m5YGCw0Lw2gqmBIvMIXnSw1VhTGagdYCSHI5kJPNFH0EpddkUXkpHDYleEJlxR
         WLVhNXlMrh38eiqFdO3Uv4gtALAxW/sPf+yCDBNZdFdJkLsPyyruxI8DQxs1XiF2aF30
         dfwFcs/wp3lnwz3b+mu5ORFZGO/346ertOBHga+TsZME+2Vwv2xH0kQ1oNElUtvdrvlT
         mLd3Wpoi1X3/j8aj4BW193u70/9y9AoHjVLsydIgnrdFhozsQCF74gAbjQ5nf9ZP5s9F
         ptYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=49L4cgm8toXAyD2ZEUaHsHpjHOYgAy6IfvXfuPRP5Yk=;
        b=pMhtaInqqZsuODDPg3rePDRt9Pi/vNG9+22ZMoIIC3F21B6SCTxaPwvOw/ktwzRYKG
         XBqDkd0Ga/xVcUYD+LL0r1H58SEe8c1J1PUjctAOm6zMXUnBqwYCHHt0K6mcOaoaaZyQ
         ojhWUUIbCcIGqpNvKd3gHYDpLDKMO6OvDXwtosRRx3b7kKVIPN7+B/jBUY3SpE3s1Ovs
         Jk2w180Z1EfGW9G9+/EKWl2IvLhDkUPpjMikKjJVWw3JwFhyjF347jA6TKHm5VS/oW5S
         e1OffsTfSLqqkeDDemxrIQrhrNctVJNRBwKZjERG/l+zSUwO9IkXqMw9LTxpXI3/Vpln
         elDg==
X-Gm-Message-State: AHQUAuYD+GqHhOt+SW0iYTbhxVBvVTvkwIWrSvR2ox21AnoG5LJRmW/g
        nRczHYTVuDiArCe6H3uOjDw7hmqSG9ZoCIZe3qVLojuf
X-Google-Smtp-Source: AHgI3IYCLTROgHEX/L6hD7LWnacasSb8gDMwm421VjXt6YGeP0KCd+VjSxxHpUAO9wUOfSF3PNHv//O8PuGJhSu3+PI=
X-Received: by 2002:a63:40c1:: with SMTP id n184mr255834pga.225.1549920490334;
 Mon, 11 Feb 2019 13:28:10 -0800 (PST)
MIME-Version: 1.0
References: <CANFDZM6PikancjUdm+HYgGknD0dPhzxU6yOYFLZpcnCmg8JKdA@mail.gmail.com>
 <CANFDZM7fsbwwqhyWTzfivm4L=GgtCMfCi+DekZurs+SFGqaOjw@mail.gmail.com>
In-Reply-To: <CANFDZM7fsbwwqhyWTzfivm4L=GgtCMfCi+DekZurs+SFGqaOjw@mail.gmail.com>
From:   Fernando Chorney <djsbx@djsbx.com>
Date:   Mon, 11 Feb 2019 15:27:59 -0600
Message-ID: <CANFDZM5=ffu-=H=vrO3Kr0t2km-3Zg4=msYUWqqJQKGxGojnqA@mail.gmail.com>
Subject: git commit --verbose shows incorrect diff when pre-commit hook is
 used to modify files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am trying to use a pre-commit hook to modify files before they are
to be committed. The problem I am running into is that if I use "git
commit --verbose", which I often do so that I can see the diff, the
diff it displays in the editor is the diff before the pre-commit hook
was run rather than what the diff would be after the pre-commit was
run.

I would like to note, that the pre-commit hook is definitely running,
but when git grabs the diff seems to be in the wrong place.

I have set up a simple example on my github to show the problem.
https://github.com/fchorney/pre-commit-example

Is this intended behaviour, or perhaps an issue?

 Thanks,
 Fernando Chorney
