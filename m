Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622F420133
	for <e@80x24.org>; Fri,  3 Mar 2017 20:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdCCUbG (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 15:31:06 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:33215 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdCCUbF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 15:31:05 -0500
Received: by mail-it0-f65.google.com with SMTP id 68so3555827itg.0
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 12:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmfhYkmLpTqxoFcEQ4MeC9D/tu50hpUFiipBXSBXMBE=;
        b=u92L/GhUSNiVnZCCy/artyEXWwwaXmpNIKP+qmDphGGhS407QeoWkH4yjj65INa0UD
         aC5Xsv4PpUivuYWHLE+fy8LFSkrHgk+eAl5uQQftHNRnx3HgwjzXxO6QyOH1L0aFOTm+
         zQsVsVQJkRV5a+LsSoRFC6vqp8AbwGo/JP0S9dwAjWgajyG6UcuZbJGNLeB4fv5LcRsb
         3Bd5EGWTeMQw+RxlVhYmJYuKPUbO6zVh3WwBFIC6Zwv0UIY7EVMw9ostFMP/ByPepG5C
         DVMO9SMN4bWN3u0vBpTKEHLc8lVLSAs/3wSEF1HC7jL91xPB1G91SRdJxSgaVMB8qb6+
         dilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=mmfhYkmLpTqxoFcEQ4MeC9D/tu50hpUFiipBXSBXMBE=;
        b=i67tISVMFPSxeJ3ojedChj9Qq7UHx5Ot6WKvNgBCuJaNwMF0vvl7hnQEX/cBMikd/W
         Q/erjk179nuOzCf1ZPtYQ8SR1JE/I9P3QwJkAoMBBoT/Zeu7PB56Tp9l1uwcatb12/nd
         +vRp96yTPekjozV44BEPuCTZpY2nElERqdzLo1zu37IlW+OJ4cq0oZYpSmZHLpQGgaWW
         TzX8xdujgoGBI2CfCI1NYoKP+fkeOOG7rRq6sZ4tcZyS03JGs+clvFV2YdVuVMCkfer9
         LQ8gXSBZaGVekH9O9PjJZODt7EGLvbsksqxtK6e+//dlCTGJ483I1MfDsEmNU9lgQHdH
         KoSw==
X-Gm-Message-State: AMke39lTqVin8qW0kYez9aJrZ0LVJ9cU1m0IH1o9/odjTHqcX++gR941EH2a6S++/ewVlw==
X-Received: by 10.36.80.66 with SMTP id m63mr4590526itb.62.1488573005571;
        Fri, 03 Mar 2017 12:30:05 -0800 (PST)
Received: from prospect.localdomain (wcnat-96-27.wheaton.edu. [209.147.96.27])
        by smtp.gmail.com with ESMTPSA id k186sm181530ita.30.2017.03.03.12.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 12:30:04 -0800 (PST)
Date:   Fri, 3 Mar 2017 14:30:25 -0600
From:   "Devin J. Pohly" <djpohly@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] filter-branch: fix --prune-empty on parentless
 commits
Message-ID: <20170303203025.GA4763@prospect.localdomain>
Mail-Followup-To: Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
References: <20170223082736.31283-1-djpohly@gmail.com>
 <20170223082736.31283-3-djpohly@gmail.com>
 <xmqqbmts7gjm.fsf@gitster.mtv.corp.google.com>
 <20170223213333.GA3490@prospect.localdomain>
 <xmqqshmvbhe5.fsf@gitster.mtv.corp.google.com>
 <20170303075535.rxij4knd7d4ayfev@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303075535.rxij4knd7d4ayfev@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 02:55:35AM -0500, Jeff King wrote:
> The only objectionable thing I noticed in the test additions is that
> the early ones should be marked test_expect_failure until the fix from
> 3/4 flips them to "success". Otherwise it breaks bisectability.
> 
> -Peff

Good point.  Will fix in a v2 set then.

-- 
<><
