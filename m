Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7DE20374
	for <e@80x24.org>; Mon, 15 Apr 2019 09:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfDOJ1t (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 05:27:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38738 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfDOJ1t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 05:27:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so19423698wmc.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IcIN4RpoZn+pHoTVoYZf10IHza4qFbNUY8ZYSCCDoT0=;
        b=lQTF71PBwaJv8JdXgFOwQUi+uuB2I2iVqZQnsvxH9+PqBOwRiwuEmsRaDorns5wdIU
         vS9Bu67eSuIjvbjdVHPP3SnIGkH+FMg+1UQCAlJukwpVy3iEPYMGKiXx9wm/gmcJxq8I
         ccbQDOHB76+Ih2UalbvLDAo2IktsQYSrUTXr5Q/CVpL20gtNIymZTaFL8+PdHCpZQ7pT
         3vsI/WbF1Y1p42CQQ+lDxzZTm7z3z4xXAsYtx9o+456fw5sScBmx6DeMS0vUiYbJcOPT
         AvOu5hFonH7E3YOkwV1+YKGLbQmG3+bvkcZrCG19tEpfo9GDmPr+fRqeHRTeM2GyjxKK
         D2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IcIN4RpoZn+pHoTVoYZf10IHza4qFbNUY8ZYSCCDoT0=;
        b=Wv0ro6SGiSIKxUliY2VpY6frEZ5d2Ta/mKtbUE1SgG1LkYrkKGUTIB4xmp9ckTbPxI
         WMdv9i5/eRC9KyB2Iuw4nR30F3r729e4fiY0eiUabhUsMdG/ReIh52+RM0Jkp+9geiy7
         98ldvDmdZNeiWF0KJ+DBQOclfXUbsnx0qYIfBodls4lGxST7YhJQ5q/vT2Mc7/VNjvbn
         5kuQNXRjRT25N77/PH0O6sSarVKOLeKvf0G5ZUlyV//BK11DYzsDoP42WwqAy47qZ2tQ
         kG+hU8G8nSZ9b9yoy7Tbujro9pdjBzcjqTmiedWplhYJWuCXxgq8Ozn8ErMmsG6YUTzC
         WImQ==
X-Gm-Message-State: APjAAAUnbqlMJufXoeW5kb5Ipf+3X1C0zEv6T5GF9cbun2g6QvsLR0vZ
        d4sDi8xfymECnGW143niZTI=
X-Google-Smtp-Source: APXvYqyrkI2p3PQZ/vXuBa5YUoNjiWDyt0GZSzeVDwAmgzF8tvpF04amYUadRX60ptTWA3yJD+QOPQ==
X-Received: by 2002:a1c:4e04:: with SMTP id g4mr22027187wmh.127.1555320467098;
        Mon, 15 Apr 2019 02:27:47 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w16sm70161034wrt.84.2019.04.15.02.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 02:27:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 00/16] Many promisor remotes
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
Date:   Mon, 15 Apr 2019 18:27:45 +0900
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 9 Apr 2019 18:11:00 +0200")
Message-ID: <xmqqmukrr52m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This patch series is based on:
>
> 763fb763b8 (Merge branch 'jt/batch-fetch-blobs-in-diff' into jch, 2019-04-08)
>
> to avoid issues with jt/batch-fetch-blobs-in-diff.

Yuck.  As an experienced contributor, you should know better than
that by now to do that.  A merge into jch/pu are rebuilt at least
once and often three times a day, and in no way a good solid base
to build on top.

If you really need to depend on another topic or two, please base
your work on a merge between 'master' (or some well known ancestor
of it) and the tips of the topics instead.

Having said that, I thought that the semantic conflict has been
corrected and the machinery to rebuild 'pu' has been replaying the
correct resolution ever since, so there was no need for such a
rebase?  Isn't it the case and do we still have the breakage due to
semantic conflict with JTan's topic in 'pu'?
