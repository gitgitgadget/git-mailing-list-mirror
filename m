Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9392320966
	for <e@80x24.org>; Thu, 30 Mar 2017 17:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933901AbdC3Rr5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 13:47:57 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36645 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933891AbdC3Rr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 13:47:57 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so45883385pge.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EWeKXfnMpkxWq0FMVv5DyEnlkzFla8Yl0nHeUjPsnhY=;
        b=t8BGZ9/AWi28le6Vi1ThqUzFJtieKfwq+hSuYWpLZ9krBCtNjy++kTTkZ7osTOsCF8
         PbuKOufNZjBB8ng7e1eYBsjmCeS72DMuUwhS5ns0+Wz6/Ny1rLdMuoLEVzSVduQq3EJ6
         rlrjCf8fbcR6Xu5dePrPIax+R7ktJMSlTnZDGlCRJDALGChz1+iirIt8j6VN1WYGNu71
         zR/BZCtTruP4u2D7MQb+dqHVABDoN0BLchdMJrgLIM0NbcSkYSWZsEi7PmMzD5ZTKEFn
         fGF9FiHaVWLE55ENIdvp7XT89HWQclq0Qk8QJItbdR1XUJhedXTX5dZxvI8Me3WqXKEr
         wYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EWeKXfnMpkxWq0FMVv5DyEnlkzFla8Yl0nHeUjPsnhY=;
        b=muMKuRB4jSOl66+Bou/3T0hFjANvIkf+fdBQSrv81qOLVLkAueXILpPxhLyneXwS2e
         YOF/Q6eQeYwNyiSrwHRT/tAgfeeiIS8T0Z4/RJpX+2VebRenLiwrG6pvM7rZHJJDz3yR
         ZFkgakDiF9ByH5XvfsBKE8rrxgq3MrDY6DP1v9znyacCKAld/x5xDJ9NXqHyP5mt8HS1
         BEw7/ZSzl5oxYd8duk9ZbDeAsf5O8Vd3RiGIfcA75ppe7Fp3t3OWGQUSXeTRIQqB0Q/N
         BtZyp4Ax8VVJiz27cfFd9eZkGCI/8K9bsaVhgmnNSwVjcBVdUN+Ls9H/pgNObYBC7QXE
         G0Og==
X-Gm-Message-State: AFeK/H3M/h9kb7uqguSzoN9UH3wver2Y2hyMHIbfjn1axZYMdOnmblgEGByarTt8kHMVVxFC/lcXteV9mLZlj/z/
X-Received: by 10.84.241.139 with SMTP id b11mr864734pll.107.1490896075636;
 Thu, 30 Mar 2017 10:47:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Thu, 30 Mar 2017 10:47:55 -0700 (PDT)
In-Reply-To: <xmqqefxe655v.fsf@gitster.mtv.corp.google.com>
References: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
 <1453877887-11586-5-git-send-email-chriscool@tuxfamily.org>
 <20170330032858.rdklpoipmvwjov4d@sigill.intra.peff.net> <xmqqefxe655v.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 30 Mar 2017 10:47:55 -0700
Message-ID: <CAGZ79kb68qbMx7hhmFzMtBeg8FqtVSLk_Gmp1iedqjy5s5up2g@mail.gmail.com>
Subject: Re: [PATCH v8 04/11] update-index: add untracked cache notifications
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        David Turner <dturner@twopensource.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 10:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Coverity points out that this is a leak (xgetcwd returns an allocated
>> buffer).
>
> I saw that quite recently and was wondering why it reported it this
> late.  It has been in 'master' for more than a month.

Because the repo/script for coverity was broken. It was missing
a hard reset, such that the merge conflict that occurred once upon
a time stayed in the repo and the checkout and merge of the newer
version did not succeed for quite some time.

I fixed it yesterday and will monitor the script more carefully now.

Stefan
