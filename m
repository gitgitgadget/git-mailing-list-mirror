Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8790EC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF6E2075B
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="EoSkSMDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgH1VDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:03:07 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:50298 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgH1VDG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 17:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598648586; bh=hlF+bXdYNwyrMS2YMDeUl0ivChDCUPOzAJY4/7atgz4=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=EoSkSMDYa8GHyCIsOMlFAQ269C/mAwiK7ZqD6ZfurNqDFdzF8zM50SqrJQvB9LN3F
         gwom9+2TxJspwo0X0muXPbLM0K0yoT3bpFG1ZvYy7ICF6DtmEEa4GRvSr4r1/YwJOA
         woR8IS81+H7MbfUhhZ4AhkM3dttVra09NyYhe+j8=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Date:   Fri, 28 Aug 2020 17:01:46 -0400
Message-Id: <C58XLLAE3SMA.3T1C6DXZ4VSWA@homura>
In-Reply-To: <xmqqk0xio59r.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri Aug 28, 2020 at 5:00 PM EDT, Junio C Hamano wrote:
> "Drew DeVault" <sir@cmpwn.com> writes:
>
> > "You can give an empty answer if you are not responding to any message"
> > could confuse users, because they might think -v2 is a "response", or
> > maybe they've written the patch in response to a discussion on the
> > -users mailing list, or any other number of reasons.
>
> "Type the value you would have given to --in-reply-to command line
> option (if you forgot to use it), or leave this field empty"
> perhaps? Those who do not know should be able to learn what
> "--in-reply-to" is. A prompt help is not the place to do a
> documentation.

This would be better, yeah, but at that point it's pretty weird, like
why are we prompting for this CLI flag and not any others? The answer is
just for legacy reasons. There's no inherent justification for it.

> > I hate to be a nuisance over such a seemingly simple problem, but there
> > are a lot of new users who are struggling here and I care about their
> > struggle. What path should we take to fixing this issue for them?
>
> The ideal way would be to craft step (0) well enough so that new
> users trigger the To: prompt in the first place, which would
> automatically make the problem disappear ;-)

Do you mean teaching users how to use --to upfront? Honestly the prompt
seems totally fine to me, there's nothing wrong with a use-case which
calls for typing your To address into the prompt. Hell, often I'll use
it, or I'll use --annotate and write my To addresses in vim.
