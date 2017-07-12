Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4751320357
	for <e@80x24.org>; Wed, 12 Jul 2017 21:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754056AbdGLVhW (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:37:22 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35553 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdGLVhV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:37:21 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so4421048pgc.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AlAAGCObQMe+LyLG5wxS/59j/oodwRBnchQtBOPhGFE=;
        b=lljoVc5Atllrd3prAEJpI5YuW6P4j9C+fpTPkAxjnbpYgOz5N1fboWBgkbwXKUy9SO
         +MvXBYZW9VgDZyXfp//TDpsI9+1ZDkcj31BvW2LGkoa+ed8RNLcJZPX5IOhEMhvOWqsS
         UNO1GngA5vJ5uO4O4BdQf+SzjTrSleUZA6y9bMpJK+DfUKGCSz0LFyPJZXTdHzlB242w
         bZvD+uyK8fRYyO23b4wpeUZ015965Y+9SvhuqVh8vq8Kokqo+VwQjVgiPs/KG4DjeP8w
         lT8WwRb/pEkYmxVsQyVGJBTLcfJtmmoInN6/ugdyiqmp16Fcqsgsji4IkOOpsYukdMR0
         7DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AlAAGCObQMe+LyLG5wxS/59j/oodwRBnchQtBOPhGFE=;
        b=dxtlH1zJ6jVqNzO0aZM8Qvvfah34LqMf4Zipvwjk16gi4tPGCZ3Wd2KOH5WBEHKyje
         jFQhZLwKPKqEzF2PXQj7cMtqc+MLhK510r1bgGya1N9ns0KnRl97yNTTVOD00TrrLrYp
         I9S1Tbf0PxzPoS1EZbqqjzTiPkcFIM/jzkEGFOSzIPFmrZoPYZBDm/iXNaJsVTwDmVma
         lcIyiHgXjxTtPh84u+nvcpCjdkffpxg359OHzT/3sgAGEdQ7Xw4/3Fn+xDXTp5TcIGZN
         2tPRKU0ndcH7sUuK90ylevm9Mdhw07HelVeX1MtcVsUZN7cBy9DpzZQTAt4KOzzLUEj7
         uo4g==
X-Gm-Message-State: AIVw113djyutfNQ6cFfqypJznHa/OBXnXESMFm/9LV6sb3FvBQOMLiiY
        Jis8V24FXofGbA==
X-Received: by 10.84.218.136 with SMTP id r8mr6488336pli.205.1499895435492;
        Wed, 12 Jul 2017 14:37:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id y14sm6845274pgr.1.2017.07.12.14.37.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 14:37:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
References: <20170711233827.23486-1-sbeller@google.com>
        <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYftkxbDY2E_=2w0VYx8COF_yc61h78gs2qaraK9HRSuA@mail.gmail.com>
Date:   Wed, 12 Jul 2017 14:37:13 -0700
In-Reply-To: <CAGZ79kYftkxbDY2E_=2w0VYx8COF_yc61h78gs2qaraK9HRSuA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 12 Jul 2017 13:58:52 -0700")
Message-ID: <xmqqzic9z69i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> 2. collaboration.
>     When I want to review a patch from the mailing list,
>     I could (a) download the patch, apply locally, see the diff
>     formatted nicely according to diff.orderFile.

If you are not doing a review of a patch with complex changes that
benefits by a local diff.orderfile (i.e. only in the mail client
without applying and viewing the changes in wider context), then you
either (1) have a much greater memory than I do and know all the
code outside the patch context by heart, or (2) not reviewing them
properly in context.

I tend to suspect that it is the latter case, so that argument does
not sound convincing at least to me.

No, I do not apply all patches before commenting from my mailbox; a
one or two-pager patch can often be viewed and judged without much
surrounding context, and can be answered in the mail client, perhaps
while running "less" on some related files that may or may not be
touched by the patch in another terminal, without applying the
patch.  But such a one or two-pager patch can be viewed in any
presentation order and do not behefit much fro diff.orderfile
anyway.
