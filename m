Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31D6B1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 18:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfJZSZq (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 14:25:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46785 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfJZSZq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 14:25:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so4619946lfc.13
        for <git@vger.kernel.org>; Sat, 26 Oct 2019 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Yoa5kKgMtoEzNjUbo+0vY/L1U2hX0wI0SQfUr7gEtxU=;
        b=rL8pKB1CR097RahVE3erTBweuk+hjM3pgWqAnWlQgEoal3YyeUzwQ4a40/FSphG1ME
         xspxm7V25bkZn6Dqg2/DwBA0LqZcfPLNnFrBZ8ySAyxVEWiDUI++Cr/IZwu5CPgxr/xz
         lfYAD2qyaKcB4CyizKD0WXasNUMXxd43as+sd0iYREFFUwnUdi2PbhQGd+FrnVlLYz3k
         k5+4gJe2hHYIMkMyDUAT3o6OG9BkCGwTxr++FbfBqL6FcuImDtkCnG2LuKnrO7TSLXyw
         06tl37/jmSJbVbYqsPL0sHfiIUCZmJib/z6eG1UEXzj1LFcwa0bo1CKzWybW5/zm+Us3
         1qEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Yoa5kKgMtoEzNjUbo+0vY/L1U2hX0wI0SQfUr7gEtxU=;
        b=nDqCxheIBENs+UAMWpgGaWNLiNnVf9t2WtJ7u9sHrvnw9sOEaNX7orUDV7QioRkeh2
         TTi94T8PUxSH4f8DXrSiRZoat6BshRs/H8DR9Z7OCIkwg7mxs6SblX/EZM6jYPRzPcdT
         x5R9VL6/aRhDcJWAcqQrHFdOPmanqfR2+M/M3brKTMJcFShxLVwSF7Jy3tCeZXhxydu+
         2lXL8zIUTAc73q8WVD96mCC1O1Pe1JF1gnCfFcLBMiOVVmiGZZIap4Pp36ISboJMYr0Y
         BnDQ3SV94j+5Ias0fP2Hhu1tDNhKzLxtYmHCgYL8Gw4xK0NpkXGYTISbqSRiyypFPv72
         ScfQ==
X-Gm-Message-State: APjAAAXs0xHWyJqRIJg3zkC+CjF6rsoqWPX74kUURgTHWqqVTW4xCbY/
        XVJOVJzu6A8B4bbjFyox/GM=
X-Google-Smtp-Source: APXvYqwx/uniqq+mTYlxTd7V05UZWph7Wfvyu26qONZDPH8kQlsr0kDkbZY7f8TcFJnnjBJ0PC81bA==
X-Received: by 2002:a19:c3d1:: with SMTP id t200mr5577007lff.52.1572114344587;
        Sat, 26 Oct 2019 11:25:44 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id y135sm2916012lfa.92.2019.10.26.11.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Oct 2019 11:25:43 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: RFC: Moving git-gui development to GitHub
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
        <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
Date:   Sat, 26 Oct 2019 20:25:40 +0200
In-Reply-To: <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 24 Oct 2019 12:46:20 -0700")
Message-ID: <86k18rbbyz.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:
> On Thu, Oct 24, 2019 at 2:45 AM Pratyush Yadav <me@yadavpratyush.com> wro=
te:
>>
>> I recently had some discussions with Dscho about whether it is a better
>> idea to use GitHub for development instead of email [0]. His argument
>> was that GitHub makes it easier for newcomers to contribute, since more
>> people are familiar with GitHub compared to mailing lists. Also, it is
>> somewhat difficult to set up an email-based workflow.
[...]
> GitHub is great for ease of creating new repos, learning about other
> developers, finding similar projects, creation of webhooks, etc.  But
> it's *awful* for code review.  Gerrit is a lot better at code reviews
> (though still has problems); so maybe dealing with both GitHub and
> Gerrit would be reasonable.
[...]
> Email is a horrible medium for sending/receiving
> changes, but at least it gets the overall code review model right
> (commit-messages-are-first-order-objects-that-can-be-reviewed,
> review-individual-commits, merge-per-topic, cover-letter included,
> range-diff for high-level comparison of different iterations,
> reversing-commit-order-display-based-on-author-timestamps-is-NOT-forgivab=
le,
> Change-IDs-are-ugly, magic-refs-are-disgusting, etc.), something no
> GUI tool (yet) does to my knowledge.

I agree with that.  You need then to decide whether it is better to have
it easier for beginners to contribute, or is it better to have it easier
to review code.  What are the pain points?


Another source worth looking into is "Patches carved into stone tablets,
why the Linux kernel developers rely on plain text email instead of
using =E2=80=9Cmodern=E2=80=9D development tools." presentation by Greg KH =
from
2016[1][2].  But remember that git-gui is not Linux kernel; what works
for one might not work for the other.

It is unfortunate that we have no tools described in "Patches carved
into developer sigchains"[3] wishfull blog post by Konstantin Ryabitsev...

[1]: https://kernel-recipes.org/en/2016/talks/patches-carved-into-stone-tab=
lets/
[2]: https://www.slideshare.net/ennael/kernel-recipes-2016-patches-carved-i=
nto-stone-tablets
[3]: https://people.kernel.org/monsieuricon/patches-carved-into-developer-s=
igchains

Regards,
--
Jakub Nar=C4=99bski
