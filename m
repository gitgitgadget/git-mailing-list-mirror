Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A726220248
	for <e@80x24.org>; Thu, 14 Mar 2019 17:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfCNRUl (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 13:20:41 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:33568 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfCNRUl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 13:20:41 -0400
Received: by mail-pf1-f178.google.com with SMTP id i19so4309858pfd.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grande.coffee; s=omgwhathaveyoudone;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BNukpwzTf6wPI0fe19jPmQQagNGeCgGTCjn717c+crs=;
        b=KmYukHRii6Vsu40oC8vXl1X/JBvpWGBGwpklJjnwAIs9jpQAq93B2Do4gW+B1hzbzj
         ObPqYy6mwRmPswNE1uP/BGWJD+KiN29Tcg/jkthJ5k/0YuVqIVYHX1Pk66B2y03rXXt1
         /lkW4siIWtiGAQlJg5C6L8SOSxipCHhK63fwhPvVaPpYVfdPS+zdOxGzT0ipcuXtMDh1
         PwMj9YqReYbcv4u3KnAxTMwZFRKe9lIs1jFtYHyIolSmyhEBZKfMbjAwRfLrHjgECy2b
         41TByYQ8fcW2d1c6dzo+SpPQ1ycEV3jJTPspC2mqjCS/Xz1p3aS14vyYfyKsgpGgAmUv
         R6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BNukpwzTf6wPI0fe19jPmQQagNGeCgGTCjn717c+crs=;
        b=Fcti8sFZrPIwo/tk7R3Kmm0sJBdxvJkWukOvBnLiXYK0UKWjEuvnQZK1sUh+JthyIr
         FDIU04Z0JBC4M/L4KhJVDaqh/vTEihfbW2LAJcdIosOxvD/EZOadALmiIDqLp+iGuFkA
         pvTZWinmNNeGDbNXWFIUTsZOJorFbijr3LPR8tSq0SZWTE2gwuvx5C1AcGRaQFhKu4mP
         JYN2KQGn73NnSOXWFCVjOa3xwZ6YrixXeocMYWFgDkTMWodeX6uRUwiYuuP8ZRXN/6W3
         IOdZ52qbJNg1nN1qVTQtU+z32FSH+LycN+obqdZx1TSyu7BrigSMjwU9GOk3+DZxkK0z
         z52g==
X-Gm-Message-State: APjAAAXCBnI/aYkdEXPKQZ3Df5DK7g9dripU3rX44n5g6WPJpAFLHYlh
        qhmmPinDpAgNe4WE0Lyg6jNkCPjgWTbd9A==
X-Google-Smtp-Source: APXvYqxi6EIUMS5fcAltXcvC1O26IrPYsW/7XHCH6nkLiXhvGWtOftu8f+XSG3183ez1zKAaKuDwew==
X-Received: by 2002:a63:c307:: with SMTP id c7mr46492320pgd.386.1552584040499;
        Thu, 14 Mar 2019 10:20:40 -0700 (PDT)
Received: from chabuduo ([198.41.129.7])
        by smtp.gmail.com with ESMTPSA id h75sm40651873pfd.150.2019.03.14.10.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 10:20:39 -0700 (PDT)
Date:   Thu, 14 Mar 2019 17:20:32 +0000
From:   Alexander Huynh <alex@grande.coffee>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] fetching all remote branches results in failed multiple
 updates
Message-ID: <20190314172032.GA10461@chabuduo>
References: <20190307214447.GA4909@chabuduo>
 <20190307234015.GD28939@szeder.dev>
 <20190308000810.GA8044@chabuduo>
 <xmqqef7ikw9f.fsf@gitster-ct.c.googlers.com>
 <20190313234524.GA3053@chabuduo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313234524.GA3053@chabuduo>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Sorry to bother one last time. After a bit more digging, I found that the
problem was with my workflow.

Shallow clones set `remote.origin.fetch` to one branch, so what I was doing in
the past was overriding the respository-specific `remote.origin.fetch` with my
global config.

I've now changed my workflow to perform a shallow clone at first, `cd` into
the repository, and locally set `remote.origin.fetch` to
`+refs/heads/*:refs/remotes/origin/*`.

Thanks again,
Alex
