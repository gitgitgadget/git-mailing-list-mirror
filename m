Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31620208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 17:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbdHaRb6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 13:31:58 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35360 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdHaRb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 13:31:58 -0400
Received: by mail-oi0-f49.google.com with SMTP id k77so2579673oib.2
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1dFhv+Wq3RvAbZ8e0Bicxrhk6wLPLZQhqjmQqKE8Vyc=;
        b=SfUruXEDLTI/3imgaH57aRE/Mhe40sSx8dzS6bNxCvFsZ+Qmawu1zYjguB8+RTzS6E
         Tz02etp8U1YX5tiQf9pYd2h6AKRe7JLf3yrHmTnzJVcvnr0bHjdnptIl9ftcu6g/Svsp
         B4hWTEl0blnmDeUwRBTwx0FoSf48Kg5JlWgc3nyvdXrI6t/CXPdCnM1wNiuhcX1jMELk
         O8heqcdoriRGy4sR32M5E6L5njpkvBNvBICWE9ZrBgIS64+LH8Y+Fx5oyL+6Nb6nYbcN
         TBS7KZG9SKufkcucYfMXU6RT4q5RCz3KQQDp92yhUGCH0x69VqvL674PO1j3TUVP10Tv
         f8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1dFhv+Wq3RvAbZ8e0Bicxrhk6wLPLZQhqjmQqKE8Vyc=;
        b=c+nLXNRRWWLbX4EL6AJIJosgHSD0mhuGMTpifKRTGGcv1Hox5CHtxJC36wtEm0lokn
         Aj1d+OKKLTsKdstXSwLFNkUqS2Rws1bK+VGJQkuCfj30Mb5pcXXFqyZKaokkdXiknU7G
         uWhnzoDqjljDVYzXfQDh4/KFQhDvuZHPCkloF2s4KpvSQgZC8v1u5Pgb3VPHnOdtQsGO
         yBx/kJBOsNNWbezOf9PtUPPINDZ0a30wOduTL1NgeTgSBqT/s2iD5TX2HN7jb6N7ORH1
         3cEJlPKD/fge5huUgdrcLcJ1aGLVUQDb9I8adnU12fwjfbfZzfkd9JBiIMQlBdqPB2Fu
         jFmg==
X-Gm-Message-State: AHYfb5jgtdXUECALXkQiRsXUn/v74iFT3bwvCcHX/6jhuJO/HGRj//NW
        YdddhmQGwVbIUBns5JjqZ4ZXR0ARC5hy
X-Google-Smtp-Source: ADKCNb75LhS1pXyfSoHihKe3odWo4oSqpJvREiaAsdb4Qjj+eJLA4+t+kdIujJsQTHsojpJ9Q7yi9gY3uJ4MgNX8Aeo=
X-Received: by 10.202.117.129 with SMTP id q123mr5951028oic.0.1504200717241;
 Thu, 31 Aug 2017 10:31:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.14.141 with HTTP; Thu, 31 Aug 2017 10:31:56 -0700 (PDT)
In-Reply-To: <20170830175005.20756-2-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de> <20170830175005.20756-2-l.s.r@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 Aug 2017 10:31:56 -0700
Message-ID: <CAGZ79kb4H7Ztm4tFhRNKaR4L1RM+eY30dtnTRm25xMPNWWZo2Q@mail.gmail.com>
Subject: Re: [PATCH 01/34] am: release strbufs after use in detect_patch_format()
To:     Rene Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 10:49 AM, Rene Scharfe <l.s.r@web.de> wrote:
> Don't reset the strbufs l2 and l3 before use as if they were static, but
> release them at the end instead.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

This was introduced with 5ae41c79b8 (builtin-am: support and
auto-detect StGit patches, 2015-08-04), trying to sift through old emails
I did not find a discussion if that was static in an earlier round of the
patches.

Thanks and
Reviewed-by: Stefan Beller <sbeller@google.com>
