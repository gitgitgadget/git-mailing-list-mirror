Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C333CC4332B
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 09:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5762310D
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 09:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgLVJ7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 04:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgLVJ7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 04:59:14 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45774C0613D3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 01:58:12 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 9so14229041oiq.3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 01:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=BQXIofhr1qCgrM4v+lNb4skzDSpCJ2XWOVhsyn6fDPw=;
        b=VALilPLAmkyOy/6hSu3sssJxrH0ttFHn2SI6MBSA4/HmQiGFSZZqrUUUxqEgvBKamb
         RGI0I7Jv1z/XZo/U5QiY/q12W0IdwyuL4tjfRRK8yFKnEkHo5kvKV+s55yE6G3UIzzRn
         G5+GErYZvDWMJr7d2G2Wmd6Ffh+VzuzSjthxdI+z0VgfsI4BYou6G7G/zJ6r8HCm3ZP5
         bCo29g7Q96RRhVLYNbpG/FNpoPyVC4QiponA2y/epcRPmYAVWjOav+Hmi607jQfVtkfP
         9x1g5Pff0pKppqN5RampR7bzzouvHZYA0d6jyDytLaFFSosfG2o4PbAQ+gqCc4UNS2ti
         VOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=BQXIofhr1qCgrM4v+lNb4skzDSpCJ2XWOVhsyn6fDPw=;
        b=O/I25hfvZ3JaHV8JXIXeBM7j9Fs3uE9jwP30kC+SHgsuj3lOckeSlipD5kz8oqM/QD
         7X+FL96N5G7ia+wSw/5sA6MVS+9JZOWiGbhcMNUPSv7lf3DLetFYMkRvDM0yEUbMLECi
         FmZM/FEpzvJDA3bz13KhkIjdsc4Pc89+RmtKfJMp1SjzvOlDdxdTY+XQ3S0wVxiI/gV3
         v3MQ2jsklHuisLZvmTLVhcf+IzFL9Pq1d8BklgBsBJC26OrppGTw7zAIWvpyoZ65Wd0t
         cgy0g96CZgEHz2eIxa60UcuJYYK5cQfWtewVQ5OCfNv35eLf/+VDVVzVkaNZqd6DK9KO
         0EhQ==
X-Gm-Message-State: AOAM53341+eSlwWIaRWZ7TxaLKeJ7RYlg0L3aygoDMc6Lx6w0HZKndz0
        aa/2mpZjo7OCq3/V8OSbEyM=
X-Google-Smtp-Source: ABdhPJyTVTbEBZn95o/6N6Yn/HAWxzT3KnNrHlyHDAPgIrFrpUzp/oStASGElwnJ9CS6DJjaaurvVg==
X-Received: by 2002:aca:47c2:: with SMTP id u185mr13532866oia.56.1608631091739;
        Tue, 22 Dec 2020 01:58:11 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y35sm4395525otb.5.2020.12.22.01.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 01:58:10 -0800 (PST)
Date:   Tue, 22 Dec 2020 03:58:09 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <5fe1c3319a9ee_147e42083c@natae.notmuch>
In-Reply-To: <xmqqv9cuia8v.fsf@gitster.c.googlers.com>
References: <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
 <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen>
 <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
 <5fe134eeaec71_11498208f9@natae.notmuch>
 <xmqqv9cuia8v.fsf@gitster.c.googlers.com>
Subject: Re: Code of conduct violation?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > David Aguilar wrote:
> >> Just a heads-up that Felipe has a history on this list of creating
> >> long, never-ending, pointless rant threads so sometimes the best
> >> course of action is to ignore him.
> >
> > I think this can be considered a personal attack, which goes against the
> > code of conduct.
> 
> A PLC member here.
> 
> As CoC document outlines in its Enforcement section, the project
> leadership committee will review complaints of this kind, and may
> issue a statement later, but we do not encourage list participants
> to hold People's court publicly on the matter.

That's fine.

In real life courts don't have to be open, but accusations and decisions
do.

The public is supposed to learn which sort of behavior is acceptable, and
which not, from the behavior of others, and past decisions. In fact it's
from examples that most people learn the rules, including future judges.

-- 
Felipe Contreras
