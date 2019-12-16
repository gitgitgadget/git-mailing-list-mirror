Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53033C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2988320409
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfLPPRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:17:14 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:38956 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfLPPRN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:17:13 -0500
Received: by mail-io1-f45.google.com with SMTP id c16so5371937ioh.6
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RiUg3FD3GatCoSffW1I2zEz/8KRONAr7kISAww3xD+U=;
        b=IHkNUbpLfPzLVqL+83Ye8+AWI72Up/fwNXd7Z3pF+0konis7Od1nuyYbvmoIDzibsd
         qTMLfp5dkEz343/qQxoCJZu+63krTTU7FJOKi+hVzaseM31K+7eYsmsNOF5yeEvYJ73a
         qZ5h5kTns8iFVRY/1/rIhHVxyBwmkzmklMCAukzTzaVB0S9NHYu/3dz/KlxR+hWkmCG4
         a7uuvXdayucHW9kUPL2Re9BQ6zx/z4j5EcUgYAiWc5oB/Iuv27sh/u7O80jJ/JPtEccL
         oPX0o//L+n7Ss5vsRNr2e6RSOZHTRemngdDc4/wSpFyNq4wQ8jGsywxB0dDnQ5ZayQmr
         VwPw==
X-Gm-Message-State: APjAAAVfeXfrjjPjhNeH+Sfc4P6gvLzDoVHkjZIAgSOUl4i6MRvuf2mg
        fMyRbO6ebQeug2tnV0iYuNM0Tn6g/YWeoAAV8p0=
X-Google-Smtp-Source: APXvYqzYRSUMeYwppqkm3jwDYitgo0NaGtAMsVpq31AxYLF8V92ylXN/CfvptlocJU5CHiGCoBGOF0MCGGqfOEgh6Mc=
X-Received: by 2002:a6b:db12:: with SMTP id t18mr17468128ioc.11.1576509432826;
 Mon, 16 Dec 2019 07:17:12 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1912091615200.31080@tvgsbejvaqbjf.bet>
 <7E95BE86-BD96-482F-9ECA-DBDD9C10D114@msys.ch> <nycvar.QRO.7.76.6.1912092037540.31080@tvgsbejvaqbjf.bet>
 <D99ED706-EC49-4A52-8186-5C9B0B5BC744@icloud.com> <038c72f0349174bb92e1dd9c3b38f02543ba1d95.camel@swri.org>
 <5C8CA727-370E-4CEE-BBF9-F336C5921D98@icloud.com> <nycvar.QRO.7.76.6.1912131440400.46@tvgsbejvaqbjf.bet>
 <2BB5D7E6-D565-4DCF-8E4D-D410AC1F91F3@msys.ch> <BAB4CF6D-6904-4698-ACE1-EBEEC745E569@msys.ch>
 <10B64ECE-6635-4735-A8AA-44E66BF0E5DA@icloud.com>
In-Reply-To: <10B64ECE-6635-4735-A8AA-44E66BF0E5DA@icloud.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Mon, 16 Dec 2019 06:30:50 -0500
Message-ID: <CAPyFy2ANiDQ+Ed+3vG-MAxeAV=CRhJow56F7tBooBpJ-Q9B-bA@mail.gmail.com>
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after 315a84f9aa0e2e629b0680068646b0032518ebed
To:     Tom Clarkson <tqclarkson@icloud.com>
Cc:     Marc Balmer <marc@msys.ch>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Strain, Roger L." <roger.strain@swri.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ns@nadavsinai.com" <ns@nadavsinai.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 14 Dec 2019 at 09:27, Tom Clarkson <tqclarkson@icloud.com> wrote:
>
> When you say it pushed every commit, does that mean that a bunch of mainline commits erroneously ended up in the subtree repo?

We encounter this case when trying to use subtree on the FreeBSD
repository. In our case it's caused by commit that should not be
classified as a commit to the subtree, but has no files in the
subtree. In our case it looks like an artifact of svn-git conversion
of an odd working branch, but the same issue is reproducible in other
ways. For example, it will appear if the subtree is deleted at some
point and later re-added.
