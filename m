Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB0EC43457
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F012231B
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="f5WJUJBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733042AbgJSVac (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:30:32 -0400
Received: from pine.sfconservancy.org ([162.242.171.33]:51772 "EHLO
        pine.sfconservancy.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733038AbgJSVab (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 17:30:31 -0400
Received: from localhost (unknown [216.161.86.18])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 858FAE374;
        Mon, 19 Oct 2020 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1603143030;
        bh=m6NEpZ1JA3uauTiHdopQ0b87m6lXxV1ifKVLBN5Jj7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5WJUJBopnIhhu91OcQedlKFGMDnb0p9YeqB+VJqApDS+obBvakRh0pA3pvoiqeg9
         ODZOTh0AqZn/1zsKgW9mmJx7NIZNHD2eOumOSdrUe3Iqx5T8VINB5fhjlEwTmAtMSu
         pNjhZ8DPbzaLqx0cORnUL3Vv9GsBw4TYlzTAyh88RJoEU+EoS70SOMNrHAnUrJ/P8J
         zADdH2xqrN5EKSDUwfQ7w6cjRwCCVjDMOYwrgXjEI6e/CCn7rASAQP9ef0I2NrfRTn
         vf4NaOoQNKvT/k7Bqwkm9fQk6UcWvMbmZ+c3dfohHa59oZhWZ/f2tG6UcH2Ke6pGv2
         I65Mo8YMtbjSg==
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] clarify and expand description of --signoff & related fixes
Date:   Mon, 19 Oct 2020 14:25:41 -0700
Message-Id: <cover.1603142543.git.bkuhn@sfconservancy.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <xmqqmu0it6ls.fsf@gitster.c.googlers.com>
References: <20201015215933.96425-1-bkuhn@sfconservancy.org> <59E3B060-63E3-41C2-A7C4-5B2C888F8D68@gmail.com> <CAPc5daWenXds=0BW0CXa=4MOF2UxDeQ8DF2+7V9-WkKwCFCDBw@mail.gmail.com> <20201016015937.GA3335046@coredump.intra.peff.net> <xmqqft6eewc5.fsf@gitster.c.googlers.com> <xmqqh7quaqwb.fsf@gitster.c.googlers.com> <20201016201119.GA3356073@coredump.intra.peff.net> <xmqqwnzn73og.fsf@gitster.c.googlers.com> <20201019155338.GK181507@mit.edu> <xmqqmu0it6ls.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Organization: Software Freedom Conservancy, Inc.
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff wrote last week:
>>> You said "squashing", but I'd suggest keeping it as its own patch on top
>>> of Bradley's.
Junio replied last week:
>> OK, let's do so.
Theodore Ts'o wrote today at 08:53 (PDT):
>>>> I pointed out a missing article ("a") in the line *above* ... It's a
>>>> minor nit, and it's unrelated to his proposed change.
Junio C Hamano replied today at 11:26 (PDT):
> In any case, an updated version that ended up
> being a 3-patch series is now on the table.  I think they are in good
> shape to be merged down.

Herein is (I believe) the three-patch series that Junio references.  The
middle patch didn't exist yet because Ted just pointed out the typo and
didn't have a patch, but I've done the typo fix and credited Ted on that in
the commit.

However, the middle commit ([PATCH v2 2/3]) needs some review.  I ended up
down the rabbit hole of "what is the consistent way in which the Git
documentation refers to Signed-off-by?" and I found many inconsistencies.
I've normalized around a style convention described in that patch's commit
message.

Meanwhile, I also note that SubmittingPatches now calls these "trailers"
rather than "lines", so maybe we should be using the word "trailer" rather
than "line" consistently in the other documentation?  If folks think that
should be done, I can redo this patchset to go that route.

Alternatively, if anyone has any strong opinions on the normalization to:
  (a|the) `Signed-off-by:` line
in documentation formatting when referring to Signed-off-by, please say so.

Thanks everyone for your comments and help on this!

I also added these, as Jeff King wrote about at 17:46 (PDT) on Thursday:
>>> To be clear, it's...
>>>  Signed-off-by: Jeff King <peff@peff.net>
>>> as far as any words I contributed.

Added.

>>> I probably would've kept "clarify" in the title as lowercase.

Fixed.

>>>>> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
>>>>> index 80d4831662..c9df9cc0f4 100644
>>>>> --- a/Documentation/merge-options.txt
>>>>> +++ b/Documentation/merge-options.txt
>>>>> [...]
>>>>> +	leadership of the project to which you're contributing to understand
>>>>> +	 how the signoffs are used in that project.

>>> Extra leading space on this final line.

Also fixed.

Bradley M. Kuhn (2):
  Documentation: clarify and expand description of --signoff
  Documentation: stylistically normalize references to Signed-off-by:

Junio C Hamano (1):
  SubmittingPatches: clarify DCO is our --signoff rule

 Documentation/MyFirstContribution.txt |  2 +-
 Documentation/SubmittingPatches       | 35 +++++++++++++++------------
 Documentation/git-cherry-pick.txt     |  2 +-
 Documentation/git-commit.txt          | 15 +++++++-----
 Documentation/git-format-patch.txt    |  2 +-
 Documentation/git-rebase.txt          |  2 +-
 Documentation/git-revert.txt          |  2 +-
 Documentation/git-send-email.txt      |  4 +--
 Documentation/githooks.txt            |  2 +-
 Documentation/merge-options.txt       | 17 +++++++------
 builtin/am.c                          |  2 +-
 builtin/commit.c                      |  2 +-
 builtin/log.c                         |  2 +-
 builtin/merge.c                       |  2 +-
 builtin/pull.c                        |  2 +-
 builtin/revert.c                      |  2 +-
 16 files changed, 52 insertions(+), 43 deletions(-)

-- 
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter

