Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4826E20248
	for <e@80x24.org>; Tue,  5 Mar 2019 13:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfCEN73 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 08:59:29 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39379 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfCEN72 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 08:59:28 -0500
Received: by mail-wr1-f47.google.com with SMTP id l5so9562401wrw.6
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 05:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2Pf/m8IxK+iW1ZriZeq/+l436sS6/KgFpzzF9DMW4AM=;
        b=HOHezHtT6RI2uByPAleFcxUizSqwa/TnOYvAc99/z1D9cpLz8fZjRLfdPw5oYvyO+g
         NcEtHdZEpJc8rLF4CNKV0hnyAqFMsbKRgQ9Ju/FJIhkve32eMEPIUHgMkoI9mjJiptX1
         yWOsfGbb+SQoHVeNjPpBsfHhO4ahNaOfLECl7lpv2nywtELWKvUdDZsgVCt+QRjCz13g
         B/TCsGMjFSZuvpmUW1n08gl1ORl/Ih4Gahmi5p9b1JLi2/TGM8KiGQR+rRDuJvBlv9Cy
         sjDBCFxXFFMdFS/SyQk9smxGm/6Giq8f2z4oKdfCHDaiagU6kOzkga5mlJtcyK23lkpW
         0Uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2Pf/m8IxK+iW1ZriZeq/+l436sS6/KgFpzzF9DMW4AM=;
        b=U56z663oeaD8wLRRns8DixA3l8+RWZfFvvpdAmarc2CEGypVMcF8L+irQTnU/lW3aO
         g7Bw0hwxdQmqv2Qi4PaspjKzLMy6cMM/8am/grDhTM5/4fxuBXYo25xtHh082E360o2E
         N5o0Yn8PRV37/usaQAwuxwzB++E2TeOb0AS7jUtMj5w00+VTyaJtZqw2IVQ+wWhE4PMu
         QKWkUUH1lwTXqmP83PmE0DXX7kPnbehgYZ4KeFhFrNjGecEFk6WUXrO1mb1Gc3ubnZXl
         26Tvmp8bH+y3BQdtB2Hi/7qmSAe75D0CzhSLE8+hXRD0mFQGfX/4U4ggRvSaxnIhJXJa
         5i2Q==
X-Gm-Message-State: APjAAAVFd6yT16pn6IumxCO2bkeFgRCADkDH6n5NWKWKa9AYZjSnFVW1
        UUC7gfL7fRrNQ/c5cnHjYvc=
X-Google-Smtp-Source: APXvYqwbingtG/Ug2kBio6h2PyL7lJ7L+s5T8+F6+Zj3Vu1UB57N5SMTM4dMWkDNxeeiACcziS9UUA==
X-Received: by 2002:a5d:6b43:: with SMTP id x3mr17853892wrw.76.1551794366433;
        Tue, 05 Mar 2019 05:59:26 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r15sm10292873wrt.37.2019.03.05.05.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 05:59:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git <git@vger.kernel.org>
Subject: Re: How to determine the order of commit
References: <40f11dda.1d424.1694d0cd42b.Coremail.wuzhouhui14@mails.ucas.ac.cn>
        <CAP8UFD21SaWUSqpKjTYVQkbQxLpFEhvjJW8019i6tAS9agnWGg@mail.gmail.com>
Date:   Tue, 05 Mar 2019 22:59:24 +0900
In-Reply-To: <CAP8UFD21SaWUSqpKjTYVQkbQxLpFEhvjJW8019i6tAS9agnWGg@mail.gmail.com>
        (Christian Couder's message of "Tue, 5 Mar 2019 13:39:00 +0100")
Message-ID: <xmqqva0xtoar.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Hi,
>
> On Tue, Mar 5, 2019 at 10:00 AM wuzhouhui <wuzhouhui14@mails.ucas.ac.cn> wrote:
>>
>> Suppose I have "git format-patch" two commit from a repository like
>> following:
>>
>>   git format-patch -1 cf1c9ccba730
>>   git format-patch -1 d1a2930d8a99
>>
>> Now, how to determine the commit order of these two patch in repository?
>
> Do you mean something like:
>
> $ git merge-base --is-ancestor cf1c9ccba730 d1a2930d8a99
>
> and:
>
> $ git merge-base --is-ancestor d1a2930d8a99 cf1c9ccba730
>
> ?

What if neither is true ;-)?
