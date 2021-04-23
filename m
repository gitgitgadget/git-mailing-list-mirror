Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A88C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F7261452
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243503AbhDWTJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhDWTJG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:09:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F26AC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:08:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so75314952ejc.10
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dQld+QGuUofSggnC6UcoH04nX+B48k8MNYR6dQPqU94=;
        b=qU+h/4CRFGJCHtvp7CU5U5oTeZJ/USj9t3c5KZkqJBoLjgJdgBthDbZR7fdwAxtyXD
         niwsxUFLW9LQd3h1VJ7w/BPdbRswb8FDNPnfR06nyLkKZeLbXXrP06k3YdfFFmb48gI8
         SUr44N6sYfz9dT9mv1SOvy/cl3c17NzrOYdOk3PyAL9gXxhjtp6/hZQHL1FptaLSTEaB
         kuwZ6+gVpC6R5F6caypfmLf6fO1EWpZJ1RE1f6anWpTZ7BoBphvZW8luWGugMdTmi2zk
         ojPT4M8Na4S95TRpYnQAOm9ZUSdwraPIAHE2nDJJ7YPb5YnjiwUyt2TjZLaDGWrrlaOE
         YUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dQld+QGuUofSggnC6UcoH04nX+B48k8MNYR6dQPqU94=;
        b=O8iKfEnnyvrIfsSYLcnMS+RUxOfR0eRGm/+HSJX+2uhdbyltZeSGhsXQlTqacQMdZb
         4O9JGxMw/XnPZH9/AS6gbH0fncuEwiE7NskUG+UkTZCvX0WAqRK5V18q4hRCTY7/WNRD
         GyKnpA7vsYI5XdmX24epwIITlKkpRL6h+T2qjeXe1PVuyL2YrJPkh1/yst+CTXsi5hXS
         SFDuxzdIRdKaHckbRHilYLy6uE77nV7p80+r3V6gHlTl9OHUVcyrt2gkraD3/XNWIV96
         S0H4KM2IDE+/5buY2SPCnJ347zt0kRWZnm8tQrb1PGckS6oh/sEP9sJkHShc8IJUnjdf
         i2FA==
X-Gm-Message-State: AOAM531kp5yVv1/R1+io4x14H+YwmpqNRU0vdsuAJBxZnoWRlrMXG6Kv
        2xFhTJNIqsffl1M4REsbLf8SALz2dypaDI6fzJE=
X-Google-Smtp-Source: ABdhPJzdWj6emlFAytkK1JlnvdlV6zcKUWfG47R1pSwRGWC0/qciAJMZr1BK0Vd2jEfUSnyLx90uRN3bZ5Z0XCgcY4Q=
X-Received: by 2002:a17:906:c348:: with SMTP id ci8mr5844069ejb.303.1619204908219;
 Fri, 23 Apr 2021 12:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cQUaJq4Bu1NDSBnsQoR2HXhQ+s+4aQHeVP82DM_BuEL8Q@mail.gmail.com>
 <20210423063632.1973-1-tzadik.vanderhoof@gmail.com> <CAKu1iLVwfQ7Y-bOSO1tyxyFaNWum8sKW4b00i1nJCef98_2=UQ@mail.gmail.com>
In-Reply-To: <CAKu1iLVwfQ7Y-bOSO1tyxyFaNWum8sKW4b00i1nJCef98_2=UQ@mail.gmail.com>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Fri, 23 Apr 2021 12:08:17 -0700
Message-ID: <CAKu1iLXPi4zc-5-RtZo3UBwTQ1GqshXjLEZKT=WvtvB0aiuUJA@mail.gmail.com>
Subject: Re: [PATCH] add git-p4.fallbackEncoding config variable, to prevent
 git-p4 from crashing on non UTF-8 changeset descriptions
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To clarify....

The new config variable I am introducing addresses an issue that only
occurs on Windows.  This is because the behavior of the "p4" command
differs on Windows vs Linux around Unicode in changeset descriptions.

I don't have the source code for "p4", but I'm guessing it's written
in C, and that this difference in behavior is simply a result of the
fact that there is no defined standard of how "char *argv[]" in "main"
should deal with non-ASCII characters being passed in from the command
line.

As a result, "git p4 clone" on Linux is not affected by this "p4"
behavior.  Since my tests assume the Windows behavior, they fail when
run on Linux.  For this reason, I added code to my tests to skip them
on Linux.

On a related note, I don't think there are any CI environments on
github for git that are (a) on Windows, and (b) have Python and (c)
have Perforce, so I don't think my tests are actually running on
github CI.  I'm not sure how that can be addressed.
