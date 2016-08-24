Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8412D1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 21:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755524AbcHXVAs (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 17:00:48 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34909 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756124AbcHXVAr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 17:00:47 -0400
Received: by mail-pa0-f43.google.com with SMTP id hb8so9797690pac.2
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alexnauda-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=h8JYFoMvodtSyMpYSMwcCacWuubJGC7T2et+W7NXxtU=;
        b=LafLo8KVQSZR+0ncA4migTGI/j6xhN8jbDIP5fjzi/M1D5BE03pGUEnD1qKb7SfR53
         SYXDrNhBWRz2UVcdxCwRUtw82Fg5vH/Qs6WefZVlS2ScExGzINkxQpKDvTPeVD0kMyFD
         5p4n/aUhk1miUxxt8x9LpdwHMkQDwFyohf+6mFJel/YpLCN7TNO3S2aNetldg5jNHWcy
         08mJ+WD9WXqyf384vrQHxgDBMk/Eiwo3C0FvoHtYqSLT4/CjNgHbxSN9NxseUS7qJAa7
         A7JsKDMHQiVOFEhTYXhItY9/CkA3bVZYqLhX/WZpCdcoYEVP0FbvUTSdBz+cEFBNzT6a
         ldXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h8JYFoMvodtSyMpYSMwcCacWuubJGC7T2et+W7NXxtU=;
        b=kD4ICfKFZOcmI8TlwUv0x5BdEMQo4kL2PaUAHR1DhZ+s3/RGHd0LVDq9Hrl2BAYLj6
         1tVam7fl87ZQQUwp+4Q5n5bpRxNDmZ23oSUbqQqXDkT7OxZTd7ClC7yNBS1jtvY4OhU3
         MuJKic5itYXFSsELIttD5SXO9VED0auVySenN5IHoUjb0nvljYD2AxBS/okms0gft4Wg
         gOaJPs1K1ExAyYFLvSJaDR+WuW7N6H5EGgcZ7KK/6ErAnbVtmYG7swvJ77BQ1fnsX6EL
         usyLbwPCzljl9gxxWp9DnGqyjdEdlsvEIeVwMlWiR5MFWQkutC+rOoN50JhftNiyOYp6
         C1jg==
X-Gm-Message-State: AE9vXwO2ua1HljdlI6cGlBwsqToRMCYIQiuwmZAPb59E/EzD27HSDyTpzfqsyGTJG6X05Nyn5nbWzFT7bGY04w==
X-Received: by 10.66.181.139 with SMTP id dw11mr9583771pac.2.1472071953827;
 Wed, 24 Aug 2016 13:52:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.67.4.229 with HTTP; Wed, 24 Aug 2016 13:52:33 -0700 (PDT)
X-Originating-IP: [54.208.66.34]
From:   Alex Nauda <alex@alexnauda.com>
Date:   Wed, 24 Aug 2016 16:52:33 -0400
Message-ID: <CAMQLHmAraXPL=8SmMG4X_424FAzx4q2Byk8pva5wEOg7vNSqLw@mail.gmail.com>
Subject: on Amazon EFS (NFS): "Reference directory conflict: refs/heads/" with
 status code 128
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elastic File System (EFS) is Amazon's scalable filesystem product that
is exposed to the OS as an NFS mount. We're using EFS to host the
filesystem used by a Jenkins CI server. Sometimes when Jenkins tries
to git fetch, we get this error:
$ git -c core.askpass=true fetch --tags --progress
git@github.com:mediasilo/dodo.git
+refs/pull/*:refs/remotes/origin/pr/*
fatal: Reference directory conflict: refs/heads/
$ echo $? 128

Has anyone seen anything like this before? Any tips on how to troubleshoot it?

Related Jenkins issue: https://issues.jenkins-ci.org/browse/JENKINS-37653
