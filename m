Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2A6B1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbeKNBVS (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:21:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37925 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbeKNBVS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:21:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id f2-v6so11771760wme.3
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 07:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:user-agent:date:message-id
         :mime-version;
        bh=o3LlZ69KXPzmVCjoF4uj8tOfx9So1reIv0bNDkJCcSo=;
        b=JXOXCZ5b8iVXBjWEXW/aXQ5M1hB9sg/fDlWBgFDiFAwcya8ccacLg2vCDFD+hdnOWu
         nZ2FGre1HzzdqYKpXgkJFWrOhj37SXVEFJzj0ZZfBh3fi65EjrwxuvIbKetbKrsy4JBA
         9Z/PuNeUzCjwxrjGoKLOqOwY8C5U6HVWOl8+3ohU1MfPxAIfmiqDFvTdevCj8e7ZmnFK
         q9hFVa1xwJ/n1s1+pnm03p9N2XruAcYDaMPKxgoTGJKMKC//ydAD2ct2JfEoAFobS/B8
         s2qGfHlPc3bgghPqZ3csquKbhCrPwBvP2DFlOWIkE15N/awqNE1aSA6SI68VIfQ/HXKE
         +Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:user-agent:date
         :message-id:mime-version;
        bh=o3LlZ69KXPzmVCjoF4uj8tOfx9So1reIv0bNDkJCcSo=;
        b=WnQKAlW9vxxYxtEdhf3m4FD4mEdiR7qU3XDdoqFyFANpbTy/2Qb7YZDEYLMHDG+RjQ
         ACiqbgEMSgkiXsxJSkozX61PnOHGz+fJh/RTFXF0MuBE601iE7HBY0iROhfL/119f5rH
         0DkXjIx/HDHnomxvyXUBWd7VQYyv+tlTBsb4nXmWPBuIQhZMpDmdMg5Q2ztVLTdJ0mZl
         0Ea6570tYjDPpI175+FFSR2cMbURXOqS6YffaL4/o97nNgG+VbGT5z9as7N1XofZyoBf
         5u989wfPOOhVRN61HzWEk1F3+wz7awW442cdyDO3qgV/4B8P0lKT4b7j8X7/yECwE4dK
         yv9Q==
X-Gm-Message-State: AGRZ1gLeU7i40zDTurrNcJBoEbI+Ea+oZ1cXOoNFjSP3Pgsv7oqCDUKP
        7bYbFLfi3X2BgGo7xf4ZbxE=
X-Google-Smtp-Source: AJdET5c2gUZRFCkagXRjpjOtpRwRZkAyTGMdvK0zINA9RzbKXdx3bz/o8luL5r3wU6VavK8x+3j7QA==
X-Received: by 2002:a1c:6754:: with SMTP id b81-v6mr3749006wmc.104.1542122560900;
        Tue, 13 Nov 2018 07:22:40 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id o126-v6sm9712386wmo.3.2018.11.13.07.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 07:22:40 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] read-cache: use shared perms when writing shared index
In-Reply-To: <xmqq8tkjkdgl.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Tue, 13 Nov 2018 16:22:38 +0100
Message-ID: <874lcl2e9t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, 22 Jun 2017 12:51:54 -0700 Junio wrote:

> > Let's fix that by using create_tempfile() instead of mks_tempfile()
> > to create the shared index file.
> >
> > ...
> > -     fd = mks_tempfile(&temporary_sharedindex, git_path("sharedindex_XXXXXX"));
> > +     fd = create_tempfile(&temporary_sharedindex, git_path("sharedindex_XXXXXX"));
>
> So we used to create a temporary file that made sure its name is
> unique but now we create sharedindex_XXXXXX with 6 X's literally
> at the end?

I'm looking at some of this again. Yeah that was a bug in Christian's
code, but interestingly if you just create literal sharedindex_XXXXXX
files (don't replace the X's) the whole test suite passes under
GIT_TEST_SPLIT_INDEX=true

That seems like a major blindspot, i.e. we don't seem to have tests that
stress test the case of >1 split index.
