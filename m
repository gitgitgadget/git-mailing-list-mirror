Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7942F1F404
	for <e@80x24.org>; Sat,  3 Feb 2018 00:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeBCAbq (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 19:31:46 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45727 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbeBCAbo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 19:31:44 -0500
Received: by mail-yw0-f195.google.com with SMTP id b16so11701645ywh.12
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 16:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rm7SHR2wr2gCiIMd/diwZJtgFfNh+BskHbvnm+8fV48=;
        b=os+e1pSXpXiPyqmUwivYdSUN2XbEI4YZ/A1fFPhUcmGiR5qrFB8wIXKXPnB6WHqDTp
         ZoEwhYVRDUEo5G9pwOW8Jd3Mc41du3lyIgYJoeKP/CfwiJsKglXjhUt7Wg3yL3lyzt53
         Wi0tavdzHWeXdAOJLoMU6uYvK3pkeouJy7iwzkajmO3O8EvPyAErIB9Jbz8DRpiSdDzn
         8fjtrcO6poqoCV9PatMRPMm8HX4yMY+SA+N+kLrYLw8NYyRXJYG7QVRdKPP6fdlJaFCH
         vrtEhVnHu1K6gLra3qfSs15EH4y5hMoe2+ZZAeeLuDMApBkeEWb8qN/uxsGKGUiQGYZ5
         osbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rm7SHR2wr2gCiIMd/diwZJtgFfNh+BskHbvnm+8fV48=;
        b=UAvk6uV9JO+EUoA0uS7TT+peWux85pU/kGK8HGTtTe39cVlrMycNK5z83NQMSFZJmG
         b01bqDHJ/jP1EXdKGv6jwUDXhAZI+qdvFhEXgqmOm9Tt+JUNr3mu4hsioHTjD6NQgZij
         h0bZ5Ay0DekeRKWP0n8rYtKQAJgDi3w4jp2ijY9ZtEgAka9+Ba3AQ/KGIOKaL7ACJR4v
         7j+4heDUflK14cbcCRUEv8xnhN8voqVifgjf7l1ViifSG7WtsnZs4yIQuhWnveTfnXUC
         wqn89fCiN1dN8JJ7/pAMAXSOovS0M68wEpsEUOaTZjjvZRGpJFjMPYLvHbqX52/IkFKd
         crhQ==
X-Gm-Message-State: AKwxytd2AGSMsi4IpsvxKgKiy2hiRjX9+ljaCDRp1YzJHwmo1UiZvQ5i
        NmtztRPDodC0e+yWnwHevyWJixIepWS6Pfxhhlf5nKQ+
X-Google-Smtp-Source: AH8x225ShdVNi+bu+3W/JLod6MRb8BJJam4k+rkMU2A2Wy3sGFuI/H+P7LbrhieaZ82Hxq+CYfuGlvrqA5A3ta+rRgo=
X-Received: by 10.129.156.134 with SMTP id t128mr28075009ywg.108.1517617903732;
 Fri, 02 Feb 2018 16:31:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 2 Feb 2018 16:31:43 -0800 (PST)
In-Reply-To: <20180130232533.25846-19-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-19-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Feb 2018 16:31:43 -0800
Message-ID: <CAGZ79kYuiE31dQ7X45x+ZkF8t1ugMfzhoq_yh-j4cGy22P7aqQ@mail.gmail.com>
Subject: Re: [PATCH v7 18/31] merge-recursive: make a helper function for
 cleanup for handle_renames
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> In anticipation of more involved cleanup to come, make a helper function
> for doing the cleanup at the end of handle_renames.  Rename the already
> existing cleanup_rename[s]() to final_cleanup_rename[s](), name the new
> helper initial_cleanup_rename(), and leave the big comment in the code
> about why we can't do all the cleanup at once.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

This mostly touches new code of the series, so it feels a bit unnecessary.
I don't feel strongly about it being a separate patch, as the patches up to
now are easy to review. (and squashing may harm reviewability)

But the code makes sense.

Stefan
