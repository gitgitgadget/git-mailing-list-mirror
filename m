Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4401F954
	for <e@80x24.org>; Wed, 22 Aug 2018 18:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeHVVkn (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 17:40:43 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:46532 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeHVVkn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 17:40:43 -0400
Received: by mail-io0-f201.google.com with SMTP id f4-v6so2201593ioh.13
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V6y7V5wDkLUKILxogqhn7QACW/2OZt/+HzoGBERWkX8=;
        b=SLYPYLnjOzj8QGBWm/Sz8n/KhuheipwC6KUQBie1lJ+ylEl+1eIEsd6gxcsGCOcfUw
         ckRPqd5FTAkPSsa4Nq1SbOTJlAWP0l9zH2HYVm3rltD6agSfxQgcgF60BPnIMbmRalIo
         JqE3QptJkTcHIrYof/D4qTlEePi2uIy03JpKDHF7zewpHs+d2FnVArD7YmsQydBbPgwb
         Yad9yKStKTqYLYEIUZ+m8T5jpREaq5hNlAPce9uREgCsubPIj9Bt2nV2vVAzBmgdmItA
         A/kkSb/zSOINXfHLlOdYdUkqzoJWyh11NiOPW9RMzyyKlHCymS9mLwEZWS4wI1n9VbaT
         y5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V6y7V5wDkLUKILxogqhn7QACW/2OZt/+HzoGBERWkX8=;
        b=of67+dL8W5/zjr6ARAUMohVf190W5g49ACn9zRUNYYTYs55utQjS6oxdhXwXIV5DRf
         RwZdsWPTeqVgxwQjzP9u70SEIEv6AqwDwORni5i8Ym0V2ivxVmB7Kg4MMZ+3li6ZCd7h
         qRht4HZqs5WaSECJOSJW6U9XRHrgats7xUbZ4xPuzgrUnanJB6ZOD/27WhmqeMWhq/4D
         CRXJkjMpxJBc2tWlcobUkoiNM8vXGbSAgQLyiJAkemIOqDCaIaYKBYIonAd5e9EsCZst
         /0YXsLj/zctH+TrlsOeINLj22pnpqiCoqa944ZlNlvhHlcI94BSQtT6nuwNrGVQyv2lo
         6VZg==
X-Gm-Message-State: APzg51B1R00u7RM1IufAw1MYx2ieDHzCwfatZZn8+DwUGeoD+baHWIX8
        w5mHGbL+27JdQOWP6BfzF3f59fh76HM=
X-Google-Smtp-Source: ANB0VdYspyT6wbBojlT3591eVk9EJyCEsQov7pKXYAjXTAKBjPNYDG05FxA8FsMRnzPOP7OhwWFyURB0aQth
X-Received: by 2002:a6b:4919:: with SMTP id u25-v6mr1044311iob.0.1534961687192;
 Wed, 22 Aug 2018 11:14:47 -0700 (PDT)
Date:   Wed, 22 Aug 2018 11:14:44 -0700
In-Reply-To: <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com>
Message-Id: <20180822181444.169611-1-matvore@google.com>
Mime-Version: 1.0
References: <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can
 use bitmap' test
From:   Matthew DeVore <matvore@google.com>
To:     rybak.a.v@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, kirr@nexedi.com,
        peff@peff.net, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I would encourage use of an existing function to check for emptiness,
but require a particular argument for it to be considered "the right
way:"

test_cmp /dev/null actual

This means less vocabulary to memorize for test writers. It's usually a
code smell to have special logic for a specific value for a specific
argument - a sign that a separate function ought to be created - but
since we want to add an error or warning in test_cmp anyway when
<EXPECTED> is empty, I think this special logic is OK.

As for comparing against a file that *might* be empty, like a utility
function, might I suggest requiring the file name be formatted in a
specific way if it may be empty? Like require a certain substring. Then
the syntax for comparison would be:

# If the emptiness is unconditional
test_cmp /dev/null actual

# If the emptiness is unknown ahead of time
test_cmp maybe_empty_expected actual

Then, issue an error for something like:
> expected && test_cmp expected actual

which says: "
Use test_cmp /dev/null <ACTUAL> to verify a file is empty.
If the <EXPECTED> file may or may not be empty (as in a utility
function), include the string "maybe_empty" in the <EXPECTED> file name.
"
