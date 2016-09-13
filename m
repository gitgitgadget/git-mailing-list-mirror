Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F2A20984
	for <e@80x24.org>; Tue, 13 Sep 2016 21:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756512AbcIMVmT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 17:42:19 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35860 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbcIMVmS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 17:42:18 -0400
Received: by mail-it0-f42.google.com with SMTP id o3so16858231ita.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 14:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hVS7ZJH68dAJ0vnJQ2Rk2uuZKn8lcbb953FK4RGoxJw=;
        b=d6OFn52RnAjM1BiYJMZTOuyOamBaQPqNHbCx20B59YWVMprY2j7NANtDTr1dwc2jWP
         wJmpFkJFPZXtbRt6c9IqM4rOawpv3+M00EzFOLthfjU9An5VE1Ek9YAIodphsoI1npj+
         BIu/S6Pxf2nrr++Y81F1RUpkLiQB8wIvVK8vJ+4w/cMxf55PsPJVnEunoM2u9lUWAX2I
         wbA5oYMrQ1QweZWZBHpwPLoFihJFXmv6QXTwA7HdQwjo2EuSj7mq5AGNwbjHd9Xrfz55
         UOf0XrgZ2/j4ZLXX4cHu/IeAY3XqTS+P6VuOft+tmvzroPBz8iZWvdfRGdCzlRMk9diO
         3EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hVS7ZJH68dAJ0vnJQ2Rk2uuZKn8lcbb953FK4RGoxJw=;
        b=Fch1ePs6LqBGGuihm+IRjjmKBFEmrLEMRaIjmYI+B7MRd8LDLhWcDn7UBhzl6ZsAwe
         NXAD4qscwz4ZeYyvOhHykjtdaQ+GtE7MiXXznTlgJdTlmSMBPuOUx6F6XZta1qOL3Uvr
         +hgFQr62w/HbFNHo9UYdZ+ROFETHojzeAANc91yHS4/r05mnqNocry/qL/rARVGtAQBr
         mY9NmOf8nmUsEW+BeOa+e4sd2U3Cb8cZG0+qaa1oW+cqNXTw/Ddo+d31dYNZJUzRoOKa
         B6gxqG8S2JPjijSKYGIEeWk7UT6+oH0UBIBv3He9hOrQPVLJaSrB0dteW9kFi4kM/i/G
         lSXw==
X-Gm-Message-State: AE9vXwMxqSDrpFAl7ajgl3WI/9kjKuGrpf6BgRFj6Q1wR5JHgClHUandHgCqI8qkgNHkX8y6zt6NI7LEW3t9+lHW
X-Received: by 10.107.20.67 with SMTP id 64mr5168439iou.165.1473802937133;
 Tue, 13 Sep 2016 14:42:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Tue, 13 Sep 2016 14:42:16 -0700 (PDT)
In-Reply-To: <20160913032312.yheky2o25lmibvmb@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net> <20160913032312.yheky2o25lmibvmb@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Sep 2016 14:42:16 -0700
Message-ID: <CAGZ79kZQd2+TyceLmnTcv6rNGeKuyQhtvepvzcHw48WqOL4J4Q@mail.gmail.com>
Subject: Re: [PATCH 01/16] t1007: factor out repeated setup
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2016 at 8:23 PM, Jeff King <peff@peff.net> wrote:
> We have a series of 3 CRLF tests that do exactly the same
> (long) setup sequence. Let's pull it out into a common setup
> test, which is shorter, more efficient, and will make it
> easier to add new tests.
>
> Note that we don't have to worry about cleaning up any of
> the setup which was previously per-test; we call pop_repo
> after the CRLF tests, which cleans up everything.
>
> Signed-off-by: Jeff King <peff@peff.net>

This makes sense and looks good,
Thanks,

Reviewed-by: Stefan Beller <sbeller@google.com>
