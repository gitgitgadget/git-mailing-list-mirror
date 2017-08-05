Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0EB420899
	for <e@80x24.org>; Sat,  5 Aug 2017 19:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbdHETGE (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 15:06:04 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:32841 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdHETGD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 15:06:03 -0400
Received: by mail-qt0-f177.google.com with SMTP id a18so24116103qta.0
        for <git@vger.kernel.org>; Sat, 05 Aug 2017 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=/XiLtBuvlKlPekVGPnimykcmuCCtGOt6BsTfP09+oF8=;
        b=Wi0zIxB8RoCLb4BNTHaIGLk/3rGHg3KEpZD6FOa6AcdMtgQvO+HRtBrQbcX2Iqoxnx
         X3ruJ+ro77LeFi2E+Hm7WMAP1KYxjZbi4c8n+dQAZ3O/s7gmk1vmNK0vwVcr5LrPREBa
         HmHm9hQOkZTA/xTzcJBXRZuKZk5C5yncdboSD+QlY/GrRKHoEAWsQ0YWxkm7CsTu3QDp
         LF/gjcvCAY8W1iuFS3IosJNf4iMEmlZqX+B7FWjEok6PNvJ4ZI684xvKGLuYL6b6p1Le
         yLhFQ356R34pfFo7Ac+Iv7IheHbwXoStMtRMUFccJMtw9eCJn5Vh8msnTI+OZhsGxFW6
         D1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=/XiLtBuvlKlPekVGPnimykcmuCCtGOt6BsTfP09+oF8=;
        b=UydPERk21/D6GclSZX+fCmcKL2L4znN7vlMLwyWLt7DryKElaHNYy3xpXlN6LXsGmy
         mn353cuqnsWshi9U2dA8pDx5niFh30neYdCUH/bPhTjqanxvFpZg1DYn62DaKPotAVde
         /CNnOQLDyk05LGZLA9Wpq51+htyi8FB7gG83Ai47UiyjTS0k9J2IPIxgVNjBzPjQA6C6
         YLb8WLn9M6oZCNji0nn/o0zGQEDOi5rFGeU9hE3WxyKBd3B2qE+Lir9zJw7mpRtw5dim
         iQxUYZjNIfXY+DrKm+q4kb9L33zWVhaU92n6IhN9ZfdcJvp7EHTRFiP/XOQMNhQ73GFr
         FLkA==
X-Gm-Message-State: AHYfb5hLjUJ7QWqpWJLRHrr05DCHjkMhEs+mxf0AnnqvFfFfvjpPwZLV
        hJ0+QoqSidKoHzo/fFo=
X-Received: by 10.237.54.227 with SMTP id f90mr9363469qtb.256.1501959962486;
        Sat, 05 Aug 2017 12:06:02 -0700 (PDT)
Received: from localhost ([99.29.115.58])
        by smtp.gmail.com with ESMTPSA id a123sm2899579qkc.0.2017.08.05.12.06.01
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Aug 2017 12:06:01 -0700 (PDT)
Date:   Sat, 5 Aug 2017 15:05:53 -0400
From:   Stephen Talley <stephentalley@nerdysoftware.com>
To:     git@vger.kernel.org
Subject: bug: git stash list =?utf-8?Q?--format=3D'?=
 =?utf-8?B?JWdkJyAtLWRhdGU9Zm9ybWF0OifigKYn?=
Message-ID: <20170805190553.GA12649@nerd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Markdown: false
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Synopsis:

When expanding '%gd' placeholder (reflog selector), git substitutes user-specified --date format, which mangles the reflog.

Description:

I was writing a script that expects a stash reflog and a date on stdin:

    % git stash list --format='%gd%n%ad'
    stash@{0}
    Sat Aug 5 13:26:30 2017 -0400
    stash@{1}
    Sat Aug 5 13:18:54 2017 -0400
    …

Since this date is going to be presented to the user, I wanted to apply my own date format:

    % git stash list --format='%gd%n%ad' --date=format:%Y/%m/%d
    stash@{2017/08/05}
    2017/08/05
    stash@{2017/08/05}
    2017/08/05
    …

Unfortunately this mangles the reflog as well (e.g. "stash@{2017/08/05}"), making it useless when passed back to git.

Apparently stashes can be referenced by date, which is fine I suppose.  But those dates should never be subject to user-defined formatting via --date=format:….

I'd expect the above command to instead output:

    % git stash list --format='%gd%n%ad' --date=format:%Y/%m/%d
    stash@{0}
    2017/08/05
    stash@{1}
    2017/08/05
    …

or at least always use the ISO date format:

    % git stash list --format='%gd%n%ad'
    stash@{2017-08-05 13:26:30 -0400}
    2017-08-05 13:26:30 -0400
    stash@{2017-08-05 13:18:54 -0400}
    2017-08-05 13:18:54 -0400
    …

Steve
