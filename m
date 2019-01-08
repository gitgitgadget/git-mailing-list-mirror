Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1ECF1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 23:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfAHXgu (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 18:36:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38658 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHXgu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 18:36:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so6250296wml.3
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 15:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e4bg12GBMfvseXKMtip8Fw3Oa77eJHUy0pb8GaRnNoc=;
        b=hMLcZzDM2S2g4tVc88cntVOE7xWpzJxwwuUD50tvgV2DlbJsEsgW8DGuvdTOGoBZmp
         gNcZ/cWDhkc4Kbnd9fJprOsyTbZqtHqatjN6p3eq0M/9eHtwiNzFVEtHHUHq1RO9hoKw
         pehbw+tslzT2fJw1V15tkEG5h0fn6hf72+4y/tkKEuuVWBu4dy/+yqklGwoMhWOtZBnF
         KjYy5K099YH8IrT+I6pf+A4c70A3R6F6GCxHC3mQYKS/uaBlBtWXrLfElxN2nx3rNt0Z
         sqCGNnlpSNSnhHfCIEsBO67A32eZqYwaTa1NNVk4AdY+NOAUT42k8SSDteQwAe7457lT
         NXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e4bg12GBMfvseXKMtip8Fw3Oa77eJHUy0pb8GaRnNoc=;
        b=Dl71zr1fO5ywp97ZZdyTVYKDAzlaRoAB2+b7o/gfM0LhDVqkd2P2aBLwCN6CnygUqA
         Jy+RX0G4mBTuaeojSFHiRTO7iLcGBBh/mhicc33+zSvFc41F7R+eEQ0GLVaJyt8tugfb
         m0YhtVeyrvKIBhcWrEcHzab1FW3YZXwYG4U9+JyxciYtX4j9IJ+UCt+D0gQKpdYIlW4G
         l9xDZMamGVkWJ+WRrmSJOiQZkxsD+nHmlqLZWIezPbj6IOrrtYOEhYrMC7eNyMScnm16
         7DzPeIcCtCNTGU3xHsxyZUTvOhKtSwB0rKdBIrOzaJziTkHXnCGlYRYfLx3Lls3Nr1jk
         auoQ==
X-Gm-Message-State: AJcUukfHu/9ONU4KaI+PDUvT0iCdrSqCjBlM/dc0E0mrh+Kp/0OC/Xst
        SB3O5sb9czay/27Rs+Um6XE=
X-Google-Smtp-Source: ALg8bN6b1WhsD9k6AabvI3hcfmE57Eb77ca/EZ3NGMB/YywNvdo3m3x15hgNqxcLMSSND6cmFuag8Q==
X-Received: by 2002:a1c:e345:: with SMTP id a66mr3234119wmh.12.1546990608505;
        Tue, 08 Jan 2019 15:36:48 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n9sm44866674wrx.80.2019.01.08.15.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 15:36:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@comcast.net, matvore@google.com, git@vger.kernel.org,
        sbeller@google.com, git@jeffhostetler.com, jeffhost@microsoft.com,
        peff@peff.net, stefanbeller@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v2 1/2] list-objects-filter: teach tree:# how to handle >0
References: <54fba0d3-4b8e-1faf-4b2d-e67c1f5fbf02@comcast.net>
        <20190108231945.36970-1-jonathantanmy@google.com>
Date:   Tue, 08 Jan 2019 15:36:47 -0800
In-Reply-To: <20190108231945.36970-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 8 Jan 2019 15:19:45 -0800")
Message-ID: <xmqqftu24t80.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> For your reference, here is an interdiff for this particular patch after 
>> applying your comments:
>
> The interdiff looks good, thanks. All my issues are resolved.

Just to make sure.  That's not "v2 is good", but "v2 plus that
proposed update, when materializes, would be good", right?  I'll
mark the topic as "expecting a reroll" then.

Thanks.
