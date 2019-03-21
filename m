Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE6720248
	for <e@80x24.org>; Thu, 21 Mar 2019 03:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfCUDPX (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 23:15:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38652 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUDPX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 23:15:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so1193941wmf.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 20:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kskm603tYwtrY5yLra/Gy0H2tLQgEDwBgAVtMZ5EJe8=;
        b=EyXmATlwc/OQJz3LyYqUiLYrwp4v9DCwLNGzlzbVYcrHFlxcDpT9E5mUClXfXa+/UM
         Te3Zw7ciTf+OvbI0vuAKsjazoAx5C13I54OvuhEY94jPUIXN3vYemLCIweA8ouEZ7bAD
         KHE0HbOF6y3/HBNsJLE9Mr2Wbgmwa/XCQ4dvsQxe8hFHDcf29VhQsL+FO/Z7RmB/YXr8
         mI9rnOIu+6Pw43o6dZJy3llqTXz55VdmuS+8W9xJkcsUxjNnkwGJKWO79zBN52FbDa0z
         Ca5JoVTOKoLa9k6pqpXKiCylrJBeyWBuuP0AoO7B+mwiXdibfocb+BvJhtNp6FF/PDcs
         XIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kskm603tYwtrY5yLra/Gy0H2tLQgEDwBgAVtMZ5EJe8=;
        b=YK3OHu5oUPpMUvixjhoXep/h8zG7WK2KW/OWtNIY1OtJYc3bFL1KN5TO98/321R4hC
         nlz0h9FfvboGA/YuFpyg+ofEfPpCzFl7bSvhA7/smVPO+ErMHopiGdJNbX1GrjoUyPY2
         nTuJIasJ1CgymXacsgMJDIf2nrub1Zp7UJ53neYI6pi3ZZMKJQJyaNgXZrfDg2c7gDEo
         lKfr/NRolnlerpR4XyUjIZgPG6N2NYg5RFqBSlVJo8oMPzAl2uPYociL6o2MlFHtltwT
         s++QT/+xcED8iyBmwFYA7vnl2v+KyvtMwSijaKnqSYrTqLlI0YYWexXJi62OUol8DbdX
         2/gQ==
X-Gm-Message-State: APjAAAXN1fXerIxKSmUW+p9vzbml2rVesh5HPxZtit4wY+cVutyvSzrr
        6L0MhFCYumGWN/bgedOc+oM=
X-Google-Smtp-Source: APXvYqxPsjX/YnpOzUZH26DLaBiI1+U7ckvAFIhlbBVHYJxS1lDxU3HKAx9cHkaKoVDqfQFTzPjqIg==
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr906850wma.40.1553138121280;
        Wed, 20 Mar 2019 20:15:21 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w13sm4962259wrr.21.2019.03.20.20.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 20:15:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        "C.J. Jameson" <cjcjameson@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
        <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com>
        <871s31vjo7.fsf@javad.com>
        <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
        <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 21 Mar 2019 12:15:19 +0900
In-Reply-To: <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 21 Mar 2019 11:17:46 +0900")
Message-ID: <xmqq4l7wuddk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> This worries me that it'll lead to bad surprises.  Perhaps some folks
>> cherry-pick merges around intentionally, but I would want that to be a
>> rare occurrence at most.
>
> We can just reject this RFC patch and we'd be in a slightly safer
> place.  You still need to tell us with "-m 1" on the command line
> that you are picking a range with merges in it.  But then I am sure
> that clueless people blindly would alias "pick = cherry-pick -m1" and
> use "git pick" and blindly pick ranges here and there, so I am not
> sure such a slightly-more safety buys us very much.

To put it a bit differently, I share with you that picking merges
should be deliberate and it is safer to make sure allowing it only
when the told us that s/he knows the commit being picked is a merge,
but when we started allowing "-m 1" for non-merge commits in the
current world where cherry-pick can work on a range, the ship has
already sailed.
