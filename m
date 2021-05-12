Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MISSING_SUBJECT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFFCC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9797161628
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhELDDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 23:03:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36997 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229932AbhELDDG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 23:03:06 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AFE485C00C1;
        Tue, 11 May 2021 23:01:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 May 2021 23:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:message-id:mime-version
        :content-type; s=fm3; bh=+zOdfJeDhF/hMVpsry9FOZbQqegRBqdJcWjSsIi
        6eCY=; b=TVzkKkTs1fgF0L3QEMFnF/Oq9ftDPTpNFCGv5qIKngNOXdIoh4XWpjG
        p16JeJpsuT1e7Dkx9OXcOHuZFDJAhYcXRFsYt+QHMMK8vGTUAiFE+TRIPlMnmR/Y
        CCEQhTDCL8F3WgiKQCOhDgTTYWFO/jIlifRd4S2nzIgTxb2Y6HIjLLtLhENVgzxA
        jrBGDuiBhh4WV1GmG1MOCTYnbOZzskjME/AS3eSDpPJek8VwzhWiP/yIwvMX2eTl
        CC1w+oX1nOJC3uyu15F9GxdePav4KaeskxXus/8D7GcWk5e7jWISk9ysHcL0PiK4
        FjlMLgqNVY6a6GgG+/d+kMr5qjmHHGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=+zOdfJeDhF/hMVpsry9FOZbQqegRBqdJcWjSsIi6e
        CY=; b=J+L/p9tb8yVVNYN6WLKa6u9D0hmmJcGfSyYqjEf2L11WbQj1femaO0y7/
        tXfM/5sUQXz1SgEPpNSn23g/dsIsHwN//+1icOfT+zeDE9FZcMp+RHiauPQEi0dN
        harxkONRf0leqSAxxD8k0+1UERHK/RXZFV11wme+szzSPmDMmQ8Qx31H2Ns+51Ld
        5qURHVYB51Ee5bwW802R85mtAH8oWVoFF1UULEei6tKbmyOPzq1Xfg2FLCNuWe8t
        P5eaBQs95WQScrj9hInagmdaiTbVe8lX1drprloWX+EcJReGvCmUNjTSU2CvCVPo
        0rU4L8aEzgQ4ZAS6acPTB85VjHWAw==
X-ME-Sender: <xms:JkWbYEl8cQmuuLFWzmVhvBVnQLrR3JvVp6tPrWmI7nbYeNZIqvJwEQ>
    <xme:JkWbYD2dPSRJkqu-pUqn25l_Gz8YEctrjeN8rqnqYH5SW1sAvQjEWvsDyRLtlX4Ye
    ZUgQmPEI8r-xA4n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehuddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucfgmhhpthihuchsuhgsjhgvtghtucdluddtmdenuc
    fjughrpeffhffvkfggtggufgesthdtredttderjeenucfhrhhomhepffgrvhgvucfjuhhs
    vggshicuoegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteegffeujeegieffteeiiedtgeejudfhfedtjeeggfdthfdugfetveek
    jeegudenucfkphepudejgedrhedvrdduhedrfeejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugifhheslhhinhhugihprhhoghhrrghmmhgv
    rhdrohhrgh
X-ME-Proxy: <xmx:JkWbYCoZHZvm7PGAmqoaTJ9BQseowo8zISlJb9qI9hBlmYSbj9ymVA>
    <xmx:JkWbYAnfmhP2eo9xxcnOfSacfL4BnPYCY3t_leO8qeNx9TOu6mx9lw>
    <xmx:JkWbYC3R4iMzEcU42M3wkhvv1pit_N0a4Dj4S6163BxmafMOPCBTCA>
    <xmx:JkWbYLhaL_06aA7naKAFUsqhdOcmDIXbvLOnDVydQSLNzML4q9saIQ>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 11 May 2021 23:01:58 -0400 (EDT)
Date:   Tue, 11 May 2021 20:01:56 -0700
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, filipe.contreras@gmail.com
Message-ID: <20210512030156.GB1899@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitster@pobox.com, stefanmoc@gmail.com
Bcc: 
Subject: Re: [PATCH v1] Writing down mail list etiquette.
Reply-To: 
In-Reply-To: <20210512025746.GA1899@localhost>

Aaaaand I also forgot to Cc: all of the relevant people in the previous
thread. It's been a long day :)

Cheers!
Dave

On 11.05.2021 19:57, Dave Huseby wrote:
>Doh! I forgot to make this patch In-Reply-To the previous thread that
>sparked this discussion. Well, at least this patch email doesn't have a
>Mail-Followup-To header.
>
>Cheers!
>Dave
