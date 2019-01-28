Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CA891F453
	for <e@80x24.org>; Mon, 28 Jan 2019 00:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfA1ATU (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 19:19:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52027 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfA1ATT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 19:19:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so12167743wmj.1
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 16:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qXK49bX9xdl1h1332x+UrOhflLqyd7W6ckN3e8i0IOY=;
        b=spcui7W0oSe8+rzIUJgkWwlB/36Lvv8vDb1B15/RrhnFIV0EZ+nhkTaSHQAiLeecfx
         XE8nIkJyg+wfYeM6cIp7gKFd/O4qXGiVP4+4boUSByKy86Hqz/ciGgxmBBEqw1CnPLRu
         iglUED0qKJD2+NrzzQ6i7jR2GxamMxmcu8f0T/vkQNPNprQ8kYcn3YsFVltwLvT49Smb
         TKQ5TIUv6ULAqT7hQoBjT7h6txF3PbfuVIoG8zi6iS7k+J9DbiD1OTbO0wyACESYhHcP
         Suv/ZQCqgnTG0IB/Y3mAkAWTgvbVQenhrydk+VGQtXi0+yhffWPrisngg0SUs+Io7FD7
         Zrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qXK49bX9xdl1h1332x+UrOhflLqyd7W6ckN3e8i0IOY=;
        b=NxdKXRnX37MigShZnR5bIDA4UG3QM24nmbqDXu9k4q0h+Na1gVSkl34618tLC9vQ7v
         XqfLL4iiljXy3fWN+WY5a7cY7CSfHBBkpYTD1I0w8LyaH3Qr/9dBqiewXo3zZGvDavMa
         obGq9Snyg8sVJNE/+lUMwYj5v8E4sE0C4SRaLHk7q63e1t5kQSTNZ3nfEdtcL9KR+bYq
         Bp8WSg6gs2uIvpZAHsfg+CUcCVph+QdE0848x+JuApclADoveARbSG2ffMVd4r/cZNQf
         dbscdjOHaWCBy3OncmVpNgj6IkG5WbKcSjpRKAnUwZ48iUanOWh1Y/32Yzsb0t0sDMiO
         /IPg==
X-Gm-Message-State: AJcUukcpcnnV4wpYUxzoh1p1JM7uGtUdMXPU6oX5inJyFB17qpK3zwKF
        Rqp3OPh99BRRa6xtx2lx5KLOpdC2
X-Google-Smtp-Source: ALg8bN5/aAlPKhzPaZH9Dfl7BpMVQ1ZT2iat985wZjqnbUC9GoTKO6q/jT6EkfPewvzi2bRMzVIkWQ==
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr15229494wme.118.1548634757653;
        Sun, 27 Jan 2019 16:19:17 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c15sm51465197wml.27.2019.01.27.16.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 16:19:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] log,diff-tree: add --combined-with-paths options for merges with renames
References: <20190124164654.1923-1-newren@gmail.com>
        <xmqqmunofsdv.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFjUgY5htSbPpnamPDRM3bCLNsQv-K35uXoRzaT2f85tA@mail.gmail.com>
        <xmqq8sz8fkfi.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFaVwwM17Oe+-RoP5wt2V58AD=dr01uNPuV=9r4yoF3Qg@mail.gmail.com>
Date:   Sun, 27 Jan 2019 16:19:16 -0800
In-Reply-To: <CABPp-BFaVwwM17Oe+-RoP5wt2V58AD=dr01uNPuV=9r4yoF3Qg@mail.gmail.com>
        (Elijah Newren's message of "Sat, 26 Jan 2019 14:12:41 -0800")
Message-ID: <xmqqd0oheirf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ... Instead, I decided that
> instead of having a "from" and a "to" header, we would have N "from"
> headers (since all parents are what we came from) and 1 "to" header.
> I hope that makes sense, because otherwise I think this become to
> unwieldy of a change.

Yeah, it makes sense for an N-way merge to have N 'from' pathnames
that resulted in a single 'to' pathname in the resulting tree.

