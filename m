Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D22D2021E
	for <e@80x24.org>; Tue,  8 Nov 2016 09:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932694AbcKHJTW (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 04:19:22 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:50542 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbcKHJTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 04:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=subject:to
        :references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=pL8nvYOOQrZSRS
        RkrrFocpp0e3TEz3do6njHbkdRWGg=; b=oaeCV0dAZskOvwVytAWYcBhYhvngJA
        yPXPjoTM72yUrOm0jpeFGB6MzLQCRW3nutglrGiw6Hy0jcM4WzBuALSsi+4b3lgA
        Z4O8W778S46HDtqSYEHPMINgczcYAaweV0eCrW+En90L8tqnlhDnKjtAnO4oDoK/
        qIJWxUl2Kqf0I=
Received: (qmail 10686 invoked from network); 8 Nov 2016 10:19:13 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 8 Nov 2016 10:19:13 +0100
Subject: Re: [PATCH 0/6] Provide for config to specify tags not to abbreviate
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
 <22561.8757.914542.10409@chiark.greenend.org.uk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@samba.org>
From:   Markus Hitter <mah@jump-ing.de>
Message-ID: <0d7ff8e5-230a-c6e1-6663-eaecee5d5620@jump-ing.de>
Date:   Tue, 8 Nov 2016 10:19:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <22561.8757.914542.10409@chiark.greenend.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.11.2016 um 01:54 schrieb Ian Jackson:
> Please find in the following mails patches which provide a way to make
> gitk display certain tags in full, even if they would normally be
> abbreviated.

TBH, I see a violation of tool independence with the choice of preference storage. Abbreviation of tags isn't a property of the repository, but a pure visual thing (screen real estate, whatever), so it should be handled by the tool doing the visuals, only.

Your use case looks like a nice opportunity for

- adding a Gitk user preference on how long displayed tags are allowed to be (instead of distinguishing between abbreviated and unabbreviated ones; set it to 999 for your use case) and/or

- even better, abbreviate them depending on the size of the visible area, like a web browser would do, and/or

- considering whether tags should be abbreviated on the left instead of on the right and/or

- finding a mechanism to show them in full length even on small visible areas.

The latter could be done by a tooltip appearing when hovering with the mouse over an abbreviated tag or by allowing multiple lines for a single commit in the list of commits.

Trying to enforce long names just means they're not cut off by the abbreviation algorithm, but by the right boundary of the visible area.


My $0.02,
Markus

-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
