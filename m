Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E5C2BBCF
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 15:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D9023B6C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 15:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgLRPu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 10:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgLRPu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 10:50:59 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A81C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 07:50:19 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d8so2289441otq.6
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 07:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=v2cs9r6LX5WGsWLoUxPBkkMdFz8MNxdGZ6KJ1FuJn7A=;
        b=vZiap0jELGXTT2yT+BI+xRdUBxKUfqGowcrW4eF0l3YCKz1cWh8YqQJwfOjRt4aH2K
         i8kkasS0RZwM8trb1ydj1Y4Uo4BQXfYah8iR1ljq4LocOi88QwWZgvWIP9kiD/CQFoLV
         e4RpD9IYObZB2ohaZ2waKerYYJjR1wik1uYvX+QRILKmPd0bcm1xCETr8XUHmmtsvG7e
         N9CtIagRhQcePCXUYTsb5GBWmtEpOVsA1FM0SQpgNJnnQbThqRnAFDx47KTQDfvPbL7c
         dRS17ersy3H8TUh29hGIbIkXU9TwF3agiILMK9CQIc/hSgupaNCoH6WnEZEo8q56V9jc
         J4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=v2cs9r6LX5WGsWLoUxPBkkMdFz8MNxdGZ6KJ1FuJn7A=;
        b=T0RnfCzbnkCcuNx+sBy3L12CGzUfj/2hjxQsx+1QDa6MB76L/3VwXzuJNGH5gmcfnj
         MSI80QzqhEy/GdHrnVIMKuBEDq6efTh6M1r9TWoWoxtbYlvuEKet14JIP5CLIheoyKIc
         oEe2DJYlLqZGnHX+G4juEp0g/PKEkShydZvJLiOszprj/5rm82ajElKewzfQnqLR7sFA
         rf/5uYz1q/pMCRgplp3jbGWSC9GtV7QyN0Nt7Q6+VaLC4g3ynCuhbt7h6ZbsPdLRJlt5
         Hr5FJ+muWWvZeht2hHAiGEBljwD4P3K9pvhmDM3FM4zZrkip2BmjfaLfIYhpDS4MKAZg
         TS0g==
X-Gm-Message-State: AOAM532cn1SgHCvSAdeTYchVz3Gr1F84hGwi0UjJKQ3qvQtOGVh1+4mf
        dCeDBR61faDpOhySpmLdpmc=
X-Google-Smtp-Source: ABdhPJxhVRQ0pcj+UYy8FsdmlMnPueqgxl+qi/ovew2z8xq9NCUIHztb/SB3gkVjVlpWW0SOmBy2Kg==
X-Received: by 2002:a9d:7851:: with SMTP id c17mr3276860otm.255.1608306618071;
        Fri, 18 Dec 2020 07:50:18 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id o49sm1947491ota.51.2020.12.18.07.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 07:50:17 -0800 (PST)
Date:   Fri, 18 Dec 2020 09:50:16 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>
Message-ID: <5fdccfb8179d9_127502208c4@natae.notmuch>
In-Reply-To: <CAP8UFD0X5HR67T6msOhJwgAGKQfgW4JxH+pJprseBi9XAZ2rCw@mail.gmail.com>
References: <20201218151406.1193792-1-felipe.contreras@gmail.com>
 <CAP8UFD0X5HR67T6msOhJwgAGKQfgW4JxH+pJprseBi9XAZ2rCw@mail.gmail.com>
Subject: Re: [PATCH] test: bisect-porcelain: fix location of files
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder wrote:
> On Fri, Dec 18, 2020 at 4:14 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

> ...if we wanted this kind of bug not to happen again, we could add a
> test here, before `git bisect reset`, to check that here one of the
> files below actually exists.

Yeah, but that's like testing the test-case.

Unless the .git directory is renamed by default (like s/master/main),
there would never be a need to update this in the same way.

Cheers.

-- 
Felipe Contreras
