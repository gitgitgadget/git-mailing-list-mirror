Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77A1920281
	for <e@80x24.org>; Mon, 22 May 2017 11:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759113AbdEVLSb (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 07:18:31 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35640 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbdEVLS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 07:18:29 -0400
Received: by mail-oi0-f41.google.com with SMTP id l18so156684862oig.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 04:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GZ5nfVt5BL3cVk9OrNW+qZuTXQY4q0JtWm6UOvTSQTE=;
        b=IF8jA/KkjZt/Pzheh0cRrLurTdhZUtfqUZWSYhKC44k/F2fzydOGOqJlcGzGbr6kBu
         HZlCSGBDEgd8F+1FgFQN2lLkPcgfae0H7VVy8g0iqMRCXOulCd/n6OLkkl/jq0IZlAfD
         6PbXZEQZ9mCQEsDkmXPPSJH0OJES6PTvNe305MbrWoGOaaeOKCS6CFLeGvopOFQ8qqhi
         O1J2UUF26/wMl4TRWUZABVLKOsnawU50XjFvj6YD9mZlRFlGPFlP2G1PTlbD4sYTZTg9
         2DLGuJ/daVE+4UT4jm1W6i3lEkwBwOlRxy5z7NHxVlsOplr2+LqAGxOBfrWL6KtsvWbL
         Ehbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GZ5nfVt5BL3cVk9OrNW+qZuTXQY4q0JtWm6UOvTSQTE=;
        b=nwChnBbTh1xTME908CLvFHw21IDPRTirZNaZcTa6BFvgQSmoma/I5L7JtWkDSm5Rue
         gGuHFWoC0N5AwMAnepFtKIdF171PQF2fnMk1jTiKS5M6o8dlLREj1RwSvenU0Pa1xLg8
         0F91bH1r+KiLhan96uVRtnBUAnXDukhBfvsekOzkTCjqJnxrb63i6ZbicMae+1CT7YYE
         g4Ov0xw2gUgvwICereLQfTyL9JnQkhGlsQxoINGihsStcZXBmtoUiCFKqT3lYAkrY4AX
         MRD7HpMPLVrxSXt2YG1gqKKSV0ouJJcRPjduwTCEZBjCxBvCAPY7QsWnvgoC2WtSalqj
         XiDA==
X-Gm-Message-State: AODbwcBwsZpiCBwdsyb307zmNVGcprBepdKCrTZLtzARSc40W0vTGXHn
        uwWVTZC4GhHRm32a9RstP3LL2ADRVQ==
X-Received: by 10.157.17.143 with SMTP id v15mr11147368otf.140.1495451907666;
 Mon, 22 May 2017 04:18:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.17 with HTTP; Mon, 22 May 2017 04:17:57 -0700 (PDT)
In-Reply-To: <xmqqy3trstup.fsf@gitster.mtv.corp.google.com>
References: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
 <20170518014210.94189-1-manishearth@gmail.com> <xmqqy3trstup.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 May 2017 18:17:57 +0700
Message-ID: <CACsJy8CN0ZvWD6v2vkK3Lbt7xgrMwCjFKT6Nx7HtwZiEzmowpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] refs: Add for_each_worktree_ref for iterating over
 all worktree HEADs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     manishearth@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 20, 2017 at 5:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> By the way, doesn't nd/prune-in-worktree topic that has been cooking
> in 'pu' supersede this change?  It not just protects the commit at
> the tip of HEAD in each worktree, it also makes sure the ones in
> HEAD's reflog are not prematurely pruned.

You have probably noticed I have stayed silent for a long time (and
probably will continue). But yes nd/prune-in-worktree should fix this.
Unfortunately I will not be able to fix it up (I think Michael
responded on my last question about the proper way to fix
files_for_each_ref). So anyone feel free to pick that series up and
fix it (or drop it). For now, pretend that I'm kidnapped by aliens.
-- 
Duy
