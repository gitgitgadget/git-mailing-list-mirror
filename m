Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46CA2013B
	for <e@80x24.org>; Mon, 13 Feb 2017 23:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbdBMXsL (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 18:48:11 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:35440 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdBMXsK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:48:10 -0500
Received: by mail-it0-f67.google.com with SMTP id 203so1319245ith.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 15:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fWzNRVAqUpn9go/HVMMpapKwvF7SKHYb2v3qCq+Bp80=;
        b=UBthyCrahDqyz7axWKO5pvhcROkJjKdxKn92boDvAHnLcJU0GJQZBr1K99VG1scf7S
         +EMMcDs4nvaHfB71VqG9KeTwL4o8DsQ9h+v2sZAQckT8MWtqiPhiF92Q02k/HORVRVoD
         ibih7O7lPnThnZ9d+Ve6rOU++AqiQvj67Vo1brUa3IbUcwlTd4T/6hCysSTDdsjuNHaU
         IX6XaFU1nCI0jNcFLsgC9W+3Dp138saTlh5M53WSiwgr16vbYuKngPoKKdj7mQXTaFKt
         UetIJAQBUSFIfPeeZlSp+uMqZLERF2mmFHG9aevbDcIMkSWzXEkcmzzyI0n36b20J9/U
         Ok0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fWzNRVAqUpn9go/HVMMpapKwvF7SKHYb2v3qCq+Bp80=;
        b=K5wVVx8SITSPDcPctAOJ468scRpPZ9PjoLiVBylNU7di6ywZhNzSoPvrosjiEe3oH8
         qrD+Stou5lbNWBbsyV1D0hUPIVJ3kxL+j/LB/3gqDWyRYOqk0Jws5bnQ/sQSKxGiGF2H
         gH50kh3QlwzJZIYfkIpfxO4TetB0ESAb6kVNIHVhsaf4XgWojQU7eoo2S3QpL0qDxa3j
         UjzupLK+oZqoteONLbQzwUcAsZT3TNJVjWxSMy9OB3iQins4PLDhwxx1SNel8e+Qg+xy
         TzUeoFPsC90/GQPGfbthT0YCoJIDArVTv1JtX3SoDo+thpcf663dhirH7wW45Z6sv00Z
         qaYQ==
X-Gm-Message-State: AMke39kUcBmlGDjv+hfMlFoeuUyYhITKEXMOHgxNDOUmvVWfMF2fbNyal8Q+woNoO6uSaA==
X-Received: by 10.99.228.69 with SMTP id i5mr29821309pgk.63.1487029689157;
        Mon, 13 Feb 2017 15:48:09 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id d29sm22870103pfk.83.2017.02.13.15.48.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 15:48:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] clean: use warning_errno() when appropriate
References: <20170213092702.10462-1-pclouds@gmail.com>
        <xmqqwpcudjoh.fsf@gitster.mtv.corp.google.com>
        <20170213191433.muwhz7zem64p3rxr@sigill.intra.peff.net>
        <xmqqk28tddwo.fsf@gitster.mtv.corp.google.com>
        <20170213211051.vsnnrtcsvuvfcwyk@sigill.intra.peff.net>
        <xmqqy3x9bvvm.fsf@gitster.mtv.corp.google.com>
        <20170213222210.dtfnxbbi77tsx4a6@sigill.intra.peff.net>
Date:   Mon, 13 Feb 2017 15:48:07 -0800
In-Reply-To: <20170213222210.dtfnxbbi77tsx4a6@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 13 Feb 2017 17:22:10 -0500")
Message-ID: <xmqq1sv1bqko.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So in that sense doing the errno dance as close to the caller who cares
> is the most _obvious_ thing, even if it isn't the shortest.

Yup.

> It would be nice if there was a way to annotate a function as
> errno-safe, and then transitively compute which other functions were
> errno-safe when they do not call any errno-unsafe function. I don't know
> if any static analyzers allow that kind of custom annotation, though
> (and also I wonder whether the cost/benefit of maintaining those
> annotations would be worth it).

Double yup.
