Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A22B71F404
	for <e@80x24.org>; Fri,  6 Apr 2018 05:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeDFF3F (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 01:29:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43531 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeDFF3E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 01:29:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id j2so10151880pff.10
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 22:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Da8SwNvgw6IpqKAHv+ZjR1TD+t2lP1lTFGOiz2BtByk=;
        b=cI86lACIahd/AkcqkURyGMX/OYT+nFVu9etiQj45HdSrU/VxvEyOi+ypO817CxmB1V
         eGFd0pIzcvZ9KKKwywXNpZB2i480+5pLrB58WuDDY0U480vWkyHHxtVP8AwDleXzu0Aa
         4E5t3u4xVn+AxDG0duavg5fDQ19+Vki+c7fLSeF0zS+zwkZ466NA2mj3BpfErHK0TDRn
         zhFUqYy6bkKatUOzUNcaJqmGlvmLsZ4ympisvITrc2zUca+iM7+Sd/Mfe3zlV+CfNs84
         xAtdzQKkTcwyWC4SQ5XcL7+27NWt6o3vkiodD+2HUFo/Q8ouHhLTStLtLDoaAoe/Q9uu
         4cDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Da8SwNvgw6IpqKAHv+ZjR1TD+t2lP1lTFGOiz2BtByk=;
        b=skzsWwk9w9OLl/KUa4DawmCw1RV7xk5Sp+1CHWim3h4fHduBDR+nf8zfZO/s4V7GeH
         eCJ7GmbN3BHw9cMO8/jFtSYCD0CV4Zef/JMChCsgBSFf4H6zYQNtzUheXnrX32PZ/f+d
         5Y0f1LxxoqefcSji6h8OXGjEBL3/7W0po7ClAMerIYpJtkWCv1bhz7S9VEbEwlUYclMI
         kF+ayWsTqTGTXcUYqnuCqFGZtWv9zevVjCaM1muWRAI9d71ZZo+rFNk8ABnfGxM4RPYo
         Wus3mu0SDlrcOOWXWkE+IPsH5j3BwHfyIrE54uRdN+eNKzJ9O0p2wKy4S1O9+M8m+PuA
         xSEg==
X-Gm-Message-State: AElRT7FTl0NumwGbV1qlBn9gEXA6j8Wjqv7Bw2s1LCdLVg1c/KGXDYdd
        p9Kc0ub1Nj8yOqaVRPctV32cKdC5r4E=
X-Google-Smtp-Source: AIpwx4+MJ6DaHCHAQ/11cP0LzVlpHXha+czALpinSCjMdEPIdsyKJztAbe3uUwYmb1dA7gpbTrEzlg==
X-Received: by 10.99.54.73 with SMTP id d70mr16333950pga.86.1522992543060;
        Thu, 05 Apr 2018 22:29:03 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id z127sm16881266pfb.72.2018.04.05.22.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 22:29:01 -0700 (PDT)
Date:   Thu, 5 Apr 2018 22:29:01 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v5 0/2] builtin/config.c: prefer `--type=bool` over `--bool`,
 etc.
Message-ID: <20180406052901.GB60769@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329011634.68582-1-me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

(Apologies for the noise of accidentally sending an empty template cover
letter. Here is the real one :-).)

Attached is my fifth, and anticipated final re-roll of my series to add
"--type=<type>" to "git config" in an effort to replace "--bool" with
"--type=bool".

I have changed the following since v4:

  - Remove extra space when redirecting in t1300 (cc: Peff).

  - Clarify the effect of using "--type" in Documentation (cc: Eric).

  - Document "--no-type" in Documentation (cc: Eric).

  - Fix an outstanding typo in Documentation, "input output" (cc: Peff).

Thanks as always for your feedback -- I look forward to having this queued.


Thanks,
Taylor

Taylor Blau (2):
  builtin/config.c: treat type specifiers singularly
  builtin/config.c: prefer `--type=bool` over `--bool`, etc.

 Documentation/git-config.txt | 74 +++++++++++++++++++---------------
 builtin/config.c             | 77 +++++++++++++++++++++++-------------
 t/t1300-repo-config.sh       | 29 ++++++++++++++
 3 files changed, 121 insertions(+), 59 deletions(-)

--
2.17.0
