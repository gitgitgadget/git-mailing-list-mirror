Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04FB1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 19:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeCVTyB (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 15:54:01 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40310 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeCVTyA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 15:54:00 -0400
Received: by mail-wm0-f50.google.com with SMTP id t6so18397703wmt.5
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2pz3XQ6kz7AT2erRNaC9qep2+WqRW2uuCyPpm8CjSAg=;
        b=CJceR3A3fTJ5jeaLIiL4Ew8auIZ+akvhaoLJHN5Kmi4xXebOVdfVvXqpGB9Ym1dOs3
         0KIG3jqg2c/58QP/dilbeP2j4wRB11d+dzqLy5M2tFJKIDEUyjYTPjbdgpcUBNqsfp1n
         Sq8Fcp0qEtnR6k7KMhQtuOs+FA4WGN4JwGXbEBIf9hTlUPu2AJpWk938MTfKXyGETm3y
         W8x2cQTMzhCquE+vTBSvDIbaUBmnhPqNm+ePsx8SOApKy3HV5bMQ0w9Nay14XQjyxvlw
         xE9ei0uGbICmHIrhgzOHIE8CK7SJkLHtzmfZZfMTctld2iejaPEQ4yp8tKbvK4MVIFE4
         3wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=2pz3XQ6kz7AT2erRNaC9qep2+WqRW2uuCyPpm8CjSAg=;
        b=fa4uKMVlR1ppimg0XqchjdbjLbwTtqwZSNKPHT2ZZSaPiGnq0BP4IxVBH7XBCjqn0C
         xkdcksHk5SNf1ImdBcX/seS3ql6AIGaofSqM7lrSSjbaJNjmKCsbDDl7PW/DLpaMhmh8
         CBbvw45lddyqFXmKhzjumTKng1GUrXqDjO67R7idANWmZTZH3vdTi0O4vjaWqHIWBi72
         asOHHanwhZAmzXEHWSrDhmgtwIo2bjPGpxkJRnbebAHrLUdc5Gz1B2klhwo5D4v9RW1J
         RWFeTWJQo7vbmleZqTzN1KOl7BfZOI6eRALZEhjzuK1z7ZbkpcOvYRbHaGFWATQUxKGF
         7yHA==
X-Gm-Message-State: AElRT7FOdtyi3vHIyF+LNP5aNhD+z2tm69QdVTXkmSJCfxFsa+9fqG/M
        /7vSkOILVUDqGO2M8q7qRMg=
X-Google-Smtp-Source: AG47ELv+lJ4YM+NMv6IY1ziKtmEp756JWS/+4MR7AYXErzDYR3btllu87Uha7S3ezNVA9O5psB6mRw==
X-Received: by 10.80.165.175 with SMTP id a44mr19848595edc.308.1521748439529;
        Thu, 22 Mar 2018 12:53:59 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o3sm5166424edi.24.2018.03.22.12.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 12:53:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: The most efficient way to test if repositories share the same objects
References: <14d0937f-0e39-7af7-a395-3046ec5d5c16@linuxfoundation.org> <87o9jfyl0y.fsf@evledraar.gmail.com> <xmqqlgejlx8e.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqqlgejlx8e.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 22 Mar 2018 20:53:57 +0100
Message-ID: <87muyzyjhm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 22 2018, Junio C. Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> But of course that'll just give you the tips. You could then use `git
>> cat-file --batch-check` on both ends to see what commits from the other
>> they report knowing about, in case they have branches that are
>> ahead/behind the other.
>
> I am not sure how you are envisioning to use "cat-file
> --batch-check" here.  Do you mean to take "rev-list --all" output
> from both and compare, or something?

By doing something like this:

    (
        cd /tmp &&
        git clone http://github.com/gitster/git gitster-git;
        git clone http://github.com/avar/git avar-git;
        git -C gitster-git for-each-ref --format="%(object)" | git -C avar-git cat-file --batch-check|grep -E -o '(commit|missing)'|sort|uniq -c &&
        git -C avar-git for-each-ref --format="%(object)" | git -C gitster-git cat-file --batch-check|grep -E -o '(commit|missing)'|sort|uniq -c
    )

Which outputs:

    673 commit
    696 missing
    374 commit
    495 missing

Which of course, as noted, isn't going to be a good general solution in
all cases, but it's blindingly fast, and since the original question is
essentially that he's starting out with doing a rough equivalent of
that, but for tags only, maybe it'll work for his use-case.

> I am not sure how Konstantin defines "the most efficient", but if it
> is "with the smallest number of bits exchanged between the
> repositories", then the answer would probably be to find the root
> commit(s) in each repository and if they share any common root(s).
> If there isn't then there is no hope to share objects between them,
> of course.

Yes, that would probably be much better:

    diff -ru <(git -C avar-git log --oneline --pretty=format:%H --max-parents=0) \
             <(git -C gitster-git log --oneline --pretty=format:%H --max-parents=0) &&
    do_stuff_because_they_have_stuff_in_common
