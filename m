Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65ACF1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 20:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeCWUvS (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 16:51:18 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:55228 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeCWUvR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 16:51:17 -0400
Received: by mail-wm0-f46.google.com with SMTP id h76so5806168wme.4
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5a4a1gbpKQXqSAS+Ga3so/YfGih8sD5VpGA08d2kYcU=;
        b=KJmJIUImCocOjvllDSC++W7ApO1qqV2fLAO6OsapWkfoBZ9sHC1cHmHXlhnMecsbax
         6DL8KJsx0VdxRjF6QYbP096twy3hk5w+o6uYsSQFNPo9Ap3ZhWpkV4Xy/MZkpbE6O9v1
         tUIjEEtJh/7qhv68z1Z//5+suJzGRlTl97pBQ+WlEM4ZZMrEM/h1iukRpXyAWha8XCbT
         AWzfCDmCToYCnclWo9LKQ/tgRJc2UrclDHA2O5lvCYJkoclwJ3zqsfYsMsVI6bb+olL8
         g+E+Xb1N0E7BlvK1bDpbmJeIxWpwqPojPOK2EW/s8FTNtmDr7/A+MaLA2UKuTbFste8M
         Ymyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5a4a1gbpKQXqSAS+Ga3so/YfGih8sD5VpGA08d2kYcU=;
        b=gA9VKpd1GtcNpU+0Kpa9Ew8aBlbwmL0mWlVZY5T8s57pkK9qcT0/Ux9FnQhSvDJfUd
         aq2+UrX+yeuOsCERkkbxpQBbwrInzpyzW+Gz73gfA2UXkN2qF+lvZ9OpTE3uxLaBtwQi
         NM9SxZr0Ac/gLrvRgLRfMVF4TMAoYGsV3zltkYFU1F3fRg/fd2GgvbxzEUvKOS9t7VDk
         82Zb8loY7casplEL5QXpxQoWtjAicBQi0IlbZ/wR8VxVRF/wJ0+mahIqWeUyjQsSGAtY
         vxAIfHFjsTXyXyG+tkg08X6Tq4BwNK6TDH8kxmHW+QWe/ekwc4OcMZOAbE7fkd7+t7EF
         fHew==
X-Gm-Message-State: AElRT7G2FNj/LFeEJYpUSp/9VwVsyRME6WBEVq55CyxAg8v/gcKru9Fh
        9EMMVIsMFaAo33jRXXWAZj4=
X-Google-Smtp-Source: AG47ELsMPLxJq3MT/3nM+5wqhaN3nciaKhhs7Ay4aDdRsJAxj/WQpwgIkmeRj50pjv13aQxeE1Bthg==
X-Received: by 10.28.47.3 with SMTP id v3mr10188025wmv.96.1521838275564;
        Fri, 23 Mar 2018 13:51:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m62sm13640071wmc.25.2018.03.23.13.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 13:51:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH v4] rebase: Update invocation of rebase dot-sourced scripts
References: <cover.1521779249.git.wink@saville.com>
        <ed4cfdc9f31b920eae5055c3b080e2ca5b2f6e42.1521779249.git.wink@saville.com>
        <nycvar.QRO.7.76.6.1803231811530.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CAKk8isrxTmryumw5EFVcPxx9wUKA=pB3VxvH9VaHPLRraa=4=g@mail.gmail.com>
Date:   Fri, 23 Mar 2018 13:51:14 -0700
In-Reply-To: <CAKk8isrxTmryumw5EFVcPxx9wUKA=pB3VxvH9VaHPLRraa=4=g@mail.gmail.com>
        (Wink Saville's message of "Fri, 23 Mar 2018 12:06:16 -0700")
Message-ID: <xmqqfu4qikhp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> Here is one possibility:
>
> git format-patch --cover-letter --rfc --thread -v 5
> --to=git@vger.kernel.org --cc=sunshine@sunshineco.com
> --cc=Johannes.Schindelin@gmx.de -o patches/v5 master..v5-2

Sounds sensible.

> If this was the first version then the above would seem to be a
> reasonable choice.

My personal preference (both as a reviewer and an occasional
multi-patch series submitter) is to use a cover letter for a larger
series (e.g. more than 3-5 patches), regardless of the iteration.
In fact, a submitter tends to have _more_ things to say in the cover
letter for v2 and subsequent iteration than the original iteration.

The motivation behind the series may not change so greatly but will
be refined as iterations go on, and you want help those who missed
the earlier iteration understand what you are doing with the updated
cover letter.  Also cover letter is the ideal place to outline where
to find older iterations and their discussion and summarize what
changed since these earlier attempts in this round.

> But this is version 5 and maybe I don't need --cover-letter which, I
> think means I
> don't want to use --thread. If that's the case should I add --in-reply-to? But
> that leads to the question. from which message should I get the Message-Id?

The most typical practice I've seen around here is that v5's cover
is made in-reply-to v4's cover.

