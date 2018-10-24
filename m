Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BADA1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 09:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeJXRwK (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 13:52:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54546 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJXRwK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 13:52:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so4604078wma.4
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2xvqxLHVgEv7+5B47/fEGYYiAJgURfdiRZrn1NPeGR0=;
        b=fe/zCnG1NaQ89u7mL5MFAap7S7EoTPf9pz3grYGMvX97/QioSnhFOf/hsHiHO7R4MV
         HjY1xgO9ENXFWq6rWs8o+u3RatcqVlT4dpJelQOb2hnbHuVw0uuxvAW5VmeXNT3VEpvB
         cTqP4kk11/mPCm6BKAkL9Ufz2+WI1lkObPSf7ALZIIJCZbZmuAF/E4FQSesA8Avr8KTn
         BTXTTRGxdDH20NxYQ5UNQdUtjB9zeMDB5SXWQ8gHx4EOKNa9m4qi7sxNVf5SLao6IlAG
         G0vYfkFWdOjhBolw75Jb4fK+N32oJ89c3jNWeEvki5A1rL8Dr1PdUE/FPrcVkRXfuC7z
         3f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2xvqxLHVgEv7+5B47/fEGYYiAJgURfdiRZrn1NPeGR0=;
        b=n+6yyjroBBj9zzOj55zEbz2sbOZxUfMmpAmntBmD5+x+n7FHjb4muRgmkvLkj4Ig0B
         W18f6nCb7+xzJaKADsuNIFLw5dMK1d5pMvqnWgHkyw+uCXrxBxbkBma9dYhHT4YzLUac
         PXQTInsIBOZkroWO7gVxS3808UMh8l2Th56g25iTbR9cWY5xSeMpRK5KFBqjuTEFKEl8
         T87jsVM12qdgmsKQOOXalJOJA9PQ9Z7mfB7MlF1fVoWQqbSYzHqecLbGF32y9IABzzTD
         l101P1Y74MYBbIRNn1Fdh8ZEunoiMsSgwt6Ih8sH/mFcWZsrkEXXCBENs41fks8CJG3P
         7Fsg==
X-Gm-Message-State: AGRZ1gJrT5GWn4rdtEU5zs4UsmcATth2J3mdwwcEZm9j6A2vTGpICaEq
        8z/rQBpkPOYeRUuiyXU08A4=
X-Google-Smtp-Source: AJdET5dQNlxqLgaz6+lSCVtkV5VYRcEGb4cXhP3Y2+eFJNyQGG1bvrxqrJk9891a+7eiyP1swSU0Xg==
X-Received: by 2002:a1c:3584:: with SMTP id c126-v6mr1867584wma.120.1540373087994;
        Wed, 24 Oct 2018 02:24:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j189-v6sm3915993wmb.12.2018.10.24.02.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 02:24:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Clear --exclude list after 'git rev-parse --all'
References: <20181023191758.15138-1-agruenba@redhat.com>
        <xmqqefcgotbk.fsf@gitster-ct.c.googlers.com>
        <CAHc6FU6YLeTBU02k-Md7+H5kJDq2RXZmAXMaq8ZkiuSmZFXbwQ@mail.gmail.com>
Date:   Wed, 24 Oct 2018 18:24:45 +0900
In-Reply-To: <CAHc6FU6YLeTBU02k-Md7+H5kJDq2RXZmAXMaq8ZkiuSmZFXbwQ@mail.gmail.com>
        (Andreas Gruenbacher's message of "Wed, 24 Oct 2018 11:01:54 +0200")
Message-ID: <xmqqr2gfn1cy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Gruenbacher <agruenba@redhat.com> writes:

>> All other glob options do show_reference with for_each_ref_in() and
>> then calls clear_ref_exclusion(), and logically the patch makes
>> sense.
>>
>> What is the "problem" this patch fixes, though?  Is it easy to add a
>> new test to t/6018-rev-list-glob.sh to demonstrate that "--glob" (or
>> whatever that clears exclusion list without this patch) works
>> correctly but "--all" misbehaves without this change?
>
> The test suite doesn't cover clearing the exclusion list for any of
> those rev-parse options and I also didn't write such a test case. I
> ran into this inconsistency during code review.

That is why I asked what "problem" this patch fixes.  Without
answering that question, it is unclear if the patch is completing
missing coverage for "--all", or it is cargo culting an useless
clearing done for "--glob" and friends to code for "--all" that did
not do the same useless clearing.  IOW, there are two ways to address
the "inconsistency", and the proposed log message (nor your answer
above) does not make a convincing argument why adding the same code
to the "--all" side is the right way to achieve consistency---rather
than removing the call to clear from the existing ones.

Thanks.
