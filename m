Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C1E20D0C
	for <e@80x24.org>; Tue, 13 Jun 2017 18:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753642AbdFMSGW (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 14:06:22 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36710 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753617AbdFMSGV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 14:06:21 -0400
Received: by mail-pg0-f68.google.com with SMTP id v18so20139421pgb.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 11:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A1iPjzqvk9Q3eONGJmLF/T6lPrA/h+5tubPrkntM68s=;
        b=Y5SvdJK9FtV0VR931F3i06UnyPQgKqAL3SoadzDNnkGEg7S3JoM9XT48+kgjHf/V+H
         kZ88+PRsgNfF9OFiNcebYvukMQ8Z8peCFtXcUoiPbr7j+1RCrjaE02MtP+ladx/eajNC
         e+lS+M4O45xkXd+6Nj2GZMyt++nxrsjv6f0jnFFircpdvwQ74JZXmcSq7/cutT3O5Ne/
         v1aVrhD2JcmRqwZRxA/W9msFJctG6enQTj/fI6opcbVEtfVsjUNL9u1iCYsdb7GrXXE+
         yv7+1Ut2vpyr3BqaHZQG+F1IzmaE9muDUiojRJP/wi5c2mW7aO/kDNHC7YrBd3Vn7nJh
         9fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A1iPjzqvk9Q3eONGJmLF/T6lPrA/h+5tubPrkntM68s=;
        b=QIr/+hkwUoV7jqsWPFsd3bs59i8rxlZ5OvYehnIfi8bEtXG+gdyBmo5gu4rAF8AH90
         7euKyUVXuDFHSRd0Hleqw/iuog3UZ2gIBvupZiwmboU4+XhCwVnUz2G7UnWjnWqJLo/d
         yc69BgMHy1CEm3DOb1isxcZVA6gnc8nhHgpMKTD9rFzjwKs0F/GVs6ST33t+6cV4vNXd
         YE9ZxLqOicewHX+g60L2tlQsT1wI0skgHj9wKSVMFdmEPOj9Jlp0x5F33GeQP8V54NZF
         6rmg6NvuzcT0slDJV5aEJiJdl1cV1GxqHIuq7PZI/1vvVacBEAp99xEWeFKK3i/hd0XT
         kIkg==
X-Gm-Message-State: AKS2vOyCYIW1DRyolyPpSEp3e1CysUDjD/TosX9qX+dEHFT/ElSqc6//
        OXJ8xnmbI+IMCl6XXxk=
X-Received: by 10.101.72.207 with SMTP id o15mr785538pgs.133.1497377180228;
        Tue, 13 Jun 2017 11:06:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id 67sm3546816pfa.83.2017.06.13.11.06.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 11:06:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
References: <20170613023151.9688-1-sbeller@google.com>
        <xmqqvanz9afq.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYR+qh1X-dQixdpDbcr5z-DJ2mkdncaVn_8y90kNco9tw@mail.gmail.com>
        <xmqqa85b9626.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYV8Ngis=ux50Zs1r5XOBUJ=hw2=8BEkNqk7PiGamX0AA@mail.gmail.com>
        <xmqqo9tr7qkk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kafV5aXd9SAOHHGOgsAdpuY=YV6yWoWSsuG9rncLYhphA@mail.gmail.com>
        <xmqqbmpr7pyj.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZNXCjBBnzPZLJqPY9S_ovPAegNT0pdCKAMWJH5AQoCCw@mail.gmail.com>
Date:   Tue, 13 Jun 2017 11:06:18 -0700
In-Reply-To: <CAGZ79kZNXCjBBnzPZLJqPY9S_ovPAegNT0pdCKAMWJH5AQoCCw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Jun 2017 10:44:51 -0700")
Message-ID: <xmqqy3sv69ut.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jun 13, 2017 at 10:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> But you do not want to (yet)? The goal is not to tell you where the bounds
>>> are, but the goal is to point out that extra care is required for review of
>>> these particular 3 lines.
>>
>> And when you _can_ help users in that "extra care" by pointing out
>> where the boundary is, what is the justification for hiding that
>> information?
> ...
>
> And how many colors would be confusing for the user?

Well, having two "dimmed" for moved lines are not needed if we use
the same as context, so we can reduce the colors to just two
highlights times two (i.e. old and new).

Having said that,

> I would think we want to start with a simple model ...

would be OK.  Let me configure the old-moved and new-moved to the
same as context and see if I can live with just a single highlight
color.

Thanks.
