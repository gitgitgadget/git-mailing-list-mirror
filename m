Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B283ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 18:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiIIS1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 14:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIIS1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 14:27:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8ED7C512
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 11:27:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso2410321pjd.4
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 11:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:importance
         :references:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=HVEO+7igrKbkgI7ylpvNyDS+tFkB1cMOm9jV+g+UXqI=;
        b=ccKQko1qowj3D+6V5omzVRSNitWK1YXwhjF81QaQSVATIqguF5UpPGTRLxu4gQGfXe
         sp6xrbDI2koD95Hehz8IDBZr/JKX2v5MzEW8HGbhsLxAAehJKsBZ+mxdNQ5nheuafVyd
         uU4p+U5mW6OkQLHmS1Ny1YDCd/MJ3pVOGp69G6qf6osKvtoz4fpRmBq8d0wscU5BZjQK
         SG/3dIRfaq8Am17721EuvSCaGsLYu9PtqnB+V21804p92cYDv2JcgjdunwPfd23DX56Z
         DXq00PjrVZU+ywB1vUZVPzl0hTFWBEynGk4uQFd55lrxgE+sz5ommDW746hXr0Zj6sFO
         lWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:importance
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HVEO+7igrKbkgI7ylpvNyDS+tFkB1cMOm9jV+g+UXqI=;
        b=qokXzJzh9thLZ2K2iDSkhec1kxWRIhRjahhmxYKYbJDpxiXl4RAViG+tbbdpW8Ffj+
         5Mm8x/iEEVmvmkDSK3G9ShF1bPEP8qJsB+KicnVs0Rr6su1jN0mk0ABhFFM80eu57e/P
         YYIVlD4fSQf1eyvY+IJ8VN3bA6qek6A+welhZzPARuDbO24996Lb+ABnkcVvrlNQaeMx
         o2JQUJd53oPkDuweOCDXUqygxAlvdqpFw7+GgS97wyNypYr0ahWeWmaITW93rW7rUuR2
         FITUg2X9glk5gRlboWtiv1CYIQOqhZ6ZKeqwMVursxFN6MEPSVUvvzDgg/gY0/I1QH1a
         /kPQ==
X-Gm-Message-State: ACgBeo1SMn1iAySszGe9wEVycWUd23cceO2m8hiMa09bsk/Vs9CqG53G
        PaYWPZ4xIDuynbJgsFWy31c=
X-Google-Smtp-Source: AA6agR6GSQdVKGIolh7llf2/v1/OHj8FW3BUfdwKtsMxxOQ2+oubFNhinDv0Bv/7MxnA5Hqta0epjA==
X-Received: by 2002:a17:903:189:b0:175:4643:f862 with SMTP id z9-20020a170903018900b001754643f862mr14901710plg.5.1662748065777;
        Fri, 09 Sep 2022 11:27:45 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z2-20020aa79482000000b0053e47dcfa32sm35450pfk.155.2022.09.09.11.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 11:27:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Lana Deere <lana.deere@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
        <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net>
        <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
        <Yxf9yETBi3k6Wasl@danh.dev>
        <CA+4x=b9M+HRWdDx-Mr4q0NiRQESwJ5uEkOBL_nVPPPHhXs7i_g@mail.gmail.com>
        <YxjhQ8xVI4YtA7xb@coredump.intra.peff.net>
        <CA+4x=b9upd2uTihZK5hXDULkCz6y+CX-dS7p65Pfhn0zh0eMiA@mail.gmail.com>
        <YxkI2zqCheqTv/wc@coredump.intra.peff.net>
        <CA+4x=b-SqzGfeTu4c8akk3quYF7ORZ5jYCpey5221H8=+_PfRg@mail.gmail.com>
        <Yxow7zrYF/xOijVr@coredump.intra.peff.net>
        <CA+4x=b_eOO=ThnSkMARPXBH6cJLeuYPfF-PZNy4Vjpbk=BWQYw@mail.gmail.com>
Importance: high
Date:   Fri, 09 Sep 2022 11:27:45 -0700
In-Reply-To: <CA+4x=b_eOO=ThnSkMARPXBH6cJLeuYPfF-PZNy4Vjpbk=BWQYw@mail.gmail.com>
        (Lana Deere's message of "Fri, 9 Sep 2022 13:32:49 -0400")
Message-ID: <xmqqr10kjtcu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lana Deere <lana.deere@gmail.com> writes:

> I can use a workaround to continue testing 2.37.2, but I saw in a
> different mail that there has already been a patch for this problem.
> I'm guessing that will be in 2.37.4.  When would that be likely to be
> available?

It is unlikely we would have 2.37.4 in the first place.

The patch was already discussed and I expect it would take a few
more days before we agree it is a good approach to take, at which
time it will be merged to 'next'.  And then it will be cooked for
about a week, before graduating to 'master', to be part of Git 2.38.

Usually topics for fixing bugs are downmerged to 'maint' and lower
after they get merged and spent at least a week or so on the
'master' branch.

But by that time, the tip of the master branch would be already
tagged as 2.38-rc0 (see https://tinyurl.com/gitCal) and it is
unlikely that we would issue more maintenance releases for the 2.37
track at that point, especially given that there are not that many
other topics to downmerge to 'maint' remaining on the master front.

You can see when Git 2.38 is scheduled to become available from the
same calendar.

Thanks.
