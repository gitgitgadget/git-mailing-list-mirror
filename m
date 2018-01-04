Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6036B1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeADTTi (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:19:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45618 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbeADTTg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:19:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B18A460850; Thu,  4 Jan 2018 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515093575;
        bh=4X/YF5SoBLq0BVyUBswHL1/wwFSunzEqqceB0kC2MYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1e2JVBAwYPC6bWulOdDr8Z+hfQdijGFj3jCJN2ZBcT5rvYqk1uYIuaa9ZB2antat
         SfsnJHOAx/WqAYTrGVpONOlZnN2fKP93EBDsptxjtD0WRRftAgOftNX6v1h8CQ4rwi
         hXsitI5ttl3B4ltzDLcalC1bzXzhhD8N5LDNzIUo=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D78360850;
        Thu,  4 Jan 2018 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515093575;
        bh=4X/YF5SoBLq0BVyUBswHL1/wwFSunzEqqceB0kC2MYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1e2JVBAwYPC6bWulOdDr8Z+hfQdijGFj3jCJN2ZBcT5rvYqk1uYIuaa9ZB2antat
         SfsnJHOAx/WqAYTrGVpONOlZnN2fKP93EBDsptxjtD0WRRftAgOftNX6v1h8CQ4rwi
         hXsitI5ttl3B4ltzDLcalC1bzXzhhD8N5LDNzIUo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D78360850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Carl Baldwin <carl@ecbaldwin.net>, Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Date:   Thu, 04 Jan 2018 12:19:34 -0700
Message-ID: <2180514.YZ24uruNv3@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-125-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <CA+P7+xpvuCjdnjyQxQg3B5iMwbnx-CerQMAP+bDQHR_-ALJOkQ@mail.gmail.com>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com> <20171226060229.GB18783@Carl-MBP.ecbaldwin.net> <CA+P7+xpvuCjdnjyQxQg3B5iMwbnx-CerQMAP+bDQHR_-ALJOkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, December 26, 2017 12:40:26 AM Jacob Keller 
wrote:
> On Mon, Dec 25, 2017 at 10:02 PM, Carl Baldwin 
<carl@ecbaldwin.net> wrote:
> >> On Mon, Dec 25, 2017 at 5:16 PM, Carl Baldwin 
<carl@ecbaldwin.net> wrote:
> >> A bit of a tangent here, but a thought I didn't wanna
> >> lose: In the general case where a patch was rebased
> >> and the original parent pointer was changed, it is
> >> actually quite hard to show a diff of what changed
> >> between versions.
> 
> My biggest gripes are that the gerrit web interface
> doesn't itself do something like this (and jgit does not
> appear to be able to generate combined diffs at all!)

I believe it now does, a presentation was given at the 
Gerrit User summit in London describing this work.  It would 
indeed be great if git could do this also!

-Martin 



-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

