Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105B8202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 18:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbdGMSvq (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 14:51:46 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33194 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbdGMSvp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 14:51:45 -0400
Received: by mail-pf0-f177.google.com with SMTP id e7so33638965pfk.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e1PJ5CdJZrSjpfLrM4GTq6ZzqAzFdU1wM7POjdmAv0Q=;
        b=s31+gYbKcbEx3lyNyM0IRsMYmUZeZglwkx8Ey5szpg6uynQ29lzyNzeqk6NGuiDPTm
         dZxlJ+llKsNk6rZLHSnKqO3+OTAMUtRJqDiJl06gA6SXAvsLEpGCXijo4Xy9kQSwNECu
         AubwKF5Ez7NdZ1ozE6l8SfKCfon+Vg/XYqR8DwrmTrnmqz8dWp4YoAfS+jBdB8WXm2I+
         vKC/onSY5d5vA0S0tqTMnIO8wU/C2EVhuRLVHhVcchzYt7kt5dZKGEmCVs3H4DnIqB/f
         OwJPMXoFNBxib5PAM2EZEGnqXf7pbz7Dwebk7v7gmqBwH1be3/vRPwNKAO6jQ8UYMgbu
         2t4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e1PJ5CdJZrSjpfLrM4GTq6ZzqAzFdU1wM7POjdmAv0Q=;
        b=ivhAIUs8CfulltA/foWBYy+hwS6y/OW70CeoCU8qcJ4XWBCla7vApx8igPxXDqDVcC
         gew9Q/eWhKjbN/B9iGLRjd21d0YbvJkzsmhttB1FsJ3d0IpzZQplgd55tH9FkqDsHiPs
         J0ozHN3Sko0rNDf7fOpLdWsa5nGfVj+A8rGliF5Hw92xE76lAvcCjcjWzufNOLIjq516
         kzugofDC0ub7imfL/P8MNp/QpYVKndPMT4YC+jwDApXJ46Pmnc0zZWnPWznZ/LiM1TAB
         PHJMxrw53ScwxWCWzGTJ1uzkaZ/z3qK6YQD/Da43eZQJzHg5qvITSbA/UVFsOSmPPanz
         oiAQ==
X-Gm-Message-State: AIVw111p0/voP3OneWCemXul6zM2kYYeokdKO7BCg1/vz0QOzkeQotWd
        OW+wfvQ3b+5uUA7mFV4uOFEyx8sMQV6f9lFkIA==
X-Received: by 10.99.149.83 with SMTP id t19mr10646534pgn.247.1499971905183;
 Thu, 13 Jul 2017 11:51:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 13 Jul 2017 11:51:44 -0700 (PDT)
In-Reply-To: <20170713150118.eof3xgu4zujmo6u6@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net> <20170713150118.eof3xgu4zujmo6u6@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Jul 2017 11:51:44 -0700
Message-ID: <CAGZ79kag1B37FBrmDzbRFNVODHp=n1h=xSq_pi1b7Fs4wLoRBg@mail.gmail.com>
Subject: Re: [PATCH 05/15] ref-filter: abstract ref format into its own struct
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 8:01 AM, Jeff King <peff@peff.net> wrote:

>  builtin/branch.c       | 14 +++++++-------
>  builtin/for-each-ref.c | 22 ++++++++++++----------
>  builtin/tag.c          | 30 ++++++++++++++++--------------
>  builtin/verify-tag.c   | 12 ++++++------
>  ref-filter.c           | 22 ++++++++++++----------
>  ref-filter.h           | 22 +++++++++++++++++-----
>  6 files changed, 70 insertions(+), 52 deletions(-)

The patch looks good to me. So some off-topic comments:
I reviewed this patch from bottom up, i.e. I started looking at
ref-filter.h, then  ref-filter.c and then the rest. If only you had formatted
the patches with an orderfile. ;)
