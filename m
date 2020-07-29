Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EF5C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1422E20663
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaZCQlOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgG2UjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Ui7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:38:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7D2C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:38:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ha11so2802194pjb.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qNaO3XuvLZuuASTMq+peKJrH4OXXqDDcuJktDUJW4w=;
        b=FaZCQlOsgA7AczHhTcKIDbXLHZRcSlv5LWTFZ8GwsVqNCRhHbYNr6W2F3RjI882RDb
         bcXzOU3Z9J/E498+lMEQp1Ytc8XiXSgrsBK0wQBpqOxQPsocL2YKiQzWp8fI80RbKD8/
         RPJlsuniwZyVWm3NbEGxfcby9maLzBQ9SQALTUMS6JeY/xQgzRvwSzPC4EZIj1NO7ifP
         hTNFeH/8jaNCkJtv6r7Thed0VTaYr7Z7iIwPCRqc0wTzTK5kOPiy8QhdTsoKhgJCvYwO
         3aAcfNKlG2jRXp/hgN5yLf7BjudqiiiFq3gf5240ApehrkC84tGQKYjwuKuuYC7EwhMZ
         bsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qNaO3XuvLZuuASTMq+peKJrH4OXXqDDcuJktDUJW4w=;
        b=U8zzoIbjcfeHD3Bgig2Qzo51veqd5YmstnipCdT5xiiDPu+cT3yE+FlMP8VJB0sOUf
         Q2pNOqs2Cfp+UhigSBSWJE8Rj7HAmfUwI3sPtfH62kFk/6xGRVSMDeLaFiKCCO8hgWYt
         z0JJgTmsY6URCXJNTMv9Cf+0hQZoCBxljBhMfiLtLTV9greB6mCCqyIYhfQuGSNJ8fZJ
         RHme2qQqtkl2TpAWZMDHzcJk4uynVbdXDy7JzeOaDAUzycl3e5jwPlEd9D14FrydK7gE
         pQPBzFKsJ2f5xRwxmtOmeDaUG0v/WcRVn6rAvTWbTm80ymqq7fuf9tF9Qxtu2GEVuQx4
         FL1Q==
X-Gm-Message-State: AOAM531yffvHAwZsGD8bLH0lyVmyaMVSdMNUSXxPjJRZ1TD9tEovpvY6
        3HMDvnJ5WVaUaqw4qHQdi0o=
X-Google-Smtp-Source: ABdhPJzG4k9BMaCA4PlUXyIbl8ViDsUeTym/kFzf9UhLw2N1wJJtoY8nz9QRQGUbaM7hLfwt7H1PXQ==
X-Received: by 2002:a17:90a:a60a:: with SMTP id c10mr281350pjq.117.1596055139330;
        Wed, 29 Jul 2020 13:38:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id p11sm3262856pgh.80.2020.07.29.13.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 13:38:58 -0700 (PDT)
Date:   Wed, 29 Jul 2020 13:38:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
Message-ID: <20200729203856.GA519065@google.com>
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com>
 <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Linus,

Linus Torvalds wrote:
> On Wed, Jul 29, 2020 at 1:05 PM Junio C Hamano <gitster@pobox.com> wrote:

>> The intent was to stop treating 'master' as some kind of 'special'
>> word, since it is no longer special after init.defaultBranchName was
>> invented.
>
> I understand it happened.
>
> I just think it's simplistic and wrong, and outright stupid, exactly
> because it effectively does the exact opposite of what you should do
> if you feel that "master" is a bad default.

I know that "on the internet no one can hear you being subtle", but the
following is not about subtlety:

Repeatedly describing this change as wrong, stupid, simple-minded,
pointless, etc is not making your point any more clearly than if you
were to describe how this change is affecting your workflow.

In fact, in this thread you haven't described it yet.  I assume your
point is that you find the message it writes to be ugly?  If so, why not
say that, instead of describing how the change doesn't do what you
believe it should do?

The commit message describes its intent

  commit 489947cee5095b168cbac111ff7bd1eadbbd90dd
  Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
  Date:   Tue Jun 23 22:33:23 2020 +0000

      fmt-merge-msg: stop treating `master` specially

      In the context of many projects renaming their primary branch names away
      from `master`, Git wants to stop treating the `master` branch specially.

which is *not* about treating "master" as a forbidden word.  All that
said, I do think it can make sense to make these merge messages less
noisy, for example by keying on a setting like init.defaultBranchName
as Junio suggested.

What would help in figuring out how to do that is, instead of more
reminders of how stupid we are, some more information about what would
be useful for you (both directly in your use of git and indirectly in
the history you would like to have available to you for pulling).

Thanks,
Jonathan
