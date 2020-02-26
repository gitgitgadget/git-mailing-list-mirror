Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78523C4BA0B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 07:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403362084E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 07:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmbbi9pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBZHam (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 02:30:42 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:43113 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgBZHam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 02:30:42 -0500
Received: by mail-qt1-f182.google.com with SMTP id g21so1552848qtq.10
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 23:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5hfNy6AeZG/zgGugGYs/rFhzKpFyL0LqRew1j+2tEJY=;
        b=qmbbi9ptiNLf3UtTIib/fmDXOVXP38xQ6O25bAO/nABwQ1aCx80v91Qncn9zImy/AZ
         X/sifUNezis7ANNJmBJdRIHjEzGQCIB02IvGlmDpMwCt9pArLu2gmhSIa+9yZA6XYvD4
         j9WEaqVAFVVChPAD/Zn4nnlsNINUHxyEDtVjCoo4kglwGS9QHFwtlunodQjl05WIms1O
         0KODqlUQh0O3YPEYfybm1pRbHdJ/eLtQj468XHq21yiUdhGfrYcxvj5RA8fvz8Bu7tEz
         ptjumR7j+tmzE7/ZwgJsFIFFH0dC4VRN9uhXf0hmhUfJ1vFoO+gpK3MMQrPlmSyhYuLt
         wIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5hfNy6AeZG/zgGugGYs/rFhzKpFyL0LqRew1j+2tEJY=;
        b=qhEA9oIFcdv2sPHwecTLSgIDdqXof9NmpRjtD6ilNMGGjL1rufMNEA/JW/+Q74xnqj
         gizr+OKBgJiX+X63Xn38aT6v55yPJk2ZOJKW5M8Fei2u5wGTevMNXB/2GVYwM3Ze82m2
         lQr/aqoj1MzMk+QjogGNzsolMVQemz+yKkklIhPKpCMv9fmcwr3/ATKz4Wg4xZ+/8gMY
         l4kCh281LU8N2xel7oqXcppkaUNpy+0r0Adh7fiGAjPW6RNEJYN++FOEM24sPoP6+zHT
         vuWfNsLkDuUHPISVLAu2kNjws2O76xMYQqSvqUd9FUYbGnDPEPuvPQ0nuxn+uFWkERcC
         qBTw==
X-Gm-Message-State: APjAAAX8FThAB4ESZxajG7gJ2+wEX8ruf1/al9iHocOdYiux/7tF408U
        gp/LfNPakvpzxUw3LbGn8g0EqNhVo1Q4lnIk+BY=
X-Google-Smtp-Source: APXvYqxZuKW9BVe5gp5LpetXNkoEs7W+O0SE0CMVcgTMq/MunwKTHTWQYu4XjtxkHntq7+HcAiskFXu+f3xY6ocQfnk=
X-Received: by 2002:ac8:2618:: with SMTP id u24mr1343325qtu.297.1582702241236;
 Tue, 25 Feb 2020 23:30:41 -0800 (PST)
MIME-Version: 1.0
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
Date:   Wed, 26 Feb 2020 13:00:00 +0530
Message-ID: <CAHk66fszhTMWa14rpupbwDak=t4=svcHr=1CMBBSt8MQbEUqmQ@mail.gmail.com>
Subject: Re: [GSoC][RFC][PROPOSAL v1] Unify ref-filter formats with other
 --pretty formats
To:     hariom18599@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings Hariom,

> Here is the initial version of my proposal. I would really love to
> have comments on it.
> Also, how should I manage the project timeline?

As far as I have seen, there are two approaches to the project timeline.
Some prefer a week by week timeline whereas others have 3-4 week-long
phases instead.

If your work can be neatly divided into a weekly schedule, by all
means - go for it.

> Project title says some past GSoC and Outreachy Interns had worked on this.
> I would also like to be redirected there. So I can learn from there
> work as well.

Olga has worked on migrating the formatting logic from cat-file, log
and for-each-ref to ref-filter as a part of Outreachy 2017-18. Look up
her patches and proposal.

She, along with Christian and Thomas were the possible mentors for last year.
They are the best people to ask to learn from.

Regards
Abhishek
