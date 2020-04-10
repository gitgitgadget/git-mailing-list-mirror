Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F2BC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0281207FF
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOX7exEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgDJRrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:47:39 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:32989 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJRrj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:47:39 -0400
Received: by mail-ot1-f54.google.com with SMTP id 103so2565459otv.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QvAD6VdyHv0NVYYbiCg9yPJhpP2IkVywAJs88Qbxwvs=;
        b=TOX7exEwR3m2LQYS4rZqbGLa6nO8HH3v4HR2XFMkFjf478bR3jE9Hi7QyNtcc2TB5z
         AiEhaY8BWSNfr+m3QCx/7x+dUqjN1KuMe3Wrd38h5TSz1cd3L4LwAnmZs6yMisDlkw0K
         JIg2rxNypNPeXTOjlqwFCr7k0wEgE3RSFqGs+pUUM0y9HUpcSIgux2clJu8kgJH9t30x
         4d39KwreTfrYZWEsm6aCLvr/gz9+vTI6nypt8oX9HHAQZoaOl17urVzZn/IdX47wbePs
         yxW5loYYQuPibL7TnshkIC5i1KGXfctZmR+LG94X7cmSenmwxgLdfz69Z3KiuPKdf0SZ
         7CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QvAD6VdyHv0NVYYbiCg9yPJhpP2IkVywAJs88Qbxwvs=;
        b=sBZTEYBjz3tCGVafXhALB71s5npiWvmJMVokOTWPtchuXM5CeS9FA4MpFREUslMp4S
         E2+bGfCX7/BkyBikREakD7UUuFhHunwgo12z3gDqsCtUI3fq9tGfhK4ieE2Gc2h+C2qF
         lCEGDKdJA0wvY3QcVV6hCq0hUxiu0Zq4xV0o5HZzRDsGbORM1PSzNa5fqZVuIszxQEQI
         xRxwaDOp8PuoLhz9yrawv+UIoTMwxsrWP3GpWbWx8HvdKP7BWsEBcO7/5m5E0OI+ABCf
         eqp8Sd9zLgDzJuFCvHSFOI8B7MVdgzymJrHMT6wca3Gg8vgv/F7Ris81muzM/3jFQkVu
         +rlg==
X-Gm-Message-State: AGi0Pubv5yaLHfi4iW2wiaYSWHYbzRrHrdrYFWjqiJ+M195BLXzALn7z
        iY4aSZFH8eqMksh2h0HoTk8wf1CyYseOsvkT/ZI=
X-Google-Smtp-Source: APiQypJJgZ+wU+JtfncRMs65uuL0z9JrbANvt3cyRzXn5mr0qYAvPDY5BueIjpRU06JQJuzuHpboihz2gaL/q3NWcpg=
X-Received: by 2002:a4a:9451:: with SMTP id j17mr4915231ooi.30.1586540858444;
 Fri, 10 Apr 2020 10:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <FA375405E0773E4095AD3784C67AE52214DA4BC3@UMECHPA7A.easf.csd.disa.mil>
In-Reply-To: <FA375405E0773E4095AD3784C67AE52214DA4BC3@UMECHPA7A.easf.csd.disa.mil>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Apr 2020 10:47:27 -0700
Message-ID: <CABPp-BFWnfr0kc3Od4XC2ZmJ94k3p+oSmbz2k1+GyY+S-OVwig@mail.gmail.com>
Subject: Re: Possible impacts on Git due to COVID19
To:     "Coghlan, Owen R CTR USARMY PEO EIS (USA)" 
        <owen.r.coghlan.ctr@mail.mil>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Pegram, George A JR CIV USARMY SEC (USA)" 
        <george.a.pegram.civ@mail.mil>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 7:04 AM Coghlan, Owen R CTR USARMY PEO EIS
(USA) <owen.r.coghlan.ctr@mail.mil> wrote:
>
> Good Morning,
>
> My name is Owen Coghlan and I'm the Cyber Security Analyst  for Defensive=
 Cyber Operations, Cyber Platforms and Systems, located at Fort Belvoir sup=
porting the Army. Are there any  possible impacts or slowdowns due to COVID=
19? Impacts such as supply chain, coders, and shipping, where your software=
 product is concerned. This information would be greatly appreciated.

I'm not sure what kind of "supply chain or shipping" you are
envisioning would even be applicable to git.  I'm also not even sure
why slowdowns would matter -- you get new features slower?

It's also not at all clear whether we have an overall slowdown; not to
me at least.  Some developers who contribute may have less time to do
so (e.g. due to the sudden need to homeschool kids), but others might
have more time.  While some git developers may have worked in the same
company and collaborated in person, overall, git development has
always been done electronically and remotely and has contributors from
many companies as well as hobbyists.  If someone had a reason to be
interested in this kind of answer beyond "My gut answer right now is I
don't think so", they could try counting patch submissions to the
mailing list or the number of new commits entering various branches
and compare it to previous release cycles.  That information is
publically available for all to see, after all.  But digging out this
information seems like work for someone who feels that documenting the
answer provides some kind of utility.  If you just want a rough gut
estimate, I don't perceive any slowdowns.
