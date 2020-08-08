Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C5CC433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D6020719
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="k9Vyf4kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgHHRoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHHRoF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 13:44:05 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE17C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 10:44:05 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596908643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=7QE1aVfwC6e5nmSCf+ombuuTXhJDqhz+x+op79jALSg=;
        b=k9Vyf4kU5+1UvACgZdIlH68ja60yebm02YySSyczht/6/6cdBNhk0n14iEaN4WRzpXh9OE
        q1INh4FiS/Hr85yc0ywA1VbebHzSoteP+m/sYngt5ILa1hulKjMJ0WbaLc+z+B8k21m4Ef
        yGcOxDRaDIgkbcrnxcHDJgEF78ThO5A=
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] apply: make i-t-a entries never match worktree
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     <phillip.wood@dunelm.org.uk>, <phillip.wood@dunelm.org.uk>,
        "Junio C Hamano" <gitster@pobox.com>
Date:   Sat, 08 Aug 2020 11:58:56 -0400
Message-Id: <C4RQMTXM9R7C.1WK5637SFISUU@ziyou.local>
In-Reply-To: <d81e79a9-7d7f-22a0-9d53-06fb92b0af48@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat Aug 8, 2020 at 11:48 AM EDT, Phillip Wood wrote:
> If I've understood correctly an i-t-a entry in the index combined with
> nothing in the worktree is a deletion and that is why we don't want
> --index to succeed when applying a creation patch? If so an expanded
> explanation in the commit message to this patch would help rather than
> just saying 'by definition'. I'm still a bit confused as we don't count
> it as a deletion when using --cached or applying to the worktree.

Nothing that complicated - --index requires that the index and worktree
be identical, and nothing that can possibly be in a worktree is
identical to an i-t-a entry.

> > --check goes through all the same code,
>
> The same code as --cached or --index? (I assume it's the former but
> wanted to be sure)

"--cached --check" goes through the same code paths as "--cached",
"--cached --index" goes through the same code paths as "--index",
"--check" goes through the same code paths as [no options]. The option
just makes it skip the part where it writes things out.
