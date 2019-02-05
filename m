Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7291A1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 16:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfBEQ0l (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 11:26:41 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:43645 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfBEQ0l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 11:26:41 -0500
Received: by mail-it1-f201.google.com with SMTP id p124so6509765itd.8
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 08:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yEoYdWBeYuvnMUt+BcxO8pTBnFQZgq0bvFvGiSLzWqI=;
        b=o4aGoB1/ufm/fF4ODsAM9oD5jWUn+af588ujq1ICcV/fIVuTosmfGrl9tpbDI2oYjz
         UY6g5B0eyr4WhKh+UUEf499zE6Ct+mQopav+t0hvB2BvVk2TZ49TAhSgYr0e88DwJ1ng
         z8mwNoUUARIKcR4F8IQqS1UDq+q1dn5huBd0ZUBoFnTUMUX6IFYHTZM+Z7JrH9CYw9jK
         SvOOCituWkjfImyxKL4Ym/971unoKeadvTwXZV/DjoVyTTxQ21h2MEgvzOeMjMcpZBhF
         NdeuW2OYXU9hE4Dvj0Sa1IP/fhYrmOG9Tks8+bQo5K7LMwnj2OyrpcKkKDUb3Jvq0k1e
         vPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yEoYdWBeYuvnMUt+BcxO8pTBnFQZgq0bvFvGiSLzWqI=;
        b=U4IdL80id4y6Ioa0vwgflnrj47sv8c0Pf5LUThY0tZKFg9mUDom8u3i8zUkzjJccro
         O/reTZfRy3A2pdGbsRRcFGoz7kGwGZrdPbPZQpdC6ciEyXLdBLSDPGXvTrcm2b4m1/Mi
         nnTwEhqOj/ioyKIWeesKV13lGIx9oGBxEtVYr1cmPBqHluSfiipOdTIS4qk3ApHEnXRy
         cHgZ3yyRKUDVUZJ5DXvMEY6fA2dItcVNvDTq7ui/Uy7O5LwyXBx5uozTzy+ieJKSFgSq
         eHysKrSruJI5mum8b43FMqsSsqVxpE7pH+tY9Wojv/9+vM5QpxmyyWBRQStD00O4GB1C
         baDw==
X-Gm-Message-State: AHQUAuaNV8iK/QJHNyMfn97/VTIFH5bXbW/X2P9Iep/p34KDV+dTSJHZ
        7xH85Pi78YmpH1vPWQn7dN8PaoWKqj1Lr58/AjKi
X-Google-Smtp-Source: AHgI3IYwEqVniZlzBRBYbhiOYxDlcnTBKWuKwSXpYVYJf7HgrdeBZ+fetgxCKVSYfLhRCum9oQnkLL/QIFT5bKRWSZNm
X-Received: by 2002:a24:5948:: with SMTP id p69mr3445045itb.21.1549384000417;
 Tue, 05 Feb 2019 08:26:40 -0800 (PST)
Date:   Tue,  5 Feb 2019 08:26:36 -0800
In-Reply-To: <CACsJy8CvVPr+OJ04aLGDeAS-o5__x1+3cKQNuq2+qba5gw5W+g@mail.gmail.com>
Message-Id: <20190205162636.128901-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CACsJy8CvVPr+OJ04aLGDeAS-o5__x1+3cKQNuq2+qba5gw5W+g@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH] fetch-pack: clear alternate shallow when complete
From:   Jonathan Tan <jonathantanmy@google.com>
To:     pclouds@gmail.com
Cc:     sandals@crustytoothpaste.net, jonathantanmy@google.com,
        jrnieder@gmail.com, sbeller@google.com, gitster@pobox.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Feb 4, 2019 at 7:06 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > When we write an alternate shallow file in update_shallow, we write it
> > into the lock file. The string stored in alternate_shallow_file is
> > copied from the lock file path, but it is freed the moment that the lock
> > file is closed, since we call strbuf_release to free that path.
> >
> > This used to work, since we did not invoke git index-pack more than
> > once, but now that we do, we reuse the freed memory. Ensure we reset the
> > value to NULL to avoid using freed memory. git index-pack will read the
> > repository's shallow file, which will have been updated with the correct
> > information.
> 
> It may be worth mentioning bd0b42aed3 (fetch-pack: do not take shallow
> lock unnecessarily - 2019-01-10). I believe this is the same problem
> and a full solution was suggested but not implemented in that commit.

For reference, the full solution is [1], linked from that commit's email
[2]. (Looking back, I probably should have included all the information
below the "---" in the commit message proper.) The full solution is more
related to shallow locks, though, not alternate_shallow_file.

[1] https://public-inbox.org/git/20181218010811.143608-1-jonathantanmy@google.com/
[2] https://public-inbox.org/git/20190110193645.34080-1-jonathantanmy@google.com/

> The problem with dangling alternate_shallow_file is also from that
> commit.

You're right - thanks for noticing this.

> When line_received is false at the end of
> receive_shallow_info(), we should clear alternate_shallow_file. I'm
> still debating myself whether we should clear alternate_shallow_file
> in receive_shallow_info() in addition to your changes (which is good
> hygiene anyway) to keep the setup steps of do_fetch_pack() and
> do_fetch_pack_v2() aligned.

Clearing alternate_shallow_file when line_received is false at the end
of receive_shallow_info() sounds like a good idea to me.
